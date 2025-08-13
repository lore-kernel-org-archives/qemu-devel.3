Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2491CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfx-0002zM-Gn; Wed, 13 Aug 2025 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfC-0002ck-AU; Wed, 13 Aug 2025 12:49:23 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf3-0007mi-0U; Wed, 13 Aug 2025 12:49:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6337F806ED;
 Wed, 13 Aug 2025 19:49:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-GqcTJp6L; Wed, 13 Aug 2025 19:49:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103742;
 bh=acxYECp3A0SGP4hq0iUq8Uo4uzgqm35WfZKeXrTijzk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=sjMRU4dvGWAd7DosG9x+ELz8m1mRo9JdmOSzwWQ0sG4o2FuXK1OHGir2lKwv9ccSe
 P+/jGpN/SbSTbnCcS9D9+NQ1G73VYbV78cCJ+MILCoxbNe903xOzU0Itpq8+oCepCJ
 Z7wjL8ZDljfZhP2LOmQSYLZp3vrg8ofsTJChC2EM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 02/33] vhost: drop backend_features field
Date: Wed, 13 Aug 2025 19:48:23 +0300
Message-ID: <20250813164856.950363-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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
vhoust-user-net). But we can simply recalculte these two flags inplace
from hdev->features, and from net-client for
VHOST_NET_F_VIRTIO_NET_HDR.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c   |  1 -
 hw/net/vhost_net.c          | 16 ++++++++--------
 hw/scsi/vhost-scsi.c        |  1 -
 hw/scsi/vhost-user-scsi.c   |  1 -
 hw/virtio/vdpa-dev.c        |  1 -
 hw/virtio/vhost-user.c      | 19 +++++++++----------
 hw/virtio/virtio-hmp-cmds.c |  2 --
 hw/virtio/virtio-qmp.c      |  2 --
 include/hw/virtio/vhost.h   |  7 -------
 qapi/virtio.json            |  3 ---
 10 files changed, 17 insertions(+), 36 deletions(-)

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
index 540492b37d..fcee279f0b 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -53,7 +53,10 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
 
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
-    net->dev.acked_features = net->dev.backend_features;
+    net->dev.acked_features =
+        (qemu_has_vnet_hdr(net->nc) ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))
+         | (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
+
     vhost_ack_features(&net->dev, net->feature_bits, features);
 }
 
@@ -256,12 +259,9 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         if (r < 0) {
             goto fail;
         }
-        net->dev.backend_features = qemu_has_vnet_hdr(options->net_backend)
-            ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        net->dev.backend_features = 0;
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -281,10 +281,10 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
             net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
-        if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                   " for backend\n",
-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
+        if (!qemu_has_vnet_hdr(options->net_backend) &&
+            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
+            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
+                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
             goto fail;
         }
     }
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
index d1da40afc8..3c0eed3e8e 100644
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
index 1b2879a90c..cf6f53801d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1232,7 +1232,7 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
 
 static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
 {
-    return virtio_has_feature(dev->backend_features,
+    return virtio_has_feature(dev->features,
                               VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
@@ -1449,14 +1449,15 @@ static int vhost_user_set_features(struct vhost_dev *dev,
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
@@ -2187,8 +2188,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
         uint64_t protocol_features;
 
-        dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
-
         err = vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES,
                                  &protocol_features);
         if (err < 0) {
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 7d8677bcf0..024904915d 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -175,8 +175,6 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         hmp_virtio_dump_features(mon, s->vhost_dev->features);
         monitor_printf(mon, "    Acked features:\n");
         hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
-        monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
         monitor_printf(mon, "    Protocol features:\n");
         hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
     }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..e514a4797e 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -788,8 +788,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
             qmp_decode_features(vdev->device_id, hdev->features);
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 66be6afc88..9f9dd2d46d 100644
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
     uint64_t features;
     uint64_t acked_features;
-    uint64_t backend_features;
 
     /**
      * @protocol_features: is the vhost-user only feature set by
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9d652fe4a8..0aae77340d 100644
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


