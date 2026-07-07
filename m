Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E594C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Go-0003jh-2x; Tue, 07 Jul 2026 04:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gm-0003iv-P0; Tue, 07 Jul 2026 04:35:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gk-0008Pe-PO; Tue, 07 Jul 2026 04:35:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAmrkEUsJvSPe22RGtJaxImmyEijxgiG+6Um7FNXyuE3aml3Apksp/m+gwquOKdtSvBEq+Bonv4mehaMW9jZMN9NZwrmDtbRR4MHNCKv/sfg90qUWqCzahSA8QcwmhIAtB0HgLSOYWw9yZrWOoD4R0OucNimC87hC6y2v/NlsNYKQOtXLKk+uBY8vEyB5cnmHIYQJx2FxAXDJhVXG3JwaqMpQD5djsKreEBZccfqFyICy1eT7o8btuhnCZw3DvXASkM1F7B+6oPlZpf/6BkZWGdoi3rbFYHDWKWOWwpQtVZ586WYBuzO316yEKdFZHHG1py1yWlkrkXd0xUnggaSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uixdf+oQtholaUuBQOUI5+39mHiezmBLYAbPZV2OZgs=;
 b=ffQcSRXgP65doATcKGH720UWgGuvghuIsRPQ3Agq2M3F5qIij7MqtC9PKT8jgIzMoAkX1bknaWamTjVH443Gz8NMYYm4M3zYOom0QP3c2QedHK7lspwiIxkY9iVRQ1WpuVBc1Xinwm7NUd6z0eL5XSDvi+4TTjo6bK5gGRaeIFP3TcywOmehYSnLOU5YcaXD0JpiDW23liJqH9BIhfmEXTRNR3flMOJzogKqX9oyc2Yeb2ICvHVwA2O7Xg/DkclSiX94H7OWaFwDjNaSRZ5aS7pmborU7RW+OBJth2z7H3/UmWXwcunbopDCisWdt/lOA5s0G2Mt5TvVRMurMAw0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uixdf+oQtholaUuBQOUI5+39mHiezmBLYAbPZV2OZgs=;
 b=n+Q2CPuSd5bLj6/enu5NRD2R3TsE7f/pQbbBnzqsIsTff/Sz5hTR1D43crkfutihYxs4HKMwVLpIh34SdlWObpChd2O6po75Ax5F0nRevcWDdrbG9ld/P9pZZ1CvPH+SS9cIRxagzLXAk8OvODmWZS7J2XQMrMyj1GGcxlcE71eY8ae0wEDB6bNB2IiRc0ivTxJfxSR8f+lzW/a1sXcN7uP3fQJSrnhgsnpBqoGdB9GSXnbGluHWfphfjMlM2g3C9r1jv8WkANKFVnqa+oJs+0gWueciV7Uds5BewvRiDRFmEqmFoJGoUBP8QEOXhO7biUkt92OGkCIi1nheRyLCuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:00 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:34:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
Date: Tue,  7 Jul 2026 16:34:23 +0800
Message-ID: <20260707083431.219671-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d70b290-702a-4393-9c8d-08dedc02a1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|376014|1800799024|23010399003|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eDECXDqA8NGC0FQtCDfjx/P2mWL1FWVzFzcT/ChPDfO4pOPeFAre5DpcnG2XOyAyVbwW/3lLMF0rn0KmW4v8mTcNpzVPEzdgegnU+eqKU4LatJC/07ttl00IDagpdHOKXquN2n+gfQkU3pQ66y9rSSLTzGRQqmRT/362OiH6D5lekGfI2/PCDs3SHW1izkKyHlKTVhe+hdxQnT2v/q10Oj4qoHz15PXH+Z03WQjlkgoqwJZsBfQDwzSDDTTHm15v+ID+M3pk+wXyIunbLEn3lW2H3pMWIahJuIoRRSpztcmjjLbDTcZ95PbTwJvCu4HGKSu3taz1YIGB85M5hERCH8BJsC5AGdkJDlBtr+Dj91y/vuUhfZX4+SLrqixmJgIdSUklE4F5A3FcHJDPuf1HYpsQqSo4ON3td4G30lRxjpV0UskhBy+c0g+T1Trp0Uo2URVvkUBh2BXVxMW7OJoxa2wWIvuWqGY2Se7QAvNO2OKvpoI6/1FcA5PElpE6XhIZLxfr9qarpEQ6rarPK/hdW85VSzBpXBf+8ZHR1qOYD9cvXlZ4JSqP4IWg7UZBjrvfZqw6+UVJ9C/cGyh+u09vg4F7ClpTdjlMKD2pGVxhEQQ6pKy+htH8Agd1TT0jZ/OWh7YxN0e+ijC+3354xrswR86ypYhU1oqYDzibqMMX6cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG90RFFTUmJHQ2tnWlZuOWs0MFNJSnJKQnNBMGJQQnE3am9OdEM3WHhZTDFw?=
 =?utf-8?B?TzNsUDRQQ0dhUEphSENzWGFTU0dTQVZ4R3hMN2FkdmZMbkdLNW9uakt3UWpE?=
 =?utf-8?B?RkM5dVVhcWluWmJxR1p0ajRmWUxTa0REcVRTWHY4cEVSKzhYSldKZVFTOGtS?=
 =?utf-8?B?QW9qVXBxWC92Y1NhaWYvRXl6WmxNSFFJeTBtTW1Md21vaWt1MEhFTTRIeWtl?=
 =?utf-8?B?VnRTQkRucFNFS0YyUXd5OW4zMFlLV2hIZGczVHRJeFk5TUovaWtyMTYyU2FC?=
 =?utf-8?B?WjBORVdKUWFlSXlURlY2N0IwVEZxVWxmcENMVzd1dEtTeUxxNjZybEp0N0Fa?=
 =?utf-8?B?Njh3c2tPWG10Vms2a2xGVmdiYUFrU2ZuN1l4NTRIS3FoVkJ2QndLS3NDUS9h?=
 =?utf-8?B?SUVmMDdDUCtEM09jTGdnREIrb285MHVYbXptdElOYm40emEvcFN1Z0hPV1M0?=
 =?utf-8?B?NG1PL01lUnI5elhEU3N2S3F0SUhBaXVKbGFpMG4wU0lGczByNng2RGEvbzY4?=
 =?utf-8?B?dGhPT1pTTDNzYUdUblpxekg1NWdFRVFSZ2t3NS9vb2J1UFloeHJrVGovYU9U?=
 =?utf-8?B?T1BEa0d6bmM5ejBvcFNoL0lZeVNiTDZ4bHhqc3I0NHlwaVlMQWxwbmhEQmM4?=
 =?utf-8?B?T0NBNjVTVklJSXJGdWk3U1pVWkZWaGhkOWdGQzlhdThOaXlqdGN1NXl3eHBU?=
 =?utf-8?B?WVFWdWsxaGNNMTJDL1VXclUyZUZQZWY4bjVYT1ZzL1FKWWorOFNjL2RiQkpp?=
 =?utf-8?B?YkJ3Q1M0RTU5Nnl6bWlva2Yzc2xCK25Kc3czUUdLN01TRmtLWWlMdFdPOVFY?=
 =?utf-8?B?aUZ2UCt6ZVMxNWgvMlpPd3J0MTM2MWRJcmorMEh6U1p1Qmxab3Brbk5aOHVp?=
 =?utf-8?B?aStTc3IrNXNBMms1NlRlN1cvT1dxSTYvQnF5ajVHZHUyY1paMThFNXAzRmZl?=
 =?utf-8?B?K1JMWFV5MjVWNWhNQjBNdGl4WGp0YUY5QStqNGJ6enlndmtxSHZic2VRaGlt?=
 =?utf-8?B?WUtWVG0ycXl5YTUyYmtWSGtnNDdEdTVjQ3hmRzcvbXFaN3d0UnRpTzQrWEZH?=
 =?utf-8?B?ZERXZDdpem5HczQxZ0FYVFhHSVBYNlByYlJqaTl1dU0yTnJlQk4xUXpNeEpP?=
 =?utf-8?B?cU13dHVXR2NObHI3dTRYRUYwc2Zpbk40OU5qSHdaTVpYZ2puSWZMOVdxNWNT?=
 =?utf-8?B?cnExblEvemNrSndPR01Ib1pKdkJiUHVhVWJMblhzbUVkS2tHVys4SzUxLzB3?=
 =?utf-8?B?Y3FUdnM1UklTeE9RQ2FqSnRIRUF2aGpsMEJEV3V2dVlyMXJubDMzL1lRZk92?=
 =?utf-8?B?dXI1cGplQ0g2UjcwYWJuRkprVi96bzJBeWpMVkExQkdra3F3TE83UXpYeHIx?=
 =?utf-8?B?cCtTSFh2cC8wNWFIY2RORnBUeFU5b1MrZXgyc2hNVzlCOGlUZzFudmplTFZ5?=
 =?utf-8?B?SjdKSkt4azN6aERLL0N1bWhwV0xPZkRKUGhhM3laRERwK2lScW9SY2o3Tk1I?=
 =?utf-8?B?eVp6RDJZb3hFYVowbm12cmovazZYbCt0Mk1qbk1iWWIybjlxdWtIakJYZDJy?=
 =?utf-8?B?UDd3c0JGbXBHUEdFQnpHVkZZZEFGTTVZdXo3Qi9TT1NRbE9kMW5EVVN3ZDBR?=
 =?utf-8?B?cE1qeHhmMHlXMFBTbDJnWmFERENndUk5Sis0SUZKdmhmVC9haFNYTUhGcGhS?=
 =?utf-8?B?WHZHeHFsM2x3MDhIREZjd1NzdVBiMjA2RmgrNVd4UVRQeVdrOG41VGZjc0to?=
 =?utf-8?B?UmlCYXJpTkN5WExncDZPclJSRWNHYzZtdTRPblBPV2kxb0tORXN3T1lZSkNt?=
 =?utf-8?B?Uy9TVGhZMUlLdVlhSFE2b1Jhc0pFcG1xYWhrT0dUcG1RZEhKRUhMU05TcS82?=
 =?utf-8?B?ckJPVjRUV3o3eTJ5WVFsdG1teE05dlkxT1dGbTAxcnhTSTZDbG0vQkh4MjBI?=
 =?utf-8?B?R0MxRE50L1ZuZWZLMk1wMW5MYmJTczRIQ0c2eUwwbGNiQ3B6em44VGFkMnU2?=
 =?utf-8?B?MXVGOUhrVEFXQU9XZlVNMTQ0OVo3ZlNOZEVvaXo2YW52NEM1cEtvUktMOWVn?=
 =?utf-8?B?OWw0RXRacFZDdm91cll4Zkc2eDNqNFgzSkNmWkdKckV1SHF4c3l6MmVaNjc5?=
 =?utf-8?B?YzV4eURmOFdrRWJXZXJjTzFGTDJDajZvSVBTQkU2aExFNHN4S0xsTmxvWSti?=
 =?utf-8?B?ZlBteFJKd3pmSWJ5OGM4aktOeUwzenVKRUZUK245YTFiaVI2cGJxV2I0Vkls?=
 =?utf-8?B?UzliaHJ0b3hQOGtWcVJNWGp0WjBpTnNBVzQrc3Q2eTY2elZyaGdYN04vakR2?=
 =?utf-8?B?dEx3TzJWZld3cU90L3lacnV0SW5NT3pEbFdTdTU1amJublhUU2FLdFllVlN0?=
 =?utf-8?Q?4WP0ucUbfLY5fNug=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d70b290-702a-4393-9c8d-08dedc02a1a0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:59.3725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/vWV3eGvdqAzb7kJpRz95tA0O82h+Oglz418qk1zO865P26vDKHsnEzXyKWX12yFaOwfgeYU2PIp8ZcrT3dUfuZe060ZCw8EgzWHiBFVk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Spansion flashes expose the number of dummy clock cycles through CR2V
register [1]. The value is a cycle count, not a byte count, so the
m25p80 model has to convert it to the number of whole SSI transfer
bytes consumed while collecting read command data.

Add a helper that multiplies the CR2V dummy cycle count by the phase
width and rounds up non-byte-aligned counts, matching the byte-oriented
SSI model. The default eight-cycle configuration keeps the same byte
counts as before.

[1] https://www.infineon.com/assets/row/public/documents/10/49/infineon-s25fs128s-s25fs256s-1-datasheet-en.pdf

Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

---

Changes in v2:
- change spansion_extract_cfg_num_dummies() to spansion_extract_cfg_dummy_bytes()
  to avoid confusion
- use assert() when the dummy bit count is not byte-aligned

 hw/block/m25p80.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d7a9d79373..545e0b5728 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1057,6 +1057,23 @@ static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
     return dummy_bits / 8;
 }
 
+static uint8_t spansion_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
+{
+    uint8_t dummy_bits;
+
+    dummy_bits = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
+                            SPANSION_DUMMY_CLK_LEN);
+    dummy_bits *= bus_width;
+
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    return dummy_bits / 8;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -1075,10 +1092,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_SPANSION:
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_ISSI:
         /*
@@ -1111,10 +1125,7 @@ static void decode_dio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 2);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
@@ -1151,10 +1162,7 @@ static void decode_qio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 4);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
-- 
2.53.0


