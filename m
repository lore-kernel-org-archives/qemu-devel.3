Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5916FEF5871
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGU-0005I8-1m; Sun, 15 Feb 2026 06:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGJ-0005Ea-UV
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:05 -0500
Received: from p-west2-cluster1-host2-snip4-10.eps.apple.com ([57.103.68.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGG-0007wV-3N
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:02 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 5C041180029F; Sun, 15 Feb 2026 11:25:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154756; x=1773746756;
 bh=a4Lipn9YKiDG3oI91EQCLLzeKcwiCgC5chTtbPEFiwg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=By/V5sJ8NrzpoBU0um90W1h9eZNYaEjD2g7JBuqcXYZPUeKP2rfZbOg9qXIETxeiFUfz6txBE5gGiaCTRLhN2QSdmKTOYgo0WnN4ICe1MFWKWUMAyGb08p2SlgrcFv6PII3nAanu9KGWNMP+7kjn32MjQbdDJdZFP3szDwjB/1xExZbDH6K6FRoax83mTXTIZQTjoATezHfaYba1WdSqbd+r/pmcItolM1DAktUcNDX1CcPB6tYhkjiG1Alwu5RP4Nd8dzMgSV0Wy7Udv5H/002pWVobRvVkf2T8fMbxR/KnBOxiySrPO1g/Wq3FygReIIpofbXUF6wKxYRgy8TvNg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 D88C518000A9; Sun, 15 Feb 2026 11:25:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 03/14] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
Date: Sun, 15 Feb 2026 12:25:32 +0100
Message-ID: <20260215112543.4817-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sVPmFnz0CfZeUQW-ny49LK_T8l93UhEv
X-Authority-Info-Out: v=2.4 cv=aKv9aL9m c=1 sm=1 tr=0 ts=6991ad44
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=kNOF8fv34t_zTB2Y_VIA:9
X-Proofpoint-GUID: sVPmFnz0CfZeUQW-ny49LK_T8l93UhEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX7t+s+qI6noXG
 6cpaz1r2oJGW9NznRtLGXODwE2K912uWqKdgteqBeq78eo2w1EcThtSrxh0fik/en3oQYrUJxn/
 oSlwAqPUkPnAYOLEMJXXOI1BR7x1X84U9+Uz4s9/pWH6GBl61o3DVcP5JwSLzR4UqgEJdjYYyAq
 Jf73zrCHcadx6RD4Dmt5awOLe3Sot9e1K6ma5UhiHViP3lVpDVQiYheHd8NWy8MWMdX6c0oUHnT
 fe02Xddv8ZDaSz9qlweKL1NWI50JsQ0VxTDMqiYih3mcwd+rBtbX5iOrGCPudIUrMqONQPTsoUC
 pYpuR+b0G/O6+/YAND55lzm26VEc8hG5mXhuRUeqxHI52FcML4DlmojpX5e0pA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=975 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602150092
X-JNJ: AAAAAAABTApmkbUcupuYfOh/eA0Cj93XyABfAdxQpbcfuAGVdgjLFXlxUE+wOdewcMyOvKV/NuPUOMmSBIVjxIQzNAkadCALE5whaX0KDNHKBEXdKFpKz+7XtXktozFDDwcGzBPLZ9eGyDLh2L1bBqyRtarBdeqVaIvO19Bjy3uo760nnYwFzsKLvI+nJmGVU0viJgFuafR3FiuHwW5GEEZ7gEMBY1LLMRSZFWJcpjfgCd9P0qIOeSPjNzArzQx9aFzTueFmv/L+IUvLAOMBUlSu5BjQWx6+p997CFR3uHvxJlE2oepGJ9NQsBYO9kz6PbO6zZCtCyoqDIerC1mhZNK/dGJ/VrUo3LwYP+6tGjIWdS5UImBZbAUOdfOOQr8DTUUP3uWSrfPUIdH+4WDKppnojUBqmYUU9o8OnQtLUkU78V2Fgf9SU9Z1Xpb/6AdFf0B2u4x+7JwKoW/1wzX+Ro8rdMXxIjnRQJTyQn0YkBvdfIRuDFAe0A1Nf3MGprMft4msgUrlOJH6emULQXRPLaU+v2Mukv11VBYOAesA4ordN8ULGNmrtTERp0q0fn+6ukA/YC11WRdlAHMIDzwN8rXrAt4PWnha0lG77mhp5itLyX4bbEJLRhnnIigQBcxxErzmbXJMc2ESNuNGoJxuB/G+S6yCbz+u/muR75/mRjiLnSnel4mFk7DKk2Fin3Ue/RlIr2VvZcqBhEhX79HShAQOUiCLuKbDTPtxX2RWSlKKeTnKPW/NqJaY6rQSAsN9MeLCv0qgDE3W4aPH
Received-SPF: pass client-ip=57.103.68.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On HVF, some of the GIC state is in an opaque Apple-provided structure.

Save/restore that state to be able to save/restore VMs that use the hardware GIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_hvf.c            | 91 ++++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
 hw/intc/meson.build                |  1 +
 include/hw/intc/arm_gicv3_common.h |  3 +
 5 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9200671c7a..9c3fb2f4bf 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -305,6 +305,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_gicd_no_migration_shift_bug,
         &vmstate_gicv3_gicd_nmi,
+        &vmstate_gicv3_hvf,
         NULL
     }
 };
diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
index d6a46b7d53..9e4d974cd1 100644
--- a/hw/intc/arm_gicv3_hvf.c
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/runstate.h"
+#include "migration/vmstate.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "hvf_arm.h"
@@ -30,8 +31,13 @@ struct HVFARMGICv3Class {
 
 typedef struct HVFARMGICv3Class HVFARMGICv3Class;
 
-/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
-DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
+typedef struct HVFGICv3State {
+    GICv3State gicv3_state;
+    uint32_t size;
+    void *state;
+} HVFGICv3State;
+
+DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
                      HVF_GICV3, TYPE_HVF_GICV3);
 
 /*
@@ -656,7 +662,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
 static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    GICv3State *s = HVF_GICV3(dev);
+    GICv3State *s = (GICv3State *)HVF_GICV3(dev);
     HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
     int i;
 
@@ -703,6 +709,83 @@ static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
     }
 }
 
+/*
+ * HVF doesn't have a way to save the RDIST pending tables
+ * to guest memory, only to an opaque data structure.
+ */
+static bool gicv3_is_hvf(void *opaque)
+{
+    return hvf_enabled() && hvf_irqchip_in_kernel();
+}
+
+static int hvf_gic_opaque_state_save(void* opaque)
+{
+    HVFGICv3State* gic = opaque;
+    hv_gic_state_t gic_state;
+    hv_return_t err;
+    size_t size;
+
+    gic_state = hv_gic_state_create();
+    if (gic_state == NULL) {
+        error_report("hvf: vgic: failed to create hv_gic_state_create.");
+        return 1;
+    }
+    err = hv_gic_state_get_size(gic_state, &size);
+    gic->size = size;
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to get GIC state size.");
+        return 1;
+    }
+    gic->state = g_malloc(gic->size);
+    err = hv_gic_state_get_data(gic_state, gic->state);
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to get GIC state.");
+        return 1;
+    }
+    return 0;
+}
+
+static int hvf_gic_opaque_state_free(void* opaque)
+{
+    HVFGICv3State* gic = opaque;
+    free(gic->state);
+    return 0;
+}
+
+static int hvf_gic_opaque_state_restore(void* opaque, int version_id)
+{
+    HVFGICv3State* gic = opaque;
+    hv_return_t err;
+    if (!gic->size) {
+        return 0;
+    }
+    err = hv_gic_set_state(gic->state, gic->size);
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to restore GIC state.");
+        return 1;
+    }
+    return 0;
+}
+
+const VMStateDescription vmstate_gicv3_hvf = {
+    .name = "arm_gicv3/hvf_gic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gicv3_is_hvf,
+    .pre_save = hvf_gic_opaque_state_save,
+    .post_save = hvf_gic_opaque_state_free,
+    .post_load = hvf_gic_opaque_state_restore,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(size, HVFGICv3State),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state,
+                                     HVFGICv3State, 0, 0,
+                                     size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -722,7 +805,7 @@ static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo hvf_arm_gicv3_info = {
     .name = TYPE_HVF_GICV3,
     .parent = TYPE_ARM_GICV3_COMMON,
-    .instance_size = sizeof(GICv3State),
+    .instance_size = sizeof(HVFGICv3State),
     .class_init = hvf_gicv3_class_init,
     .class_size = sizeof(HVFARMGICv3Class),
 };
diff --git a/hw/intc/arm_gicv3_hvf_stub.c b/hw/intc/arm_gicv3_hvf_stub.c
new file mode 100644
index 0000000000..a587332c7c
--- /dev/null
+++ b/hw/intc/arm_gicv3_hvf_stub.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ARM Generic Interrupt Controller using HVF platform support stub
+ *
+ * Copyright (c) 2026 Mohamed Mediouni
+ *
+ */
+#include "qemu/osdep.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "migration/vmstate.h"
+#include "qemu/typedefs.h"
+
+static bool needed_never(void *opaque)
+{
+    return false;
+}
+
+const VMStateDescription vmstate_gicv3_hvf = {
+    .name = "arm_gicv3/hvf_gic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = needed_never,
+    .version_id = 1,
+    .minimum_version_id = 1,
+};
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index b7baf8a0f6..c6de2d9d00 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -43,6 +43,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
+specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: files('arm_gicv3_hvf_stub.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 9adcab0a0c..dd49fe1b9d 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -339,4 +339,7 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
  */
 const char *gicv3_class_name(void);
 
+/* HVF vGIC-specific state: stubbed out on a build with HVF disabled. s*/
+extern const VMStateDescription vmstate_gicv3_hvf;
+
 #endif
-- 
2.50.1 (Apple Git-155)


