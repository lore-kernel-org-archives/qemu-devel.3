Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463CEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYz6-00025B-Lu; Tue, 30 Jun 2026 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyq-00023J-55; Tue, 30 Jun 2026 09:58:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyo-0003om-3R; Tue, 30 Jun 2026 09:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcipN/9xtKNariXQMn6PXO/RsFBwJbmkWA0EylTbqPpLayZ4JDe9yp2s30ZrS5DaEEN5QK4amZeq3cfDVaMIk6YGZ3L3rUsws3Tjv5kUUZe+J+FAVz112idtG5FaHIs19SvOfK2bPZV9Ea1O6aWEnHrRnFRtcRFfjf9F8vWQfoNDUW7If8A+iGcgX7Hy7/SEJzztvDYqLl5pvPryrE7VaZJTS59afMF3+ALy2Ejx09rjvexENV1W76ps0OpTP01ml9sbiBFeQTCBVrUqzqpIfhPmaPzrEwiM3C7sAYnKxgXCneyqDrm3lhgmDS4Skv0wH/phgaeoqS2HdluR1eJlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1sjayF5ObqNguGjmSLOK+Ap0DWobwdKEGhwAIhaR6w=;
 b=NVqiBc1ZYvaKl0s3+xJ9BpX99Uu6wPIOje5M2JBhw9mIW8mkDBsE/7M1bsEJVq83tDhx+tkI7qt6TUhVX8Ju/LJBG6d7xLs6KFJGRWTcC84tHdUNc9cep79sYs6EPq90wVG7Fe0xyek9NZwcZXVEJ0Ai48yc/YXa3tRFeHBLD44Ov9RqFYjtr/QYTrbdbShHFfh87HJqQWwjVGs2NjvCovubLYordcR5hDv1psGExVpzROKLsEDJpPSGacrZqSCzS55AMlwZ7rIA6QYONHFpqIrYYuOy9uO4mcubPyPEhWJnhnSpO6RH0ZvVeh2I/VycPmiek7A5ghyOodzPUdRL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1sjayF5ObqNguGjmSLOK+Ap0DWobwdKEGhwAIhaR6w=;
 b=bw9KggLoVcZOKM0GJkVQeoqmHPXFNq2PZItvjm6IHDQLZtJxizgVivoI+WITZ2tVXeR2B1xutQL1kQgGsQjy4aF1i+QS6y0w4lNWOItXMVfIfzaSDpdZouG4d/5fEtmX8l55MAreDLeNrEo5QaqHm8RtOusj0ULBF2cxJglvfoMGk4zK5munYqpSxEOqht9UhrGWL2tg5+lcoJXEpmUUUUcE+bwtu76XQD0Vpwq4EP63qbYwI+jovBv9CDk4Qj+4mUKoJ60lKNLzhWQVnd4wMEqLDcgNtVPujYgtttOZp/rUiuhmNBFt31OrT/IJ5NO9egv+ItrasIIv0OfpuhDISg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:14 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 08/10] Revert "aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command"
Date: Tue, 30 Jun 2026 21:57:27 +0800
Message-Id: <20260630135729.466264-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 99aa5c7e-2028-4203-e093-08ded6afa0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|7416014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: XZrAF0ktr5RB9PHUyAxV+md3IQZqaQ7/joqH9MYxPSQoZBqjOTkYaFRr0JaOzXbN4UUSro2h22BeYEqXqvTRYOKFAtnSrYYNCtbv+OSUC5VjP0TuioG0kdIfWgCn2ZJTsfgo9FCInt4Nxy+CxjTbjVXr3CVoOscSF2fNybfXc2wqTE9XtAWBkr65jLUKlubQ43BENEywquM3rlsm43d/N2G5b9qAMBgUKZqffZLezD8xgywG68cKBPYnYIf2TSKPIyRsF7wDn+nMnDt+l79bK7HYkhce+YuhwoyIHMkxuJ7mUdBd7colq2VDZWQ1ydrEJ5y6Kpn+y3qiYwxNvOnkVSuLB/nSc5xyL/kTjXs6V+LtvwHmSuJI306+DiovQv2GPG2I408rlNJ3rL9rPfvggtRJLa0UCQ+5dUZvDEsDY0venMD3uwdPQ0K8iqmqbtlf/lDrAMY8MvaMdG2U6NOyqMIW9y7qT+HN+fBzwQ0h0C9aP2N80EBDHPrrxRyKuUBbXHfCLmQx/UWGb5gIRiMHgYFYDuo435i2/peofZ3lmn9HXVSLl5aiG7AMQcrpgTg7Um8JnyG4pVpLQBJoUrYMB0BgZ/fW+Mc8U82u2uoxeT4lJ/gO0SBS9OkaTPsQJmgNcAmA1C+gMDrplp2VYHBqwQS4xemVRUKdHx+zNer60j0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(7416014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4Eclop7N7Ldj62+fFnnfOBsxifv5HN9z1vSexnjyQ4++O/Ch2Fyxa906b9s?=
 =?us-ascii?Q?CgAwUd5/NkVCiSa/bsmBniOCz4FkolLyuhLBJesWctqo3TrgoxFNe1jtchvq?=
 =?us-ascii?Q?A1SUnWkIkrlC0HvBvFD6mSfWav7U566mExpGGEkyajV3yqoYMc/NUSgIXxdm?=
 =?us-ascii?Q?oSYYi/6kJjnS7hIwfVmSuMsBwoDs8H/10v+rt2QHrBQFjwDOV+sbzrsfSh5m?=
 =?us-ascii?Q?C76nmaGhmNWPnsxcuxtC5gnSTKo1ee/RBZFuda8JxK86ILmS4qfy+DM+97+T?=
 =?us-ascii?Q?eYIHA9KKMcbJ4yOHWzIoljThdKigrijo1w/3Lwqta4sBVT/AkBfXj3u8Dx0w?=
 =?us-ascii?Q?9tp/wIM2JjewfY68sIXqqJZ+GT6YDraSl7JSVEUeLPhJvYY708dC+xm8H9mw?=
 =?us-ascii?Q?joOrQ4uox4Nz8rd+g54944eorbVy589z79YuJqQRoNv6ymXXvnZ93ji7o46b?=
 =?us-ascii?Q?j03xDmmCSaHzgx3qkwAP8pejD3yv5VFqiBK26BTRpvDk4BOU0BFqo3FB7fnz?=
 =?us-ascii?Q?9KQWtf4rv81JP3ce+hPwkF5PCmg9126vNUE6LSjIQtN8o7DQm8U34qArG7U5?=
 =?us-ascii?Q?krxEuC2nLqxF+KHOhTyFN1S7v5rmDAoimGglbyDKT0tz1YXftIdPBQf2hXMG?=
 =?us-ascii?Q?gPKsgh4/YGtWqPtceX9oStu1tT4crHJIhpubPNRlKSR8YOl/dtr3sBG7Jgwd?=
 =?us-ascii?Q?MKBQoDDJTD3mtwfcZnznTRC1f/roChzrZe7Rj41agUwSl7swio8jHfsvt16M?=
 =?us-ascii?Q?Sfk+67dvgJ2LGlTjxN2zC3y4muAYca9+Q3kAzAWsyUPKRYGdTTySSe2/4S+h?=
 =?us-ascii?Q?jPH4mDLHqnZFtRdlS0qwg/jKCPSSf3hvBm2UnGJajvWyl12jtosb6SaavBvy?=
 =?us-ascii?Q?hdV4dn72f5Nj5aFXHS01mg3MgU7FMNV0O+swKzPc2Ohf3r6iD1Bp5EQrJ4cH?=
 =?us-ascii?Q?ScaT6YfIAVWVMWNQ68udIWM/Tv6kzg5mDI8XxddS18eIS+8yitpfewxHpAeX?=
 =?us-ascii?Q?AUcZrRNhDSUzFJvUNpU9GthB5MxUk6MIlmmMhItTgpQbDGAd6oWo26f7WJyV?=
 =?us-ascii?Q?YL9iJGSPuUbaJlkeAwkpHKDlR01oVqdu11QoBXWAmlCeMXNy4mYMievKM7Fj?=
 =?us-ascii?Q?0lL6azvCBvHA3QF0nhpHCtEvMl7N40hDgo4tdyqQo28XHvE/4KLUm16hdD4D?=
 =?us-ascii?Q?MUTPxoaPfwXDzlfJ5jwo1dBi0leVHkjQpyE9DaiRi6TqVRfewepBVVrDf1ex?=
 =?us-ascii?Q?Zj7YIjRCuWF0Rk2XCo0CIBeNm2my9eB+PPj/GsWVl/tNMOwNXX7dnvuF2ymP?=
 =?us-ascii?Q?00ErnbFpv91wTKP8aEp/QoKLi3rT7kBI8O4C2WqN/vWhHZaortCqAh3aRTCy?=
 =?us-ascii?Q?9cRrOCTSpNKvy020KZkkk7lLo35J4WEkJQMRiAijm+fQVhw93Td7KTkz8Afj?=
 =?us-ascii?Q?DsunBud3qVeIfRk6AmvMK3oCcCoNV9Djm9d1LppSJVrnAzYRvT8uPXS+/Dbr?=
 =?us-ascii?Q?CdJB6tWpBn/OGsv77N6IWtQWTNZyXCM1iLIT3cUhfw3rwWfUYhn0zu9N2c6n?=
 =?us-ascii?Q?VflH4jOwfYBhY5Pry8wYRQuvDmI5GFwwrLhbeI5soTswrTXuVWBV8Bb77AMB?=
 =?us-ascii?Q?DxUBzIuTMMd3qmVm+EjGaT9VinDDWwk1B8hZabVKruFTuuPdAneOfbYfofUn?=
 =?us-ascii?Q?0nCzLEx+b4OyO6u7z2lIbWLcrYGxeS8j86UeRbtvRtd3UT6SbD2yYRTu87wI?=
 =?us-ascii?Q?IBpvXPdD9CL/+lESEDcHzZzQKFR5KlY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aa5c7e-2028-4203-e093-08ded6afa0ea
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:14.2431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEy7hlT5phWgejCFbQcv0BE5sHQByN73pNY4/Ygl42NPzc/Ud9ZMlmbf732YkJkeEvPnzszLEdSF8QAAD6dwyaU8AxW2JkNqypGxoGg+mIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 7faf6f1790dddf9f3acf6ddd95f7bbc1b4a755d0.

The incorrect implementation of dummy cycles in m25p80 model is now
corrected. Revert this commit.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f5abc9fcc9..c2a732664b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -568,11 +568,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
-    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
+    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.34.1


