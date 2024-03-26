Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D87CCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GR-00048n-2g; Tue, 26 Mar 2024 09:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GP-000486-Rh
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GO-0001O5-31
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00p6Fe2jKqTz09HPK0hkhT/FL6JFarV4u7L7bkf2gsg=;
 b=izewh4tE5dFJeTKBb3cW44GZsvJdjpZa3boxXk4IR4NJUac8wVKj1jXB65QzbJ6Q2imA8k
 nKBtXlugdI8rC6YyLE53l05jBoa8nc1prv392jp07LjjZ5BJCPqOn7QCA5uuhKW+1d/Mc5
 FQe8vibAfnWnuTdhlPGJf04B1L78KlA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-3RS1TJvxPiWjVmGGsxFh7A-1; Tue,
 26 Mar 2024 09:54:49 -0400
X-MC-Unique: 3RS1TJvxPiWjVmGGsxFh7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71AF028EC116;
 Tue, 26 Mar 2024 13:54:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 854CC112132A;
 Tue, 26 Mar 2024 13:54:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 2/6] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Date: Tue, 26 Mar 2024 14:54:36 +0100
Message-ID: <20240326135440.421609-3-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/net/vhost_net.c     | 10 ++++++++++
 hw/virtio/vdpa-dev.c   |  5 +----
 hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
 hw/virtio/vhost.c      |  8 +++++++-
 hw/virtio/trace-events |  2 +-
 5 files changed, 45 insertions(+), 9 deletions(-)

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
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index eb9ecea83b..13e87f06f6 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
 
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
index 3bcd05cc22..e827b9175f 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -896,19 +896,41 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
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
@@ -1536,6 +1558,7 @@ const VhostOps vdpa_ops = {
         .vhost_set_features = vhost_vdpa_set_features,
         .vhost_reset_device = vhost_vdpa_reset_device,
         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
         .vhost_get_config  = vhost_vdpa_get_config,
         .vhost_set_config = vhost_vdpa_set_config,
         .vhost_requires_shm_log = NULL,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2e4e040db8..f50180e60e 100644
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
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 13b6991179..96632fd026 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -49,7 +49,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
-vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
+vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
-- 
2.44.0


