Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA73C7115E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 02:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjUS7-00006K-Rp; Wed, 28 Aug 2024 21:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjUS6-0008Rw-F8; Wed, 28 Aug 2024 21:59:58 -0400
Received: from mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::728]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjUS4-0007Ke-KB; Wed, 28 Aug 2024 21:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jquxbn9yrqqRe9aI8p0g6pVqEe7+Ze70F7ErbmV6D00pvwyGlU6DxzXor8FLOzaxJUKwFGNiFTOuvVED9pdfA6t8Slzso80AqpT3digi6h04/LC0SrlJrVu5/3t7Efxs8FvpF/v+beEjvkykzxBBov3hDEs1+UDc/l3bCLg4a/3A+w19aMFm7j9Hr5In9bHVd4svCgHnn5xfQHvjlVLQUob6IJYTgHmIEE4JWMOxHknV6v2kxrHXdZhgiDmTEkWZfsvhN2MnA4JFLMUcd95qivNAgKb4RMLiL0CJR9RtJZYid4CQfXXwCaUuIRUxQkBTNNdyADzVKezU0HzgUO+Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=343RvMhlijlXsdUuwPVCO20/Wh/+SDip6rsGAOusnfA=;
 b=I4+OVYLMz3lcnmK7svUviYS6dOqPoMnulix6WcedHLXo2ZOgTUxk9ubYJr82phpQlHNOPLRjDMGZ/+r8697zpoeKUH0KCW+Dw+N5Spml04d9Vs2noSIaVhqT6lyvhgtG+p10nr3ZFk4BxbQVXJZijVtbJGAHYaRxjfJ4wPXBWYoG2J+hg5JM7MayUFP2g4AtZQTtBRFBYyo8z6Hf8xVBYDh3tKmfGIR7XFDHkjyW+WjESrMxJr+BDwl+eZa+AYP4V0Zmqg6ox/KN2Cp10w1YlbxNYwdJeNxFZTpzRzc8y0n8+xXLVr0RGD3Abr1fN3YhBce1IPLxvZk/f6Vum0EDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 01:59:39 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:59:39 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v5 3/3] tests/qtest/bios-tables-test: Update virt SPCR golden
 reference for RISC-V
Date: Wed, 28 Aug 2024 18:59:20 -0700
Message-Id: <20240829015920.95778-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1021:EE_
X-MS-Office365-Filtering-Correlation-Id: c1628671-83a3-47f9-3fb0-08dcc7ce3dc2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: Ooys4qrrzQtOvzJF8AWfRdk6rS67AUcbqsTH9QSzs9qbMXlQXxExCbZ3E8yW/EeGpp91KxDnhv46glB8Pt1gVchbWB/k2a4oXE+AVkwuAPF9EcM+rt8vGnx2x74/htImX7auP1Y5Y/JmDPY4byh5m5yu9oQvPE2CpJ4q3eTtqr9Zz4L2/J7YFlN3izVPiDtu0qQq20+YNbVUNTptsfkxfEOnze78DSv/HZEbk1b4JCL2z08x21GlJJ3bOi1g/3laTYKLfV9vEdD+QIxb5I9OvGC5lOhf5udRrrJZE8nvnycr5kSV5gK1GxuxErZY5LI09DTBKlnQsum0iXitPRgcrlBhimUVa6r9R26EeUMb4WxchFvTPc560fvi9Gd4wUUhAeyDD/GALQW8tnSbDYpfTEg7fKTtOwRqTDjHOCysKjeJQHOXjsOHFulsZUl52Ee07KjjgSW1V85Z/0wSn5C4YMQri+TiG5MiH0LeS+NiWGyGvlpOTnvVPFhGYtzD12/r9a7HuJPiHZmwOjG5uo3hfisgGqFT8XJr14PT7Xec9AEZCGz3QPmHfnvzvbiTI1sF1IVXu6wfyHtNwnDcpXQgHF8AN27sQaNPD+ykhs7EGzCt4sdPK7eSSS0XTozDF6VA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZfJ3zC8VqNndhKlWY/nyzpMt7p25CTLwBzSfu5sAhoutetyKLlJkj68T6OU?=
 =?us-ascii?Q?ZoMrNxmb3tBKritFonpPbTuOymY7pAZhL4a88m5cUA8OWj6l7CzZMy9lYRGp?=
 =?us-ascii?Q?7ZhE8Bw6VaJWwodZ/wO/DoBNa1w7fPBu4CyxUhJRFjIDo8rQZatmCxHpVilY?=
 =?us-ascii?Q?r1XFrpn5CTNb9lRcHOse1RpAgw07GOL9mNO+Aq8/Jqgn4KSySiyCWRdtliZk?=
 =?us-ascii?Q?mvVnulTsItQVpMsN0VJJRtjbvIX46yhir950tizBU7dY4EDgvPh0sEC1EHGx?=
 =?us-ascii?Q?gkbcJFIs4YaQWtIuekAl8hKRFG6OFQ8Q0o//lNVStWOLvNI1qi3DlgV135ln?=
 =?us-ascii?Q?SrxgLjYqr8vCGhadU6Iif/jw4Iv7k/xmcCF4FUHhsCSgRWIPeHdaABe/WNUq?=
 =?us-ascii?Q?Z5p/ZIYJ30wk2HLZpfSxm5vRRGUjciVuVkLvN0ZneVEBptAUssEmHAzAuFGZ?=
 =?us-ascii?Q?hhBn6niu56An4SNcK+spCuwqiEPT1l3lPkRti73ykpmlHQLwMpENbsKSK9ba?=
 =?us-ascii?Q?ejUS6i7wNePaZEkILSlnUZfjr4VYitI3Tly/kx5B4EP5+fcG56pujc3H364W?=
 =?us-ascii?Q?KcHFsvNzDPi/V9jMzPT1OmNeLJiriVxSstR/Y6fAXzmf88krTlqONaGbAMKJ?=
 =?us-ascii?Q?j2iO8J6br6Fj0A+NUtIQzkrR76tee1YI6AhJusQE1VONOoykTfLnQnoRaSP2?=
 =?us-ascii?Q?HI5xhYeLn/ZdCAqhg8SV4UStf0g1915oKYTY5/IMwWzhtL3bsPMrt9eySTNQ?=
 =?us-ascii?Q?GJfq/4ut5a8QcEdN/7oRSYj2xEjn/aAsTEjeNMhxCRzQ5IclcZnWz8xH6Bh/?=
 =?us-ascii?Q?zwMEhKDH4GKNu7QwoG45XqqcRpubIDTG72wJO7OwuQcxYq4+FtTMjQvK6Z5H?=
 =?us-ascii?Q?8101NBi6THnzijxwSfaR7UMyzo7qnzdnswZN80InJPHh8GZ1A139OcpXTCgQ?=
 =?us-ascii?Q?Jvgad1ECgkfQpGTzf1FKEOgnuK7Qv+RlJxtWcDNby0zZY/vIZtXRGEv9McOA?=
 =?us-ascii?Q?aVnHkeg9Zj1G3hHvQ4fCXbYxtsxI4LIyqnxTDQcQYHZk6Icre7ElUUKidMqV?=
 =?us-ascii?Q?uN4T6AoO7klmkwUv3wd6Sm4KbyRy6XvcXQDu3Gu3F3cgnbIn87A4gsLpmEKl?=
 =?us-ascii?Q?pysV1hGJakF0ScnJhLePnj0w9z9BhyIQUnIRtu3rQIecMNWjn1/OswYmaY1r?=
 =?us-ascii?Q?Ak7dZUcN2yK3Q5h0GmNXmU4NWYG00qIoLYmoduQr0cnsTlvSwdVSCecubJqr?=
 =?us-ascii?Q?r5+d7ZLFg8Zrfx/smEbOzsJc8Z4jM7t0xLllviNSJXfXOEEomKCQhb4ZF64h?=
 =?us-ascii?Q?WeqW1H11PYbWsIauP6G+TyD04+KDe/KF9gNkfvWjWwP0FchMH8IZ/jd5KSks?=
 =?us-ascii?Q?DUnxMJwrNL+ZYcGvmt5OfG5XkcTcDj7fY9AswveMaa0CgEVDNvqklLoCrCoo?=
 =?us-ascii?Q?9qiZInTkX9sf7zhyJtlmhcmf04r1c8XTE3ZCqpaKCsWqzi4QByQWBM6iJ/Yw?=
 =?us-ascii?Q?IBtKQa4yh+oud27u561/H7Ph2lFExsQvwlqetPh8rCQCWsd6W2kZgiTiCLQJ?=
 =?us-ascii?Q?1nDk8OlfH39CXn36jflmThwLHFX/eKTHiWGHmk+U4fDi0dux7txcjeiZGstx?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1628671-83a3-47f9-3fb0-08dcc7ce3dc2
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:59:39.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kydAxeSDzXqasccR3+c6hBNt+gCsBkFXw4swrAelZVvs4SSKYZJxHTK1POpZldDJ0VDQgaEgfqiNF9iM2CESa/CrwZGU70emgotwEhP8gfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1021
Received-SPF: pass client-ip=2406:e500:4440:2::728;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
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


