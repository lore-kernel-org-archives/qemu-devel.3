Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87346C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlgU-0005U9-Nr; Wed, 19 Aug 2026 15:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgT-0005Tw-DR; Wed, 19 Aug 2026 15:10:45 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgR-0002GX-P5; Wed, 19 Aug 2026 15:10:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70D5543512;
 Wed, 19 Aug 2026 19:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E1B1F000E9;
 Wed, 19 Aug 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787166642;
 bh=b79w992CcGeaFPRTZAWb9+4+Yjxr9UMHRwyVdcYQ+vA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mdhw1ObNmZMUjsauZjXQf+3M9nd1DG1NqEXoC3+nqlRAWuRcLJJye2bXKt7Mkb8aP
 iTQyM+AdDii/5Q9WP79hmG2GlZCY1fVOq54zzt9uvEnzC1qEbjAy3I8OqozJd7DdJ/
 t9GWvvvWlnoi0ur4DsMcYdX+yMEbzOe821OzdCNqV452NZGcAeMCvjsp4oFhkCsFHN
 oM1je1UjY/gNCu1mQtzLbJw4eSRwe8xbYv0U/B8JnMhxApqwf66uNhl5Jm2HECsxwK
 Ec31A8oOj9JxXv/L/2e2U4h9HCazrr7oPRxyXE8xBmng95z89PKX0/ZzFmnSqam9AY
 3f6uIja7uw6pQ==
From: Niklas Cassel <cassel@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtio-blk: check the write granularity of writes to
 sequential zones
Date: Wed, 19 Aug 2026 21:10:31 +0200
Message-ID: <20260819191031.3001633-3-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819191031.3001633-1-cassel@kernel.org>
References: <20260819191031.3001633-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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
a write, against virtio_blk_write_granularity(), so that every request
the device accepts is one that the driver was told is valid. Writes to
conventional zones keep no alignment constraint beyond the logical block
size. The write path performs the check after virtio_blk_sect_range_ok()
so that the zone index derived from the guest supplied sector is known to
be in range.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ef5581c1e6..b1be0e9eda 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -514,7 +514,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     if (append) {
         uint32_t wg = virtio_blk_write_granularity(s);
 
-        if ((offset % wg) != 0) {
+        if ((offset % wg) != 0 || (len % wg) != 0) {
             *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
             return false;
         }
@@ -903,6 +903,28 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
             return 0;
         }
 
+        if (is_write) {
+            BlockDriverState *bs = blk_bs(s->blk);
+            int64_t offset = req->sector_num << BDRV_SECTOR_BITS;
+            uint32_t wg = virtio_blk_write_granularity(s);
+
+            /*
+             * Both the offset and the size of a write to a sequential zone
+             * must be a multiple of the write granularity reported by the
+             * device. Conventional zones are not constrained. The zone index
+             * is derived from a guest supplied sector, so this must come after
+             * virtio_blk_sect_range_ok() has bounded it.
+             */
+            if (bs->bl.zoned != BLK_Z_NONE &&
+                ((offset % wg) != 0 || (req->qiov.size % wg) != 0) &&
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


