Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F543CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzild-00067s-04; Fri, 19 Sep 2025 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilb-000677-LV
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilZ-0002VC-Gy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu89L017342;
 Fri, 19 Sep 2025 21:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=e0XhY
 RcjNOv9dlHl2s1IooeLi/bMj0mmI0EDTOAuCUs=; b=CvZ5cHn2DnX2Tm9gWMtdt
 YlKXgXtSZGx3lUSpHAkJ3jhbWiJ0o503M7B8L5O0kwFvi3CrFSPCqbdN7WXeHqzr
 xTOp2elk3qxcFaT6GtegIFak9UCdLIyjqn7tyfQILzhE7s83EUEwledNhoFHJ+Wo
 Yz5rPyFBRrwiB93fXBP0R39nHh5wtyKY3HozzyzX15CeoIGWQSYKCV9P6QVbG7M7
 N2XphTP4tYd1oAC7T50UHyaumOihS1iialO+JGjy67c3E2e5c9wEsgWTv+/b6rDR
 IOX7AtlLG1aFwXHJSarQkmIBooCjeUjZZlF8Gh8+h18VSjEmvGy4ae7cbJs+iTzn
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kefyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JL5PaS033754; Fri, 19 Sep 2025 21:35:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm07004301;
 Fri, 19 Sep 2025 21:35:30 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-6; Fri, 19 Sep 2025 21:35:30 +0000
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
Subject: [PATCH v3 05/22] amd_iommu: Add helper function to extract the DTE
Date: Fri, 19 Sep 2025 21:34:58 +0000
Message-ID: <20250919213515.917111-6-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cdcca4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=e7RXMJMBNNZR3-p0WbYA:9
X-Proofpoint-GUID: jm5kqy_SuLfxZN275TQHxpF_57TXtKBH
X-Proofpoint-ORIG-GUID: jm5kqy_SuLfxZN275TQHxpF_57TXtKBH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX8zxgQHy8/ok8
 iDjQmqfQqhohJR3RYIaWrwEPXpNc/X6QzzfAfPCYA6Jt4ZfzvKEdd1a/MSof9lPDeKBXIxvU3fG
 Wf4MbF7TcisUYzty0N6xN1brzIkOXS8zEJwBO35/WckXI7OT3o/FcPUsr6PWQZr2TxybKUWC6AF
 zu071yGW9vMDZv5JFGGYyGdEVdIqI6KwIii9HY1gE8+zsnM76NbI/IyxohAEINrcXucQicfGBEI
 xJoBgQ2wIVVTlku6T/CPA67ThypeZxI+vo5TRRVprTSN1Tt+9uWgk+Adf/bKD7PVvRntdIjVEUf
 vIIsJhR+2zJcAnk0Vd/Sj7lGhBHw1Sz4D6zc+JANXQ6K2/jjXHDNa6rrptm73kP1ecLdY2WQpST
 jlu7VYC1
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

Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
common operation required for syncing the shadow page tables. Implement a
helper to do it and check for common error conditions.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 202f0f8c6e90c..dc7531fd4a8b9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -77,6 +77,18 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+/*
+ * These 'fault' reasons have an overloaded meaning since they are not only
+ * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
+ * IOMMU specification, but are also used to signal internal errors in the
+ * emulation code.
+ */
+typedef enum AMDVIFaultReason {
+    AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
+    AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
+    AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
+} AMDVIFaultReason;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -524,6 +536,28 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
     return pte;
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
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -1081,6 +1115,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
+    int dte_ret;
 
     if (iotlb_entry) {
         trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -1092,13 +1127,14 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
         return;
     }
 
-    if (!amdvi_get_dte(s, devid, entry)) {
-        return;
-    }
+    dte_ret = amdvi_as_to_dte(as, entry);
 
-    /* devices with V = 0 are not translated */
-    if (!(entry[0] & AMDVI_DEV_VALID)) {
-        goto out;
+    if (dte_ret < 0) {
+        if (dte_ret == -AMDVI_FR_DTE_V) {
+            /* DTE[V]=0, address is passed untranslated */
+            goto out;
+        }
+        return;
     }
 
     amdvi_page_walk(as, entry, ret,
-- 
2.43.5


