Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A04C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkV-00043P-1r; Wed, 21 May 2025 07:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkT-00043A-Fr
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhkN-0001Am-K7
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMjzeewNVky4/obxdybXw193KgJIslzO/xqBUfEBPds=;
 b=ATvFcfNikv97VWHw6oYZWRsGC44apbRyp0wvqvSOJ6tnNNZhsAHSVSpFMsS09GDhTWdwON
 tiXsIDipixaC89GLYq0bi345AU6B3UA7fPoIQbrexqMlnmf1iuEgODg+RUDINOLz5fQg37
 yG+by2IMB9sJLumRearDE4juV2UQFGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-07EyYkpuMp6FMnF_MUBfZQ-1; Wed,
 21 May 2025 07:36:24 -0400
X-MC-Unique: 07EyYkpuMp6FMnF_MUBfZQ-1
X-Mimecast-MFC-AGG-ID: 07EyYkpuMp6FMnF_MUBfZQ_1747827383
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3862719560B4; Wed, 21 May 2025 11:36:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B29B519560B7; Wed, 21 May 2025 11:36:17 +0000 (UTC)
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
Subject: [PATCH RFC 14/16] net: bundle all offloads in a single struct
Date: Wed, 21 May 2025 13:34:08 +0200
Message-ID: <828ccacae4b84313327242cd716f46f711d5849b.1747825544.git.pabeni@redhat.com>
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

The set_offload() argument list is already pretty long and
we are going to introduce soon a bunch of additional offloads.

Replace the offload arguments with a single struct and update
all the relevant call-sites.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/e1000e_core.c |  5 +++--
 hw/net/igb_core.c    |  5 +++--
 hw/net/virtio-net.c  | 19 +++++++++++--------
 hw/net/vmxnet3.c     | 13 +++++--------
 include/net/net.h    | 15 ++++++++++++---
 net/net.c            |  5 ++---
 net/netmap.c         |  3 +--
 net/tap-bsd.c        |  3 +--
 net/tap-linux.c      | 21 ++++++++++++---------
 net/tap-solaris.c    |  4 ++--
 net/tap-stub.c       |  3 +--
 net/tap.c            |  8 ++++----
 net/tap_int.h        |  4 ++--
 13 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2413858790..ec90869e56 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2827,8 +2827,9 @@ e1000e_update_rx_offloads(E1000ECore *core)
     trace_e1000e_rx_set_cso(cso_state);
 
     if (core->has_vnet) {
-        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
-                         cso_state, 0, 0, 0, 0, 0, 0);
+        struct NetOffloads ol = {.csum = cso_state };
+
+        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
     }
 }
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 39e3ce1c8f..e940d3a8e2 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -3058,8 +3058,9 @@ igb_update_rx_offloads(IGBCore *core)
     trace_e1000e_rx_set_cso(cso_state);
 
     if (core->has_vnet) {
-        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
-                         cso_state, 0, 0, 0, 0, 0, 0);
+        struct NetOffloads ol = {.csum = cso_state };
+
+        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
     }
 }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 05cf23700f..881877086e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -882,14 +882,17 @@ static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 
 static void virtio_net_apply_guest_offloads(VirtIONet *n)
 {
-    qemu_set_offload(qemu_get_queue(n->nic)->peer,
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_CSUM)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
+    NetOffloads ol = {
+       .csum = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_CSUM)),
+       .tso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
+       .tso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
+       .ecn  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
+       .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
+       .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
+       .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
+    };
+
+    qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
 }
 
 static uint64_t virtio_net_features_to_offload(virtio_features_t features)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 83d942af17..dbacb4aa18 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1334,14 +1334,11 @@ static void vmxnet3_update_features(VMXNET3State *s)
               s->lro_supported, rxcso_supported,
               s->rx_vlan_stripping);
     if (s->peer_has_vhdr) {
-        qemu_set_offload(qemu_get_queue(s->nic)->peer,
-                         rxcso_supported,
-                         s->lro_supported,
-                         s->lro_supported,
-                         0,
-                         0,
-                         0,
-                         0);
+        struct NetOffloads ol = { .csum = rxcso_supported,
+                                  .tso4 = s->lro_supported,
+                                  .tso6 = s->lro_supported };
+
+        qemu_set_offload(qemu_get_queue(s->nic)->peer, &ol);
     }
 }
 
diff --git a/include/net/net.h b/include/net/net.h
index 391d983e49..c71d7c6074 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -35,6 +35,16 @@ typedef struct NICConf {
     int32_t bootindex;
 } NICConf;
 
+typedef struct NetOffloads {
+    bool csum;
+    bool tso4;
+    bool tso6;
+    bool ecn;
+    bool ufo;
+    bool uso4;
+    bool uso6;
+} NetOffloads;
+
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
@@ -58,7 +68,7 @@ typedef bool (HasUso)(NetClientState *);
 typedef bool (HasTunnel)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
-typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
+typedef void (SetOffload)(NetClientState *, const NetOffloads *);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef int (SetVnetLE)(NetClientState *, bool);
@@ -188,8 +198,7 @@ bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
-void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
-                      int ecn, int ufo, int uso4, int uso6);
+void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
diff --git a/net/net.c b/net/net.c
index 9c83d3b137..5a2f00c108 100644
--- a/net/net.c
+++ b/net/net.c
@@ -549,14 +549,13 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
     return nc->info->has_vnet_hdr_len(nc, len);
 }
 
-void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
-                          int ecn, int ufo, int uso4, int uso6)
+void qemu_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
     if (!nc || !nc->info->set_offload) {
         return;
     }
 
-    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
+    nc->info->set_offload(nc, ol);
 }
 
 int qemu_get_vnet_hdr_len(NetClientState *nc)
diff --git a/net/netmap.c b/net/netmap.c
index 297510e190..6cd8f2bdc5 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -366,8 +366,7 @@ static void netmap_set_vnet_hdr_len(NetClientState *nc, int len)
     }
 }
 
-static void netmap_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
-                               int ecn, int ufo, int uso4, int uso6)
+static void netmap_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
     NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
 
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 3f01c8921e..e7de0672f4 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -236,8 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
     return -EINVAL;
 }
 
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo, int uso4, int uso6)
+void tap_fd_set_offload(int fd, const NetOffloads *ol)
 {
 }
 
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 2df601551e..aa5f3a6e22 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -258,8 +258,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
     abort();
 }
 
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo, int uso4, int uso6)
+void tap_fd_set_offload(int fd, const NetOffloads *ol)
 {
     unsigned int offload = 0;
 
@@ -268,20 +267,24 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
         return;
     }
 
-    if (csum) {
+    if (ol->csum) {
         offload |= TUN_F_CSUM;
-        if (tso4)
+        if (ol->tso4) {
             offload |= TUN_F_TSO4;
-        if (tso6)
+        }
+        if (ol->tso6) {
             offload |= TUN_F_TSO6;
-        if ((tso4 || tso6) && ecn)
+        }
+        if ((ol->tso4 || ol->tso6) && ol->ecn) {
             offload |= TUN_F_TSO_ECN;
-        if (ufo)
+        }
+        if (ol->ufo) {
             offload |= TUN_F_UFO;
-        if (uso4) {
+        }
+        if (ol->uso4) {
             offload |= TUN_F_USO4;
         }
-        if (uso6) {
+        if (ol->uso6) {
             offload |= TUN_F_USO6;
         }
     }
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index b1aa40d46b..ac09ae03c0 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -27,6 +27,7 @@
 #include "tap_int.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "net/net.h"
 
 #include <sys/ethernet.h>
 #include <sys/sockio.h>
@@ -240,8 +241,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
     return -EINVAL;
 }
 
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo, int uso4, int uso6)
+void tap_fd_set_offload(int fd, const NetOffloads *ol)
 {
 }
 
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 5f57d6baac..66abbbc392 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -71,8 +71,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
     return -EINVAL;
 }
 
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo, int uso4, int uso6)
+void tap_fd_set_offload(int fd, const NetOffloads *ol)
 {
 }
 
diff --git a/net/tap.c b/net/tap.c
index f6e8cd5f1c..c7612fb91b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -271,15 +271,14 @@ static int tap_set_vnet_be(NetClientState *nc, bool is_be)
     return tap_fd_set_vnet_be(s->fd, is_be);
 }
 
-static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo, int uso4, int uso6)
+static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     if (s->fd < 0) {
         return;
     }
 
-    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
+    tap_fd_set_offload(s->fd, ol);
 }
 
 static void tap_exit_notify(Notifier *notifier, void *data)
@@ -365,6 +364,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  int fd,
                                  int vnet_hdr)
 {
+    NetOffloads ol = {};
     NetClientState *nc;
     TAPState *s;
 
@@ -379,7 +379,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->has_uso = tap_probe_has_uso(s->fd);
     s->has_tunnel = tap_probe_has_tunnel(s->fd);
     s->enabled = true;
-    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
+    tap_set_offload(&s->nc, &ol);
     /*
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
diff --git a/net/tap_int.h b/net/tap_int.h
index 2a8aa3632f..327d10f68b 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,6 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qapi/qapi-types-net.h"
+#include "net/net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
@@ -38,8 +39,7 @@ int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 int tap_probe_has_tunnel(int fd);
-void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
-                        int uso4, int uso6);
+void tap_fd_set_offload(int fd, const NetOffloads *ol);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
-- 
2.49.0


