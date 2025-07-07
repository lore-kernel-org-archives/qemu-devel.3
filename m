Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5DC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh18-0000Ey-AE; Mon, 07 Jul 2025 04:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh16-0000Dn-9o
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh14-0007TD-G2
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI0g4aSAGtXxXc4YGSTKu7BnCDGAeLc3PRCc1/pH5ls=;
 b=I6KTkOv6BeLp0QZnayFXaizTRmoYPtxezEhMs4LT1CiAezC52+GqpuQ7Mp+In6eBIYd5ND
 bjroe+CU2THRr7INQoNCKSU38uTVU5XE2keRbvWYWsXshIUtCyYfs7oS+rJKqSCMfaQpfr
 Y1t+dyFyc4f3pQ0zdlbBkjjnn+7HT7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-pakXk4O0OmGYwuJgP6O91g-1; Mon,
 07 Jul 2025 04:15:54 -0400
X-MC-Unique: pakXk4O0OmGYwuJgP6O91g-1
X-Mimecast-MFC-AGG-ID: pakXk4O0OmGYwuJgP6O91g_1751876152
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6681944A8C; Mon,  7 Jul 2025 08:15:52 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A93518046C6; Mon,  7 Jul 2025 08:15:48 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 08/11] net: Allow network backends to advertise max TX
 queue size
Date: Mon,  7 Jul 2025 10:15:02 +0200
Message-ID: <20250707081505.127519-9-lvivier@redhat.com>
In-Reply-To: <20250707081505.127519-1-lvivier@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index 976d2b315a2f..74d2e3ed90f5 100644
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
index b52660436273..789717818317 100644
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
index b0830bac798a..a62992c8192e 100644
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
index eb26ed9bdcbf..8f4fddfb69ea 100644
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
index 79fa02a65c91..2f0cb55c9a77 100644
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
index 8a3df27b02cf..bf892915def1 100644
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
index c63225d3d2ed..353392b3d741 100644
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
2.49.0


