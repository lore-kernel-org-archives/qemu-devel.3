Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC4DCAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimZ-0007BJ-CL; Fri, 19 Sep 2025 17:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimO-0006nG-L7
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimJ-0002ZF-MN
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:32 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpBY023221;
 Fri, 19 Sep 2025 21:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=lhwFn
 bShaPIWngv/XkYQcUXgzdetKoeJKMyrNGTKbA8=; b=LMwDcZrNIeDKWjBU+LNLW
 aN0Zjd7EU+0NAoZ/tGhkiDNHu2rQDZrSo01Mr1ngnSY9DpKEc87KuPborP500L+l
 /HPGcNGjg+VeHm8S9iVVm4+Vyv7QkrR/mAgtdHn++ihIluKHvOebdZ1Sgg8jT4pa
 mF18UzhBL9nFnSMyh5KVGkpYGGdmTK5gAD/hlLfiyIPW6bngN8I/mfIMy63nXWOJ
 JCc/0sTjYSnhflLyQrkvrfKu1tKT1nSlAqRhE/fcCcHXPjcZYDrjq1lLM+sjpox8
 xXCtnMa3yUedEUOCM0NDH7Ql2/Ap65BPkg1ALg0NRoRj78OCS8CodhYPmp5P+GPK
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JL5sv6033697; Fri, 19 Sep 2025 21:36:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0h004301;
 Fri, 19 Sep 2025 21:36:11 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-23; Fri, 19 Sep 2025 21:36:11 +0000
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
Subject: [PATCH v3 22/22] amd_iommu: HATDis/HATS=11 support
Date: Fri, 19 Sep 2025 21:35:15 +0000
Message-ID: <20250919213515.917111-23-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdcccd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mBIxkfzqmLV85dqxFSkA:9
X-Proofpoint-GUID: GalLXWYqOXf73jiUhXCvbvr_EHRRTsEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyJcPGgJ/0Tpu
 0KvQgkoThKSZHoahTwwCtboQ9FyboK7rufSuvZh08T+vCrnVkNoDsgK1qXyjzoHdCe9cXJy8+yh
 yzygFs/ivDa5YlTplbvYP5bREqfR5Bhj13Q5zM6jkfvPtLWxaPdBlyhVEfcriBkZLd2CtuD0Y1p
 qnxiLkyrvMwMzPizBktI1VP+F++6wRXkJu0aG11QxjsUBCFKcKZR/m6i5SEC9qSoetqdldPbYq6
 UAjjkhsGoBwTAdopw45VGaADSklBj1TP9w+nBBj/DvV7uRP34LszXkZQif6TBXX/L1wxWKT06jn
 TQhSNtYKkZkvkrqMcsY5QS9JDDx3s/8z2BnDSmps1EenxvDVV5DE+M0j99IZuaH2ISHDcRNfsxL
 vE1UB09J
X-Proofpoint-ORIG-GUID: GalLXWYqOXf73jiUhXCvbvr_EHRRTsEf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

From: Joao Martins <joao.m.martins@oracle.com>

Add a way to disable DMA translation support in AMD IOMMU by
allowing to set IVHD HATDis to 1, and exposing HATS (Host Address
Translation Size) as Reserved value.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/acpi-build.c |  6 +++++-
 hw/i386/amd_iommu.c  | 19 +++++++++++++++++++
 hw/i386/amd_iommu.h  |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 423c4959fe809..9446a9f862ca4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1863,7 +1863,11 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IOMMU info */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU Attributes */
-    build_append_int_noprefix(table_data, 0, 4);
+    if (!s->iommu.dma_translation) {
+        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     /* EFR Register Image */
     build_append_int_noprefix(table_data,
                               amdvi_extended_feature_register(s),
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b6851784fb9f1..378e0cb55eab6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -107,6 +107,9 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
     if (s->xtsup) {
         feature |= AMDVI_FEATURE_XT;
     }
+    if (!s->iommu.dma_translation) {
+        feature |= AMDVI_HATS_MODE_RESERVED;
+    }
 
     return feature;
 }
@@ -472,6 +475,9 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
+
+    uint64_t root;
+
     if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
         (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
         (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
@@ -482,6 +488,19 @@ static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
         return false;
     }
 
+    /*
+     * 1 = Host Address Translation is not supported. Value in MMIO Offset
+     * 0030h[HATS] is not meaningful. A non-zero host page table root pointer
+     * in the DTE would result in an ILLEGAL_DEV_TABLE_ENTRY event.
+     */
+    root = (dte[0] & AMDVI_DEV_PT_ROOT_MASK) >> 12;
+    if (root && !s->iommu.dma_translation) {
+        amdvi_log_illegaldevtab_error(s, devid,
+                                      s->devtab +
+                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
+        return false;
+    }
+
     return true;
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e1354686b6f03..daf82fc85f961 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -177,6 +177,7 @@
 /* AMDVI paging mode */
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
+#define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
 
 /* Page Table format */
 
-- 
2.43.5


