Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E813C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IL-0000Xy-MI; Wed, 29 Jan 2025 09:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IG-0000Va-CH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9ID-0001Kg-MH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXofu029996;
 Wed, 29 Jan 2025 14:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=dxO7RmoHpuyW7MIQrWXdvs9viXY+6yordmUe816rFj8=; b=
 MyDsoodEdcVMtx1o+1YSZsQtywkEeMuL2nrgjq1XOvVkA+heCISXDKWJDEX8Fcud
 q5g/vDhLqyaJ34uy5gNtrDA3Xvxzu2mav8bqrmAAWQ5zvXRURtFE95c0301c+DtU
 fqwU8iYYAyYyVHkdKe3zFNAyAVd6B/x+F92g/uipIdy75sleBDYA5QkC24FT3e+V
 sEMgzIbCBHgnKscL+z3Y+aNUAGOSzeqNNH0vdUR8tKbzTnugiy4qyx9Vr2wUWe6O
 qd69nvmXS7pLckSui1SQwOPeHzmhk5njxl2gA35gOZKjoyrQfOLfVJ/4wOyg4oJB
 EpS3zrpMYljjCXAWUMquBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug602-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TEGPIL034279; Wed, 29 Jan 2025 14:43:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8Q003307;
 Wed, 29 Jan 2025 14:43:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-7; Wed, 29 Jan 2025 14:43:45 +0000
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
Subject: [PATCH V1 06/26] vfio/container: preserve DMA mappings
Date: Wed, 29 Jan 2025 06:43:02 -0800
Message-Id: <1738161802-172631-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: d8-N8NYa9Y5YbUuwJIA_q-jZQleOcuLw
X-Proofpoint-GUID: d8-N8NYa9Y5YbUuwJIA_q-jZQleOcuLw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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

Preserve DMA mappings during cpr-transfer.

In the container pre_save handler, suspend the use of virtual addresses
in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will
be remapped at a different VA after exec.  DMA to already-mapped pages
continues.

Because the vaddr is temporarily invalid, mediated devices cannot be
supported, so add a blocker for them.  This restriction will not apply
to iommufd containers when CPR is added for them in a future patch.

In new QEMU, do not register the memory listener at device creation time.
Register it later, in the container post_load handler, after all vmstate
that may affect regions and mapping boundaries has been loaded.  The
post_load registration will cause the listener to invoke its callback on
each flat section, and the calls will match the mappings remembered by the
kernel.  Modify vfio_dma_map (which is called by the listener) to pass the
new VA to the kernel using VFIO_DMA_MAP_FLAG_VADDR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c           | 44 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio/cpr-legacy.c          | 32 +++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  3 +++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 81d0ccc..2b5125e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/cpr.h"
+#include "migration/blocker.h"
 #include "pci.h"
 
 VFIOGroupList vfio_group_list =
@@ -132,6 +133,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    assert(!container->reused);
+
     if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -183,12 +186,24 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
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
+    if (container->reused) {
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
@@ -205,7 +220,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
         return 0;
     }
 
-    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
+fail:
+    error_report("vfio_dma_map %s (iova %lu, size %ld, va %p): %s",
+        (container->reused ? "VADDR" : ""), iova, size, vaddr,
+        strerror(errno));
+
     return -errno;
 }
 
@@ -689,8 +708,17 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
+        bcontainer->listener = vfio_memory_listener;
+        memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+    }
 
     if (bcontainer->error) {
         error_propagate_prepend(errp, bcontainer->error,
@@ -1002,6 +1030,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (vbasedev->mdev) {
+        error_setg(&vbasedev->cpr_mdev_blocker,
+                   "CPR does not support vfio mdev %s", vbasedev->name);
+        migrate_add_blocker_modes(&vbasedev->cpr_mdev_blocker, &error_fatal,
+                                  MIG_MODE_CPR_TRANSFER, -1);
+    }
+
     bcontainer = &group->container->bcontainer;
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
@@ -1018,6 +1053,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
+    migrate_del_blocker(&vbasedev->cpr_mdev_blocker);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index ce6f14e..f3a31d1 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -14,6 +14,21 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
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
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -29,12 +44,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOContainer *container = opaque;
+    Error *err = NULL;
+
+    if (!vfio_dma_unmap_vaddr_all(container, &err)) {
+        error_report_err(err);
+        return -1;
+    }
+    return 0;
+}
+
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOGroup *group;
     VFIODevice *vbasedev;
 
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
     container->reused = false;
 
     QLIST_FOREACH(group, &container->group_list, container_next) {
@@ -49,6 +79,8 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
+    .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a435a90..1e974e0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -143,6 +143,7 @@ typedef struct VFIODevice {
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
+    Error *cpr_mdev_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
     OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
@@ -310,6 +311,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
+void vfio_listener_register(VFIOContainerBase *bcontainer);
+
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
-- 
1.8.3.1


