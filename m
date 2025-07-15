Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC7C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPO-0001ur-FD; Tue, 15 Jul 2025 00:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOZ-0001QN-Gu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOX-00061l-Gu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5V/l3Azbas7jiQylywA3mzzUCzgI0GaPktcMBeaTx0=;
 b=A9MMChdawPB3lbyc7/AVYunUtoN8YpFfON6TBxKFXxAUuZGkRGxUSm/kRm+pbP/SW/TvrK
 9GK+iaFguXT8T2PYPD5sRCB05/wOvd68ipkKSkmyMd2EKFSQv5kQPRaUWkVB8zOKMFCNVd
 1HPP2LlMQCXFMv/l1yyWkxjAEFUNWO8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-cpIGUZ6XNlSk4-Iup7XFyA-1; Tue,
 15 Jul 2025 00:35:54 -0400
X-MC-Unique: cpIGUZ6XNlSk4-Iup7XFyA-1
X-Mimecast-MFC-AGG-ID: cpIGUZ6XNlSk4-Iup7XFyA_1752554154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18D5D180029F
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:35:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2FFF1977000; Tue, 15 Jul 2025 04:35:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 08/16] net: Add get_acked_features callback to
 VhostNetOptions
Date: Tue, 15 Jul 2025 12:35:16 +0800
Message-ID: <20250715043524.21719-9-jasowang@redhat.com>
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

This patch continues the effort to decouple the generic vhost layer
from specific network backend implementations.

Previously, the vhost_net initialization code contained a hardcoded
check for the vhost-user client type to retrieve its acked features
by calling vhost_user_get_acked_features(). This exposed an
internal vhost-user function in a public header and coupled the two
modules.

The vhost-user backend is updated to provide a callback, and its
getter function is now static. The call site in vhost_net.c is
simplified to use the new generic helper, removing the type check and
the direct dependency.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net.c       | 6 ++----
 include/net/vhost-user.h | 2 --
 include/net/vhost_net.h  | 3 +++
 net/tap.c                | 1 +
 net/vhost-user.c         | 4 +++-
 net/vhost-vdpa.c         | 1 +
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 787c769ccc..fb169af0e8 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -288,9 +288,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     }
 
     /* Set sane init value. Override when guest acks. */
-#ifdef CONFIG_VHOST_NET_USER
-    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        features = vhost_user_get_acked_features(net->nc);
+    if (options->get_acked_features) {
+        features = options->get_acked_features(net->nc);
         if (~net->dev.features & features) {
             fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
                     " for backend\n",
@@ -298,7 +297,6 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
     }
-#endif
 
     vhost_net_ack_features(net, features);
 
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 0b233a2673..a4d0ce4b8d 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -11,8 +11,6 @@
 #ifndef VHOST_USER_H
 #define VHOST_USER_H
 
-struct vhost_net;
-uint64_t vhost_user_get_acked_features(NetClientState *nc);
 void vhost_user_save_acked_features(NetClientState *nc);
 
 #endif /* VHOST_USER_H */
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index fbed37385a..a8d281c8f7 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -7,12 +7,15 @@
 struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
+typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
+
 typedef struct VhostNetOptions {
     VhostBackendType backend_type;
     NetClientState *net_backend;
     uint32_t busyloop_timeout;
     unsigned int nvqs;
     const int *feature_bits;
+    GetAckedFeatures *get_acked_features;
     void *opaque;
 } VhostNetOptions;
 
diff --git a/net/tap.c b/net/tap.c
index a33eb23212..acd77f816f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -744,6 +744,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         options.opaque = (void *)(uintptr_t)vhostfd;
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
+        options.get_acked_features = NULL;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index bc8e82a092..93b413b49f 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -81,7 +81,7 @@ static struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
-uint64_t vhost_user_get_acked_features(NetClientState *nc)
+static uint64_t vhost_user_get_acked_features(NetClientState *nc)
 {
     NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
@@ -139,6 +139,8 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.busyloop_timeout = 0;
         options.nvqs = 2;
         options.feature_bits = user_feature_bits;
+        options.get_acked_features = vhost_user_get_acked_features;
+
         net = vhost_net_init(&options);
         if (!net) {
             error_report("failed to init vhost_net for queue %d", i);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cbbea0eb71..a3980d1fb5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -202,6 +202,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.busyloop_timeout = 0;
     options.nvqs = nvqs;
     options.feature_bits = vdpa_feature_bits;
+    options.get_acked_features = NULL;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.42.0


