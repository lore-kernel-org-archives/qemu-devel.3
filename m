Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA89C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkD-0003rP-LY; Wed, 21 May 2025 07:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhk0-0003f7-T7
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjx-00017c-PA
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VNFzrq/Ooi4pork00bC5nqjr61W6Qox9V85Ynz5t7U=;
 b=QmjUdFsDTQmhbIgD9N2hIXfjduol7E10N4iaWLz3jsYQ32G133pPipkHCv3gmDI8LIMQz6
 RcAJVpUrpkyccukos85wRY7TqnMGCCTR6lPoLUw44U+HGu5BzbeQNe31VBR4uk6rvX04en
 9kQDxPl8qluQ6o/0S43vij0HWzJ9gn4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-r1Rv4ylxPbKJjYg9vDuZTg-1; Wed,
 21 May 2025 07:36:00 -0400
X-MC-Unique: r1Rv4ylxPbKJjYg9vDuZTg-1
X-Mimecast-MFC-AGG-ID: r1Rv4ylxPbKJjYg9vDuZTg_1747827359
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7814180034A; Wed, 21 May 2025 11:35:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71FA419560B7; Wed, 21 May 2025 11:35:53 +0000 (UTC)
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
Subject: [PATCH RFC 10/16] vhost-net: implement extended features support.
Date: Wed, 21 May 2025 13:34:04 +0200
Message-ID: <625a5d2173d582e58f90c96897e2ca569c73e4c3.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Update the features manipulation helpers to cope with the
extended features, adjust the relevant format strings accordingly
and always use the virtio features type for bitmask manipulation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/vhost_net-stub.c |  7 ++++---
 hw/net/vhost_net.c      | 31 ++++++++++++++++++-------------
 include/net/vhost_net.h |  8 +++++---
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e..3997b3b814 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -47,7 +47,8 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+virtio_features_t vhost_net_get_features(struct vhost_net *net,
+                                         virtio_features_t features)
 {
     return features;
 }
@@ -63,11 +64,11 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return 0;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features(struct vhost_net *net, virtio_features_t features)
 {
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+virtio_features_t vhost_net_get_acked_features(VHostNetState *net)
 {
     return 0;
 }
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 891f235a0a..58d7619fc8 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -121,7 +121,8 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
     return feature_bits;
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+virtio_features_t vhost_net_get_features(struct vhost_net *net,
+                                         virtio_features_t features)
 {
     return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
             features);
@@ -137,7 +138,7 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features(struct vhost_net *net, virtio_features_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
     vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
@@ -148,7 +149,7 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return net->dev.max_queues;
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+virtio_features_t vhost_net_get_acked_features(VHostNetState *net)
 {
     return net->dev.acked_features;
 }
@@ -317,10 +318,11 @@ static int vhost_net_get_fd(NetClientState *backend)
 
 struct vhost_net *vhost_net_init(VhostNetOptions *options)
 {
+    virtio_features_t missing_features;
     int r;
     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
     struct vhost_net *net = g_new0(struct vhost_net, 1);
-    uint64_t features = 0;
+    virtio_features_t features = 0;
     Error *local_err = NULL;
 
     if (!options->net_backend) {
@@ -361,12 +363,14 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     if (backend_kernel) {
         if (!qemu_has_vnet_hdr_len(options->net_backend,
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
-            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
+            net->dev.features &= ~VIRTIO_BIT(VIRTIO_NET_F_MRG_RXBUF);
         }
-        if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                   " for backend\n",
-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
+
+        missing_features = ~net->dev.features & net->dev.backend_features;
+        if (missing_features) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                   " for backend\n", VIRTIO_FEATURES_HI(missing_features),
+                   VIRTIO_FEATURES_LOW(missing_features));
             goto fail;
         }
     }
@@ -375,10 +379,11 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
 #ifdef CONFIG_VHOST_NET_USER
     if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
         features = vhost_user_get_acked_features(net->nc);
-        if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
+        missing_features = ~net->dev.features & features;
+        if (missing_features) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                    " for backend\n", VIRTIO_FEATURES_HI(missing_features),
+                    VIRTIO_FEATURES_LOW(missing_features));
             goto fail;
         }
     }
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c6a5361a2a..d7d733b7ad 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -2,6 +2,7 @@
 #define VHOST_NET_H
 
 #include "net/net.h"
+#include "hw/virtio/virtio-features.h"
 #include "hw/virtio/vhost-backend.h"
 
 struct vhost_net;
@@ -25,8 +26,9 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
 
 void vhost_net_cleanup(VHostNetState *net);
 
-uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
-void vhost_net_ack_features(VHostNetState *net, uint64_t features);
+virtio_features_t vhost_net_get_features(VHostNetState *net,
+                                         virtio_features_t features);
+void vhost_net_ack_features(VHostNetState *net, virtio_features_t features);
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len);
@@ -43,7 +45,7 @@ VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_set_vring_enable(NetClientState * nc, int enable);
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net);
+virtio_features_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
-- 
2.49.0


