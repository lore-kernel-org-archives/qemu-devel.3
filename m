Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3ECC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChdN-0002i9-A5; Thu, 30 May 2024 11:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sChdL-0002hX-QI
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sChdJ-0008DZ-Q9
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717082640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bm4HWbT1lx3S9/NtXwHpR5rs4TO+4xVgMAS2NUFLYh0=;
 b=CKHXxU/h+lAZ0Mjp+8hIled3RDvg+G8f8o1tHlv4o+kxpD9fhCPUFLVwXMMxejPIVFRsFZ
 HSU26i/zFl+MHr2YC31cjpBPIe75OkcMCmvvHuVvVAbnm5L/7iMV0FSBMgBxllAYJPpe60
 HazDxADVIGgmExMn7BgSzV/YBl5E4UE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-HZpUbNbcMLGszDR4EFke3Q-1; Thu, 30 May 2024 11:22:30 -0400
X-MC-Unique: HZpUbNbcMLGszDR4EFke3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59E9800169
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:22:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93C902026D6E;
 Thu, 30 May 2024 15:22:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, slp@redhat.com, stefanha@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC PATCH 1/1] vhost-user: add shmem mmap request
Date: Thu, 30 May 2024 17:22:23 +0200
Message-ID: <20240530152223.780232-2-aesteve@redhat.com>
In-Reply-To: <20240530152223.780232-1-aesteve@redhat.com>
References: <20240530152223.780232-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add SHMEM_MAP/UNMAP requests to vhost-user.

This request allows backends to dynamically map
fds into a shared memory region indentified by
its `shmid`. Then, the fd memory is advertised
to the frontend through a BAR+offset, so it can
be read by the driver while its valid.

Then, the backend can munmap the memory range
in a given shared memory region (again, identified
by its `shmid`), to free it. After this, the
region becomes private and shall not be accessed
by the frontend anymore.

Initializing the memory region is reponsiblity
of the PCI device that will using it.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst |  23 ++++++++
 hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio.c          |   2 +
 include/hw/virtio/virtio.h  |   3 +
 4 files changed, 134 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d8419fd2f1..3caf2a290c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1859,6 +1859,29 @@ is sent by the front-end.
   when the operation is successful, or non-zero otherwise. Note that if the
   operation fails, no fd is sent to the backend.
 
+``VHOST_USER_BACKEND_SHMEM_MAP``
+  :id: 9
+  :equivalent ioctl: N/A
+  :request payload: fd and ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  This message can be submitted by the backends to advertise a new mapping
+  to be made in a given shared memory region. Upon receiving the message,
+  QEMU will mmap the given fd into the shared memory region with the
+  requested ``shmid``. A reply is generated indicating whether mapping
+  succeeded.
+
+``VHOST_USER_BACKEND_SHMEM_UNMAP``
+  :id: 10
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  This message can be submitted by the backends so that QEMU un-mmap
+  a given range (``offset``, ``len``) in the shared memory region with the
+  requested ``shmid``.
+  A reply is generated indicating whether unmapping succeeded.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..9526b9d07f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -192,6 +194,23 @@ typedef struct VhostUserShared {
     unsigned char uuid[16];
 } VhostUserShared;
 
+/* For the flags field of VhostUserMMap */
+#define VHOST_USER_FLAG_MAP_R (1u << 0)
+#define VHOST_USER_FLAG_MAP_W (1u << 1)
+
+typedef struct {
+    /* Shared memory region ID */
+    uint8_t shmid;
+    /* File offset */
+    uint64_t fd_offset;
+    /* Offset within the shared memory region */
+    uint64_t shm_offset;
+    /* Size of region to map */
+    uint64_t len;
+    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
+    uint64_t flags;
+} VhostUserMMap;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -224,6 +243,7 @@ typedef union {
         VhostUserInflight inflight;
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
+        VhostUserMMap mmap;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1748,6 +1768,85 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     return 0;
 }
 
+static int
+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
+                                  VhostUserMMap *vu_mmap,
+                                  int fd)
+{
+    void *addr = 0;
+    MemoryRegion *mr = NULL;
+
+    if (fd < 0) {
+        error_report("Bad fd for map");
+        return -EBADF;
+    }
+
+    if (!dev->vdev->shmem_list ||
+        dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
+        error_report("Shared memory region at "
+                     "ID %d unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    mr = &dev->vdev->shmem_list[vu_mmap->shmid];
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    void *shmem_ptr = memory_region_get_ram_ptr(mr);
+
+    addr = mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
+        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
+        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
+        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
+    if (addr == MAP_FAILED) {
+        error_report("Failed to mmap mem fd");
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
+static int
+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
+                                    VhostUserMMap *vu_mmap)
+{
+    void *addr = 0;
+    MemoryRegion *mr = NULL;
+
+    if (!dev->vdev->shmem_list ||
+        dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
+        error_report("Shared memory region at "
+                     "ID %d unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    mr = &dev->vdev->shmem_list[vu_mmap->shmid];
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    void *shmem_ptr = memory_region_get_ram_ptr(mr);
+
+    addr = mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
+                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+    if (addr == MAP_FAILED) {
+        error_report("Failed to unmap memory");
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
                                                              &hdr, &payload);
         break;
+    case VHOST_USER_BACKEND_SHMEM_MAP:
+        ret = vhost_user_backend_handle_shmem_map(dev, &payload.mmap,
+                                                fd ? fd[0] : -1);
+        break;
+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
+        ret = vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap);
+        break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
         ret = -EINVAL;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..59596370ec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
             virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
+    vdev->shmem_list = NULL;
+    vdev->n_shmem_regions = 0;
 }
 
 /*
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..34bec26593 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -165,6 +165,9 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    /* Shared memory region for vhost-user mappings. */
+    MemoryRegion *shmem_list;
+    int n_shmem_regions;
 };
 
 struct VirtioDeviceClass {
-- 
2.44.0


