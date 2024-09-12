Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881C1EED60D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solD1-00015V-VV; Thu, 12 Sep 2024 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solD0-00014t-Ce
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solCx-0000Ha-2y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xG4rr6587vwjGLOmp2PGDY77mR8V0+e64UiAhyqmV34=;
 b=CGs/kq5/2xmAVBE+qdRqWLVG8tdjRlC255Rzmoqh70w+t1+vGj111Ozbr7HJtKtwgK22mr
 WsCUdIcTs88QSSXql4vjBuG8LEyqsSGOd9beVaCi30AGsU0UVkypnhTnM6HlrYIgTkqIPV
 zttyj/p6zt7klVWEWRpZ9jOeTd7nK68=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-UJsyyt2hOBqVSeMHn1NgHg-1; Thu,
 12 Sep 2024 10:54:02 -0400
X-MC-Unique: UJsyyt2hOBqVSeMHn1NgHg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D601955D59; Thu, 12 Sep 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B63461956052; Thu, 12 Sep 2024 14:53:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 2/5] virtio: Track shared memory mappings
Date: Thu, 12 Sep 2024 16:53:32 +0200
Message-ID: <20240912145335.129447-3-aesteve@redhat.com>
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

Update shmem_list to be able to track
active mappings on VIRTIO shared memory
regions. This allows to verify that new
mapping request received from backends
do not overlap. If they do, the request
shall fail in order to adhere to the specs.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c     | 31 +++++++++++++-------
 hw/virtio/virtio.c         | 58 ++++++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio.h | 25 ++++++++++++++--
 3 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 338cc942ec..de0bb35257 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1776,7 +1776,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
                                     int fd)
 {
     void *addr = 0;
-    MemoryRegion *mr = NULL;
+    VirtSharedMemory *shmem = NULL;
 
     if (fd < 0) {
         error_report("Bad fd for map");
@@ -1791,22 +1791,29 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         return -EFAULT;
     }
 
-    mr = &dev->vdev->shmem_list[vu_mmap->shmid];
+    shmem = &dev->vdev->shmem_list[vu_mmap->shmid];
 
-    if (!mr) {
+    if (!shmem) {
         error_report("VIRTIO Shared Memory Region at "
                      "ID %d unitialized", vu_mmap->shmid);
         return -EFAULT;
     }
 
     if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
-        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
         error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
                      vu_mmap->shm_offset, vu_mmap->len);
         return -EFAULT;
     }
 
-    void *shmem_ptr = memory_region_get_ram_ptr(mr);
+    if (virtio_shmem_map_overlaps(shmem, vu_mmap->shm_offset, vu_mmap->len)) {
+        error_report("Requested memory (%" PRIx64 "+%" PRIx64 ") overalps "
+                     "with previously mapped memory",
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    void *shmem_ptr = memory_region_get_ram_ptr(shmem->mr);
 
     addr = mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
         ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
@@ -1818,6 +1825,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         return -EFAULT;
     }
 
+    virtio_add_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+
     return 0;
 }
 
@@ -1826,7 +1835,7 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
                                       VhostUserMMap *vu_mmap)
 {
     void *addr = 0;
-    MemoryRegion *mr = NULL;
+    VirtSharedMemory *shmem = NULL;
 
     if (!dev->vdev->shmem_list ||
         dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
@@ -1836,22 +1845,22 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
         return -EFAULT;
     }
 
-    mr = &dev->vdev->shmem_list[vu_mmap->shmid];
+    shmem = &dev->vdev->shmem_list[vu_mmap->shmid];
 
-    if (!mr) {
+    if (!shmem) {
         error_report("VIRTIO Shared Memory Region at "
                      "ID %d unitialized", vu_mmap->shmid);
         return -EFAULT;
     }
 
     if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
-        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
         error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
                      vu_mmap->shm_offset, vu_mmap->len);
         return -EFAULT;
     }
 
-    void *shmem_ptr = memory_region_get_ram_ptr(mr);
+    void *shmem_ptr = memory_region_get_ram_ptr(shmem->mr);
 
     addr = mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
                 PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
@@ -1861,6 +1870,8 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
         return -EFAULT;
     }
 
+    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+
     return 0;
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ccc4f2cd75..0e2cd62a15 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3059,15 +3059,52 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
 }
 
-MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
+VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev)
 {
-    MemoryRegion *mr;
+    VirtSharedMemory *shmem = NULL;
     ++vdev->n_shmem_regions;
-    vdev->shmem_list = g_renew(MemoryRegion, vdev->shmem_list,
+    vdev->shmem_list = g_renew(VirtSharedMemory, vdev->shmem_list,
                                vdev->n_shmem_regions);
-    mr = &vdev->shmem_list[vdev->n_shmem_regions - 1];
-    mr = g_new0(MemoryRegion, 1);
-    return mr;
+    shmem = &vdev->shmem_list[vdev->n_shmem_regions - 1];
+    shmem = g_new0(VirtSharedMemory, 1);
+    QTAILQ_INIT(&shmem->mapped_regions);
+    return shmem;
+}
+
+void virtio_add_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size)
+{
+    MappedMemoryRegion *mmap = g_new0(MappedMemoryRegion, 1);
+    mmap->offset = offset;
+    mmap->size = int128_make64(size);
+    QTAILQ_REMOVE(&shmem->mapped_regions, mmap, link);
+    g_free(mmap);
+}
+
+void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size)
+{
+    MappedMemoryRegion *mmap = g_new0(MappedMemoryRegion, 1);
+    mmap->offset = offset;
+    mmap->size = int128_make64(size);
+    QTAILQ_INSERT_TAIL(&shmem->mapped_regions, mmap, link);
+    g_free(mmap);
+}
+
+bool virtio_shmem_map_overlaps(VirtSharedMemory *shmem, hwaddr offset,
+                               uint64_t size)
+{
+    MappedMemoryRegion *map_reg;
+    hwaddr new_reg_end = offset + size;
+    QTAILQ_FOREACH(map_reg, &shmem->mapped_regions, link) {
+        hwaddr region_end = map_reg->offset + map_reg->size;
+        if ((map_reg->offset == offset) ||
+            (map_reg->offset < offset && region_end >= offset) ||
+            (offset < map_reg->offset && new_reg_end >= map_reg->offset )) {
+            return true;
+        }
+    }
+    return false;   
 }
 
 /* A wrapper for use as a VMState .put function */
@@ -4007,11 +4044,20 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
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
+        while (!QTAILQ_EMPTY(&shmem->mapped_regions)) {
+            MappedMemoryRegion *mmap_reg = QTAILQ_FIRST(&shmem->mapped_regions);
+            QTAILQ_REMOVE(&shmem->mapped_regions, mmap_reg, link);
+        }
+    }
 }
 
 static Property virtio_properties[] = {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d4a2f664d9..5b801f33f5 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -98,6 +98,21 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+struct MappedMemoryRegion {
+    Int128 size;
+    hwaddr offset;
+    QTAILQ_ENTRY(MappedMemoryRegion) link;
+};
+
+typedef struct MappedMemoryRegion MappedMemoryRegion;
+
+struct VirtSharedMemory {
+    MemoryRegion *mr;
+    QTAILQ_HEAD(, MappedMemoryRegion) mapped_regions;
+};
+
+typedef struct VirtSharedMemory VirtSharedMemory;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -168,7 +183,7 @@ struct VirtIODevice
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
     /* Shared memory region for vhost-user mappings. */
-    MemoryRegion *shmem_list;
+    VirtSharedMemory *shmem_list;
     int n_shmem_regions;
 };
 
@@ -289,7 +304,13 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
-MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
+VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev);
+void virtio_add_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size);
+void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
+                          uint64_t size);
+bool virtio_shmem_map_overlaps(VirtSharedMemory *shmem, hwaddr offset,
+                               uint64_t size);
 
 extern const VMStateInfo virtio_vmstate_info;
 
-- 
2.45.2


