Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B9C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Az-0007Kc-BA; Sun, 13 Apr 2025 22:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ad-0007Bs-V8
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Aa-0007Rm-V3
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E17FGQ023052;
 Mon, 14 Apr 2025 02:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=V74bm
 L9CMwDa0wwOC20sFxxLON0lXsj1ROpKv4Q/Z9s=; b=Ul1b3lX8ExizAzOeIBD0n
 j+5MPBOvAq+vw+ZXwNbRahBszlLncGdJGGc2gObiQB33wuudYd+s8yOi6LNcJxSY
 cpHt5azRMQeraI2nCEmsG7huTT6xrBGvHv0qYo4qTybknVdyJz+g0qS8pn6j/LRX
 GbJJZAE0vaLoX92I3a2y0LmSjQKQiKqKm1OOyrTqUAx3EqpNkJxQ2v8urEihyOHP
 PXzUTQYr7NyfiShPoiM+SX7maC5CudMeVqOXiwHEX4DdaVW+EFsz1Z4QFXZQFnD6
 tNzsOgTOoUSRR9BW+fZNptJqQMeT3pvKBMKfvhsA3bcFD3y58XtxhsxZuX9S+Su8
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460rdr01f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN4AcV009180; Mon, 14 Apr 2025 02:03:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYQ035550;
 Mon, 14 Apr 2025 02:03:24 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-3; Mon, 14 Apr 2025 02:03:23 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 02/18] amd_iommu: Add helper function to extract the DTE
Date: Mon, 14 Apr 2025 02:02:37 +0000
Message-ID: <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: UukwAsRtPuPOJVQQ-kY-FbcDfuy85k60
X-Proofpoint-ORIG-GUID: UukwAsRtPuPOJVQQ-kY-FbcDfuy85k60
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

Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
common operation required for syncing the shadow page tables. Implement a
helper to do it and check for common error conditions.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f9b95279997..22d648c2e0e3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -77,6 +77,20 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+/*
+ * These 'fault' reasons have an overloaded meaning since they are not only
+ * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
+ * IOMMU specification, but are also used to signal internal errors in the
+ * emulation code.
+ */
+typedef enum AMDVIFaultReason {
+    AMDVI_FR_DTE_RTR_ERR = 1,           /* Failure to retrieve DTE */
+    AMDVI_FR_DTE_V,                     /* DTE[V] = 0 */
+    AMDVI_FR_DTE_TV,                    /* DTE[TV] = 0 */
+} AMDVIFaultReason;
+
+static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -882,6 +896,28 @@ static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
     return true;
 }
 
+static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
+{
+    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    AMDVIState *s = as->iommu_state;
+
+    if (!amdvi_get_dte(s, devid, dte)) {
+        /* Unable to retrieve DTE for devid */
+        return -AMDVI_FR_DTE_RTR_ERR;
+    }
+
+    if (!(dte[0] & AMDVI_DEV_VALID)) {
+        /* DTE[V] not set, address is passed untranslated for devid */
+        return -AMDVI_FR_DTE_V;
+    }
+
+    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
+        /* DTE[TV] not set, host page table not valid for devid */
+        return -AMDVI_FR_DTE_TV;
+    }
+    return 0;
+}
+
 /* get pte translation mode */
 static inline uint8_t get_pte_translation_mode(uint64_t pte)
 {
@@ -990,6 +1026,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
+    int dte_ret;
 
     if (iotlb_entry) {
         trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -1001,13 +1038,13 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
         return;
     }
 
-    if (!amdvi_get_dte(s, devid, entry)) {
-        return;
-    }
+    dte_ret = amdvi_as_to_dte(as, entry);
 
-    /* devices with V = 0 are not translated */
-    if (!(entry[0] & AMDVI_DEV_VALID)) {
+    if (dte_ret == -AMDVI_FR_DTE_V) {
+        /* DTE[V]=0, address is passed untranslated */
         goto out;
+    } else if (dte_ret == -AMDVI_FR_DTE_TV) {
+        return;
     }
 
     amdvi_page_walk(as, entry, ret,
-- 
2.43.5


