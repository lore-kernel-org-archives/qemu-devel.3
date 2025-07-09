Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52EEC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQ7G-0001oJ-15; Wed, 09 Jul 2025 04:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ7E-0001iw-1J
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ7C-0006Qv-2k
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752049517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrDrFGgxVI/5jPLGv6XBLu49UEWzUDEnHNCSZAEK+0k=;
 b=aIjx+qsJtfeAKBVJ3ghKxETA3LI8WcJSICNs9deSaRhFwRBwBN4CKlHhlqkvJDQLr4ovKT
 bYSxJR9/boaiHd20TQzktEUYgSNzmmLuWdaKFtTUDNTgL/iHqGFh6eIxNQPvyMuuFo15em
 eObBWTIxZhlH5eXK9rUtagRyLMxxO68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-fdVdLPBJNkiOG4oVziDhbg-1; Wed,
 09 Jul 2025 04:25:15 -0400
X-MC-Unique: fdVdLPBJNkiOG4oVziDhbg-1
X-Mimecast-MFC-AGG-ID: fdVdLPBJNkiOG4oVziDhbg_1752049515
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDCB819560A1; Wed,  9 Jul 2025 08:25:14 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E389E195608F; Wed,  9 Jul 2025 08:25:10 +0000 (UTC)
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
Subject: [PATCH v4 09/11] net: Add is_vhost_user flag to vhost_net struct
Date: Wed,  9 Jul 2025 10:24:23 +0200
Message-ID: <20250709082425.601990-10-lvivier@redhat.com>
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

Introduce a boolean is_vhost_user field to the vhost_net
structure. This flag is initialized during vhost_net_init based
on whether the backend is vhost-user.

This refactoring simplifies checks for vhost-user specific behavior,
replacing direct comparisons of 'net->nc->info->type' with the new
flag. It improves readability and encapsulates the backend type
information directly within the vhost_net instance.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c        | 3 ++-
 hw/net/virtio-net.c       | 8 ++++++--
 include/hw/virtio/vhost.h | 1 +
 include/net/vhost_net.h   | 1 +
 net/tap.c                 | 1 +
 net/vhost-user.c          | 1 +
 net/vhost-vdpa.c          | 1 +
 7 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 74d2e3ed90f5..540492b37ddc 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -246,6 +246,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->feature_bits = options->feature_bits;
     net->save_acked_features = options->save_acked_features;
     net->max_tx_queue_size = options->max_tx_queue_size;
+    net->is_vhost_user = options->is_vhost_user;
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
@@ -440,7 +441,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
          * because vhost user doesn't interrupt masking/unmasking
          * properly.
          */
-        if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+        if (net->is_vhost_user) {
             dev->use_guest_notifier_mask = false;
         }
      }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 789717818317..3b5448de8191 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -691,12 +691,14 @@ default_value:
 static int peer_attach(VirtIONet *n, int index)
 {
     NetClientState *nc = qemu_get_subqueue(n->nic, index);
+    struct vhost_net *net;
 
     if (!nc->peer) {
         return 0;
     }
 
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+    net = get_vhost_net(nc->peer);
+    if (net && net->is_vhost_user) {
         vhost_net_set_vring_enable(nc->peer, 1);
     }
 
@@ -714,12 +716,14 @@ static int peer_attach(VirtIONet *n, int index)
 static int peer_detach(VirtIONet *n, int index)
 {
     NetClientState *nc = qemu_get_subqueue(n->nic, index);
+    struct vhost_net *net;
 
     if (!nc->peer) {
         return 0;
     }
 
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+    net = get_vhost_net(nc->peer);
+    if (net && net->is_vhost_user) {
         vhost_net_set_vring_enable(nc->peer, 0);
     }
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a62992c8192e..f178cf9e1d57 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -147,6 +147,7 @@ struct vhost_net {
     const int *feature_bits;
     int max_tx_queue_size;
     SaveAcketFeatures *save_acked_features;
+    bool is_vhost_user;
     NetClientState *nc;
 };
 
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 8f4fddfb69ea..879781dad7b6 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -17,6 +17,7 @@ typedef struct VhostNetOptions {
     unsigned int nvqs;
     const int *feature_bits;
     int max_tx_queue_size;
+    bool is_vhost_user;
     GetAckedFeatures *get_acked_features;
     SaveAcketFeatures *save_acked_features;
     void *opaque;
diff --git a/net/tap.c b/net/tap.c
index 2f0cb55c9a77..23536c09b465 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -747,6 +747,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         options.get_acked_features = NULL;
         options.save_acked_features = NULL;
         options.max_tx_queue_size = 0;
+        options.is_vhost_user = false;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index bf892915def1..1c3b8b36f351 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -141,6 +141,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
         options.get_acked_features = vhost_user_get_acked_features;
         options.save_acked_features = vhost_user_save_acked_features;
+        options.is_vhost_user = true;
 
         net = vhost_net_init(&options);
         if (!net) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 353392b3d741..943e9c585c4c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -205,6 +205,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.get_acked_features = NULL;
     options.save_acked_features = NULL;
     options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
+    options.is_vhost_user = false;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.49.0


