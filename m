Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E04C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BI-0007R4-N6; Sun, 13 Apr 2025 22:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49BB-0007O2-GS
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49B9-0007WK-3v
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E17Mqo023470;
 Mon, 14 Apr 2025 02:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=miDr/
 T4z/llbrLEPHEIITT5v9VthVO4CERsAnohUPSw=; b=VKU1nE/qlE8kSk8L8Vp2S
 N8mu0jhvyqVAteSGPqJHZO5BLt/9QPvB1xCYii9i5IbDAOH/XfWwr0a4VOeWRZjh
 yRV22YOaFoLJ/RI1ZIcSPxrM53giyGgSWR8WAiV4mz1UGXL4JgCrGnOGu0J0g+Sm
 8EqWz0THFVwY1BRl5cjjVdl4EIhgqPG2trO27/kFI5AYMXqEdbxehGvXLAmfgKFC
 ovG3pptpSMEniP9GKmO9kY9+aJ0QX3XjDxfy3rOxJ1gyHSRQfsvFXYBkNuFJnzzV
 qyhghaW3xlWpxjyOglrBeHRWXeMmp9AB7lTKT8X33Akkb2Tg1vWa6O3H6wf4Kk3x
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460rdr01fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN0Lio009275; Mon, 14 Apr 2025 02:03:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvquy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYq035550;
 Mon, 14 Apr 2025 02:03:50 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-16; Mon, 14 Apr 2025 02:03:49 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 15/18] amd_iommu: Use iova_tree records to determine large
 page size on UNMAP
Date: Mon, 14 Apr 2025 02:02:50 +0000
Message-ID: <20250414020253.443831-16-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-GUID: FLqiD4eTUTFOPI_Jini11L8IrUVVGUQG
X-Proofpoint-ORIG-GUID: FLqiD4eTUTFOPI_Jini11L8IrUVVGUQG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Keep a record of mapped IOVA ranges per address space, using the
iova_tree implementation. Besides enabling optimizations like avoiding
unnecessary notifications, a record of existing <IOVA, size> mappings
makes it possible to determine if a specific IOVA is mapped by the guest
using a large page, and adjust the size when notifying UNMAP events.

When unmapping a large page, the information in the guest PTE encoding
the page size is lost, since the guest clears the PTE before issuing the
invalidation command to the IOMMU. In such case, the size of the
original mapping can be retrieved from the iova_tree and used to issue
the UNMAP notification. Using the correct size is essential since the
VFIO IOMMU Type1v2 driver in the host kernel will reject unmap requests
that do not fully cover previous mappings.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 98 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index abdd67f6b12c..e502bbbbb7d3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -33,6 +33,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
 #include "kvm/kvm_i386.h"
+#include "qemu/iova-tree.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -73,6 +74,7 @@ struct AMDVIAddressSpace {
     QLIST_ENTRY(AMDVIAddressSpace) next;
     /* DMA address translation active */
     bool addr_translation;
+    IOVATree *iova_tree;        /* Record DMA translation ranges */
 };
 
 /* AMDVI cache entry */
@@ -103,6 +105,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
 static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n);
 static void amdvi_address_space_sync(AMDVIAddressSpace *as);
 static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as);
+static void amdvi_notify_iommu(AMDVIAddressSpace *as, IOMMUTLBEvent *event);
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
@@ -1366,6 +1369,7 @@ static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
     hwaddr start = n->start;
     hwaddr end = n->end;
     hwaddr remain;
+    DMAMap map;
 
     assert(start <= end);
     remain = end - start + 1;
@@ -1399,6 +1403,11 @@ static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(!remain);
+
+    map.iova = n->start;
+    map.size = n->end - n->start;
+
+    iova_tree_remove(as->iova_tree, map);
 }
 
 /*
@@ -1908,7 +1917,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
 {
     IOMMUTLBEvent event;
 
-    hwaddr iova_next, page_mask, pagesize;
+    hwaddr page_mask, pagesize;
     hwaddr iova = addr;
     hwaddr end = iova + size - 1;
 
@@ -1930,7 +1939,6 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
         /* PTE has been validated for major errors and pagesize is set */
         assert(pagesize);
         page_mask = ~(pagesize - 1);
-        iova_next = (iova & page_mask) + pagesize;
 
         if (pte == (uint64_t)-1) {
             /*
@@ -1963,12 +1971,90 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
             event.type = IOMMU_NOTIFIER_MAP;
         }
 
-        /* Invoke the notifiers registered for this address space */
-        memory_region_notify_iommu(&as->iommu, 0, event);
+        /*
+         * The following call might need to adjust event.entry.size in cases
+         * where the guest unmapped a series of large pages.
+         */
+        amdvi_notify_iommu(as, &event);
+        /*
+         * In the special scenario where the guest is unmapping a large page,
+         * addr_mask has been adjusted before sending the notification. Update
+         * pagesize accordingly in order to correctly compute the next IOVA.
+         */
+        pagesize = event.entry.addr_mask + 1;
 
 next:
-        iova = iova_next;
+        iova = (iova & ~(pagesize - 1)) + pagesize;
+    }
+}
+
+/*
+ * Invoke notifiers registered for the address space. Update record of mapped
+ * ranges in IOVA Tree.
+ */
+static void amdvi_notify_iommu(AMDVIAddressSpace *as, IOMMUTLBEvent *event)
+{
+    IOMMUTLBEntry *entry = &event->entry;
+
+    DMAMap target = {
+        .iova = entry->iova,
+        .size = entry->addr_mask,
+        .translated_addr = entry->translated_addr,
+        .perm = entry->perm,
+    };
+
+    /*
+     * Search the IOVA Tree for an existing translation for the target, and skip
+     * the notification if the mapping is already recorded.
+     * When the guest uses large pages, comparing against the record makes it
+     * possible to determine the size of the original MAP and adjust the UNMAP
+     * request to match it. This avoids failed checks against the mappings kept
+     * by the VFIO kernel driver.
+     */
+    const DMAMap *mapped = iova_tree_find(as->iova_tree, &target);
+
+    if (event->type == IOMMU_NOTIFIER_UNMAP) {
+        if (!mapped) {
+            /* No record exists of this mapping, nothing to do */
+            return;
+        }
+        /*
+         * Adjust the size based on the original record. This is essential to
+         * determine when large/contiguous pages are used, since the guest has
+         * already cleared the PTE (erasing the pagesize encoded on it) before
+         * issuing the invalidation command.
+         */
+        if (mapped->size != target.size) {
+            assert(mapped->size > target.size);
+            target.size = mapped->size;
+            /* Adjust event to invoke notifier with correct range */
+            entry->addr_mask = mapped->size;
+        }
+        iova_tree_remove(as->iova_tree, target);
+    } else { /* IOMMU_NOTIFIER_MAP */
+        if (mapped) {
+            /*
+             * If a mapping is present and matches the request, skip the
+             * notification.
+             */
+            if (!memcmp(mapped, &target, sizeof(DMAMap))) {
+                return;
+            } else {
+                /*
+                 * This should never happen unless a buggy guest OS omits or
+                 * sends incorrect invalidation(s). Report an error in the event
+                 * it does happen.
+                 */
+                error_report("Found conflicting translation. This could be due "
+                             "to an incorrect or missing invalidation command");
+            }
+        }
+        /* Record the new mapping */
+        iova_tree_insert(as->iova_tree, &target);
     }
+
+    /* Invoke the notifiers registered for this address space */
+    memory_region_notify_iommu(&as->iommu, 0, *event);
 }
 
 /*
@@ -2034,6 +2120,7 @@ static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
         return;
     }
 
+    /* Dropping all mappings for the addres space. Also clears the IOVA tree */
     amdvi_address_space_unmap(as, n);
 
     amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
@@ -2062,6 +2149,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
+        iommu_as[devfn]->iova_tree = iova_tree_new();
 
         amdvi_dev_as = iommu_as[devfn];
 
-- 
2.43.5


