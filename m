Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41183C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49B7-0007ML-AY; Sun, 13 Apr 2025 22:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Am-0007G4-Hb
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ak-0007TX-O0
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1r5tg030617;
 Mon, 14 Apr 2025 02:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=j30fF
 IkU7Sds0tsPNOs/tFyYJc49D1NNGzumNrG+mh0=; b=c2DTOdqW3Qm8MraOziO5l
 SpXPkGv0V1dFFPoVv919QVHcVzwlm4X0Dj6dmlYvDeBT7sGEf7UjEJeJ/6W3ZmMj
 ZmreAOGBluROTk4x37caDs3b2+wmFUcwnr9t3rdYaPlm5RiqytpNQ8Zz4xuipomx
 mwfd5o3dnS/Z36VgC4EeAx89h6TakFjVabh+yT+nQOsl5Pe+9XjIDdAjjnB1gwdS
 Z5e3dBCNGtbQmcH5kB93/0Ayv1D3yfCljcl6sNVeJjjhDVGYNj3lFbzaLb31cLOG
 2Z5jJk60Y2/5biq6UWKtFtEH/DePbTZZvMVm64zLkNveeZm7P/6TRrUX1KMgMrNx
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s2u007m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMMsqK009161; Mon, 14 Apr 2025 02:03:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYc035550;
 Mon, 14 Apr 2025 02:03:36 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-9; Mon, 14 Apr 2025 02:03:35 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 08/18] amd_iommu: Helper to decode size of page invalidation
 command
Date: Mon, 14 Apr 2025 02:02:43 +0000
Message-ID: <20250414020253.443831-9-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: voUDfiuXqmqOTCWP43fcSZU6gqrCGnAf
X-Proofpoint-ORIG-GUID: voUDfiuXqmqOTCWP43fcSZU6gqrCGnAf
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

The size of the region to invalidate depends on the S bit and address
encoded in the command. Add a helper to extract this information, which
will be used to sync shadow page tables in upcoming changes.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f55be1f4d36..0af873b66a31 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -481,6 +481,40 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
     return entry->domid == domid;
 }
 
+/*
+ * Helper to decode the size of the range to invalidate encoded in the
+ * INVALIDATE_IOMMU_PAGES Command format.
+ * The size of the region to invalidate depends on the S bit and address.
+ * S bit value:
+ * 0 :  Invalidation size is 4 Kbytes.
+ * 1 :  Invalidation size is determined by first zero bit in the address
+ *      starting from Address[12].
+ *
+ * In the AMD IOMMU Linux driver, an invalidation command with address
+ * ((1 << 63) - 1) is sent when intending to clear the entire cache.
+ * However, Table 14: Example Page Size Encodings shows that an address of
+ * ((1ULL << 51) - 1) encodes the entire cache, so effectively any address with
+ * first zero at bit 51 or larger is a request to invalidate the entire address
+ * space.
+ */
+static uint64_t __attribute__((unused))
+amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+{
+    uint64_t size = AMDVI_PAGE_SIZE;
+    uint8_t fzbit = 0;
+
+    if (flags & AMDVI_CMD_INVAL_IOMMU_PAGES_S) {
+        fzbit = cto64(addr | 0xFFF);
+
+        if (fzbit >= 51 || !addr) {
+            size = AMDVI_INV_ALL_PAGES;
+        } else {
+            size = 1ULL << (fzbit + 1);
+        }
+    }
+    return size;
+}
+
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e12ecade4baa..c89e7dc9947d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -123,6 +123,10 @@
 #define AMDVI_CMD_COMPLETE_PPR_REQUEST    0x07
 #define AMDVI_CMD_INVAL_AMDVI_ALL         0x08
 
+
+#define AMDVI_CMD_INVAL_IOMMU_PAGES_S   (1ULL << 0)
+#define AMDVI_INV_ALL_PAGES             (1ULL << 52)
+
 #define AMDVI_DEVTAB_ENTRY_SIZE           32
 
 /* Device table entry bits 0:63 */
-- 
2.43.5


