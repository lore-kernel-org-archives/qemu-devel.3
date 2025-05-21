Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B049C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkF-0003s4-9q; Wed, 21 May 2025 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkD-0003rl-P8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhk8-00019H-T5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Qnkj3gk794sIguByyjpMjyUEyEFTPe94F5f1GjfOo8=;
 b=X3RRqU2iAd3Ga9WUCTF45w5q0o5y6LbWcukTDtEeluzvq631f4gWDmkgdFB/DKXZzo82/u
 uX4R8GEIwMULKy0tPp37UoxH+0PekESFr29C41hqKzZuHeWwyllp2uCMTo3gEUNccBaJWI
 55Gcjxn1NHaB7TVjzeZ0qbMm5+P8YEc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-zSjoF4hBNNyVbJC39j5qHw-1; Wed,
 21 May 2025 07:36:12 -0400
X-MC-Unique: zSjoF4hBNNyVbJC39j5qHw-1
X-Mimecast-MFC-AGG-ID: zSjoF4hBNNyVbJC39j5qHw_1747827371
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 234431956080; Wed, 21 May 2025 11:36:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7251A19560B7; Wed, 21 May 2025 11:36:05 +0000 (UTC)
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
Subject: [PATCH RFC 12/16] virtio-net: implement extended features support.
Date: Wed, 21 May 2025 13:34:06 +0200
Message-ID: <8fb9f142e25a0f1b01e8cf54a6c2a0971db00d83.1747825544.git.pabeni@redhat.com>
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

Use the extended types and helpers to manipulate the virtio_net
features.

Note that offloads are still 64bits wide, as per specification,
and extended offloads will be mapped into such range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/virtio-net.c            | 87 +++++++++++++++++++++-------------
 include/hw/virtio/virtio-net.h |  2 +-
 2 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f500c64e7..193469fc27 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -90,6 +90,17 @@
                                          VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
 
+#define VIRTIO_OFFLOAD_MAP_MIN    46
+#define VIRTIO_OFFLOAD_MAP_LENGTH 4
+#define VIRTIO_OFFLOAD_MAP        MAKE_64BIT_MASK(VIRTIO_OFFLOAD_MAP_MIN, \
+                                                VIRTIO_OFFLOAD_MAP_LENGTH)
+#define VIRTIO_FEATURES_MAP_MIN   65
+#define VIRTIO_O2F_DELTA          (VIRTIO_FEATURES_MAP_MIN - \
+                                   VIRTIO_OFFLOAD_MAP_MIN)
+
+#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
+                                          fbit - VIRTIO_O2F_DELTA : fbit)
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -751,44 +762,45 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
+static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
+                                                 virtio_features_t features,
+                                                 Error **errp)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
 
     /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
+    features |= n->host_features_ex;
 
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+    virtio_add_feature_ex(&features, VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UFO);
     }
 
     if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
     }
 
     if (!get_vhost_net(nc->peer)) {
@@ -796,7 +808,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_RSS);
     }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features_ex = features;
@@ -818,7 +830,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
      * support it.
      */
     if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
     }
 
     return features;
@@ -851,9 +863,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
 }
 
-static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
+static uint64_t virtio_net_features_to_offload(virtio_features_t features)
+{
+    return (features & ~VIRTIO_OFFLOAD_MAP) |
+           ((features >> VIRTIO_O2F_DELTA) & VIRTIO_OFFLOAD_MAP);
+}
+
+static uint64_t
+virtio_net_guest_offloads_by_features(virtio_features_t features)
 {
-    static const uint64_t guest_offloads_mask =
+    static const virtio_features_t guest_offloads_mask =
         (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
         (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
         (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
@@ -862,13 +881,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
         (1ULL << VIRTIO_NET_F_GUEST_USO6);
 
-    return guest_offloads_mask & features;
+    return guest_offloads_mask & virtio_net_features_to_offload(features);
 }
 
 uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
-    return virtio_net_guest_offloads_by_features(vdev->guest_features);
+    return virtio_net_guest_offloads_by_features(vdev->guest_features_ex);
 }
 
 typedef struct {
@@ -947,7 +966,8 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
     error_propagate(errp, err);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
+static void virtio_net_set_features(VirtIODevice *vdev,
+                                    virtio_features_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     Error *err = NULL;
@@ -955,7 +975,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 
     if (n->mtu_bypass_backend &&
             !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
-        features &= ~(1ULL << VIRTIO_NET_F_MTU);
+        features &= ~VIRTIO_BIT(VIRTIO_NET_F_MTU);
     }
 
     virtio_net_set_multiqueue(n,
@@ -1962,10 +1982,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                 virtio_error(vdev, "virtio-net unexpected empty queue: "
                              "i %zd mergeable %d offset %zd, size %zd, "
                              "guest hdr len %zd, host hdr len %zd "
-                             "guest features 0x%" PRIx64,
+                             "guest features 0x" VIRTIO_FEATURES_FMT,
                              i, n->mergeable_rx_bufs, offset, size,
                              n->guest_hdr_len, n->host_hdr_len,
-                             vdev->guest_features);
+                             VIRTIO_FEATURES_HI(vdev->guest_features_ex),
+                             VIRTIO_FEATURES_LOW(vdev->guest_features_ex));
             }
             err = -1;
             goto err;
@@ -4146,8 +4167,8 @@ static void virtio_net_class_init(ObjectClass *klass, const void *data)
     vdc->unrealize = virtio_net_device_unrealize;
     vdc->get_config = virtio_net_get_config;
     vdc->set_config = virtio_net_set_config;
-    vdc->get_features = virtio_net_get_features;
-    vdc->set_features = virtio_net_set_features;
+    vdc->get_features_ex = virtio_net_get_features;
+    vdc->set_features_ex = virtio_net_set_features;
     vdc->bad_features = virtio_net_bad_features;
     vdc->reset = virtio_net_reset;
     vdc->queue_reset = virtio_net_queue_reset;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b9ea9e824e..5ccdbeb253 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -178,7 +178,7 @@ struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint64_t host_features;
+    DECLARE_FEATURES(host_features);
     uint32_t rsc_timeout;
     uint8_t rsc4_enabled;
     uint8_t rsc6_enabled;
-- 
2.49.0


