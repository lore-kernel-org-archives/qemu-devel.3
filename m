Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F25C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYKG-0004Cu-PX; Tue, 17 Jun 2025 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI8-000126-P3
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXrZ-0006sN-MO
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEWwdP003883;
 Tue, 17 Jun 2025 15:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=J5iTw
 p1bSL6P4EyZpSZa9apeAQ6mvJhF3sO7MRLqVsM=; b=mZ/lstljk0s+xDO9cxxoe
 fneR8d13kX3S3SIMJdiRumWiYhQIWwryPhTE0vSM5bwBMHL9K3HIRdwmKy2ZJE+s
 j8Pqc6Oo2fspyHPTlelOlGyQ3iaJqLxVMArPeTUd38BXYXQXiP8lqlDASCa+4Lez
 NF36CjMmy5+w/4va+wZA9Gc7QOaMUacHHnxh1Osm7y1I/yR0kvOHf0bgM4zbd6+a
 Taqnf4STHUUA4HSiPQjM7ltNaeT1Xmonf4TvndQyBII9HIa9NqkkJk6lK0lCDRY/
 t4Nzv9PYTdH9XGetektcuSYo1+xwP2illEyadw0BttpgRe9WqkXLjmGCqYZR6hWv
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv55eyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEP5mt001490; Tue, 17 Jun 2025 15:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4Svd014869;
 Tue, 17 Jun 2025 15:04:30 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-4; Tue, 17 Jun 2025 15:04:30 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 3/8] amd_iommu: Update bitmasks representing DTE reserved
 fields
Date: Tue, 17 Jun 2025 15:04:22 +0000
Message-ID: <20250617150427.20585-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX40nnEagjNv9p
 OtzVpw9Zo8lCzN3uLLf6PINaOxCq3KR4lvrR9dMEdlpk8NI2sjaA8PfciOplci8W4qaiVTLiW4U
 OoxakaAP6eYSW4E5/7crurKvTmF0r6Qs3pQgsZlbeI0LL7iqvGsA67Uog3DZq6YDvXSbUV/RMZK
 IzQMsCNJat4YBXRD5vkEgGrl5oJnNinWXsrZodyNNYZOHATLgFZYriz5qG7Yj/tsl7AvYKn7dvO
 tzz29vkk/Dachg/I5Q0/HU4lmFu49zOTScvuQDfrkq2G5i5JeoWbshT9oeB5m/6D3XJ5JAMNpc9
 5X9UKlTrj4FmB1cUghyXizMbmlADa8GwdcxdXIG2sgLnCsHyZHxswWH55oMCQiynarGvKnFWtmW
 vuQITRpJt6ZpmGruMIIvj+jD2sUR2EuHOPal6cZSw/0BZ2jXoPRInp9TU/yYBIzDTJN8Np9o
X-Proofpoint-GUID: rpsIem4wlp0C6wLL0rJ8ZiFuWjTkIa7R
X-Proofpoint-ORIG-GUID: rpsIem4wlp0C6wLL0rJ8ZiFuWjTkIa7R
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=685183ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=4jmliWysXe4-JJ31YZsA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 7 ++++---
 hw/i386/amd_iommu.h | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c27efa504d19a..6e78047919cb6 100644
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
index 3b1d2e9da5347..aacb29b617aec 100644
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


