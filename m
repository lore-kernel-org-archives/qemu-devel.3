Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C221C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisQ-0004D5-PH; Thu, 29 May 2025 15:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisH-00046O-4U
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisE-0000E6-1P
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftFd009742;
 Thu, 29 May 2025 19:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Bb0EEY/qYPsNcXN89FP0PXN/66VvTCLaMGnFmfMEFKA=; b=
 KhrvRr481h0ZBtCRoMRYD7Zu0RlLcOFlUi9yAxqtB7MBnHalsPzopTR7UvxqjRWy
 Xy5IgDNbl4U6bGzvXxZGWSc2cGZWeyGdi8W1Zx0upq0RjP5ZD0Y2T2ZYYo3wNFxn
 yXmbKE8txJeAeTwj3ZD5oaqH8+Idw76RwlWm1cyVBaSUUq3kas26ehstOjW/0n/5
 vtu3bIfdnHCPGOKbDl1OLdJxYhPr5hWpgAOMrqkBL/JPuCkFPgtG5otFSOlFPJcG
 yddhGrs1M6djBqC3NoQlD9JkXqOOdCEtSg85+NjaPEnAuYWYDiarRCxWGKF9r7+7
 2iCY3yfOkxZgdnmOrd/IYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THeEi1020317; Thu, 29 May 2025 19:24:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRF022158;
 Thu, 29 May 2025 19:24:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-15; Thu, 29 May 2025 19:24:52 +0000
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
Subject: [PATCH V4 14/43] vfio/container: recover from unmap-all-vaddr failure
Date: Thu, 29 May 2025 12:24:10 -0700
Message-Id: <1748546679-154091-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: 7ZZ7AHS3oL8czprTRRanD5cZp9hntptL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX7cPNOpf4aK9N
 5zZ6P414GRUBZUkWvIcPs1Ey2elZ9/Ar7KaGNMlfroMOQ1cGWlStPl+B7SoUy7hsGiqf0VIg2X/
 6WTCV8kaWk/yjOtOPY1LMTwmefJDUWNrPfrzTKTHDXf3ovIiZVe5WvdLJJnHD6NjDc9BZ9gtpxL
 g0qzTJNpJMWI1sg0RT6T8J6nFxpv/C0rIhfgBB+VkGKJ/5udxToU7C0lEKizfYkf5lQQYnxURk0
 OwMIxmCXhkMPS9j0WnoaC2g2JZFOWyg8eGab0obn1z8VIut0YB/S2ygb7tvPSuPzt6YchQJS2An
 i02yhzRNOdkGq98zD6bjFiM6gnh5N5W7ttCwuBVE03gbZZh346hJTVH9yZ9WKvuKq5h0caARmFN
 G8aF0UlxcIbbhdI19mXETr4H+v7Cqi8iJdRuFAJq8/DyjagkpMLalOelcb0M/mncGS9d2mqv
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b485 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=bXQ6ZcJOO1ukfLjjEFYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7ZZ7AHS3oL8czprTRRanD5cZp9hntptL
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  3 ++
 include/hw/vfio/vfio-cpr.h            | 10 ++++
 hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
 hw/vfio/listener.c                    | 19 +++++++-
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 01cdcb6..dbbe87d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -199,4 +199,7 @@ struct VFIOIOMMUClass {
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool cpr_remap);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b83dd42..56ede04 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -10,6 +10,7 @@
 #define HW_VFIO_VFIO_CPR_H
 
 #include "migration/misc.h"
+#include "system/memory.h"
 
 struct VFIOContainer;
 struct VFIOContainerBase;
@@ -17,6 +18,9 @@ struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    bool vaddr_unmapped;
+    NotifierWithReturn transfer_notifier;
+    MemoryListener remap_listener;
     int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
                          hwaddr iova, ram_addr_t size,
                          void *vaddr, bool readonly, MemoryRegion *mr);
@@ -42,4 +46,10 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int fd);
 
+void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section);
+
+bool vfio_cpr_ram_discard_register_listener(
+    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 512ef41..59e2599 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -30,6 +30,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
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
@@ -121,6 +130,40 @@ static const VMStateDescription vfio_container_vmstate = {
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
+        vioc->dma_map = container->cpr.saved_dma_map;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -143,6 +186,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
         container->cpr.saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
+
+    migration_add_notifier_mode(&container->cpr.transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -153,6 +200,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
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
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index fb1fd84..1106dc9 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -481,6 +481,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -516,6 +523,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -558,7 +570,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
 
-- 
1.8.3.1


