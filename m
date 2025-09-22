Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F660CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hP1-00071f-5s; Mon, 22 Sep 2025 10:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0hOw-00070N-FE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0hOp-00073S-NW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758550814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJUEMwk8eVOsIvxuBYIzTBMcSQjlWbM0YhLL6aQ6JSU=;
 b=YXvNTz5GI8DtjR1ItDZmDCXPF6BxC/N/MR/koZY0Yf2gfYJ8oEXeqsZIdJgUOZSLmxBgXK
 Qhwz/DAIJZvAWbtxEAclLQFgji+d/EGPJaPzoAOxgDWmu2mgd/fBCmBa7TsKsmZLZnvCMR
 /rEW9xY59+7cBEv9+tkATGk+2m0nM2I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-DkFl0PpvMrmrXvutYSC6mg-1; Mon,
 22 Sep 2025 10:20:09 -0400
X-MC-Unique: DkFl0PpvMrmrXvutYSC6mg-1
X-Mimecast-MFC-AGG-ID: DkFl0PpvMrmrXvutYSC6mg_1758550808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76217195608B; Mon, 22 Sep 2025 14:20:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.247])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB75C1956045; Mon, 22 Sep 2025 14:20:03 +0000 (UTC)
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
Subject: [PATCH v7 11/14] vhost-net: implement extended features support
Date: Mon, 22 Sep 2025 16:18:25 +0200
Message-ID: <69c78c432e28e146a8874b2a7d00e9cbd111b1ba.1758549625.git.pabeni@redhat.com>
In-Reply-To: <cover.1758549625.git.pabeni@redhat.com>
References: <cover.1758549625.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide extended version of the features manipulation helpers,
and let the device initialization deal with the full features space,
adjusting the relevant format strings accordingly.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - add missing features initialization
  - use new virtio_features macro names

v2 -> v3:
  - use virtio_features_andnot return value instead of virtio_features_empty
  - rebased on top of "net: Consolidate vhost feature bits into vhost_net
    structure"
  - _array -> _ex

v1 -> v2:
  - uint128_t -> uint64_t[]
  - provide extended variant of the features manipulation helpers
---
 hw/net/vhost_net-stub.c |  8 +++-----
 hw/net/vhost_net.c      | 45 +++++++++++++++++++++++------------------
 include/net/vhost_net.h | 33 +++++++++++++++++++++++++++---
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 7d49f82906..0740d5a2eb 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -46,9 +46,8 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return features;
 }
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
@@ -62,13 +61,12 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return 0;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return 0;
 }
 
 bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 540492b37d..a8ee18a912 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -35,10 +35,9 @@
 #include "hw/virtio/virtio-bus.h"
 #include "linux-headers/linux/vhost.h"
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return vhost_get_features(&net->dev, net->feature_bits,
-            features);
+    vhost_get_features_ex(&net->dev, net->feature_bits, features);
 }
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len)
@@ -51,10 +50,11 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
-    net->dev.acked_features = net->dev.backend_features;
-    vhost_ack_features(&net->dev, net->feature_bits, features);
+    virtio_features_copy(net->dev.acked_features_ex,
+                         net->dev.backend_features_ex);
+    vhost_ack_features_ex(&net->dev, net->feature_bits, features);
 }
 
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
@@ -62,9 +62,9 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return net->dev.max_queues;
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return net->dev.acked_features;
+    virtio_features_copy(features, net->dev.acked_features_ex);
 }
 
 void vhost_net_save_acked_features(NetClientState *nc)
@@ -234,7 +234,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     int r;
     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
     struct vhost_net *net = g_new0(struct vhost_net, 1);
-    uint64_t features = 0;
+    uint64_t missing_features[VIRTIO_FEATURES_NU64S];
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     Error *local_err = NULL;
 
     if (!options->net_backend) {
@@ -247,6 +248,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->save_acked_features = options->save_acked_features;
     net->max_tx_queue_size = options->max_tx_queue_size;
     net->is_vhost_user = options->is_vhost_user;
+    virtio_features_clear(features);
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
@@ -261,7 +263,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        net->dev.backend_features = 0;
+        virtio_features_clear(net->dev.backend_features_ex);
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -281,26 +283,29 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
             net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
-        if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                   " for backend\n",
-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
+
+        if (virtio_features_andnot(missing_features,
+                                   net->dev.backend_features_ex,
+                                   net->dev.features_ex)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
 
     /* Set sane init value. Override when guest acks. */
     if (options->get_acked_features) {
-        features = options->get_acked_features(net->nc);
-        if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
+        virtio_features_from_u64(features,
+                                 options->get_acked_features(net->nc));
+        if (virtio_features_andnot(missing_features, features,
+                                   net->dev.features_ex)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                    " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
 
-    vhost_net_ack_features(net, features);
+    vhost_net_ack_features_ex(net, features);
 
     return net;
 
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 879781dad7..0225207491 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -2,6 +2,7 @@
 #define VHOST_NET_H
 
 #include "net/net.h"
+#include "hw/virtio/virtio-features.h"
 #include "hw/virtio/vhost-backend.h"
 
 struct vhost_net;
@@ -33,8 +34,26 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
 
 void vhost_net_cleanup(VHostNetState *net);
 
-uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
-void vhost_net_ack_features(VHostNetState *net, uint64_t features);
+void vhost_net_get_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_features(VHostNetState *net,
+                                              uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_get_features_ex(net, features_array);
+    return features_array[0];
+}
+
+void vhost_net_ack_features_ex(VHostNetState *net, const uint64_t *features);
+static inline void vhost_net_ack_features(VHostNetState *net,
+                                          uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_ack_features_ex(net, features_array);
+}
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len);
@@ -51,7 +70,15 @@ VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_net_set_vring_enable(NetClientState *nc, int enable);
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net);
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_acked_features(VHostNetState *net)
+{
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+
+    vhost_net_get_acked_features_ex(net, features);
+    assert(!virtio_features_use_ex(features));
+    return features[0];
+}
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
-- 
2.51.0


