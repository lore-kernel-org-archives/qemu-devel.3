Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5B3CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilw-0006BQ-EQ; Fri, 19 Sep 2025 17:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilp-00069t-AX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilf-0002Vy-BL
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpPk008956;
 Fri, 19 Sep 2025 21:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=1x9Vi
 IrSLY26EWMCK3ttmdPzLZtGc5KqMXfUlwdKuDI=; b=c1xrWNGHra5b9uGd1W2Pq
 UtEc7EmPOxCDWR4ar+P34p42NN609OJNVM2tVFxPzaiG9gUvCyhlnCTt3LpoMWQV
 mnItaQC0cJQ7EQGpN69EHSNS+aAmt73w6Ou3oJHa1ce3FRN0CIz8VU/52ihzWKyI
 E/BZAu6aqER+L4vLueM/Hs91uRbwdA+OqIzvR2HUr/kc7L/xxrXEn3tGe1iGC5OP
 mP/WsKJ/0U1Izmuno8KB5B7U8rjFCwuvi76cgEoqKKUnwNcZJPPGnu5M0ywlvuPI
 bO3tTsUUFW2K7xdfHoUY1m9ayGrTvM5um28JBAgGiU3FL0gdJh17d24D/6Hkf7wd
 A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb6cea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JItLGn033730; Fri, 19 Sep 2025 21:35:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:36 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0B004301;
 Fri, 19 Sep 2025 21:35:35 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-8; Fri, 19 Sep 2025 21:35:35 +0000
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
Subject: [PATCH v3 07/22] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
Date: Fri, 19 Sep 2025 21:35:00 +0000
Message-ID: <20250919213515.917111-8-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7vdbsDOJK4DC
 y6DvnrJq0oeJPxS2DWdDszbxRqayrC93smgDVy528StF2nsxSyyhSxEQbI/cQxW6eekSvohPz0m
 Y0+Fpy2H3KWt7vrfREgdSlvaPZSC1NytDR1tCxtSORUVcCyBkhXkeL68k1K1twb1PeTsPlzcOEc
 EHzDOaJtKhoooOfTJAzqhCcoURacfnx4GkR/GRETsDcP/G6NxaKkpj4QbmzpF0Kp1/vcF/oRwta
 rsp6zutcz6f9RKbJQZt8hrEZqX+mSG2871AueCGgPA/1Rlr3qekjTxQS2DjhvXkxulrybgeshJM
 H16Gm6b3qzbVqCN8XS6EaxxPJVOzCblkVXdAZOZnLh/MP9gWyZf3/FIkRPvLATsOXfcFJk8K3Xj
 OkdKhbyd
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cdcca9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=hF7hyPbbb6ONIRq6hAgA:9
X-Proofpoint-GUID: viSq62804NmVzXsbeSESkmzt9Refcaor
X-Proofpoint-ORIG-GUID: viSq62804NmVzXsbeSESkmzt9Refcaor
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current amdvi_page_walk() is designed to be called by the replay()
method. Rather than drastically altering it, introduce helpers to fetch
guest PTEs that will be used by a page walker implementation.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  40 ++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 29ed3f0ef292e..c25981ff93c02 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -87,6 +87,8 @@ typedef enum AMDVIFaultReason {
     AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
     AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
     AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
+    AMDVI_FR_PT_ROOT_INV,       /* Page Table Root ptr invalid */
+    AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
 } AMDVIFaultReason;
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
@@ -558,6 +560,127 @@ static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
     return 0;
 }
 
+/*
+ * For a PTE encoding a large page, return the page size it encodes as described
+ * by the AMD IOMMU Specification Table 14: Example Page Size Encodings.
+ * No need to adjust the value of the PTE to point to the first PTE in the large
+ * page since the encoding guarantees all "base" PTEs in the large page are the
+ * same.
+ */
+static uint64_t large_pte_page_size(uint64_t pte)
+{
+    assert(PTE_NEXT_LEVEL(pte) == 7);
+
+    /* Determine size of the large/contiguous page encoded in the PTE */
+    return PTE_LARGE_PAGE_SIZE(pte);
+}
+
+/*
+ * Helper function to fetch a PTE using AMD v1 pgtable format.
+ * On successful page walk, returns 0 and pte parameter points to a valid PTE.
+ * On failure, returns:
+ * -AMDVI_FR_PT_ROOT_INV: A page walk is not possible due to conditions like DTE
+ *      with invalid permissions, Page Table Root can not be read from DTE, or a
+ *      larger IOVA than supported by page table level encoded in DTE[Mode].
+ * -AMDVI_FR_PT_ENTRY_INV: A PTE could not be read from guest memory during a
+ *      page table walk. This means that the DTE has valid data, but one of the
+ *      lower level entries in the Page Table could not be read.
+ */
+static int __attribute__((unused))
+fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
+          hwaddr *page_size)
+{
+    IOMMUAccessFlags perms = amdvi_get_perms(dte);
+
+    uint8_t level, mode;
+    uint64_t pte_addr;
+
+    *pte = dte;
+    *page_size = 0;
+
+    if (perms == IOMMU_NONE) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /*
+     * The Linux kernel driver initializes the default mode to 3, corresponding
+     * to a 39-bit GPA space, where each entry in the pagetable translates to a
+     * 1GB (2^30) page size.
+     */
+    level = mode = get_pte_translation_mode(dte);
+    assert(mode > 0 && mode < 7);
+
+    /*
+     * If IOVA is larger than the max supported by the current pgtable level,
+     * there is nothing to do.
+     */
+    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
+        /* IOVA too large for the current DTE */
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    do {
+        level -= 1;
+
+        /* Update the page_size */
+        *page_size = PTE_LEVEL_PAGE_SIZE(level);
+
+        /* Permission bits are ANDed at every level, including the DTE */
+        perms &= amdvi_get_perms(*pte);
+        if (perms == IOMMU_NONE) {
+            return 0;
+        }
+
+        /* Not Present */
+        if (!IOMMU_PTE_PRESENT(*pte)) {
+            return 0;
+        }
+
+        /* Large or Leaf PTE found */
+        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
+            /* Leaf PTE found */
+            break;
+        }
+
+        /*
+         * Index the pgtable using the IOVA bits corresponding to current level
+         * and walk down to the lower level.
+         */
+        pte_addr = NEXT_PTE_ADDR(*pte, level, address);
+        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+
+        if (*pte == (uint64_t)-1) {
+            /*
+             * A returned PTE of -1 indicates a failure to read the page table
+             * entry from guest memory.
+             */
+            if (level == mode - 1) {
+                /* Failure to retrieve the Page Table from Root Pointer */
+                *page_size = 0;
+                return -AMDVI_FR_PT_ROOT_INV;
+            } else {
+                /* Failure to read PTE. Page walk skips a page_size chunk */
+                return -AMDVI_FR_PT_ENTRY_INV;
+            }
+        }
+    } while (level > 0);
+
+    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
+           level == 0);
+    /*
+     * Page walk ends when Next Level field on PTE shows that either a leaf PTE
+     * or a series of large PTEs have been reached. In the latter case, even if
+     * the range starts in the middle of a contiguous page, the returned PTE
+     * must be the first PTE of the series.
+     */
+    if (PTE_NEXT_LEVEL(*pte) == 7) {
+        /* Update page_size with the large PTE page size */
+        *page_size = large_pte_page_size(*pte);
+    }
+
+    return 0;
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c1170a820257e..9f833b297d25c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -178,6 +178,46 @@
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 
+/* Page Table format */
+
+#define AMDVI_PTE_PR                    (1ULL << 0)
+#define AMDVI_PTE_NEXT_LEVEL_MASK       GENMASK64(11, 9)
+
+#define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
+
+/* Using level=0 for leaf PTE at 4K page size */
+#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
+
+/* Return IOVA bit group used to index the Page Table at specific level */
+#define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
+                                        GENMASK64(8, 0))
+
+/* Return the max address for a specified level i.e. max_oaddr */
+#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
+                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
+                                (~(0ULL)))
+
+/* Extract the NextLevel field from PTE/PDE */
+#define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
+
+/* Take page table level and return default pagetable size for level */
+#define PTE_LEVEL_PAGE_SIZE(level)      (1ULL << (PT_LEVEL_SHIFT(level)))
+
+/*
+ * Return address of lower level page table encoded in PTE and specified by
+ * current level and corresponding IOVA bit group at such level.
+ */
+#define NEXT_PTE_ADDR(pte, level, iova) (((pte) & AMDVI_DEV_PT_ROOT_MASK) + \
+                                        (PT_LEVEL_INDEX(level, iova) * 8))
+
+/*
+ * Take a PTE value with mode=0x07 and return the page size it encodes.
+ */
+#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+
+/* Return number of PTEs to use for a given page size (expected power of 2) */
+#define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
+
 /* IOTLB */
 #define AMDVI_IOTLB_MAX_SIZE 1024
 #define AMDVI_DEVID_SHIFT    36
-- 
2.43.5


