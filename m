Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A49C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 16:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvAu-0003JL-Ud; Wed, 18 Jun 2025 11:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAs-0003Is-Fk
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAq-0008Bi-QA
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kActzQWZPLXpkEvMFVLwpdhw0QHrTWdRdX5HrsZdUvs=;
 b=UikcorhG9e3oisoMwUfZEeuJAi2HYHbxFVTa6rhtRpyHkW8AWwh16Gq2hQQqI9OtjqRN6g
 Mx+xM0hEs6s1EbpSGZS7Lg/+ifanPUVOBQ6F22ZhJCAnTayAELAZKvRV1FuoNlT46qTgjm
 KRERznQWb6+2ZMNxjgiGpVWe6SV0UzY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-taopULcsNBK1duBOfqX_7w-1; Wed,
 18 Jun 2025 11:58:00 -0400
X-MC-Unique: taopULcsNBK1duBOfqX_7w-1
X-Mimecast-MFC-AGG-ID: taopULcsNBK1duBOfqX_7w_1750262279
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9AA01800C25; Wed, 18 Jun 2025 15:57:59 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C095D180045B; Wed, 18 Jun 2025 15:57:55 +0000 (UTC)
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
Subject: [PATCH v2 08/10] net: Allow network backends to advertise max TX
 queue size
Date: Wed, 18 Jun 2025 17:57:16 +0200
Message-ID: <20250618155718.550968-9-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-1-lvivier@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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

This commit refactors how the maximum transmit queue size for
virtio-net devices is determined, making the mechanism more generic
and extensible.

Previously, virtio_net_max_tx_queue_size() contained hardcoded
checks for specific network backend types (vhost-user and
vhost-vdpa) to determine their supported maximum queue size. This
created direct dependencies and would require modifications for
every new backend that supports variable queue sizes.

To improve flexibility, a new max_tx_queue_size field is added
to the NetClientInfo structure. This allows each network backend
to advertise its supported maximum transmit queue size directly.

This change centralizes the configuration of transmit queue sizes,
simplifying the virtio-net driver and making it easier to integrate
new network backends with diverse queue size capabilities.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c | 16 ++--------------
 include/net/net.h   |  1 +
 net/vhost-user.c    |  1 +
 net/vhost-vdpa.c    |  2 ++
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1367d2b581b1..2468621375e9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -671,23 +671,11 @@ static int virtio_net_max_tx_queue_size(VirtIONet *n)
 {
     NetClientState *peer = n->nic_conf.peers.ncs[0];
 
-    /*
-     * Backends other than vhost-user or vhost-vdpa don't support max queue
-     * size.
-     */
-    if (!peer) {
+    if (!peer || !peer->info->max_tx_queue_size) {
         return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
     }
 
-    if (qemu_is_vhost_user(peer)) {
-        return VIRTQUEUE_MAX_SIZE;
-    }
-
-    if (peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        return VIRTQUEUE_MAX_SIZE;
-    }
-
-    return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+    return peer->info->max_tx_queue_size;
 }
 
 static int peer_attach(VirtIONet *n, int index)
diff --git a/include/net/net.h b/include/net/net.h
index 179ffee5bd11..25dd29e07d7f 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -101,6 +101,7 @@ typedef struct NetClientInfo {
     GetVHostNet *get_vhost_net;
     GetAckedFeatures *get_acked_features;
     SaveAcketFeatures *save_acked_features;
+    int max_tx_queue_size;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 15609faedb88..89d216714c13 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -284,6 +284,7 @@ static NetClientInfo net_vhost_user_info = {
         .vhost_feature_bits = user_feature_bits,
         .get_acked_features = vhost_user_get_acked_features,
         .save_acked_features = vhost_user_save_acked_features,
+        .max_tx_queue_size = VIRTQUEUE_MAX_SIZE,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bd699066a3ab..4fc5d381ceef 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -434,6 +434,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
         .get_vhost_net = vhost_vdpa_get_vhost_net,
         .vhost_feature_bits = vdpa_feature_bits,
+        .max_tx_queue_size = VIRTQUEUE_MAX_SIZE,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1291,6 +1292,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
     .get_vhost_net = vhost_vdpa_get_vhost_net,
     .vhost_feature_bits = vdpa_feature_bits,
+    .max_tx_queue_size = VIRTQUEUE_MAX_SIZE,
 };
 
 /*
-- 
2.49.0


