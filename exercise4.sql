-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise4` ;
USE `exercise4` ;

-- -----------------------------------------------------
-- Table `exercise4`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Specialist` (
  `Specialistid` INT NOT NULL,
  `Field_area` ENUM('A', 'B', 'C') NOT NULL,
  PRIMARY KEY (`Specialistid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Medical` (
  `Medicalid` INT NOT NULL,
  `Overtime_rate` INT NOT NULL,
  PRIMARY KEY (`Medicalid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor` (
  `doctorid` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `Specialist_Specialistid` INT NOT NULL,
  `Medical_Medicalid` INT NOT NULL,
  PRIMARY KEY (`doctorid`, `Specialist_Specialistid`, `Medical_Medicalid`),
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_Specialistid` ASC) VISIBLE,
  INDEX `fk_Doctor_Medical1_idx` (`Medical_Medicalid` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_Specialistid`)
    REFERENCES `exercise4`.`Specialist` (`Specialistid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Medical1`
    FOREIGN KEY (`Medical_Medicalid`)
    REFERENCES `exercise4`.`Medical` (`Medicalid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Patient` (
  `patientid` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`patientid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Appointment` (
  `Appointmentid` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  `Patient_patientid` INT NOT NULL,
  `Doctor_doctorid` INT NOT NULL,
  `Doctor_Specialist_Specialistid` INT NOT NULL,
  `Doctor_Medical_Medicalid` INT NOT NULL,
  PRIMARY KEY (`Appointmentid`, `Patient_patientid`, `Doctor_doctorid`, `Doctor_Specialist_Specialistid`, `Doctor_Medical_Medicalid`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_patientid` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_doctorid` ASC, `Doctor_Specialist_Specialistid` ASC, `Doctor_Medical_Medicalid` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_patientid`)
    REFERENCES `exercise4`.`Patient` (`patientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_doctorid` , `Doctor_Specialist_Specialistid` , `Doctor_Medical_Medicalid`)
    REFERENCES `exercise4`.`Doctor` (`doctorid` , `Specialist_Specialistid` , `Medical_Medicalid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Payment` (
  `details` VARCHAR(45) NOT NULL,
  `method` ENUM('card', 'visa') NOT NULL,
  `Patient_patientid` INT NOT NULL,
  UNIQUE INDEX `details_UNIQUE` (`details` ASC) VISIBLE,
  PRIMARY KEY (`details`, `Patient_patientid`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_patientid` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_patientid`)
    REFERENCES `exercise4`.`Patient` (`patientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Bill` (
  `total` INT NOT NULL,
  PRIMARY KEY (`total`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Bill_has_Payment` (
  `Bill_total` INT NOT NULL,
  `Payment_details` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Bill_total`, `Payment_details`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_details` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_total` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_total`)
    REFERENCES `exercise4`.`Bill` (`total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_details`)
    REFERENCES `exercise4`.`Payment` (`details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
