Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54441C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPE-0001ok-Om; Tue, 15 Jul 2025 00:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOU-0001OP-CD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOR-00061E-L2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8+fF7SH0OZ4mxMevN3C0CPeMRnFs+jK4vsOAwAbjhU=;
 b=aFYFw7pQu7n1D+3SL9h4arF1uSir83y77BTdeAlp9q3uoJmVYHcZyTmDP3SZ6dp8djA1G/
 FjIkJxyAsgMMK4Y9/8l+1XRCS3lxHPus02ZyT0STAZ+iGdzSGDo+ZpvSi2UFw2Iqfmwg3G
 3xAjhVJCdRn1JQqXpu1hU0Jb2tJQ0P0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-ZKMKdFjINFCenyAlOm6wYA-1; Tue,
 15 Jul 2025 00:35:49 -0400
X-MC-Unique: ZKMKdFjINFCenyAlOm6wYA-1
X-Mimecast-MFC-AGG-ID: ZKMKdFjINFCenyAlOm6wYA_1752554148
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C5501809C86
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:35:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 934C61977000; Tue, 15 Jul 2025 04:35:46 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 06/16] net: Add get_vhost_net callback to NetClientInfo
Date: Tue, 15 Jul 2025 12:35:14 +0800
Message-ID: <20250715043524.21719-7-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
index cb87056397..db8b97b753 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -649,41 +649,18 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
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
 
 int vhost_net_set_vring_enable(NetClientState *nc, int enable)
diff --git a/include/net/net.h b/include/net/net.h
index ac59b593ba..e67b375626 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -67,6 +67,7 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -92,6 +93,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    GetVHostNet *get_vhost_net;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/include/net/tap.h b/include/net/tap.h
index 5d585515f9..6f34f13eae 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -33,7 +33,4 @@ int tap_disable(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
-struct vhost_net;
-struct vhost_net *tap_get_vhost_net(NetClientState *nc);
-
 #endif /* QEMU_NET_TAP_H */
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 35bf619709..0b233a2673 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -12,7 +12,6 @@
 #define VHOST_USER_H
 
 struct vhost_net;
-struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc);
 uint64_t vhost_user_get_acked_features(NetClientState *nc);
 void vhost_user_save_acked_features(NetClientState *nc);
 
diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
index b81f9a6f2a..916ead3793 100644
--- a/include/net/vhost-vdpa.h
+++ b/include/net/vhost-vdpa.h
@@ -14,8 +14,6 @@
 
 #define TYPE_VHOST_VDPA "vhost-vdpa"
 
-struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);
-
 extern const int vdpa_feature_bits[];
 
 #endif /* VHOST_VDPA_H */
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 671dee970f..38baf90e0b 100644
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
index ae1c7e3983..4beba6d7a7 100644
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
index 10ac8dc0b3..b7bf0d2042 100644
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
@@ -231,6 +231,7 @@ static NetClientInfo net_vhost_user_info = {
         .set_vnet_be = vhost_user_set_vnet_endianness,
         .set_vnet_le = vhost_user_set_vnet_endianness,
         .check_peer_type = vhost_user_check_peer_type,
+        .get_vhost_net = vhost_user_get_vhost_net,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..0b86c917ed 100644
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
2.42.0


