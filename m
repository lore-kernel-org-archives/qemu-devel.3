Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07173CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTl8-0005Zc-Iw; Wed, 24 Jun 2026 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTl0-0005XC-OL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTkx-00083P-Tx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEUxN02701409; Wed, 24 Jun 2026 19:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=uvRQ4
 9MLRvXujpAUwRE0Buhp53NTNkhgCDHPLUJ/cj8=; b=TdZS2Xapv9NCTB4N5F6nv
 5l4VZeZuTyVr6QUKGcpSEbG5edFQp7gwlekJznQ5vHYdPQxWPnHXThN2qVNmuv8K
 IQPI2vdDSWv2cyrul2afjOJXz0asM995itTcJz4q2nRtOAqRFmiXM32sY677UOKR
 LyWCH8EgSfB3eyKV1+hbizCmXn2LEhy/hYx5nByyvpyR2iBY2AxC8VzNgDDXNw5Z
 gq/e/KZn73mvyYKUyAgEjZJi6JXaTDF2Ot8QlXnOMVVSuG9mRn0i4pp5M9DbRd5h
 2s2UO2IITTPRIYc/ilvMTr4O1JGME1lO890qoIf9VeUXMMnoxVHj2nP9w+Cnreg1
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwce501-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65OJwcfA009164; Wed, 24 Jun 2026 19:59:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas3kxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:27 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65OJuO8G004335;
 Wed, 24 Jun 2026 19:59:26 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhas3kwx-3; Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 2/4] amd_iommu: Decode XT interrupt control register
 without bitfields
Date: Wed, 24 Jun 2026 19:59:23 +0000
Message-ID: <20260624195925.1254462-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
References: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240167
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a3c371f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=RlXo0yPEHK3ZGNOOaAcA:9 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: hMw6gAjwt-MIkjkL8LJ2GpdmSr_SVf3W
X-Proofpoint-GUID: hMw6gAjwt-MIkjkL8LJ2GpdmSr_SVf3W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX98d3Z2p+r/03
 jsjOzQs328TFAI65bYhSTG1mdgY3+e+v4yDf6/vvFCpQ6Yf7jprP4PBq8zArc73YLYGld+ICuQn
 l48fClR0rc46R6HbwPtA/ey6wVwyox/QZ3jwMpEdSY7NKy3W7A39/v2DdL04l9xH4/ZllCuaXkk
 LC22xK52SUVQXFO+xjqhiEfG4ut/Pvv5q5srmwSj4isKJJf+6Wws1DoEVsTbdcW+ByZs9ki2Fb2
 0JrsHEm59/Zf4m4VvVRLbUbgjqNy71JYalyIxU+PQ2UYFfZwnd0Rh3vrQjexoTDIUGO3tPl9/zr
 nQJeu9GusGqq1WIT5mognUU4rYiaHJehuPXHS3VPCMLEAir+yLpIp85JNY3mXFeEiWN9KNOevzu
 FQ1sZMIutzWRN0Va4o/0aEz3I1EYjRHuPoCJmIfuqf/dQRWbFQm3QAMaDWhA57rR+JpgKBBlbGe
 a5YmZ+u1pFy4xOmQx2RyZ6UGvG/G1WySpKyqSfzY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX0ddVYhKs+5ab
 Zqr8XLv9+C/dM0A7/j5MPdreuKsEsHDkq3HlCzxKVoP1OdtAC0zyknR54nMg6VWTf158VoXCCfk
 kN2KYjEdYpMVzHEC4wNVjKQyqHwI2ESUTyeHFoVlTbnq4Jxd/ouG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The XT IOMMU General Interrupt Control Register is a guest-visible MMIO
register. Decoding it with bitfields depends on host bitfield layout and is
not portable to big-endian hosts.

Fix this by removing union mmio_xt_intr and explicitly extracting fields
with FIELD_EX64() from the full register value returned by amdvi_readq(),
which has already been converted to host endianness.

Using a designated initializer for X86IOMMUIrq also ensures fields not
provided by the XT register (e.g. msi_addr_last_bits) are initialized before
x86_iommu_irq_to_msi_message() uses them.

CID: 1660056
Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 28 ++++++++++++++++++----------
 hw/i386/amd_iommu.h | 14 --------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0d273fd33d..c634928d3c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -34,6 +34,7 @@
 #include "hw/core/qdev-properties.h"
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
+#include "hw/core/registerfields.h"
 
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
@@ -88,6 +89,13 @@ typedef struct AMDVIIOTLBKey {
     uint16_t devid;
 } AMDVIIOTLBKey;
 
+/* XT IOMMU General Interrupt Control Register layout */
+FIELD(AMDVI_XT_GEN_INTR, DEST_MODE, 2, 1)
+FIELD(AMDVI_XT_GEN_INTR, DEST_LO, 8, 24)
+FIELD(AMDVI_XT_GEN_INTR, VECTOR, 32, 8)
+FIELD(AMDVI_XT_GEN_INTR, DELIVERY_MODE, 40, 1)
+FIELD(AMDVI_XT_GEN_INTR, DEST_HI, 56, 8)
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -194,17 +202,17 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
 
 static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
 {
-    union mmio_xt_intr xt_reg;
-    struct X86IOMMUIrq irq;
-
-    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
+    uint64_t xt_reg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
 
-    irq.vector = xt_reg.vector;
-    irq.delivery_mode = xt_reg.delivery_mode;
-    irq.dest_mode = xt_reg.destination_mode;
-    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
-    irq.trigger_mode = 0;
-    irq.redir_hint = 0;
+    X86IOMMUIrq irq = {
+        .vector = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, VECTOR),
+        .delivery_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DELIVERY_MODE),
+        .dest_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_MODE),
+        .dest = (FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_HI) << 24) |
+                 FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_LO),
+        .trigger_mode = 0,
+        .redir_hint = 0,
+    };
 
     x86_iommu_irq_to_msi_message(&irq, msg);
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3cab04a6d4..ca4440a4c1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -340,20 +340,6 @@ struct irte_ga {
   union irte_ga_hi hi;
 };
 
-union mmio_xt_intr {
-    uint64_t val;
-    struct {
-        uint64_t rsvd_1:2,
-                 destination_mode:1,
-                 rsvd_2:5,
-                 destination_lo:24,
-                 vector:8,
-                 delivery_mode:1,
-                 rsvd_3:15,
-                 destination_hi:8;
-    };
-};
-
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
-- 
2.47.3


