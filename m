Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FCC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQ72-0001G2-E5; Wed, 09 Jul 2025 04:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ70-0001BL-7X
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ6y-0006KE-AD
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752049503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAO7Ut8y2fzNcNSTmMKmzgfJ9mZ8UAi2ecrs8pm9WC4=;
 b=A1gh0pabl3clCRzmZe132WAuI2KImXaF00Se1CHIcslha5IypVjEYS//Smgcf9W3TDQTEk
 w6o/VpXRmju7vVtfNaCC8HeI4in6DUPogGUEtSIdYhjzk2DyN42jEWB9R/lyetQGW+nh9I
 6Qg2gYQXI/B8guajm5s6RW7dmtWDiMw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-1uYAN4plNSK0bvc3jbYoRg-1; Wed,
 09 Jul 2025 04:25:02 -0400
X-MC-Unique: 1uYAN4plNSK0bvc3jbYoRg-1
X-Mimecast-MFC-AGG-ID: 1uYAN4plNSK0bvc3jbYoRg_1752049501
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2DDB1954236; Wed,  9 Jul 2025 08:25:00 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E315195608F; Wed,  9 Jul 2025 08:24:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 06/11] net: Add get_acked_features callback to
 VhostNetOptions
Date: Wed,  9 Jul 2025 10:24:20 +0200
Message-ID: <20250709082425.601990-7-lvivier@redhat.com>
In-Reply-To: <20250709082425.601990-1-lvivier@redhat.com>
References: <20250709082425.601990-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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
---
 hw/net/vhost_net.c       | 6 ++----
 include/net/vhost-user.h | 2 --
 include/net/vhost_net.h  | 3 +++
 net/tap.c                | 1 +
 net/vhost-user.c         | 4 +++-
 net/vhost-vdpa.c         | 1 +
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 787c769ccc37..fb169af0e81b 100644
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
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index fbed37385a3c..a8d281c8f7c2 100644
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
index a33eb2321242..acd77f816fec 100644
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
index bc8e82a09263..93b413b49f34 100644
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
index cbbea0eb7198..a3980d1fb5ed 100644
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
2.49.0


