Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A542C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvAt-0003Ir-Rq; Wed, 18 Jun 2025 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAr-0003If-3N
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAp-0008BO-B9
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AORrHkTo1CSRa5FEHRdhnhWesUlfPSJmqnq3AxSgsQ=;
 b=dblZntx7NEXOtcNpHEF7GF1hdUqIwMqSbZlEoRbjOozHI6kZrGogSpgNJeypMgnUSbRbs+
 /ihJtxuWi/5p73s0C6vuMkKqRj6IN5PF6PdYux2aoZRTGTDhSzKPWjOyRwmdRQqA6tkhlk
 d0227lbjHCSMMAFHhApboEAmjLkNxvQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-kXfnp2bPNZ-P_qZc7wqOjg-1; Wed,
 18 Jun 2025 11:57:56 -0400
X-MC-Unique: kXfnp2bPNZ-P_qZc7wqOjg-1
X-Mimecast-MFC-AGG-ID: kXfnp2bPNZ-P_qZc7wqOjg_1750262275
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FABF195609F; Wed, 18 Jun 2025 15:57:55 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3DE9180045B; Wed, 18 Jun 2025 15:57:51 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 07/10] net: Add save_acked_features callback to
 NetClientInfo
Date: Wed, 18 Jun 2025 17:57:15 +0200
Message-ID: <20250618155718.550968-8-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-1-lvivier@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

This patch completes the series of refactorings aimed at decoupling the
generic vhost layer from specific network backends.

The final remaining dependency was in vhost_net_save_acked_features,
which contained a hardcoded check for the vhost-user client type.

This commit applies the now-established callback pattern, introducing a
save_acked_features function pointer to NetClientInfo and
converting the vhost_net function into a generic dispatcher.

The vhost-user backend provides the callback, making its function static.
With this change, no other module has a direct dependency on the
vhost-user implementation.

This cleanup allows for the complete removal of the net/vhost-user.h
header file.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c  |  1 -
 hw/net/vhost_net.c       |  7 ++-----
 include/net/net.h        |  2 ++
 include/net/vhost-user.h | 16 ----------------
 net/vhost-user-stub.c    |  1 -
 net/vhost-user.c         |  4 ++--
 6 files changed, 6 insertions(+), 25 deletions(-)
 delete mode 100644 include/net/vhost-user.h

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e4d..dab9943172da 100644
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
index 9cfe41b40b41..e5890bac8200 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 #include "net/vhost-vdpa.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -80,11 +79,9 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net)
 
 void vhost_net_save_acked_features(NetClientState *nc)
 {
-#ifdef CONFIG_VHOST_NET_USER
-    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_user_save_acked_features(nc);
+    if (nc->info->save_acked_features) {
+        nc->info->save_acked_features(nc);
     }
-#endif
 }
 
 static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
diff --git a/include/net/net.h b/include/net/net.h
index 37dc97a06752..179ffee5bd11 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -70,6 +70,7 @@ typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef bool (IsVHostUser)(NetClientState *);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
+typedef void (SaveAcketFeatures)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -99,6 +100,7 @@ typedef struct NetClientInfo {
     IsVHostUser *is_vhost_user;
     GetVHostNet *get_vhost_net;
     GetAckedFeatures *get_acked_features;
+    SaveAcketFeatures *save_acked_features;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
deleted file mode 100644
index a4d0ce4b8dd1..000000000000
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
diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
index 52ab4e13f12a..283dee87db2d 100644
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
index e590b39503de..15609faedb88 100644
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
 
@@ -284,6 +283,7 @@ static NetClientInfo net_vhost_user_info = {
         .get_vhost_net = vhost_user_get_vhost_net,
         .vhost_feature_bits = user_feature_bits,
         .get_acked_features = vhost_user_get_acked_features,
+        .save_acked_features = vhost_user_save_acked_features,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
-- 
2.49.0


