Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C35FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkP-00042F-JM; Wed, 21 May 2025 07:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkN-00041X-Ei
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkK-0001AH-Ut
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vA1d/ZWaKK3z0tALUDfF3uh5oVonzx2JrfcgtKWPP5s=;
 b=Fgfrsf3GcZemxWMa1wg71FhbEGRG1XI82jZa/0qHIcsMUehgKv9SsX8TFV4TcfxzgIeMVo
 zzNuW6GpEwpCevE6Qv8e135djsbd8eC6UXQHr7oRKKg0RbBjZi7cV5HByu5kScgIxB2iUF
 7HUimDrgcfSoiHaOpDTNyiACK7bHuoQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-LyxuLCPpNnmhL4AgDH5d5Q-1; Wed,
 21 May 2025 07:36:18 -0400
X-MC-Unique: LyxuLCPpNnmhL4AgDH5d5Q-1
X-Mimecast-MFC-AGG-ID: LyxuLCPpNnmhL4AgDH5d5Q_1747827377
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F795180048E; Wed, 21 May 2025 11:36:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3FF3195607A; Wed, 21 May 2025 11:36:11 +0000 (UTC)
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
Subject: [PATCH RFC 13/16] net: implement tunnel probing
Date: Wed, 21 May 2025 13:34:07 +0200
Message-ID: <b0e5839ab3e723247b12ddecf36c75c51c5a0b83.1747825544.git.pabeni@redhat.com>
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

Tap devices support GSO over UDP tunnel offload. Probe for such
feature in a similar manner to other offloads.

GSO over UDP tunnel needs to be enabled in addition to  a "plain"
offload (TSO or USO).

No need to check separately for the outer header checksum offload:
the kernel is going to support both of them or none.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/virtio-net.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/net/net.h   |  3 +++
 net/net.c           |  9 +++++++++
 net/tap-bsd.c       |  5 +++++
 net/tap-linux.c     | 19 +++++++++++++++++++
 net/tap-solaris.c   |  5 +++++
 net/tap-stub.c      |  5 +++++
 net/tap.c           | 11 +++++++++++
 net/tap_int.h       |  1 +
 9 files changed, 97 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 193469fc27..05cf23700f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -646,6 +646,15 @@ static int peer_has_uso(VirtIONet *n)
     return qemu_has_uso(qemu_get_queue(n->nic)->peer);
 }
 
+static int peer_has_tunnel(VirtIONet *n)
+{
+    if (!peer_has_vnet_hdr(n)) {
+        return 0;
+    }
+
+    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
+}
+
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                        int version_1, int hash_report)
 {
@@ -789,6 +798,15 @@ static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
         virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
         virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
 
+#ifdef CONFIG_INT128
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(&features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(&features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+#endif
+
         virtio_clear_feature_ex(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
@@ -803,6 +821,17 @@ static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
         virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
     }
 
+#ifdef CONFIG_INT128
+    if (!peer_has_tunnel(n)) {
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(&features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(&features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+    }
+#endif
+
     if (!get_vhost_net(nc->peer)) {
         return features;
     }
@@ -4153,6 +4182,16 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+#ifdef CONFIG_INT128
+    DEFINE_PROP_BITVF("host_tunnel", VirtIONet, host_features_ex,
+                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
+    DEFINE_PROP_BITVF("host_tunnel_csum", VirtIONet, host_features_ex,
+                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
+    DEFINE_PROP_BITVF("guest_tunnel", VirtIONet, host_features_ex,
+                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
+    DEFINE_PROP_BITVF("guest_tunnel_csum", VirtIONet, host_features_ex,
+                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
+#endif
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0..391d983e49 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -55,6 +55,7 @@ typedef void (NetClientDestructor)(NetClientState *);
 typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
 typedef bool (HasUso)(NetClientState *);
+typedef bool (HasTunnel)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
@@ -83,6 +84,7 @@ typedef struct NetClientInfo {
     NetPoll *poll;
     HasUfo *has_ufo;
     HasUso *has_uso;
+    HasTunnel *has_tunnel;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
     SetOffload *set_offload;
@@ -183,6 +185,7 @@ void qemu_set_info_str(NetClientState *nc,
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_uso(NetClientState *nc);
+bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
diff --git a/net/net.c b/net/net.c
index 39d6f28158..9c83d3b137 100644
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
index b4c84441ba..3f01c8921e 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+int tap_probe_has_tunnel(int fd)
+{
+    return 0;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2..2df601551e 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -37,6 +37,14 @@
 
 #define PATH_NET_TUN "/dev/net/tun"
 
+#ifndef TUN_F_UDP_TUNNEL_GSO
+#define TUN_F_UDP_TUNNEL_GSO       0x080
+#endif
+
+#ifndef TUN_F_UDP_TUNNEL_GSO_CSUM
+#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
+#endif
+
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp)
 {
@@ -196,6 +204,17 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+int tap_probe_has_tunnel(int fd)
+{
+    unsigned offload;
+
+    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
+        return 0;
+    }
+    return 1;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 51b7830bef..b1aa40d46b 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,6 +221,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+int tap_probe_has_tunnel(int fd)
+{
+    return 0;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 38673434cb..5f57d6baac 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+int tap_probe_has_tunnel(int fd)
+{
+    return 0;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index ae1c7e3983..f6e8cd5f1c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -58,6 +58,7 @@ typedef struct TAPState {
     bool using_vnet_hdr;
     bool has_ufo;
     bool has_uso;
+    bool has_tunnel;
     bool enabled;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
@@ -223,6 +224,14 @@ static bool tap_has_uso(NetClientState *nc)
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
@@ -340,6 +349,7 @@ static NetClientInfo net_tap_info = {
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
     .has_uso = tap_has_uso,
+    .has_tunnel = tap_has_tunnel,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
@@ -367,6 +377,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
+    s->has_tunnel = tap_probe_has_tunnel(s->fd);
     s->enabled = true;
     tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
     /*
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d..2a8aa3632f 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -37,6 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
+int tap_probe_has_tunnel(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
                         int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
-- 
2.49.0


