Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2F606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gjkko1tD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyW-00015c-Ph; Tue, 27 Oct 2026 16:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny1-0000qQ-5e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxg-0001ME-1M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CawP+jicTemyhB4Ih2BygFVKp4RXXazB1bImzxuDm3g=;
 b=Gjkko1tDdyihOxhYtcOW9Sptv+fF1ZE2gz+LQOiv1n+6fHoWX/VaeHmOz6bpoHm6+7ym5H
 fO0w4ePaPBU3RUvtOTroAW2XneuaenM7aOBHgNzih9AZ4LfabZ6Mykokq4QlwjKtmgmuKA
 PHYEImhaLvWk85p8LM3GyJ6jYb9LOVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-ViNnSGD6MhqUa_Bsy-782Q-1; Tue,
 27 Oct 2026 16:39:56 -0400
X-MC-Unique: ViNnSGD6MhqUa_Bsy-782Q-1
X-Mimecast-MFC-AGG-ID: ViNnSGD6MhqUa_Bsy-782Q_1793133594
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92B71955BF9; Tue, 27 Oct 2026 20:39:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4446A300019F; Tue, 27 Oct 2026 20:39:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 11/15] virtio-blk: add a max-append-sectors property
Date: Tue, 27 Oct 2026 16:39:29 -0400
Message-ID: <20261027203933.1066759-12-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Niklas Cassel <cassel@kernel.org>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-12-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  1 +
 hw/block/virtio-blk.c          | 67 ++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 3d8dee7ec15..0070ca6ba9c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -47,6 +47,7 @@ struct VirtIOBlkConf
     bool report_discard_granularity;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
+    uint32_t max_append_sectors;
     bool x_enable_wce_if_config_wce;
 };
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 74bd08b0ec1..536d71a91ad 100644
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
-- 
2.56.0


