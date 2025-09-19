Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27737CAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzile-000683-0H; Fri, 19 Sep 2025 17:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilc-00067O-8e
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilW-0002Uj-MX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtocw016596;
 Fri, 19 Sep 2025 21:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=lWTXc
 PDkzvOTy2E4xjFLqSMtjw16XmwocuiKRJX1u1o=; b=bGwritF65P/3BzRkRjTf1
 /C4gZSWvH/Jm6SZFxhSdK/qY5P4P6KEbi2rt2cZyFb3RuKQ56Aa2CzClFc8IRfCp
 nGo5YK7xB/hzxeA69ZYHPm+HINQvknTqwj9g+iw6PcUvrm4/VPcjymaYvj65R/as
 ZCcueyKXndPofOE/TuwR6CnMqYlFNOtlJ6MuPBgVfZiTmnd0HWBpGl3fXot770le
 W5TqftIauGSMJ8RWKF/eAbLtfAnrwzq8dgbg4S+aqSHwDgy3jIZv+3cSCBU4Wqjo
 kxivuqy2MQVgs+D2K5jcTjpgre6mIOyx7jkcZ1D3ho+s7ibwmhRLjHVfp+eeacZn
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kefyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JIxjoV033667; Fri, 19 Sep 2025 21:35:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm05004301;
 Fri, 19 Sep 2025 21:35:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-5; Fri, 19 Sep 2025 21:35:28 +0000
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
Subject: [PATCH v3 04/22] amd_iommu: Helper to decode size of page
 invalidation command
Date: Fri, 19 Sep 2025 21:34:57 +0000
Message-ID: <20250919213515.917111-5-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cdcca1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=ZVecacK4M2hnvEF20eUA:9
X-Proofpoint-GUID: btv3tGqiRoglQaD-k5j1S01KJeATnkFN
X-Proofpoint-ORIG-GUID: btv3tGqiRoglQaD-k5j1S01KJeATnkFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX0xUqhg+zWcj0
 ETzPAGQpvRt5LfaEgpwhMjIiNqDTiZU/TsV8u3hcxFguqqa8q/QXYpSTRs4ABBvYOAe5dhN7nxe
 IKRji58fOIjQb3X4DV1rnryPYgiXopLn2qI1weO0nQ7Ab89aJjI9uTcfTkGjocOws7v58U63OSr
 K4fE0iaNQXKqi6r1oUBbqrGHovNe4oWfSSBYLzCGp1tbRp5bAFFc0Aqy1WtLMeAcUZ81IB2Efcn
 PoaKZQhQcFSUJdngcLjO938MvmmoQe1WNnP5N2lMC1ZUrPelWWiRTNgL75KMiG5EtVlXPJgGBUC
 4xrM5xhi+VCOkm9t5mvlfahxzWLFKrjyPKE+u21gCryXEQY9JeJo9Mhb1NFFht9N/ib9RzEzzAV
 i17j3Rl2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 3cbc9499dbcc4..202f0f8c6e90c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -577,6 +577,40 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
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
index 2476296c49023..c1170a820257e 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -126,6 +126,10 @@
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


