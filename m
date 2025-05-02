Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29079C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx6-0003vg-J5; Thu, 01 May 2025 22:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx5-0003ui-2A
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx2-0007Rn-5G
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54208641016913;
 Fri, 2 May 2025 02:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=SN4nf
 EL87DQOWsJXiUY5OwrVT2mpuVBirz/b+gLKWMs=; b=Y51j535ONCx5XQmm8RmLp
 VEsrfh6CMRuCHXCs5TeiOY7XoSRhwau58sFFPvTzUP9XWLhEVyb93a0Cv9E7orhp
 W8789EEC77GaSAkH4jkXIpqJRkCPcW7gg6wr0wpeeaZCCd8GPbQk6OZlsEPXpmee
 qNwC132E9KRAj1t6YcptCC6F2ZZM5mv4e2QoMtVz3TVF5Yf6mFi5q5HHzC1YvV9H
 1A4F2F7N05mzsXWyWlPreeajLwc9JRMD8/9CicxibRgMpm1ZKp9w/Kp1HVQJr2KU
 oVACoKaU5hMgHCcoZdGbMFEa+l4sn2/rdTuN9tyAl3PdolLTBhk79nPIHICzxlrj
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukvh2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54201glk023740; Fri, 2 May 2025 02:16:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEs4011525;
 Fri, 2 May 2025 02:16:11 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-8; Fri, 02 May 2025 02:16:11 +0000
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
Subject: [PATCH v2 07/20] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
Date: Fri,  2 May 2025 02:15:52 +0000
Message-ID: <20250502021605.1795985-8-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX4HoWoecBcEYK
 7b8stKwBVkRR4+6s9XWFFw6iwxA4oLb+o0Saib2FdtvtOSSIYrjJBZkSc8ZFbL/H3hRGEDNWj0m
 /kDeOicdvDRjCpg8/nGExxH5GVSNwA8X4iKJXphZN4GlrbqXy29Wexmtz/FOK4nfG4GG0ifoX5t
 4LCWANZAqalgXSCSnYV1gZYQ3QmOe9LD2n8He06m+Kkl796ZphQIf5P63zr6ZlMw1reXloDVZLS
 9wcmtAbshgJOguhKZOJyAoJZOM40R/wo0Z3MDdpFvXXy+oiP/Ht9uyF/AgWDyoG8QJ1KI6aTDjX
 iusftUo4NOY95hCtz9OoHfAPOzOC7F+009ouep05uBqWiLBhIuRFB3aMSXBvPjkPajiZ7ENYISn
 N7Qt1oDer2nz5BlV5Qij86TK3HY1Ylw5Xm4ErwLmrN62QdRKAqhdcjzoKxjdN4QDm/PR8d7y
X-Proofpoint-GUID: ylsWirsjMzQ-nwsTEX-ociJHENCglWlf
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68142af9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=hF7hyPbbb6ONIRq6hAgA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: ylsWirsjMzQ-nwsTEX-ociJHENCglWlf
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

The current amdvi_page_walk() is designed to be called by the replay()
method. Rather than drastically altering it, introduce helpers to fetch
guest PTEs that will be used by a page walker implementation.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  42 +++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 698967cc1a88..44bf8ebe303e 100644
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
@@ -526,6 +528,127 @@ static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
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
index 6f35b0595054..5e35d4b15167 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -25,6 +25,8 @@
 #include "hw/i386/x86-iommu.h"
 #include "qom/object.h"
 
+#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
+
 /* Capability registers */
 #define AMDVI_CAPAB_BAR_LOW           0x04
 #define AMDVI_CAPAB_BAR_HIGH          0x08
@@ -174,6 +176,46 @@
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


