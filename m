Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D131CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3WC-0003Jf-6a; Fri, 12 Sep 2025 09:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3W7-0003Gi-9g
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3W4-0007KF-Iv
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757682516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLLpaL6Bh6GSzg23z27uRaeUXHzRJLLOzHU4uQWQnGA=;
 b=WHFIWpVS9ISEwveoviJ0yyDZn56aiA+7dSZW9ma2+9HtJCB/aWtNKkTDkFfx3StWdfbNSo
 4Zn67CGUQVZiOJbagu8ep/Huussmge8w/2sGr6JUIQiyA2pjrbLb180/tUjFGrSwn+M57c
 A1Hgvt7tqsrLNufFGlnjCFz2RZc1Q7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-v1yF-b1uNXyzDw5wusftxg-1; Fri,
 12 Sep 2025 09:08:31 -0400
X-MC-Unique: v1yF-b1uNXyzDw5wusftxg-1
X-Mimecast-MFC-AGG-ID: v1yF-b1uNXyzDw5wusftxg_1757682510
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858CB1955EAC; Fri, 12 Sep 2025 13:08:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E757A1954126; Fri, 12 Sep 2025 13:08:25 +0000 (UTC)
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
Subject: [PATCH v6 13/14] net: implement tunnel probing
Date: Fri, 12 Sep 2025 15:07:04 +0200
Message-ID: <5593bacc611b3e9e95cccf6ede12f41731b4e53e.1757676218.git.pabeni@redhat.com>
In-Reply-To: <cover.1757676218.git.pabeni@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

Tap devices support GSO over UDP tunnel offload. Probe for such
feature in a similar manner to other offloads.

GSO over UDP tunnel needs to be enabled in addition to a "plain"
offload (TSO or USO).

No need to check separately for the outer header checksum offload:
ithe kernel is going to support both of them or none.

The new features are disabled by default to avoid compat issues,
and could be enabled, after that hw_compat_10_1 will be added,
together with the related compat entries.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v4 -> v5:
  - disable features by default
  - DEFINE_PROP_FEATURE -> VIRTIO_DEFINE_PROP_FEATURE
  - reformatted props definitions

v3 -> v4:
  - move DEFINE_PROP_FEATURE() in patch 4

v2 -> v3:
  - use bool type for tap_probe_has_tunnel()
  - rebased on top of 2deec9ab7d ("virtio-net: Move
        virtio_net_get_features() down")
  - _array -> _ex

v1 -> v2:
  - peer_has_tunnel return a bool
  - move TUN_F definition in net/tun-linux.h
---
 hw/net/virtio-net.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/net/net.h   |  3 +++
 net/net.c           |  9 +++++++++
 net/tap-bsd.c       |  5 +++++
 net/tap-linux.c     | 11 +++++++++++
 net/tap-linux.h     |  9 +++++++++
 net/tap-solaris.c   |  5 +++++
 net/tap-stub.c      |  5 +++++
 net/tap.c           | 11 +++++++++++
 net/tap_int.h       |  1 +
 10 files changed, 100 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 89cf008401..0abb8c8a62 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
     return qemu_has_uso(qemu_get_queue(n->nic)->peer);
 }
 
+static bool peer_has_tunnel(VirtIONet *n)
+{
+    if (!peer_has_vnet_hdr(n)) {
+        return false;
+    }
+
+    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
+}
+
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                        int version_1, int hash_report)
 {
@@ -3073,6 +3082,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
 
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+
         virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
     }
 
@@ -3086,6 +3102,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
     }
 
+    if (!peer_has_tunnel(n)) {
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+    }
+
     if (!get_vhost_net(nc->peer)) {
         if (!use_own_hash) {
             virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
@@ -4248,6 +4273,22 @@ static const Property virtio_net_properties[] = {
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
                                   ON_OFF_AUTO_AUTO),
+    VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
+                               false),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/net/net.h b/include/net/net.h
index 48ba333d02..9a9084690d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -65,6 +65,7 @@ typedef void (NetClientDestructor)(NetClientState *);
 typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
 typedef bool (HasUso)(NetClientState *);
+typedef bool (HasTunnel)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, const NetOffloads *);
@@ -95,6 +96,7 @@ typedef struct NetClientInfo {
     NetPoll *poll;
     HasUfo *has_ufo;
     HasUso *has_uso;
+    HasTunnel *has_tunnel;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
     SetOffload *set_offload;
@@ -197,6 +199,7 @@ void qemu_set_info_str(NetClientState *nc,
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_uso(NetClientState *nc);
+bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
diff --git a/net/net.c b/net/net.c
index 63872b6855..9536184a0c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -522,6 +522,15 @@ bool qemu_has_uso(NetClientState *nc)
     return nc->info->has_uso(nc);
 }
 
+bool qemu_has_tunnel(NetClientState *nc)
+{
+    if (!nc || !nc->info->has_tunnel) {
+        return false;
+    }
+
+    return nc->info->has_tunnel(nc);
+}
+
 bool qemu_has_vnet_hdr(NetClientState *nc)
 {
     if (!nc || !nc->info->has_vnet_hdr) {
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 86b6edee94..751d4c819c 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index a1c58f74f5..e2628be798 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -196,6 +196,17 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    unsigned offload;
+
+    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
+        return false;
+    }
+    return true;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 9a58cecb7f..8cd6b5874b 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -53,4 +53,13 @@
 #define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
 #define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
 
+/* I can handle TSO/USO for UDP tunneled packets */
+#define TUN_F_UDP_TUNNEL_GSO       0x080
+
+/*
+ * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
+ * the outer header
+ */
+#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
+
 #endif /* QEMU_TAP_LINUX_H */
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 833c066bee..ac1ae25761 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -222,6 +222,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 67d14ad4d5..f7a5e0c163 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index 72046a43aa..9f65e3fb3d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -76,6 +76,7 @@ typedef struct TAPState {
     bool using_vnet_hdr;
     bool has_ufo;
     bool has_uso;
+    bool has_tunnel;
     bool enabled;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
@@ -246,6 +247,14 @@ static bool tap_has_uso(NetClientState *nc)
     return s->has_uso;
 }
 
+static bool tap_has_tunnel(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return s->has_tunnel;
+}
+
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -374,6 +383,7 @@ static NetClientInfo net_tap_info = {
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
     .has_uso = tap_has_uso,
+    .has_tunnel = tap_has_tunnel,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
@@ -403,6 +413,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
+    s->has_tunnel = tap_probe_has_tunnel(s->fd);
     s->enabled = true;
     tap_set_offload(&s->nc, &ol);
     /*
diff --git a/net/tap_int.h b/net/tap_int.h
index f8bbe1cb0c..b76a05044b 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -38,6 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
+bool tap_probe_has_tunnel(int fd);
 void tap_fd_set_offload(int fd, const NetOffloads *ol);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
-- 
2.51.0


