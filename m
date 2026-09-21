Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48C1C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2C-0002yM-8r; Mon, 21 Sep 2026 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0p-0001wk-Ua; Mon, 21 Sep 2026 10:29:01 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0l-00008C-M0; Mon, 21 Sep 2026 10:28:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65F1843C33;
 Mon, 21 Sep 2026 14:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A341F00898;
 Mon, 21 Sep 2026 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000930;
 bh=BaGydPCSUAeNb0eWyHPI3N0R/c7Ye/3rI6LSXHt3/po=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L7qfATPe5BbDxhSN8gK04Nz9j++muofh+WKHGEGkG+aTRo5tJ++888mo1Sl1Uq9EB
 FkjqA4MgMoM5hluoeYhqav0KFNXpPWvZ62+OXhtnwMp0fFDY5pUNL2R01DOpnj5Ps8
 ncZerkQQEsess/7seQanlRcG3ikbi6z+naBwfLzKbyFI3VAwHo14TLEWvIcPZmI2d5
 sbGE8vvUNMZ+OJc1by8OHPmG0SDkYS331XVQaghVvBNu5g9OIvOiPhzTBYdau/LEUn
 tCMj5VjGyf5G7O9ge8gI4fYJFpYjUNlOwDEi9TGhq7ToigAo5RmoMVeRqbWSDqDFx2
 +8jF2P5cEybBg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 05/15] hw/block: derive the zone write granularity from the
 block sizes
Date: Mon, 21 Sep 2026 16:28:07 +0200
Message-ID: <20260921142819.2916043-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
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

For ZBC/ZAC devices the write granularity is the physical block size, so
a 512e SMR disk exposed through a host_device backend has a logical block
size of 512 and a zone write granularity of 4096. We told the guest
driver 512 while raw_co_zone_append() rejects anything that is not 4096
byte aligned, so the driver saw a plain I/O error for a request it had
been told was valid.

Report the larger of the logical and the physical block size instead.
Both are properties of the device model, so the value that a guest is
given does not change when it is migrated to a host whose disks differ,
which a value taken from BlockLimits would. It is also what a guest
derives for itself: blk_validate_zoned_limits() raises
zone_write_granularity to the logical block size, and for a SCSI disk
sd_zbc_read_zones() takes it from the physical block size.

blkconf_blocksizes() rejects a logical block size larger than the
physical block size, so this is the physical block size in practice. It
is expressed as the larger of the two because that is the constraint
which applies: a guest cannot issue a write finer than the logical block
size, and the medium cannot take one finer than the physical block size.

Add it as a helper next to blkconf_blocksizes(), since it is derived from
a BlockConf, and use it for the zone append offset check in
check_zoned_request(), which validated against bs->bl.write_granularity.
The value reported to the driver and the value that requests are
validated against then cannot drift apart. The helper cannot return zero
because blkconf_blocksizes() always leaves a logical block size behind,
so the check no longer needs to guard against an unset granularity.

Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/block.c                 |  5 +++++
 hw/block/virtio-blk.c            | 13 +++++++------
 include/block/block_int-common.h |  7 +++++++
 include/hw/block/block.h         | 13 +++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d..79b0a67cea 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -201,6 +201,11 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
     return true;
 }
 
+uint32_t blkconf_zone_write_granularity(BlockConf *conf)
+{
+    return MAX(conf->logical_block_size, conf->physical_block_size);
+}
+
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index dd69d81532..6bf1049aea 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -516,11 +516,11 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
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
 
         index = bdrv_zone_index(bs, offset);
@@ -1276,7 +1276,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
                      bs->bl.max_active_zones);
         virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
                      bs->bl.max_open_zones);
-        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
+        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
+                     blkconf_zone_write_granularity(conf));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
                      bs->bl.max_append_sectors);
     } else {
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 82aa0c1a6e..7abd2b12bb 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -922,6 +922,13 @@ typedef struct BlockLimits {
     /* maximum number of active zones */
     uint32_t max_active_zones;
 
+    /*
+     * The granularity that the backend requires of a write to a sequential
+     * zone, in bytes, or zero if it has none. This describes the host, so it
+     * must not be reported to a guest: a frontend reports
+     * blkconf_zone_write_granularity() and checks this against it when the
+     * device is realized.
+     */
     uint32_t write_granularity;
 } BlockLimits;
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f..c769b1297d 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -114,6 +114,19 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 bool blkconf_blocksizes(BlockConf *conf, Error **errp);
+/*
+ * The alignment constraint that applies to writes to a sequential zone. A guest
+ * cannot issue a write finer than the logical block size, and the medium cannot
+ * take one finer than the physical block size, so the constraint that applies
+ * is the larger of the two. A frontend must report this value to its guest and
+ * validate requests against it.
+ *
+ * It is derived from the configuration and not from the backend, so that a
+ * guest is not given a property of the host, which would differ after
+ * migration. blkconf_blocksizes() rejects a logical block size larger than the
+ * physical block size, so this is the physical block size in practice.
+ */
+uint32_t blkconf_zone_write_granularity(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
-- 
2.55.0


