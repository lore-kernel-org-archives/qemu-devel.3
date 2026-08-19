Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE1C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlgS-0005TI-OO; Wed, 19 Aug 2026 15:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgR-0005St-JJ; Wed, 19 Aug 2026 15:10:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgQ-0002G7-24; Wed, 19 Aug 2026 15:10:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31DA861834;
 Wed, 19 Aug 2026 19:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D581F000E9;
 Wed, 19 Aug 2026 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787166639;
 bh=QPxqmF6HxpLantW710NlQtv2E0xlp2I9cy+oJ74aQEA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dzFAj38KvL9dAy9tN6rzRd/9NE0xZPUA/7rjM1YzJByhHtl92r30A+wLPHNs7exX4
 XQiplp3qhbH/1lRfYZk5uUbB/fxXs6zKSzu2zcSdEtJ1pWkp1y/uXyfqHoM9S7+gG7
 I8EGc2uk3EzUFQio5w1PoLHo5H3p1x8ZMI/M5Wn2u5GXQ8ICE+wrDzihcmyOTzQKHv
 SLVauVCbNUH2ghQFW5SFikytD3F483ohdlz3dPU4L2RgP3JkCFqbRVf7ppcwgzDJ5f
 /M/L1LQrOgphEbqrhXlMwHPVqqpm5kNyWOniZ0ue8KOM/u7uFCLXJa1YpK5jSycB0B
 GG8xRYKiS4I9w==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtio-blk: report the effective zone write granularity
Date: Wed, 19 Aug 2026 21:10:30 +0200
Message-ID: <20260819191031.3001633-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819191031.3001633-1-cassel@kernel.org>
References: <20260819191031.3001633-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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

For ZBC/ZAC devices the write granularity is the physical block size, so
a 512e SMR disk exposed through a host_device backend has a logical block
size of 512 and a zone write granularity of 4096. We told the driver 512
while raw_co_zone_append() rejects anything that is not 4096 byte
aligned, so the driver saw a plain I/O error for a request it had been
told was valid.

Report the larger of the backend granularity and the logical block size
instead. The driver cannot issue writes finer than the logical block
size, so the larger of the two is the constraint that applies. This
matches what a Linux guest derives for itself: blk_validate_zoned_limits()
raises zone_write_granularity to the logical block size, and
blk_stack_limits() stacks it with max().

Add it as a helper and use it for the zone append offset check in
check_zoned_request(), which validated against bs->bl.write_granularity,
so that the value reported to the driver and the value that requests are
validated against cannot drift apart. The helper cannot return zero
because blkconf_blocksizes() always leaves a logical block size behind,
so the check no longer needs to guard against an unset granularity.

Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..ef5581c1e6 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -478,6 +478,18 @@ typedef struct ZoneCmdData {
     };
 } ZoneCmdData;
 
+/*
+ * The write granularity that the device reports to the driver in
+ * virtio_blk_zoned_characteristics: the offset and size alignment constraint
+ * for writes and zone appends to sequential zones.
+ */
+static uint32_t virtio_blk_write_granularity(VirtIOBlock *s)
+{
+    BlockDriverState *bs = blk_bs(s->blk);
+
+    return MAX(bs->bl.write_granularity, s->conf.conf.logical_block_size);
+}
+
 /*
  * check zoned_request: error checking before issuing requests. If all checks
  * passed, return true.
@@ -500,11 +512,11 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     }
 
     if (append) {
-        if (bs->bl.write_granularity) {
-            if ((offset % bs->bl.write_granularity) != 0) {
-                *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
-                return false;
-            }
+        uint32_t wg = virtio_blk_write_granularity(s);
+
+        if ((offset % wg) != 0) {
+            *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
+            return false;
         }
 
         index = offset / bs->bl.zone_size;
@@ -1254,7 +1266,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
                      bs->bl.max_active_zones);
         virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
                      bs->bl.max_open_zones);
-        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
+        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
+                     virtio_blk_write_granularity(s));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
                      bs->bl.max_append_sectors);
     } else {
-- 
2.55.0


