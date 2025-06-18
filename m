Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6E0C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoMy-0007I9-0h; Wed, 18 Jun 2025 04:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoMv-0007Ej-CS
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoMs-000355-5J
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750236121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jb0CgELTRKz19zoBNNtzjKkT3GlOqs/ymBmwcRa0rdA=;
 b=ChRS6E+zSrKynXFb+0E3FnDYd48jIBoloX9tdDVPE7jyqG0fdoAmIr+9mXq56kCe4r10bL
 0COuEyInDdd+lQ74hCC5mQ0h7Im49lWaibz9w11+CHEEUOJUrTwjQdTotLTX75AZnOvBda
 I7ZmEut693vM8vsuWi9yo0vfv3rNgWo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-vBAub8AOPyComycXb_dRoQ-1; Wed,
 18 Jun 2025 04:39:56 -0400
X-MC-Unique: vBAub8AOPyComycXb_dRoQ-1
X-Mimecast-MFC-AGG-ID: vBAub8AOPyComycXb_dRoQ_1750235996
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5A6C19560AA; Wed, 18 Jun 2025 08:39:55 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BB7619560A3; Wed, 18 Jun 2025 08:39:51 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 4/8] net: Add get_vhost_net callback to NetClientInfo
Date: Wed, 18 Jun 2025 10:39:26 +0200
Message-ID: <20250618083930.451313-5-lvivier@redhat.com>
In-Reply-To: <20250618083930.451313-1-lvivier@redhat.com>
References: <20250618083930.451313-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

The get_vhost_net() function previously contained a large switch
statement to find the VHostNetState pointer based on the net
client's type. This created a tight coupling, requiring the generic
vhost layer to be aware of every specific backend that supported
vhost, such as tap, vhost-user, and vhost-vdpa.

This approach is not scalable and requires modifying a central function
for any new backend. It also forced each backend to expose its internal
getter function in a public header file.

This patch refactors the logic by introducing a new get_vhost_net
function pointer to the NetClientInfo struct. The central
get_vhost_net() function is now a simple, generic dispatcher that
invokes the callback provided by the net client.

Each backend now implements its own private getter and registers it in
its NetClientInfo.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c       | 31 ++++---------------------------
 include/net/net.h        |  2 ++
 include/net/tap.h        |  3 ---
 include/net/vhost-user.h |  1 -
 include/net/vhost-vdpa.h |  2 --
 net/tap-win32.c          |  5 -----
 net/tap.c                | 20 +++++++++++++-------
 net/vhost-user.c         |  3 ++-
 net/vhost-vdpa.c         |  4 +++-
 9 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 41d21e687ed9..16dadd022e75 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -646,41 +646,18 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
 {
     vhost_config_mask(&net->dev, dev, mask);
 }
+
 VHostNetState *get_vhost_net(NetClientState *nc)
 {
-    VHostNetState *vhost_net = 0;
-
     if (!nc) {
         return 0;
     }
 
-    switch (nc->info->type) {
-    case NET_CLIENT_DRIVER_TAP:
-        vhost_net = tap_get_vhost_net(nc);
-        /*
-         * tap_get_vhost_net() can return NULL if a tap net-device backend is
-         * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
-         * vhostforce or vhostfd options at all. Please see net_init_tap_one().
-         * Hence, we omit the assertion here.
-         */
-        break;
-#ifdef CONFIG_VHOST_NET_USER
-    case NET_CLIENT_DRIVER_VHOST_USER:
-        vhost_net = vhost_user_get_vhost_net(nc);
-        assert(vhost_net);
-        break;
-#endif
-#ifdef CONFIG_VHOST_NET_VDPA
-    case NET_CLIENT_DRIVER_VHOST_VDPA:
-        vhost_net = vhost_vdpa_get_vhost_net(nc);
-        assert(vhost_net);
-        break;
-#endif
-    default:
-        break;
+    if (nc->info->get_vhost_net) {
+        return nc->info->get_vhost_net(nc);
     }
 
-    return vhost_net;
+    return NULL;
 }
 
 int vhost_set_vring_enable(NetClientState *nc, int enable)
diff --git a/include/net/net.h b/include/net/net.h
index 2c3b22f564b6..8a62cd6e8aab 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -68,6 +68,7 @@ typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef bool (IsVHostUser)(NetClientState *);
+typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -94,6 +95,7 @@ typedef struct NetClientInfo {
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
     IsVHostUser *is_vhost_user;
+    GetVHostNet *get_vhost_net;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/include/net/tap.h b/include/net/tap.h
index 5d585515f9e3..6f34f13eae44 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -33,7 +33,4 @@ int tap_disable(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
-struct vhost_net;
-struct vhost_net *tap_get_vhost_net(NetClientState *nc);
-
 #endif /* QEMU_NET_TAP_H */
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 35bf61970985..0b233a267345 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -12,7 +12,6 @@
 #define VHOST_USER_H
 
 struct vhost_net;
-struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc);
 uint64_t vhost_user_get_acked_features(NetClientState *nc);
 void vhost_user_save_acked_features(NetClientState *nc);
 
diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
index b81f9a6f2a0e..916ead3793d9 100644
--- a/include/net/vhost-vdpa.h
+++ b/include/net/vhost-vdpa.h
@@ -14,8 +14,6 @@
 
 #define TYPE_VHOST_VDPA "vhost-vdpa"
 
-struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);
-
 extern const int vdpa_feature_bits[];
 
 #endif /* VHOST_VDPA_H */
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 671dee970f7a..38baf90e0b3f 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -704,11 +704,6 @@ static void tap_win32_send(void *opaque)
     }
 }
 
-struct vhost_net *tap_get_vhost_net(NetClientState *nc)
-{
-    return NULL;
-}
-
 static NetClientInfo net_tap_win32_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
diff --git a/net/tap.c b/net/tap.c
index ae1c7e398321..4beba6d7a784 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -329,6 +329,18 @@ int tap_get_fd(NetClientState *nc)
     return s->fd;
 }
 
+/*
+ * tap_get_vhost_net() can return NULL if a tap net-device backend is
+ * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
+ * vhostforce or vhostfd options at all. Please see net_init_tap_one().
+ */
+static VHostNetState *tap_get_vhost_net(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return s->vhost_net;
+}
+
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -347,6 +359,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
+    .get_vhost_net = tap_get_vhost_net,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
@@ -980,13 +993,6 @@ free_fail:
     return 0;
 }
 
-VHostNetState *tap_get_vhost_net(NetClientState *nc)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    return s->vhost_net;
-}
-
 int tap_enable(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 4b4d02c56740..2caa7e56f7a0 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -32,7 +32,7 @@ typedef struct NetVhostUserState {
     bool started;
 } NetVhostUserState;
 
-VHostNetState *vhost_user_get_vhost_net(NetClientState *nc)
+static struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc)
 {
     NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
@@ -239,6 +239,7 @@ static NetClientInfo net_vhost_user_info = {
         .set_vnet_le = vhost_user_set_vnet_endianness,
         .check_peer_type = vhost_user_check_peer_type,
         .is_vhost_user = vhost_user_is_vhost_user,
+        .get_vhost_net = vhost_user_get_vhost_net,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945dbc..0b86c917ed68 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -132,7 +132,7 @@ static const uint64_t vdpa_svq_device_features =
 
 #define VHOST_VDPA_NET_CVQ_ASID 1
 
-VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
+static struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -432,6 +432,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
+        .get_vhost_net = vhost_vdpa_get_vhost_net,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1287,6 +1288,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
+    .get_vhost_net = vhost_vdpa_get_vhost_net,
 };
 
 /*
-- 
2.49.0


