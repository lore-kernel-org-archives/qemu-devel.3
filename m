Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8537EC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtE-000133-Mg; Mon, 28 Jul 2025 01:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrg-0007MP-1V
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:41 -0400
Received: from p-east3-cluster3-host2-snip4-6.eps.apple.com ([57.103.86.19]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGre-0007Gy-98
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:35 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 A66AC18000AA; Mon, 28 Jul 2025 05:57:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=y6mI8AmJ1dWdgen3Y4HML2fQWE3KY+VD1EyD//Qc2Zo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=bPar//4VQb8tPifxBJ6DFGXXmdw2AMFIC9kJAU/0JP5g8DTGTFqJHUV95D+QtqhjBISTLsuGdhXFLNgC/+rmK5lh1vCtwKnFjBcgkG+7x5uNzoecMB75hRgnbtlZzSinJE6k06OBckbgQho85XNyvUzArnK1Qti0NCURTk6prhmfxlts6mlvJke9XOmqaZRv2UKQ4LsdFC4T7aFb26HUrJtWkSN77TxeIxWrpxfzmApb6hojWSVMqMuD5cV5i8HGnUTsAzSc2vkX99u3uc7inZWUuiVn66uWdu+j4BIyxYfFtCWbL8KfmG7jNMDFxWN0uDDcwPtZpK0oLVWGSh7V/w==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 64038180009A; Mon, 28 Jul 2025 05:57:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 13/15] hw/intc: hvf: sync state in c->ich* registers when
 virt on
Date: Mon, 28 Jul 2025 07:56:59 +0200
Message-Id: <20250728055701.38975-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9TPXBQzbmoXtYz68X5g5VPWXWVWc7f-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX6qTXyYh7iTmm
 l2J51eimKbaGReSTF7ikrIXBTyVyO2aki5Yx2pEFrUQdSOR5UcqqZMdsyu2Fkl1dSfDm8bFouNj
 H4eNz230fAZGhsc8YRLCPMsHcTPhlhbmGhQ3uMOg7qCrNOZgaTMGHEgRwKtQ6H/DLBc7sB9Vvrx
 dpq+2GzwXfUXAAHC7ytxTaw2tVJC7t5CAwZliPmxXWIZF2zly+VOZjWTHS7PjKAv/17cBnzU1Ia
 UGFmvCGp6e6IG1IfZOZ8Xwnz+lvAI2Oyd+4WHJ15eVtyY2Cvo5lK4FA9oDV3dtloc7MRnRY+4=
X-Proofpoint-GUID: 9TPXBQzbmoXtYz68X5g5VPWXWVWc7f-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=884 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.86.19;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Part of vGIC state to save/restore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c | 113 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
index a154b27318..30362540f2 100644
--- a/hw/intc/arm_gicv3_hvf.c
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -15,6 +15,7 @@
 #include "system/runstate.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include "hvf_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "qom/object.h"
@@ -315,6 +316,62 @@ static void hvf_gicv3_put(GICv3State *s)
             hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1, reg64);
         }
     }
+
+    /* Registers beyond this are with nested virt only */
+    if (!hvf_arm_el2_enabled()) {
+        return;
+    }
+
+    /* ICH */
+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        hv_vcpu_t vcpu = c->cpu->accel->fd;
+        int num_pri_bits;
+
+        hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2,
+                    c->ich_vmcr_el2);
+        hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2,
+                    c->ich_hcr_el2);
+
+        for (int i = 0; i < GICV3_LR_MAX; i++) {
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2,
+                c->ich_lr_el2[i]);
+        }
+
+        num_pri_bits = c->vpribits;
+
+        switch (num_pri_bits) {
+        case 7:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3
+                , c->ich_apr[GICV3_G0][3]);
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2
+                , c->ich_apr[GICV3_G0][2]);
+            /* fall through */
+        case 6:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1
+                , c->ich_apr[GICV3_G0][1]);
+            /* fall through */
+        default:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2
+                , c->ich_apr[GICV3_G0][0]);
+        }
+
+        switch (num_pri_bits) {
+        case 7:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3
+                , c->ich_apr[GICV3_G1NS][3]);
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2
+                , c->ich_apr[GICV3_G1NS][2]);
+            /* fall through */
+        case 6:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1
+                , c->ich_apr[GICV3_G1NS][1]);
+            /* fall through */
+        default:
+            hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2
+                , c->ich_apr[GICV3_G1NS][0]);
+        }
+    }
 }
 
 static void hvf_gicv3_get(GICv3State *s)
@@ -452,6 +509,62 @@ static void hvf_gicv3_get(GICv3State *s)
                 , &c->icc_apr[GICV3_G1NS][0]);
         }
     }
+
+    /* Registers beyond this are with nested virt only */
+    if (!hvf_arm_el2_enabled()) {
+        return;
+    }
+
+    /* ICH */
+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        hv_vcpu_t vcpu = c->cpu->accel->fd;
+        int num_pri_bits;
+
+        hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2,
+                        &c->ich_vmcr_el2);
+        hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2,
+                        &c->ich_hcr_el2);
+
+        for (int i = 0; i < GICV3_LR_MAX; i++) {
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2,
+                &c->ich_lr_el2[i]);
+        }
+
+        num_pri_bits = c->vpribits;
+
+        switch (num_pri_bits) {
+        case 7:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3
+                , &c->ich_apr[GICV3_G0][3]);
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2
+                , &c->ich_apr[GICV3_G0][2]);
+            /* fall through */
+        case 6:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1
+                , &c->ich_apr[GICV3_G0][1]);
+            /* fall through */
+        default:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2
+                , &c->ich_apr[GICV3_G0][0]);
+        }
+
+        switch (num_pri_bits) {
+        case 7:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3
+                , &c->ich_apr[GICV3_G1NS][3]);
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2
+                , &c->ich_apr[GICV3_G1NS][2]);
+            /* fall through */
+        case 6:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1
+                , &c->ich_apr[GICV3_G1NS][1]);
+            /* fall through */
+        default:
+            hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2
+                , &c->ich_apr[GICV3_G1NS][0]);
+        }
+    }
 }
 
 static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
-- 
2.39.5 (Apple Git-154)


