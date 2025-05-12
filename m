Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9f-0004So-7K; Mon, 12 May 2025 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9c-0004MV-4d
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9Z-0006fh-M7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9euI017589;
 Mon, 12 May 2025 15:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=iToOAigcxvxjllq5I+WnYLCGEBOW/Wb4etTi2lEUF6U=; b=
 ZuKcXuyLCjX+qAPy+wgMiKiNMOPNZKFCWu4NwEB8n4PO64UgEspD456OoLfl+3L5
 yQhL2iUBomPENO72kwDoFThWIBhrB2zuZ91UnJo+Yz8Ba0nwczVTEan/IKFcEe+w
 xiU7E9QKhMQpAc00f8fa/4vPROB7uX8lEUQwcFM0d0nC0s+pg+9WS5ljq9wYQpSs
 tzHmxLtuN43FC0CP6q5Ek/BwAiN5Urx4MKsP9fZ5BEXGRM6pCSJ3JuaE5hIbQ4OV
 9fZCQqOcIT5GU3n0bTdr4N7SVugbxk6Qu5NQ9DADLygabxf1TMK2ITx2/P/d8gq7
 48h8SD65gzyoXOcKi+DKHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tvfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE214f002394; Mon, 12 May 2025 15:33:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk52030605;
 Mon, 12 May 2025 15:33:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-13; Mon, 12 May 2025 15:33:03 +0000
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
Subject: [PATCH V3 12/42] vfio/container: recover from unmap-all-vaddr failure
Date: Mon, 12 May 2025 08:32:23 -0700
Message-Id: <1747063973-124548-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX7sWiwtpXBWf7
 mEuYudrSgUw8Mn002fWWsIcyCBOTP4evEf/+4ded3HY6Rf0ioWd2AazjYFFvjZebf0c9DId3CLz
 +SPubbI5B1QAnyUJplB64SyxtH8FTAn9IK72nADVKx0CrbU+bHt/AEOoj2BXnzN+eRiCK6IrZHd
 WPu9G5IUIhq/RHGJKLNIgawCqK1ygOn2tNde3HAnE9FmeMamhwTK/OztgEvPqC9NMo7poK6FwwJ
 J5LO1noj5w3PVU/bNT+aArnHbfllOfnrysS1ODEBYMOmwsFdEe2+cG4H78dkF2pGWo2YHZwyzc4
 bYux4P55L9rCX+Jd3tAsFGEfCSLD0QFN1O6HuqizgtFVZBiRvZ4bASwwdbdBl01iic8mZ6OYFj2
 EblJHFqtnycuG9ssY5WmHmnalfI/7Byrg2V7OS1S5kRfV71GSAJS8c87xiA/a0ixZp4lGwUw
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214b0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=bXQ6ZcJOO1ukfLjjEFYA:9
X-Proofpoint-ORIG-GUID: cqnShf6L-QrdPcUZ-MCEja_SFXt75AZb
X-Proofpoint-GUID: cqnShf6L-QrdPcUZ-MCEja_SFXt75AZb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If there are multiple containers and unmap-all fails for some container, we
need to remap vaddr for the other containers for which unmap-all succeeded.
Recover by walking all address ranges of all containers to restore the vaddr
for each.  Do so by invoking the vfio listener callback, and passing a new
"remap" flag that tells it to restore a mapping without re-allocating new
userland data structures.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
 hw/vfio/listener.c                    | 19 +++++++-
 include/hw/vfio/vfio-container-base.h |  3 ++
 include/hw/vfio/vfio-cpr.h            | 10 ++++
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bbcf71e..f8ddf78 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -31,6 +31,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->cpr.vaddr_unmapped = true;
     return true;
 }
 
@@ -63,6 +64,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
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
@@ -131,6 +140,40 @@ static const VMStateDescription vfio_container_vmstate = {
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
@@ -152,6 +195,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
         VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
+
+    migration_add_notifier_mode(&container->cpr.transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -162,6 +209,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
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
+bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
+
+    g_assert(vrdl);
+    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
 }
 
 static bool same_device(int fd1, int fd2)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 5642d04..e86ffcf 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -474,6 +474,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -509,6 +516,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -551,7 +563,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_ram_discard_register_listener(bcontainer, section);
+        if (!cpr_remap) {
+            vfio_ram_discard_register_listener(bcontainer, section);
+        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
+                                                           section)) {
+            goto fail;
+        }
         return;
     }
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index a2f6c3a..5776fd7 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -189,4 +189,7 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
 int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                         ram_addr_t size, void *vaddr, bool readonly);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool cpr_remap);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 0fc7ab2..d6d22f2 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -10,10 +10,14 @@
 #define HW_VFIO_VFIO_CPR_H
 
 #include "migration/misc.h"
+#include "system/memory.h"
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
     bool reused;
+    bool vaddr_unmapped;
+    NotifierWithReturn transfer_notifier;
+    MemoryListener remap_listener;
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
@@ -39,4 +43,10 @@ void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int *fd);
 
+void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section);
+
+bool vfio_cpr_ram_discard_register_listener(
+    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
-- 
1.8.3.1


