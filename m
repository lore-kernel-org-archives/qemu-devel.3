Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A952BC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPK-0001sq-TW; Tue, 15 Jul 2025 00:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOj-0001Tn-Jk
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOh-000633-QG
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQv5wmeY0GaWezx9NXctHKJ6I7SkofkcbyXSQD2bNxc=;
 b=Gbiuh+cKPTbHEEbZl6qQiVx4P2u0dolPESF7p7SktqOlFIOOq/Y8EqlZWjpXNm4RIed2oj
 NXCry5fP2UNlDAk3Y2aU1RQLfFr367NlG3kMuU8V6bBk0BrpFsfj6lTveoJTsBMI1SatSB
 UPPkrCiOZpR/9fZOC2ly0tS16HPY2k0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-COqRQ68iOrWdyELG6s8DzQ-1; Tue,
 15 Jul 2025 00:36:04 -0400
X-MC-Unique: COqRQ68iOrWdyELG6s8DzQ-1
X-Mimecast-MFC-AGG-ID: COqRQ68iOrWdyELG6s8DzQ_1752554163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39F461809C8B
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44F161977000; Tue, 15 Jul 2025 04:35:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 11/16] net: Add is_vhost_user flag to vhost_net struct
Date: Tue, 15 Jul 2025 12:35:19 +0800
Message-ID: <20250715043524.21719-12-jasowang@redhat.com>
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

Introduce a boolean is_vhost_user field to the vhost_net
structure. This flag is initialized during vhost_net_init based
on whether the backend is vhost-user.

This refactoring simplifies checks for vhost-user specific behavior,
replacing direct comparisons of 'net->nc->info->type' with the new
flag. It improves readability and encapsulates the backend type
information directly within the vhost_net instance.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
index 74d2e3ed90..540492b37d 100644
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
index 39fc280839..00df5fd6cd 100644
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
index a62992c819..f178cf9e1d 100644
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
index 8f4fddfb69..879781dad7 100644
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
index 2f0cb55c9a..23536c09b4 100644
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
index bf892915de..1c3b8b36f3 100644
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
index 353392b3d7..943e9c585c 100644
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
2.42.0


