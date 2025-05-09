Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F9AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa7-00043e-QY; Fri, 09 May 2025 09:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYv-0002Iq-1f
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYr-0007Do-Ex
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVUcCZRKOq/kbj+QXNOx7sH+oheFYfZEKGWAOTGUE08=;
 b=Yyo0NgV7exzHh6Jzf2dgKZQDn9SqE/3NTvFbCcgDSLrW3K8qm/DbQLYR9qacylEQ9u6Oa+
 6k6PFqcOaXOrmAacjO1xSTeYT8L5SCy8ZrDIsjfUNlyN4Y26msmLIUe+1vGGcqguentjo6
 4nqR/CkyAVpIKTHbVm6p9R/oy8bM19k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-ob9k7SdHPaWbzibHA3ExWA-1; Fri,
 09 May 2025 09:14:41 -0400
X-MC-Unique: ob9k7SdHPaWbzibHA3ExWA-1
X-Mimecast-MFC-AGG-ID: ob9k7SdHPaWbzibHA3ExWA_1746796480
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89F34180045B; Fri,  9 May 2025 13:14:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5012C18003FD; Fri,  9 May 2025 13:14:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/28] vfio: add device IO ops vector
Date: Fri,  9 May 2025 15:13:13 +0200
Message-ID: <20250509131317.164235-25-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: John Levon <john.levon@nutanix.com>

For vfio-user, device operations such as IRQ handling and region
read/writes are implemented in userspace over the control socket, not
ioctl() to the vfio kernel driver; add an ops vector to generalize this,
and implement vfio_device_io_ops_ioctl for interacting with the kernel
vfio driver.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-11-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 38 ++++++++++++++++++
 hw/vfio/container-base.c      |  6 +--
 hw/vfio/device.c              | 74 +++++++++++++++++++++++++++++------
 hw/vfio/listener.c            | 13 +++---
 hw/vfio/pci.c                 | 10 ++---
 5 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4a3220294309d718bb3230a5d3f4bab9e082f951..7e1e81e76bd2b484108282f7147ff7a0793360cf 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,7 @@ enum {
 };
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -66,6 +67,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -151,6 +153,42 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIOOps {
+    /**
+     * @device_feature
+     *
+     * Fill in feature info for the given device.
+     */
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+
+    /**
+     * @get_region_info
+     *
+     * Fill in @info with information on the region given by @info->index.
+     */
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+
+    /**
+     * @get_irq_info
+     *
+     * Fill in @irq with information on the IRQ given by @info->index.
+     */
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+
+    /**
+     * @set_irqs
+     *
+     * Configure IRQs as defined by @irqs.
+     */
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+};
+
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info);
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3ff473a45c2db779a54f3d8e77079d4a1601eb36..1c6ca94b6040813a63bb8fca07b25189a8d8cb76 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
-    }
-
-    return 0;
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 5d837092cba2c35ad17d93dd5c3627d83defc818..40a196bfb9a86656610863d4f064db383c7072e0 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
@@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
@@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -167,7 +167,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    if (!vbasedev->io_ops->set_irqs(vbasedev, irq_set)) {
         return true;
     }
 
@@ -188,22 +188,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                              struct vfio_irq_info *info)
 {
-    int ret;
-
     memset(info, 0, sizeof(*info));
 
     info->argsz = sizeof(*info);
     info->index = index;
 
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
-
-    return ret < 0 ? -errno : ret;
+    return vbasedev->io_ops->get_irq_info(vbasedev, info);
 }
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     *info = g_malloc0(argsz);
 
@@ -211,10 +208,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
-        return -errno;
+        return ret;
     }
 
     if ((*info)->argsz > argsz) {
@@ -320,11 +318,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
     vbasedev->fd = fd;
 }
 
+static VFIODeviceIOOps vfio_device_io_ops_ioctl;
+
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
+    vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
 
@@ -442,3 +443,54 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, global_next);
     vbasedev->bcontainer = NULL;
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_device_io_device_feature(VFIODevice *vbasedev,
+                                         struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
+                                          struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
+                                       struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
+                                   struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
+    .device_feature = vfio_device_io_device_feature,
+    .get_region_info = vfio_device_io_get_region_info,
+    .get_irq_info = vfio_device_io_get_irq_info,
+    .set_irqs = vfio_device_io_set_irqs,
+};
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e7ade7d62ec81c9228e096ba4818a8dd09f54bd3..2b93ca55b6d47e4ef3e89bea681d6e345f8d3abe 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -794,13 +794,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        int ret;
+
         if (!vbasedev->dirty_tracking) {
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+
+        if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                        vbasedev->name, -errno, strerror(errno));
+                        vbasedev->name, -ret, strerror(-ret));
         }
         vbasedev->dirty_tracking = false;
     }
@@ -901,10 +905,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index f65c9463ce0350e6a1962309da21e96d1aa6cfdd..da2ffc9bf36778fb61a7decf345391caee528b2a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
-    int ret = 0, argsz;
+    int argsz;
     int32_t *fd;
 
     argsz = sizeof(*irq_set) + sizeof(*fd);
@@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-
-    return ret < 0 ? -errno : ret;
+    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
-    return ret < 0 ? -errno : ret;
+    return ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-- 
2.49.0


