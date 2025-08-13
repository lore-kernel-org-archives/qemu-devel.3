Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D5CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 10:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um8kc-0000Gu-SL; Wed, 13 Aug 2025 06:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8kY-0000EV-Vi
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8kV-0007uV-HV
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755081026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw8R05jUoGZMznADNX0sGy0BtZCXHGMJo1qDTDVVWKw=;
 b=TxEQRzwc1JnauvpRatxHydNQa1MoMZGrQLLUROMYxIbUhjsq3muTxeILFhfwwqbKuW8XP+
 eZ2Mj45LUdSp9/EwL7C3BbMsXHWrzH4q1clRncU4rBrYLTlmY7Iq1Av/0mbgs2Wp+Hg4bH
 xbsAqS4kajJ9gyZjwyNpC30JSzGIwwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-kFcQful-MdaYEVTnzbN0tw-1; Wed,
 13 Aug 2025 06:30:24 -0400
X-MC-Unique: kFcQful-MdaYEVTnzbN0tw-1
X-Mimecast-MFC-AGG-ID: kFcQful-MdaYEVTnzbN0tw_1755081023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FA9F180034A; Wed, 13 Aug 2025 10:30:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A61419560AB; Wed, 13 Aug 2025 10:30:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 13/13] net: implement UDP tunnel features offloading
Date: Wed, 13 Aug 2025 12:28:26 +0200
Message-ID: <df42c6a37a1ea4ce4093802ba142ec8ab9b1140c.1755080614.git.pabeni@redhat.com>
In-Reply-To: <cover.1755080613.git.pabeni@redhat.com>
References: <cover.1755080613.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

When any host or guest GSO over UDP tunnel offload is enabled the
virtio net header includes the additional tunnel-related fields,
update the size accordingly.

Push the GSO over UDP tunnel offloads all the way down to the tap
device extending the newly introduced NetFeatures struct, and
eventually enable the associated features.

As per virtio specification, to convert features bit to offload bit,
map the extended features into the reserved range.

Finally, make the vhost backend aware of the exact header layout, to
copy it correctly. The tunnel-related field are present if either
the guest or the host negotiated any UDP tunnel related feature:
add them to the kernel supported features list, to allow qemu
transfer to the backend the needed information.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - '|' -> '||'

v2 -> v3:
  - rebased on top of "net: Consolidate vhost feature bits into vhost_net
    structure"
  - _array -> _ex

v1 -> v2:
  - squashed vhost support into this patch
  - dropped tun offload consistency checks; they are implemented in
    the kernel side
  - virtio_has_tnl_hdr ->virtio_has_tunnel_hdr
---
 hw/net/virtio-net.c | 34 ++++++++++++++++++++++++++--------
 include/net/net.h   |  2 ++
 net/net.c           |  3 ++-
 net/tap-linux.c     |  6 ++++++
 net/tap.c           |  2 ++
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0abb8c8a62..f021663f92 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -103,6 +103,12 @@
 #define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
                                        VIRTIO_NET_FEATURES_MAP_MIN + 64)
 
+static bool virtio_has_tunnel_hdr(const uint64_t *features)
+{
+    return virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
+           virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+}
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -659,7 +665,8 @@ static bool peer_has_tunnel(VirtIONet *n)
 }
 
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
-                                       int version_1, int hash_report)
+                                       int version_1, int hash_report,
+                                       int tunnel)
 {
     int i;
     NetClientState *nc;
@@ -667,9 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
     if (version_1) {
-        n->guest_hdr_len = hash_report ?
-            sizeof(struct virtio_net_hdr_v1_hash) :
-            sizeof(struct virtio_net_hdr_mrg_rxbuf);
+        n->guest_hdr_len = tunnel ?
+            sizeof(struct virtio_net_hdr_v1_hash_tunnel) :
+            (hash_report ?
+             sizeof(struct virtio_net_hdr_v1_hash) :
+             sizeof(struct virtio_net_hdr_mrg_rxbuf));
         n->rss_data.populate_hash = !!hash_report;
     } else {
         n->guest_hdr_len = n->mergeable_rx_bufs ?
@@ -803,6 +812,10 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
        .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
        .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
        .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
+       .tnl  = !!(n->curr_guest_offloads &
+                  (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED)),
+       .tnl_csum = !!(n->curr_guest_offloads &
+                      (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED)),
     };
 
     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
@@ -824,7 +837,9 @@ virtio_net_guest_offloads_by_features(const uint64_t *features)
         (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
         (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
-        (1ULL << VIRTIO_NET_F_GUEST_USO6);
+        (1ULL << VIRTIO_NET_F_GUEST_USO6) |
+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) |
+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED);
 
     return guest_offloads_mask & virtio_net_features_to_offload(features);
 }
@@ -937,7 +952,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
                                virtio_has_feature_ex(features,
                                                   VIRTIO_F_VERSION_1),
                                virtio_has_feature_ex(features,
-                                                  VIRTIO_NET_F_HASH_REPORT));
+                                                  VIRTIO_NET_F_HASH_REPORT),
+                               virtio_has_tunnel_hdr(features));
 
     n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
@@ -3163,13 +3179,15 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
+    bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_1),
                                virtio_vdev_has_feature(vdev,
-                                                       VIRTIO_NET_F_HASH_REPORT));
+                                                      VIRTIO_NET_F_HASH_REPORT),
+                               has_tunnel_hdr);
 
     /* MAC_TABLE_ENTRIES may be different from the saved image */
     if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
@@ -3989,7 +4007,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
-    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
+    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
     n->promisc = 1; /* for compatibility */
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
diff --git a/include/net/net.h b/include/net/net.h
index 9a9084690d..72b476ee1d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -43,6 +43,8 @@ typedef struct NetOffloads {
     bool ufo;
     bool uso4;
     bool uso6;
+    bool tnl;
+    bool tnl_csum;
 } NetOffloads;
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
diff --git a/net/net.c b/net/net.c
index 9536184a0c..27e0d27807 100644
--- a/net/net.c
+++ b/net/net.c
@@ -575,7 +575,8 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
            len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
+           len == sizeof(struct virtio_net_hdr_v1_hash) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash_tunnel));
 
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
diff --git a/net/tap-linux.c b/net/tap-linux.c
index e2628be798..8e275d2ea4 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -279,6 +279,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
         if (ol->uso6) {
             offload |= TUN_F_USO6;
         }
+        if (ol->tnl) {
+            offload |= TUN_F_UDP_TUNNEL_GSO;
+        }
+        if (ol->tnl_csum) {
+            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
+        }
     }
 
     if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
diff --git a/net/tap.c b/net/tap.c
index 9f65e3fb3d..dc2a2859ec 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -62,6 +62,8 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
2.50.1


