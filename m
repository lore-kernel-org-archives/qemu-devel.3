Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B5A1061B24
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K9z-0007u7-GX; Mon, 30 Mar 2026 17:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9v-0007tb-Dy
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9t-0006FH-47
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDE1SC2001947; Mon, 30 Mar 2026 21:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fttLD
 iltSJACdB2XElhG21tLldLlYiWL3RwDQ4QzDkk=; b=Iqb5o+x32+ZtOysTEDix8
 fr0xngdD7y8xqdDGbmJK6UUgapsY5LpyvtqQeFD1ghFBB7cs4EykxKOQuMl/7YRx
 P/2r2UxYkF+vZpAqKnpCFDOpdcj/4lnko0W6518zghtAsyz0og7eVeOLCOop00Qq
 lJqR0MFz8w5LRydm9KFN6mFAV/OOiNu2upQOAb4Ld0SRAIkAQ24wJt6sRHtxEtSS
 ykWcTtnufap8Xp7WQZDkLo9xTuXXSQBP2Eq4gf6slG3KTcaoQOmBkgM7qgEnhE1S
 gINGztUg+RvY6wIgjrnow4LlljB4jD3cZnxo244MIjNGaLwWpMNzApi9Eg/CRqgl
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwb49g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UKMWet036408; Mon, 30 Mar 2026 21:28:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65efn542-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62ULSISx018888;
 Mon, 30 Mar 2026 21:28:18 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4d65efn53s-2; Mon, 30 Mar 2026 21:28:18 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, sarunkod@amd.com, qemu@demindiro.com, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH for-11.0 1/2] amd_iommu: Follow root pointer before page walk
 and use 1-based levels
Date: Mon, 30 Mar 2026 21:28:16 +0000
Message-ID: <20260330212817.992673-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
References: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE4MiBTYWx0ZWRfX4lfd3vr1Cu7a
 NCX++UwamtEYjHszDFNoWdTeIIqN+mNev04+L0px5/JUQlAPLy1UYadhw10uLPr1KYT/jDElLuZ
 QgGEYYvvt4du/mGpUeyewEqL3fpzBlYMuv/UmcKDnvEMZ1RmkEp21L79AIJns34oeBBfm7x0GjN
 hEbirl+kgwcjAh96ztkqpFPsIBbBN7opSEt3mHIiXEof7HLDl1JTabq93Y/TI8ea347qU3X4irN
 O7Kcf8CgjhcIFjj+dCF/e6+95ftWLULQT8PUfWQraI3phoif/gHuUAXiD1inYLT4imAoMW6qkOB
 TV7EyaQwScSXqhCVtQSWtNPhxpR1G0yHPgcpwHqgGr08rMVTApdetJ5wlxbFxxaiFNeosVGIEOA
 MtxaSF8k5TA537qK7ehHNzTvHxwzzjM8Gv+GecwiojFNLo0aM2AMveOIzzeAl3adrfEWG5P1Fjt
 zxCxVlD8DiYJgOyAVEZ4kpFuQ1wkSYlU9oK50L80=
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69caeaf4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=69wJf7TsAAAA:8 a=RWxpEp7VAAAA:8 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=y5qzoqqGynPG9JP8Bm8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=3unh6Pbajv6CBnL1DxgC:22 cc=ntf awl=host:12276
X-Proofpoint-ORIG-GUID: MQM5MYGdW0N_JXlyihtPmIxgzxBW580P
X-Proofpoint-GUID: MQM5MYGdW0N_JXlyihtPmIxgzxBW580P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
fetch_pte() currently uses a 0-based level counter, making the logic
harder to follow and requiring conversions between DTE mode and level.

Switch the page table walk logic to use 1-based level accounting in
fetch_pte() and the relevant macro helpers. To further simplify the page
walking loop, split the root page table access from the walk i.e. rework
fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
level pagetable entry before entering the loop, then iterate only over the
PDE/PTE entries.

The reworked algorithm fixes a page walk bug where the page size was
calculated for the next level before checking if the current PTE was already
a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
leading to performance degradation and failures in some setups.

Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
Cc: qemu-stable@nongnu.org
Reported-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-By: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 132 ++++++++++++++++++++++++++++++--------------
 hw/i386/amd_iommu.h |  11 ++--
 2 files changed, 97 insertions(+), 46 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2..04acfa645f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -648,6 +648,52 @@ static uint64_t large_pte_page_size(uint64_t pte)
     return PTE_LARGE_PAGE_SIZE(pte);
 }
 
+/*
+ * Validate DTE fields and extract permissions and top level data required to
+ * initiate the page table walk.
+ *
+ * On success, returns 0 and stores:
+ *   - top_level: highest page-table level encoded in DTE[Mode]
+ *   - dte_perms: effective permissions from the DTE
+ *
+ * On failure, returns -AMDVI_FR_PT_ROOT_INV. This includes cases where:
+ *   - DTE permissions disallow read AND write
+ *   - DTE[Mode] is invalid for translation
+ *   - IOVA exceeds the address width supported by DTE[Mode]
+ * In all such cases a page walk must be aborted.
+ */
+static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+                                                 uint8_t *top_level,
+                                                 IOMMUAccessFlags *dte_perms)
+{
+    *dte_perms = amdvi_get_perms(dte);
+    if (*dte_perms == IOMMU_NONE) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /* Verifying a valid mode is encoded in DTE */
+    *top_level = get_pte_translation_mode(dte);
+
+    /*
+     * Page Table Root pointer is only valid for GPA->SPA translation on
+     * supported modes.
+     */
+    if (*top_level == 0 || *top_level > 6) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /*
+     * If IOVA is larger than the max supported by the highest pgtable level,
+     * there is nothing to do.
+     */
+    if (address > PT_LEVEL_MAX_ADDR(*top_level)) {
+        /* IOVA too large for the current DTE */
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    return 0;
+}
+
 /*
  * Helper function to fetch a PTE using AMD v1 pgtable format.
  * On successful page walk, returns 0 and pte parameter points to a valid PTE.
@@ -662,40 +708,49 @@ static uint64_t large_pte_page_size(uint64_t pte)
 static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
-    IOMMUAccessFlags perms = amdvi_get_perms(dte);
-
-    uint8_t level, mode;
     uint64_t pte_addr;
+    uint8_t pt_level, next_pt_level;
+    IOMMUAccessFlags perms;
+    int ret;
 
-    *pte = dte;
     *page_size = 0;
 
-    if (perms == IOMMU_NONE) {
-        return -AMDVI_FR_PT_ROOT_INV;
-    }
-
     /*
-     * The Linux kernel driver initializes the default mode to 3, corresponding
-     * to a 39-bit GPA space, where each entry in the pagetable translates to a
-     * 1GB (2^30) page size.
+     * Verify the DTE is properly configured before page walk, and extract
+     * top pagetable level and permissions.
      */
-    level = mode = get_pte_translation_mode(dte);
-    assert(mode > 0 && mode < 7);
+    ret = amdvi_get_top_pt_level_and_perms(address, dte, &pt_level, &perms);
+    if (ret < 0) {
+        return ret;
+    }
 
     /*
-     * If IOVA is larger than the max supported by the current pgtable level,
-     * there is nothing to do.
+     * Retrieve the top pagetable entry by following the DTE Page Table Root
+     * Pointer and indexing the top level table using the IOVA from the request.
      */
-    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
-        /* IOVA too large for the current DTE */
+    pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
+    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+
+    if (*pte == (uint64_t)-1) {
+        /*
+         * A returned PTE of -1 here indicates a failure to read the top level
+         * page table from guest memory. A page walk is not possible and page
+         * size must be returned as 0.
+         */
         return -AMDVI_FR_PT_ROOT_INV;
     }
 
-    do {
-        level -= 1;
+    /*
+     * Calculate page size for the top level page table entry.
+     * This ensures correct results for a single level Page Table setup.
+     */
+    *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
 
-        /* Update the page_size */
-        *page_size = PTE_LEVEL_PAGE_SIZE(level);
+    /*
+     * The root page table entry and its level have been determined. Begin the
+     * page walk.
+     */
+    while (pt_level > 0) {
 
         /* Permission bits are ANDed at every level, including the DTE */
         perms &= amdvi_get_perms(*pte);
@@ -708,37 +763,34 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
             return 0;
         }
 
+        next_pt_level = PTE_NEXT_LEVEL(*pte);
+
         /* Large or Leaf PTE found */
-        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
+        if (next_pt_level == 0 || next_pt_level == 7) {
             /* Leaf PTE found */
             break;
         }
 
+        pt_level = next_pt_level;
+
         /*
-         * Index the pgtable using the IOVA bits corresponding to current level
-         * and walk down to the lower level.
+         * The current entry is a Page Directory Entry. Descend to the lower
+         * page table level encoded in current pte, and index the new table
+         * using the appropriate IOVA bits to retrieve the new entry.
          */
-        pte_addr = NEXT_PTE_ADDR(*pte, level, address);
+        *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
+
+        pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
         *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
 
         if (*pte == (uint64_t)-1) {
-            /*
-             * A returned PTE of -1 indicates a failure to read the page table
-             * entry from guest memory.
-             */
-            if (level == mode - 1) {
-                /* Failure to retrieve the Page Table from Root Pointer */
-                *page_size = 0;
-                return -AMDVI_FR_PT_ROOT_INV;
-            } else {
-                /* Failure to read PTE. Page walk skips a page_size chunk */
-                return -AMDVI_FR_PT_ENTRY_INV;
-            }
+            /* Failure to read PTE. Page walk skips a page_size chunk */
+            return -AMDVI_FR_PT_ENTRY_INV;
         }
-    } while (level > 0);
+    }
+
+    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7);
 
-    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
-           level == 0);
     /*
      * Page walk ends when Next Level field on PTE shows that either a leaf PTE
      * or a series of large PTEs have been reached. In the latter case, even if
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca512..7af3c742b7 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -186,17 +186,16 @@
 
 #define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
 
-/* Using level=0 for leaf PTE at 4K page size */
-#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
+/* Using level=1 for leaf PTE at 4K page size */
+#define PT_LEVEL_SHIFT(level)           (12 + (((level) - 1) * 9))
 
 /* Return IOVA bit group used to index the Page Table at specific level */
 #define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
                                         GENMASK64(8, 0))
 
-/* Return the max address for a specified level i.e. max_oaddr */
-#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
-                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
-                                (~(0ULL)))
+/* Return the maximum output address for a specified page table level */
+#define PT_LEVEL_MAX_ADDR(level)    (((level) > 5) ? (~(0ULL)) : \
+                                    ((1ULL << PT_LEVEL_SHIFT((level) + 1)) - 1))
 
 /* Extract the NextLevel field from PTE/PDE */
 #define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
-- 
2.47.3


