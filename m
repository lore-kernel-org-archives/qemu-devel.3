Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B9ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7ZW-00041A-0d; Wed, 27 May 2026 02:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZI-0003uq-Dw; Wed, 27 May 2026 02:16:40 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZD-0003tE-L8; Wed, 27 May 2026 02:16:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6A6E18076D;
 Wed, 27 May 2026 09:16:33 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-YJPE0tiy; Wed, 27 May 2026 09:16:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862592;
 bh=WxKn5yTwqrVh0rfVhVIPo0TFywv4rXak2ThV805BI6w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IXBqWp8cQUTP3w2dW0ZOnxEaBv1TLxoA2vwY6YpFHo8BQXDHVm9IfH6Q7BZT3XSE4
 LkIjoNhUhSsjFbZQNRzsDJ+sHcrKPfYCMQvGOEkb7KuGGI57R979Tvkm+7iKECRdze
 Xypbemta1dRklHF/oHqdJKIFKPlO5aCx81AO4iaw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v7 04/22] vhost: move protocol_features to vhost_user
Date: Wed, 27 May 2026 09:16:05 +0300
Message-ID: <20260527061625.11167-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

As comment says: it's only for vhost-user. So, let's move it
to corresponding vhost backend realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/cryptodev-vhost.c     |  1 -
 hw/block/vhost-user-blk.c      |  6 ++----
 hw/net/vhost_net.c             |  2 --
 hw/virtio/meson.build          |  1 +
 hw/virtio/vhost-user-stub.c    |  6 ++++++
 hw/virtio/vhost-user.c         | 36 +++++++++++++++++++++++++++-------
 hw/virtio/virtio-qmp.c         |  6 ++++--
 include/hw/virtio/vhost-user.h |  4 ++++
 include/hw/virtio/vhost.h      |  8 --------
 9 files changed, 46 insertions(+), 24 deletions(-)
 create mode 100644 hw/virtio/vhost-user-stub.c

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index abdfce33afc..c6069f4e5bd 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -60,7 +60,6 @@ cryptodev_vhost_init(
 
     crypto->cc = options->cc;
 
-    crypto->dev.protocol_features = 0;
     crypto->backend = -1;
 
     /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index dc99de02635..2831f3c0530 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -572,10 +572,8 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
 {
     struct VHostUserBlk *s = opaque;
 
-    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
-                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-
-    return inflight_migration;
+    return vhost_user_has_protocol_feature(
+        &s->dev, VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
 }
 
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fda90e231e6..ca199831260 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -265,9 +265,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
         net->backend = r;
-        net->dev.protocol_features = 0;
     } else {
-        net->dev.protocol_features = 0;
         net->backend = -1;
 
         /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index e0566a60de7..0ea89d8af4c 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -94,6 +94,7 @@ system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 stub_ss.add(files('vhost-stub.c'))
+stub_ss.add(files('vhost-user-stub.c'))
 stub_ss.add(files('virtio-stub.c'))
 stub_ss.add(files('virtio-md-stubs.c'))
 
diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
new file mode 100644
index 00000000000..45559788dd4
--- /dev/null
+++ b/hw/virtio/vhost-user-stub.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user.h"
+
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+}
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 72aeed26caa..fc2ed1f17e5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-dmabuf.h"
+#include "hw/virtio/virtio-qmp.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
@@ -259,6 +260,14 @@ struct vhost_user {
     /* Our current regions */
     int num_shadow_regions;
     struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
+
+    /**
+     * @protocol_features: the vhost-user protocol feature set by
+     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
+     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
+     * by the backend (see @features).
+     */
+    uint64_t protocol_features;
 };
 
 struct scrub_regions {
@@ -267,10 +276,13 @@ struct scrub_regions {
     int fd_idx;
 };
 
-static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
-                                            uint64_t feature)
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
 {
-    return virtio_has_feature(dev->protocol_features, feature);
+    struct vhost_user *u = dev->opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    return virtio_has_feature(u->protocol_features, feature);
 }
 
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
@@ -1338,8 +1350,8 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
     int ret;
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     VhostUserMsg msg = {
         .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2239,8 +2251,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* final set of protocol features */
-        dev->protocol_features = protocol_features;
-        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
+        u->protocol_features = protocol_features;
+        err = vhost_user_set_protocol_features(dev, u->protocol_features);
         if (err < 0) {
             error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
             return -EPROTO;
@@ -3033,6 +3045,16 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+    struct vhost_user *u = dev->opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    status->vhost_dev->protocol_features =
+        qmp_decode_protocols(u->protocol_features);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 71717c56a41..c8bf702d38d 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -751,12 +751,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
 
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
         status->vhost_dev->log_size = hdev->log_size;
+
+        if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {
+            vhost_user_qmp_status(hdev, status);
+        }
     }
 
     return status;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 53fe9966862..0e576fc5386 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -10,6 +10,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
+#include "qapi/qapi-types-virtio.h"
 
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
@@ -113,4 +114,7 @@ void vhost_user_async_close(DeviceState *d,
                             CharFrontend *chardev, struct vhost_dev *vhost,
                             vu_async_close_fn cb);
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature);
+
 #endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index e139e059857..4a9bd3effef 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -104,14 +104,6 @@ struct vhost_dev {
     VIRTIO_DECLARE_FEATURES(features);
     VIRTIO_DECLARE_FEATURES(acked_features);
 
-    /**
-     * @protocol_features: is the vhost-user only feature set by
-     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
-     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
-     * by the backend (see @features).
-     */
-    uint64_t protocol_features;
-
     uint64_t max_queues;
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
-- 
2.52.0


