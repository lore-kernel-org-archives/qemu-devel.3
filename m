Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A67FC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IP-0000Zo-LG; Wed, 29 Jan 2025 09:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IG-0000W7-Qw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IE-0001Ko-QD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:52 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEbCQj007548;
 Wed, 29 Jan 2025 14:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=QKAEHNgfgJr719FTxd7rx1e4E3u189Wkt3eRkRWbTdI=; b=
 d9sndbHhIYGJHZGNJb9XIAojMU9m5rsM1gd9d/6mVfhZzk0NMRv3fMy6d+py4b7V
 iThSajSqQ+sXQsQf86fF8b3yWvUEiSzoA/T1hXOWrAYdmjAQFuO2y2shARIMwQGQ
 44ZsvbZ3J2azXLcPUD4pfcWLqATwpBKuFoopCNmLyQRf6oIaPlBgi74CoZomqkjg
 iZD0pV++AtdoJi3AH2gZPdFyOhJH+t2uECmnJRsPK5YiJkZLDC6hJm8pN96wqhp/
 5nkfDHzZVgmWihzR2Gq5yjRxzDFmCpcfLCNJWj8WWGv+DRfjug1y/WjFDb1SrBa9
 rKw6b1TMGtEPGzNSS05dbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e00qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TE3Xqx036333; Wed, 29 Jan 2025 14:43:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8S003307;
 Wed, 29 Jan 2025 14:43:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-8; Wed, 29 Jan 2025 14:43:46 +0000
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
Subject: [PATCH V1 07/26] vfio/container: recover from unmap-all-vaddr failure
Date: Wed, 29 Jan 2025 06:43:03 -0800
Message-Id: <1738161802-172631-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: G5Wpx8pkceuc2bpQs5pqBBgg5ip0MY1s
X-Proofpoint-GUID: G5Wpx8pkceuc2bpQs5pqBBgg5ip0MY1s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
 hw/vfio/common.c              | 47 ++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/cpr-legacy.c          | 44 ++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  6 +++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7370332..c8ee71a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -580,6 +580,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    vfio_container_region_add(bcontainer, section, false);
+}
+
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section,
+                               bool remap)
+{
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -614,6 +621,30 @@ static void vfio_listener_region_add(MemoryListener *listener,
         int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
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
@@ -656,7 +687,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
index f3a31d1..3139de1 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -26,9 +26,18 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->vaddr_unmapped = true;
     return true;
 }
 
+static void vfio_region_remap(MemoryListener *listener,
+                              MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer,
+                                            remap_listener);
+    vfio_container_region_add(&container->bcontainer, section, true);
+}
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -88,6 +97,37 @@ static const VMStateDescription vfio_container_vmstate = {
     }
 };
 
+static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    VFIOContainer *container =
+        container_of(notifier, VFIOContainer, cpr_transfer_notifier);
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
+        container->reused = true;
+        container->remap_listener = (MemoryListener) {
+            .name = "vfio recover",
+            .region_add = vfio_region_remap
+        };
+        memory_listener_register(&container->remap_listener,
+                                 bcontainer->space->as);
+        memory_listener_unregister(&container->remap_listener);
+        container->reused = false;
+        container->vaddr_unmapped = false;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -104,6 +144,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    migration_add_notifier_mode(&container->cpr_transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -114,4 +157,5 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     vfio_cpr_unregister_container(bcontainer);
     migrate_del_blocker(&container->cpr_blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migration_remove_notifier(&container->cpr_transfer_notifier);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1e974e0..8a4a658 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -86,6 +86,9 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     Error *cpr_blocker;
     bool reused;
+    bool vaddr_unmapped;
+    NotifierWithReturn cpr_transfer_notifier;
+    MemoryListener remap_listener;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
@@ -311,7 +314,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
-void vfio_listener_register(VFIOContainerBase *bcontainer);
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool remap);
 
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
-- 
1.8.3.1


