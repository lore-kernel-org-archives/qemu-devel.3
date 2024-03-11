Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHY-0007ZY-2l; Mon, 11 Mar 2024 14:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFK-0005et-K1; Mon, 11 Mar 2024 14:19:38 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFH-0006tQ-W2; Mon, 11 Mar 2024 14:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFRT/2uUEE0QebolJlblg2AhQKr0dmzmakPrzL8gzHRXAAaRfwIbzINGBSZMoGU7VcwhchV+zWJOP4Ttia6n2qhwNOksgblJOdFSPVwZk1lTjrvqhos6AQodUVo38v5Z0y+2J5i6Tv2Hz/5XnYuIxjb6DA+WbAo4ZL5PeZHWVXOKOrHIVNX7AMwHfFezrNLQviSOgMDymKsBLFa5Qmlms3MuuN/oSsuwYuJ2C6Hmdjcu03F44M4RDlU6kRxiY0wYm+X9IdQMTjU9QNJK79BusyllwN4XhV+PMEyQGWQjhjOcg3S4IALv1nfLfp9nUZYIVLz9Ll3H6DuhJcGXV0cB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dpw2BFoQH+IUcfx2HU9nvky/XaiMOXrcKOzTx1PVl8=;
 b=LeAZcTcBHTPWrsI2PBkJ+ad605VdRSqBUvlopFyEY4IW87tPhNBBbsvqmHS7L/cQRx++S0GsUxDbY0edRrKGpx5vA2x2SrcUOjw+yfo2i5NQCru2SggIxchwXQK3pL1fVFl41tSrW7jbZVMDTLc102EXJAW4jVXfSgdjoVssjSW+V+54r+10P0ubSyd9YntXyoubQbuc27c2EXjF+SJI1m/IM2GBDG3tIdGmo5tb/HI7jBZ2Co2Af5BzppnPnxS8EKcTeStNTclKfSZ3Uyj2zo7f5Z4kUzHNxdy4Uw1fekXQBn6cG3sULdwmG8sHr3OXwT9A0Hjuxx0Ot3WdMCm7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dpw2BFoQH+IUcfx2HU9nvky/XaiMOXrcKOzTx1PVl8=;
 b=nAsBiujwxs5Cy7/819ZIdBYF/br6m4GvagFmWAn+RoamCM1lcxiYUKHPtC5WVz6mSB7vwmtmxCYqwOEjPePDj4uFgdN0P30vtb51OwJGi7J3RzdHjEnRrN8MbCSKo4tph4cs4JN98b5FnLor8hA+PpZJYByWaUhyYBLyh+AkKY/2RYoAS+bKIOvRyrhvHyLgaONbENVeIjJ8VfkMZRznkWHcK7vja7aQLeLTsCZRNpdgn2cSTiPjRKVx9RJ5w0ArDYPHgHkV7Oy7yfsC1riPdZ3uL4GQcXamjTWIeh5Y2TBhV2i3ivONQnVyODXd+NPWLCKfkBcL+kCAO6yj4k6IBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:10 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 19/22] parallels: Remove unnecessary data_end field
Date: Mon, 11 Mar 2024 19:18:47 +0100
Message-Id: <20240311181850.73013-20-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6b221d7-ad85-475c-a6d5-08dc41f7bfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j4+WRObd0G+qF7pPxbG3ebHn41CQfIuU5uJBgSnsj4wHq4/8uz5fOCq+fwPvYQyXrC7e97jATNYJyso1aYOd2ZwseSnmfFMsC3RByKXawlgrvzpnXxFok7KqxLKnMVNF+Gl6AXlYpUprokZRj8xDJDUVAzldmx1nrFya6dK+tJVkZHMLwD7QsRAXfvYTYmu5IeB9jpbdRzTlN5WpSE22CnSmX0lt77pL64AS4hxeJZvH44osG2Gm0BmL/8NkKYXPzzM3em069/QCx7aLiM6A92shVLnAuRoYIaao3CM3g3EwAud6P7uVgdXG8MSHvShVZtDHW5YHnS17CVE0wt3uGUkeqJ5XawF0dVDeAvXAv+PwJrzlv2aOytSK0JyH9xwIIuhVuuG81pWysNTOURKmUpMABXbPbBRaLMM0Q6eKk3XJYJDarjDyB91vZ79Q6Xk4LpvOp2P6ThqZuMLLZSRAcBjQtyQWT3BLlTrFoc7gReV32dp9qII3KjlhKGpsKzuUbulucx9qaWoWP69O+FckvPeuN4LT+UUal9xn2I8RAJys4T4JU8RXZXihzd8OhReCTGY5aoG8vtiDMqatpnnJ9qBeZerZ8axXw0NuCOhZ+rvvJrMXla/uV90b6fHStL/zKBcwAE81vShLU03heJcKtggI8i1/W/Jef6/BSCnuJElmtEKwKKwb9JZfEjO/qBEQlvvAEjfm7ZmsDLtqOjIkcE/aMDu3zl3SpirNDM/vnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASsBZwWE97gNtY4xwbYJeDKE4fKnyvmqbA+udKVSekQm058dz3viDMtIEHuk?=
 =?us-ascii?Q?oF2cNMAP7ysr7E46QuVoPOOltqb/I8/P2YpYPCBOtm5vn69WqY7sazNU5rHc?=
 =?us-ascii?Q?vNvaHrWnoV3gdW5CAU/st0X67Yn8iu1oQJTH6KGMKTjgT+UakEIPwf91SndH?=
 =?us-ascii?Q?2aA/+A8u2m3rBzWSwBbs+Y1uekpOhRGJPrLjxGHuzJMoRTh3AQyKCvLkEIR/?=
 =?us-ascii?Q?leOkvhM8Ncd8bpi9fEHRTtnLirSq6NDnnfO8Zym00yHOeDgE3KQcJ4vRS9l4?=
 =?us-ascii?Q?is9Q67HLwe4kj0ddW2Vuc4P6ycRcspz7szP22T4W/xTOAJMAyJrxzhsxsB9T?=
 =?us-ascii?Q?QCDAS3OQPN9gf7MFcH4CzTQ+4pdhcejLAhs33Z0/FbOC247S1kgC2wFvO7cO?=
 =?us-ascii?Q?ud1Sa40DdQnxHU7EfCc8qeJYyCObAnJc4TTBlRRWe26SdhHAKP1hYgiVCRpw?=
 =?us-ascii?Q?7AlHP74qSaPEi+PegzrXv2gzfEtOFU74mVwNFxMcUqULK7DV2IxIXodF3tsT?=
 =?us-ascii?Q?5E89uSHLFCfRdFtFL5f27tnXJg9KUqRxtj1U5+ilAn4maUTswVmieBKICQVH?=
 =?us-ascii?Q?30cxU7sNn8RFRJN6m/i73GKHw2cYd1RFa5H6iBnS96IrpWkAtyGpb1JzpSH1?=
 =?us-ascii?Q?THr6e9w9Ih/N8C4V5mEPBBhkVxw6QfBN19E1ygRG61iWP9o2dglr+RvTrly1?=
 =?us-ascii?Q?CEUMkC/3+ngIMTw5Mo/iqRRS6fdE2W5/f3c8Fm1/MZoMOuDdleyiuWl5f0WO?=
 =?us-ascii?Q?pmTg900Kf26y1k4SPnVSAn2ZnXz6eAsXKsLAZtO33FW4D/gM+z0z3cSmqcxk?=
 =?us-ascii?Q?j0qEuTJEzYAV3u0y/Cx1hvm2tvTWZb+pieASZAmA8y/TNrlmhAcwA++WBoJT?=
 =?us-ascii?Q?sR1C3zgDdmRZDS1FCaer9KjgnkRirL8XcCqmB1FOE3rcHT1whAisAifj5Szk?=
 =?us-ascii?Q?DS3UdyN9BTWnyJl4ZN98E9f7E+E/PnAkRJJKghWN9HESUsjiWuXtqTynZ8Cu?=
 =?us-ascii?Q?dmYYDehMIAKc2K/zaBaGl9PKahvsMWqKpVCxgX5Qhkl53dvFPev7XPPsAhlK?=
 =?us-ascii?Q?wQ7bFD3eict+rqUPl/Ghl21tDvPBaRduX+b1EXwUDeciIy8XUWI20haxBJfZ?=
 =?us-ascii?Q?SVoQgzXY9EE+WQIwy7F9AyvUqz14+iAm/dFd01el5RF6wCJEd3AGgsT1MQu/?=
 =?us-ascii?Q?sZvGc5MnbYHwkEuyFXmBgjLu0TklczD3w3f26NLTYJtcESDwalRa24TRmAIn?=
 =?us-ascii?Q?yc1vREIXfXqYhPUM227U8QBaLhCg4PFk0nWrYcvBIx0VD79bwEr2iNDni2wJ?=
 =?us-ascii?Q?FkKkQElQGE+eZ4MLCMtgl2dMHW3MEXqZodnZmMq9FlCKgU+MZAVd+kq2trsG?=
 =?us-ascii?Q?SSDGI56bHI8MaYZJQFvdSMLfYuYyYG7Z9Ca3KHFz+786b0ejMkHnQ2zUBI9M?=
 =?us-ascii?Q?g4hUDifWGfA+8SxmEZgbc6zEM7Ulzh+T741z8QyIYUdchkQqbmHVieXpVWVi?=
 =?us-ascii?Q?TOXuwgAILgbORD97Mp8IgmK1Dez2+uDKfpH+tMsXfUq6X8RJuwpFcv6xA1A/?=
 =?us-ascii?Q?POcCfLr34fur4gN4nMpJpmDrHFHn3mpGeOlzYvaJhid8RpmGd2dJYm524fqe?=
 =?us-ascii?Q?HMkre0WGzgdJ61yapKXs9Rw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b221d7-ad85-475c-a6d5-08dc41f7bfa0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:10.8510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcP154TOOjsxqE4FN7Z/l7PeTxG+chCs9AmiDDnKzam655hZPcZrSThB0CWle890cw6CA7G66Z2LHdYYByv63+3WXkYG8ieRIF4yaeIJFzQ=
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Note: bdrv_pwrite_zeroes() was removed from the branch where we reallocate
clusters. It's redundant - bdrv_pwrite_zeroes() was already called for all
such clusters.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 45 +++++++++++++--------------------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fd80179642..11b6f97454 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,6 +268,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
                                                       int64_t *clusters)
 {
@@ -279,7 +286,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
@@ -307,31 +314,14 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
         /* Not enough continuous clusters in the middle, adjust the size */
         *clusters = MIN(*clusters, next_used - first_free);
-        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
-
-        /*
-         * No need to preallocate if we are using tail area from the above
-         * branch. In the other case we are likely re-using hole. Preallocate
-         * the space if required by the prealloc_mode.
-         */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
-            if (ret < 0) {
-                return ret;
-            }
-        }
     }
 
     ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
@@ -763,13 +753,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -808,8 +792,6 @@ parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
         return ret;
     }
 
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-
     return leak;
 }
 
@@ -1401,8 +1383,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1435,11 +1416,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+        if (sector + s->tracks > file_nb_sectors) {
+            need_check = true;
+            break;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     ret = parallels_fill_used_bitmap(bs);
     if (ret == -ENOMEM) {
diff --git a/block/parallels.h b/block/parallels.h
index d1e46dcfa8..1d41a59b6f 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.40.1


