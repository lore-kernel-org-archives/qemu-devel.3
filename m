Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCEC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyDt-0001BK-Fx; Tue, 25 Aug 2026 16:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDp-00019X-19; Tue, 25 Aug 2026 16:58:17 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDl-0003DO-Lm; Tue, 25 Aug 2026 16:58:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A26BB41998;
 Tue, 25 Aug 2026 20:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999AD1F000E9;
 Tue, 25 Aug 2026 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691490;
 bh=kyDnXcRIvbvgWddM5UPAmFcXBgLEVAb4H2IEpb22gDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fUDstn6UDGNxeW3xpslXABi5upFOVzIoJl+uShPW2YXBzBfXTL6Y06amvVp2PFDk6
 Jcq04s6Ysr7VJGnAfLyEWQr+Is9+XfeJU6ElmbwaBLkW9cb8hgGreE3dZ349QIbJg7
 Tum1Lm8s/qTbj0qSmlufobCltJiZacWIV2rlM8vtSYQ4kkvVcWSzRm5ptFD0kTsegY
 hCFEZ8yrdD/KxPat61548oWI/fL7N2sSeBjkBreyYEMh2rkK3H89ygrav8V7bsWVlJ
 +ov6KfEd4hmIuRB/oDC394fUTpZMfEZhdoLHng69ucmwn7pCQwgdxngQTOw3pYcSk1
 CbvJDXZU0CS1w==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 05/12] virtio-blk: check the write granularity of writes to
 sequential zones
Date: Tue, 25 Aug 2026 22:57:40 +0200
Message-ID: <20260825205748.679968-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825205748.679968-1-cassel@kernel.org>
References: <20260825205748.679968-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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
 hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f8cda1baa7..7977f4abe5 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -522,7 +522,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     if (append) {
         uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
 
-        if (offset & wg_mask) {
+        if (offset & wg_mask || len & wg_mask) {
             *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
             return false;
         }
@@ -911,6 +911,29 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
             return 0;
         }
 
+        if (is_write) {
+            BlockDriverState *bs = blk_bs(s->blk);
+            int64_t offset = req->sector_num << BDRV_SECTOR_BITS;
+            uint32_t wg_mask =
+                blkconf_zone_write_granularity(&s->conf.conf) - 1;
+
+            /*
+             * Both the offset and the size of a write to a sequential zone
+             * must be a multiple of the write granularity reported by the
+             * device. Conventional zones are not constrained. The zone index
+             * is derived from a guest supplied sector, so this must come after
+             * virtio_blk_sect_range_ok() has bounded it.
+             */
+            if (bs->bl.zoned != BLK_Z_NONE &&
+                (offset & wg_mask || req->qiov.size & wg_mask) &&
+                !BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size])) {
+                virtio_blk_req_complete(req, VIRTIO_BLK_S_ZONE_UNALIGNED_WP);
+                block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
+                g_free(req);
+                return 0;
+            }
+        }
+
         block_acct_start(blk_get_stats(s->blk), &req->acct, req->qiov.size,
                          is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
 
-- 
2.55.0


