Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD448C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDRl-0000s7-4F; Thu, 02 Jul 2026 05:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wfDRi-0000r9-R8; Thu, 02 Jul 2026 05:10:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wfDRa-0000hK-M8; Thu, 02 Jul 2026 05:10:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 7BA3880604;
 Thu, 02 Jul 2026 12:10:45 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:43d::1:15])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id NAc7BT0aDa60-XZ7fFrmb; Thu, 02 Jul 2026 12:10:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782983444;
 bh=sGPkSM7/sBQ28Y0z9E0rw0TzxOCYF3XhngIDZ+Qv0qc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yLKa9G+SC/jgW9ZBNeqbSgnIeaFUpfEUpupoRvfioPPUmAjkbinaPxYCZbv+9zR94
 Cp4hzDmKpqjN9ofo1MFrDR9993YiiH0655A8rruN+sSNlxSgDy61LnGXBrC6Poho5q
 kmbqXC5IvOtJzoW4CgJk4F/BaUDnGTp45SNc04HQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Milan Zamazal <mzamazal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, zhenwei pi <zhenwei.pi@linux.dev>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 virtio-fs@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, qemu-block@nongnu.org,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v4 1/6] vhost-user: add skip_drain param to
 do_vhost_virtqueue_stop
Date: Thu,  2 Jul 2026 14:10:18 +0500
Message-Id: <20260702091023.3306378-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702091023.3306378-1-dtalexundeer@yandex-team.ru>
References: <20260702091023.3306378-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Will be used in future commit for using new protocol message.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 backends/cryptodev-vhost.c     |  2 +-
 backends/vhost-user.c          |  2 +-
 hw/block/vhost-user-blk.c      |  2 +-
 hw/net/vhost_net.c             |  9 +++++----
 hw/scsi/vhost-scsi-common.c    |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user-fs.c      |  2 +-
 hw/virtio/vhost-user-scmi.c    |  2 +-
 hw/virtio/vhost-vsock-common.c |  2 +-
 hw/virtio/vhost.c              | 28 +++++++++++++++++++---------
 include/hw/virtio/vhost.h      |  7 +++++--
 12 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index c6069f4e5b..f1ca6bcd4e 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -109,7 +109,7 @@ static void
 cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
                                  VirtIODevice *dev)
 {
-    vhost_dev_stop(&crypto->dev, dev, false);
+    vhost_dev_stop(&crypto->dev, dev, false, false);
     vhost_dev_disable_notifiers(&crypto->dev, dev);
 }
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 380d825023..0423c2d4ec 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -108,7 +108,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
         return 0;
     }
 
-    ret = vhost_dev_stop(&b->dev, b->vdev, true);
+    ret = vhost_dev_stop(&b->dev, b->vdev, true, false);
 
     if (k->set_guest_notifiers &&
         (err = k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false)) < 0) {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index b2e46eb3f9..e3b873af7c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -232,7 +232,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
                  qemu_force_shutdown_requested();
 
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
-                       vhost_dev_stop(&s->dev, vdev, true);
+                       vhost_dev_stop(&s->dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 323d117735..6e05c995f1 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -384,7 +384,7 @@ fail:
     if (net->nc->info->poll) {
         net->nc->info->poll(net->nc, true);
     }
-    vhost_dev_stop(&net->dev, dev, false);
+    vhost_dev_stop(&net->dev, dev, false, false);
 fail_start:
     return r;
 }
@@ -403,7 +403,7 @@ static void vhost_net_stop_one(struct vhost_net *net,
     if (net->nc->info->poll) {
         net->nc->info->poll(net->nc, true);
     }
-    vhost_dev_stop(&net->dev, dev, false);
+    vhost_dev_stop(&net->dev, dev, false, false);
     if (net->nc->info->stop) {
         net->nc->info->stop(net->nc);
     }
@@ -636,7 +636,8 @@ void vhost_net_virtqueue_reset(VirtIODevice *vdev, NetClientState *nc,
     vhost_virtqueue_stop(&net->dev,
                          vdev,
                          net->dev.vqs + idx,
-                         net->dev.vq_index + idx);
+                         net->dev.vq_index + idx,
+                         false);
 }
 
 int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
@@ -686,7 +687,7 @@ err_start:
         assert(ret >= 0);
     }
 
-    vhost_dev_stop(&net->dev, vdev, false);
+    vhost_dev_stop(&net->dev, vdev, false, false);
 
     return r;
 }
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e19800a0bc..e546a6dc75 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -108,7 +108,7 @@ int vhost_scsi_common_stop(VHostSCSICommon *vsc)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
-    ret = vhost_dev_stop(&vsc->dev, vdev, true);
+    ret = vhost_dev_stop(&vsc->dev, vdev, true, false);
 
     if (k->set_guest_notifiers) {
         int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 94188d37bb..b86d0b664a 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -300,7 +300,7 @@ static void vhost_vdpa_device_stop(VirtIODevice *vdev)
         return;
     }
 
-    vhost_dev_stop(&s->dev, vdev, false);
+    vhost_dev_stop(&s->dev, vdev, false, false);
 
     ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (ret < 0) {
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 39b5e637fc..abeae1a064 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -78,7 +78,7 @@ static int vub_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&vub->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vub->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 209993918a..0d8842817a 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -111,7 +111,7 @@ static int vuf_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&fs->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&fs->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 9470f68c1f..9fa65d7d8b 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -101,7 +101,7 @@ static int vu_scmi_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(vhost_dev, vdev, true);
+    ret = vhost_dev_stop(vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index b79f4c9ce6..4ef037627b 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -106,7 +106,7 @@ int vhost_vsock_common_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..2a62550222 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
@@ -1496,8 +1497,13 @@ fail:
 static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                    struct VirtIODevice *vdev,
                                    struct vhost_virtqueue *vq,
-                                   unsigned idx, bool force)
+                                   unsigned idx, bool force,
+                                   bool skip_drain)
 {
+    if (skip_drain) {
+        assert(vhost_user_has_protocol_feature(dev,
+               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
+    }
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
@@ -1547,9 +1553,10 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
 int vhost_virtqueue_stop(struct vhost_dev *dev,
                          struct VirtIODevice *vdev,
                          struct vhost_virtqueue *vq,
-                         unsigned idx)
+                         unsigned idx,
+                         bool skip_drain)
 {
-    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false);
+    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false, skip_drain);
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -2302,7 +2309,8 @@ fail_vq:
         vhost_virtqueue_stop(hdev,
                              vdev,
                              hdev->vqs + i,
-                             hdev->vq_index + i);
+                             hdev->vq_index + i,
+                             false);
     }
 
 fail_mem:
@@ -2317,7 +2325,7 @@ fail_features:
 
 /* Host notifiers must be enabled at this point. */
 static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
-                             bool vrings, bool force)
+                             bool vrings, bool force, bool skip_drain)
 {
     int i;
     int rc = 0;
@@ -2344,7 +2352,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
                                       vdev,
                                       hdev->vqs + i,
                                       hdev->vq_index + i,
-                                      force);
+                                      force,
+                                      skip_drain);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2366,15 +2375,16 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     return rc;
 }
 
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings,
+                   bool skip_drain)
 {
-    return do_vhost_dev_stop(hdev, vdev, vrings, false);
+    return do_vhost_dev_stop(hdev, vdev, vrings, false, skip_drain);
 }
 
 int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
                          bool vrings)
 {
-    return do_vhost_dev_stop(hdev, vdev, vrings, true);
+    return do_vhost_dev_stop(hdev, vdev, vrings, true, false);
 }
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 684bafcaad..33b88f95ea 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -228,6 +228,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  * @hdev: common vhost_dev structure
  * @vdev: the VirtIODevice structure
  * @vrings: true to have vrings disabled in this call
+ * @skip_drain: true to notice back-end to skip draining all in-flight requests
  *
  * Stop the vhost device. After the device is stopped the notifiers
  * can be disabled (@vhost_dev_disable_notifiers) and the device can
@@ -235,7 +236,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  *
  * Return: 0 on success, != 0 on error when stopping dev.
  */
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings,
+                   bool skip_drain);
 
 /**
  * vhost_dev_force_stop() - force stop the vhost device
@@ -393,7 +395,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
                           struct vhost_virtqueue *vq, unsigned idx);
 int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
-                         struct vhost_virtqueue *vq, unsigned idx);
+                         struct vhost_virtqueue *vq, unsigned idx,
+                         bool skip_drain);
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
-- 
2.34.1


