Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B9CC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyi-00021b-8y; Tue, 30 Jun 2026 09:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyh-000217-16; Tue, 30 Jun 2026 09:58:19 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyf-0003om-7t; Tue, 30 Jun 2026 09:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXbxUrSRI3k2MkLfexH6LjdByKc8/rfpSykrop3dPlECTt9U8ALdhCzbeoCtHR4Y04bzED5A4xxaxaKeUyEHCmKMr3DuSwb+ONtHPUzwHIMagANMqWNU7xBt2f+l7O063q3Q/m4VK3XofwvlYSLnscwzg1cRsTZLu72icBp4ukZDv9wh0WDyG4q/MCZ/ycxZhv5tANeCTBIv8BrfSZecN+IwTS2gUS+/GzfTJprpW1PPy+qto9SGaNSy9lsAl8Xf7InNOzivMIiTuC433xaKZMSlQGw7xGB8o/CCgWCM7LLvWG+p1wOD/464MuE0EJJYFZIIcrqKXWZxOPvTV2ipkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urClK7CbJWUxsopWabjCeZ7lje+qlWoWYdUqY8Kkjrw=;
 b=akx3HF93ncsG4I4oHhNwhGWtQUsZqmkGdYxeA/qT9OkD0oaWn6iqzuQ6d7v1NMuWKYwyKK2zGbHizO6Lna8EbSu0weigQqHfHpdIkKnohqU2Y7Yb2m3XPmCMuzuwV6fqZBOsBTJ657RR5QL4e4hbf8k1J8RgmrMX1JZqPd3CTBFapJ/LlTp0ZU3aH5fMLqb2rRBlnoxqVyDAxb2ng6Tk5CTmIderaqYULV9lfmzGCpq6h5GBv3o+7vrbXtMQFVlBiwOQ6tSBooVdXhZTSP412Z55eL1UxuYddQQmoNV8Wd5+JWky0ZqT829HJ+E4fSHfFsrtsc/kHy407zl1fRoJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urClK7CbJWUxsopWabjCeZ7lje+qlWoWYdUqY8Kkjrw=;
 b=rGBAhu1eI9J6ljC231hopwB0cdn5T1/+xmH22X3prT/lwmepGseOBjiwO77gQIXhRihSdZO1p70w3WS744V2qVvGPR50FZZdiL6N4+OgeftYQz3hitoXxvSnJ7q53sVUv3kQ7z3JyhVIUDqZV8Qo/6WNVe0YCXHmdsENpsyVnOOH2+Aubb6eDXfXy3wAMTfib2XN22hl8UIGQYyFsdcN07GC+CzOs0Wm1mzHWtj7uj2SJltFKXfztFDuarz6Vkv2i3w3y/uCvbV2wJB2vXc67+JeP9U4SWGw1XsjiDAnJIvrQrZpU0udxbLGJongoiRbGAi7r3JPnIfiqU4qdpHz6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:04 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:04 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 04/10] hw/block: m25p80: Fix dummy byte handling for Spansion
 flash
Date: Tue, 30 Jun 2026 21:57:23 +0800
Message-Id: <20260630135729.466264-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5eaab4f-943f-4fce-45e9-08ded6af9b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fiMpOyHOZQzdMBROSXAinPtPdDNB65dfedsC85jZD5gMPNJlZEuHXqKgEM29GKTdhTbzWqEVmDT9/8vnGmh65/QGtU1Ly9qQU0hLwJf7GsAKaa6HVE463Vf1OeFd/uoejxcTPzgfPART+IKKGdJrqRC9yFLEr/pxisTJ2UYNkuMAOoXJgNBAsu/Jr+Rf3911awZxnjHIjGRhp4A1jH/X+W9WFJ8D8J7MTSOYp4gwfA5R6JP2HfOMukWbJHHVGDtxNplXdRfTjHy9vBzqAeFwwNvwEEb7g91CoIQLYgoLTgzCCU8bs11u2w7VzFM2z4EEn9YnjT1lksH7XUG4AcrsdMo4cuHy9sPuraV0tubsLOWGls8rIMYS0EouawIjg0Iwj9EYuDX4ni6Mq0saMd9IsS99C4Nkt2zUa8WKzpGTzedK7g8FFBwl6caDKR7MkXboIvGgzFWQahHFdrJI3qkrK92eSOoMJWgxBJzgdroJ3ziczZx7YQ1sEV36Y/QOdBsO4dbRhMeRhkyE3sDOrngC1nacxXKINBjGN01G8JUj2faAUHq3Gf+LNtuF68C0XIbgvEJ1FxRwLKOxL41s8w5+KDz6y4h7hmXz3WmzhZE1+gg7oEnYfKhsiBTyQRBob5EeQNdmI1QCjvXKwnPcGF4smNVB2JGKONzWCppRehXSf60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SxJZ8BRWHJNK+TKgOQtyis0WQp4bmRamb4pncGt1/evu9qpPDRvevtKsNeA0?=
 =?us-ascii?Q?IMiRgmb/PP5gSRQe6oeglZT7rgqXwlfc7CPy5uv0iSl2FZri8zhRhwnnD3zP?=
 =?us-ascii?Q?5DqK0wk8SP9ZVCVDxP+isaLJ9Uq8Vm8diydp+mYQwlVhmtCaJQpTqwQ3nv6k?=
 =?us-ascii?Q?0H/2K4MHMmH4U6tisdJKQrq6QM0i91yFptuxjh+Ct3JRCVu1qJYwqP1QLlXh?=
 =?us-ascii?Q?kZTgr3adW6V/sdkwgJ4odDVP4tqahZSO28TMrpeaExxffTNNzpL99gH6OF08?=
 =?us-ascii?Q?+I7nxJCJFgHaNLocXdJe4UpjGQkOL2S8PREhsNvUhn0MmchSWXV+SOh/wcL7?=
 =?us-ascii?Q?u/bYAd82OBY/61UhYzartmkVCn3P9oeq37brW1/TagvyMA0UQqzceDalxpp4?=
 =?us-ascii?Q?Fdothsgp9qSBrs0Ftp7dtgX4VHYKkmQ7mn86aelIv2HNYKlXzBNmML5C01lo?=
 =?us-ascii?Q?YTEZyNDy7vb6xpFEV3zCSgJWVyPmYHqDhZl7/OUUzQpMqh45U7rGUA3IMXsP?=
 =?us-ascii?Q?q4b52z0/k5s1dFg67A1UA31bR4I+8Lth3UNIBTBtGCOOTyGfha+rJ8oCgNlF?=
 =?us-ascii?Q?5M54YkfYposI/WEKN8ShBiBc40L4ODTRpogFQ9oPhas1S30MdOxONvo6XQMq?=
 =?us-ascii?Q?PqEz4bUl2JopkgdFSSQkJPUXAO7ip35YWXpmfgP3WcI9ceDMhqjbLSovbT3G?=
 =?us-ascii?Q?EHNybhhFINRJAWZetA30Gx+jDWk9J5KxP7duTtjgg3DMfbUORzKt75NeDmnq?=
 =?us-ascii?Q?C3JRC3UWjlVgKOERi6PlHeg/DdNB+z33LT512zTsLl6Bt1cHjgqdtYzKKYAD?=
 =?us-ascii?Q?1fyEv3+Xb4bBepAvtV5FgRCR/kxAC4B6Oh75FK3OJipcdXDf/ZjyE01Zc3sd?=
 =?us-ascii?Q?qIi/+IjyZFRs4pW08MPRapJ18cgCjzaYphNUJ4DO6ddZlHczRDCxERzmrU/q?=
 =?us-ascii?Q?yPltB+bX3n115veT3B3F5pY3K0nAsZQDq/Zl8RqQ+jGnjAZSDoPVDT8LPBtb?=
 =?us-ascii?Q?kkJbz7XAxNn6dByqaO2H9nLu8accIsP0fTErAFVO3M3waY4RHDOydhCAWU+J?=
 =?us-ascii?Q?SR6VlK7xEuTqvEy8L2UXI8jF4dcYDflqRiN/0jQwaXAO/F+SnTv3mhD78dFu?=
 =?us-ascii?Q?i0CZSsx6NFgi96KFr3axMd6LqIh2+h+B9N1gNCzXZxAHZfvwjUh0DBEYTxCp?=
 =?us-ascii?Q?RxHZBFDV7Nq/fHHkK/iOPLd2JBDDrJNsI+jlLE1ces2LO6GfnoqHmoVggXCI?=
 =?us-ascii?Q?3PBTpQ0Rg2UfVSvQq8bqV/yHeGaeK43alTzf5HZ8xekV6CeWQxau0pjEjFSA?=
 =?us-ascii?Q?tIa2mpFHS0X5GE4+YWaATVQiw6SGauCBsbVTNdquxojF7SMb9WVbQolGunr0?=
 =?us-ascii?Q?jl+57+fGg44iL2Otpn6Sy8hJRsNuZEn6fg99A50bdYZksN47eIoioJxFbPr7?=
 =?us-ascii?Q?uNdz8AMtrPyw3FzUW6OBKjxmIbd7sNQdW5VpMiJ/Np+6G89Z11pUxImX5ZSW?=
 =?us-ascii?Q?07zePh0GPgXTUjXd/OxSPMEp8IPJ9IFtrbnLyOd+KvSe5uangYzIjUCzYIBE?=
 =?us-ascii?Q?t+ujTwBmXOG+1dV3s3V9l054V58Ox+0TX4hq0MeRhtcZS2oIbJLWbMTWSXsi?=
 =?us-ascii?Q?HnvebKOlca3YceVL1Mr0zhpjd/2GH1dhjwWrk5bncifRl39T5yzwlmEO9Pma?=
 =?us-ascii?Q?6XuTAmDi+zXn9okyvbntVoK3FYFUg0BDUgX/4X6C4WUj93rMOcbKSOh+UJ62?=
 =?us-ascii?Q?A13CcrtoIIvQiwpAM98IXhjks6Tif9E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eaab4f-943f-4fce-45e9-08ded6af9b50
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:04.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQxL/+XgLzTErGW5g7UVrOD0SEeaZ2Wt5HLo09sWih0cGeK5Rt6EMQMOMLIRBY2qff/C+srdhTtaMd0pcJZrhYXubGpN7es8XZKXKKo8YDY=
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
---

 hw/block/m25p80.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 745d13dff6..e5d1bea5fc 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1028,6 +1028,23 @@ static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
     return num_dummies / 8;
 }
 
+static uint8_t spansion_extract_cfg_num_dummies(Flash *s, uint8_t bus_width)
+{
+    uint8_t num_dummies;
+
+    num_dummies = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
+                            SPANSION_DUMMY_CLK_LEN);
+    num_dummies *= bus_width;
+
+    if (num_dummies % 8) {
+        qemu_log_mask(LOG_UNIMP,
+                      "M25P80: the number of dummy bits is not multiple of 8");
+        num_dummies = ROUND_UP(num_dummies, 8);
+    }
+
+    return num_dummies / 8;
+}
+
 static uint8_t macronix_extract_cfg_num_dummies(Flash *s, uint8_t bus_width)
 {
     static const uint8_t dummy_cycles_fast[4] = { 8, 6, 8, 10 };
@@ -1081,10 +1098,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += macronix_extract_cfg_num_dummies(s, 1);
         break;
     case MAN_SPANSION:
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_num_dummies(s, 1);
         break;
     case MAN_ISSI:
         /*
@@ -1117,10 +1131,7 @@ static void decode_dio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_num_dummies(s, 2);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
@@ -1157,10 +1168,7 @@ static void decode_qio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_num_dummies(s, 4);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
-- 
2.34.1


