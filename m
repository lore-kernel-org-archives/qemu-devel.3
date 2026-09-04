Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE2C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WcO-0000Vg-Vq; Fri, 04 Sep 2026 12:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcN-0000VQ-KI; Fri, 04 Sep 2026 12:18:19 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcL-0001KG-W6; Fri, 04 Sep 2026 12:18:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03B476020A;
 Fri,  4 Sep 2026 16:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E561F00A3D;
 Fri,  4 Sep 2026 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788538696;
 bh=Vl9F/hDoAxFJfb47pT+Ws99N4unPk5C+HlgiMxsOiQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X3W/Er0HCxeS+l7eI9EuefqoKKov/Vmd+bU6LioTdFydqWbcQN7qf7EGgLGoLhbJ/
 xijl0pWl98NROaM51FIhGnJF34AdbPVCdABGfBY7P+atzpKdr2pEwQUd5zItiy/FRa
 oGaPWytSr9ntTpAaSTuvGcZ2FVaPSedyPf/+QmZZa0hxXKBpFAOk9IVled+6cwwTtn
 ZhSzzgkFZaY1s+piiVQDZReUm8bWDoz12p93cCZkVWk14SK+9Cg+Uhibi002QQ/SQq
 Fcnrn4uDjnaGaquaKgESBnaB1TCDsPvxFRMClXKG/u5axJyYrOjymGTaWEBt59sMKg
 lHhN/k6v8A4FA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] block: add a helper for the index of the zone an
 offset falls in
Date: Fri,  4 Sep 2026 18:17:51 +0200
Message-ID: <20260904161801.1568841-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904161801.1568841-1-cassel@kernel.org>
References: <20260904161801.1568841-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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
in two files, as a division of the offset by BlockLimits.zone_size. The
zone size of a zoned device is always a power of two, which Linux requires
of every device it accepts, so the division is a shift.

Add bdrv_zone_index() and use it. No functional change; the count of zones
that a management operation spans stays a division, since it is a length
rather than an offset.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c       | 8 ++++----
 block/io.c               | 7 +++++++
 hw/block/virtio-blk.c    | 2 +-
 include/block/block-io.h | 5 +++++
 4 files changed, 17 insertions(+), 5 deletions(-)

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
index a916b236c3..497247b684 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3361,6 +3361,13 @@ out:
     return co.ret;
 }
 
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
+{
+    IO_CODE();
+
+    return offset >> ctz64(bs->bl.zone_size);
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
index d34d846bb2..71c8cdf2e1 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -126,6 +126,11 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   int64_t *offset,
                                                   QEMUIOVector *qiov,
                                                   BdrvRequestFlags flags);
+/*
+ * The index of the zone that @offset falls in. A zoned device always has a
+ * zone size that is a power of two, so the division is a shift.
+ */
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
-- 
2.55.0


