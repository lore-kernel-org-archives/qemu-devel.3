Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CF2CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hP9-00074C-DK; Mon, 22 Sep 2025 10:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0hP4-00072T-Jz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0hOx-00075e-2e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758550820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDckLiiTXwXnFE/vdPOb0E4UzwwQtUGlkHPba2eh61E=;
 b=HUcbKQiZvBIBsGpsEauEKSYxqSoWIKakMPk54rzVIOto+Yuvi9vLyphtCweEenNJOjix7x
 HbPk6vkY3hfbHtb/QNimg8Rjjipcd7Rkaws2Ldy6CTvCSNSZT19hSO0Vr8yRDNy2AnrwiT
 JhmHoU+YzDz5f2SK8IIoMKTn6CuZPGQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-Mvu72r7TPmqeqptbzsdRGA-1; Mon,
 22 Sep 2025 10:20:10 -0400
X-MC-Unique: Mvu72r7TPmqeqptbzsdRGA-1
X-Mimecast-MFC-AGG-ID: Mvu72r7TPmqeqptbzsdRGA_1758550803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B857180035C; Mon, 22 Sep 2025 14:20:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.247])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8B8519560BB; Mon, 22 Sep 2025 14:19:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v7 10/14] vhost-backend: implement extended features support
Date: Mon, 22 Sep 2025 16:18:24 +0200
Message-ID: <150daade3d59e77629276920e014ee8e5fc12121.1758549625.git.pabeni@redhat.com>
In-Reply-To: <cover.1758549625.git.pabeni@redhat.com>
References: <cover.1758549625.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Leverage the kernel extended features manipulation ioctls(), if
available, and fallback to old ops otherwise. Error out when setting
extended features but kernel support is not available.

Note that extended support for get/set backend features is not needed,
as the only feature that can be changed belongs to the 64 bit range.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - use new virtio_features macro names

v1 -> v2:
  - synced with kernel ioctl changes
---
 hw/virtio/vhost-backend.c | 62 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804dd40..4367db0d95 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -20,6 +20,11 @@
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 
+struct vhost_features {
+    uint64_t count;
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+};
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
@@ -182,12 +187,6 @@ static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
 }
 
-static int vhost_kernel_set_features(struct vhost_dev *dev,
-                                     uint64_t features)
-{
-    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
-}
-
 static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
 {
     uint64_t features;
@@ -210,10 +209,51 @@ static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
     return 0;
 }
 
-static int vhost_kernel_get_features(struct vhost_dev *dev,
-                                     uint64_t *features)
+static int vhost_kernel_set_features(struct vhost_dev *dev,
+                                     const uint64_t *features)
 {
-    return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
+    struct vhost_features farray;
+    bool extended_in_use;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    virtio_features_copy(farray.features, features);
+    extended_in_use = virtio_features_use_ex(farray.features);
+
+    /*
+     * Can't check for ENOTTY: for unknown ioctls the kernel interprets
+     * the argument as a virtio queue id and most likely errors out validating
+     * such id, instead of reporting an unknown operation.
+     */
+    r = vhost_kernel_call(dev, VHOST_SET_FEATURES_ARRAY, &farray);
+    if (!r) {
+        return 0;
+    }
+
+    if (extended_in_use) {
+        error_report("Trying to set extended features without kernel support");
+        return -EINVAL;
+    }
+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &farray.features[0]);
+}
+
+static int vhost_kernel_get_features(struct vhost_dev *dev, uint64_t *features)
+{
+    struct vhost_features farray;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES_ARRAY, &farray);
+    if (r) {
+        memset(&farray, 0, sizeof(farray));
+        r = vhost_kernel_call(dev, VHOST_GET_FEATURES, &farray.features[0]);
+    }
+    if (r) {
+        return r;
+    }
+
+    virtio_features_copy(features, farray.features);
+    return 0;
 }
 
 static int vhost_kernel_set_owner(struct vhost_dev *dev)
@@ -341,8 +381,8 @@ const VhostOps kernel_ops = {
         .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
         .vhost_new_worker = vhost_kernel_new_worker,
         .vhost_free_worker = vhost_kernel_free_worker,
-        .vhost_set_features = vhost_kernel_set_features,
-        .vhost_get_features = vhost_kernel_get_features,
+        .vhost_set_features_ex = vhost_kernel_set_features,
+        .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
-- 
2.51.0


