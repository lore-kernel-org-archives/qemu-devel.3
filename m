Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C5C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHvd-0005QO-EJ; Tue, 09 Jul 2024 16:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHva-0005EN-Cb
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvW-0005XB-C6
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KtuIM005681;
 Tue, 9 Jul 2024 20:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=KgLDCh70MzL+z9CrRxPKd9/rhKIzpnFQenotDp8DH3Q=; b=
 Mzf5ofTDKwYkw0GleVk8T2SjNcSa/hrgEoCPLr1Utz1Tq2DSBM0C2zlwJTs4jp5M
 QZhYGaSLVjn26mzMN++JkYKmoNiRiHG+Oy840/TaA/c7/9qhvYXp1IvFv5LJrO03
 5T8MHYxpI+4ocWlhEYx0VdT1YG+3U0fzb7aCwSJOalAo/B2FCw/xNlCaUy5+T77M
 ieHHSaQ2vbfbNsJKWWPT1Z+CBUJrHPdZjSVT+fLyC8z1cZiREV/uH+oEHkK46ZbZ
 ScQtiVLJyITmKBKWeeCqQfiC38FfvPUQR4ah+V+Xs0Dx4WssT444Uh2aVMTU6MYO
 0t8SFSrQ4ch+G1clf41t+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknnym1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469KCjpT005055; Tue, 9 Jul 2024 20:59:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tve98t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 469KwwD7012128;
 Tue, 9 Jul 2024 20:59:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 407tve98qa-9; Tue, 09 Jul 2024 20:59:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 8/8] vfio-pci: recover from unmap-all-vaddr failure
Date: Tue,  9 Jul 2024 13:58:57 -0700
Message-Id: <1720558737-451106-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: vf1AnGtyxJQrR9paxth5Cj0mJWVMAaBW
X-Proofpoint-ORIG-GUID: vf1AnGtyxJQrR9paxth5Cj0mJWVMAaBW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/vfio/common.c                      | 45 ++++++++++++++++++++++++++++++++---
 hw/vfio/cpr-legacy.c                  | 44 ++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h         |  4 +++-
 include/hw/vfio/vfio-container-base.h |  1 +
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5c7baad..da2e0ec 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -586,11 +586,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    vfio_container_region_add(bcontainer, section);
+    vfio_container_region_add(bcontainer, section, false);
 }
 
 void vfio_container_region_add(VFIOContainerBase *bcontainer,
-                               MemoryRegionSection *section)
+                               MemoryRegionSection *section,
+                               bool remap)
 {
     hwaddr iova, end;
     Int128 llend, llsize;
@@ -626,6 +627,30 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
         int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(iova, end);
+
+        /*
+         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
+         * want to remap the vaddr.  vfio_container_region_add was already
+         * called in the past, so the giommu already exists.  Find it and
+         * replay it, which calls vfio_dma_map further down the stack.
+         */
+
+        if (remap) {
+            hwaddr as_offset = section->offset_within_address_space;
+            hwaddr iommu_offset = as_offset - section->offset_within_region;
+
+            QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
+                if (giommu->iommu_mr == iommu_mr &&
+                    giommu->iommu_offset == iommu_offset) {
+                    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
+                    return;
+                }
+            }
+            error_report("Container cannot find iommu region %s offset %lx",
+                memory_region_name(section->mr), iommu_offset);
+            goto fail;
+        }
+
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
          * avoid bouncing all map/unmaps through qemu this way, this
@@ -676,7 +701,21 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(bcontainer, section);
+        /*
+         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
+         * want to remap the vaddr.  vfio_container_region_add was already
+         * called in the past, so the ram discard listener already exists.
+         * Call its populate function directly, which calls vfio_dma_map.
+         */
+        if (remap)  {
+            VFIORamDiscardListener *vrdl =
+                vfio_find_ram_discard_listener(bcontainer, section);
+            if (vrdl->listener.notify_populate(&vrdl->listener, section)) {
+                error_report("listener.notify_populate failed");
+            }
+        } else {
+            vfio_register_ram_discard_listener(bcontainer, section);
+        }
         return;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bc51ebe..c4b95a8 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -29,9 +29,18 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->vaddr_unmapped = true;
     return true;
 }
 
+static void vfio_region_remap(MemoryListener *listener,
+                              MemoryRegionSection *section)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 remap_listener);
+    vfio_container_region_add(bcontainer, section, true);
+}
+
 static bool vfio_can_cpr_exec(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -95,6 +104,37 @@ static const VMStateDescription vfio_container_vmstate = {
     }
 };
 
+static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    VFIOContainer *container =
+        container_of(notifier, VFIOContainer, cpr_exec_notifier);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
+        return 0;
+    }
+
+    if (container->vaddr_unmapped) {
+        /*
+         * Force a call to vfio_region_remap for each mapped section by
+         * temporarily registering a listener, which calls vfio_dma_map
+         * further down the stack. Set reused so vfio_dma_map restores vaddr.
+         */
+        bcontainer->reused = true;
+        bcontainer->remap_listener = (MemoryListener) {
+            .name = "vfio recover",
+            .region_add = vfio_region_remap
+        };
+        memory_listener_register(&bcontainer->remap_listener,
+                                 bcontainer->space->as);
+        memory_listener_unregister(&bcontainer->remap_listener);
+        bcontainer->reused = false;
+        container->vaddr_unmapped = false;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
                                         Error **errp)
 {
@@ -107,6 +147,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    migration_add_notifier_mode(&container->cpr_exec_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_EXEC);
     return true;
 }
 
@@ -115,4 +158,5 @@ void vfio_legacy_cpr_unregister_container(VFIOContainerBase *bcontainer)
     VFIOContainer *container = VFIO_CONTAINER(bcontainer);
 
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migration_remove_notifier(&container->cpr_exec_notifier);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7c4283b..1902c8f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -81,6 +81,8 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    NotifierWithReturn cpr_exec_notifier;
+    bool vaddr_unmapped;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
@@ -292,7 +294,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 void vfio_container_region_add(VFIOContainerBase *bcontainer,
-                               MemoryRegionSection *section);
+                               MemoryRegionSection *section, bool remap);
 void vfio_listener_register(VFIOContainerBase *bcontainer);
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 82ccf0c..3d30365 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -37,6 +37,7 @@ typedef struct VFIOContainerBase {
     Object parent;
     VFIOAddressSpace *space;
     MemoryListener listener;
+    MemoryListener remap_listener;
     Error *error;
     bool initialized;
     bool reused;
-- 
1.8.3.1


