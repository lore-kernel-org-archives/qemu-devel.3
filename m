Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCF8C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkY-000499-2b; Wed, 21 May 2025 07:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkW-00043S-CS
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkS-0001B9-AA
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ke938JlAVnXEmFCrTD9zD7lx45OmWvtzIdYYyeHEI8k=;
 b=IVyLg5R9TveDLgPSVR0EpQhqsnXUKe9nCtCXVTZC72/BCVgx+d7STBHVAWThCFWY5qlX3M
 86hB55HOLUJI37AFETbKpXKXPQIGOO2Q75fdLCFstCjb4g78j863kOo+g/xYFgqQDZHWDL
 q8SGU5tEHmyr+1K+r0VOkjoW+wqNeYw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611--tpLgiI_OimjT0_KhGDAew-1; Wed,
 21 May 2025 07:36:31 -0400
X-MC-Unique: -tpLgiI_OimjT0_KhGDAew-1
X-Mimecast-MFC-AGG-ID: -tpLgiI_OimjT0_KhGDAew_1747827389
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99467180098D; Wed, 21 May 2025 11:36:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B85A919560B7; Wed, 21 May 2025 11:36:23 +0000 (UTC)
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
Subject: [PATCH RFC 15/16] net: implement tnl feature offloading
Date: Wed, 21 May 2025 13:34:09 +0200
Message-ID: <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
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

When any host or guest GSO over UDP tunnel offload is enabled the
virtio net header includes the additional tunnel-related fields,
update the size accordingly.

Push the GSO over UDP tunnel offloads all the way down to the tap
device extending the newly introduced NetFeatures struct, and
eventually enable the associated features.

As per virtio specification, to convert features bit to offload bit,
map the extended features into the reserved range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/virtio-net.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 include/net/net.h   |  2 ++
 net/net.c           |  7 ++++++-
 net/tap-linux.c     |  6 ++++++
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 881877086e..758ceaffba 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -101,6 +101,27 @@
 #define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
                                           fbit - VIRTIO_O2F_DELTA : fbit)
 
+#ifdef CONFIG_INT128
+#define VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO \
+    VIRTIO_FEATURE_TO_OFFLOAD(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO)
+#define VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM \
+    VIRTIO_FEATURE_TO_OFFLOAD(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM)
+
+static bool virtio_has_tnl_hdr(virtio_features_t features)
+{
+    return virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+           virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+}
+
+#else
+
+static bool virtio_has_tnl_hdr(virtio_features_t features)
+{
+    return false;
+}
+
+#endif
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -656,7 +677,8 @@ static int peer_has_tunnel(VirtIONet *n)
 }
 
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
-                                       int version_1, int hash_report)
+                                       int version_1, int hash_report,
+                                       int tnl)
 {
     int i;
     NetClientState *nc;
@@ -674,6 +696,9 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
             sizeof(struct virtio_net_hdr);
         n->rss_data.populate_hash = false;
     }
+    if (tnl) {
+        n->guest_hdr_len += sizeof(struct virtio_net_hdr_tunnel);
+    }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
         nc = qemu_get_subqueue(n->nic, i);
@@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
        .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
        .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
        .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
+#ifdef CONFIG_INT128
+       .tnl  = !!(n->curr_guest_offloads &
+                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
+       .tnl_csum = !!(n->curr_guest_offloads &
+                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
+#endif
     };
 
     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
@@ -911,7 +942,12 @@ virtio_net_guest_offloads_by_features(virtio_features_t features)
         (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
         (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
-        (1ULL << VIRTIO_NET_F_GUEST_USO6);
+        (1ULL << VIRTIO_NET_F_GUEST_USO6)
+#ifdef CONFIG_INT128
+        | (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)
+        | (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)
+#endif
+        ;
 
     return guest_offloads_mask & virtio_net_features_to_offload(features);
 }
@@ -1020,7 +1056,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
                                virtio_has_feature(features,
                                                   VIRTIO_F_VERSION_1),
                                virtio_has_feature(features,
-                                                  VIRTIO_NET_F_HASH_REPORT));
+                                                  VIRTIO_NET_F_HASH_REPORT),
+                               virtio_has_tnl_hdr(features));
 
     n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
@@ -3139,7 +3176,8 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_1),
                                virtio_vdev_has_feature(vdev,
-                                                       VIRTIO_NET_F_HASH_REPORT));
+                                                       VIRTIO_NET_F_HASH_REPORT),
+                               virtio_has_tnl_hdr(vdev->guest_features));
 
     /* MAC_TABLE_ENTRIES may be different from the saved image */
     if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
@@ -3946,7 +3984,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
-    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
+    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
     n->promisc = 1; /* for compatibility */
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
diff --git a/include/net/net.h b/include/net/net.h
index c71d7c6074..5049d293f2 100644
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
index 5a2f00c108..bd41229407 100644
--- a/net/net.c
+++ b/net/net.c
@@ -569,13 +569,18 @@ int qemu_get_vnet_hdr_len(NetClientState *nc)
 
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
 {
+    int len_tnl = len - sizeof(struct virtio_net_hdr_tunnel);
+
     if (!nc || !nc->info->set_vnet_hdr_len) {
         return;
     }
 
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
+           len_tnl == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
            len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
+           len_tnl == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash) ||
+           len_tnl == sizeof(struct virtio_net_hdr_v1_hash));
 
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
diff --git a/net/tap-linux.c b/net/tap-linux.c
index aa5f3a6e22..b7662ece63 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -287,6 +287,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
         if (ol->uso6) {
             offload |= TUN_F_USO6;
         }
+        if ((ol->tso4 || ol->tso6 || ol->uso4 || ol->uso6) && ol->tnl) {
+            offload |= TUN_F_UDP_TUNNEL_GSO;
+        }
+        if ((offload & TUN_F_UDP_TUNNEL_GSO) && ol->tnl_csum) {
+            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
+        }
     }
 
     if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
-- 
2.49.0


