Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45649C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 21:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOk13-00005O-3t; Mon, 09 Jun 2025 17:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk11-0008VS-85; Mon, 09 Jun 2025 17:26:47 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk0y-0007d7-Qx; Mon, 09 Jun 2025 17:26:46 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:722f:0:640:94d5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 743A460D44;
 Tue, 10 Jun 2025 00:26:41 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:771::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VQpuLN5FZuQ0-1RyDyOq6; Tue, 10 Jun 2025 00:26:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749504400;
 bh=CxLtRVZJ+VDwzg3qfk9X5czGZQYuX2xMqqVhQLh6XeU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OH60tyevyKc/gugeY+gng6NLLOM9lDn8ONHKIUp/4bd1pyAaOUiqs4TTgkS9+SLg1
 WWUtG3f94DuYf5fKqdyHqO/m87oRt0vSmovyF3tNudA6KH/ejdHErBErXLshHa7WF3
 KPRjT9VdvRz5cN+zhJSvuBsIOAZx2oPDaUSa+JZA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 2/3] vhost: add a helper for force stopping a device
Date: Tue, 10 Jun 2025 00:25:46 +0300
Message-Id: <20250609212547.2859224-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
References: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This adds an ability to skip GET_VRING_BASE during device stop entirely,
and thus the expensive drain operation that this call entails as well,
which may be useful during a non-graceful shutdown in case the guest
operating system hangs or refuses to react to a previously requested
ACPI shutdown for whatever reason.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c         | 52 +++++++++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 15 +++++++++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fc43853704..d321faf0a1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1367,25 +1367,30 @@ fail_alloc_desc:
     return r;
 }
 
-int vhost_virtqueue_stop(struct vhost_dev *dev,
-                         struct VirtIODevice *vdev,
-                         struct vhost_virtqueue *vq,
-                         unsigned idx)
+static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
+                                   struct VirtIODevice *vdev,
+                                   struct vhost_virtqueue *vq,
+                                   unsigned idx, bool force)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
     };
-    int r;
+    int r = 0;
 
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
     }
 
-    r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
-    if (r < 0) {
-        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+    if (!force) {
+        r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+        }
+    }
+
+    if (r < 0 || force) {
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
@@ -1414,6 +1419,14 @@ int vhost_virtqueue_stop(struct vhost_dev *dev,
     return r;
 }
 
+int vhost_virtqueue_stop(struct vhost_dev *dev,
+                         struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq,
+                         unsigned idx)
+{
+    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false);
+}
+
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
                                                 int n, uint32_t timeout)
 {
@@ -2136,7 +2149,8 @@ fail_features:
 }
 
 /* Host notifiers must be enabled at this point. */
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                             bool vrings, bool force)
 {
     int i;
     int rc = 0;
@@ -2158,10 +2172,11 @@ int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         vhost_dev_set_vring_enable(hdev, false);
     }
     for (i = 0; i < hdev->nvqs; ++i) {
-        rc |= vhost_virtqueue_stop(hdev,
-                                   vdev,
-                                   hdev->vqs + i,
-                                   hdev->vq_index + i);
+        rc |= do_vhost_virtqueue_stop(hdev,
+                                      vdev,
+                                      hdev->vqs + i,
+                                      hdev->vq_index + i,
+                                      force);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2181,6 +2196,17 @@ int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     return rc;
 }
 
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+{
+    return do_vhost_dev_stop(hdev, vdev, vrings, false);
+}
+
+int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                         bool vrings)
+{
+    return do_vhost_dev_stop(hdev, vdev, vrings, true);
+}
+
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file)
 {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 38800a7156..eb3dd7616b 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -237,6 +237,21 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  */
 int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
 
+/**
+ * vhost_dev_force_stop() - force stop the vhost device
+ * @hdev: common vhost_dev structure
+ * @vdev: the VirtIODevice structure
+ * @vrings: true to have vrings disabled in this call
+ *
+ * Force stop the vhost device. After the device is stopped the notifiers
+ * can be disabled (@vhost_dev_disable_notifiers) and the device can
+ * be torn down (@vhost_dev_cleanup). Unlike @vhost_dev_stop, this doesn't
+ * attempt to flush in-flight backend requests by skipping GET_VRING_BASE
+ * entirely.
+ */
+int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                         bool vrings);
+
 /**
  * DOC: vhost device configuration handling
  *
-- 
2.34.1


