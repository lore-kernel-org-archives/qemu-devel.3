Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE82C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qtF-0000Sw-Gg; Wed, 02 Sep 2026 15:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtD-0000RO-J1; Wed, 02 Sep 2026 15:44:55 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtB-0005zN-Te; Wed, 02 Sep 2026 15:44:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 251B3601EF;
 Wed,  2 Sep 2026 19:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C816D1F000E9;
 Wed,  2 Sep 2026 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378285;
 bh=TFg7avD/j58roO41WzcRhKlbi6ueX70eH3NQ2e75uBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G8/8s3SUAnKS2Np3hrA/o6z+mooDhcO0H5Wo9qkXWcvvNpbYTsI6/CIwu1xxj1HFg
 jOJMCLNdG2SrtpzUmsUl3SJsUIyTpp7w+L644gmp3g7lSMpvJGnbnr/g7Dl0rSS0BS
 W9haK+UbQ/p7Al9EqEK4ZtYNTH5eAhDXg9qjTVooYVAIFO+UakxMgosbVZOE4ep5T9
 R5XNk4innzBL3LlbvDl3mwby9GFnMH2LQEJ4QKy9lUvnryZz4aJQ784Fgbi1BSb5ev
 P4I5VH/OOF6WSYox+P8MTk3bwSiqSzCUjWqqEenhaDX5AdZmsT1P/1Ly6HNJTwG2Jq
 wZchvnIqQxOnA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] virtio-blk: do not merge requests across a zone
 boundary
Date: Wed,  2 Sep 2026 21:44:13 +0200
Message-ID: <20260902194423.759355-3-cassel@kernel.org>
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

From: Sam Li <faithilikerun@gmail.com>

virtio_blk_submit_multireq() fuses adjacent in-zone requests into a
single request. On a zoned backend, a merged zone append request
that straddles a zone boundary is rejected by the device because
each write/read must stay within a single zone (virtio 1.4, 5.2.6.1).

Add a bail condition to the merge coalescer: if combining the
candidate request into the current batch would cross a zone
boundary, flush the current batch and start a new one.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/block-backend.c             | 11 +++++++++++
 hw/block/virtio-blk.c             | 22 +++++++++++++++++++++-
 include/system/block-backend-io.h |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..049e70ddcb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2326,6 +2326,17 @@ uint32_t blk_get_request_alignment(BlockBackend *blk)
     return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
 }
 
+/*
+ * Returns the zone size in bytes for a zoned backend, or 0 if @blk does
+ * not present zoned geometry.
+ */
+uint64_t blk_get_zone_size(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zone_size : 0;
+}
+
 /* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..ffcd327803 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -294,6 +294,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
     int i = 0, start = 0, num_reqs = 0, niov = 0, nb_sectors = 0;
     uint32_t max_transfer;
     int64_t sector_num = 0;
+    uint64_t zone_size = blk_get_zone_size(s->blk);
+    bool zone_cross;
+    int64_t zone_nr_sectors, end_sector;
 
     if (mrb->num_reqs == 1) {
         submit_requests(s, mrb, 0, 1, -1);
@@ -309,17 +312,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
     for (i = 0; i < mrb->num_reqs; i++) {
         VirtIOBlockReq *req = mrb->reqs[i];
         if (num_reqs > 0) {
+            /*
+             * On zoned backends, a single backend write/read must not span
+             * a zone boundary. Bail out of merging if combining req into
+             * the current batch would straddle a zone.
+             */
+            if (zone_size > 0) {
+                zone_nr_sectors = zone_size / BDRV_SECTOR_SIZE;
+                end_sector = req->sector_num
+                                + req->qiov.size / BDRV_SECTOR_SIZE - 1;
+                zone_cross = (sector_num / zone_nr_sectors) !=
+                             (end_sector / zone_nr_sectors);
+            } else {
+                zone_cross = false;
+            }
+
             /*
              * NOTE: We cannot merge the requests in below situations:
              * 1. requests are not sequential
              * 2. merge would exceed maximum number of IOVs
              * 3. merge would exceed maximum transfer length of backend device
+             * 4. merge would cross a zone boundary on a zoned backend
              */
             if (sector_num + nb_sectors != req->sector_num ||
                 niov > blk_get_max_iov(s->blk) - req->qiov.niov ||
                 req->qiov.size > max_transfer ||
                 nb_sectors > (max_transfer -
-                              req->qiov.size) / BDRV_SECTOR_SIZE) {
+                              req->qiov.size) / BDRV_SECTOR_SIZE ||
+                zone_cross) {
                 submit_requests(s, mrb, start, num_reqs, niov);
                 num_reqs = 0;
             }
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index fd84723d9d..78d410b8df 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -121,6 +121,7 @@ uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 uint64_t blk_get_max_hw_transfer(BlockBackend *blk);
+uint64_t blk_get_zone_size(BlockBackend *blk);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-- 
2.55.0


