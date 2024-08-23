Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08581C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shSXM-0001h5-Ky; Fri, 23 Aug 2024 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSXI-0001QL-1d; Fri, 23 Aug 2024 07:32:56 -0400
Received: from mail-sh0chn02on20706.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::706]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSXF-00086J-Bo; Fri, 23 Aug 2024 07:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncWG6jlvs8vC1RFMZ7DxmplG0S/2CT4ur6poCpwdQBphCIHpWGg0E1zz9TG6ozHmz4VO/UyllX2xfd5OZP2vYhQKSC8uGWItR9Mp3SE69tOdnsN5W6XVsJAFDZHASx5oW94ivrNnBzQtnTS2qDICSYlq7PEOrf+4invBTOh4EbPnQqhqZr6MN84CrlEbsw8nAomuwGLiRg/O4aYKY5hCMn5dNpMyfo/UHYsHP0BUpz198kqIMUjko48JDPThvmT+h81GQP/VCwEb4jFDL3dV+qm/eBmFv3V6L9SuwkQu7HJ+OHZqQyXhhPaEyjjYal6S0SVcShbk4csA+z1DmmvMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmGMyq1MZKLP2C4HOPw7aPDX7g8TOYFd6Ri1Rt9aew4=;
 b=RQCx40mPwjEuDN+NZ5Iy1Dlj1BKiwgDMK0YyQMkUh2esJCRIgl3a+r15qlJeZgyx/n4Vn2jfFTIyhhHCBWA3J0WVLc+pa5wlsQQisFl7PDfaES2acKMw0EYma3CDFv7SUPF25J6WvDsXr/PKWtzO9NMyUWob+P7z63+yJGLCxa0MfMigAzec7tEC5WLJ/zShhBslTdSx6OkvXyKpV3IUTde8DC8a7z49ZFiECLHlkpBplw/Hkein/cEZjdb5Zif0cE0FA/swTUPZyBVRCOWEdpMVnLUqWLX+Fqf568IsrCUahOMgEBaPVH6vWf4YR5nnbjLGJhmopKjoyxnFKrzxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 11:32:13 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:32:13 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH RESEND v4 3/3] tests/qtest/bios-tables-test: Update virt SPCR
 golden reference for RISC-V
Date: Fri, 23 Aug 2024 04:31:42 -0700
Message-Id: <20240823113142.161727-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2922ba-9b9a-462b-5923-08dcc3673b96
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: iruJ35aIZcybldT4oZ8wbcQytx8yE2z83c+6OE4U2R2ydPKpU474VotJQAa6dQ9BOPon3qJdocsdBk3dks5MQZeSqAa/23qsUsw/DVmRo7X1w0B9IBf7IbmnzTBa1awCaooeXgI6uN/gX2FDyg0aYEAhVnPAqN0hYvoxj+92VicVEzFLip/yUd0Kb5XJiHWYQUHQ9Nbyaa4MVaiXgSwcbUKFb4JvZcHqRRTTLdam9Juu7qj9qKr8VQGEBJMtBszH50E/LoOm3EDTtskSZZbcynLP7wTtdySF7DXVdne2MPlWLBuiz+zdm0yigL9G5ppjwh2pF4QnNTMod7TxEhVfiLBPgrjVtZeb1ulGGsxnXrHRu7rk/qCIGdLGpgMP4Zy2R8deSadDOR/VyVMlOKdX9WaCObZIZ6kzRazc5+Kceg5l5isK5yqKkn/Oy9d6Elew+y/6ycEl9F1ry79/2+xGyjGEOJhaquiIU//a9IPpsUcUyyIjyzuPwpJRX28fqWde+n7tFshbxbnPY+56rf53+aZj/m1ImciR6Slh3U7sb/4C9HoUV3y8NcuXYQiiYzgHhFE2M6l7YX9xQ6XHpB+yZheLxBvLIhwY1y5ODia2HCoE6tUYQF1COrBtoZFY0Q17
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TM6Rew17ssGtkE0DZhZn0nOKqVTGAeHdI+oaw24eF2NDYj4iAatlTnDzm7KP?=
 =?us-ascii?Q?H0se9dMgagicjh9Ma/57f4PIgZrVva04u1m0yyG+bRtbwWJZ3ZnsA08pQ06K?=
 =?us-ascii?Q?AuJoC62q0AzIOQ8h7cPrsdXxnRUqtHC4rVtOJM2S2BuE1A6s66KTOp49OOFE?=
 =?us-ascii?Q?fXOw6wznQdkVU/wFZySsb8joUYyUkORKlaE12hGRIIUL6xPoAhPW9pa9xZw5?=
 =?us-ascii?Q?BjvTP43V2qMOfq4UGdZUTSMTBntA/zu1MCB/tYP0WKict3zW8S24s1p1rOpt?=
 =?us-ascii?Q?rc73ATLp3qGWfU6rvs5FUr4j7i0j+437SdtEDlGJush5hBUfx50qmde/58Gv?=
 =?us-ascii?Q?OYv6Dk9Jt1jvST9iIsbgqzitmL7JgUEmqRNqKsXtYT71BRJRmpdcGSrXZ6hZ?=
 =?us-ascii?Q?fHWhNIGSzB/ytEQ8kL1P4E2Rsjw9SRKfGf61cOlKsCk5tfFZFbPQENUHU0gd?=
 =?us-ascii?Q?8nfTq4CH1nvyxSTXwRQ5ljAV3UZHgMNLWybYR6Lr4tAqbj7Ca6Bzq8G5Xh0Z?=
 =?us-ascii?Q?DeLbXHitLsenZ+wm8gX4FBwIsM2bXBcDOD9bdBRl/uPzxxld9xnsvNT4FsEs?=
 =?us-ascii?Q?REXzcDZVvMFIpvEJBmYSDf9mJHSkABy4lAY6Rfj6yTShyNykwkZAj9Kxeq6l?=
 =?us-ascii?Q?7OCufZLQ/8FMAacR1XpnoFVnkSnZ7Wt6PrJQ6Pz/guvWp64G8bHmVRQD0I8c?=
 =?us-ascii?Q?tpas9s12gbxkCqRySEBi/DZeexRBo5QcjgfOuIeHH6s5xJxRbb42Ubi0edXX?=
 =?us-ascii?Q?KAKNytn9idY3t4uXSJJP6irpz9BQn81SGazs4XDVDx5Nlu0MLlJQf1FPEnxM?=
 =?us-ascii?Q?duAW1kyg2fEAzVBfjF+aNllhTRKqJiKgYwEDjIgdYP7XjVrFyykaVAFx2DSZ?=
 =?us-ascii?Q?AboHT58xJrlXUMVRBduaJZAVNakW6h/FyRwd+wvg15cUOiBeAEnW+PVY0O36?=
 =?us-ascii?Q?YyaPe/HmvbYFtL8DJ+Iol9jzzRlx5AENNow2TwZE1TO11TgfvIsdYOjYelnr?=
 =?us-ascii?Q?OjY6UQzrslN1Wx+ala2dCzVXgLDuxhJUjY1/ZKRcz4bQM4+6Owc4n8wZltzM?=
 =?us-ascii?Q?5IsuCtEOFOvT5uXKDyuCi+Crdwt2JiFGRrhCQ4nRuIagAIz4ZzN6SFzMK0Gi?=
 =?us-ascii?Q?1ww4IDIZUiHLYzquBS0TaGJI99A1G0Xc2o4EFTOY3hA9QnJh+nPAAHuiGnu/?=
 =?us-ascii?Q?pLqUJ1TmtO9PV4ndxBSmbh6sT8hjmw/j8EN1sF3KGE6WewQbWkNDQnJ5IPrA?=
 =?us-ascii?Q?GkGtZ/6yFqmzlwTGpPgXrUE6SD3Lvk7hUOND0JQN5Tk4TSGK7iZpacEnHIUT?=
 =?us-ascii?Q?w8kygP1csBeFbzrWWgwyprK6K4i50n0Y1x+JfE/fi+txQ4OSaAw4UHW9MRUE?=
 =?us-ascii?Q?8JCslIkbHN7RvNg70uh4XIKrnH9jeKcH0gIirW35kuyVV5c1Ygp/dn2h3Bkk?=
 =?us-ascii?Q?WnAt3G5N8FNDn3qZMx/3tZISptvWyrZruCgxkbpc2kcUa7/J6/NDwVcJwXNi?=
 =?us-ascii?Q?pTlf7A2N4GOObraC4FGuMsE1Ld6Nsq6omI46ImI3lMMGPi8ZWrSzIBrxQPDm?=
 =?us-ascii?Q?nyNxwKBk4SrIiRRpLvDpBRjnMAxGoKPlBvdDyu8PuEug4IjmUHHV53DfENJA?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2922ba-9b9a-462b-5923-08dcc3673b96
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:32:13.0193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQgs8lI7ptmBNHgcSvOgG14dlVeVzQ0PKRiG7m668QWltDAjoeA7egae86nPyTkm64cSZRNj2fzpwv+AqedJkQIOTxIruc8rjUltOyb9b3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4420:2::706;
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


