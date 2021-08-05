-- CREATE USER 'shixin'@'%' IDENTIFIED BY 'shixin@12345678';

-- GRANT ALL ON *.* TO 'shixin'@'%';

create database `idigest` default character set utf8 collate utf8_general_ci;

use idigest;

-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 09, 2021 at 06:10 AM
-- Server version: 5.5.65-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `iDigest`
--

-- --------------------------------------------------------

--
-- Table structure for table `Attendance`
--

CREATE TABLE IF NOT EXISTS `Attendance` (
  `UserId` int(11) NOT NULL COMMENT 'leader user id',
  `StudyGroupId` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Users` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `AllUsers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `SubmitDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `BSF_DailyActiveUserView`
--
CREATE TABLE IF NOT EXISTS `BSF_DailyActiveUserView` (
`AccessDate` date
,`Count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `ChatMessage`
--

CREATE TABLE IF NOT EXISTS `ChatMessage` (
  `ChatMessageId` int(11) NOT NULL,
  `StudyGroupId` int(11) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL COMMENT 'NULL - anonymous user',
  `MessageContent` text COLLATE utf8mb4_unicode_ci,
  `Attachment` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Tags` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `MessageTime` int(11) NOT NULL DEFAULT '0',
  `MessageTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Class`
--

CREATE TABLE IF NOT EXISTS `Class` (
  `ClassId` int(11) NOT NULL,
  `ClassNameChs` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClassNameCht` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClassNameEng` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` int(11) DEFAULT '1' COMMENT '0-not published, 1-published',
  `ResourceId` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique folder name on server',
  `ClassType` int(11) DEFAULT '0' COMMENT '0 - free, 1 - paid, 2 - paid with free content',
  `ImageUrl` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'deprecated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DailyActiveUser`
--

CREATE TABLE IF NOT EXISTS `DailyActiveUser` (
  `AccessDate` date NOT NULL,
  `UserId` int(11) NOT NULL,
  `IP` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `DeviceId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PlatformOS` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Lang` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `BibleVersion` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `DailyActiveUserByOrganization`
--
CREATE TABLE IF NOT EXISTS `DailyActiveUserByOrganization` (
`AccessDate` date
,`UserId` int(11)
,`OrganizationId` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `DailyActiveUserView`
--
CREATE TABLE IF NOT EXISTS `DailyActiveUserView` (
`Date` date
,`Count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `Log`
--

CREATE TABLE IF NOT EXISTS `Log` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` int(11) DEFAULT '0',
  `statusCode` int(11) NOT NULL DEFAULT '0',
  `cost` int(11) NOT NULL,
  `ip` varchar(32) COLLATE utf8_bin NOT NULL,
  `path` tinytext COLLATE utf8_bin NOT NULL,
  `deviceId` varchar(64) COLLATE utf8_bin NOT NULL,
  `sessionId` varchar(64) COLLATE utf8_bin NOT NULL,
  `lang` varchar(8) COLLATE utf8_bin NOT NULL,
  `platformOS` varchar(8) COLLATE utf8_bin NOT NULL,
  `deviceYearClass` varchar(5) COLLATE utf8_bin NOT NULL,
  `version` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `bibleVersion` varchar(32) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Triggers `Log`
--
DELIMITER $$
CREATE TRIGGER `UpdateDailyActiveUser` AFTER INSERT ON `Log`
 FOR EACH ROW BEGIN

REPLACE INTO DailyActiveUser(AccessDate, UserId, IP, DeviceId, PlatformOS, Lang, Version, BibleVersion) values (new.date, new.userId, new.ip, new.deviceId, new.platformOS, new.lang, new.version, new.bibleVersion);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `MonthlyActiveUser`
--

CREATE TABLE IF NOT EXISTS `MonthlyActiveUser` (
  `Date` date NOT NULL,
  `Count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE IF NOT EXISTS `Organization` (
  `OrganizationId` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Notice` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `Phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StreetAddress` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StateProvince` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ZipCode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `OrganizationUser`
--

CREATE TABLE IF NOT EXISTS `OrganizationUser` (
  `OrganizationId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Role` int(11) NOT NULL DEFAULT '0' COMMENT '0 - member, 1 - admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `OrgCheckup`
--

CREATE TABLE IF NOT EXISTS `OrgCheckup` (
  `OrgCheckupId` int(11) NOT NULL,
  `OrganizationId` int(11) NOT NULL,
  `Subject` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `StartDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `OrgCheckupUser`
--

CREATE TABLE IF NOT EXISTS `OrgCheckupUser` (
  `OrgCheckupUserId` int(11) NOT NULL,
  `OrgCheckupId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Status` int(11) NOT NULL DEFAULT '0' COMMENT '''0'' - invited, ''1'' - accepted, ''2'' - rejected, ''3'' - completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Ownership`
--

CREATE TABLE IF NOT EXISTS `Ownership` (
  `OwnerUserId` int(11) NOT NULL,
  `OwnedClassId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StudyGroup`
--

CREATE TABLE IF NOT EXISTS `StudyGroup` (
  `StudyGroupId` int(11) NOT NULL,
  `StudyGroupName` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `GroupNotice` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `OrganizationId` int(11) NOT NULL DEFAULT '0' COMMENT 'DO NOT USE, feature not done yet! 0 - not org group',
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StudyGroupClass`
--

CREATE TABLE IF NOT EXISTS `StudyGroupClass` (
  `StudyGroupId` int(11) NOT NULL,
  `ClassId` int(11) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StudyGroupUser`
--

CREATE TABLE IF NOT EXISTS `StudyGroupUser` (
  `StudyGroupUserId` int(11) NOT NULL,
  `StudyGroupId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Leader` int(11) NOT NULL DEFAULT '1',
  `Status` int(11) NOT NULL DEFAULT '1',
  `LastReadTime` timestamp NULL DEFAULT NULL,
  `JoinedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SystemUser`
--

CREATE TABLE IF NOT EXISTS `SystemUser` (
  `UserId` int(11) NOT NULL,
  `CanViewActiveUser` int(11) DEFAULT '0',
  `CanManageOrganization` int(11) NOT NULL DEFAULT '0',
  `CanManageClass` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Tag`
--

CREATE TABLE IF NOT EXISTS `Tag` (
  `GroupId` int(11) NOT NULL,
  `Tag` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `TaggingUsageLast30Days`
--
CREATE TABLE IF NOT EXISTS `TaggingUsageLast30Days` (
`Count` bigint(21)
,`Tags` varchar(64)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `TrueLight_DailyActiveUserView`
--
CREATE TABLE IF NOT EXISTS `TrueLight_DailyActiveUserView` (
`AccessDate` date
,`Count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `UserId` int(11) NOT NULL,
  `Password` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DisplayName` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LoginId` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LoginIdType` int(11) DEFAULT NULL,
  `RegisterTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ResetToken` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ResetTokenTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `AccessToken` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cellphone` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserAnswer`
--

CREATE TABLE IF NOT EXISTS `UserAnswer` (
  `UserId` int(11) NOT NULL,
  `ClassId` int(11) NOT NULL,
  `Week` int(11) NOT NULL,
  `Answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Count` int(11) NOT NULL DEFAULT '0',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserChatMessageLastReadTime`
--

CREATE TABLE IF NOT EXISTS `UserChatMessageLastReadTime` (
  `UserId` int(11) NOT NULL,
  `StudyGroupId` int(11) NOT NULL,
  `LastReadTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserData`
--

CREATE TABLE IF NOT EXISTS `UserData` (
  `UserDataId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserDevice`
--

CREATE TABLE IF NOT EXISTS `UserDevice` (
  `UserId` int(11) NOT NULL,
  `Token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `RegisteredTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserMessage`
--

CREATE TABLE IF NOT EXISTS `UserMessage` (
  `UserMessageId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UserId` int(11) NOT NULL,
  `Category` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserNote`
--

CREATE TABLE IF NOT EXISTS `UserNote` (
  `UserId` int(11) NOT NULL,
  `ClassId` int(11) NOT NULL,
  `Note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure for view `BSF_DailyActiveUserView`
--
DROP TABLE IF EXISTS `BSF_DailyActiveUserView`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `BSF_DailyActiveUserView` AS select `DailyActiveUserByOrganization`.`AccessDate` AS `AccessDate`,count(0) AS `Count` from `DailyActiveUserByOrganization` where (`DailyActiveUserByOrganization`.`OrganizationId` = 6) group by `DailyActiveUserByOrganization`.`AccessDate` order by `DailyActiveUserByOrganization`.`AccessDate` desc;

-- --------------------------------------------------------

--
-- Structure for view `DailyActiveUserByOrganization`
--
DROP TABLE IF EXISTS `DailyActiveUserByOrganization`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `DailyActiveUserByOrganization` AS select distinct `DailyActiveUser`.`AccessDate` AS `AccessDate`,`DailyActiveUser`.`UserId` AS `UserId`,`StudyGroup`.`OrganizationId` AS `OrganizationId` from ((`DailyActiveUser` join `StudyGroupUser` on((`StudyGroupUser`.`UserId` = `DailyActiveUser`.`UserId`))) join `StudyGroup` on((`StudyGroup`.`StudyGroupId` = `StudyGroupUser`.`StudyGroupId`))) where (`StudyGroup`.`OrganizationId` <> 0);

-- --------------------------------------------------------

--
-- Structure for view `DailyActiveUserView`
--
DROP TABLE IF EXISTS `DailyActiveUserView`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `DailyActiveUserView` AS select `DailyActiveUser`.`AccessDate` AS `Date`,count(0) AS `Count` from `DailyActiveUser` where (`DailyActiveUser`.`UserId` <> 0) group by `DailyActiveUser`.`AccessDate` order by `DailyActiveUser`.`AccessDate` desc;

-- --------------------------------------------------------

--
-- Structure for view `TaggingUsageLast30Days`
--
DROP TABLE IF EXISTS `TaggingUsageLast30Days`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TaggingUsageLast30Days` AS select count(0) AS `Count`,`ChatMessage`.`Tags` AS `Tags` from `ChatMessage` where (`ChatMessage`.`MessageTimestamp` between (curdate() - interval 30 day) and curdate()) group by `ChatMessage`.`Tags` order by count(0) desc;

-- --------------------------------------------------------

--
-- Structure for view `TrueLight_DailyActiveUserView`
--
DROP TABLE IF EXISTS `TrueLight_DailyActiveUserView`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TrueLight_DailyActiveUserView` AS select `DailyActiveUserByOrganization`.`AccessDate` AS `AccessDate`,count(0) AS `Count` from `DailyActiveUserByOrganization` where (`DailyActiveUserByOrganization`.`OrganizationId` = 3) group by `DailyActiveUserByOrganization`.`AccessDate` order by `DailyActiveUserByOrganization`.`AccessDate` desc;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Attendance`
--
ALTER TABLE `Attendance`
  ADD UNIQUE KEY `StudyGroupIdDate` (`StudyGroupId`,`Date`) USING BTREE,
  ADD KEY `Date` (`Date`);

--
-- Indexes for table `ChatMessage`
--
ALTER TABLE `ChatMessage`
  ADD PRIMARY KEY (`ChatMessageId`),
  ADD KEY `MessageTime` (`MessageTime`),
  ADD KEY `GroupId` (`StudyGroupId`) USING BTREE,
  ADD KEY `UserId` (`UserId`),
  ADD KEY `Tags` (`Tags`);

--
-- Indexes for table `Class`
--
ALTER TABLE `Class`
  ADD PRIMARY KEY (`ClassId`),
  ADD UNIQUE KEY `ResourceId` (`ResourceId`) USING BTREE,
  ADD KEY `Status` (`Status`);

--
-- Indexes for table `DailyActiveUser`
--
ALTER TABLE `DailyActiveUser`
  ADD UNIQUE KEY `AccessDate_UserId` (`AccessDate`,`UserId`) USING BTREE,
  ADD KEY `AccessDate` (`AccessDate`) USING BTREE;

--
-- Indexes for table `Log`
--
ALTER TABLE `Log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `MonthlyActiveUser`
--
ALTER TABLE `MonthlyActiveUser`
  ADD KEY `Date` (`Date`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`OrganizationId`),
  ADD KEY `Status` (`Status`);

--
-- Indexes for table `OrganizationUser`
--
ALTER TABLE `OrganizationUser`
  ADD PRIMARY KEY (`OrganizationId`,`UserId`),
  ADD KEY `UserId` (`UserId`),
  ADD KEY `OrganizationId` (`OrganizationId`) USING BTREE;

--
-- Indexes for table `Ownership`
--
ALTER TABLE `Ownership`
  ADD PRIMARY KEY (`OwnerUserId`,`OwnedClassId`) USING BTREE;

--
-- Indexes for table `StudyGroup`
--
ALTER TABLE `StudyGroup`
  ADD PRIMARY KEY (`StudyGroupId`);

--
-- Indexes for table `StudyGroupClass`
--
ALTER TABLE `StudyGroupClass`
  ADD PRIMARY KEY (`StudyGroupId`,`ClassId`),
  ADD KEY `StudyGroupId` (`StudyGroupId`),
  ADD KEY `ClassId` (`ClassId`);

--
-- Indexes for table `StudyGroupUser`
--
ALTER TABLE `StudyGroupUser`
  ADD PRIMARY KEY (`StudyGroupUserId`),
  ADD UNIQUE KEY `StudyGroupId_2` (`StudyGroupId`,`UserId`),
  ADD KEY `StudyGroupId` (`StudyGroupId`),
  ADD KEY `UserId` (`UserId`),
  ADD KEY `Leader` (`Leader`),
  ADD KEY `Status` (`Status`);

--
-- Indexes for table `Tag`
--
ALTER TABLE `Tag`
  ADD PRIMARY KEY (`GroupId`,`Tag`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserId`),
  ADD UNIQUE KEY `LoginId` (`LoginId`),
  ADD KEY `ResetToken` (`ResetToken`);

--
-- Indexes for table `UserAnswer`
--
ALTER TABLE `UserAnswer`
  ADD PRIMARY KEY (`UserId`,`ClassId`,`Week`),
  ADD UNIQUE KEY `UserId` (`UserId`,`ClassId`,`Week`);

--
-- Indexes for table `UserChatMessageLastReadTime`
--
ALTER TABLE `UserChatMessageLastReadTime`
  ADD UNIQUE KEY `UserId` (`UserId`,`StudyGroupId`);

--
-- Indexes for table `UserData`
--
ALTER TABLE `UserData`
  ADD PRIMARY KEY (`UserDataId`),
  ADD UNIQUE KEY `UserIdName` (`UserId`,`Name`) USING BTREE;

--
-- Indexes for table `UserDevice`
--
ALTER TABLE `UserDevice`
  ADD UNIQUE KEY `UserIdToken` (`UserId`,`Token`) USING BTREE,
  ADD KEY `User` (`UserId`);

--
-- Indexes for table `UserMessage`
--
ALTER TABLE `UserMessage`
  ADD PRIMARY KEY (`UserMessageId`),
  ADD KEY `Date` (`Date`,`UserId`);

--
-- Indexes for table `UserNote`
--
ALTER TABLE `UserNote`
  ADD PRIMARY KEY (`UserId`,`ClassId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ChatMessage`
--
ALTER TABLE `ChatMessage`
  MODIFY `ChatMessageId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Class`
--
ALTER TABLE `Class`
  MODIFY `ClassId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Log`
--
ALTER TABLE `Log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `OrganizationId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `StudyGroup`
--
ALTER TABLE `StudyGroup`
  MODIFY `StudyGroupId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `StudyGroupUser`
--
ALTER TABLE `StudyGroupUser`
  MODIFY `StudyGroupUserId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserData`
--
ALTER TABLE `UserData`
  MODIFY `UserDataId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserMessage`
--
ALTER TABLE `UserMessage`
  MODIFY `UserMessageId` int(11) NOT NULL AUTO_INCREMENT;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `RemoveMoreThan7DaysOldUserMessages` ON SCHEDULE EVERY 1 DAY STARTS '2020-10-18 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM UserMessage WHERE Date < NOW() - INTERVAL 7 DAY$$

CREATE DEFINER=`root`@`localhost` EVENT `CalculateMonthlyActiveUser` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-06 23:59:59' ON COMPLETION NOT PRESERVE ENABLE DO INSERT MonthlyActiveUser (SELECT CURDATE() AS Date, COUNT(DISTINCT UserId) As Count FROM `DailyActiveUser` WHERE AccessDate BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE())$$

DELIMITER ;
