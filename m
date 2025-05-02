Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0355AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfwz-0003sB-9u; Thu, 01 May 2025 22:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwt-0003qj-Or
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwp-0007Or-JY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:22 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNeN007190;
 Fri, 2 May 2025 02:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=LtWIZ
 F24E+i84J6YfKEXoe8ultBSd8eCMI+sgD0k6Xo=; b=Mhri1f+negInTMvtshv/+
 cg2WsSg6bVYYbQiPwgL1PWW3AlTmLYwAS/FRfldNRzJeg15xqaCxiLTik2Rdx62H
 Vd/UbQ5GPiniYxqeCbtKo2zmW3fR3JsehxQzFZToiA2F4KAGdZuPCUNeAfafZ9dR
 6Cp2tHoknGwzrizqvPll1d9Htar66KvCaT+6mXz/CJZIZaSTwtlF0cBihu2EtgWv
 ivzUe8AznUVLR7XgJiZ1LpluZaSFnpd5ezRMdWcG+Qa003WLIcfqBsk5TcEEKvH1
 7vZKCsbR+MYwRfaeP0bJrzhaG5g0Dwx9SBJC+bTn7xxapTpItvUGApckxjtr1qCd
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucmdv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NPfWf023782; Fri, 2 May 2025 02:16:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEru011525;
 Fri, 2 May 2025 02:16:08 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-4; Fri, 02 May 2025 02:16:08 +0000
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
Subject: [PATCH v2 03/20] amd_iommu: Reorder device and page table helpers
Date: Fri,  2 May 2025 02:15:48 +0000
Message-ID: <20250502021605.1795985-4-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68142ae9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=0jG7Jb7pV4afCPoZSdkA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: uf7D6vXjx7kY4SMJgYlcC84WTsIB_sIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfXwD8IVsv8rg21
 rdRLAiyX9WEkWzNfErAGfIA2H+ox2E4tkEFJN97jVz4wdYgP/ptPdtP27lYfRhVCjphFSKrO2lN
 wWhP36HuvTmsF/m3cLO1cRMFBw3oBbFs2mvePWrudBEAOQhOAKC63JlcaIZ3CnnMuPApiCEju1o
 GsvWlHeroZOHxLCjJLMESVHzBx+WFtmLEwfg+O1+leYGyn2IhpC5ySbkkhCFTkelau2IJePZRpX
 OwgE/hiyqEiJg3OTb0t+HZHw25Fx8rKkISQ7v6OMxBEmqyzihQUKhvY3E/lcMXX8VjVLZYV8NTE
 coGwYg1t9+vx8dHRKbjXbvSf0QXQjCXUSrz1Uupv1qLD6YuVg1tpeK9sbijjqc5Ml9D0NtViZ12
 u1a3w33OcQGOaOoKnFLAEHyeEBZXnbzFQ8gKxOiaq1Q9NQOy9W+JeeffywWTHNvUC4/KlImm
X-Proofpoint-GUID: uf7D6vXjx7kY4SMJgYlcC84WTsIB_sIH
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

Move code related to Device Table and Page Table to an earlier location in
the file, where it does not require forward declarations to be used by the
various invalidation functions that will need to query the DTE and walk the
page table in upcoming changes.

This change consist of code movement only, no functional change intended.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 170 ++++++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2cf7e24a21d8..9e500121f6e8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -407,6 +407,91 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
     trace_amdvi_completion_wait(addr, data);
 }
 
+static inline uint64_t amdvi_get_perms(uint64_t entry)
+{
+    return (entry & (AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE)) >>
+           AMDVI_DEV_PERM_SHIFT;
+}
+
+/* validate that reserved bits are honoured */
+static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
+                               uint64_t *dte)
+{
+    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
+        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
+        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
+        amdvi_log_illegaldevtab_error(s, devid,
+                                      s->devtab +
+                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
+        return false;
+    }
+
+    return true;
+}
+
+/* get a device table entry given the devid */
+static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
+{
+    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
+
+    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
+                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
+        trace_amdvi_dte_get_fail(s->devtab, offset);
+        /* log error accessing dte */
+        amdvi_log_devtab_error(s, devid, s->devtab + offset, 0);
+        return false;
+    }
+
+    *entry = le64_to_cpu(*entry);
+    if (!amdvi_validate_dte(s, devid, entry)) {
+        trace_amdvi_invalid_dte(entry[0]);
+        return false;
+    }
+
+    return true;
+}
+
+/* get pte translation mode */
+static inline uint8_t get_pte_translation_mode(uint64_t pte)
+{
+    return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
+}
+
+static inline uint64_t pte_override_page_mask(uint64_t pte)
+{
+    uint8_t page_mask = 13;
+    uint64_t addr = (pte & AMDVI_DEV_PT_ROOT_MASK) >> 12;
+    /* find the first zero bit */
+    while (addr & 1) {
+        page_mask++;
+        addr = addr >> 1;
+    }
+
+    return ~((1ULL << page_mask) - 1);
+}
+
+static inline uint64_t pte_get_page_mask(uint64_t oldlevel)
+{
+    return ~((1UL << ((oldlevel * 9) + 3)) - 1);
+}
+
+static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
+                                          uint16_t devid)
+{
+    uint64_t pte;
+
+    if (dma_memory_read(&address_space_memory, pte_addr,
+                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
+        trace_amdvi_get_pte_hwerror(pte_addr);
+        amdvi_log_pagetab_error(s, devid, pte_addr, 0);
+        pte = 0;
+        return pte;
+    }
+
+    pte = le64_to_cpu(pte);
+    return pte;
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -838,91 +923,6 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
-static inline uint64_t amdvi_get_perms(uint64_t entry)
-{
-    return (entry & (AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE)) >>
-           AMDVI_DEV_PERM_SHIFT;
-}
-
-/* validate that reserved bits are honoured */
-static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
-                               uint64_t *dte)
-{
-    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
-        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
-        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
-        amdvi_log_illegaldevtab_error(s, devid,
-                                      s->devtab +
-                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
-        return false;
-    }
-
-    return true;
-}
-
-/* get a device table entry given the devid */
-static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
-{
-    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
-
-    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
-                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
-        trace_amdvi_dte_get_fail(s->devtab, offset);
-        /* log error accessing dte */
-        amdvi_log_devtab_error(s, devid, s->devtab + offset, 0);
-        return false;
-    }
-
-    *entry = le64_to_cpu(*entry);
-    if (!amdvi_validate_dte(s, devid, entry)) {
-        trace_amdvi_invalid_dte(entry[0]);
-        return false;
-    }
-
-    return true;
-}
-
-/* get pte translation mode */
-static inline uint8_t get_pte_translation_mode(uint64_t pte)
-{
-    return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
-}
-
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
-static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
-                                          uint16_t devid)
-{
-    uint64_t pte;
-
-    if (dma_memory_read(&address_space_memory, pte_addr,
-                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
-        trace_amdvi_get_pte_hwerror(pte_addr);
-        amdvi_log_pagetab_error(s, devid, pte_addr, 0);
-        pte = 0;
-        return pte;
-    }
-
-    pte = le64_to_cpu(pte);
-    return pte;
-}
-
 static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
-- 
2.43.5


