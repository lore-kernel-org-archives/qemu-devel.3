Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BAFC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XDM-0003zc-6u; Mon, 07 Sep 2026 07:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XDD-0003bh-Ka; Mon, 07 Sep 2026 07:08:33 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XDB-0003ys-Uc; Mon, 07 Sep 2026 07:08:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7A47435B4;
 Mon,  7 Sep 2026 11:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B281F00A3A;
 Mon,  7 Sep 2026 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788779308;
 bh=ZPierz8DjsI6hbxFJ1qeP847aE7YBpeXin+QKb0us7U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NIpX9SrCdEuoJXgnp9qJjOYiq4KqIKOrFhrNT/1Bzu9lNm82ANrp0An0I0jlT5SPC
 wC3skSnhQYVq717QPsMSRr5sy+XcmG1OJv/5vwRV/nk1MzbbDbsKk2nFxxcNaeEvW9
 FtOSSPrPhohp6pS99/JShJD42WLg3QakhdXZbUe5sftekzMaEEiIkZvcff0fVg6njG
 2gaLW+4O8g9jt08zn4Eyz2uU/YaoUW3/JyK+MouZr3ra8Db5ukUC9YHD6KVTxCAD+p
 eaHeY+MEaLEvwFHMw056th4tRojUGZ/sn7RAOEUJBaPacxbEyOUNri7j6uzbKr5Wj4
 Rl3QzjT3JMi0g==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 05/12] virtio-blk: check the write granularity of writes to
 sequential zones
Date: Mon,  7 Sep 2026 13:07:40 +0200
Message-ID: <20260907110748.1868714-6-cassel@kernel.org>
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f6781ff5f6..7d5a02a42c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -398,6 +398,33 @@ static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
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
+    if (BDRV_ZT_IS_CONV(bs->wps->wp[bdrv_zone_index(bs, offset)])) {
+        return true;
+    }
+
+    wg_mask = blkconf_zone_write_granularity(&dev->conf.conf) - 1;
+
+    return !(offset & wg_mask) && !(size & wg_mask);
+}
+
 static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
     struct virtio_blk_discard_write_zeroes *dwz_hdr, bool is_write_zeroes)
 {
@@ -522,7 +549,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     if (append) {
         uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
 
-        if (offset & wg_mask) {
+        if (offset & wg_mask || len & wg_mask) {
             *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
             return false;
         }
@@ -911,6 +938,15 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
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


