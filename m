Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024D5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkG2-00064i-Ts; Mon, 11 Mar 2024 14:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFD-0005av-1O; Mon, 11 Mar 2024 14:19:28 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF9-0006tQ-VN; Mon, 11 Mar 2024 14:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjFMfhz0m7P9BBLqlzX6XMEHdFNWB+PIYGdMiTGeXtcWVE4j/tdtx+8D/+A6OTzjNnlkVdm1gPv8T47QuI0HpwrnEv1nTlM6+OS0/a7Z7VJCduLBpcP/4bYm5YVEXj1lOf5R0LKUzkLmgj0UOXnrV8OqzPiQmnDX511uKz4w6EBDVKaFe1QowS5jqhHcw/EzNsQSes36gXm9v5gXqDjIDoma62159a7FEZ9DDYP76AnNCIRF/+NgyoB66TCcp5+02U3ugR0Gr3aHsiUBABE67WNdSJSmEns7GuO9q9MuTGu1FtWAhqbZ7HTWcA3W4ZgZM0NDxq1ilhEUjitJNklhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFmmOZU8aKPLqXrPTX01OG1YD9sHBv41zXDxq+rePAM=;
 b=EQeLVwnUlpk1cTS6e0Biel+xX13uKtTkSQkjFyH2LDODUGL9ozvDUOH95Aopivus/AYluZVnyLExDQvuTPhRvK2SIpRbx5fQdowcNjbEPUnBjwQBUDbon+4C/AYYuK9jcV55XjQmVFS1uhm7XQ4kWXt++HEAoih2cMVoouF4ZZovcLhUjtejzZcpWuefeaaF7wHnrCtbcy6E1htHAGDCcp7L6xoMxLCxv5smKC4xhatBrnyRB6UGOCZUq7dt/deUxk63AnXXYKi970y1V4nHQldQ7te3NzVjbaacGvc2QA7Ok8yXumZXZ7Ikdsg+KpQIRi2jJ/Q60bui7XWrcWAljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFmmOZU8aKPLqXrPTX01OG1YD9sHBv41zXDxq+rePAM=;
 b=QpcyjKqPatC/haq931NoyvGJjyV329hA/KtXf44HvshGX9K//EooRtm2b5fAUa1r8ENNAMD7CqDNWIn9tKE9ZnjTPvWXuMYd2iP7CtGd9vJp62KF38puOilsXrWGlJYceu20MRpN7QhSBLYLYOQCZYdpCGCDz6h1V/9761WTyr9oGS9IaBv5ieWNYQ7o+Iomvrkw6uONMXAid9dDqKWMIZJaXccGYFBU0Qu8gB3rYcZRQKB0WzF8hgGrGGcrSyodDU9A3TvRKwZwRF+w6IOPN2xbVGpxSvTpGLE06jv5YVwbAb0VIb4xVZOXFsdOM2U8ShYuO+tgkU5GNmbkpHtkiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:07 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 14/22] parallels: Preserve extensions cluster for
 non-transient extensions
Date: Mon, 11 Mar 2024 19:18:42 +0100
Message-Id: <20240311181850.73013-15-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdb4e01-dbea-439c-5965-08dc41f7bd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUZlNkqh5AmBqB1InhZsrz3ZFOyAYLH2/iOKJn0hIJnGR1y8B44n072Yw6f13pzOb32w5FKzp8QUMOsEAOGMPchCVc/J7sulSeojB99Y/YeGmzmVPjyVgEhj9byCFGFfpExn4AUy3kmSNfId7UUPUobnQ0hN2fNjlkXKOPAnLLZeQ57J5bv2ZjZS16kLfcDMH5eUtdGRDzKDkC7jrP2RhSthRNZBaTtmQSITWoAz06adZTnz+jFNsN26YuGmaY1HWd46fOgB8SvmQu/I1Q87W3modWiSRnXDOwQ8OlOD9lS2lYxbD4RQd4PY6+V5HEBpEwP6SofF/4M221O8IjNGpFvMjGN+p+L6LuhiWNjYGzCyKoffYQmf7rCUqjoA5bdxdkUZ/WFie/tTMvrT4T9BGEK2YJD72pmbX0iRh6licRrkwJ5f0T8AYn03KIxYg+P41DXEn+vGRL0eVSuqZob3HLx+i/4Nqnk/pq+aAPAIP29zCXRtSPZ1jHeSe6sbhWh7b1eIjsSgB4gK5N/3ESNGpG3/iDiHOSeRnnEXjACdxFM15veGCu6XNDZXKtSCOHWMnq5qeyMRBhSNJSewNJTrIiBLSA/lnozFXs5TvJG6XOPnzsAAmv0elCbevm1nd+i13zJo9lAxH26yMGxHv3m4IcyP9ZDTBouINhRzx/QzMebWwZttFLdqyjAm8jcUYno6DgJK6qOsE2ZbSRyt8FR5KRrbS9r03l/xZNwPXfZyflY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zm9j3kbuFl/rvtaNjLZdVk28J31dBvMQCQywtoUVEoA1CGZrmNYcOVrVNqe7?=
 =?us-ascii?Q?+vD+q1u8fE7Glia2pTwYja7SUwKl0g45S4GIn5WEDzXGgSxduEpGe3sb5nF5?=
 =?us-ascii?Q?SHssMKn7oTOB+WHwzXnF5Y+P5REjgQk6Gw3/qBGh4oOdTyl/c6zUmT6nza5v?=
 =?us-ascii?Q?9UTh9Mc+NXogRsapM/4u8zDTbOUw75kOl+v+LFV5HTX3mDtQrz0dR6bIm0pv?=
 =?us-ascii?Q?haARR5kQLEOQtWpHP4DVZdOnCNdA6LP/88IuzN00EoxboizyykALYEtbqvnk?=
 =?us-ascii?Q?yFY9Tu+bkGpwRoDmhosHXV22/qM+VNQOxDpPMjua2mjit0rxyImok5TU88vN?=
 =?us-ascii?Q?wyKb3nlKVqrKmgarBy5ahOsr8o4LlR3lz5/XlCemnhBlzqgUD+C4lKiHrn8o?=
 =?us-ascii?Q?1MhX8QnxQJtJWMd+0silQpNIc1OciOuUs+CA8tbrRkBghubdjcnjBBqaIsF9?=
 =?us-ascii?Q?NHNnv4htZwjAnBtwTnSwaSwBxpLr0bjPRtT1yEzwyO+7QEi0pdHDghFypi5W?=
 =?us-ascii?Q?6yF/r9cFPv9+hjb7JocuX0w1kjiSAUbxWD6Ia97+Ne93mhBN4kxcCECZMbcJ?=
 =?us-ascii?Q?W1UR+44scctYYcDxXOzbP/aGpa2e919k2b8Tw+gLL9L96K701vKhS/rOgfwm?=
 =?us-ascii?Q?B4bTZ2pl0wzuK5mn6x6LPaWbvnxlSlI47kvoIIQjDB+5YBftWeTrMgHVLr2Q?=
 =?us-ascii?Q?Q6d/zHiKGWnPj/Vrd7hLyeA6AIRnVDR0XpqD0RM02fLuePixB/L3ZToUEy3s?=
 =?us-ascii?Q?Ym6AojZNox9pfblh31JTYRRggcygSpdkv+TCsVC8Tpt3jsO7I7GohzbTgBu4?=
 =?us-ascii?Q?LHaTRrtLBB6qI0F/aqmIX4f0mLMddA74j06iC7KG6WRY+/fUAx68MBcTtGOa?=
 =?us-ascii?Q?1Bd2B141Ygmi9hbUhdHkHR4zLCNMFCpi4nuuGLKBsZxRqp28GOb8XSDdwS9N?=
 =?us-ascii?Q?5mKrxmqjVP5UaeXdRaeSRwWVXNsl8JF57ez1myAyi0rUItOlLQf2DCv2LVuL?=
 =?us-ascii?Q?SdXcZeLwo14m9jgig+66CTf17wbtDsBa3CAwT0T/NZEvrD6oyrLrPcWMInr1?=
 =?us-ascii?Q?d5iTZ8o8ZR+yAvTarazO3hjzcHrF2u+2nlpc4IofcWN3Q+FnQxsFddQvI4cG?=
 =?us-ascii?Q?rHFS1rQIaeTX9xp9gCWPY0aQgj8fIB50izIWLgsBOWA7kJE10iyIGEo4vDjg?=
 =?us-ascii?Q?csNwnCxaWh6vRE3xu1bt2tridwAjotWgxwxH+y0Ed4YaVRi/Z7OljUx5WTEE?=
 =?us-ascii?Q?RGx6WvOM3sb8uL5Myzix+qiS4N+rhTVrGgztD1zQQTAyxgBhOsbqeLow4goz?=
 =?us-ascii?Q?QvV1kGdVSwK6LG5f6n1QA13f3s1Xp09myqHJ0TLBaexR3K4reb/6xE/+JGzl?=
 =?us-ascii?Q?kM35nQEEVq4ykHm7IQoiVnHBCpyioGL/8IjQsLSUgl/WRHLZvf9iO2tpmEyO?=
 =?us-ascii?Q?ay0zftq8j3nfESwHcy+2uZ6+WSN1d+Iq9zoVAVrHb2+2LJgi18NEmj/vMX1G?=
 =?us-ascii?Q?1yDoaSWE1jY4ip4QNRfZB8Bd6xBYBB9TIzVNC42jduUkcaatoyc/hYi6IiB4?=
 =?us-ascii?Q?DdBPcu2N9v1xAQBJBXPl7akB1IFFo7sZKCHstx1A9+7kBDs71tFRkzdvcPMr?=
 =?us-ascii?Q?4rhiT1MP3DMhXpznwtAE4tM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdb4e01-dbea-439c-5965-08dc41f7bd7d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:07.2898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVAK6z3CHSmVKketOQgpLduR7dc+hDSDqaJjrbqnKiMitQP0LqYEl9HVY5nLV9T7CHmUpdKmTRdBP+BJQn3aFAqyNj7WSoUZ8SOIxmCOs9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

There could be non-transient extensions that require presence of the
extensions cluster during work. Mark extensions cluster as used at
extensions loading end nullify l1 tables of dirty bitmaps.
Use this cluster at dirty bitmap saving if it exists.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 49 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 2d839006a4..1ec23aa1e7 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -122,7 +122,7 @@ finish:
  */
 static BdrvDirtyBitmap * GRAPH_RDLOCK
 parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
-                      Error **errp)
+                      int64_t ext_off, Error **errp)
 {
     int ret;
     ParallelsDirtyBitmapFeature bf;
@@ -130,6 +130,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     BdrvDirtyBitmap *bitmap;
     QemuUUID uuid;
     char uuidstr[UUID_STR_LEN];
+    int64_t l1_off;
     int i;
 
     if (data_size < sizeof(bf)) {
@@ -171,16 +172,29 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
 
     ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap, errp);
     if (ret < 0) {
-        bdrv_release_dirty_bitmap(bitmap);
-        return NULL;
+        goto err;
+    }
+
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        return bitmap;
+    }
+
+    l1_off = ext_off + sizeof(ParallelsDirtyBitmapFeature);
+    ret = bdrv_pwrite_zeroes(bs->file, l1_off,
+                             bf.l1_size * sizeof(uint64_t), 0);
+    if (ret < 0) {
+        goto err;
     }
 
     return bitmap;
+err:
+    bdrv_release_dirty_bitmap(bitmap);
+    return NULL;
 }
 
 static int GRAPH_RDLOCK
-parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
-                                 Error **errp)
+parallels_parse_format_extension(BlockDriverState *bs, int64_t ext_off,
+                                 uint8_t *ext_cluster, Error **errp)
 {
     BDRVParallelsState *s = bs->opaque;
     int ret;
@@ -259,7 +273,8 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
                  */
                 break;
             }
-            bitmap = parallels_load_bitmap(bs, pos, fh.data_size, errp);
+            bitmap = parallels_load_bitmap(bs, pos, fh.data_size,
+                                           ext_off + pos - ext_cluster, errp);
             if (!bitmap) {
                 goto fail;
             }
@@ -298,7 +313,11 @@ int parallels_read_format_extension(BlockDriverState *bs,
         goto out;
     }
 
-    ret = parallels_parse_format_extension(bs, ext_cluster, errp);
+    ret = parallels_parse_format_extension(bs, ext_off, ext_cluster, errp);
+    if (ret == 0) {
+        ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                  ext_off, 1);
+    }
 
 out:
     qemu_vfree(ext_cluster);
@@ -429,8 +448,6 @@ parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     size_t hash_len = 0;
     int ret;
 
-    s->header->ext_off = 0;
-
     if (!bdrv_has_named_bitmaps(bs)) {
         return 0;
     }
@@ -447,11 +464,15 @@ parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         parallels_save_bitmap(bs, bitmap, &pos, &remaining);
     }
 
-    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
-    if (header_off < 0) {
-        error_report("Can't save dirty bitmap: cluster allocation error");
-        ret = header_off;
-        goto end;
+    if (s->header->ext_off) {
+        header_off = le64_to_cpu(s->header->ext_off) << BDRV_SECTOR_BITS;
+    } else {
+        header_off = parallels_allocate_host_clusters(bs, &alloc_size);
+        if (header_off < 0) {
+            error_report("Can't save dirty bitmap: cluster allocation error");
+            ret = header_off;
+            goto end;
+        }
     }
 
     ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
-- 
2.40.1


