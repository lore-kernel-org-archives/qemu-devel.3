Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E271C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2OlE-0000uU-7C; Thu, 02 May 2024 01:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Okk-0000lI-NF; Thu, 02 May 2024 01:13:06 -0400
Received: from mail-bjschn02on2070a.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::70a]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Oki-0005U9-Rx; Thu, 02 May 2024 01:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4syhv6dD03oR5KA9yMyXsnvvWWL7I6S4Q/F8YAQ4hDhi7FS5q4tDSrbZgpLdYuB6Wsou1ZMfbZ9r5aeqY7StQ/O5iMUiIbZfCORYnVbQtcPG6uGwS9nGb6c9SFKW33z2ZZq7MIoj7sPtwOMASc8FpWB9gzGozVwy5W6lJssIkg1P980zNEXLo6aNDEFfgxLuqvOputgrSd7jedAFRkQlt8iBXEVhL+x9jC9+6cTm1esS8uHRbzL+oOuT5S67CpEdpih1XWdV4aexzZlcmR3XZQzFnykSN8O/X6YkvCBmJJBNC5rCaWaQbFXx+WpQ4OQ2e5m6fmAb5HfDriQE0A1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ2crzElDreqE94IaJFTbIvDHJWXG3H1H/YncZQ9fr8=;
 b=kCyUCffMvV8VjJV0MnKnVr9wOZI2EA/YPubY15+YNXphHN7H5zP3p+Dyk3JhbDnD4esybwt/4QeSLIGMtgrF6f757mBu/U/skX11XYgxTSDnPgqmefpq5T8BWQnrjfWe4kv7hqVOe6sWa9WdEZu74FFlY38r3ptv2ytm7ZIviwEKB6QACrQRfJGNJLZ1dUYAV7VO/eADBLjYVkJqzm6PgFVUg0npzFnYasFX7g/FxzX7TRTqlTCfl4VN+Jf1mm735vqf5iOawbAeqULoLyD5zhw/N8UCzLsxZFFn1C+J98u5+i/u6pibZomvZ7SVQZ0g9Ndu1alwE1QP7He4G8pQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Thu, 2 May
 2024 05:12:51 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 05:12:51 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v1 1/2] tests/qtest/bios-tables-test: Update virt SPCR golden
 references
Date: Wed,  1 May 2024 22:12:32 -0700
Message-Id: <20240502051233.50749-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
References: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0051.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::18) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: bf042ae7-5328-4b0c-39b6-08dc6a668438
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pv9msKovECC9LO1W46jkFn1tpKa6P6UNaRAJgMVw/eEiCViYfNcE319LNclaAeq5g06EUh9VTKv+Lml038TJHFoj3bVv504QDugQUF8P4U7sJzcrMuyeQXEcBV+i35MaK7xbRnekpwN0m7kYX4PnOlDpCJMnT5O8+Qx5a/V7hurxcayP/Qh3h2BlqtAPDcWK3hwmVH2FI2ly6tDM8j5lxm9u6IRSaxprvPHsKql2Oaf+7dtiyVqjDmerUKkMFsSATXgcwA+l/4O0xV2ckspa2vN/emNaHnZ4TpRedEZzRrrGbHc3YSrPs8mcDSzl9OLJmde3CDLK7bkrC8c+/jcEFte24ppnihlH8EX1IFS0qT7jHLN4ete6Bjgdgek8NdK1m+1Z34ALdDiUXM1ExOFNwIlbxhYjrEASEehGMqQZh5r7FY8TNuW/xWbrq4xgxRhsQSk4FHhkSEeKOJ2F5+pbB2GNkDouSXu50KhHyYhQobRVcg8ANZ5l3Fn6bqReQo1sVcESkRgfYbxciBLKducIHhQfmA4bVOuMiBoao68kxJl6Kzxn67Z+hUZbGMjQ5rJkCw2yUKbdbqTQ1XeNTyWEiXBnxm35on0NjZdR4I2xQ5KkBtPw92WvPK0g/Yk/KwMq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(7416005)(41320700004)(366007)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+XpplSCFWCEw7vw9jzdTsb9TGNW4BKLuviAyil13VuoZqMkC7UU9/GGjwrT?=
 =?us-ascii?Q?UmxjTuXis361svr5xEGvSO+DJi/1/86Ho6W2jbXcVZT55J0LMw/N3m+kXBsu?=
 =?us-ascii?Q?4mEwkNEmGjH5bZZMvR6pkif4bw4Ep6jErIWTjDm+g9vhwxZwp7claguLutG+?=
 =?us-ascii?Q?DxTfaoXitQXSWW/6QZ0ycqeBdO3wEq35XkJym1QuYCUeOu1/BgcqP4o8n4/e?=
 =?us-ascii?Q?/WPlhExG7x+xTOoSLt6qxIudv+I+i+FXa5uRYUYBpi7Hz5sK56BIMudxg33f?=
 =?us-ascii?Q?QcvjHXXGZXU37Q5XyY3HIjI7+Muzj4n6X+FCZwuN9az0TZeilUSrbXFWwbfl?=
 =?us-ascii?Q?Q+Y4+cNeClRTHzp0+73+HRC/zOzthsVT7nTgG7PCCidpMHTbq5OvBYInHbZu?=
 =?us-ascii?Q?pcWIemmP8MoHcUGAu/VVf7mva4M5MXDa6eEuLqFjY9eIQ7yHNMTc2VHujTxX?=
 =?us-ascii?Q?w3pAd0SUNWS3U4uwtbbLWmqQmQyaMWJqCSQP7Q4Q+oIDmQ6vP4Ss5VMU4Lfx?=
 =?us-ascii?Q?3EilWh/MK2u2LOhrfwESS3UvNZxWbbatYoGwTpA82ojUoZ+O7vlijLlYN6Nv?=
 =?us-ascii?Q?qRL4fGlpWSF2ZXQxnD2y4aPDvCFJZ5Ksk/CytMlQ13rrt6uM6dODegQmB0G8?=
 =?us-ascii?Q?BUzo77PBXBlai1UWqgb8q5DAGiXVe82vv+kifvUHPcw2RMhLrmQvGdSVaeKO?=
 =?us-ascii?Q?Nan+b0nLwDq+pCl+YHwnKqmNrIfxkLfmRAjLMRh59NgSg2jJ8tm2qmsEM7tL?=
 =?us-ascii?Q?ONwjFkjjE0kS+jJgVO2xlFWYN+V4rALYrKAipi0OHyy9pptbeBUXyLNRxhHJ?=
 =?us-ascii?Q?s2EPz4VKhGN1IOvW+ps+curSIjpvJGqKmCbOh6OJKj1VG99oGOffbp+I7tb0?=
 =?us-ascii?Q?gUUm2Z36i42C+xc/oKx/pwJcyt6YdtIPI22B2CG3fOCzEny9fNMoZc3Iiv9b?=
 =?us-ascii?Q?/vjco87AKmHEMAog7kA7L5OtLBF/VV3VFek2AU/2JlAN2kYSIeccidPsAGtc?=
 =?us-ascii?Q?LoySLe9EwUxLYdLvWmyT3uCIV3wbweSdJXWeIdceK8SwEAlqL/K+wcAZe+EQ?=
 =?us-ascii?Q?l9AvSD2rVIM1y0xTB4N4IRMGkC0Z1a+fORuzcbF0nUDOGHf2CCBNgUb+Ejok?=
 =?us-ascii?Q?bngFtq+rRNLPdu/5hkg8GsK0B2rdmfFVMyaQe06vrXCjDrnLiPwocQlv4Zyh?=
 =?us-ascii?Q?498kJgx2y6YjhI0V5OkreaEDVHttUzrWLkylYn15SkQsfsYWVoq9UrjTvrYj?=
 =?us-ascii?Q?To0gj+rNNdGzkovm2O7c+Oj7qP8/8JVLRoepzO9QLY0tMK1wERwaCYsZxNYc?=
 =?us-ascii?Q?MiM6ekmz/uhO5MnxgPmooNAgl/xwBYCsWsXBOfl06IJo4INWD8dJPwKMb8+j?=
 =?us-ascii?Q?ucC5itBB2NCRJrrQnf4gdabQgfG0zCOX6y59P7bLCGhKogR/EzcTdoeikCfZ?=
 =?us-ascii?Q?ooxezdUQDUghdQhmn8H+ZEQs+BNDpMMMmJnM59aw3MoH0j7VLOO1q31eloXC?=
 =?us-ascii?Q?IzB0Bg1BUxZl7C/aKQK3d+3/SDtQbDY9/fVUx/xxx3r6igVfAGrrm5Hpt4Y/?=
 =?us-ascii?Q?/R6CYh82qxKNt1v62fMSsFNp8WqIMKN6T14HGLs882ykLSiExIYQ8+GODq1y?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf042ae7-5328-4b0c-39b6-08dc6a668438
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:12:51.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0f/3oMguMTnYq6UAdpI1JfNTvXyUbpFlGEmmufg9YvS4jt4V8296inv66SEzaMKLJpllk9VrAX4xk49xzQrXFA3C4LSyXf2WbFnNYtPFsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4440:2::70a;
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

Update the virt SPCR golden reference files to accommodate the
SPCR Table version 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository [2]. The SPCR table has been modified to
adhere to the version 4 format [3].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica
[3]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:
@@ -1,32 +1,32 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/SPCR
+ * Disassembly of /tmp/aml-HJ5IN2
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
@@ -34,18 +34,29 @@
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

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/data/acpi/virt/SPCR | Bin 80 -> 90 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/SPCR
index cf0f2b75226515097c08d2e2016a83a4f08812ba..acafd161ba2e2fdfbf081d4977ea05621152c9c9 100644
GIT binary patch
delta 27
hcmWHD;tCFM4vJ!6U|^A*$mPZbWH2x>L@?+v002b>1KR)q

delta 16
XcmazF;0g|K4hmpkU|`xfk;@GLAfp4(

-- 
2.34.1


