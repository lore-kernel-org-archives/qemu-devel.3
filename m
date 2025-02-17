Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E934C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4C7-0004Wo-A9; Mon, 17 Feb 2025 11:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4C5-0004WN-Ib
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4C1-0007wp-VI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyNhzrr1DeEeNg443omaN6Fe2+QnPDF5gl9hKYrI+WU=;
 b=Q0oX2D631Swv44oI6jTlQVCwdmlByZxOFzMiYWl/5KZ8Atge/dPeIhdaHhzTUiQFMDfW6R
 2DTn8DB/cqC7hK/Jfl5MQkyuQIpzdYs2ONz2PERMXE4L3YWYxJSRFALlEAmsXNpRaA8MR/
 d7T+bKnMdRGkVytYKL+5HJ2qoPGq7LM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-4KyFTZjCOtKbaraZN2ipCw-1; Mon,
 17 Feb 2025 11:40:26 -0500
X-MC-Unique: 4KyFTZjCOtKbaraZN2ipCw-1
X-Mimecast-MFC-AGG-ID: 4KyFTZjCOtKbaraZN2ipCw_1739810425
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C826718D95F1; Mon, 17 Feb 2025 16:40:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01F691800874; Mon, 17 Feb 2025 16:40:19 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
 david@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 1/9] vhost-user: Add VirtIO Shared Memory map request
Date: Mon, 17 Feb 2025 17:40:04 +0100
Message-ID: <20250217164012.246727-2-aesteve@redhat.com>
In-Reply-To: <20250217164012.246727-1-aesteve@redhat.com>
References: <20250217164012.246727-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add SHMEM_MAP/UNMAP requests to vhost-user to
handle VIRTIO Shared Memory mappings.

This request allows backends to dynamically map
fds into a VIRTIO Shared Memory Region indentified
by its `shmid`. The map is performed by calling
`memory_region_init_ram_from_fd` and adding the
new region as a subregion of the shmem container
MR. Then, the fd memory is advertised to the
driver as a base addres + offset, so it can be
read/written (depending on the mmap flags
requested) while it is valid.

The backend can unmap the memory range
in a given VIRTIO Shared Memory Region (again,
identified by its `shmid`), to free it.
Upon receiving this message, the front-end
must delete the MR as a subregion of
the shmem container region and free its
resources.

Note that commit all these operations need
to be delayed to after we respond the request
to the backend to avoid deadlocks.

The device model needs to create VirtSharedMemory
instances for the VirtIO Shared Memory Regions
and add them to the `VirtIODevice` instance.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c                    | 134 ++++++++++++++++++++++
 hw/virtio/virtio.c                        |  81 +++++++++++++
 include/hw/virtio/virtio.h                |  27 +++++
 subprojects/libvhost-user/libvhost-user.c |  70 +++++++++++
 subprojects/libvhost-user/libvhost-user.h |  55 +++++++++
 5 files changed, 367 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 267b612587..d88e6f8c3c 100644
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
 
@@ -192,6 +194,24 @@ typedef struct VhostUserShared {
     unsigned char uuid[16];
 } VhostUserShared;
 
+/* For the flags field of VhostUserMMap */
+#define VHOST_USER_FLAG_MAP_R (1u << 0)
+#define VHOST_USER_FLAG_MAP_W (1u << 1)
+
+typedef struct {
+    /* VIRTIO Shared Memory Region ID */
+    uint8_t shmid;
+    uint8_t padding[7];
+    /* File offset */
+    uint64_t fd_offset;
+    /* Offset within the VIRTIO Shared Memory Region */
+    uint64_t shm_offset;
+    /* Size of the mapping */
+    uint64_t len;
+    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
+    uint64_t flags;
+} VhostUserMMap;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -224,6 +244,7 @@ typedef union {
         VhostUserInflight inflight;
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
+        VhostUserMMap mmap;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1770,6 +1791,111 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     return 0;
 }
 
+static int
+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
+                                    QIOChannel *ioc,
+                                    VhostUserHeader *hdr,
+                                    VhostUserPayload *payload,
+                                    int fd, Error **errp)
+{
+    VirtSharedMemory *shmem = NULL;
+    VhostUserMMap *vu_mmap = &payload->mmap;
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+
+    if (fd < 0) {
+        error_report("Bad fd for map");
+        return -EBADF;
+    }
+
+    if (!dev->vdev->shmem_list ||
+        dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
+        error_report("Device only has %d VIRTIO Shared Memory Regions. "
+                     "Requested ID: %d",
+                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    shmem = &dev->vdev->shmem_list[vu_mmap->shmid];
+
+    if (!shmem) {
+        error_report("VIRTIO Shared Memory Region at "
+                     "ID %d unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    g_string_printf(shm_name, "virtio-shm%i-%lu",
+                    vu_mmap->shmid, vu_mmap->shm_offset);
+
+    memory_region_transaction_begin();
+    virtio_add_shmem_map(shmem, shm_name->str, vu_mmap->shm_offset,
+                         vu_mmap->fd_offset, vu_mmap->len, fd, errp);
+
+    hdr->size = sizeof(payload->u64);
+    vhost_user_send_resp(ioc, hdr, payload, errp);
+    memory_region_transaction_commit();
+
+    return 0;
+}
+
+static int
+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
+                                      QIOChannel *ioc,
+                                      VhostUserHeader *hdr,
+                                      VhostUserPayload *payload,
+                                      Error **errp)
+{
+    VirtSharedMemory *shmem = NULL;
+    MappedMemoryRegion *mmap = NULL;
+    VhostUserMMap *vu_mmap = &payload->mmap;
+
+    if (!dev->vdev->shmem_list ||
+        dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
+        error_report("Device only has %d VIRTIO Shared Memory Regions. "
+                     "Requested ID: %d",
+                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    shmem = &dev->vdev->shmem_list[vu_mmap->shmid];
+
+    if (!shmem) {
+        error_report("VIRTIO Shared Memory Region at "
+                     "ID %d unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    mmap = virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+    if (!mmap) {
+        return -EFAULT;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_del_subregion(shmem->mr, mmap->mem);
+
+    hdr->size = sizeof(payload->u64);
+    vhost_user_send_resp(ioc, hdr, payload, errp);
+    memory_region_transaction_commit();
+
+    /* Free the MemoryRegion only after vhost_commit */
+    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+
+    return 0;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1837,6 +1963,14 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
                                                              &hdr, &payload);
+    case VHOST_USER_BACKEND_SHMEM_MAP:
+        ret = vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
+                                                  fd ? fd[0] : -1, &local_err);
+        break;
+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
+        ret = vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload,
+                                                    &local_err);
+        break;
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce37..47d0ddb820 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3063,6 +3063,75 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
 }
 
+VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev)
+{
+    ++vdev->n_shmem_regions;
+    vdev->shmem_list = g_renew(VirtSharedMemory, vdev->shmem_list,
+                               vdev->n_shmem_regions);
+    vdev->shmem_list[vdev->n_shmem_regions - 1].mr = g_new0(MemoryRegion, 1);
+    QTAILQ_INIT(&vdev->shmem_list[vdev->n_shmem_regions - 1].mmaps);
+    return &vdev->shmem_list[vdev->n_shmem_regions - 1];
+}
+
+void virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_name,
+                          hwaddr shm_offset, hwaddr fd_offset, uint64_t size,
+                          int fd, Error **errp)
+{
+    MappedMemoryRegion *mmap;
+    fd = dup(fd);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "Failed to duplicate fd");
+        return;
+    }
+
+    if (shm_offset + size > shmem->mr->size) {
+        error_setg(errp, "Memory exceeds the shared memory boundaries");
+        return;
+    }
+
+    mmap = g_new0(MappedMemoryRegion, 1);
+    mmap->mem = g_new0(MemoryRegion, 1);
+    mmap->offset = shm_offset;
+    if (!memory_region_init_ram_from_fd(mmap->mem,
+                                        OBJECT(shmem->mr),
+                                        shm_name, size, RAM_SHARED,
+                                        fd, fd_offset, errp)) {
+        error_setg(errp, "Failed to mmap region %s", shm_name);
+        close(fd);
+        g_free(mmap->mem);
+        g_free(mmap);
+        return;
+    }
+    memory_region_add_subregion(shmem->mr, shm_offset, mmap->mem);
+
+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
+}
+
+MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
+                                          hwaddr offset, uint64_t size)
+{
+    MappedMemoryRegion *mmap;
+    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
+        if (mmap->offset == offset && mmap->mem->size == size) {
+            return mmap;
+        }
+    }
+    return NULL;
+}
+
+void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size)
+{
+    MappedMemoryRegion *mmap = virtio_find_shmem_map(shmem, offset, size);
+    if (mmap == NULL) {
+        return;
+    }
+
+    object_unparent(OBJECT(mmap->mem));
+    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
+    g_free(mmap);
+}
+
 /* A wrapper for use as a VMState .put function */
 static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
                               const VMStateField *field, JSONWriter *vmdesc)
@@ -3492,6 +3561,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
             virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
+    vdev->shmem_list = NULL;
+    vdev->n_shmem_regions = 0;
 }
 
 /*
@@ -4005,11 +4076,21 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
 static void virtio_device_instance_finalize(Object *obj)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    VirtSharedMemory *shmem = NULL;
+    int i;
 
     virtio_device_free_virtqueues(vdev);
 
     g_free(vdev->config);
     g_free(vdev->vector_queues);
+    for (i = 0; i< vdev->n_shmem_regions; i++) {
+        shmem = &vdev->shmem_list[i];
+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
+            MappedMemoryRegion *mmap_reg = QTAILQ_FIRST(&shmem->mmaps);
+            QTAILQ_REMOVE(&shmem->mmaps, mmap_reg, link);
+            g_free(mmap_reg);
+        }
+    }
 }
 
 static const Property virtio_properties[] = {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6386910280..a778547c79 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -98,6 +98,21 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+struct MappedMemoryRegion {
+    MemoryRegion *mem;
+    hwaddr offset;
+    QTAILQ_ENTRY(MappedMemoryRegion) link;
+};
+
+typedef struct MappedMemoryRegion MappedMemoryRegion;
+
+struct VirtSharedMemory {
+    MemoryRegion *mr;
+    QTAILQ_HEAD(, MappedMemoryRegion) mmaps;
+};
+
+typedef struct VirtSharedMemory VirtSharedMemory;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -167,6 +182,9 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    /* Shared memory region for vhost-user mappings. */
+    VirtSharedMemory *shmem_list;
+    int n_shmem_regions;
 };
 
 struct VirtioDeviceClass {
@@ -289,6 +307,15 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
+VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev);
+void virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_name,
+                          hwaddr shm_offset, hwaddr fd_offset, uint64_t size,
+                          int fd, Error **errp);
+MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                                          uint64_t size);
+void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size);
+
 extern const VMStateInfo virtio_vmstate_info;
 
 #define VMSTATE_VIRTIO_DEVICE \
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..034cbfdc3c 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
     return vu_send_message(dev, &msg);
 }
 
+bool
+vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
+             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd)
+{
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_BACKEND_SHMEM_MAP,
+        .size = sizeof(vmsg.payload.mmap),
+        .flags = VHOST_USER_VERSION,
+        .payload.mmap = {
+            .shmid = shmid,
+            .fd_offset = fd_offset,
+            .shm_offset = shm_offset,
+            .len = len,
+            .flags = flags,
+        },
+        .fd_num = 1,
+        .fds[0] = fd,
+    };
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
+        return false;
+    }
+
+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
+        return false;
+    }
+
+    /* Also unlocks the backend_mutex */
+    return vu_process_message_reply(dev, &vmsg);
+}
+
+bool
+vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_t len)
+{
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_BACKEND_SHMEM_UNMAP,
+        .size = sizeof(vmsg.payload.mmap),
+        .flags = VHOST_USER_VERSION,
+        .payload.mmap = {
+            .shmid = shmid,
+            .fd_offset = 0,
+            .shm_offset = shm_offset,
+            .len = len,
+        },
+    };
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
+        return false;
+    }
+
+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
+        return false;
+    }
+
+    /* Also unlocks the backend_mutex */
+    return vu_process_message_reply(dev, &vmsg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 2ffc58c11b..e9adb836f0 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
+    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE */
+    VHOST_USER_PROTOCOL_F_SHMEM = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -186,6 +190,24 @@ typedef struct VhostUserShared {
     unsigned char uuid[UUID_LEN];
 } VhostUserShared;
 
+/* For the flags field of VhostUserMMap */
+#define VHOST_USER_FLAG_MAP_R (1u << 0)
+#define VHOST_USER_FLAG_MAP_W (1u << 1)
+
+typedef struct {
+    /* VIRTIO Shared Memory Region ID */
+    uint8_t shmid;
+    uint8_t padding[7];
+    /* File offset */
+    uint64_t fd_offset;
+    /* Offset within the VIRTIO Shared Memory Region */
+    uint64_t shm_offset;
+    /* Size of the mapping */
+    uint64_t len;
+    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
+    uint64_t flags;
+} VhostUserMMap;
+
 #define VU_PACKED __attribute__((packed))
 
 typedef struct VhostUserMsg {
@@ -210,6 +232,7 @@ typedef struct VhostUserMsg {
         VhostUserVringArea area;
         VhostUserInflight inflight;
         VhostUserShared object;
+        VhostUserMMap mmap;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -593,6 +616,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
  */
 bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
 
+/**
+ * vu_shmem_map:
+ * @dev: a VuDev context
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd_offset: File offset
+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @flags: Flags for the mmap operation
+ * @fd: A file descriptor
+ *
+ * Advertises a new mapping to be made in a given VIRTIO Shared Memory Region.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
+                  uint64_t shm_offset, uint64_t len, uint64_t flags, int fd);
+
+/**
+ * vu_shmem_unmap:
+ * @dev: a VuDev context
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd_offset: File offset
+ * @len: Size of the mapping
+ *
+ * The front-end un-mmaps a given range in the VIRTIO Shared Memory Region
+ * with the requested `shmid`.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
+                    uint64_t len);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
-- 
2.48.1


