Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F850E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNv8m-0003gp-Ez; Wed, 18 Dec 2024 09:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tNv8j-0003eh-Vt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tNv8h-0004nn-9O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734532501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WAC+Qzi4qSgi/qGI+XlVOgbDADD7acZ2ZVxkQEaki70=;
 b=Pxsyonwy3/zUgVbqrJG1NHTabK3QfIjMtSTmTgsRg4s/zfiRq7MjC1Nvdy7odn92lHGzYA
 FX9t+o08eepWO8Nomaku+yN0quR0lU9UhKZouWBmUtLuUxGsUowTIKeBNXa2v/0gJxglFN
 ViSWJlerhL6b0rR1ncmVOoHRg4QvyQw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-xNMR8A9sNs-mR9PhDef9iA-1; Wed,
 18 Dec 2024 09:34:58 -0500
X-MC-Unique: xNMR8A9sNs-mR9PhDef9iA-1
X-Mimecast-MFC-AGG-ID: xNMR8A9sNs-mR9PhDef9iA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1250A19560BE
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:34:57 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B1F9195605F; Wed, 18 Dec 2024 14:34:55 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-net: vhost-user: Implement internal migration
Date: Wed, 18 Dec 2024 15:34:53 +0100
Message-ID: <20241218143453.1573185-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net
with vhost-user backend.

Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6e8c51a2dbce..b4d9e96dc0d7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3337,6 +3337,117 @@ static const VMStateDescription vmstate_virtio_net_rss = {
     },
 };
 
+static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc;
+    struct vhost_net *net;
+
+    if (!n->nic) {
+        return NULL;
+    }
+
+    nc = qemu_get_queue(n->nic);
+    if (!nc) {
+        return NULL;
+    }
+
+    net = get_vhost_net(nc->peer);
+    if (!net) {
+        return NULL;
+    }
+
+    return &net->dev;
+}
+
+static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field,
+                                     JSONWriter *vmdesc)
+{
+    VirtIONet *n = pv;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+    Error *local_error = NULL;
+    int ret;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        error_reportf_err(local_error,
+                          "Error getting vhost back-end of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return -1;
+    }
+
+    ret = vhost_save_backend_state(vhdev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error saving back-end state of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return ret;
+    }
+
+    return 0;
+}
+
+static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field)
+{
+    VirtIONet *n = pv;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+    Error *local_error = NULL;
+    int ret;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        error_reportf_err(local_error,
+                          "Error getting vhost back-end of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return -1;
+    }
+
+    ret = vhost_load_backend_state(vhdev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error loading  back-end state of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return ret;
+    }
+
+    return 0;
+}
+
+static bool vhost_user_net_is_internal_migration(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        return false;
+    }
+
+    return vhost_supports_device_state(vhdev);
+}
+
+static const VMStateDescription vhost_user_net_backend_state = {
+    .name = "virtio-net-device/backend",
+    .version_id = 0,
+    .needed = vhost_user_net_is_internal_migration,
+    .fields = (const VMStateField[]) {
+        {
+            .name = "backend",
+            .info = &(const VMStateInfo) {
+                .name = "virtio-net vhost-user backend state",
+                .get = vhost_user_net_load_state,
+                .put = vhost_user_net_save_state,
+            },
+         },
+         VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3389,6 +3500,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_net_rss,
+        &vhost_user_net_backend_state,
         NULL
     }
 };
@@ -3950,29 +4062,6 @@ static bool dev_unplug_pending(void *opaque)
     return vdc->primary_unplug_pending(dev);
 }
 
-static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc;
-    struct vhost_net *net;
-
-    if (!n->nic) {
-        return NULL;
-    }
-
-    nc = qemu_get_queue(n->nic);
-    if (!nc) {
-        return NULL;
-    }
-
-    net = get_vhost_net(nc->peer);
-    if (!net) {
-        return NULL;
-    }
-
-    return &net->dev;
-}
-
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
-- 
2.47.1


