Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9118CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xMy-0003bJ-9u; Wed, 15 Oct 2025 05:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xMx-0003bB-LU
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xMn-0005BF-1S
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760518815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISvBYs0n358x6itNI8BKTjPYqeJGGv5CzQlrTQwezIs=;
 b=EOqisDY3PP2ogTanD0msXiVl0TMLe8igLpzFYJ4xIgJRGJijSFcKCTFqY3RMMeVZ7bTuWX
 n0yqh5y5Ypkfg/q8OwhPCFKWCwXfaiKimezzga3EhtlQJ+v14hF+uQik14O+6AkPwhpWpf
 TAdUcjUEf8Is3JgmXwGs/YmpmvDHUbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-MBQ42p-_Ogejc6I8qkuMmg-1; Wed,
 15 Oct 2025 05:00:11 -0400
X-MC-Unique: MBQ42p-_Ogejc6I8qkuMmg-1
X-Mimecast-MFC-AGG-ID: MBQ42p-_Ogejc6I8qkuMmg_1760518810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BCA319560B5; Wed, 15 Oct 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 526BF18003FC; Wed, 15 Oct 2025 09:00:04 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, jasowang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, david@redhat.com,
 manos.pitsidianakis@linaro.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com,
 dbassey@redhat.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v9 4/7] vhost_user: Add frontend get_shmem_config command
Date: Wed, 15 Oct 2025 10:59:27 +0200
Message-ID: <20251015085930.1517330-5-aesteve@redhat.com>
In-Reply-To: <20251015085930.1517330-1-aesteve@redhat.com>
References: <20251015085930.1517330-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The frontend can use this command to retrieve
VirtIO Shared Memory Regions configuration from
the backend. The response contains the number of
shared memory regions, their size, and shmid.

This is useful when the frontend is unaware of
specific backend type and configuration,
for example, in the `vhost-user-device` case.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c            | 44 +++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h | 10 +++++++
 include/hw/virtio/vhost-user.h    |  1 +
 include/hw/virtio/virtio.h        |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8a4385a5ad..c39cf52dbc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_SET_DEVICE_STATE_FD = 42,
     VHOST_USER_CHECK_DEVICE_STATE = 43,
+    VHOST_USER_GET_SHMEM_CONFIG = 44,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -138,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
     VhostUserMemoryRegion region;
 } VhostUserMemRegMsg;
 
+typedef struct VhostUserShMemConfig {
+    uint32_t nregions;
+    uint32_t padding;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+} VhostUserShMemConfig;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -244,6 +251,7 @@ typedef union {
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
         VhostUserMMap mmap;
+        VhostUserShMemConfig shmem;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -3226,6 +3234,41 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+static int vhost_user_get_shmem_config(struct vhost_dev *dev,
+                                       int *nregions,
+                                       uint64_t *memory_sizes,
+                                       Error **errp)
+{
+    int ret;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_SHMEM_CONFIG,
+        .hdr.flags = VHOST_USER_VERSION,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_SHMEM)) {
+        *nregions = 0;
+        return 0;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    assert(msg.payload.shmem.nregions <= VIRTIO_MAX_SHMEM_REGIONS);
+    *nregions = msg.payload.shmem.nregions;
+    memcpy(memory_sizes,
+           &msg.payload.shmem.memory_sizes,
+           sizeof(uint64_t) * VIRTIO_MAX_SHMEM_REGIONS);
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -3264,4 +3307,5 @@ const VhostOps user_ops = {
         .vhost_supports_device_state = vhost_user_supports_device_state,
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
+        .vhost_get_shmem_config = vhost_user_get_shmem_config,
 };
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa1734..ce58b4d2d6 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -163,6 +163,15 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
                                             int *reply_fd,
                                             Error **errp);
 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+/*
+ * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
+ * number of memory_sizes that will be accepted.
+ */
+typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
+                                         int *nregions,
+                                         uint64_t *memory_sizes,
+                                         Error **errp);
+
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -220,6 +229,7 @@ typedef struct VhostOps {
     vhost_supports_device_state_op vhost_supports_device_state;
     vhost_set_device_state_fd_op vhost_set_device_state_fd;
     vhost_check_device_state_op vhost_check_device_state;
+    vhost_get_shmem_config_op vhost_get_shmem_config;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 9a3f238b43..bacc7d184c 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
+    VHOST_USER_PROTOCOL_F_SHMEM = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index cee807e236..b05c4c8252 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -82,6 +82,8 @@ typedef struct VirtQueueElement
 
 #define VIRTIO_NO_VECTOR 0xffff
 
+#define VIRTIO_MAX_SHMEM_REGIONS 256
+
 /* special index value used internally for config irqs */
 #define VIRTIO_CONFIG_IRQ_IDX -1
 
-- 
2.49.0


