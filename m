Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A76C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx0-0003t1-PH; Thu, 01 May 2025 22:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwu-0003qn-JI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwr-0007Pf-IA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNhF024973;
 Fri, 2 May 2025 02:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=hpsuf
 gT5jNLYenP3VebynLEFuRx2pYt00pc+2Sm8wgY=; b=lexn2cH67Dt1GzPElN34V
 zArbXYbHmD2QTl9JJzvim6uJNB/Rac7priHR3YSIaIe7rAa1mVzNFmBPWyW/H1B3
 LsatjXophDgBPtl7Pn83zIWuoQEOpbNovdSOtK5lRKoVC95R1zf+wShux66UYm+g
 WZP7bflFGDF0K46hHi8UiGnnX3bz7vERZKdhi+ktsMQV2Gi2a0J6lufIjepeyYqJ
 vtFkj53lp2O5HSBu1GGze1c5tzrkf3YR1VCO9cBfI4LG57QrJ6o6kX7yoF5t0JlF
 Bzq8lWRBS6QvZtEM/CxCzETFead5aynz1/ovO2IopfpNgxvMPQ1Z1SCjzv084NEQ
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmcp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NlILP023907; Fri, 2 May 2025 02:16:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEs0011525;
 Fri, 2 May 2025 02:16:09 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-6; Fri, 02 May 2025 02:16:09 +0000
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
Subject: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
Date: Fri,  2 May 2025 02:15:50 +0000
Message-ID: <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: Z_neTDe7WxXAc2nqz9aMEh47JqN5stg5
X-Proofpoint-GUID: Z_neTDe7WxXAc2nqz9aMEh47JqN5stg5
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68142aec b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=e7RXMJMBNNZR3-p0WbYA:9 cc=ntf
 awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX6XC/Aco6TGIh
 B4HUMKUbFp3LzMBT6Pukjw8S+ImecTLSdJNqsWZfXWOvkRRZyyIn6x9g6fdRQk9NcUq5dBW7FcL
 edBYIEUBfbiiTlrJHQwDooPLkmG0W9ZA3sFVg8iGzt1HUo9/QPW2evCybs3vim9SowPOJ7RRmiy
 /XJIVX4tFsmy4yM16RePg7irlTQoiBPTRTHN55UDm0uoa/M9aNfFWJR+cYZJwHNileD2IPllHoG
 Xt744tXwZR73p1L09Zv+aZfKrClQTb0HRB71KD5GkgToRK2l9whTnMZWkipRORx2+jg+C84Gi4V
 jcXwSj8RjbUETXQ7tQ/mEDyhMGyqTb4pe0Z3xA2DXCChOZK1TLVBQMPNhCTKypPimQOVuJrjeTA
 SQTHj9IHbfgANhQ8eZbzDhEwSjaki0JN2B+9wBU0cohMtwdkbuN0Ryrr+8wnmjFB8Hp1SHKZ
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

Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
common operation required for syncing the shadow page tables. Implement a
helper to do it and check for common error conditions.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dff6f04c8651..5322a614f5d6 100644
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
@@ -492,6 +504,28 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
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
@@ -1024,6 +1058,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
+    int dte_ret;
 
     if (iotlb_entry) {
         trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -1035,13 +1070,13 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
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


