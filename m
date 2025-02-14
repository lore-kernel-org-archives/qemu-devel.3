Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E62C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwT2-0004hY-6J; Fri, 14 Feb 2025 09:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSz-0004XB-PW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSx-0004TF-K1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtT8P028517;
 Fri, 14 Feb 2025 14:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=RkREt5x2dAQoSdbgHirMskiKHaxedX30dO32juP6jHs=; b=
 QmDtgAHOy6u9PKcZVH+Tfsp3IC99Nue00iK8fHqBWt/MSjmKd7SWiGyEZ0+s0CpJ
 UsS5BmjgvmqUxmOgvFzHL9aGu9HHTrZUFLKbTw6tBzwhLAs/OHf4RvO9pPQAwUxl
 9BHYPc8IMDkwa+hEA+LikISj6ASrmk97qhBKyNeWF7yhfLw67kyp02cTOBuhIw8G
 vjZkzO856fWpbzY1v4sZY8hidqDoSRVFJyS6lgdD2K/K/ziPZLfho/xucZ+T/bFD
 gRrmpQHx6vnFKDbeLGhRqyBT3OKYQ4rPAVc9XONXyh5hCBZySHIXRXEpOHxq8rQ8
 6DkUBzM4XAjvo54e8swi2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnbnn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECuXh7025256; Fri, 14 Feb 2025 14:14:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPf006920;
 Fri, 14 Feb 2025 14:14:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-15; Fri, 14 Feb 2025 14:14:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 14/45] vfio/container: recover from unmap-all-vaddr failure
Date: Fri, 14 Feb 2025 06:13:56 -0800
Message-Id: <1739542467-226739-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: GTBkuUE2zJ9ZF2UfgadzmZqfTsjWMjJp
X-Proofpoint-ORIG-GUID: GTBkuUE2zJ9ZF2UfgadzmZqfTsjWMjJp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If there are multiple containers and unmap-all fails for some container, we
need to remap vaddr for the other containers for which unmap-all succeeded.
Recover by walking all address ranges of all containers to restore the vaddr
for each.  Do so by invoking the vfio listener callback, and passing a new
"remap" flag that tells it to restore a mapping without re-allocating new
userland data structures.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c              | 19 ++++++++-
 hw/vfio/cpr-legacy.c          | 91 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  3 ++
 include/hw/vfio/vfio-cpr.h    | 11 ++++++
 4 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e3e1da0..48663ad 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -592,6 +592,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    vfio_container_region_add(bcontainer, section, false);
+}
+
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section,
+                               bool cpr_remap)
+{
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -627,6 +634,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
+
+        if (cpr_remap) {
+            vfio_cpr_giommu_remap(bcontainer, section);
+        }
+
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
          * avoid bouncing all map/unmaps through qemu this way, this
@@ -669,7 +681,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(bcontainer, section);
+        if (!cpr_remap) {
+            vfio_register_ram_discard_listener(bcontainer, section);
+        } else if (!vfio_cpr_register_ram_discard_listener(bcontainer,
+                                                           section)) {
+            goto fail;
+        }
         return;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bb5f802..90f9f14 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -28,6 +28,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->cpr.vaddr_unmapped = true;
     return true;
 }
 
@@ -60,6 +61,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+static void vfio_region_remap(MemoryListener *listener,
+                              MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer,
+                                            cpr.remap_listener);
+    vfio_container_region_add(&container->bcontainer, section, true);
+}
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -124,6 +133,40 @@ static const VMStateDescription vfio_container_vmstate = {
     }
 };
 
+static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    VFIOContainer *container =
+        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
+        return 0;
+    }
+
+    if (container->cpr.vaddr_unmapped) {
+        /*
+         * Force a call to vfio_region_remap for each mapped section by
+         * temporarily registering a listener, and temporarily diverting
+         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
+         */
+
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+
+        container->cpr.remap_listener = (MemoryListener) {
+            .name = "vfio cpr recover",
+            .region_add = vfio_region_remap
+        };
+        memory_listener_register(&container->cpr.remap_listener,
+                                 bcontainer->space->as);
+        memory_listener_unregister(&container->cpr.remap_listener);
+        container->cpr.vaddr_unmapped = false;
+        vioc->dma_map = vfio_legacy_dma_map;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -145,6 +188,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
         VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
+
+    migration_add_notifier_mode(&container->cpr.transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -155,6 +202,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migration_remove_notifier(&container->cpr.transfer_notifier);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a giommu.
+ *
+ * The giommu already exists.  Find it and replay it, which calls
+ * vfio_legacy_cpr_dma_map further down the stack.
+ */
+void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section)
+{
+    VFIOGuestIOMMU *giommu = NULL;
+    hwaddr as_offset = section->offset_within_address_space;
+    hwaddr iommu_offset = as_offset - section->offset_within_region;
+
+    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
+        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
+            giommu->iommu_offset == iommu_offset) {
+            break;
+        }
+    }
+    g_assert(giommu);
+    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a RamDiscardManager.
+ *
+ * The ram discard listener already exists.  Call its populate function
+ * directly, which calls vfio_legacy_cpr_dma_map.
+ */
+bool vfio_cpr_register_ram_discard_listener(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
+
+    g_assert(vrdl);
+    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
 }
 
 static bool same_device(int fd1, int fd2)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7f33476..1563f3a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -315,6 +315,9 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool cpr_remap);
+
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 25ac944..40d4f06 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -8,11 +8,15 @@
 #ifndef HW_VFIO_VFIO_CPR_H
 #define HW_VFIO_VFIO_CPR_H
 
+#include "exec/memory.h"
 #include "migration/misc.h"
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
     bool reused;
+    bool vaddr_unmapped;
+    NotifierWithReturn transfer_notifier;
+    MemoryListener remap_listener;
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
@@ -22,6 +26,7 @@ typedef struct VFIODeviceCPR {
 
 struct VFIOContainer;
 struct VFIOGroup;
+struct VFIOContainerBase;
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -32,4 +37,10 @@ void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
 
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int *fd);
+
+void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section);
+
+bool vfio_cpr_register_ram_discard_listener(
+    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 #endif
-- 
1.8.3.1


