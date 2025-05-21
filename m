Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A119C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhk9-0003q6-OO; Wed, 21 May 2025 07:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjx-0003eQ-On
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjo-00016c-Na
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enaBYQCINliwTGyHAbl3e/ASgYxjRCYgvrL673vfrl4=;
 b=dfERX2pT9hB+smp7PJFTWT6wom/nBTsip2Sk2t65wB6UkRYusJsVpdnL1xbxmlYly8XH+L
 d21Vm3GvTIG40pw2c0fhZxHZqRscuevf6+AB0BNn7gPvm7P8lzQfrjTljM548lHVZ3xRX4
 7WiINpio3IIihHgYxaXH3nbdpI//cQ0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-QwiUcKQgMIecFlxLmqYVdg-1; Wed,
 21 May 2025 07:35:54 -0400
X-MC-Unique: QwiUcKQgMIecFlxLmqYVdg-1
X-Mimecast-MFC-AGG-ID: QwiUcKQgMIecFlxLmqYVdg_1747827353
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E266A1954236; Wed, 21 May 2025 11:35:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B85E19560B7; Wed, 21 May 2025 11:35:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 09/16] vhost-backend: implement extended features support.
Date: Wed, 21 May 2025 13:34:03 +0200
Message-ID: <5f1afbf8865c9d51f01aa5ba3b09fb4449c458a0.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/vhost-backend.c | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804dd40..a5e28e15ee 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -182,12 +182,6 @@ static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
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
@@ -210,11 +204,59 @@ static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
     return 0;
 }
 
+#ifdef CONFIG_INT128
+static int vhost_kernel_set_features_ex(struct vhost_dev *dev,
+                                     virtio_features_t features)
+{
+    uint64_t features64;
+    int r;
+
+    /*
+     * Can't check for ENOTTY, as the kernel for unknown ioctls interprets
+     * the argument as a virtio queue id and most likely errors out validating
+     * such id, instead of reporting an unknown operation.
+     */
+    r = vhost_kernel_call(dev, VHOST_SET_FEATURES_EX, &features);
+    if (!r) {
+        return 0;
+    }
+
+    if (!!(features >> 64)) {
+        error_report("Trying to set extended features without kernel support");
+        return -EINVAL;
+    }
+    features64 = (uint64_t)features;
+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features64);
+}
+
+static int vhost_kernel_get_features_ex(struct vhost_dev *dev,
+                                        virtio_features_t *features)
+{
+    uint64_t features64;
+    int r;
+
+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES_EX, features);
+    if (!r) {
+        return 0;
+    }
+
+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES, &features64);
+    *features = features64;
+    return r;
+}
+#else
+static int vhost_kernel_set_features(struct vhost_dev *dev,
+                                     uint64_t features)
+{
+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
+}
+
 static int vhost_kernel_get_features(struct vhost_dev *dev,
                                      uint64_t *features)
 {
     return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
 }
+#endif
 
 static int vhost_kernel_set_owner(struct vhost_dev *dev)
 {
@@ -341,8 +383,13 @@ const VhostOps kernel_ops = {
         .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
         .vhost_new_worker = vhost_kernel_new_worker,
         .vhost_free_worker = vhost_kernel_free_worker,
+#ifdef CONFIG_INT128
+        .vhost_set_features_ex = vhost_kernel_set_features_ex,
+        .vhost_get_features_ex = vhost_kernel_get_features_ex,
+#else
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
+#endif
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
-- 
2.49.0


