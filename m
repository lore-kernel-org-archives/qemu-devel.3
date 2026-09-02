Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3314DC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qtC-0000Q6-HV; Wed, 02 Sep 2026 15:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtA-0000OE-N8; Wed, 02 Sep 2026 15:44:52 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qt8-0005zT-Sy; Wed, 02 Sep 2026 15:44:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8D6A43889;
 Wed,  2 Sep 2026 19:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E221F000E9;
 Wed,  2 Sep 2026 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378288;
 bh=IGcgE/4NFaLV5tyZlvJo73z07UAWAIkatyuzrJ46im0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B6VIqMfpA1U60WS/vEJHfdtweT5EvvhzDWj0A+bi+h4VfxbSiHQmSFrUzPwYTYcb4
 aLWkCT2kgsmWF9dSoah9FmtTNRVvklkvZ/2qvK1aB/YHefkHDDXPGQw470ESfj9baR
 XUqtdxiLUx0koYYs82mNe0LK/1eb45B3mlUCKOe1R8UpA+L9Kooi75nz5rGQcwa5Qy
 Pmv8ogsjiNt6s4U62RA110acPeZRCIOxhLVVK5kv9U3jzhpBB3ULMiJm35sAz7cEHI
 zDffE4ZJ/geBNWnSbd6imxaaVkR5VkEUa4jAN2n47zkqwPioQgstrjOg9+1ZSax6m/
 R+PJTCH0J96GA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] virtio-blk: report the effective zone write
 granularity
Date: Wed,  2 Sep 2026 21:44:14 +0200
Message-ID: <20260902194423.759355-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194423.759355-1-cassel@kernel.org>
References: <20260902194423.759355-1-cassel@kernel.org>
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

For ZBC/ZAC devices the write granularity is the physical block size, so
a 512e SMR disk exposed through a host_device backend has a logical block
size of 512 and a zone write granularity of 4096. We told the guest driver 512
while raw_co_zone_append() rejects anything that is not 4096 byte
aligned, so the driver saw a plain I/O error for a request it had been
told was valid.

Report the larger of the backend granularity and the logical block size
instead. The guest driver cannot issue writes finer than the logical
size, so the larger of the two is the constraint that applies. This
matches what a Linux guest derives for itself: blk_validate_zoned_limits()
raises zone_write_granularity to the logical block size, and
blk_stack_limits() stacks it with max().

Add it as a helper next to blkconf_blocksizes(), since it is derived from
a BlockConf and the limits of the backend below it, and use it for the
zone append offset check in check_zoned_request(), which validated
against bs->bl.write_granularity. The value reported to the driver and
the value that requests are validated against then cannot drift apart.
The helper cannot return zero because blkconf_blocksizes() always leaves
a logical block size behind, so the check no longer needs to guard
against an unset granularity.

Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/block.c         |  7 +++++++
 hw/block/virtio-blk.c    | 13 +++++++------
 include/hw/block/block.h |  8 ++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d..1c3135843d 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -201,6 +201,13 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
     return true;
 }
 
+uint32_t blkconf_zone_write_granularity(BlockConf *conf)
+{
+    BlockDriverState *bs = blk_bs(conf->blk);
+
+    return MAX(bs->bl.write_granularity, conf->logical_block_size);
+}
+
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ffcd327803..b22aed04a1 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -520,11 +520,11 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     }
 
     if (append) {
-        if (bs->bl.write_granularity) {
-            if ((offset % bs->bl.write_granularity) != 0) {
-                *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
-                return false;
-            }
+        uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
+
+        if (offset & wg_mask) {
+            *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
+            return false;
         }
 
         index = offset / bs->bl.zone_size;
@@ -1274,7 +1274,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
                      bs->bl.max_active_zones);
         virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
                      bs->bl.max_open_zones);
-        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
+        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
+                     blkconf_zone_write_granularity(conf));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
                      bs->bl.max_append_sectors);
     } else {
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f..f98525c01a 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -114,6 +114,14 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 bool blkconf_blocksizes(BlockConf *conf, Error **errp);
+/*
+ * The alignment constraint that applies to writes to a sequential zone. The
+ * medium may require a coarser granularity than the logical block size, while
+ * a guest cannot issue writes finer than the logical block size, so the
+ * constraint that applies is the larger of the two. A frontend must report this
+ * value to its guest and validate requests against it.
+ */
+uint32_t blkconf_zone_write_granularity(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
-- 
2.55.0


