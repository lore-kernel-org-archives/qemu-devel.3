Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA161C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP6J-0003FG-LP; Wed, 28 May 2025 18:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5y-0003AK-Ez
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5p-0000x4-Na
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SIN2ok016710;
 Wed, 28 May 2025 22:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=1vbh1
 uDB13yiD152yJ62wuX9AEeqoGKtdJ12LOns2iY=; b=MwiSKpUZzQnjilE8yDbsZ
 lhbcg5zpu7ScQg0wMpWrtdihomK4+1ZmDSh9vQ4VWf5SG5la8DOixQ/ocFHz4aio
 86TFGt/2WDD0ljJ8nuTDX9cOU3sED4to3dDVruDmFdCpet+GvyupoDT3Maw2gba9
 FdgStP9HZyRmk25cGFSNSVaU/kvrNgVZpEUjw+RuJSX5FAuCpxU7BEFOdgf9Jbb2
 myCPLRVwQPxdbtk+5UPYYJfDOY7PBfewMNG6sgT76ZtgQvY5L7VAstZjHao2fX6R
 M0YhDF6vQWoC5iSiBuL64J+hY1FZbFoXxLlOztWcobc+bFxmuZnqFjikB9swZFXe
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6wvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SKCkD9024393; Wed, 28 May 2025 22:17:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jb86v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SMHQsV018695;
 Wed, 28 May 2025 22:17:27 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jb86u3-4; Wed, 28 May 2025 22:17:27 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 3/7] amd_iommu: Update bitmasks representing DTE reserved
 fields
Date: Wed, 28 May 2025 22:17:20 +0000
Message-ID: <20250528221725.3554040-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5MyBTYWx0ZWRfX+ZRdCUHnGpX/
 r2YyeD54rp46D89VzKqr01M8nWhGyIuiWEDMDk4vRZP6o6EiAFNEr6NNl0y9tYfE8rISHhPfrM/
 99aepD/s7yr2SzeRPZFRwSgu31X9XYNN9efBy9YLFzt3gq3z2sbQUuE582sW7MOB23sp4AQuWl8
 qe8K4IaiwV1gW+PPvUxZ5QnzXyTYKZF6LNHh1K/oXpqJgQsORcBfCzKk5apn/YYc+PwnIUgSWq6
 BQyYSabPHFy2D6S6Nwpec4yMzrOHaUXkDcYKw4RndrbppkS3Ofer/c+pTQm+0S/cgpKWXrq3fgu
 vq5wl204UrZANLe6IOIC9tddzh3+p/QsEXok8QG2K3OXnda/nTLWLvvM8ZpMp+BruoC6aegCX1k
 qssd0+vnU5yV52eJXtG4TG2T4H9HVR/X/zyDkyrLC3IIQqr5Ybb82r8/99OqRCE+rp3ExuVn
X-Proofpoint-GUID: bmgZsbDWeZOyxMGkoBs-r2o8eUCxdaP6
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68378b78 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=4jmliWysXe4-JJ31YZsA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: bmgZsbDWeZOyxMGkoBs-r2o8eUCxdaP6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) DKIMWL_WL_MED=-0.498, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 7 ++++---
 hw/i386/amd_iommu.h | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 55202eb9ef7d6..cc47ba9249990 100644
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
index 75a01eff468f5..45a997af861e6 100644
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


