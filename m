Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4FECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilz-0006DE-Qa; Fri, 19 Sep 2025 17:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzils-0006Ai-Di
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilq-0002Wj-31
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDts7Q015846;
 Fri, 19 Sep 2025 21:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=E0Bs0
 /46oRg89iiuFWOJK9F3iaA6Z78rrdoKygG43eg=; b=iu8YbFTMVRNqsU+Rsj2w/
 XrFtvGnHuAvvfAUB0z0R9987OCqO5P7hDfcznlT5LpzYO7bHR85L3zeJumoJfdv8
 fZt9vSnmD61S9mnUdu5+dKRtpSzqmVIaN2cAs4nuPaScgMB+4CuqfgU1jlvXC5sN
 9fjtK2ZtsVload1viSr1UoNgbEdLTjuKYo/q59syg1eTRTnaCqlvKfrEJz8o2K12
 lEaFmblwDpdb8QG3hwL4Nbcsg05kanI94aRJSOhLprng/t2UtaaBu2BjAPLHP3+4
 +ikL5DB5XtkfG7TWDPfyRaLTLd51LMAKTvpBQ45AWlqnl9fvLTOoMckCTEbEVzVa
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx96b69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JItLGp033730; Fri, 19 Sep 2025 21:35:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0J004301;
 Fri, 19 Sep 2025 21:35:45 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-12; Fri, 19 Sep 2025 21:35:45 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 11/22] amd_iommu: Use iova_tree records to determine large
 page size on UNMAP
Date: Fri, 19 Sep 2025 21:35:04 +0000
Message-ID: <20250919213515.917111-12-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Proofpoint-ORIG-GUID: HCacK4PMSGOErmKEWGqkm-hUGfKK3cOu
X-Proofpoint-GUID: HCacK4PMSGOErmKEWGqkm-hUGfKK3cOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/5GdS2BGNdmx
 hUWlxZLpj1BNRgP8ld0sqtJyCndhG2JzfO4MsMBT5/NHfmmAn5uA6IFE26XxqhMRsD9Gt55fc5m
 oN64TnOG8oZ6a3Zstv+PFIhUonjLShjwzlE8hCo3djZwef63yQzGFvTtMxuirJ4t58hCRjpVr9d
 oMlXpY7IGyrQGe/qYo3Q1cXMo10aUtq7hb3rDhJbSBnrnTAOdbe8JD8JV+uvuYVqyOf8sOfhdak
 4BPNuUjrcb/9IO1QT2614geKHT0OsCM8NFCLLRpg0f/STIs0RqwLwBOnECBamcY7VKE+XTlcU+G
 9kNOfYmp7mKly0Uyz8Uwtil7RjlXhZJExcwzeY3tik/ulLZwl0XW8UqMyoBmGtpSOH53Fsns9hc
 olLHFfNa
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cdccb3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=7d1lPJd8Oj0-l-ugTcUA:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep a record of mapped IOVA ranges per address space, using the iova_tree
implementation. Besides enabling optimizations like avoiding unnecessary
notifications, a record of existing <IOVA, size> mappings makes it possible
to determine if a specific IOVA is mapped by the guest using a large page,
and adjust the size when notifying UNMAP events.

When unmapping a large page, the information in the guest PTE encoding the
page size is lost, since the guest clears the PTE before issuing the
invalidation command to the IOMMU. In such case, the size of the original
mapping can be retrieved from the iova_tree and used to issue the UNMAP
notification. Using the correct size is essential since the VFIO IOMMU
Type1v2 driver in the host kernel will reject unmap requests that do not
fully cover previous mappings.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 95 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index caae65c4b3565..4376e977f8886 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -33,6 +33,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
 #include "kvm/kvm_i386.h"
+#include "qemu/iova-tree.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -71,6 +72,8 @@ struct AMDVIAddressSpace {
     IOMMUNotifierFlag notifier_flags;
     /* entry in list of Address spaces with registered notifiers */
     QLIST_ENTRY(AMDVIAddressSpace) next;
+    /* Record DMA translation ranges */
+    IOVATree *iova_tree;
 };
 
 /* AMDVI cache entry */
@@ -685,6 +688,75 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
     return 0;
 }
 
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
+    }
+
+    /* Invoke the notifiers registered for this address space */
+    memory_region_notify_iommu(&as->iommu, 0, *event);
+}
+
 /*
  * Walk the guest page table for an IOVA and range and signal the registered
  * notifiers to sync the shadow page tables in the host.
@@ -696,7 +768,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
 {
     IOMMUTLBEvent event;
 
-    hwaddr iova_next, page_mask, pagesize;
+    hwaddr page_mask, pagesize;
     hwaddr iova = addr;
     hwaddr end = iova + size - 1;
 
@@ -719,7 +791,6 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
         /* PTE has been validated for major errors and pagesize is set */
         assert(pagesize);
         page_mask = ~(pagesize - 1);
-        iova_next = (iova & page_mask) + pagesize;
 
         if (ret == -AMDVI_FR_PT_ENTRY_INV) {
             /*
@@ -752,15 +823,26 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
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
+        iova &= ~(pagesize - 1);
+
         /* Check for 64-bit overflow and terminate walk in such cases */
-        if (iova_next < iova) {
+        if ((iova + pagesize) < iova) {
             break;
         } else {
-            iova = iova_next;
+            iova += pagesize;
         }
     }
 }
@@ -1845,6 +1927,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
+        iommu_as[devfn]->iova_tree = iova_tree_new();
 
         amdvi_dev_as = iommu_as[devfn];
 
-- 
2.43.5


