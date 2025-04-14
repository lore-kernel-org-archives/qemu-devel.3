Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E35FC369B1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BI-0007Qq-1W; Sun, 13 Apr 2025 22:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49BE-0007PN-SN
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49BC-0007Wy-Nj
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E0qEbu023913;
 Mon, 14 Apr 2025 02:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=iUJ9e
 z99+Boijf3xXqAMdXxEoVKdp9pojsBs+JJ6R2I=; b=gDCKWd8SWAzPPoWedNDPN
 PYCIHPba6N1OnJiH/7qm8817nscURiHaMufwt/HfRgzJUXO4UAfo7AwY35WWrYoY
 mn2RPWuLxEkgsXJLVxs/5Uz+57pDzo2qQ1+OM1dnU2bFE5o6MaTm64hE5FJa4Dsv
 z+XyFT3655b/J5OkmXhkWAO1cwMNJayhzLYlXC+n6zpgL7NGYZl92zx2xsjgky7m
 8+fv8u0B21D5qEnugjjFIEL23ibKsqWg7RTN6Tk0gIqCadQGV71nm7UhvjX1fGPc
 UxfDegfdxCttm46JjPpZnGtxlTO4Hvmiq/qsH63t4OdSNBk3zsRyS3pT6aLJh81W
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460r6qg1u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN495u009241; Mon, 14 Apr 2025 02:03:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYu035550;
 Mon, 14 Apr 2025 02:03:54 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-18; Mon, 14 Apr 2025 02:03:54 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 17/18] amd_iommu: Refactor amdvi_page_walk() to use common
 code for page walk
Date: Mon, 14 Apr 2025 02:02:52 +0000
Message-ID: <20250414020253.443831-18-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: 6q2g5vvagVcjINhKkclQdhnkoUVlUv9P
X-Proofpoint-ORIG-GUID: 6q2g5vvagVcjINhKkclQdhnkoUVlUv9P
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

Simplify amdvi_page_walk() by making it call the fetch_pte() helper that
is already in use by the shadow page synchronization code. Ensures all
code uses the same page table walking algorithm.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 60 +++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index edf2935f6a83..dc29a52bd845 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,8 @@ static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n);
 static void amdvi_address_space_sync(AMDVIAddressSpace *as);
 static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as);
 static void amdvi_notify_iommu(AMDVIAddressSpace *as, IOMMUTLBEvent *event);
+static uint64_t fetch_pte(AMDVIAddressSpace *as, const hwaddr address,
+                          uint64_t dte, hwaddr *page_size);
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
@@ -1217,11 +1219,12 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
 {
-    unsigned level, present, pte_perms, oldlevel;
-    uint64_t pte = dte[0], pte_addr, page_mask;
+    hwaddr page_mask, pagesize = 0;
+    uint8_t mode;
+    uint64_t pte;
 
     /* make sure the DTE has TV = 1 */
-    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
         /*
          * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
          * An IOMMU processing a request that requires a table walk terminates
@@ -1232,42 +1235,35 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
         return;
     }
 
-    level = get_pte_translation_mode(pte);
-    if (level >= 7) {
-        trace_amdvi_mode_invalid(level, addr);
+    mode = get_pte_translation_mode(dte[0]);
+    if (mode >= 7) {
+        trace_amdvi_mode_invalid(mode, addr);
         return;
     }
-    if (level == 0) {
+    if (mode == 0) {
         goto no_remap;
     }
 
-    /* we are at the leaf page table or page table encodes a huge page */
-    do {
-        pte_perms = amdvi_get_perms(pte);
-        present = pte & 1;
-        if (!present || perms != (perms & pte_perms)) {
-            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-            trace_amdvi_page_fault(addr);
-            return;
-        }
-        /* go to the next lower level */
-        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
-        /* add offset and load pte */
-        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
-        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-        if (!pte) {
-            return;
-        }
-        oldlevel = level;
-        level = get_pte_translation_mode(pte);
-    } while (level > 0 && level < 7);
+    /* Attempt to fetch the PTE to determine if a valid mapping exists */
+    pte = fetch_pte(as, addr, dte[0], &pagesize);
 
-    if (level == 0x7) {
-        page_mask = pte_override_page_mask(pte);
-    } else {
-        page_mask = pte_get_page_mask(oldlevel);
+    /*
+     * If walking the page table results in an error of any type, returns an
+     * empty PTE i.e. no mapping, or the permissions do not match, return since
+     * there is no translation available.
+     */
+    if ((pte == (uint64_t)-1) || (pte == (uint64_t)-2) ||
+        !IOMMU_PTE_PRESENT(pte) || perms != (perms & amdvi_get_perms(pte))) {
+
+        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        trace_amdvi_page_fault(addr);
+        return;
     }
 
+    /* A valid PTE and page size has been retrieved */
+    assert(pagesize);
+    page_mask = ~(pagesize - 1);
+
     /* get access permissions from pte */
     ret->iova = addr & page_mask;
     ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
@@ -1279,7 +1275,7 @@ no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
     ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
-    ret->perm = amdvi_get_perms(pte);
+    ret->perm = amdvi_get_perms(dte[0]);
 }
 
 static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
-- 
2.43.5


