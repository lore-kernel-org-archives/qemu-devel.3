Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3DBC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qtE-0000So-Um; Wed, 02 Sep 2026 15:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtD-0000QG-7T; Wed, 02 Sep 2026 15:44:55 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtB-0005zr-Hc; Wed, 02 Sep 2026 15:44:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC0BA600D1;
 Wed,  2 Sep 2026 19:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA431F000E9;
 Wed,  2 Sep 2026 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378291;
 bh=2YJPuwHYqNlX6D6HFRPrMD9ckno5hSCVxl5z3aaycTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K5sC+B8py39Q0xoaWvih8E05Wmm7XcxcFd1FOyj3XdcuZUQAe/405TISX3dIgG9lR
 2yZA70qdn2WzLUo/4LdedYs3sE9MfQLUeSg9QCNouXDTtLa631iuv296071puiaGmZ
 /FM43djkIWzG36uR72UOOQ8xNi1T3cDO5YGyZFrx1x/4nQFJR9wPScl9iMi2Ynca6O
 8ATW4WeO20uKe3y4tjDfJonqKC4fcxMUr4+w2snP3QKeKj6LJ/nzr2CjKDe6DqMAJk
 /BnoLmVu/JAyZfVcD/eBpvBi7jB6ujVhQsQg7/fZP6jh5CC9fTHAdgiROkV3wR/Qck
 ULKnO70Yd2Iuw==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] virtio-blk: check the write granularity of writes to
 sequential zones
Date: Wed,  2 Sep 2026 21:44:15 +0200
Message-ID: <20260902194423.759355-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194423.759355-1-cassel@kernel.org>
References: <20260902194423.759355-1-cassel@kernel.org>
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

All VIRTIO_BLK_T_OUT requests issued to sequential zones and all
VIRTIO_BLK_T_ZONE_APPEND requests must have an offset and a data size
that are multiples of the write granularity reported by the device
(virtio 1.4, 5.2.6.1), and a violation is reported as
VIRTIO_BLK_S_ZONE_UNALIGNED_WP (virtio 1.4, 5.2.6).

Neither request type was fully checked. Zone appends validated only the
offset, while writes were not checked at all.

Check the size of the appended data, and both the offset and the size of
a write, against blkconf_zone_write_granularity(), so that every request the
device accepts is one that the guest driver was told is valid. Writes to
conventional zones keep no alignment constraint beyond the logical block
size. The write path performs the check after virtio_blk_sect_range_ok()
so that the zone index derived from the guest supplied sector is known to
be in range.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b22aed04a1..247af53ae2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -398,6 +398,32 @@ static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
     return true;
 }
 
+/*
+ * Both the offset and the size of a write to a sequential zone must be a
+ * multiple of the write granularity that the device reports. Conventional
+ * zones are not constrained. The zone index is derived from a guest supplied
+ * sector, so this must only be called once virtio_blk_sect_range_ok() has
+ * bounded it.
+ */
+static bool virtio_blk_zone_write_granularity_ok(VirtIOBlock *dev,
+                                                 uint64_t sector, size_t size)
+{
+    BlockDriverState *bs = blk_bs(dev->blk);
+    uint64_t offset = sector << BDRV_SECTOR_BITS;
+    uint32_t wg_mask;
+
+    if (bs->bl.zoned == BLK_Z_NONE) {
+        return true;
+    }
+
+    wg_mask = blkconf_zone_write_granularity(&dev->conf.conf) - 1;
+    if (!(offset & wg_mask) && !(size & wg_mask)) {
+        return true;
+    }
+
+    return BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size]);
+}
+
 static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
     struct virtio_blk_discard_write_zeroes *dwz_hdr, bool is_write_zeroes)
 {
@@ -522,7 +548,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     if (append) {
         uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
 
-        if (offset & wg_mask) {
+        if (offset & wg_mask || len & wg_mask) {
             *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
             return false;
         }
@@ -911,6 +937,15 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
             return 0;
         }
 
+        if (is_write &&
+            !virtio_blk_zone_write_granularity_ok(s, req->sector_num,
+                                                  req->qiov.size)) {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_ZONE_UNALIGNED_WP);
+            block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
+            g_free(req);
+            return 0;
+        }
+
         block_acct_start(blk_get_stats(s->blk), &req->acct, req->qiov.size,
                          is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
 
-- 
2.55.0


