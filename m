Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2620EC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPQ-0001wm-LQ; Tue, 15 Jul 2025 00:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOh-0001TC-Vu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOf-00062z-NH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+YvooSYZgdxo1YSHG8Ogjlc2B/r4R8Tf/zQP9kdvCs=;
 b=jGH7bHw52LZ2bo+pQSozk6+vW7NT+Kw04M3Rs8tftaPfim82NLDtyQA8hARdASOhePxGMl
 mxnQYOzGBT+KT+xv8PJHUOG6rcY5L1i3Js3S1YvPX5AhKxf2oNYGBYsJGKn96HNScSDwd1
 CSAQZABromZpJgwg7hJJB0ArnomcyHM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-DxzeGwNtNpGAMYLZ9VHllg-1; Tue,
 15 Jul 2025 00:36:00 -0400
X-MC-Unique: DxzeGwNtNpGAMYLZ9VHllg-1
X-Mimecast-MFC-AGG-ID: DxzeGwNtNpGAMYLZ9VHllg_1752554159
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84B49180029E
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 905F41977000; Tue, 15 Jul 2025 04:35:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 10/16] net: Allow network backends to advertise max TX queue
 size
Date: Tue, 15 Jul 2025 12:35:18 +0800
Message-ID: <20250715043524.21719-11-jasowang@redhat.com>
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

This commit refactors how the maximum transmit queue size for
virtio-net devices is determined, making the mechanism more generic
and extensible.

Previously, virtio_net_max_tx_queue_size() contained hardcoded
checks for specific network backend types (vhost-user and
vhost-vdpa) to determine their supported maximum queue size. This
created direct dependencies and would require modifications for
every new backend that supports variable queue sizes.

To improve flexibility, a new max_tx_queue_size field is added
to the vhost_net structure. This allows each network backend
to advertise its supported maximum transmit queue size directly.

The virtio_net_max_tx_queue_size() function now retrieves the max
TX queue size from the vhost_net struct, if available and set.
Otherwise, it defaults to VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net.c        |  1 +
 hw/net/virtio-net.c       | 24 ++++++++++++------------
 include/hw/virtio/vhost.h |  1 +
 include/net/vhost_net.h   |  1 +
 net/tap.c                 |  1 +
 net/vhost-user.c          |  1 +
 net/vhost-vdpa.c          |  1 +
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 976d2b315a..74d2e3ed90 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -245,6 +245,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->dev.nvqs = options->nvqs;
     net->feature_bits = options->feature_bits;
     net->save_acked_features = options->save_acked_features;
+    net->max_tx_queue_size = options->max_tx_queue_size;
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e3400f18c8..39fc280839 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -670,22 +670,22 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
 static int virtio_net_max_tx_queue_size(VirtIONet *n)
 {
     NetClientState *peer = n->nic_conf.peers.ncs[0];
+    struct vhost_net *net;
 
-    /*
-     * Backends other than vhost-user or vhost-vdpa don't support max queue
-     * size.
-     */
     if (!peer) {
-        return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+        goto default_value;
     }
 
-    switch(peer->info->type) {
-    case NET_CLIENT_DRIVER_VHOST_USER:
-    case NET_CLIENT_DRIVER_VHOST_VDPA:
-        return VIRTQUEUE_MAX_SIZE;
-    default:
-        return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
-    };
+    net = get_vhost_net(peer);
+
+    if (!net || !net->max_tx_queue_size) {
+        goto default_value;
+    }
+
+    return net->max_tx_queue_size;
+
+default_value:
+    return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
 }
 
 static int peer_attach(VirtIONet *n, int index)
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b0830bac79..a62992c819 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -145,6 +145,7 @@ struct vhost_net {
     struct vhost_virtqueue vqs[2];
     int backend;
     const int *feature_bits;
+    int max_tx_queue_size;
     SaveAcketFeatures *save_acked_features;
     NetClientState *nc;
 };
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index eb26ed9bdc..8f4fddfb69 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -16,6 +16,7 @@ typedef struct VhostNetOptions {
     uint32_t busyloop_timeout;
     unsigned int nvqs;
     const int *feature_bits;
+    int max_tx_queue_size;
     GetAckedFeatures *get_acked_features;
     SaveAcketFeatures *save_acked_features;
     void *opaque;
diff --git a/net/tap.c b/net/tap.c
index 79fa02a65c..2f0cb55c9a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -746,6 +746,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         options.feature_bits = kernel_feature_bits;
         options.get_acked_features = NULL;
         options.save_acked_features = NULL;
+        options.max_tx_queue_size = 0;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 8a3df27b02..bf892915de 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -138,6 +138,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.busyloop_timeout = 0;
         options.nvqs = 2;
         options.feature_bits = user_feature_bits;
+        options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
         options.get_acked_features = vhost_user_get_acked_features;
         options.save_acked_features = vhost_user_save_acked_features;
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c63225d3d2..353392b3d7 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -204,6 +204,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.feature_bits = vdpa_feature_bits;
     options.get_acked_features = NULL;
     options.save_acked_features = NULL;
+    options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.42.0


