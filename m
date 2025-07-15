Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB12FC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPN-0001uV-RX; Tue, 15 Jul 2025 00:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOe-0001Ra-7C
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOc-00062N-3s
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DT3HyA+iTPKd58MpBzGj1uOVAOgY7hfIfQe5e1fRid4=;
 b=cmd6J3D4luNKYicYJHpfbrLLfHGjT99sZSKGL1aSMZfawAuMtWmSIiVsIODq1sX5FlyMCT
 CeSq+E5SxwmVGsxaWCdwSiPU76fYWH8fn6hw0LXXQjMORttS9KTBC4IyPGzA8Dym2tgDWC
 1H/uDRfKvFk9LKvAoKUqW5KFugvF6Ok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-CZZyJFxwPQugW04ysMGI_Q-1; Tue,
 15 Jul 2025 00:35:57 -0400
X-MC-Unique: CZZyJFxwPQugW04ysMGI_Q-1
X-Mimecast-MFC-AGG-ID: CZZyJFxwPQugW04ysMGI_Q_1752554156
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9457180120C
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC4C61977000; Tue, 15 Jul 2025 04:35:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 09/16] net: Add save_acked_features callback to vhost_net
Date: Tue, 15 Jul 2025 12:35:17 +0800
Message-ID: <20250715043524.21719-10-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

This commit introduces a save_acked_features function pointer to
vhost_net and converts the vhost_net function into a generic dispatcher.

The vhost-user backend provides the callback, making its function static.
With this change, no other module has a direct dependency on the
vhost-user implementation.

This cleanup allows for the complete removal of the net/vhost-user.h
header file.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net-stub.c   |  1 -
 hw/net/vhost_net.c        | 10 +++++-----
 include/hw/virtio/vhost.h |  2 ++
 include/net/vhost-user.h  | 16 ----------------
 include/net/vhost_net.h   |  2 ++
 net/tap.c                 |  1 +
 net/vhost-user-stub.c     |  1 -
 net/vhost-user.c          |  4 ++--
 net/vhost-vdpa.c          |  1 +
 9 files changed, 13 insertions(+), 25 deletions(-)
 delete mode 100644 include/net/vhost-user.h

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 7bed0bf92b..7d49f82906 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fb169af0e8..976d2b315a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 #include "net/vhost-vdpa.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -70,11 +69,11 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net)
 
 void vhost_net_save_acked_features(NetClientState *nc)
 {
-#ifdef CONFIG_VHOST_NET_USER
-    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_user_save_acked_features(nc);
+    struct vhost_net *net = get_vhost_net(nc);
+
+    if (net && net->save_acked_features) {
+        net->save_acked_features(nc);
     }
-#endif
 }
 
 static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
@@ -245,6 +244,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->nc = options->net_backend;
     net->dev.nvqs = options->nvqs;
     net->feature_bits = options->feature_bits;
+    net->save_acked_features = options->save_acked_features;
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a75fdc021..b0830bac79 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -1,6 +1,7 @@
 #ifndef VHOST_H
 #define VHOST_H
 
+#include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
@@ -144,6 +145,7 @@ struct vhost_net {
     struct vhost_virtqueue vqs[2];
     int backend;
     const int *feature_bits;
+    SaveAcketFeatures *save_acked_features;
     NetClientState *nc;
 };
 
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
deleted file mode 100644
index a4d0ce4b8d..0000000000
--- a/include/net/vhost-user.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * vhost-user.h
- *
- * Copyright (c) 2013 Virtual Open Systems Sarl.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef VHOST_USER_H
-#define VHOST_USER_H
-
-void vhost_user_save_acked_features(NetClientState *nc);
-
-#endif /* VHOST_USER_H */
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index a8d281c8f7..eb26ed9bdc 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -8,6 +8,7 @@ struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
 typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
+typedef void (SaveAcketFeatures)(NetClientState *nc);
 
 typedef struct VhostNetOptions {
     VhostBackendType backend_type;
@@ -16,6 +17,7 @@ typedef struct VhostNetOptions {
     unsigned int nvqs;
     const int *feature_bits;
     GetAckedFeatures *get_acked_features;
+    SaveAcketFeatures *save_acked_features;
     void *opaque;
 } VhostNetOptions;
 
diff --git a/net/tap.c b/net/tap.c
index acd77f816f..79fa02a65c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -745,6 +745,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
         options.get_acked_features = NULL;
+        options.save_acked_features = NULL;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
index 52ab4e13f1..283dee87db 100644
--- a/net/vhost-user-stub.c
+++ b/net/vhost-user-stub.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "net/vhost_net.h"
-#include "net/vhost-user.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 93b413b49f..8a3df27b02 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "net/vhost_net.h"
-#include "net/vhost-user.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 #include "standard-headers/linux/virtio_net.h"
@@ -88,7 +87,7 @@ static uint64_t vhost_user_get_acked_features(NetClientState *nc)
     return s->acked_features;
 }
 
-void vhost_user_save_acked_features(NetClientState *nc)
+static void vhost_user_save_acked_features(NetClientState *nc)
 {
     NetVhostUserState *s;
 
@@ -140,6 +139,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.nvqs = 2;
         options.feature_bits = user_feature_bits;
         options.get_acked_features = vhost_user_get_acked_features;
+        options.save_acked_features = vhost_user_save_acked_features;
 
         net = vhost_net_init(&options);
         if (!net) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a3980d1fb5..c63225d3d2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -203,6 +203,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.nvqs = nvqs;
     options.feature_bits = vdpa_feature_bits;
     options.get_acked_features = NULL;
+    options.save_acked_features = NULL;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.42.0


