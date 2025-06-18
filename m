Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EB6C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoMO-0005qB-GW; Wed, 18 Jun 2025 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoM8-0005kr-Gg
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoM5-0002bk-9c
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750236072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW4woBf+JYgEkIBxPOdruLdmgq/fFn7cED5G8WWo9yw=;
 b=OWt+ovEGe5xj0+W8Xmrm7w34QOpRHJOMCtO6oi1YBnnPDg5a8X5dq1nvzg3Jx6SWYK7s7w
 ik2i1wADSTuqPfT+5/6gK82K9hq8q4/1UrNqpTNScoxea9sHiKqavd6pjzHuRgoKwTQ1ne
 7ob2cUvOEZ/aYQuA54l0dqQCMxO6N8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-CJUMvmMQPae0h9bh6Zdz7A-1; Wed,
 18 Jun 2025 04:40:01 -0400
X-MC-Unique: CJUMvmMQPae0h9bh6Zdz7A-1
X-Mimecast-MFC-AGG-ID: CJUMvmMQPae0h9bh6Zdz7A_1750236000
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 665771800287; Wed, 18 Jun 2025 08:40:00 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E39E19560A3; Wed, 18 Jun 2025 08:39:56 +0000 (UTC)
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
Subject: [PATCH 5/8] net: Add get_acked_features callback to NetClientInfo
Date: Wed, 18 Jun 2025 10:39:27 +0200
Message-ID: <20250618083930.451313-6-lvivier@redhat.com>
In-Reply-To: <20250618083930.451313-1-lvivier@redhat.com>
References: <20250618083930.451313-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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

This patch continues the effort to decouple the generic vhost layer
from specific network backend implementations.

Previously, the vhost_net initialization code contained a hardcoded
check for the vhost-user client type to retrieve its acked features
by calling vhost_user_get_acked_features(). This exposed an
internal vhost-user function in a public header and coupled the two
modules.

Following the pattern of recent commits, this patch introduces a
generic helper, qemu_get_acked_features(), and a corresponding
get_acked_features callback in the NetClientInfo struct.

The vhost-user backend is updated to provide this callback, and its
getter function is now static. The call site in vhost_net.c is
simplified to use the new generic helper, removing the type check and
the direct dependency.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c       | 18 +++++++-----------
 include/net/net.h        |  4 ++++
 include/net/vhost-user.h |  2 --
 net/net.c                | 10 ++++++++++
 net/vhost-user.c         |  3 ++-
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 16dadd022e75..4ed28a6d4186 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -317,8 +317,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     int r;
     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
     struct vhost_net *net = g_new0(struct vhost_net, 1);
-    uint64_t features = 0;
     Error *local_err = NULL;
+    uint64_t features;
 
     if (!options->net_backend) {
         fprintf(stderr, "vhost-net requires net backend to be setup\n");
@@ -369,17 +369,13 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     }
 
     /* Set sane init value. Override when guest acks. */
-#ifdef CONFIG_VHOST_NET_USER
-    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        features = vhost_user_get_acked_features(net->nc);
-        if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
-            goto fail;
-        }
+    features = qemu_get_acked_features(net->nc);
+    if (~net->dev.features & features) {
+        fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
+                " for backend\n",
+                (uint64_t)(~net->dev.features & features));
+        goto fail;
     }
-#endif
 
     vhost_net_ack_features(net, features);
 
diff --git a/include/net/net.h b/include/net/net.h
index 8a62cd6e8aab..ed9febd378b6 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -69,6 +69,7 @@ typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef bool (IsVHostUser)(NetClientState *);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
+typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -96,6 +97,7 @@ typedef struct NetClientInfo {
     NetCheckPeerType *check_peer_type;
     IsVHostUser *is_vhost_user;
     GetVHostNet *get_vhost_net;
+    GetAckedFeatures *get_acked_features;
 } NetClientInfo;
 
 struct NetClientState {
@@ -197,6 +199,8 @@ int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 bool qemu_is_vhost_user(NetClientState *nc);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
+uint64_t qemu_get_acked_features(NetClientState *nc);
+
 /**
  * qemu_find_nic_info: Obtain NIC configuration information
  * @typename: Name of device object type
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 0b233a267345..a4d0ce4b8dd1 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -11,8 +11,6 @@
 #ifndef VHOST_USER_H
 #define VHOST_USER_H
 
-struct vhost_net;
-uint64_t vhost_user_get_acked_features(NetClientState *nc);
 void vhost_user_save_acked_features(NetClientState *nc);
 
 #endif /* VHOST_USER_H */
diff --git a/net/net.c b/net/net.c
index 8726c59915a3..ba051441053f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -608,6 +608,16 @@ int qemu_set_vnet_be(NetClientState *nc, bool is_be)
 #endif
 }
 
+uint64_t qemu_get_acked_features(NetClientState *nc)
+{
+    if (nc->info->get_acked_features) {
+        return nc->info->get_acked_features(nc);
+    }
+
+    return 0;
+}
+
+
 int qemu_can_receive_packet(NetClientState *nc)
 {
     if (nc->receive_disabled) {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2caa7e56f7a0..45c952b1e76d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -39,7 +39,7 @@ static struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
-uint64_t vhost_user_get_acked_features(NetClientState *nc)
+static uint64_t vhost_user_get_acked_features(NetClientState *nc)
 {
     NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
@@ -240,6 +240,7 @@ static NetClientInfo net_vhost_user_info = {
         .check_peer_type = vhost_user_check_peer_type,
         .is_vhost_user = vhost_user_is_vhost_user,
         .get_vhost_net = vhost_user_get_vhost_net,
+        .get_acked_features = vhost_user_get_acked_features,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
-- 
2.49.0


