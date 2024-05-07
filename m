Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C5C25B5C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 05:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4DIs-0004nT-7B; Tue, 07 May 2024 01:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIR-0004Za-Jg; Tue, 07 May 2024 01:23:28 -0400
Received: from mail-sh0chn02on20711.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::711]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIP-0005li-If; Tue, 07 May 2024 01:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoA5JuB0dFF5ptXM/UnasgPpzYk+eEUSUeVvNk7vv9DU0pGLrZ4pV3+pyb6ql+KvXg6cT0SQeItcKHK8Vnvj2mbhnKV7PekGWNm6a2+8v9tcPJJhYDt5+LB6cBWTAICbYSwugn+brZcG+niMFTVaT2qtrUGgRhlOFc4qZEgJA+zb6tGdHDp9z/b/+FQFqJaQy+tDgbnIKih91OZbqBMowkI2eAYm79pET/1P5V0TQma9E/F0jJvMgs2yNvlZ2ztdO1BElUa4aFPmAq5w/1K3yLyyeTiPJWtS1juhitv3T4E/V1Qt1X9BzyUFDKvLdp1Cy3xRyTrSR33Pj4dcM17m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeVu23ShHe8byZCLk8FoTVAoi5+9De+cNZcDp+80cjo=;
 b=Ym1rm8gMwccfvRC/Kw+mlPz/2uYYRJRy+sQecleHNmdlCp/g11ThS/Zcr1uOUUqdfwzPkqYwEyuzaI5gNPcTckWiPdb/XYxR7C0aMN2RiSr6o5roOb4SGGjFBBCODdlpYcIJ3z/DDa9Kj87sT9IIG7AoXgtOjLqOPmFgL4q/Ca1lYL7Hg/8VtUbFXZgSBFmuhkNHrg5oPsSvXM1yFbR5mJnFFGdOBXrmaj9ett+ASj9zvuwOLonqShfq+PYEAL058YiSO8eZ+aQazlJ3iWscjjiHYFYIKHHdPVu8RZypjTnMpg5gjOADlvhcq+i4JKtK0tbaWpYYcIi9dinYHHxrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1072.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 7 May
 2024 05:22:42 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 05:22:42 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v2 3/3] tests/qtest/bios-tables-test: Update virt SPCR golden
 references
Date: Mon,  6 May 2024 22:22:12 -0700
Message-Id: <20240507052212.291137-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e46982a-351e-43a8-ba71-08dc6e55b821
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZrOzQFf1kaaCVEdPL72R1e9oZN18Oo58cEN1hrbq3Ib5JZc7TvqMqSBE3kLt062z6VIuUoszsU3VKD/PcgnQ1OaGDM1ArANG4+iRA42QEEQ/5LY2AvBNcMosE/oR4+y/of5fufIEaZ7KERCuYIEQDSICmsRYc5rbqJyyNxJRx3vyA3BezC15nPtt2qaXM0I0hs/I3DxfXmjXPEvFxXq6IvpCzokpha8u+Xd2L03nxMpHbE0rVdO5KKE276LDI66jGcOkZd6Y5qMWWkvJdG0mH1wuOBa+ejH3/4B9XT9703x7bCbbK4ku16oAJRRxuy831WYaRsuPTzFBugKhyiFGZNnKu6dM3aKOrhR+Z2FUKapM+sFZTE0hOXpCenK1ssXL5kjN1n6SR2lLNP6/V8gPRHhYGDkdwoXPPWh+gCJ7w9WvtzFrTctSiqOONqISxnU3cWxKGQ6Abo7rQwH1q6WXQpSdTgXeNoNdh7lzoSV2R1dtxtAd06XhB+PY6BUbopaLdOvqTgdmtH7eJGkSWy4bMABTduurF79O9TgJjjBlCeQcUPyatZdMX2b9rStfk7xD0LRoEnS6lyo6cgut6BVfI2EEbu0PrSKvoVBCG2rSDrKQJLJk36xUKYMBJKVT89U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(52116005)(41320700004)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMeU6o6HlObH0xQwPuqmGckNQAGdNaY6LAI/dv6eSv/WqHD2ODAMi7L9WM6m?=
 =?us-ascii?Q?9c79fX5IXcagyZkwqch4tNwsGEbsm2bG4pulYCAtPjg4HK33yyNfqvgwFaIG?=
 =?us-ascii?Q?fUxgbX9dWWlbbIUKFefKA9oejJ4gxTy8hmPGX/J7UTV/kTZAbNbfcRYEcY8X?=
 =?us-ascii?Q?mFlBYWhTc3OBRIXAyelBaG9ta/xj1G/sfwAXurEQqHm7S4ltpS/FTNNp9d1q?=
 =?us-ascii?Q?C19gNvMrwUo+uas0XfJDlA05sLAH1lTesdAZDgbmJ1/17caT8tE+JSXYK0ma?=
 =?us-ascii?Q?DO5DYprTWOWquYhOQlS1kXzlFcNSLFh0B/WJY3OTJPiC2a4e6i2pRaZQf9f7?=
 =?us-ascii?Q?E+5e1Z4AAjEVLC1YT3D1/dWaJzsDSMkiJCj4it4484N2rMOQU8jERNK0rz14?=
 =?us-ascii?Q?6VWOI+RVGAj8NetSERAKoyzOKzsrIgd2zbIXsPlzubtuOIMSix/vkDiQ2zLu?=
 =?us-ascii?Q?g/kereMwLQpYLpGop6JwptxkvRtLltKJAlgI50tOONHQlIGPpfAx2Ig5hMkJ?=
 =?us-ascii?Q?uQ9WnGapcNui/6xeSO81yxuCaQf0NaJapTTAQkYJcC+Q1a+PTohQh66aLpsj?=
 =?us-ascii?Q?Reg6bc0aw/DyOSCeBYDEuWysVX7/n2fyXkSamCXfISb7Ga7q2OUu0PhUWF/X?=
 =?us-ascii?Q?FYe/gBW5RCZzqi3F6EJKRuZPjNMcYbZguJXaXWxLuOE8avfiQZHh/q4e8HcE?=
 =?us-ascii?Q?1aolHGicxOvG2bTxeKHMbA8ExVI2Io3inShTlgFbP8mSKQ5h1bMh3zra3sGY?=
 =?us-ascii?Q?8iGUIeg1On95XUMD9CnH2B29uEMHGT6rLlQ+4hsNMo2+o7q6Xmo8vGxyrhHt?=
 =?us-ascii?Q?qHYqXKmqpu404uYjyxtB3CswX5Zn1xh5AKx4EdNTwEbGmEoyPBBF5i4MiKP3?=
 =?us-ascii?Q?vY1f4rXCVtTKbi5TW1evrZ8OTk0Cr+RTvxSdr96bru3DeVHiLulLS5VKAVZL?=
 =?us-ascii?Q?VE+/1PQ9mqMLErry6c9U/iZaWT+as0O/wPFpl8AC9aU/e9i7v7p45TquNTpv?=
 =?us-ascii?Q?SR9kAnkX5pGFRn5a9/dHEgM+DtRh620vFvklvVVjHBRsPMmU8AwQ6cj9YR84?=
 =?us-ascii?Q?fwU5bCyeqbaStMHrrf+Mi9k3vVAAhkH7asuY8gXSPXSirfWYinoahjNxxalH?=
 =?us-ascii?Q?Yk7GCvmiSFzesLcxF2BW7cn2LEwI3g65PXXzs4PLy+epdFyKSvxGxgNVjele?=
 =?us-ascii?Q?jd3nJNOLIYWIihm1E9RsYFU7tZ1DIAuKMuiOOXHLmVVA5Pd2qkxxaVHBbwCf?=
 =?us-ascii?Q?zGH1cRRoIO9D6yH3LKWy9fgKg4YR0n0vXJpRX//5c1KBqVackhfwuPl7rGyK?=
 =?us-ascii?Q?+koqGk7hy6+puB/ZK6nso/9IASrmisfwgsXExf+TY2A/i9C8y6EXrXW0p7cm?=
 =?us-ascii?Q?UskjR8AamAZgFtaumi1IrPnZyUaWRE+9A6iGgsLKVZvc+nyjvIduM6a75hE3?=
 =?us-ascii?Q?g2BzuhB/VdXNNPfzHizKncjLhrhx5FD5XNYyE7UuJp+cDFSAogfiNIQbrxRq?=
 =?us-ascii?Q?Db0mL1H5KXLtUAY92EAPz0A9eWWRo4RcfJr9Go9hDaD3J+RvLd6TpfblCGrM?=
 =?us-ascii?Q?k9cejq76dnvS2BZTVC46FkgRkv9+OxX/g1e5UgCjVKj57NMfCxG6z7Zee1v7?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e46982a-351e-43a8-ba71-08dc6e55b821
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:22:42.0989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM4pMPTV2lSXnODLUYREkeSHCvXgTXy1C0BkWhBNhO4Qmp3IMb/cgT647T7pyeIGYr2kQPpP6PrBRZVVX6YUoAxu5ivBCA+iYzyNMabEJKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1072
Received-SPF: pass client-ip=2406:e500:4420:2::711;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
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

Update the virt SPCR golden reference files to accommodate the
SPCR Table version 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository. The SPCR table has been modified to
adhere to the version 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/aarch64/SPCR
+ * Disassembly of /tmp/aml-DVTAN2
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
-[004h 0004 004h]                Table Length : 00000050
-[008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : B1
+[004h 0004 004h]                Table Length : 0000005A
+[008h 0008 001h]                    Revision : 04
+[009h 0009 001h]                    Checksum : 1D
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]              Interface Type : 03
 [025h 0037 003h]                    Reserved : 000000

 [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
 [029h 0041 001h]                   Bit Width : 20
 [02Ah 0042 001h]                  Bit Offset : 00
 [02Bh 0043 001h]        Encoded Access Width : 03 [DWord Access:32]
 [02Ch 0044 008h]                     Address : 0000000009000000

 [035h 0053 001h]         PCAT-compatible IRQ : 00
 [036h 0054 004h]                   Interrupt : 00000021
 [03Ah 0058 001h]                   Baud Rate : 03
 [03Bh 0059 001h]                      Parity : 00
 [03Ch 0060 001h]                   Stop Bits : 01
 [03Dh 0061 001h]                Flow Control : 02
 [03Eh 0062 001h]               Terminal Type : 00
 [03Fh 0063 001h]                    Language : 00
 [040h 0064 002h]               PCI Device ID : FFFF
 [042h 0066 002h]               PCI Vendor ID : FFFF
 [044h 0068 001h]                     PCI Bus : 00
 [045h 0069 001h]                  PCI Device : 00
 [046h 0070 001h]                PCI Function : 00
 [047h 0071 004h]                   PCI Flags : 00000000
 [04Bh 0075 001h]                 PCI Segment : 00
 [04Ch 0076 004h]             Uart Clock Freq : 00000000
-/**** ACPI table terminates in the middle of a data structure! (dump table)
-CurrentOffset: 50, TableLength: 50 ***/
\ No newline at end of file
+[050h 0080 004h]           Precise Baud rate : 00000000
+[054h 0084 002h]       NameSpaceStringLength : 0002
+[056h 0086 002h]       NameSpaceStringOffset : 0058
+[058h 0088 002h]             NamespaceString : "."
+
+Raw Table Data: Length 90 (0x5A)
+
+    0000: 53 50 43 52 5A 00 00 00 04 1D 42 4F 43 48 53 20  // SPCRZ.....BOCHS
+    0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
+    0020: 01 00 00 00 03 00 00 00 00 20 00 03 00 00 00 09  // ......... ......
+    0030: 00 00 00 00 08 00 21 00 00 00 03 00 01 02 00 00  // ......!.........
+    0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/riscv64/SPCR, Mon May  6 05:34:22 2024
+ * Disassembly of /tmp/aml-27E8M2, Mon May  6 05:34:22 2024
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
+[009h 0009   1]                     Checksum : 25
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]               Interface Type : 00
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
 [029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
 [02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044   8]                      Address : 0000000010000000

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
+    0000: 53 50 43 52 5A 00 00 00 04 25 42 4F 43 48 53 20  // SPCRZ....%BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 00 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/data/acpi/virt/aarch64/SPCR           | Bin 80 -> 90 bytes
 tests/data/acpi/virt/riscv64/SPCR           | Bin 80 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/virt/aarch64/SPCR b/tests/data/acpi/virt/aarch64/SPCR
index cf0f2b75226515097c08d2e2016a83a4f08812ba..acafd161ba2e2fdfbf081d4977ea05621152c9c9 100644
GIT binary patch
delta 27
hcmWHD;tCFM4vJ!6U|^A*$mPZbWH2x>L@?+v002b>1KR)q

delta 16
XcmazF;0g|K4hmpkU|`xfk;@GLAfp4(

diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/riscv64/SPCR
index 4da9daf65f71a13ac2b488d4e9728f194b569a43..54fb0a4c749728c93291c8b37fd8ab785189ce67 100755
GIT binary patch
delta 27
hcmWHD;tCFM4vJ!6U|><5$mPZbWH2x>L@?+v002dP1LFVy

delta 16
XcmazF;0g|K4hmpkU|`xgk;@GLAj1RM

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3f12ca546b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/riscv64/SPCR",
-"tests/data/acpi/virt/aarch64/SPCR",
-- 
2.34.1


