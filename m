Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5DEC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvAg-0003HD-H1; Wed, 18 Jun 2025 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAe-0003Gz-AI
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAc-0008AG-C1
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5HqPeqt2g0OivT9RMZt8olKZ8J7MkH3B51wrkUa+lE=;
 b=d4HJsO0kRyCieb87wuN8cTA8BCMYvDFs6ACLyeq0LOoIDNUQV3B6nln7+I1ppNSVORA/Is
 FMaBjnVYwUM/ETtQZfe71brGCpjUG1mshKNsnyBHJkcIcR+ZFs4P5pcrrlX8UGp9ublhLO
 VDh3CgEnciibKiOpcgEoj2nTiWz+8mg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-9utjXzv2OCicZIqd0_hc1Q-1; Wed,
 18 Jun 2025 11:57:48 -0400
X-MC-Unique: 9utjXzv2OCicZIqd0_hc1Q-1
X-Mimecast-MFC-AGG-ID: 9utjXzv2OCicZIqd0_hc1Q_1750262267
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB2B1809C85; Wed, 18 Jun 2025 15:57:47 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3799A18002B0; Wed, 18 Jun 2025 15:57:42 +0000 (UTC)
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
Subject: [PATCH v2 05/10] net: Consolidate vhost feature bits into
 NetClientInfo
Date: Wed, 18 Jun 2025 17:57:13 +0200
Message-ID: <20250618155718.550968-6-lvivier@redhat.com>
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

Previously, the vhost_net_get_feature_bits() function in
hw/net/vhost_net.c used a large switch statement to determine
the appropriate feature bits based on the NetClientDriver type.

This created unnecessary coupling between the generic vhost layer
and specific network backends (like TAP, vhost-user, and
vhost-vdpa).

This patch moves the definition of vhost feature bits directly into the
NetClientInfo structure for each relevant network client.

This refactoring centralizes feature bit definitions where they're
needed, making code easier to add new vhost-enabled network backends
in the future without modifying core vhost logic.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c       | 80 ++--------------------------------------
 include/net/net.h        |  1 +
 include/net/vhost-vdpa.h |  2 -
 net/tap.c                | 19 ++++++++++
 net/vhost-user.c         | 43 +++++++++++++++++++++
 net/vhost-vdpa.c         |  4 +-
 6 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 16dadd022e75..3dff819d2dbd 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -36,86 +36,14 @@
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
 static const int *vhost_net_get_feature_bits(struct vhost_net *net)
 {
-    if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
-        return kernel_feature_bits;
-    }
-
-    if (qemu_is_vhost_user(net->nc)) {
-        return user_feature_bits;
+    if (net->nc->info->vhost_feature_bits == NULL) {
+        error_report("Feature bits not defined for this type: %d",
+                     net->nc->info->type);
     }
 
-#ifdef CONFIG_VHOST_NET_VDPA
-    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        return vdpa_feature_bits;
-    }
-#endif
-
-    error_report("Feature bits not defined for this type: %d",
-                 net->nc->info->type);
-
-    return 0;
+    return net->nc->info->vhost_feature_bits;
 }
 
 uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
diff --git a/include/net/net.h b/include/net/net.h
index 8a62cd6e8aab..dd11be11a39f 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -94,6 +94,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    const int *vhost_feature_bits;
     IsVHostUser *is_vhost_user;
     GetVHostNet *get_vhost_net;
 } NetClientInfo;
diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
index 916ead3793d9..f8d7d6c9045b 100644
--- a/include/net/vhost-vdpa.h
+++ b/include/net/vhost-vdpa.h
@@ -14,6 +14,4 @@
 
 #define TYPE_VHOST_VDPA "vhost-vdpa"
 
-extern const int vdpa_feature_bits[];
-
 #endif /* VHOST_VDPA_H */
diff --git a/net/tap.c b/net/tap.c
index 4beba6d7a784..9e5b1a02d8d3 100644
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
@@ -360,6 +378,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .vhost_feature_bits = kernel_feature_bits,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2caa7e56f7a0..d8fef801de5a 100644
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
@@ -240,6 +282,7 @@ static NetClientInfo net_vhost_user_info = {
         .check_peer_type = vhost_user_check_peer_type,
         .is_vhost_user = vhost_user_is_vhost_user,
         .get_vhost_net = vhost_user_get_vhost_net,
+        .vhost_feature_bits = user_feature_bits,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0b86c917ed68..bd699066a3ab 100644
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
@@ -433,6 +433,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
         .get_vhost_net = vhost_vdpa_get_vhost_net,
+        .vhost_feature_bits = vdpa_feature_bits,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1289,6 +1290,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
     .get_vhost_net = vhost_vdpa_get_vhost_net,
+    .vhost_feature_bits = vdpa_feature_bits,
 };
 
 /*
-- 
2.49.0


