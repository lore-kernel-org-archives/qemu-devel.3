Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAD2CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iwl-0006AB-S7; Sat, 11 Oct 2025 19:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwj-000693-LT; Sat, 11 Oct 2025 19:24:18 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwg-0000r6-4T; Sat, 11 Oct 2025 19:24:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BB278C01DB;
 Sun, 12 Oct 2025 02:24:10 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-6sHTDCW2; Sun, 12 Oct 2025 02:24:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225049;
 bh=2vGzStpxOn6DIJrzjS4YB1XRA5fwr4MFFMHUtdQdzNI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=s12qabnwdyIJ+n/1WSkVPG2nZm2D18BxBb59VqVrAUSAXyB95Su+rvdy8P5yM+gEk
 jbojsPbuqJaHHckkvPgE9weFtRWHzefUQpgf2nZb93/dxbIh8Iu8iLQTmDKhhe03Ad
 tWn4dGhdSemJKsVNmHCGfT0ogld5o2kkpZPdqSy0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 02/23] vhost: drop backend_features field
Date: Sun, 12 Oct 2025 02:23:41 +0300
Message-ID: <20251011232404.561024-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This field is mostly unused and sometimes confusing (we even have
a TODO-like comment to drop it). Let's finally do.

The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
vhost-user-net). But we can simply recalculate these two flags in place
from hdev->features, and from net-client for VHOST_NET_F_VIRTIO_NET_HDR.

Note: removing field from x-query-virtio-status result is incompatible
change. We can do it because the command is unstable.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c   |  1 -
 hw/net/vhost_net.c          | 26 ++++++++++++++------------
 hw/scsi/vhost-scsi.c        |  1 -
 hw/scsi/vhost-user-scsi.c   |  1 -
 hw/virtio/vdpa-dev.c        |  1 -
 hw/virtio/vhost-user.c      | 17 ++++++++---------
 hw/virtio/virtio-hmp-cmds.c |  2 --
 hw/virtio/virtio-qmp.c      |  4 ----
 include/hw/virtio/vhost.h   |  7 -------
 qapi/virtio.json            |  3 ---
 10 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f6942..de7a810c93 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -348,7 +348,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
 
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 25e9f1fd24..fda90e231e 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -52,8 +52,14 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
 
 void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
-    virtio_features_copy(net->dev.acked_features_ex,
-                         net->dev.backend_features_ex);
+    virtio_features_clear(net->dev.acked_features_ex);
+    if (net->backend == -1) {
+        net->dev.acked_features =
+           net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+    } else if (!qemu_has_vnet_hdr(net->nc)) {
+        net->dev.acked_features = 1ULL << VHOST_NET_F_VIRTIO_NET_HDR;
+    }
+
     vhost_ack_features_ex(&net->dev, net->feature_bits, features);
 }
 
@@ -258,12 +264,9 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         if (r < 0) {
             goto fail;
         }
-        net->dev.backend_features = qemu_has_vnet_hdr(options->net_backend)
-            ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        virtio_features_clear(net->dev.backend_features_ex);
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -284,13 +287,12 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
 
-        if (virtio_features_andnot(missing_features,
-                                   net->dev.backend_features_ex,
-                                   net->dev.features_ex)) {
-            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
-                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
-            goto fail;
-        }
+        if (!qemu_has_vnet_hdr(options->net_backend) &&
+            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
+            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
+                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
+             goto fail;
+         }
     }
 
     /* Set sane init value. Override when guest acks. */
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cdf405b0f8..d694a25fe2 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -276,7 +276,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vqs = vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
                          VHOST_BACKEND_TYPE_KERNEL, 0, errp);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 25f2d894e7..0c80a271d8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -159,7 +159,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
     vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
     vsc->dev.vqs = s->vhost_vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 4a7b970976..efd9f68420 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -104,7 +104,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     v->dev.vqs = vqs;
     v->dev.vq_index = 0;
     v->dev.vq_index_end = v->dev.nvqs;
-    v->dev.backend_features = 0;
     v->started = false;
 
     ret = vhost_vdpa_get_iova_range(v->vhostfd, &iova_range);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f367ce06ce..b80174f489 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1448,14 +1448,15 @@ static int vhost_user_set_features(struct vhost_dev *dev,
     int ret;
 
     /*
-     * We need to include any extra backend only feature bits that
-     * might be needed by our device. Currently this includes the
-     * VHOST_USER_F_PROTOCOL_FEATURES bit for enabling protocol
-     * features.
+     * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
+     * specific.
      */
-    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES,
-                              features | dev->backend_features,
-                              log_enabled);
+    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+        features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+    }
+
+    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
+                             log_enabled);
 
     if (virtio_has_feature(dev->protocol_features,
                            VHOST_USER_PROTOCOL_F_STATUS)) {
@@ -2189,8 +2190,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
         uint64_t protocol_features;
 
-        dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
-
         err = vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES,
                                  &protocol_features);
         if (err < 0) {
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 1daae482d3..4bf9a3109d 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -176,8 +176,6 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         hmp_virtio_dump_features(mon, s->vhost_dev->features);
         monitor_printf(mon, "    Acked features:\n");
         hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
-        monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
         monitor_printf(mon, "    Protocol features:\n");
         hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
     }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b338344c6c..dd1a38e792 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -780,8 +780,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
                                                  vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
                                                 vdev->host_features_ex);
-    status->backend_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -822,8 +820,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
             qmp_decode_features(vdev->device_id, hdev->features_ex);
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
 
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 1ee639dd7e..3e69e47833 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -100,16 +100,9 @@ struct vhost_dev {
      *
      * @features: available features provided by the backend
      * @acked_features: final negotiated features with front-end driver
-     *
-     * @backend_features: this is used in a couple of places to either
-     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
-     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
-     * future use should be discouraged and the variable retired as
-     * its easy to confuse with the VirtIO backend_features.
      */
     VIRTIO_DECLARE_FEATURES(features);
     VIRTIO_DECLARE_FEATURES(acked_features);
-    VIRTIO_DECLARE_FEATURES(backend_features);
 
     /**
      * @protocol_features: is the vhost-user only feature set by
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 05295ab665..b995a5bb6d 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -85,8 +85,6 @@
 #
 # @acked-features: vhost_dev acked_features
 #
-# @backend-features: vhost_dev backend_features
-#
 # @protocol-features: vhost_dev protocol_features
 #
 # @max-queues: vhost_dev max_queues
@@ -106,7 +104,6 @@
             'vq-index': 'int',
             'features': 'VirtioDeviceFeatures',
             'acked-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
             'protocol-features': 'VhostDeviceProtocols',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
-- 
2.48.1


