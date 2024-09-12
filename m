Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D1EED610
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solDF-0001gA-11; Thu, 12 Sep 2024 10:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solDB-0001f9-Ti
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solD9-0000IU-Om
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=begHxUsoQRgZERRTwqdiGrBOXuooiARyTfZVLIOy1Ww=;
 b=Dqe2mRJn2REixov7KIU1jThqsgDZ2aCmmeqkLlKGXHNT0+lc5ZSaQ2VO0qL4Qnq6YA1nYb
 +zmtsl4O9Vk0pqsq5PoVS2MytUKajrTODHjSGYDdW9Qkbq6BinjzeqL06irSzdRScGM+oL
 gEPkM6TilCUzGFET5N2diwi+LYcLdD0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-a1HWPKGuNc6bdcTrWiqgig-1; Thu,
 12 Sep 2024 10:54:17 -0400
X-MC-Unique: a1HWPKGuNc6bdcTrWiqgig-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757D91955F3C; Thu, 12 Sep 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B319719560A3; Thu, 12 Sep 2024 14:54:11 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 5/5] vhost_user: Add MEM_READ/WRITE backend requests
Date: Thu, 12 Sep 2024 16:53:35 +0200
Message-ID: <20240912145335.129447-6-aesteve@redhat.com>
In-Reply-To: <20240912145335.129447-1-aesteve@redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With SHMEM_MAP messages, sharing descriptors between
devices will cause that these devices do not see the
mappings, and fail to access these memory regions.

To solve this, introduce MEM_READ/WRITE requests
that will get triggered as a fallback when
vhost-user memory translation fails.

MEM_READ/WRITE requests have flexible array members,
since we do not know in advance the number of bytes
in the mapped region. Therefore, we need to allow
bigger message sizes for these types, and ensure
we allocate sufficient memory for them.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c                    | 99 +++++++++++++++++------
 subprojects/libvhost-user/libvhost-user.c | 84 +++++++++++++++++++
 subprojects/libvhost-user/libvhost-user.h | 38 +++++++++
 3 files changed, 197 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 83f5c02bea..8a4718ae10 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -120,6 +120,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_SHMEM_MAP = 9,
     VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
+    VHOST_USER_BACKEND_MEM_READ = 11,
+    VHOST_USER_BACKEND_MEM_WRITE = 12,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -147,6 +149,12 @@ typedef struct VhostUserShMemConfig {
     uint64_t memory_sizes[VHOST_MEMORY_BASELINE_NREGIONS];
 } VhostUserShMemConfig;
 
+typedef struct VhostUserMemRWMsg {
+    uint64_t guest_address;
+    uint32_t size;
+    uint8_t data[];
+} VhostUserMemRWMsg;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -255,6 +263,7 @@ typedef union {
         VhostUserTransferDeviceState transfer_state;
         VhostUserMMap mmap;
         VhostUserShMemConfig shmem;
+        VhostUserMemRWMsg mem_rw;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -343,17 +352,23 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
         return r;
     }
 
-    /* validate message size is sane */
-    if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
-        error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", msg->hdr.size,
-                VHOST_USER_PAYLOAD_SIZE);
-        return -EPROTO;
-    }
-
     if (msg->hdr.size) {
         p += VHOST_USER_HDR_SIZE;
         size = msg->hdr.size;
+        /* validate message size is sane */
+        if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
+            switch(msg->hdr.request) {
+                case VHOST_USER_BACKEND_MEM_READ:
+                case VHOST_USER_BACKEND_MEM_WRITE:
+                    p = g_malloc0(size);
+                    break;
+                default:
+                    error_report("Failed to read msg header."
+                                 " Size %d exceeds the maximum %zu.",
+                                 size, VHOST_USER_PAYLOAD_SIZE);
+                    return -EPROTO;
+            }
+        }
         r = qemu_chr_fe_read_all(chr, p, size);
         if (r != size) {
             int saved_errno = errno;
@@ -1885,6 +1900,28 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
     return 0;
 }
 
+static int
+vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
+                                   VhostUserMemRWMsg *mem_rw)
+{
+    MemTxResult result;
+    result = address_space_read(dev->vdev->dma_as, mem_rw->guest_address,
+                                MEMTXATTRS_UNSPECIFIED, &mem_rw->data,
+                                mem_rw->size);
+    return result;
+}
+
+static int
+vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
+                                   VhostUserMemRWMsg *mem_rw)
+{
+    MemTxResult result;
+    result = address_space_write(dev->vdev->dma_as, mem_rw->guest_address,
+                                 MEMTXATTRS_UNSPECIFIED, &mem_rw->data,
+                                 mem_rw->size);
+    return result;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1900,7 +1937,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     struct vhost_dev *dev = opaque;
     struct vhost_user *u = dev->opaque;
     VhostUserHeader hdr = { 0, };
-    VhostUserPayload payload = { 0, };
+    VhostUserPayload *payload = g_new0(VhostUserPayload, 1);
     Error *local_err = NULL;
     gboolean rc = G_SOURCE_CONTINUE;
     int ret = 0;
@@ -1919,46 +1956,59 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     }
 
     if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
-        error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", hdr.size,
-                VHOST_USER_PAYLOAD_SIZE);
-        goto err;
+        switch (hdr.request) {
+            case VHOST_USER_BACKEND_MEM_READ:
+            case VHOST_USER_BACKEND_MEM_WRITE:
+                payload = g_malloc0(hdr.size);
+                break;
+            default:
+                error_report("Failed to read msg header."
+                             " Size %d exceeds the maximum %zu.", hdr.size,
+                             VHOST_USER_PAYLOAD_SIZE);
+                goto err;
+        }
     }
 
     /* Read payload */
-    if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
+    if (qio_channel_read_all(ioc, (char *) payload, hdr.size, &local_err)) {
         error_report_err(local_err);
         goto err;
     }
 
     switch (hdr.request) {
     case VHOST_USER_BACKEND_IOTLB_MSG:
-        ret = vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
+        ret = vhost_backend_handle_iotlb_msg(dev, &payload->iotlb);
         break;
     case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
         ret = vhost_user_backend_handle_config_change(dev);
         break;
     case VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG:
-        ret = vhost_user_backend_handle_vring_host_notifier(dev, &payload.area,
+        ret = vhost_user_backend_handle_vring_host_notifier(dev, &payload->area,
                                                           fd ? fd[0] : -1);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:
-        ret = vhost_user_backend_handle_shared_object_add(dev, &payload.object);
+        ret = vhost_user_backend_handle_shared_object_add(dev, &payload->object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
         ret = vhost_user_backend_handle_shared_object_remove(dev,
-                                                             &payload.object);
+                                                             &payload->object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+                                                             &hdr, payload);
         break;
     case VHOST_USER_BACKEND_SHMEM_MAP:
-        ret = vhost_user_backend_handle_shmem_map(dev, &payload.mmap,
+        ret = vhost_user_backend_handle_shmem_map(dev, &payload->mmap,
                                                   fd ? fd[0] : -1);
         break;
     case VHOST_USER_BACKEND_SHMEM_UNMAP:
-        ret = vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap);
+        ret = vhost_user_backend_handle_shmem_unmap(dev, &payload->mmap);
+        break;
+    case VHOST_USER_BACKEND_MEM_READ:
+        ret = vhost_user_backend_handle_mem_read(dev, &payload->mem_rw);
+        break;
+    case VHOST_USER_BACKEND_MEM_WRITE:
+        ret = vhost_user_backend_handle_mem_write(dev, &payload->mem_rw);
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
@@ -1970,10 +2020,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * directly in their request handlers.
      */
     if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        payload.u64 = !!ret;
-        hdr.size = sizeof(payload.u64);
+        payload->u64 = !!ret;
+        hdr.size = sizeof(payload->u64);
 
-        if (!vhost_user_send_resp(ioc, &hdr, &payload, &local_err)) {
+        if (!vhost_user_send_resp(ioc, &hdr, payload, &local_err)) {
             error_report_err(local_err);
             goto err;
         }
@@ -1991,6 +2041,7 @@ fdcleanup:
             close(fd[i]);
         }
     }
+    g_free(payload);
     return rc;
 }
 
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 496268e12b..08de54896b 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1652,6 +1652,90 @@ vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_t len)
     return vu_process_message_reply(dev, &vmsg);
 }
 
+bool
+vu_send_mem_read(VuDev *dev, uint64_t guest_addr, uint32_t size,
+                 uint8_t *data)
+{
+    VhostUserMsg msg_reply;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_MEM_READ,
+        .size = sizeof(msg.payload.mem_rw),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .payload = {
+            .mem_rw = {
+                .guest_address = guest_addr,
+                .size = size,
+            }
+        }
+    };
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
+        goto out_err;
+    }
+
+    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
+        goto out_err;
+    }
+
+    if (msg_reply.request != msg.request) {
+        DPRINT("Received unexpected msg type. Expected %d, received %d",
+               msg.request, msg_reply.request);
+        goto out_err;
+    }
+
+    if (msg_reply.payload.mem_rw.size != size) {
+        DPRINT("Received unexpected number of bytes in the response. "
+               "Expected %d, received %d",
+               size, msg_reply.payload.mem_rw.size);
+        goto out_err;
+    }
+
+    data = malloc(msg_reply.payload.mem_rw.size);
+    if (!data) {
+        DPRINT("Failed to malloc read memory data");
+        goto out_err;
+    }
+
+    memcpy(data, msg_reply.payload.mem_rw.data, size);
+    pthread_mutex_unlock(&dev->backend_mutex);
+    return true;
+
+out_err:
+    pthread_mutex_unlock(&dev->backend_mutex);
+    return false;
+}
+
+bool
+vu_send_mem_write(VuDev *dev, uint64_t guest_addr, uint32_t size,
+                  uint8_t *data)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_MEM_WRITE,
+        .size = sizeof(msg.payload.mem_rw),
+        .flags = VHOST_USER_VERSION,
+        .payload = {
+            .mem_rw = {
+                .guest_address = guest_addr,
+                .size = size,
+            }
+        }
+    };
+    memcpy(msg.payload.mem_rw.data, data, size);
+
+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
+        return false;
+    }
+
+    /* Also unlocks the backend_mutex */
+    return vu_process_message_reply(dev, &msg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index ea4902e876..8ec49dcb1b 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -129,6 +129,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_SHMEM_MAP = 9,
     VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
+    VHOST_USER_BACKEND_MEM_READ = 11,
+    VHOST_USER_BACKEND_MEM_WRITE = 12,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -152,6 +154,12 @@ typedef struct VhostUserMemRegMsg {
     VhostUserMemoryRegion region;
 } VhostUserMemRegMsg;
 
+typedef struct VhostUserMemRWMsg {
+    uint64_t guest_address;
+    uint32_t size;
+    uint8_t data[];
+} VhostUserMemRWMsg;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -235,6 +243,7 @@ typedef struct VhostUserMsg {
         VhostUserInflight inflight;
         VhostUserShared object;
         VhostUserMMap mmap;
+        VhostUserMemRWMsg mem_rw;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -649,6 +658,35 @@ bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
 bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
                     uint64_t len);
 
+/**
+ * vu_send_mem_read:
+ * @dev: a VuDev context
+ * @guest_addr: guest physical address to read
+ * @size: number of bytes to read
+ * @data: head of an unitialized bytes array
+ *
+ * Reads `size` bytes of `guest_addr` in the frontend and stores
+ * them in `data`.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_send_mem_read(VuDev *dev, uint64_t guest_addr, uint32_t size,
+                      uint8_t *data);
+
+/**
+ * vu_send_mem_write:
+ * @dev: a VuDev context
+ * @guest_addr: guest physical address to write
+ * @size: number of bytes to write
+ * @data: head of an array with `size` bytes to write
+ *
+ * Writes `size` bytes from `data` into `guest_addr` in the frontend.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_send_mem_write(VuDev *dev, uint64_t guest_addr, uint32_t size,
+                      uint8_t *data);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
-- 
2.45.2


