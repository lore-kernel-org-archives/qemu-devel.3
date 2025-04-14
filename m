Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3633EC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BE-0007Om-0S; Sun, 13 Apr 2025 22:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Aq-0007Gj-7P
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ao-0007UX-F8
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:47 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1l87F003476;
 Mon, 14 Apr 2025 02:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=sXxl9
 nOc7QzKTi7Yj9JakM5/rSOn1wKG6MgIq83sVUo=; b=T40TRgMv5nweuu8XXuory
 BWASINOmwfA9vfXcDJ1eNYfvq33DwuPV86wn0ycetgNP6lY8ch88HmCUxFTCAiRh
 x7I6KnTc+aAn4fkVleRoRwXmsrpzQNhztuplnsXwf6TA2fq4Wl7VEDSOnmlX4i80
 7DXljumu9dwQmro+osdq1CLzycWAobBaHff4pIk4KZJQeN3JgKvh2HDEXViH4Xfk
 1pYtB5J1QHCQuPwoF7o73zUwuF2w338jzq+FMFVMucBHOV+abR2S+3zphjgnK1R8
 D8Ufebu6RN5DhbW+KT7UjPswkKwT4/JQgnmnIYkjljeKfdZnSOj0zXLdxmkzxGRs
 w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s0g00bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMsuHh009219; Mon, 14 Apr 2025 02:03:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYg035550;
 Mon, 14 Apr 2025 02:03:40 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-11; Mon, 14 Apr 2025 02:03:39 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 10/18] amd_iommu: Add a page walker to sync shadow page tables
 on invalidation
Date: Mon, 14 Apr 2025 02:02:45 +0000
Message-ID: <20250414020253.443831-11-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: VJgYpL8qg0E9YoylAHK6ebNpZwmAEoZn
X-Proofpoint-GUID: VJgYpL8qg0E9YoylAHK6ebNpZwmAEoZn
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

For the specified address range, walk the page table identifying regions
as mapped or unmapped and invoke registered notifiers with the
corresponding event type.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d089fdc28ef1..6789e1e9b688 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1688,6 +1688,80 @@ fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
     return pte;
 }
 
+/*
+ * Walk the guest page table for an IOVA and range and signal the registered
+ * notifiers to sync the shadow page tables in the host.
+ * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
+ */
+static void __attribute__((unused))
+amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
+                                   hwaddr addr, uint64_t size, bool send_unmap)
+{
+    IOMMUTLBEvent event;
+
+    hwaddr iova_next, page_mask, pagesize;
+    hwaddr iova = addr;
+    hwaddr end = iova + size - 1;
+
+    uint64_t pte;
+
+    while (iova < end) {
+
+        pte = fetch_pte(as, iova, dte[0], &pagesize);
+
+        if (pte == (uint64_t)-2) {
+            /*
+             * Invalid conditions such as the IOVA being larger than supported
+             * by current page table mode as configured in the DTE, or a failure
+             * to fetch the Page Table from the Page Table Root Pointer in DTE.
+             */
+            assert(pagesize == 0);
+            return;
+        }
+        /* PTE has been validated for major errors and pagesize is set */
+        assert(pagesize);
+        page_mask = ~(pagesize - 1);
+        iova_next = (iova & page_mask) + pagesize;
+
+        if (pte == (uint64_t)-1) {
+            /*
+             * Failure to read PTE from memory, the pagesize matches the current
+             * level. Unable to determine the region type, so a safe strategy is
+             * to skip the range and continue the page walk.
+             */
+            goto next;
+        }
+
+        event.entry.target_as = &address_space_memory;
+        event.entry.iova = iova & page_mask;
+        /* translated_addr is irrelevant for the unmap case */
+        event.entry.translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) &
+                                      page_mask;
+        event.entry.addr_mask = ~page_mask;
+        event.entry.perm = amdvi_get_perms(pte);
+
+        /*
+         * In cases where the leaf PTE is not found, or it has invalid
+         * permissions, an UNMAP type notification is sent, but only if the
+         * caller requested it.
+         */
+        if (!IOMMU_PTE_PRESENT(pte) || (event.entry.perm == IOMMU_NONE)) {
+            if (!send_unmap) {
+                goto next;
+            }
+            event.type = IOMMU_NOTIFIER_UNMAP;
+        } else {
+            event.type = IOMMU_NOTIFIER_MAP;
+        }
+
+        /* Invoke the notifiers registered for this address space */
+        memory_region_notify_iommu(&as->iommu, 0, event);
+
+next:
+        iova = iova_next;
+    }
+}
+
 /*
  * Toggle between address translation and passthrough modes by enabling the
  * corresponding memory regions.
-- 
2.43.5


