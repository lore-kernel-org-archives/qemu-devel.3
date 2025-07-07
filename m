Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB6EC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh0u-00008A-ID; Mon, 07 Jul 2025 04:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0r-000060-Qp
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0p-0007Qy-Jh
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfZjc6j5sXAM2bS0yOshLl4QKC/OUj5fmMiiuI37S1o=;
 b=NqMGOAvPt5kCtagY2ijwJoWCY6H+bvbVi62lcew7wHJf0jeEta9BAZhRnEl4op5zXaiTE1
 30spC86NI/A3RuT1BXf89/8ggQ5EUa4Bo0r//SMZdpNtqIJMAH8d7GZZi7dwdSHVDv6uAr
 VIWw+oa1V53gDN6QBD7J6xo/JosyWzo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-Ntm4E7HMN8CTbnFNkBef6A-1; Mon,
 07 Jul 2025 04:15:39 -0400
X-MC-Unique: Ntm4E7HMN8CTbnFNkBef6A-1
X-Mimecast-MFC-AGG-ID: Ntm4E7HMN8CTbnFNkBef6A_1751876138
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18CC0180028F; Mon,  7 Jul 2025 08:15:38 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF6121803AF2; Mon,  7 Jul 2025 08:15:33 +0000 (UTC)
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
Subject: [PATCH v3 05/11] net: Consolidate vhost feature bits into vhost_net
 structure
Date: Mon,  7 Jul 2025 10:14:59 +0200
Message-ID: <20250707081505.127519-6-lvivier@redhat.com>
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

Previously, the vhost_net_get_feature_bits() function in
hw/net/vhost_net.c used a large switch statement to determine
the appropriate feature bits based on the NetClientDriver type.

This created unnecessary coupling between the generic vhost layer
and specific network backends (like TAP, vhost-user, and
vhost-vdpa).

This patch moves the definition of vhost feature bits directly into the
vhost_net structure for each relevant network client.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c        | 90 ++-------------------------------------
 include/hw/virtio/vhost.h |  1 +
 include/net/vhost-vdpa.h  |  2 -
 include/net/vhost_net.h   |  1 +
 net/tap.c                 | 19 +++++++++
 net/vhost-user.c          | 43 +++++++++++++++++++
 net/vhost-vdpa.c          |  3 +-
 7 files changed, 69 insertions(+), 90 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index db8b97b753d8..787c769ccc37 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -36,94 +36,9 @@
 #include "hw/virtio/virtio-bus.h"
 #include "linux-headers/linux/vhost.h"
 
-
-/* Features supported by host kernel. */
-static const int kernel_feature_bits[] = {
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
-    VIRTIO_NET_F_MRG_RXBUF,
-    VIRTIO_F_VERSION_1,
-    VIRTIO_NET_F_MTU,
-    VIRTIO_F_IOMMU_PLATFORM,
-    VIRTIO_F_RING_PACKED,
-    VIRTIO_F_RING_RESET,
-    VIRTIO_F_IN_ORDER,
-    VIRTIO_F_NOTIFICATION_DATA,
-    VIRTIO_NET_F_RSC_EXT,
-    VIRTIO_NET_F_HASH_REPORT,
-    VHOST_INVALID_FEATURE_BIT
-};
-
-/* Features supported by others. */
-static const int user_feature_bits[] = {
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_F_NOTIFICATION_DATA,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
-
-    VIRTIO_F_ANY_LAYOUT,
-    VIRTIO_F_VERSION_1,
-    VIRTIO_NET_F_CSUM,
-    VIRTIO_NET_F_GUEST_CSUM,
-    VIRTIO_NET_F_GSO,
-    VIRTIO_NET_F_GUEST_TSO4,
-    VIRTIO_NET_F_GUEST_TSO6,
-    VIRTIO_NET_F_GUEST_ECN,
-    VIRTIO_NET_F_GUEST_UFO,
-    VIRTIO_NET_F_HOST_TSO4,
-    VIRTIO_NET_F_HOST_TSO6,
-    VIRTIO_NET_F_HOST_ECN,
-    VIRTIO_NET_F_HOST_UFO,
-    VIRTIO_NET_F_MRG_RXBUF,
-    VIRTIO_NET_F_MTU,
-    VIRTIO_F_IOMMU_PLATFORM,
-    VIRTIO_F_RING_PACKED,
-    VIRTIO_F_RING_RESET,
-    VIRTIO_F_IN_ORDER,
-    VIRTIO_NET_F_RSS,
-    VIRTIO_NET_F_RSC_EXT,
-    VIRTIO_NET_F_HASH_REPORT,
-    VIRTIO_NET_F_GUEST_USO4,
-    VIRTIO_NET_F_GUEST_USO6,
-    VIRTIO_NET_F_HOST_USO,
-
-    /* This bit implies RARP isn't sent by QEMU out of band */
-    VIRTIO_NET_F_GUEST_ANNOUNCE,
-
-    VIRTIO_NET_F_MQ,
-
-    VHOST_INVALID_FEATURE_BIT
-};
-
-static const int *vhost_net_get_feature_bits(struct vhost_net *net)
-{
-    const int *feature_bits = 0;
-
-    switch (net->nc->info->type) {
-    case NET_CLIENT_DRIVER_TAP:
-        feature_bits = kernel_feature_bits;
-        break;
-    case NET_CLIENT_DRIVER_VHOST_USER:
-        feature_bits = user_feature_bits;
-        break;
-#ifdef CONFIG_VHOST_NET_VDPA
-    case NET_CLIENT_DRIVER_VHOST_VDPA:
-        feature_bits = vdpa_feature_bits;
-        break;
-#endif
-    default:
-        error_report("Feature bits not defined for this type: %d",
-                net->nc->info->type);
-        break;
-    }
-
-    return feature_bits;
-}
-
 uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
-    return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
+    return vhost_get_features(&net->dev, net->feature_bits,
             features);
 }
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
@@ -140,7 +55,7 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
-    vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
+    vhost_ack_features(&net->dev, net->feature_bits, features);
 }
 
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
@@ -329,6 +244,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     }
     net->nc = options->net_backend;
     net->dev.nvqs = options->nvqs;
+    net->feature_bits = options->feature_bits;
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 38800a7156b0..6a75fdc0213c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -143,6 +143,7 @@ struct vhost_net {
     struct vhost_dev dev;
     struct vhost_virtqueue vqs[2];
     int backend;
+    const int *feature_bits;
     NetClientState *nc;
 };
 
diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
index 916ead3793d9..f8d7d6c9045b 100644
--- a/include/net/vhost-vdpa.h
+++ b/include/net/vhost-vdpa.h
@@ -14,6 +14,4 @@
 
 #define TYPE_VHOST_VDPA "vhost-vdpa"
 
-extern const int vdpa_feature_bits[];
-
 #endif /* VHOST_VDPA_H */
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 0f40049f3419..fbed37385a3c 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -12,6 +12,7 @@ typedef struct VhostNetOptions {
     NetClientState *net_backend;
     uint32_t busyloop_timeout;
     unsigned int nvqs;
+    const int *feature_bits;
     void *opaque;
 } VhostNetOptions;
 
diff --git a/net/tap.c b/net/tap.c
index 4beba6d7a784..a33eb2321242 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -42,11 +42,29 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
+#include "hw/virtio/vhost.h"
 
 #include "net/tap.h"
 
 #include "net/vhost_net.h"
 
+static const int kernel_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_F_RING_RESET,
+    VIRTIO_F_IN_ORDER,
+    VIRTIO_F_NOTIFICATION_DATA,
+    VIRTIO_NET_F_RSC_EXT,
+    VIRTIO_NET_F_HASH_REPORT,
+    VHOST_INVALID_FEATURE_BIT
+};
+
 typedef struct TAPState {
     NetClientState nc;
     int fd;
@@ -725,6 +743,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
         options.nvqs = 2;
+        options.feature_bits = kernel_feature_bits;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index b7bf0d2042e8..bc8e82a09263 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -12,7 +12,9 @@
 #include "clients.h"
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
+#include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
+#include "standard-headers/linux/virtio_net.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-net.h"
@@ -22,6 +24,46 @@
 #include "qemu/option.h"
 #include "trace.h"
 
+static const int user_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_CSUM,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_TSO4,
+    VIRTIO_NET_F_GUEST_TSO6,
+    VIRTIO_NET_F_GUEST_ECN,
+    VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HOST_TSO4,
+    VIRTIO_NET_F_HOST_TSO6,
+    VIRTIO_NET_F_HOST_ECN,
+    VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_F_RING_RESET,
+    VIRTIO_F_IN_ORDER,
+    VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_RSC_EXT,
+    VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
+    VIRTIO_NET_F_HOST_USO,
+
+    /* This bit implies RARP isn't sent by QEMU out of band */
+    VIRTIO_NET_F_GUEST_ANNOUNCE,
+
+    VIRTIO_NET_F_MQ,
+
+    VHOST_INVALID_FEATURE_BIT
+};
+
 typedef struct NetVhostUserState {
     NetClientState nc;
     CharBackend chr; /* only queue index 0 */
@@ -96,6 +138,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.opaque      = be;
         options.busyloop_timeout = 0;
         options.nvqs = 2;
+        options.feature_bits = user_feature_bits;
         net = vhost_net_init(&options);
         if (!net) {
             error_report("failed to init vhost_net for queue %d", i);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0b86c917ed68..cbbea0eb7198 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -55,7 +55,7 @@ typedef struct VhostVDPAState {
  * with the exception of VHOST_INVALID_FEATURE_BIT,
  * which should always be the last entry.
  */
-const int vdpa_feature_bits[] = {
+static const int vdpa_feature_bits[] = {
     VIRTIO_F_ANY_LAYOUT,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_NOTIFY_ON_EMPTY,
@@ -201,6 +201,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.opaque      = be;
     options.busyloop_timeout = 0;
     options.nvqs = nvqs;
+    options.feature_bits = vdpa_feature_bits;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.49.0


