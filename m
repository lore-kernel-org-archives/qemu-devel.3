Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8386CCAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimZ-0007BI-C1; Fri, 19 Sep 2025 17:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimQ-0006o0-3Q
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimG-0002Yo-Qc
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu1cI015975;
 Fri, 19 Sep 2025 21:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=+aiwh
 hG1JB6G3vVDnqra1hRV04eDp+etk9ZO8JJwgpw=; b=JLk+pr+yWWWfDGfovcOPk
 6n6TjaJ/jtA0ekI5M8qlmJCdcRhkVUshlxkcHv9NgViPV9xxRohZkM/jGVDJtiwb
 Hp785n6BaD/mIF6et72m8KY27CJci55xLEL3MZbuK8ieWUX8X04HaomZx/azb6JA
 YKuozFgjpaybAsxUdpYlh0lpAO5VuUpGU2tJUXK4m0iDz0lXb3p4TrXhDqBZbRw4
 hG5QTMq2hDNkTXwwPaYyXsCsK15mhNj7JQguPy5j2uKxn9++CJPQEMqJoualKh+b
 NDb6+rL+x0XyyyzAx3AHsyPROD1TzwHuVLt8h9IUCKZj8Swb67rIGM5jqOi3tvfl
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx96b6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JJL6FY033686; Fri, 19 Sep 2025 21:36:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0d004301;
 Fri, 19 Sep 2025 21:36:06 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-21; Fri, 19 Sep 2025 21:36:06 +0000
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
Subject: [PATCH v3 20/22] amd_iommu: Refactor amdvi_page_walk() to use common
 code for page walk
Date: Fri, 19 Sep 2025 21:35:13 +0000
Message-ID: <20250919213515.917111-21-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: DrL4KKJbdO6hEI9GFMJ5Wj4rY_Fdq7C3
X-Proofpoint-GUID: DrL4KKJbdO6hEI9GFMJ5Wj4rY_Fdq7C3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0VnVDMVAuXkB
 L7CaEBz0aNC+3s9ncoQZRwTu8fOuacAY5hiv8MRUu4pBc8mhCzEMGmT0fJ+ibFa0V990RJmPxll
 9KpHmGxCQH6wXHccP9q2wd5M/uCWxftc0ayOujlypiADkXUtP5ddKeQQWKtXtOn3Au7Or1YDkGa
 5eN6cvG/pBxksA2JsiT7yqLEvGdxa0ZpUPgG0gGWHZaSEsDYjpDR+qIbDNXa64+kWfoMpd7j1PF
 JUSWKyrQoC7ynH1rDCZcCpSTTPBUYnFCOB8O0JqzpYzylxzUS+cYeSu1H+5XztdKQhIw9ACwD8P
 7Fx50qM2hIQJIzEdGx9pub+Wyz7vtqnbBNjgv5bB5N49GuHFVFxPqdEGsFBuqwUHhc7l5j51qPJ
 wLmBeqON
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cdccc8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=P9DecepiNGKYXCLT5xAA:9
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

Simplify amdvi_page_walk() by making it call the fetch_pte() helper that is
already in use by the shadow page synchronization code. Ensures all code
uses the same page table walking algorithm.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 77 ++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1bda2a8ac3a16..b6851784fb9f1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -513,24 +513,6 @@ static inline uint8_t get_pte_translation_mode(uint64_t pte)
     return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
 }
 
-static inline uint64_t pte_override_page_mask(uint64_t pte)
-{
-    uint8_t page_mask = 13;
-    uint64_t addr = (pte & AMDVI_DEV_PT_ROOT_MASK) >> 12;
-    /* find the first zero bit */
-    while (addr & 1) {
-        page_mask++;
-        addr = addr >> 1;
-    }
-
-    return ~((1ULL << page_mask) - 1);
-}
-
-static inline uint64_t pte_get_page_mask(uint64_t oldlevel)
-{
-    return ~((1UL << ((oldlevel * 9) + 3)) - 1);
-}
-
 static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
                                           uint16_t devid)
 {
@@ -1718,11 +1700,13 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
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
@@ -1733,42 +1717,35 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
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
@@ -1780,7 +1757,7 @@ no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
     ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
-    ret->perm = amdvi_get_perms(pte);
+    ret->perm = amdvi_get_perms(dte[0]);
 }
 
 static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
-- 
2.43.5


