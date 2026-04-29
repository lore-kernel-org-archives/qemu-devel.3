Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C48CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEJ-0001Zg-39; Wed, 29 Apr 2026 15:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEH-0001ZS-Uf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:49 -0400
Received: from ms-2001b-snip4-3.eps.apple.com ([57.103.73.144]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEF-0000Hs-Ej
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:49 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 D13D218005C4; Wed, 29 Apr 2026 19:05:44 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YBXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489546; x=1780081546;
 bh=2plkI8G/xtaBqtwyh6xOVg+3IVt0va4ZwnudgPTYjC8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=XqTHwzCzIoZ47Z3/Rn2YOiDGTc61rqJ1rchUAOxhAHwk8nLUsXAl8sqpw8e8t4g5bNxQ7HVw23LAvgh4O6H2YYsOncwE/g/G5YzvEgdjIS2ojsN6WQh18upg90Ha8ANvWjh+8TR+JS2XhvfR+S56qkxa2ezr2bpYH2wepBZeG6Y+bpELOknRQ3TAQYRajZpfx/NvvZyTrP8AvbdGpvLa66Y5JkFPpaj5k661xaCqZgf1lFdWl6EIaVOFp3etATgIKx+IaGeymsDQ0okwsqr7uAINa1avgruuEW+HkMQK2IsF4D7mfgB1uS4zMiAn7DcTpcdVz3h8XbfepCSUjHwBTg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 CBFA918000F6; Wed, 29 Apr 2026 19:05:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v21 02/15] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
Date: Wed, 29 Apr 2026 21:05:19 +0200
Message-ID: <20260429190532.26538-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfXxS/RbWKnmguq
 GkHbWTwc3iiwREbPI6zbv/F3JAhKE6ELPtSl+70J6mHbpAtPTr0JZQcyHYKhCvTNoDjTgft6rK1
 qFbMSDGbfb8/EFdmdLGzeHO6nM+wNSdhMdx9nP2xcSIRSGhs0hhuZ9DXKzHQ+KT7ZedpY3Og6Bw
 HQO94dwMHz1TRlxqvwAnw6e1pl7M7ZIeT7tBisfptgrMWpwdhMrw9tEoTkq/tnJhfnpCsFWhiBi
 VWmPjUOZrukQE/Is4Sk5Wv6vsPcN1GFxyL7s8KF23LkHiahb/XvwNRMKc2fg+/Iz6vGa3MYHkhx
 HtYnPrHaKLoRFUYnxWaCSIgBvPfu9IMmshUeACIn+wNISFHzpsBD43l1BFCaRY=
X-Proofpoint-GUID: cp22U5CM6eTCRlqNTmnbr1fyGUJJSHO-
X-Proofpoint-ORIG-GUID: cp22U5CM6eTCRlqNTmnbr1fyGUJJSHO-
X-Authority-Info-Out: v=2.4 cv=aIv9aL9m c=1 sm=1 tr=0 ts=69f25689
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=kNOF8fv34t_zTB2Y_VIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=57.103.73.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_hvf.c            | 94 ++++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
 hw/intc/meson.build                |  1 +
 include/hw/intc/arm_gicv3_common.h |  3 +
 5 files changed, 120 insertions(+), 4 deletions(-)
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
index 7935846bc7..a0f32acb82 100644
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
@@ -34,8 +35,13 @@ struct HVFARMGICv3Class {
 
 typedef struct HVFARMGICv3Class HVFARMGICv3Class;
 
-/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
-DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
+typedef struct HVFGICv3State {
+    GICv3State parent_obj;
+    uint32_t size;
+    void *state;
+} HVFGICv3State;
+
+DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
                      HVF_GICV3, TYPE_HVF_GICV3);
 
 /*
@@ -659,7 +665,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
 static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    GICv3State *s = HVF_GICV3(dev);
+    GICv3State *s = (GICv3State *)HVF_GICV3(dev);
     HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
     int i;
 
@@ -706,6 +712,86 @@ static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
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
+static int hvf_gic_opaque_state_save(void *opaque)
+{
+    HVFGICv3State *gic = opaque;
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
+        os_release(gic_state);
+        return 1;
+    }
+    gic->state = g_malloc0(gic->size);
+    err = hv_gic_state_get_data(gic_state, gic->state);
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to get GIC state.");
+        os_release(gic_state);
+        return 1;
+    }
+
+    os_release(gic_state);
+    return 0;
+}
+
+static void hvf_gic_opaque_state_free(void *opaque)
+{
+    HVFGICv3State *gic = opaque;
+    free(gic->state);
+}
+
+static int hvf_gic_opaque_state_restore(void *opaque, int version_id)
+{
+    HVFGICv3State *gic = opaque;
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
@@ -725,7 +811,7 @@ static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
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
index 9adcab0a0c..03ab3e8f2f 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -339,4 +339,7 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
  */
 const char *gicv3_class_name(void);
 
+/* HVF vGIC-specific state: stubbed out on a build with HVF disabled */
+extern const VMStateDescription vmstate_gicv3_hvf;
+
 #endif
-- 
2.50.1 (Apple Git-155)


