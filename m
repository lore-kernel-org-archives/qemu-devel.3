Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32311C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Tt-0001ar-8l; Tue, 11 Mar 2025 11:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Ti-0001RM-LE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Td-0007aW-7y
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:10 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMvXj015001;
 Tue, 11 Mar 2025 15:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=12BMq
 D/O3Ej6AFH81/p+Tpm2W8PJI1g9VFqbfmu1C1k=; b=f/NiyuY9IC+stiMRZx6jt
 BFMOfz08PhdvRaBU5Xd0iilJ6oqWCdV8aCXk7l9+5KPOC0AkZ9MRJLTfowV2aLrV
 x7pggbSzOmbmbAc3bBAP6od9Vl2WAxFDegV39hoK9nRjqUV8RFmEaEVrQ1AzgvNJ
 nKIVn9Oc1FWELUpKQl/tq0hWswhgf+3F+QCwSqiDY8Tp6BTiD29PYCIdBv2/DF77
 m4Jjrps9y/VwTa8bp1sej1YCHdymxRvlJ/aJCQdX6UDB+qA2usRkXMZCQq6MwcUh
 ABC30mQGUyPz4o25j69D32wUWoTX6eIYUUtrUpd/ksDpn59Z40qzdhGraW6/o51E
 g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb56mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:25:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BEAF7K019961; Tue, 11 Mar 2025 15:24:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 458cbfqnqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:24:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BFMCs7035998;
 Tue, 11 Mar 2025 15:24:58 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 458cbfqngj-4; Tue, 11 Mar 2025 15:24:58 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
Date: Tue, 11 Mar 2025 15:24:43 +0000
Message-ID: <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110096
X-Proofpoint-GUID: DJvqVsNcsAWKSlwoorSXtHxSPYDyQiCG
X-Proofpoint-ORIG-GUID: DJvqVsNcsAWKSlwoorSXtHxSPYDyQiCG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

The DTE validation method verifies that all bits in reserved DTE fields are
unset. Update them according to the latest definition available in AMD I/O
Virtualization Technology (IOMMU) Specification - Section 2.2.2.1 Device
Table Entry Format. Remove the magic numbers and use a macro helper to
generate bitmasks covering the specified ranges for better legibility.

Note that some reserved fields specify that events are generated when they
contain non-zero bits, or checks are skipped under certain configurations.
This change only updates the reserved masks, checks for special conditions
are not yet implemented.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 7 ++++---
 hw/i386/amd_iommu.h | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 068eeb0cae..8b97abe28c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -848,9 +848,10 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
-    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
-        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
-        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
+    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
+        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
+        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
+        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
         amdvi_log_illegaldevtab_error(s, devid,
                                       s->devtab +
                                       devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 4c708f8d74..8d5d882a06 100644
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
@@ -162,9 +164,10 @@
 #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf counters       */
 
 /* reserved DTE bits */
-#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
-#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
-#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
+#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | GENMASK64(63, 63))
+#define AMDVI_DTE_QUAD1_RESERVED        0
+#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
+#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
 
 /* AMDVI paging mode */
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
-- 
2.43.5


