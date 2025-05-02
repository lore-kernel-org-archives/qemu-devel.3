Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A333C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxM-00040L-Ln; Thu, 01 May 2025 22:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxJ-0003zg-N2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxH-0007U9-DQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeOI8009483;
 Fri, 2 May 2025 02:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fyxYM
 HrfaDaIXUg8jIVxI57JbzBE2c2IPZNAlkldBVM=; b=GHNRyoAL3thJwSXzrQ56+
 r3KS7AmJIYPuXiM+yNtjHLAboSGN6dNCvF5Ys6103RnKEZMbk7guRFuM1FcD/P0L
 fDIeWM9jOnK/TDkWvBVJ+J1WDejHWR7BqM68+o3WiZYEB9fXac4s3p4VrESKBlyk
 VGrgcRo5gA5glKCXHLCIZtaOb/QEvUDjJ4cde2H52Z4RmbV1f99JOgMIXu3tsdbf
 wJvTcX5zYjleleBskOLddnV03MmurzIyACUrmPxAnPN1P0U+1yYsUSrXp7jtnroc
 lLRDkoz8yjZKRmFxcfR6R4ojC7Dy+RPSTnzcGg+ly5EzptoaIOOlRKG2sBSxU+aP
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utcbqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NuN4W023769; Fri, 2 May 2025 02:16:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh04m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsU011525;
 Fri, 2 May 2025 02:16:20 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-21; Fri, 02 May 2025 02:16:20 +0000
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
Subject: [PATCH v2 20/20] amd_iommu: Refactor amdvi_page_walk() to use common
 code for page walk
Date: Fri,  2 May 2025 02:16:05 +0000
Message-ID: <20250502021605.1795985-21-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: vOeqr5Iz5DIhOtRbohipgXLinlwAcluU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX+bPl6Kpovm3j
 HNysKGQlOdAr5f/WRqVCE7xJurxcieXATA0qE2YtWXljAnjWWLehAHIZkjaB1KHmPsGgJWQs2SG
 nh2hUGVqrbSV2XShKcUiD/RNIN2F1hHM8A9bX64YfV4TzOjEX02QF/Rt5vIbWo9vNi9JTJfKT0g
 mnZEhDzCA7TI/UfieYuTwcz2nkXtGP9lcYyd70auv+5cTouVXB2wlkCq9YTLFay/WUqcO0q+Z7M
 bpN4zUYWo18Eb/Y38mxS/XQ7mfMeTFHDPrTWgPLpzCJM+J5jGV7Y1wedJ1fBgl589AYgJXS8E9O
 kjBH8GzlANkrRI6AKRg0iJlRRE4EsXN/Sw2xI4NqVbUJ7XoG6RP9OAJkS0ShANkS3a9XrEWPI6I
 oiA5vRQVAcsbPtRNBz9wBsoKq/Noe0OD1XRHjCdnkf10ylUVrWCUB2GYJS1140YKhl7f1bB2
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68142b04 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=vEuQwzgZqMseO_9XBp0A:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: vOeqr5Iz5DIhOtRbohipgXLinlwAcluU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Simplify amdvi_page_walk() by making it call the fetch_pte() helper that is
already in use by the shadow page synchronization code. Ensures all code
uses the same page table walking algorithm.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 59 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6d1e7cc65f83..ab236a8e016d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1608,11 +1608,13 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
 {
-    unsigned level, present, pte_perms, oldlevel;
-    uint64_t pte = dte[0], pte_addr, page_mask;
+    hwaddr page_mask, pagesize = 0;
+    uint8_t mode;
+    uint64_t pte;
+    int fetch_ret;
 
     /* make sure the DTE has TV = 1 */
-    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
         /*
          * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
          * An IOMMU processing a request that requires a table walk terminates
@@ -1623,42 +1625,35 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
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
+    fetch_ret = fetch_pte(as, addr, dte[0], &pte, &pagesize);
 
-    if (level == 0x7) {
-        page_mask = pte_override_page_mask(pte);
-    } else {
-        page_mask = pte_get_page_mask(oldlevel);
+    /*
+     * If walking the page table results in an error of any type, returns an
+     * empty PTE i.e. no mapping, or the permissions do not match, return since
+     * there is no translation available.
+     */
+    if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
+        perms != (perms & amdvi_get_perms(pte))) {
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
@@ -1670,7 +1665,7 @@ no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
     ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
-    ret->perm = amdvi_get_perms(pte);
+    ret->perm = amdvi_get_perms(dte[0]);
 }
 
 static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
-- 
2.43.5


