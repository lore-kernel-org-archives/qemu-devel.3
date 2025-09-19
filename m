Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DAECAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilZ-00066h-TC; Fri, 19 Sep 2025 17:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilW-000668-3L
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilT-0002UI-9V
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuOCs016253;
 Fri, 19 Sep 2025 21:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=c2FBO
 GCcoJOLI5lrT3kA7lby0VnEzUrqfSXmqrxIKI0=; b=AQpoXGNZOc7qPaxKRCike
 Zo7VVs8SDmQNyi0LUO3CUgZ99S1MbayA3LS25mYhR9MIOmajAxpQvKJ0kjXWiXZM
 zatpGfxJwD6ZoSN94w9XQvDDrgLD3Jbbn54VxXcNa73ruOFujKv2VP34bGiNwEau
 2zAywqgCeqPvCerrk9P/YqMjEsqMOanuHhoygVcocg8eCT/xvI4ygl7Vq7K09at3
 kYIj0A/JpwSrjQ+EkxpSB0cUTXdYCxiGJoUu39mexxIJep29XXaMu5nepqfIj7Fk
 XW3IJja7OJNk/UEDWfuUJNxSB26UuEJvxM/gCxxhf2o+xOAldsaBhP2PszSs/Do+
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbxdpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JJ7uBO033664; Fri, 19 Sep 2025 21:35:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm03004301;
 Fri, 19 Sep 2025 21:35:25 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-4; Fri, 19 Sep 2025 21:35:25 +0000
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
Subject: [PATCH v3 03/22] amd_iommu: Reorder device and page table helpers
Date: Fri, 19 Sep 2025 21:34:56 +0000
Message-ID: <20250919213515.917111-4-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/DxYrFiEMSyJ
 TbbAOL9QM55f4izovr31kzSNhHLXQ54fSoomXguRSQI01NskG9mo+er+vYF97HGzPSuFh5okp33
 dhU21jLvz41MBRsK1zYHDMYq4Jw8XUSVYb0RvcI8QsFNBIiQIfCqFkeV+k02mzxcPpyke4fmCKB
 almm/msM56cq8vjTAASrxuHle5VtOZbmKFwEbytzLSn/492zg048MjgUb6l9zf66JNS/ZQbtmdW
 1jIhUz2wj2gCo4dKp1CZoF1b28Mm6FsW1ra5j1mx+g/ezrKSBaTRUmp10h0NtfwxkRPblVSyC0B
 F5KZnfcgZRRtyF6RQ9vbkTok7FxQxEKZN/h5XKExspIgwGVtDLbniQmvfuhb2KPWPrparEGLHtO
 1CYfnwck
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cdcc9f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=0jG7Jb7pV4afCPoZSdkA:9
X-Proofpoint-GUID: nMrUBNC_TwMRoI-ht1AsXX___mYJOisC
X-Proofpoint-ORIG-GUID: nMrUBNC_TwMRoI-ht1AsXX___mYJOisC
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

Move code related to Device Table and Page Table to an earlier location in
the file, where it does not require forward declarations to be used by the
various invalidation functions that will need to query the DTE and walk the
page table in upcoming changes.

This change consist of code movement only, no functional change intended.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 26be69bec8ae2..3cbc9499dbcc4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -438,6 +438,92 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
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
+    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
+        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
+        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
+        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
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
@@ -894,92 +980,6 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
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
-    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
-        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
-        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
-        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
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


