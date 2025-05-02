Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD99C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx9-0003wf-4F; Thu, 01 May 2025 22:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx5-0003uh-1t
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx1-0007Rd-OQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421ECb7014989;
 Fri, 2 May 2025 02:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Ge694
 OK/WX30qgMogNvU+mFU3lE6Ta5XVxReHHIKxB4=; b=YKBDXffVF/WI/FeIAVBVq
 faKmEtdJ1Q1DJoe0jz9t1k1QBoE8KxQ15Pnwvm4X+GUmLb8otoanaTncjXjHPLnh
 ZnwPjMWlezb3o1+UfPTpzc8SFlGmNQv+ZEOG1V0CYkLIFjzyNo4thXnl51q2Brbr
 3KUKs4zCE/iFLgLun0cwWLRZAJSEcNXK7OanqCiPzVp72fjIuEarANJkF4yqb9eE
 Q0rN9Pf0g5EwKiWYfCaqSOCvyO9jreqEYiLcJD9PAywm/UevL04Y/SBfrIJaNBxL
 VaiKGvv05jlmWjOMeACNrAIK7gZEeqFM50q/2HD3Kz+aSqM48oyaiPJ9gekOl+QL
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukvh2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421IoqX023986; Fri, 2 May 2025 02:16:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh01n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsC011525;
 Fri, 2 May 2025 02:16:14 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-12; Fri, 02 May 2025 02:16:14 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 11/20] amd_iommu: Use iova_tree records to determine large
 page size on UNMAP
Date: Fri,  2 May 2025 02:15:56 +0000
Message-ID: <20250502021605.1795985-12-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX/BNi1WtP1tFf
 SLd1c0cTYzymqrcMb8gNkCP+zDHCo3a5yFzpS0XQNamtuLcgEmEAECg9Jo7Mh8VLR8YH9xRDzqc
 3ecHj04JXr04D9XJKhmVe311enWCACHVPDkHQFST/BsehOz8frHvuoxv1u+Gj2MlEDWNnkUqo33
 J8mU2cHfaogQ1a4m9OCvE6/cx8m7PNLNNfhbTL3d9/e+NuazgnDXuPhoiurt5nmDK+yZaq7yys0
 zjpdIyDH/a7jId8xMb0Y3Upbv6RiJ8KyasN67rzIafNIGLnIW4P8Qjmmcr4fgb+4PFVTMPJxDDD
 8XUU3p0kLOZMWZFfrU4SA4WhxgSmRJlz43oO8VP0l5ExQeV3bBADdN+cuIr7dhfa+u7BiyRzo8R
 H3Ssm8rwjaoFQWULCGNPef1ekoVzoSEN23mtigsUIfin6ZnY3u+8XWJCQBTkLUq03QptHTxS
X-Proofpoint-GUID: tP0HFvlzDDc_f8oL6MXJtwqmSyZpKO3A
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68142af9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=7d1lPJd8Oj0-l-ugTcUA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: tP0HFvlzDDc_f8oL6MXJtwqmSyZpKO3A
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/i386/amd_iommu.c | 91 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index bddfe2f93136..4f44ef159ff9 100644
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
@@ -653,6 +656,75 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
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
@@ -664,7 +736,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
 {
     IOMMUTLBEvent event;
 
-    hwaddr iova_next, page_mask, pagesize;
+    hwaddr page_mask, pagesize;
     hwaddr iova = addr;
     hwaddr end = iova + size - 1;
 
@@ -687,7 +759,6 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
         /* PTE has been validated for major errors and pagesize is set */
         assert(pagesize);
         page_mask = ~(pagesize - 1);
-        iova_next = (iova & page_mask) + pagesize;
 
         if (ret == -AMDVI_FR_PT_ENTRY_INV) {
             /*
@@ -720,11 +791,20 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
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
     }
 }
 
@@ -1783,6 +1863,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NONE;
+        iommu_as[devfn]->iova_tree = iova_tree_new();
 
         amdvi_dev_as = iommu_as[devfn];
 
-- 
2.43.5


