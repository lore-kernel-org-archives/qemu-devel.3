Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05EBCAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilj-00069M-Db; Fri, 19 Sep 2025 17:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilh-00068z-PU
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilf-0002W0-Mu
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuIF3016180;
 Fri, 19 Sep 2025 21:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=a+AZk
 PhZ//mGcKkNSYrVPysYAds/NDLDzdFptNPnhr8=; b=QpqbQ3PVSTrB1oxJUOSxn
 jSSWyKqid3mSWVGe/Z1JGDG9yLt05zj9djZZM1cAUmquipzyfduuR8D95jqaeaIY
 /BNoR1qDDgaAU+aCjC4atTDKon2LiOIlaO38NNiFBg8w6NuGiPvFxemCihC2aGc2
 iNA+13Y3br65sF0RLxtO0FjuAgGdFJ+BgOLROCogg7d6+P5YH/FHF0tQRTUq6NtM
 nesvjCEbzE2cjGWnMZ8neyIGOUzvCfVADQyw/59O1ax4r6ErbBrj3xwwnj2S+uGr
 TH1tzZWZtSFSnzwh+cWuTCYNGICYuqLaciAR8ia/pQ4ehoWqnncMDykCJQ/xNC98
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbxdq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JIx8c2033731; Fri, 19 Sep 2025 21:35:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0D004301;
 Fri, 19 Sep 2025 21:35:38 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-9; Fri, 19 Sep 2025 21:35:37 +0000
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
Subject: [PATCH v3 08/22] amd_iommu: Add a page walker to sync shadow page
 tables on invalidation
Date: Fri, 19 Sep 2025 21:35:01 +0000
Message-ID: <20250919213515.917111-9-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0fDsu2xsTGTf
 fdNjYToZeDcsjuHVSXZ+q/2Mi5gK0waPnd6YMUtHmYp06LWCk/PTI/erlFydDA8qfOADgFHPQxr
 JV95ffvM9s7XhU5i3hZEfvdAQnvuApoCLQYoUGk+jX6zISqh7lWeL4CcgooyiE+QXgUmmLKm976
 ei2Et7/W1ZLf8F+hKdPdMkwpVEpbQNHSgNPzlWp23aB6GXW6SVHUNohrXRpqGrp9uzr4dEwrOhQ
 5c6QoH9GZiEwpGgRYvzAH/6/odUAXR5FcEYuGEJidKMbh/Tdy+tDlz+89BC5q1aW3fsrsBOtUn7
 RrcKa0NOYAu9IQ73WMSMNU2WPf4HmSjscqZ0hFQFyzEWqCN91bIaBTiFT4VHrSp5AQW0PtouZlM
 sQ8tUv2/
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cdccab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mMwD0hUo444mCu11VDkA:9
X-Proofpoint-GUID: WhIqMcyLEjSbAdBUeqAkG9bhNFsS9q9V
X-Proofpoint-ORIG-GUID: WhIqMcyLEjSbAdBUeqAkG9bhNFsS9q9V
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

For the specified address range, walk the page table identifying regions
as mapped or unmapped and invoke registered notifiers with the
corresponding event type.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c25981ff93c02..0e45435c77be9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -681,6 +681,86 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
     return 0;
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
+    int ret;
+
+    while (iova < end) {
+
+        ret = fetch_pte(as, iova, dte[0], &pte, &pagesize);
+
+        if (ret == -AMDVI_FR_PT_ROOT_INV) {
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
+        if (ret == -AMDVI_FR_PT_ENTRY_INV) {
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
+        /* Check for 64-bit overflow and terminate walk in such cases */
+        if (iova_next < iova) {
+            break;
+        } else {
+            iova = iova_next;
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-- 
2.43.5


