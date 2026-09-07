Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A324C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XDM-00042L-Ow; Mon, 07 Sep 2026 07:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XD9-0003Wq-Mx; Mon, 07 Sep 2026 07:08:29 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XD6-0003y0-Ug; Mon, 07 Sep 2026 07:08:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A117435B4;
 Mon,  7 Sep 2026 11:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5531F00A3A;
 Mon,  7 Sep 2026 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788779303;
 bh=OfjAfqnyMbUKZnnlNkzGTRWbiHUY6gTAovq7xR0CVXA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F3eAImLIUaWNPRGjWbGc3OpMYMI5JcUkmX1PpvgnE3mNtuv7AryEVEqSnrOrOJv7J
 hemo5cv0xFIfcBoxBm1Gg5ovcnDyi1PtOPQ4SlRoRZzJJrUweuUiORbN5F5JPiNC8t
 jaBh9n+QoUwYN6fWqBv+0L7C7OzAhLympeOAhPHchwj63+NCW2/hODQGuJmdPCRsYz
 +cvzidc2szv2NT3LwOge7JAkE+ZjYhKuiujDkcZTqZdGciuBox/S5/5Bi3BGkZ+YGq
 odNoiFdSp595pGWkmQ0hz7MMKo5NXytOjBgEqgf8Es4fR1wj9QIHLIpo8EOnY6OMzN
 LpRhMR71iC+JQ==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 03/12] block: add a helper for the index of the zone an
 offset falls in
Date: Mon,  7 Sep 2026 13:07:38 +0200
Message-ID: <20260907110748.1868714-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907110748.1868714-1-cassel@kernel.org>
References: <20260907110748.1868714-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Deriving the zone that an offset belongs to is open coded in five places,
in two files, as a division of the offset by BlockLimits.zone_size.

The zone size of a zoned device is always a power of two. Linux requires
that of every zoned device it accepts, in blk_revalidate_disk_zones() and
in each of the drivers that report one, and qcow2 rejects an image whose
header says otherwise. So the division is a shift, and the shift is worth
deriving once rather than at every use: record it in BlockLimits as
zone_size_bits, next to the size it comes from, and assert the property
that it relies on where it is computed.

Add bdrv_zone_index() and use it. No functional change; the count of zones
that a management operation spans stays a division, since it is a length
rather than an offset.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c               |  8 ++++----
 block/io.c                       | 12 ++++++++++++
 hw/block/virtio-blk.c            |  2 +-
 include/block/block-io.h         |  2 ++
 include/block/block_int-common.h |  7 +++++++
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c0d6ee30e4..00323f7a9f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1359,7 +1359,7 @@ static int get_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
     size_t rep_size;
     uint64_t sector = offset >> BDRV_SECTOR_BITS;
     BlockZoneWps *wps = bs->wps;
-    unsigned int j = offset / bs->bl.zone_size;
+    unsigned int j = bdrv_zone_index(bs, offset);
     unsigned int n = 0, i = 0;
     int ret;
     rep_size = sizeof(struct blk_zone_report) + nrz * sizeof(struct blk_zone);
@@ -2560,7 +2560,7 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
         bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
+            int index = bdrv_zone_index(bs, offset);
             offset = bs->wps->wp[index];
         }
     }
@@ -2615,7 +2615,7 @@ out:
         bs->bl.zoned != BLK_Z_NONE) {
         BlockZoneWps *wps = bs->wps;
         if (ret == 0) {
-            uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
+            uint64_t *wp = &wps->wp[bdrv_zone_index(bs, offset)];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
                     *offset_ptr = *wp;
@@ -3513,7 +3513,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
         return -EINVAL;
     }
 
-    uint32_t i = offset / bs->bl.zone_size;
+    uint32_t i = bdrv_zone_index(bs, offset);
     uint32_t nrz = len / bs->bl.zone_size;
     uint64_t *wp = &wps->wp[i];
     if (BDRV_ZT_IS_CONV(*wp) && len != capacity) {
diff --git a/block/io.c b/block/io.c
index a916b236c3..cef23ee5bc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -227,6 +227,11 @@ void bdrv_refresh_limits(BlockDriverState *bs, Transaction *tran, Error **errp)
         }
     }
 
+    if (bs->bl.zone_size) {
+        assert(is_power_of_2(bs->bl.zone_size));
+        bs->bl.zone_size_bits = ctz64(bs->bl.zone_size);
+    }
+
     if (bs->bl.request_alignment > BDRV_MAX_ALIGNMENT) {
         error_setg(errp, "Driver requires too large request alignment");
     }
@@ -3361,6 +3366,13 @@ out:
     return co.ret;
 }
 
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
+{
+    IO_CODE();
+
+    return offset >> bs->bl.zone_size_bits;
+}
+
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
 {
     IO_CODE();
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ffcd327803..8c5b87793e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -527,7 +527,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
             }
         }
 
-        index = offset / bs->bl.zone_size;
+        index = bdrv_zone_index(bs, offset);
         if (BDRV_ZT_IS_CONV(bs->wps->wp[index])) {
             *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
             return false;
diff --git a/include/block/block-io.h b/include/block/block-io.h
index d34d846bb2..9d1c0eb7fb 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -126,6 +126,8 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   int64_t *offset,
                                                   QEMUIOVector *qiov,
                                                   BdrvRequestFlags flags);
+/* The index of the zone that @offset falls in. */
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 7571ed9968..82aa0c1a6e 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -903,6 +903,13 @@ typedef struct BlockLimits {
     /* zone size expressed in bytes */
     uint64_t zone_size;
 
+    /*
+     * log2 of zone_size, derived by bdrv_refresh_limits(). A zoned device
+     * always has a zone size that is a power of two, so the zone an offset
+     * falls in is a shift rather than a division. See bdrv_zone_index().
+     */
+    uint32_t zone_size_bits;
+
     /* total number of zones */
     uint32_t nr_zones;
 
-- 
2.55.0


