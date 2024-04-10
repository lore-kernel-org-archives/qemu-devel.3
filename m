Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B187DCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNd-0003tU-Ki; Wed, 10 Apr 2024 03:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNP-0003La-0H; Wed, 10 Apr 2024 03:28:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNM-0004tx-NQ; Wed, 10 Apr 2024 03:28:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D9A85D6A6;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 00389B02E6;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191811 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 54/87] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Date: Wed, 10 Apr 2024 10:22:27 +0300
Message-Id: <20240410072303.4191455-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

VDUSE requires that virtqueues are first enabled before the DRIVER_OK
status flag is set; with the current API of the kernel module, it is
impossible to enable the opposite order in our block export code because
userspace is not notified when a virtqueue is enabled.

This requirement also mathces the normal initialisation order as done by
the generic vhost code in QEMU. However, commit 6c482547 accidentally
changed the order for vdpa-dev and broke access to VDUSE devices with
this.

This changes vdpa-dev to use the normal order again and use the standard
vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
used with vdpa-dev again after this fix.

vhost_net intentionally avoided enabling the vrings for vdpa and does
this manually later while it does enable them for other vhost backends.
Reflect this in the vhost_net code and return early for vdpa, so that
the behaviour doesn't change for this device.

Cc: qemu-stable@nongnu.org
Fixes: 6c4825476a43 ('vdpa: move vhost_vdpa_set_vring_ready to the caller')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240315155949.86066-1-kwolf@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2c66de61f88dc9620a32239f7dd61524a57f66b0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e8e1661646..fd1a93701a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
     VHostNetState *net = get_vhost_net(nc);
     const VhostOps *vhost_ops = net->dev.vhost_ops;
 
+    /*
+     * vhost-vdpa network devices need to enable dataplane virtqueues after
+     * DRIVER_OK, so they can recover device state before starting dataplane.
+     * Because of that, we don't enable virtqueues here and leave it to
+     * net/vhost-vdpa.c.
+     */
+    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        return 0;
+    }
+
     nc->vring_enable = enable;
 
     if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 637cac4edf..f136815072 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -48,7 +48,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
-vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
+vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index f22d5d5bc0..c9c6d6c611 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -250,14 +250,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
 
     s->dev.acked_features = vdev->guest_features;
 
-    ret = vhost_dev_start(&s->dev, vdev, false);
+    ret = vhost_dev_start(&s->dev, vdev, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Error starting vhost");
         goto err_guest_notifiers;
     }
-    for (i = 0; i < s->dev.nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
-    }
     s->started = true;
 
     /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 819b2d811a..d771a4feec 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -882,19 +882,41 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
+static int vhost_vdpa_set_vring_enable_one(struct vhost_vdpa *v, unsigned idx,
+                                           int enable)
 {
     struct vhost_dev *dev = v->dev;
     struct vhost_vring_state state = {
         .index = idx,
-        .num = 1,
+        .num = enable,
     };
     int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
 
-    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
+    trace_vhost_vdpa_set_vring_enable_one(dev, idx, enable, r);
     return r;
 }
 
+static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
+{
+    struct vhost_vdpa *v = dev->opaque;
+    unsigned int i;
+    int ret;
+
+    for (i = 0; i < dev->nvqs; ++i) {
+        ret = vhost_vdpa_set_vring_enable_one(v, i, enable);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
+{
+    return vhost_vdpa_set_vring_enable_one(v, idx, 1);
+}
+
 static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
                                        int fd)
 {
@@ -1508,6 +1530,7 @@ const VhostOps vdpa_ops = {
         .vhost_set_features = vhost_vdpa_set_features,
         .vhost_reset_device = vhost_vdpa_reset_device,
         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
         .vhost_get_config  = vhost_vdpa_get_config,
         .vhost_set_config = vhost_vdpa_set_config,
         .vhost_requires_shm_log = NULL,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79468..0000a66186 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1984,7 +1984,13 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
     return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
 }
 
-/* Host notifiers must be enabled at this point. */
+/*
+ * Host notifiers must be enabled at this point.
+ *
+ * If @vrings is true, this function will enable all vrings before starting the
+ * device. If it is false, the vring initialization is left to be done by the
+ * caller.
+ */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
 {
     int i, r;
-- 
2.39.2


