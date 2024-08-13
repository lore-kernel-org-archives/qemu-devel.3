Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8FCC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdk1Z-00007z-3x; Tue, 13 Aug 2024 01:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0W-0006rO-G8; Tue, 13 Aug 2024 01:23:46 -0400
Received: from mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::701]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0S-0001ZA-IG; Tue, 13 Aug 2024 01:23:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARMq/aiwQndqDSsQdJtJ1gJOWL5gwVQeTxAM4SCmFumbOI2Dcoty0fp075iDtVD79cnbozwKxxi+97vW4OalX4pT/LB9njT9oHjcB8NRjHst+yW1EIgbat+wmA2PDF/gdffSNGHlJ21QCrwz3sDl/wN7TI4fDMG2x59AEdx/bUSm9vOdaH3F/J6/A5D3DVLEDp0yPByA19u5fK6vPqXVoDZa/zT9uwAoPDdVmknhMjN5h8xW1DlUtDOOJ+wMu1O6s9J7eDQNTrZXybGE29yd+z9wOpZLyb5FhsLz+AXdG1gs1LVmKTRl3lP1C1pP50Se1KBUvoa5f/OYQAGvI3T2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFgSVy5zcbcF98v+zS+GXuT97jIWLhSpyDwq5LibbPg=;
 b=agzyiV+GnbM2mxNhBMwe5V3q5qm5dXvnex3MNHATnpQ9ZFmOgyIdXZQ1YLcU9V1qJ3TPD8FEQKtXWBU8ymbSN8BBmz6PCnPaR6N7BE0h0Rrw2hwo/9evTUx9CVuGLmHHKtO9+yMJpd8a1ATnzZnXaL4Nk78sax5v6lvq6wN7Pzxd7DnMp0c3dPJArgf1fTZvAM4/RSq23BznTezNFCu9XBQDIrjcZKbvSR/K2xICHTWBCefOZDWkubpQ7YqtVyuRS+7FRYLRkL9M7POC5uN+vjN4aoH3Z+GU6ki9Zh+yzuqHkLWCQc9V0pdqkxygPurCjxBFlnzhiQm8JBu4ePUXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 05:22:58 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc]) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 05:22:58 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v3 3/3] tests/qtest/bios-tables-test: Update virt SPCR golden
 references
Date: Mon, 12 Aug 2024 22:22:23 -0700
Message-Id: <20240813052223.1033420-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
References: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f820f98-8684-447a-314d-08dcbb57fe75
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: 5AnKWT1S57NEzt0m7AU6cx9WjWTsjokIqIuuROiz5/PZq6Ep+Jy7Mylu79EOblN9OwBtoSqmKQz5sWPL6Ybs1vX2hHs9uQJFmRMFZr1pNSCXzuDeoZk/fNC6ufYo98ZNX+OMuxlj0Xx6N0tW7p1W7R/U7SRBr4K+8HEO/RyjAsGko89UOFPw696Bi0iy/mOJ+Luo4FaCvvn6XtpvxEWBY99Q6xd78bdtqkRrdlVAe0h+dct87gcVnbydso0zKMyrrokaWAFPuIAbCwyJWIqU81ZdufXNm7+PREUCNmqirP3Xsf5Px5x59WDl/NbwMmT6Y14p3iID0mQWX3vPfoEIMKsJnvGEqVC8veWNzofJ5zyZP7f46O+7/DHAME0aTKLMTT7s7AoTAFKGvFqx/NsFTLSY3v2lbrn5WYnvDoMSW1uMVa0SVQvYTlatyEqbEDQuZtO3CbRVPhPbupxSEcBqJi0poEDBOdRJrWiUw7mY3Q0rA18hNZXlpa1P//1y/nKhvilEVtek6lcpiHjGU1j5D7kydLL4o3lbaJCpoXvgTx2D7Y8bf4eZso0W4covenkh6nFFeBZQ+zIC5sRfORAsfArAprfpYiur5f0kq4tnYs0Kuvq3V/Iz4AroP8w7NEeD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0DLdRfyYqQIWJ7oNrFtvA2sQXvF6iQbTwa7g4YqYbR7L/KUC3NPWQq71KZo?=
 =?us-ascii?Q?VYiSp3sFQnNy6aZ50zjEfEph8v8/4yPxJpkrUKOwWmAAMk5Y1sNhQwjtmh2P?=
 =?us-ascii?Q?di2PHk+Fo+NlyNepNodspHhxuHZfj3KEyWXO7gp8Myhy7ZUyiMvrcurRuQsR?=
 =?us-ascii?Q?HZh6deXlOZpxxNlyxvPsk2X2zxYFvHZgQWeSeJE/pxzoQjAlcQtxu77VjIo0?=
 =?us-ascii?Q?6IWFd6cqzPYmH3QfNtzp9x0UJD7x0XX/Jj3/BgqmdJj+HS8FhcJGcowD9etD?=
 =?us-ascii?Q?hPtItJqqaP+++DAi4dlEaDM73GlWf8c9ckMecUq0tNOihpjMvWDcOblqubik?=
 =?us-ascii?Q?RSdIWJ6xIrEusb2XP+UJTuW98M0ZBHyHdNEacn22nBC++Vf/rdkUU3pUZ4oY?=
 =?us-ascii?Q?uOh/Dgg5TiV7qplYVVgsxRuTcj1JulIBIbsvhBker5iJhP/GotYh8R9Jm3dE?=
 =?us-ascii?Q?Abrnd6KlUGBileNCbzHSc3IHHkmFlfs61dRLWQ9iCKNik9aYskOlnt+/Jpik?=
 =?us-ascii?Q?J1Tk9D3Wasg988p0P1u9tZFMxaXbBSxztTzBapuN6k+xM9hTdhLALWyS5HM6?=
 =?us-ascii?Q?L1RWwJTKaH6mKI0TB2/cNsMojq42dlggyZRS2sC0qSBaMvRWIJVY6eEDsch4?=
 =?us-ascii?Q?j6IhpsKV+ZavfTsRsoQteWhxXGVQJOF3/+yUDjO4ku9UUFVYxPngZGRrfNIN?=
 =?us-ascii?Q?2pMvlPIEXVaHwT45Gk1bZ539XgKXjG7pIicqyl5LrRK4qkYYKVGJpgiEfbVR?=
 =?us-ascii?Q?Aly/MmTxh5xrbc2tf8Lh2FH54dAtj9IaUJWkKfwA3fgF/GFI06c9MbGpRlIQ?=
 =?us-ascii?Q?qRBXxrR7Gwian9bTOcF4r1OsonJbtZXYVqo9qVLVxm0DmFvDcxPdJXzsDBov?=
 =?us-ascii?Q?WPPXBvj7vRSD9iGPpA4ZRrky9g5alAJ8Of3VrQyE5zxs9qJQ0rqfzt5ZQFnb?=
 =?us-ascii?Q?ejN5mrGTuuZCJQTPgWQNZKayLseGavMwEBFbHLW6j+bsFvxK5IDAcc/47krk?=
 =?us-ascii?Q?F8c5gsj1bP67R3sqSUzIfqPogBX9Z8eKPMF6JsdxyUujLwyQdgzlGvaO1vGb?=
 =?us-ascii?Q?fOJNxUQj/whsO3Uw4JOw2W4u8kInAi3Q6fdQ7eWjRQ9S8+eo5wNeZ4LNxIzd?=
 =?us-ascii?Q?fLuHJqg+gWQ5t0WT4TqAezl009q7AiXNjVSRQARXDlXNtLhoWXvP8aiUj8bZ?=
 =?us-ascii?Q?Nj4ZnJUNQM4YYKQmDMpeAyPX5iql3W2gMd6cluxVRHkWwstVHvygdfmZIYeb?=
 =?us-ascii?Q?Dt3d0uL3dav+d/IaDgumpHk4suSd9MBfENPdA5faux2PEmpIkT6tXVozs6DD?=
 =?us-ascii?Q?azQpQFT7VFmA/nign1LHR5YIuF6zabG2+uNHkoTKhzqkHDYjaAc+uif1bBnK?=
 =?us-ascii?Q?WHKlJTwnz4+T/WTaIr3pu/e1WL2xhbNiMy+OzLFf7ESdLmOjvJzvQwx3l6nS?=
 =?us-ascii?Q?zc7NYisf7g1NjRq8f4KjRpc7Svmp8hp9OkNKCfH4jtfPTbkTqna5DetxoF1S?=
 =?us-ascii?Q?BnVdxLXv4oB+yRotXh5Z5jNcP71psQAtTBoen7Am4ytYFwIHyEMu00qKW12G?=
 =?us-ascii?Q?SGF/iMJxR8Jwnju1TJTvBC/xl7zKCyfYh35u8GyHyBM23jMPgrOQyeQhVqf4?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f820f98-8684-447a-314d-08dcbb57fe75
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:22:58.7068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikP9NOeVeRkvec2g0VCi0wcAZ+vefrKtH935UX/tzWBCnIb0NuXksFBXvnp8bIXejuVxaLskolyxujbpgwz7BvpP3XlEFpA0xUVIZ3xjytk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976
Received-SPF: pass client-ip=2406:e500:4420:2::701;
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

Update the virt SPCR golden reference files to accommodate the
SPCR Table version 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository. The SPCR table has been modified to
adhere to the version 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:
/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/SPCR, Sun Aug 11 23:39:37 2024
+ * Disassembly of /tmp/aml-8M7BS2, Sun Aug 11 23:39:37 2024
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
-[004h 0004   4]                 Table Length : 00000050
-[008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : B1
+[004h 0004   4]                 Table Length : 0000005A
+[008h 0008   1]                     Revision : 04
+[009h 0009   1]                     Checksum : 1D
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]               Interface Type : 03
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
 [029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
 [02Bh 0043   1]         Encoded Access Width : 03 [DWord Access:32]
 [02Ch 0044   8]                      Address : 0000000009000000

 [036h 0054   4]                    Interrupt : 00000021
 [03Ah 0058   1]                    Baud Rate : 03
 [03Bh 0059   1]                       Parity : 00
 [03Ch 0060   1]                    Stop Bits : 01
 [03Dh 0061   1]                 Flow Control : 02
 [03Eh 0062   1]                Terminal Type : 00
 [04Ch 0076   1]                     Language : 00
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

-    0000: 53 50 43 52 50 00 00 00 02 B1 42 4F 43 48 53 20  // SPCRP.....BOCHS
+    0000: 53 50 43 52 5A 00 00 00 04 1D 42 4F 43 48 53 20  // SPCRZ.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 03 00 00 00 00 20 00 03 00 00 00 09  // ......... ......
     0030: 00 00 00 00 08 00 21 00 00 00 03 00 01 02 00 00  // ......!.........
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Sun Aug 11 23:41:00 2024
+ * Disassembly of /tmp/aml-S8WCS2, Sun Aug 11 23:41:00 2024
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
 [03Eh 0062   1]                Terminal Type : 03
 [04Ch 0076   1]                     Language : 00
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
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 03 00  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/data/acpi/aarch64/virt/SPCR           | Bin 80 -> 90 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 80 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
index cf0f2b75226515097c08d2e2016a83a4f08812ba..acafd161ba2e2fdfbf081d4977ea05621152c9c9 100644
GIT binary patch
delta 27
hcmWHD;tCFM4vJ!6U|^A*$mPZbWH2x>L@?+v002b>1KR)q

delta 16
XcmazF;0g|K4hmpkU|`xfk;@GLAfp4(

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 4da9daf65f71a13ac2b488d4e9728f194b569a43..09617f8793a6f7b1f08172f735b58aa748671540 100644
GIT binary patch
delta 32
mcmWHD;tCFM4vJ!6U|<oR$R))nG*MNX3&>+&Vu)bSV*mhNumqU^

delta 21
ccmazF;0g|K4hmpkU|`xgkxPn^VWO%w05v59j{pDw

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b2dfcd60dd..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
-"tests/data/acpi/aarch64/virt/SPCR",
-- 
2.34.1


