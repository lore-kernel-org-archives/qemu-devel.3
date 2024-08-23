Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C876C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shS5c-00020Q-US; Fri, 23 Aug 2024 07:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shS5Y-0001rH-Qw; Fri, 23 Aug 2024 07:04:16 -0400
Received: from mail-sh0chn02on20726.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::726]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shS5X-0003L3-1A; Fri, 23 Aug 2024 07:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei1bBUEDnQfFwBxnq+cLsTzyNvhjCHP6A6Ls+SsSezkWhaxIUgSUCJGd3g+dAIp0Fr96vsuwIDqiXDdSD7VpgJn7Rvn0zoHMeY3Y9Ac0v/ETRKxsCXjKAZocz2Lm60ImrXan2mBB9217LWKr9FmvmHZfWeYBGj3Qqz1HHc8R4F61wqy1l9NVMd7tMbV6tCkuoIwFixdaKTAIXVLlPivo4zdSdxSVbzKJr2jpS+hTRCG02qgdHpXBbDsPNmA5SvLO/F64NSR0L/znnnMrH4K2O4HT+v+Uy+KisNgnuIZJLUhfTpd7HrmLwcF8Pzx7Y9aMEIXtLZbBUmuQrsLLkvkGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmGMyq1MZKLP2C4HOPw7aPDX7g8TOYFd6Ri1Rt9aew4=;
 b=EZvC8aHf2QoBHCNIgvEL53pnKy+qGJQPF2Qq1BC/Bu9nfchGnWqrfAW5vpYMv/4tKL6WvM8rl3O6B5XRLIrglCB9Mg2eANcPUXkN8K+KYpsQqCFk5BLzwrDmjXV0u6aF092hTFq2/L53EGM2aZvpH8YLyfHlniFQKBMKOlXplGGyT+3QpO69+RBZXAdn5WdSMltimBTSTf8sSGGP5c94xJ8f/JKOGpBnQY4V0VFGb89p+Qc236NRfbLCJKXWBNYXHCq72xKS11vmj2pcJMyu45Pr6vdxNzL4y/lyiQSIIalrMTmuSP76g48owxiuCidDtwQKUOvozTGMeHCyLMQEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1327.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 11:03:36 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:03:36 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v4 3/3] tests/qtest/bios-tables-test: Update virt SPCR golden
 reference for RISC-V
Date: Fri, 23 Aug 2024 04:03:01 -0700
Message-Id: <20240823110301.161588-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823110301.161588-1-jeeheng.sia@starfivetech.com>
References: <20240823110301.161588-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::33) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1327:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d93843-dead-43cc-d401-08dcc3633c76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: M9Gj5r9pHGjlljW2D4Hv52nPnGx9/qA0hGKIo1rTk7sIC4r257A5CUFFYHnL4XcLyvd7vB+Dl0ANBNdX3x+5x8V30YpAcppdevfoaV6Wexw/JiWjtAl8hBhXL4rGSp41Bm+No3Rh8t5xhqcg9LFQ0fGJZkDLzqW/+h7oveFE7h+yLT1IN6cdHz1q3UyWyLei0CJMDfUE487rNm5AHZIVqx2l5VtALouPgYISZk+Z/rRuq9XfVl8AeiLujNeNQnnXY4AQpvPlPa/2FStklaKeyIfp569tkJywGMtPjIsvZe2wFozAt6Hy39qmN0LhiaM5b4XUsN5yovq1xHzCTq1Jc6SHrcCEac+USxNpYbJJF8kw0NN/Ut08odGOHASlrjp5IEqPJiAN5OvntccbCCE0+X0fGxHJFRjy4dvp+7EtVyEVUEjPHPYQ8TVQzNew/SDKFMlyklWif/VzoE+U/otb22HPScxELfzH3JmCP5cXA3OQsrO2Uc1qch7YM62AxZ2acnG/dEA/yduqgFK07Upv2pR+JNRZ25Gvx9bfMEHMhw7fhG75BpsJjZ0NpiXwUlEbPoH7B2XxRNSS11I+oqTGIg72e5FyBAMGRI91oluIFVMJV5QkD0Lzdt3g/3HecDEy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vk9slB1n0OQ0+aNwzFBPQmo8keC6v22w5WeESBuQT6k8FCAn49VlwSVFhuU?=
 =?us-ascii?Q?Qb3UMA72sqXwgkUZtOQpYldWHgJQimCjEqHJPSBV3Gcnu4crhTeXfVC88E7s?=
 =?us-ascii?Q?zeTcm9VnGGmTuzsRC5GZsZ1/IQBOqQA7EI1vB/6pG3Jwqd4D3gqPAphUKPKL?=
 =?us-ascii?Q?Igfw7SUO4IDF+Bd4FIFx/wzOk0rSA1Tgt4MnN6py1XmpsIHuhbfIby/8jsic?=
 =?us-ascii?Q?xUGcn3S0RjUPe5YQSfLBFexbXYAuwbB0dN4jY0r2/G2pjlOzHFCz0LILgeK3?=
 =?us-ascii?Q?YomeC2cnzbrcpurOP5+MCSFh8hy5WYfxNY1wsPpgNGA9Vf2SugeeYCsStZ+h?=
 =?us-ascii?Q?WiAT1nKwt4lmoG98c4u7pjKvMZs3Beb73OdWrsgz/PxCG1MPRp6HHDPqV+ZD?=
 =?us-ascii?Q?mKyQhrb/DSz8OBYIVrohcV4G6FfSJrDQpGucEU73Jb3MQi1PiBYnRuyifflV?=
 =?us-ascii?Q?rtH0IMv0x8hvkDuFJ9EIQIbD+DpC8jXd55YVVsqUAluPbazBd2GlGE3/6UzF?=
 =?us-ascii?Q?bqpa165DF5T7UfXKdKrri+E0WyXOCQtDqxXy3Sm6nc4ZLUpklhwItZmxf3MZ?=
 =?us-ascii?Q?DxV14K+mUskUdf3bXigUdM11tzsd3P7ik9PajmQbSv+u0A4MPl5aRY9DfMyL?=
 =?us-ascii?Q?veWCb2jnHOvZkkdm79xR+c6wueqf7XBQnepusgttgL7/on0Sq/V/W/tX142C?=
 =?us-ascii?Q?FMUNoVfK6IlDqq8BQjewQq8fBrJIlO7OppEHC/ZMs+X8Hdya7YdWw2tkhh6G?=
 =?us-ascii?Q?/GgsE0znMWwcz018lNQgj5Nqz5rNE1cB3UGg4c+94Vw1AOG0DRt7+e7h86Ru?=
 =?us-ascii?Q?O40Qe2R8CM9b7lAEh0ReNPhNUGQW6D4bUoAHPiojYu9knl8D4dKr7nh0d395?=
 =?us-ascii?Q?TXR5JLLd1SRYLCv3l/MPFUeY7Qio9/ta2bQzn8rtaKpK2PtLhBDZzHn93tk4?=
 =?us-ascii?Q?90eJYdAqLPugIkpp6yyeDCIPO+B9obdTgEJ759n5wKUlVChmirQAR84lG3EL?=
 =?us-ascii?Q?rpo+iyefk/rhIlC3o8R0l4Vg+ReGZt9LGBlKx1jxKcVi+ojYZvJxmVAqF36I?=
 =?us-ascii?Q?BXBhH6TVdA2kso8u92M7KiSUJf0Rlc5t76DsYOfgtaj5Ok52DG1HMfJ0X2aY?=
 =?us-ascii?Q?JpKFNxeCeiB+aDJaQmJJ//jMskkYMrNCfZMETm1tKT0FyJtk+zp81j2JXxvL?=
 =?us-ascii?Q?Ajp4dsmeV6ZO3gWZCaV4XsKD/9xlSm8F+YwXXeBIJIKLNaUV/BwwD/Fu1mn1?=
 =?us-ascii?Q?RiYudZdsz9+DyTOMCyvE07UmNxDZ4i7Q6zCZplGTilzA/hLqJdn2jVnaVfaG?=
 =?us-ascii?Q?nx0WDS0UT2aoYNPVkp2xgFi5U27KNmvtiNdWaFQPEHLmlbo4o03lOK/1DxZb?=
 =?us-ascii?Q?Iup/x/Ar+iBqAHW/K8PH7KBZ7kbR97iXnRNZqBwNC9uj0+o7vHJbreTQ2ZOd?=
 =?us-ascii?Q?+3y6D4yvatNzlTHTDSBsvdkjl1fFsFkbrnHFag9aqHpkkS62UJcXSpTX8Sjl?=
 =?us-ascii?Q?FD+tMvfsM7A7s/6zv9i0JbuWe08Vdm4zF0OF/9IKM9C6nRg0xGLBZeiTnOgB?=
 =?us-ascii?Q?evFVbg1GvUY3RFERVrldaS2mtdJz0xtjYOM2SOZ7ukaZxYisM2PlNlVoqAXD?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d93843-dead-43cc-d401-08dcc3633c76
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:03:36.4921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFufVqqlvj8TwBwH0dO/YoC+mt4bUt7BxUNJYV2snkIw9qG2gHsRqyGylfSIVWHIHAH71aUeeZQU/DmClntz16KHPzbRUMLTmxDbX58npGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1327
Received-SPF: pass client-ip=2406:e500:4420:2::726;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the virt SPCR golden reference file for RISC-V to accommodate the
SPCR Table revision 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository. The SPCR table has been modified to
adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:
/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Fri Aug 23 02:07:47 2024
+ * Disassembly of /tmp/aml-Y8JPS2, Fri Aug 23 02:07:47 2024
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
-[004h 0004   4]                 Table Length : 00000050
-[008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : B9
+[004h 0004   4]                 Table Length : 0000005A
+[008h 0008   1]                     Revision : 04
+[009h 0009   1]                     Checksum : 13
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   1]               Interface Type : 00
+[024h 0036   1]               Interface Type : 12
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
 [029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
 [02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044   8]                      Address : 0000000010000000

 [034h 0052   1]               Interrupt Type : 10
 [035h 0053   1]          PCAT-compatible IRQ : 00
 [036h 0054   4]                    Interrupt : 0000000A
 [03Ah 0058   1]                    Baud Rate : 07
 [03Bh 0059   1]                       Parity : 00
 [03Ch 0060   1]                    Stop Bits : 01
 [03Dh 0061   1]                 Flow Control : 00
 [03Eh 0062   1]                Terminal Type : 00
 [04Ch 0076   1]                     Reserved : 00
 [040h 0064   2]                PCI Device ID : FFFF
 [042h 0066   2]                PCI Vendor ID : FFFF
 [044h 0068   1]                      PCI Bus : 00
 [045h 0069   1]                   PCI Device : 00
 [046h 0070   1]                 PCI Function : 00
 [047h 0071   4]                    PCI Flags : 00000000
 [04Bh 0075   1]                  PCI Segment : 00
 [04Ch 0076   4]                     Reserved : 00000000

-Raw Table Data: Length 80 (0x50)
+Raw Table Data: Length 90 (0x5A)

-    0000: 53 50 43 52 50 00 00 00 02 B9 42 4F 43 48 53 20  // SPCRP.....BOCHS
+    0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
+    0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/data/acpi/riscv64/virt/SPCR           | Bin 80 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 4da9daf65f71a13ac2b488d4e9728f194b569a43..09617f8793a6f7b1f08172f735b58aa748671540 100644
GIT binary patch
delta 32
mcmWHD;tCFM4vJ!6U|<oR$R))nG*MNX3&>+&Vu)bSV*mhNumqU^

delta 21
ccmazF;0g|K4hmpkU|`xgkxPn^VWO%w05v59j{pDw

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.34.1


