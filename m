Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D0ACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3WA-0003HN-JD; Fri, 12 Sep 2025 09:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3W1-0003CX-Dd
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3Vw-0007JR-Qh
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757682509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0A7u65zRQL5EHUSUWrBXa0BVPeE0NZxf3dKBdTdVm7U=;
 b=bG7ZK0qRDH68EmH1JDjx37wHw9kLsURKtygwsxAqpBnk3IfWci+8hIBKicGqDcFwv5cjly
 sLgOJSmC4IzOJfM2RSS1M/vvXfPq0xCyIbs68cgVaaVzs76pbozPBtlnmHDA1RqZcpDSpb
 e5nU6e74soZkLInF3HdjRXtPBR34N/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-jGiW-M0hMeGFVR-g_CJqVQ-1; Fri,
 12 Sep 2025 09:08:26 -0400
X-MC-Unique: jGiW-M0hMeGFVR-g_CJqVQ-1
X-Mimecast-MFC-AGG-ID: jGiW-M0hMeGFVR-g_CJqVQ_1757682505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 372051800366; Fri, 12 Sep 2025 13:08:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B1D41944CCA; Fri, 12 Sep 2025 13:08:20 +0000 (UTC)
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
Subject: [PATCH v6 12/14] virtio-net: implement extended features support
Date: Fri, 12 Sep 2025 15:07:03 +0200
Message-ID: <1cbebc62028279af97a823ebea3253efd36a7a11.1757676218.git.pabeni@redhat.com>
In-Reply-To: <cover.1757676218.git.pabeni@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use the extended types and helpers to manipulate the virtio_net
features.

Note that offloads are still 64bits wide, as per specification,
and extended offloads will be mapped into such range.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - rebased on top of 6071d13c6a37

v3 -> v4:
  - use new virtio_features macro names

v2 -> v3:
  - rebased on top of 2deec9ab7d ("virtio-net: Move
    virtio_net_get_features() down")
  - _array -> _ex

v1 -> v2:
  - uint128_t -> uint64_t[]
  - more verbose macro definitions
---
 hw/net/virtio-net.c            | 140 +++++++++++++++++++--------------
 include/hw/virtio/virtio-net.h |   2 +-
 2 files changed, 83 insertions(+), 59 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b86ba1fd27..89cf008401 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -90,6 +90,19 @@
                                          VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
 
+/*
+ * Features starting from VIRTIO_NET_FEATURES_MAP_MIN bit correspond
+ * to guest offloads in the VIRTIO_NET_OFFLOAD_MAP range
+ */
+#define VIRTIO_NET_OFFLOAD_MAP_MIN    46
+#define VIRTIO_NET_OFFLOAD_MAP_LENGTH 4
+#define VIRTIO_NET_OFFLOAD_MAP        MAKE_64BIT_MASK(                    \
+                                              VIRTIO_NET_OFFLOAD_MAP_MIN, \
+                                              VIRTIO_NET_OFFLOAD_MAP_LENGTH)
+#define VIRTIO_NET_FEATURES_MAP_MIN   65
+#define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
+                                       VIRTIO_NET_FEATURES_MAP_MIN + 64)
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -786,7 +799,14 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
 }
 
-static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
+static uint64_t virtio_net_features_to_offload(const uint64_t *features)
+{
+    return (features[0] & ~VIRTIO_NET_OFFLOAD_MAP) |
+           ((features[1] << VIRTIO_NET_F2O_SHIFT) & VIRTIO_NET_OFFLOAD_MAP);
+}
+
+static uint64_t
+virtio_net_guest_offloads_by_features(const uint64_t *features)
 {
     static const uint64_t guest_offloads_mask =
         (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
@@ -797,13 +817,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
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
@@ -882,34 +902,39 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
     error_propagate(errp, err);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
+static void virtio_net_set_features(VirtIODevice *vdev,
+                                    const uint64_t *in_features)
 {
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     VirtIONet *n = VIRTIO_NET(vdev);
     Error *err = NULL;
     int i;
 
+    virtio_features_copy(features, in_features);
     if (n->mtu_bypass_backend &&
             !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
-        features &= ~(1ULL << VIRTIO_NET_F_MTU);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
     virtio_net_set_multiqueue(n,
-                              virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
-                              virtio_has_feature(features, VIRTIO_NET_F_MQ));
+                              virtio_has_feature_ex(features,
+                                                    VIRTIO_NET_F_RSS) ||
+                              virtio_has_feature_ex(features,
+                                                    VIRTIO_NET_F_MQ));
 
     virtio_net_set_mrg_rx_bufs(n,
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_NET_F_MRG_RXBUF),
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_F_VERSION_1),
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_NET_F_HASH_REPORT));
 
-    n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
-        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
-    n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
-        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
-    n->rss_data.redirect = virtio_has_feature(features, VIRTIO_NET_F_RSS);
+    n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
+        virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
+    n->rsc6_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
+        virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
+    n->rss_data.redirect = virtio_has_feature_ex(features, VIRTIO_NET_F_RSS);
 
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
@@ -923,7 +948,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         if (!get_vhost_net(nc->peer)) {
             continue;
         }
-        vhost_net_ack_features(get_vhost_net(nc->peer), features);
+        vhost_net_ack_features_ex(get_vhost_net(nc->peer), features);
 
         /*
          * keep acked_features in NetVhostUserState up-to-date so it
@@ -932,12 +957,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
-        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+    if (virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN) !=
+        virtio_has_feature_ex(vdev->guest_features_ex,
+                              VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN);
         memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
-    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+    if (virtio_has_feature_ex(features, VIRTIO_NET_F_STANDBY)) {
         qapi_event_send_failover_negotiated(n->netclient_name);
         qatomic_set(&n->failover_primary_hidden, false);
         failover_add_primary(n, &err);
@@ -1902,10 +1929,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                 virtio_error(vdev, "virtio-net unexpected empty queue: "
                              "i %zd mergeable %d offset %zd, size %zd, "
                              "guest hdr len %zd, host hdr len %zd "
-                             "guest features 0x%" PRIx64,
+                             "guest features 0x" VIRTIO_FEATURES_FMT,
                              i, n->mergeable_rx_bufs, offset, size,
                              n->guest_hdr_len, n->host_hdr_len,
-                             vdev->guest_features);
+                             VIRTIO_FEATURES_PR(vdev->guest_features_ex));
             }
             err = -1;
             goto err;
@@ -3012,8 +3039,8 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
     return 0;
 }
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
+static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
+                                    Error **errp)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
@@ -3027,68 +3054,67 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         (supported_hash_types & peer_hash_types) == supported_hash_types;
 
     /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
+    virtio_features_or(features, features, n->host_features_ex);
 
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+    virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
     }
-
     if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
     }
 
     if (!get_vhost_net(nc->peer)) {
         if (!use_own_hash) {
-            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+        } else if (virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
             virtio_net_load_ebpf(n, errp);
         }
 
-        return features;
+        return;
     }
 
     if (!use_peer_hash) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
 
         if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
             if (!virtio_net_load_ebpf(n, errp)) {
-                return features;
+                return;
             }
 
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
         }
     }
 
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
+    vhost_net_get_features_ex(get_vhost_net(nc->peer), features);
+    virtio_features_copy(vdev->backend_features_ex, features);
 
     if (n->mtu_bypass_backend &&
             (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
-        features |= (1ULL << VIRTIO_NET_F_MTU);
+        virtio_add_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
     /*
@@ -3103,10 +3129,8 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
      * support it.
      */
     if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ANNOUNCE);
     }
-
-    return features;
 }
 
 static int virtio_net_post_load_device(void *opaque, int version_id)
@@ -4238,8 +4262,8 @@ static void virtio_net_class_init(ObjectClass *klass, const void *data)
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
index 73fdefc0dc..5b8ab7bda7 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -182,7 +182,7 @@ struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint64_t host_features;
+    VIRTIO_DECLARE_FEATURES(host_features);
     uint32_t rsc_timeout;
     uint8_t rsc4_enabled;
     uint8_t rsc6_enabled;
-- 
2.51.0


