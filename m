Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAADC3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHvh-0005kY-7J; Tue, 09 Jul 2024 16:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHva-0005G3-Py
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvV-0005Wi-Oe
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:10 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KtXQP013362;
 Tue, 9 Jul 2024 20:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=OqKTAz13oJqfMf35akxCVBZIbB1aEw6pScdFvFuTZ2M=; b=
 G4WZmi+86d5BxLYZSmCZj3Oc0msExsb84W5sswNnn+pWddVR3voZxNvICPw4eIj5
 EjyGYJn3mgpHhN+iEJxvp2uoOMUBinN0KH3Yx3Ez8JjXkUJRy+bKVvpD4FNXn0Pp
 aAjQbsci8jSxjLIlwQnHbpDnyoIuZoVqhIGkDmhym2F4AsNp8mQXSRA7EwJQ2yZq
 9zypzX/fBazM2g0ijPtUX6yRYRwDSruLL+rWJgMslyx2KK+EX+KutrQcMM79ptCr
 0d/OHgFDXyzf6CZbQ13wVoSaiFxBdnvwvmYQnVADKwfBxhHy5+igpJPv3QgbqB64
 EhSt+1QdLODXc7rKmFm0zA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky60gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469JvmU6005036; Tue, 9 Jul 2024 20:59:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tve98s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 469KwwCx012128;
 Tue, 9 Jul 2024 20:59:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 407tve98qa-5; Tue, 09 Jul 2024 20:59:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 4/8] vfio-pci: cpr part 1 (fd and dma)
Date: Tue,  9 Jul 2024 13:58:53 -0700
Message-Id: <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090143
X-Proofpoint-ORIG-GUID: 2DiUyXCxG1kDcfADptxQuvez1mQXoUH8
X-Proofpoint-GUID: 2DiUyXCxG1kDcfADptxQuvez1mQXoUH8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable vfio-pci devices to be saved and restored across a cpr-exec of qemu.

At vfio creation time, save the value of vfio container, group, and device
descriptors in CPR state.

In the container pre_save handler, suspend the use of virtual addresses
in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will
be remapped at a different VA after exec.  DMA to already-mapped pages
continues.  Save the msi message area as part of vfio-pci vmstate, and
save the interrupt and notifier eventfd's in vmstate.

On qemu restart, vfio_realize() finds the saved descriptors, uses the
descriptors, and notes that the device is being reused.  Device and iommu
state is already configured, so operations in vfio_realize that would
modify the configuration are skipped for a reused device, including vfio
ioctl's and writes to PCI configuration space.  Vfio PCI device reset
is also suppressed. The result is that vfio_realize constructs qemu
data structures that reflect the current state of the device.  However,
the reconstruction is not complete until migrate_incoming is called.
migrate_incoming loads the msi data, the vfio post_load handler finds
eventfds in CPR state, rebuilds vector data structures, and attaches the
interrupts to the new KVM instance.  The container post_load handler then
invokes the main vfio listener callback, which walks the flattened ranges
of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the
kernel of the new VA's.  Lastly, migration resumes the VM.

This functionality is delivered by 3 patches for clarity.  Part 1 handles
device file descriptors and DMA.  Part 2 adds eventfd and MSI/MSI-X vector
support.  Part 3 adds INTX support.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/pci/pci.c                          |  13 ++++
 hw/vfio/common.c                      |  12 +++
 hw/vfio/container.c                   | 139 ++++++++++++++++++++++++++++------
 hw/vfio/cpr-legacy.c                  | 118 +++++++++++++++++++++++++++++
 hw/vfio/cpr.c                         |  24 +++++-
 hw/vfio/meson.build                   |   3 +-
 hw/vfio/pci.c                         |  38 ++++++++++
 include/hw/vfio/vfio-common.h         |   8 ++
 include/hw/vfio/vfio-container-base.h |   6 ++
 include/migration/vmstate.h           |   2 +
 10 files changed, 336 insertions(+), 27 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52..42513dd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -389,6 +390,18 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    /*
+     * A PCI device that is resuming for cpr is already configured, so do
+     * not reset it here when we are called from qemu_system_reset prior to
+     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
+     * safe to skip this reset for all PCI devices, because cpr load will set
+     * all fields that would have been set here.
+     */
+    MigMode mode = migrate_mode();
+    if (mode == MIG_MODE_CPR_EXEC) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969..72a692a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -566,6 +566,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    vfio_container_region_add(bcontainer, section);
+}
+
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section)
+{
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -1395,6 +1401,12 @@ const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
+void vfio_listener_register(VFIOContainerBase *bcontainer)
+{
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+}
+
 void vfio_reset_handler(void *opaque)
 {
     VFIODevice *vbasedev;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 88ede91..9970463 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -31,6 +31,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/cpr.h"
 #include "pci.h"
 
 VFIOGroupList vfio_group_list =
@@ -131,6 +132,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    assert(!bcontainer->reused);
+
     if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -182,12 +185,24 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                                   bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
-        .flags = VFIO_DMA_MAP_FLAG_READ,
         .vaddr = (__u64)(uintptr_t)vaddr,
         .iova = iova,
         .size = size,
     };
 
+    /*
+     * Set the new vaddr for any mappings registered during cpr load.
+     * Reused is cleared thereafter.
+     */
+    if (bcontainer->reused) {
+        map.flags = VFIO_DMA_MAP_FLAG_VADDR;
+        if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
+            goto fail;
+        }
+        return 0;
+    }
+
+    map.flags = VFIO_DMA_MAP_FLAG_READ;
     if (!readonly) {
         map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
     }
@@ -204,7 +219,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
         return 0;
     }
 
-    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
+fail:
+    error_report("vfio_dma_map %s (iova %lu, size %ld, va %p): %s",
+        (bcontainer->reused ? "VADDR" : ""), iova, size, vaddr,
+        strerror(errno));
+
     return -errno;
 }
 
@@ -415,12 +434,28 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
 }
 
 static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
-                                            Error **errp)
+                                            bool reused, Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
     VFIOContainer *container;
 
+    /*
+     * If container is reused, just set its type and skip the ioctls, as the
+     * container and group are already configured in the kernel.
+     * VFIO_TYPE1v2_IOMMU is the only type that supports reuse/cpr.
+     */
+    if (reused) {
+        if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
+            iommu_type = VFIO_TYPE1v2_IOMMU;
+            goto skip_iommu;
+        } else {
+            error_setg(errp, "container was reused but VFIO_TYPE1v2_IOMMU "
+                             "is not supported");
+            return NULL;
+        }
+    }
+
     iommu_type = vfio_get_iommu_type(fd, errp);
     if (iommu_type < 0) {
         return NULL;
@@ -430,10 +465,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
         return NULL;
     }
 
+skip_iommu:
     vioc_name = vfio_get_iommu_class_name(iommu_type);
 
     container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
+    container->bcontainer.reused = reused;
     container->iommu_type = iommu_type;
     return container;
 }
@@ -543,10 +580,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
     int ret, fd;
+    bool reused;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
 
     space = vfio_get_address_space(as);
+    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
+    reused = (fd > 0);
 
     /*
      * VFIO is currently incompatible with discarding of RAM insofar as the
@@ -579,28 +619,50 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
+    /*
+     * If the container is reused, then the group is already attached in the
+     * kernel.  If a container with matching fd is found, then update the
+     * userland group list and return.  If not, then after the loop, create
+     * the container struct and group list.
+     */
+
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            ret = vfio_ram_block_discard_disable(container, true);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Cannot set discarding of RAM broken");
-                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
-                          &container->fd)) {
-                    error_report("vfio: error disconnecting group %d from"
-                                 " container", group->groupid);
-                }
-                return false;
+
+        if (reused) {
+            if (container->fd != fd) {
+                continue;
             }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+            continue;
+        }
+
+        ret = vfio_ram_block_discard_disable(container, true);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Cannot set discarding of RAM broken");
+            if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
+                      &container->fd)) {
+                error_report("vfio: error disconnecting group %d from"
+                             " container", group->groupid);
+
+            }
+            goto delete_fd_exit;
+        }
+        group->container = container;
+        QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+        if (!reused) {
             vfio_kvm_device_add_group(group);
-            return true;
+            cpr_save_fd("vfio_container_for_group", group->groupid,
+                        container->fd);
         }
+        return true;
+    }
+
+    if (!reused) {
+        fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     }
 
-    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
         goto put_space_exit;
@@ -613,11 +675,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto close_fd_exit;
     }
 
-    container = vfio_create_container(fd, group, errp);
+    container = vfio_create_container(fd, group, reused, errp);
     if (!container) {
         goto close_fd_exit;
     }
     bcontainer = &container->bcontainer;
+    bcontainer->reused = reused;
 
     if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
@@ -643,8 +706,16 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+    /*
+     * If reused, register the listener later, after all state that may
+     * affect regions and mapping boundaries has been cpr load'ed.  Later,
+     * the listener will invoke its callback on each flat section and call
+     * vfio_dma_map to supply the new vaddr, and the calls will match the
+     * mappings remembered by the kernel.
+     */
+    if (!reused) {
+        vfio_listener_register(bcontainer);
+    }
 
     if (bcontainer->error) {
         error_propagate_prepend(errp, bcontainer->error,
@@ -653,6 +724,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     bcontainer->initialized = true;
+    cpr_resave_fd("vfio_container_for_group", group->groupid, fd);
 
     return true;
 listener_release_exit:
@@ -679,6 +751,8 @@ close_fd_exit:
 put_space_exit:
     vfio_put_address_space(space);
 
+delete_fd_exit:
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
     return false;
 }
 
@@ -690,6 +764,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 
     /*
      * Explicitly release the listener first before unset container,
@@ -743,7 +818,12 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open_old(path, O_RDWR);
+
+    group->fd = cpr_find_fd("vfio_group", groupid);
+    if (group->fd < 0) {
+        group->fd = qemu_open_old(path, O_RDWR);
+    }
+
     if (group->fd < 0) {
         error_setg_errno(errp, errno, "failed to open %s", path);
         goto free_group_exit;
@@ -772,6 +852,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     }
 
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
+    cpr_resave_fd("vfio_group", groupid, group->fd);
 
     return group;
 
@@ -797,6 +878,7 @@ static void vfio_put_group(VFIOGroup *group)
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);
     trace_vfio_put_group(group->fd);
+    cpr_delete_fd("vfio_group", group->groupid);
     close(group->fd);
     g_free(group);
 }
@@ -806,8 +888,14 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
+    bool reused;
+
+    fd = cpr_find_fd(name, 0);
+    reused = (fd >= 0);
+    if (!reused) {
+        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    }
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -852,6 +940,8 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
+    vbasedev->reused = reused;
+    cpr_resave_fd(name, 0, fd);
 
     trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
@@ -868,6 +958,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
+    cpr_delete_fd(vbasedev->name, 0);
     close(vbasedev->fd);
 }
 
@@ -1136,6 +1227,8 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
     vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
+    vioc->cpr_register = vfio_legacy_cpr_register_container;
+    vioc->cpr_unregister = vfio_legacy_cpr_unregister_container;
 };
 
 static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000..bc51ebe
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "hw/vfio/vfio-common.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+
+#define VFIO_CONTAINER(base)    container_of(base, VFIOContainer, bcontainer)
+
+static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
+        .iova = 0,
+        .size = 0,
+    };
+    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
+        return false;
+    }
+    return true;
+}
+
+static bool vfio_can_cpr_exec(VFIOContainer *container, Error **errp)
+{
+    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
+        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
+        return false;
+
+    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
+        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
+        return false;
+
+    } else {
+        return true;
+    }
+}
+
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOContainer *container = opaque;
+    Error *err = NULL;
+
+    if (!vfio_can_cpr_exec(container, &err) ||
+        !vfio_dma_unmap_vaddr_all(container, &err)) {
+        error_report_err(err);
+        return -1;
+    }
+    return 0;
+}
+
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOGroup *group;
+    Error *err = NULL;
+    VFIODevice *vbasedev;
+
+    if (!vfio_can_cpr_exec(container, &err)) {
+        error_report_err(err);
+        return -1;
+    }
+    vfio_listener_register(bcontainer);
+    bcontainer->reused = false;
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            vbasedev->reused = false;
+        }
+    }
+    return 0;
+}
+
+static const VMStateDescription vfio_container_vmstate = {
+    .name = "vfio-container",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .pre_save = vfio_container_pre_save,
+    .post_load = vfio_container_post_load,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
+                                        Error **errp)
+{
+    VFIOContainer *container = VFIO_CONTAINER(bcontainer);
+
+    if (!vfio_can_cpr_exec(container, &bcontainer->cpr_blocker)) {
+        return migrate_add_blocker_modes(&bcontainer->cpr_blocker, errp,
+                                         MIG_MODE_CPR_EXEC, -1);
+    }
+
+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
+
+    return true;
+}
+
+void vfio_legacy_cpr_unregister_container(VFIOContainerBase *bcontainer)
+{
+    VFIOContainer *container = VFIO_CONTAINER(bcontainer);
+
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+}
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 87e51fc..4474bc3 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -6,10 +6,12 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
 #include "hw/vfio/vfio-common.h"
-#include "migration/misc.h"
+#include "migration/blocker.h"
+#include "migration/migration.h"
 #include "qapi/error.h"
-#include "sysemu/runstate.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
@@ -27,13 +29,29 @@ static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
 
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
 {
+    VFIOIOMMUClass *ops = VFIO_IOMMU_GET_CLASS(bcontainer);
+
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
                                 MIG_MODE_CPR_REBOOT);
-    return true;
+
+    if (!ops->cpr_register) {
+        error_setg(&bcontainer->cpr_blocker,
+                   "VFIO container does not support cpr_register");
+        return migrate_add_blocker_modes(&bcontainer->cpr_blocker, errp,
+                                         MIG_MODE_CPR_EXEC, -1) == 0;
+    }
+
+    return ops->cpr_register(bcontainer, errp);
 }
 
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
 {
+    VFIOIOMMUClass *ops = VFIO_IOMMU_GET_CLASS(bcontainer);
+
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+    migrate_del_blocker(&bcontainer->cpr_blocker);
+    if (ops->cpr_unregister) {
+        ops->cpr_unregister(bcontainer);
+    }
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bba776f..5487815 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,13 +5,14 @@ vfio_ss.add(files(
   'container-base.c',
   'container.c',
   'migration.c',
-  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
   'iommufd.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'cpr.c',
+  'cpr-legacy.c',
   'display.c',
   'pci-quirks.c',
   'pci.c',
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ca3c22a..2485236 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -29,6 +29,8 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/misc.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
@@ -3326,6 +3328,11 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(dev);
 
+    /* Do not reset the device during qemu_system_reset prior to cpr load */
+    if (vdev->vbasedev.reused) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3447,6 +3454,36 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
+/*
+ * The kernel may change non-emulated config bits.  Exclude them from the
+ * changed-bits check in get_pci_config_device.
+ */
+static int vfio_pci_pre_load(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int size = MIN(pci_config_size(pdev), vdev->config_size);
+    int i;
+
+    for (i = 0; i < size; i++) {
+        pdev->cmask[i] &= vdev->emulated_config_bits[i];
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vfio_pci_vmstate = {
+    .name = "vfio-pci",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .priority = MIG_PRI_VFIO_PCI,       /* must load before container */
+    .pre_load = vfio_pci_pre_load,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3457,6 +3494,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
+    dc->vmsd = &vfio_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e8ddf92..7c4283b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -122,6 +122,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    bool reused;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -240,6 +241,9 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
+bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
+                                        Error **errp);
+void vfio_legacy_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
@@ -287,6 +291,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section);
+void vfio_listener_register(VFIOContainerBase *bcontainer);
+
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 419e45e..82ccf0c 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -39,6 +39,7 @@ typedef struct VFIOContainerBase {
     MemoryListener listener;
     Error *error;
     bool initialized;
+    bool reused;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
@@ -50,6 +51,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    Error *cpr_blocker;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
@@ -152,5 +154,9 @@ struct VFIOIOMMUClass {
     void (*del_window)(VFIOContainerBase *bcontainer,
                        MemoryRegionSection *section);
     void (*release)(VFIOContainerBase *bcontainer);
+
+    /* CPR */
+    bool (*cpr_register)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*cpr_unregister)(VFIOContainerBase *bcontainer);
 };
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f313f2f..87cb5b0 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -162,6 +162,8 @@ typedef enum {
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
+    MIG_PRI_VFIO_PCI =
+        MIG_PRI_DEFAULT + 1,   /* Must happen before vfio containers */
 } MigrationPriority;
 
 struct VMStateField {
-- 
1.8.3.1


