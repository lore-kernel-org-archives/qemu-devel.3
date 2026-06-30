Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegdW-0007WX-Gz; Tue, 30 Jun 2026 18:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegct-000779-CZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcq-0005u6-Vt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UKuKkC1067095; Tue, 30 Jun 2026 22:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=YoGNWqIt3taWHOcRI4+ESM6QPZJyvW1F4VfAVHhMdL8=; b=
 Tw4Ohi7T8HOoUdYteAyhOb5lI9g2+vWsAF2A5rsf+7LqQCxtezr3QCt7Y6/ivaLZ
 YTuz+kz/sLneRHJkFkTgEhLMqXf3hQXk09ZDa5AJrOmXoceFfCG9tzf8+HdLW7Bb
 BeROhyTPszILO1ZUjbVkT7ncImHLp7twT0/zAoofArIrqixl//GpuhrnQwLjFB3Z
 n3WdXtpXLMDD84QPL20XIcpDCUFKA1D78rDxCrrdT8pTOHSneRIm7SYxwgxi4kgG
 qfzd1X/31oh7xkvEc1R5/YrLXwkRXDz3QMeAOtIamhVrYWWf8IO+riKV9Owcow80
 slPakE1ec1yXvmlLh+3aCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kfd2ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UM3WF5034126; Tue, 30 Jun 2026 22:08:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f3u1w75wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UM87gJ008507;
 Tue, 30 Jun 2026 22:08:08 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f3u1w75vm-4; Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 3/5] amd_iommu: Decode XT interrupt control register without
 bitfields
Date: Tue, 30 Jun 2026 22:08:04 +0000
Message-ID: <20260630220806.1758748-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300215
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX4/0u/hiEIf9l
 m77PEa1NBa9hSrxB35Yh4nm2ZCblG3FxccXSV1ZaMSR2lvaHTBqp6miakyEy91yJAK7BcfX+tKg
 ACjJzoNBADQq97DHnDBZlZZ9kGtiMWmlc2NNOzTnm5lZNVfEmTTi
X-Proofpoint-ORIG-GUID: X9w594s2k_vGLcG-YJUEpdQWtu9y6UAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX0lQtySBEzope
 UnXXQ2W1cnfgnJg39KrRGjDmCbX8ewdARTPjW99MgcxfpQllsygmfqsw0XEiZ0ltzCANmM7AN0N
 Gy2wvfxANwO5VDCjuvE6oyXKjhMrRCzpREK9br+kdY+UQgS2HMw16rxt8UWQsEDDNoveTLhapUH
 ahm3Jl72wEYQvXRGXHKkGmMcwr0Ymw3eZzAOYasDkqoLLFiWWPmOpEUV5H86VPayMvDNWS0WEBA
 0Oc9/Y34aDNZOQXvpvsR4KS779gUIUXtM3hOfc9ns0YO3oRTHylkGpeGMRLXHUk7rnJziNtWqbD
 OWK6WKTwb7GaJkZy3cTDYDjql7QXj/kd33BFJFk8WP92x6L6Ji1obS/Q/0rXu8k0jm/8HByUSt6
 h1ps8qZPG0gHKQPoW+XUwS2yIpQ89sg93p+5xt6fWgqG8It9r4gy+DvxW234C6pK4oVmZPP5+m5
 MlnujBUUHN8cffUbR+GxnN9hnkwuXDCYvwlVehjE=
X-Proofpoint-GUID: X9w594s2k_vGLcG-YJUEpdQWtu9y6UAv
X-Authority-Analysis: v=2.4 cv=YOavDxGx c=1 sm=1 tr=0 ts=6a443e4a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=RlXo0yPEHK3ZGNOOaAcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/amd_iommu.c | 28 ++++++++++++++++++----------
 hw/i386/amd_iommu.h | 14 --------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a0835a20d7..291cb368a9 100644
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


