Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM6v-00019A-PU; Wed, 29 May 2024 12:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6q-00016D-NJ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:05 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6l-0006Kq-8F
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:04 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6j-006CPl-H9;
 Wed, 29 May 2024 17:24:57 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 15/26] vfio-user: get region info
Date: Wed, 29 May 2024 17:23:08 +0100
Message-Id: <20240529162319.1476680-16-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add per-region FD to support mmap() of remote device regions

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  |  2 ++
 hw/vfio/ccw.c                 |  2 ++
 hw/vfio/container.c           |  7 ++++
 hw/vfio/helpers.c             | 26 ++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 hw/vfio/platform.c            |  5 +++
 hw/vfio/trace-events          |  1 +
 hw/vfio/user-pci.c            |  2 ++
 hw/vfio/user-protocol.h       | 14 ++++++++
 hw/vfio/user.c                | 68 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  6 +++-
 11 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 23d700e67a..2736ad03d9 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -162,6 +162,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
         goto error;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index b4139c8aef..34cba01a68 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -587,6 +587,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(cdev->mdevid, vbasedev,
                             &address_space_memory, errp)) {
         goto out_attach_dev_err;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ff09e277f..7e1a1a010a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -895,10 +895,17 @@ void vfio_put_base_device(VFIODevice *vbasedev)
         int i;
 
         for (i = 0; i < vbasedev->num_regions; i++) {
+            if (vbasedev->regfds != NULL && vbasedev->regfds[i] != -1) {
+                close(vbasedev->regfds[i]);
+            }
             g_free(vbasedev->regions[i]);
         }
         g_free(vbasedev->regions);
         vbasedev->regions = NULL;
+        if (vbasedev->regfds != NULL) {
+            g_free(vbasedev->regfds);
+            vbasedev->regfds = NULL;
+        }
     }
 
     if (!vbasedev->group) {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 2cd8fbe70c..d0f1db30da 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -363,6 +363,12 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    if (vbasedev->regfds != NULL) {
+        region->fd = vbasedev->regfds[index];
+    } else {
+        region->fd = vbasedev->fd;
+    }
+
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
@@ -539,12 +545,16 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* create region cache */
     if (vbasedev->regions == NULL) {
         vbasedev->regions = g_new0(struct vfio_region_info *,
                                    vbasedev->num_regions);
+        if (vbasedev->use_regfds) {
+            vbasedev->regfds = g_new0(int, vbasedev->num_regions);
+        }
     }
     /* check cache */
     if (vbasedev->regions[index] != NULL) {
@@ -558,22 +568,33 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io->get_region_info(vbasedev, *info);
+    ret = vbasedev->io->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
+        if (vbasedev->regfds != NULL) {
+            vbasedev->regfds[index] = -1;
+        }
+
         return -errno;
     }
 
     if ((*info)->argsz > argsz) {
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
 
         goto retry;
     }
 
     /* fill cache */
     vbasedev->regions[index] = *info;
+    if (vbasedev->regfds != NULL) {
+        vbasedev->regfds[index] = fd;
+    }
 
     return 0;
 }
@@ -695,10 +716,11 @@ static int vfio_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_io_get_region_info(VFIODevice *vbasedev,
-                                   struct vfio_region_info *info)
+                                   struct vfio_region_info *info, int *fd)
 {
     int ret;
 
+    *fd = -1;
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2e334c0c38..50a22b6986 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3054,6 +3054,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(name, vbasedev,
                             pci_device_iommu_address_space(pdev), errp)) {
         goto error;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 86ecd97fde..7885ccbb97 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -575,6 +575,11 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
 
+    vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
+    vbasedev->dev = dev;
+    vbasedev->ops = &vfio_platform_ops;
+    vbasedev->use_regfds = false;
+
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0f2e338194..3bfb625ee3 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -184,3 +184,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index fe98048aad..3c2d145812 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -112,6 +112,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
+    vbasedev->io = &vfio_dev_io_sock;
+    vbasedev->use_regfds = true;
 
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_attach_device_by_iommu_type(TYPE_VFIO_IOMMU_USER,
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 5f9ef1768f..6f70a48905 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -125,4 +125,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 645b927f97..e9a89df82a 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -1122,3 +1122,71 @@ int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info)
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+/*
+ * Socket-based io_ops
+ */
+
+static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
+                                        struct vfio_region_info *info,
+                                        int *fd)
+{
+    int ret;
+    VFIOUserFDs fds = { 0, 1, fd};
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+VFIODeviceIO vfio_dev_io_sock = {
+    .get_region_info = vfio_user_io_get_region_info,
+};
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6bbe0218e9..85c3fec3b9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -57,6 +57,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    int fd; /* fd to mmap() region */
 } VFIORegion;
 
 typedef struct VFIOMigration {
@@ -126,6 +127,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    bool use_regfds;
     VFIODeviceOps *ops;
     VFIODeviceIO *io;
     unsigned int num_irqs;
@@ -140,6 +142,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOUserProxy *proxy;
     struct vfio_region_info **regions;
+    int *regfds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -184,7 +187,7 @@ struct VFIODeviceOps {
 struct VFIODeviceIO {
     int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
     int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
@@ -194,6 +197,7 @@ struct VFIODeviceIO {
 };
 
 extern VFIODeviceIO vfio_dev_io_ioctl;
+extern VFIODeviceIO vfio_dev_io_sock;
 
 #endif /* CONFIG_LINUX */
 
-- 
2.34.1


