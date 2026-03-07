Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DFCF513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdL-00015K-55; Sat, 07 Mar 2026 10:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdI-000145-Hx
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:00 -0500
Received: from p-west2-cluster5-host12-snip4-8.eps.apple.com ([57.103.71.21]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdE-0000MW-N7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:00 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 127CA1800162; Sat,  7 Mar 2026 15:31:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897515; x=1775489515;
 bh=1RV2oa9C2DaRGIF3rfTp8Tdv8xxfIYsPZWi/MFo/wCM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=STOB/c35JmT9QI036yLwQI2Z1Azk7gUkuLN4qklyj8kUfARy+47HUmXCCFc9Pe247ohTk+nszAf4iL7QDpa+kCjZswXiEIHo9UcYkcGn/UJIlRSusJGoV1AmLVAdprTDRm07VpcYlVydz1VGsq4X8W5z0Z9+thKA8ZHzTDrt2/4V5nIIrYkiaAfGeN32VgqVh8G3DLUxdEoulPQZgYyavJH72cnJmJ4gMZBkCL1VBAaPKUoysipMMHROt4B44MOKYVeoks1EfcVesOhncV/bnr/MsyMR1Q7BeVxh4sZbTODwLQGAirw3+bVXHpsGDUXN08B0naqdAKcHGCKzloraXA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 7830D180009A; Sat,  7 Mar 2026 15:31:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 02/13] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
Date: Sat,  7 Mar 2026 16:31:32 +0100
Message-ID: <20260307153143.76893-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -roV3A7mTYg_WNqNpt_VRM-sA5XYaxwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX65yJxmYoCtP0
 YNCijGGpfx2SVVQHeIUoWd8IbBX8LLuVQ1Jx/emAQarOO0b0nsJBAZGTElnxgHBmK4ugA2FtPMW
 KqmpymtVLBu/N22UnNZpZKs8YZXeDQ/95df9QK12DoQ5su0RjeHu0MbViXhDZG1OgZ8P6GO+oqc
 omGxRU5HxAJHzcgqf+Nzr8WzEzcyD/hjSkd+sgdnryBLudYwyoYUUR+KjjbmGmhu0Qtb7PpQHSm
 Uzt1tVfpIB8vHSzhPnT6n//q5WxiwTvS3MQXFykzpqoUsTxM/0jCQK/L/jEXXfrMKcnkW1YLwHu
 hxWbuBePUucogFF9ZEGtfnkyTjbgcEbSpK5YFxhYCGSmZCO2Ave8PbGhy/Hr3E=
X-Authority-Info-Out: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69ac44eb
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=kNOF8fv34t_zTB2Y_VIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -roV3A7mTYg_WNqNpt_VRM-sA5XYaxwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=978 suspectscore=0 clxscore=1030
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABQ3bMiDi+3RyI6W2nOEcx+9MV2t1ZOn1+hmduPk3i2NgGBTNQipasIfHDF9ncC8MtmTA//o8dCPOsyX9VX1clWn6vcky1mIOhjmS4VS051nMInGrkBPCHw9Kq8+C4sXy0P2bDmpbnINZRlmeMnAa8120eIFMoqB4p9z8XlAKFcDvk5ItG5pUvP3MSJtk8LCh/EfHeWnn2hSr3u7ZvjbFuOJcwXHIeKacIsBpf0LAVx7D44AkaQZaAwZIk1aPlqqw48GmbfNXsNrp9fyW3gQ1wkm+m5wi+cUJqPM6i74ew9ESK5tMpAA1DYIJEwfjsbBoKeBFJKac25WxGAPxc2FtdNoNUoVPxS6YS0likTsGl9XmanEFZj7HtzpOknCb+kxD3c4ejVvFGjvYN8JFd0MWbKb0VZ4QhyAotOV+fNjZhM912EZYiAibL/luMxt2d06AKx6xEeHXPITVSmXDua+EL62pNQ8x3WnNttH0L0tltQRGtclxKtlbdEjIZkOXypjUuDquW+pgG0VXMeaq1VYmD3A88Asar4YCwCOYOdWytg3yP3eVMQiy4CxSaVyk7ItifsAR4yOICN65vjjVuAYsx3bN4wUAb1CkCjV1j6RG73l62b2sOhxsARjh7hUfwVXLgOzZ3sDRlvuDCX2BCPuwxmXih7o9Xux1hMyvsQCNt1Cj6yogdUmRnglYo71xXpUfeR+uDeNNyYEkrlw1aaoxJEkKKO77j6cqJi0EN1aIOAGYxqIgOZGU8QX+550Y4rkM480xMZt1Xizd86+duXi/rMiLMAOHfw0NXcGHO9ANMHmzh
Received-SPF: pass client-ip=57.103.71.21;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_hvf.c            | 95 ++++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
 hw/intc/meson.build                |  1 +
 include/hw/intc/arm_gicv3_common.h |  3 +
 5 files changed, 121 insertions(+), 4 deletions(-)
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
index 55171a796b..18e5b3fe68 100644
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
+    GICv3State gicv3_state;
+    uint32_t size;
+    void *state;
+} HVFGICv3State;
+
+DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
                      HVF_GICV3, TYPE_HVF_GICV3);
 
 /*
@@ -660,7 +666,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
 static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    GICv3State *s = HVF_GICV3(dev);
+    GICv3State *s = (GICv3State *)HVF_GICV3(dev);
     HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
     int i;
 
@@ -707,6 +713,87 @@ static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
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
+    gic->state = g_malloc(gic->size);
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
+static int hvf_gic_opaque_state_free(void *opaque)
+{
+    HVFGICv3State *gic = opaque;
+    free(gic->state);
+    return 0;
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
@@ -726,7 +813,7 @@ static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
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


