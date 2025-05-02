Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F658C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx2-0003tc-4z; Thu, 01 May 2025 22:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwv-0003rZ-Pd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwt-0007Pr-Fx
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5420LTB6021390;
 Fri, 2 May 2025 02:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=zoGe6
 YyEra8gRkKlb1MUbh2SB2o7LNCG7SXe9RaFZc4=; b=Qc67yLWOXsuB+wpy5UP19
 EiP1PVUs2xyf2kJnlF3d5kX3HTdMyNoprjdlzOF43+AOwOiRP9iHWLdt2bpTHq3p
 9KUBEVu0aMdYzcD2VOX2ThUE9apPADRY6MWupjQgYgJoPUAiw/UVtNov5XjHIvP7
 QYRw7CHh9UEe6eGeV9k3ILho+YtMM16FPW+W9N/RxoPgmXVFSRqQE7l5tNuYXxos
 WXd1ZR+Aw2SIaFWpiQl/11CtBbuwMV4uMoKtukrAscUXI3hhTJyC9+p6zzTYDLO3
 C2DbFA+nqKRr3MQ4ZbgRbH2oZ7AcHgY24RfVms1BEexVMBG2k/e3VkpewE1TYSi8
 Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqmdvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542006AD023886; Fri, 2 May 2025 02:16:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FErw011525;
 Fri, 2 May 2025 02:16:09 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-5; Fri, 02 May 2025 02:16:09 +0000
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
Subject: [PATCH v2 04/20] amd_iommu: Helper to decode size of page
 invalidation command
Date: Fri,  2 May 2025 02:15:49 +0000
Message-ID: <20250502021605.1795985-5-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: GYRyDCh9PFgfJeJQKMSsDFC-5aDdjm07
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=68142aeb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ZVecacK4M2hnvEF20eUA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: GYRyDCh9PFgfJeJQKMSsDFC-5aDdjm07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX8++b010sODFu
 QSvIGAuSYb8KKlWl2+s0EcUKUrkHt/0DkVhAEuBSRZQC1u/LGdTp0s7Pjv3ODYiFmyMyosqLaHX
 ZIqXIyvdg/w8zSCM6kukSD4hSXS+nOWVaikYyohCyxBCSMElV/2cl35Q3IlfrdDjCUbZOIoNAvU
 xNo6oQ2bWkVzEHrJIfvn9wKkbbxUhkfq9UFVXIfdCOd3NaaH0ZKvLnAIq7wvwzrAwBbqsEfZ+OE
 7PKp6JNJ/QtDfaH8mFol17gFMQv4jz2hWad4059TK3uiLKihH8wbJYgSTocsLyFi+3rCxkh5FvE
 FZDAJnYyxNYoHx3mf69yYiWdv9fRAPdQ6cjmUJBZSlmrX44XWZ+eAWNckr5BO1gIsgh3nOPnTUd
 1UUQ0flL0bzkZ1tYmNYYApB8rHoD+1EQJ9lU264Cx9o+fE/cezhfsFtH3xyX/kmmhPcm+Ro5
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

The size of the region to invalidate depends on the S bit and address
encoded in the command. Add a helper to extract this information, which
will be used to sync shadow page tables in upcoming changes.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9e500121f6e8..dff6f04c8651 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -545,6 +545,40 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
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
+        if (fzbit >= 51) {
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
index 28125130c6fc..6f35b0595054 100644
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


