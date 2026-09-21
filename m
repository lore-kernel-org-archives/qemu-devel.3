Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31378C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2T-00049Y-RS; Mon, 21 Sep 2026 10:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f18-00023f-2F; Mon, 21 Sep 2026 10:29:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f11-0000LV-B9; Mon, 21 Sep 2026 10:29:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C453601F0;
 Mon, 21 Sep 2026 14:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF571F000FF;
 Mon, 21 Sep 2026 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000946;
 bh=x6bE+olBOh1kMqLDv9SDGWtLLE/Wqq+0hgO1K5YKxWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FQW6bSiU21yrWGYEFrVBLSsp/N2CZHJHemLqAAATNRpyi7T36i5riNpLRi3CoYNXH
 PmgHDc3bqiXbA9mEb4FUV/9u0x7eTg8dD/qKeu/IQXTlPFXUCqG2+sBemGFDHMR6nC
 N/lZWcL/WCbtnTcl9QMB+C4gDRMSVWPs68Cltu/BtuGAixOy5gyH0/H10s8vgik1iJ
 JxEVfG8uiYLcWQ/sYRdvbsVsu2VkIdTLAPk10URtFzGooK/z+L8IKDWrIgNSGUgGke
 38PfbbDYiwuKsejkBhQByRdln2VLTNBkfPvlqpkWOeCkFccS1h6MghLcp6sqajmOKS
 9h+v+sCyR2Arg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 11/15] virtio-blk: add a max-append-sectors property
Date: Mon, 21 Sep 2026 16:28:13 +0200
Message-ID: <20260921142819.2916043-12-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
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

The maximum zone append size that the device reports to its driver was
taken from BlockLimits.max_append_sectors, a limit of the host disk that
the backend happens to sit on. A guest reads it out of the configuration
space, so it becomes part of what the guest has been told about its
device, and migrating that guest to a host whose disks report something
smaller leaves it appending more than the device accepts.

Make it a property, as max-discard-sectors and max-write-zeroes-sectors
already are, so that the value a guest is given is part of the device
model and does not change under it. Nothing from BlockLimits reaches the
configuration space any more.

Zero is a valid value here, unlike for those two. There is no feature bit
for zone append, and a maximum of zero is how the specification has a
device say that it does not support the operation (virtio 1.4, 5.2.5.2).
It is also what a ZBC or ZAC disk is: such a disk has no zone append
command at all, and Linux emulates one in its block layer.

What is reported is capped by the size of a zone. The specification asks
for the largest append that can be carried out, and one larger than a
zone never can be, so the default would otherwise advertise a size that
the block layer refuses. The cap tells a guest nothing about the host
that zone_sectors has not already told it.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c          | 67 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-blk.h |  1 +
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 74bd08b0ec..536d71a91a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -521,6 +521,24 @@ typedef struct ZoneCmdData {
     };
 } ZoneCmdData;
 
+/*
+ * The maximum zone append size that the device reports to its driver, in 512
+ * byte sectors.
+ *
+ * An append cannot cross a zone boundary, so the configured maximum is capped
+ * by the size of a zone: the specification asks for the largest append that
+ * can be carried out, and a larger one never can be. The zone size is already
+ * reported to the driver as zone_sectors, so this tells it nothing new about
+ * the host.
+ */
+static uint32_t virtio_blk_max_append_sectors(VirtIOBlock *s)
+{
+    BlockDriverState *bs = blk_bs(s->blk);
+
+    return MIN(s->conf.max_append_sectors,
+               bs->bl.zone_size >> BDRV_SECTOR_BITS);
+}
+
 /*
  * check zoned_request: error checking before issuing requests. If all checks
  * passed, return true.
@@ -556,12 +574,13 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
             return false;
         }
 
-        if (len / 512 > bs->bl.max_append_sectors) {
-            if (bs->bl.max_append_sectors == 0) {
-                *status = VIRTIO_BLK_S_UNSUPP;
-            } else {
-                *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
-            }
+        if (!s->conf.max_append_sectors) {
+            *status = VIRTIO_BLK_S_UNSUPP;
+            return false;
+        }
+
+        if ((len >> BDRV_SECTOR_BITS) > virtio_blk_max_append_sectors(s)) {
+            *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
             return false;
         }
     }
@@ -1315,7 +1334,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
         virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
                      blkconf_zone_write_granularity(conf));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
-                     bs->bl.max_append_sectors);
+                     virtio_blk_max_append_sectors(s));
     } else {
         blkcfg.zoned.model = VIRTIO_BLK_Z_NONE;
     }
@@ -1852,6 +1871,34 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_ZONED)) {
+        uint32_t wg = blkconf_zone_write_granularity(&conf->conf);
+
+        /*
+         * Checked before the granularity below, so that a driver can shift the
+         * value that it reads into a byte count without overflowing.
+         */
+        if (conf->max_append_sectors > BDRV_REQUEST_MAX_SECTORS) {
+            error_setg(errp, "invalid max-append-sectors property (%" PRIu32
+                       "), must not exceed %d", conf->max_append_sectors,
+                       (int)BDRV_REQUEST_MAX_SECTORS);
+            return;
+        }
+
+        /*
+         * Zero is allowed, and says that zone append is not supported, which
+         * is what a ZBC or ZAC disk is. Anything else has to be able to
+         * express a single write.
+         */
+        if (conf->max_append_sectors &&
+            (conf->max_append_sectors << BDRV_SECTOR_BITS) < wg) {
+            error_setg(errp, "invalid max-append-sectors property (%" PRIu32
+                       "), must be zero or at least the zone write granularity "
+                       "(%" PRIu32 " bytes)", conf->max_append_sectors, wg);
+            return;
+        }
+    }
+
     if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_DISCARD) &&
         (!conf->max_discard_sectors ||
          conf->max_discard_sectors > BDRV_REQUEST_MAX_SECTORS)) {
@@ -1986,6 +2033,12 @@ static const Property virtio_blk_properties[] = {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
+    /*
+     * Zero is valid, and says that the device does not support zone append,
+     * as a ZBC or ZAC disk does not.
+     */
+    DEFINE_PROP_UINT32("max-append-sectors", VirtIOBlock,
+                       conf.max_append_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
 };
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 3d8dee7ec1..0070ca6ba9 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -47,6 +47,7 @@ struct VirtIOBlkConf
     bool report_discard_granularity;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
+    uint32_t max_append_sectors;
     bool x_enable_wce_if_config_wce;
 };
 
-- 
2.55.0


