Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66052D13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 01:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5F1U-0002nR-NH; Sun, 27 Oct 2024 21:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1S-0002mZ-Oc; Sun, 27 Oct 2024 21:58:22 -0400
Received: from mail-bjschn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::701]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1R-0007Ma-0A; Sun, 27 Oct 2024 21:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSIQZrCcLNBZ189V5diMRrMYFJA9qQH54yiI8KZpEWxfTcsjMqrTnM89A4lOGqHrE1pD6nUDfPEukx9Xlg7p/pYAAP7/xFRFVeEg+8mEjvGCaJuQDPsfIcrwIgzS/RAm5BtRBdiNXhsslmx3D5g4nf5xSYDaDTkbh2bbb9vtAavVkGCr4pFNXtHWNYICy9PB7puNVAY7wy8sZsqEu4i5Dg4nDGyzMeKJVDep17wefWfHzmq1Guy64ZXL5vCdUKuqXXEBG6l4fz2dnHjB3j6fatCx2Mm+yvWPwyRitPBFFW41EyCnCzTWeIF3BuXvShnwtM9owc8hHMa/81gCGHp/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8roQIsT2ul1mR3LqGWmi0gRgf9/8WBWf4vqVV0E7TtQ=;
 b=JhrD5RjVu6w9Rnlf6xIfp5Z618wpX4wcQbbbIfmg0Qeg2/LsY/apCcIJ40Z/QV+AWRK29mBMvBc3okMusgAif+FuWUwRbZ597/FW1G4rQzCcVIbAa+q6jL+0q7xqsu/SYCyYW3xcK/CJIYEKlqBpSAQaEvjTW62Oz4UyCG/vkY6jTrMUiIxdNlEieyO6Z3L1dndSLOcnnxurNQwYsJLrAHO7wv4Q8zEmfkqEo9q2upo/bDwnklmzY3roTVktmZSrJ4wGc0hg51OOl1AsbLclenznUHnikcsPrJfiUb6BoNKcImDOOUWsZ2OXrwaj/85wC2/vmK9ReMDp7WsCQK6gZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1263.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:58:16 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%6])
 with mapi id 15.20.8069.031; Mon, 28 Oct 2024 01:58:16 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: [PATCH v6 3/3] tests/qtest/bios-tables-test: Update virt SPCR golden
 reference for RISC-V
Date: Sun, 27 Oct 2024 18:57:44 -0700
Message-ID: <20241028015744.624943-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
References: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1263:EE_
X-MS-Office365-Filtering-Correlation-Id: 41db5af3-6c78-4a8e-9286-08dcf6f3fd08
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: u5gov6MlCqltnCpdixu6Y4K87IvNCskYX+MRCTdkUnnCrTq7XA5k1RVxus+2muvvNRBk5YKSWy/liI9RMhwRymIxgsmXlCSYNN57c2LymjQmK6kzAgdHAGlOJXhKGRWjB+ZgLDIXe7bJ3ZDbwW+IKD61Vpqe12IjE7lFMLJB83hXDEssY+YTFmAZ4843Vk77UFmgIQbQE4q3VF6E1hT0+wdWhs1hpvVH58MvgTPVVpmjzsA1+Hr6mZTdqKcO8E+W2rnzoEZU/P59GD/DR4IvI7AzTf/hn/4qKgqYSGgtpPnfVUY6HQTrm0gFI7g7Dk3inzwBXiEd7y+oEJfdUSNLcIRGWpP9s4nEbhK2Z7+eeteqOoDqST4IHuEjxLzvn9eB9suSAx0UUiRD/Bb9gjC+2Sa1P6PTXMTEaqoy2CF2+7EwAAZRfye3JebKRvk+eGb3yzpJCjJy1zFhcpclKkuG+JVx3h5mYRIxbiXcwD6xJ7WjxVvec8K5fQ483aqADxGFyrnKUPfySuYVFXfPCzj4PoDGcAF4XuU/qr4JWas2QUZs0jmrh8gnIAtizrRV1NI/SXO5oQz7h51yx6LM5XIQy2X0zSuHT91oxsjmI/W+8E0SF0YxIFtvMqnDxqmkSFpj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtrmnXmSfTiTpPyPu1qS5miTVQs2KuOFc0/e/mWNzdzhBos/UxVI95llmgs2?=
 =?us-ascii?Q?W6SRc68jOhuLYDR1BkEiGQhbHzDdIYkiBHgxUg+zwKW5xeqcoBI3BgwdywSb?=
 =?us-ascii?Q?SdeiwsWYpkoDG6qLDlPbnbkXrcRo9nqpwZfeckZZ7Odls6ZgzUfJQj5Hhlj8?=
 =?us-ascii?Q?sp3Fx9WQuCL1zLf5FVyG1bnELdQdMznrN1m8+MAB2XR/kLThj+06txl2VMIK?=
 =?us-ascii?Q?pBhmscUbGsdUxB4wNkHKra/HZQNGAQKeSQOrP1yFnYi584+c0w977gKd97E6?=
 =?us-ascii?Q?mGKfejVu/HEi/FBS/JMdYAMTkAn8dkpAPVcmOL14SU9tb3u0f1MrTqcGVKFL?=
 =?us-ascii?Q?dEHEFeFWf7odrCAbZU7+Q4RfRWmNdjYHdxThyqhwrueMku4gYzJ880UIpGwv?=
 =?us-ascii?Q?JiwMC2BNffAq+ZTWgqc0ayF78UnRHNIMTGOmIIuZyNyuu0nx9HrYbk11mUzL?=
 =?us-ascii?Q?Bip6NJ439xWBRQ5OEcNLBq1Yp81VN+uFuyTCYxovRY80IluiVfQy0YPGgPF0?=
 =?us-ascii?Q?oLci24XI6DItRfhT4Y2EtSeiwc0ksTYx8R0M7JPMg3hmstugx2rNX4LVbDfK?=
 =?us-ascii?Q?uLd8soapIYqaECQvN3679zNlCJ4ROu5H66qPt+sZBZmHTWtlQPJs3s5FXXbi?=
 =?us-ascii?Q?9J+DiJHZb0m7l4ds0QEJQhkVJLyaU5K6o2HEg9qko8RRRAajSKLiHxuNeUxJ?=
 =?us-ascii?Q?8MoFZypqzM+CnyW1gHodcNoe82C7q+BLqGIiAxq19Np2+fghXUkOiGuxohDO?=
 =?us-ascii?Q?ASOGPL2DdhlaOwGL0Nf9RvvQ1oaoZMWh9nBOragXQak/Iki3C99rj9KkT4PV?=
 =?us-ascii?Q?w0aNa/WDBc60AMNj8z21ZndlicHFK+Fao7qcfA7aQahVXFFc6ttNQkUW1gs7?=
 =?us-ascii?Q?WaNPO24PTFlS92Ks3XiHo4PGg27YTIfwjc6eL94SRtgSHxG0stXFBp34csjJ?=
 =?us-ascii?Q?vHo3o0MxKx3FJ3i9rJ8IEJ3ptbR5I4VzplzEhfgxe9P+xB2OYmhf5yYPoqWz?=
 =?us-ascii?Q?ZMxW4oEwWQyaw5PUmY0EWRnuVtkoVMPXhE+ysrPj6Fi2J+el/VEaR+hbi8l1?=
 =?us-ascii?Q?mfuztHMic8rhwE7tQNWbeawFyNXokZFfLV3xgfeZ2gEq1N4N2QUrla1LXkcq?=
 =?us-ascii?Q?ZoTTQWPM3Uq+5+MClsF0Oyis72g6hobCdF0uDzvnFJ4AEDF9NRRUrBdZPqsM?=
 =?us-ascii?Q?QhOXhBANZcaw4Nit6LsudzdR45Oh93OQ9o/BlNcJEJWcmwxujbLagKsegIiJ?=
 =?us-ascii?Q?IXBELEOPDWRKkGgUFToUYBBzV84V+0JVGVZeC1+CUm42LwZB5/9vvkQDBGNj?=
 =?us-ascii?Q?0t2ZOu3Vlzc+BeNMVGsRzpQRFW3ye3te1iXdMGqOxpAAsNZVvwnt2mKB3H3D?=
 =?us-ascii?Q?eDgkEQnrjN1tBwz4ISza3iu6FC8/w/mAPcECKc7pYnYJrhfBOmG+IhzeGdMb?=
 =?us-ascii?Q?uRWfK+gOOnyJtzxVRarP7l3c7B0kJTXaJmL+AJYRGv8MKnvOof1VAO5PbRtS?=
 =?us-ascii?Q?wN7GCBK/sg11gSaSVOGMmeQx2wrfZFBnwmaFtc0s4gH1ZbS8XBTlyDPKcL9h?=
 =?us-ascii?Q?J0evzqJVfJuo4BuZNwkbalSkzcmMJ12xq1Z74cF50kNcVgu7JpK+/SLoC8ai?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41db5af3-6c78-4a8e-9286-08dcf6f3fd08
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:58:16.4118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DEgZcLYh6o7r6J9v7ni9s05pYOVZXrh0wyZocKaPHP4aKFUVYaMPympNWyO2XzrzpLsajR+nv8pw+nnSv1cVF76vlAvrvnFEKTsJTl4NeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1263
Received-SPF: pass client-ip=2406:e500:4440:2::701;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Wed Aug 28 18:28:19 2024
+ * Disassembly of /tmp/aml-MN0NS2, Wed Aug 28 18:28:19 2024
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
-[04Ch 0076   4]                     Reserved : 00000000
+[04Ch 0076 004h]             Uart Clock Freq : 00000000
+[050h 0080 004h]           Precise Baud rate : 00000000
+[054h 0084 002h]       NameSpaceStringLength : 0002
+[056h 0086 002h]       NameSpaceStringOffset : 0058
+[058h 0088 002h]             NamespaceString : "."

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
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
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
2.43.0


