Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0FEF5878
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGS-0005Gj-9w; Sun, 15 Feb 2026 06:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGL-0005Es-H0
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:07 -0500
Received: from p-west2-cluster1-host6-snip4-10.eps.apple.com ([57.103.68.63]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGG-0007wk-4M
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:04 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 A439218002A9; Sun, 15 Feb 2026 11:25:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154759; x=1773746759;
 bh=59TJPyifQdYiPo+R2EjYdFKf7iChqKxw+V2UadvNjas=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gkm5A0dqkQEXMfBKt9BCbbzN88Wr/e5R0+HnjhpCsHEImxRQn21OvHW0mwTv5QUH7L1VtX6bQKn9Mby+p9uPouqjSmpONXjFsZ1jv43tK5xYenhUd13XJNdx5hQaQK5iUrFeZaSVRm/adkf2xRm8AtDAJxvEtTgl4XNivIQXbR9huocJ6i4PO3vJ8af96yZ2xmzw76IxD4bpZVWfEE4+ODvNuh9ArGmbcw/lDbzeL2VfAijOsuKUG/Oj5NZM4/LvjUrPBXtcY7M22bsXDZqrAlQsp5QK2FOVWP/rDmG2gaZHn0GGvJefXiIc14DAUGxjeS/YQp6j7dZjdoKk+AybiQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 2D0741800294; Sun, 15 Feb 2026 11:25:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 04/14] accel, hw/arm,
 include/system/hvf: infrastructure changes for HVF vGIC
Date: Sun, 15 Feb 2026 12:25:33 +0100
Message-ID: <20260215112543.4817-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfXyBEWuiq55QM2
 lMcuMFf8eegJPJuM5sVgs6GDG3KTQrZNrBbQdj5wYCKm9Ealtj5LBgoGOIz5MgAL9JTbwo4ESyp
 OO7L8NljuwAfqh5zDRvLIt8BQO62rgB9IqbLJBavUDfSkT2HKEiXrBEVBKdpD3tSa8G7rdBNJs+
 q1gaAQZUQ6S30C7ic/XhLdI2UA/2pulTGWN3wSbmoW40KCX+N5W/qUVe/1JZLmNtkquBZO3pRrv
 q2hbBlzc+v9JkiFcJf7bD+toHspSwl9WyqNg9WTVTEtsQySAljKmirDaKc/LB+bThCEBwO+N2EM
 NfzqvJVw0KIikEdjuz0x8xgTFAnLN4PQE3RS8FAf1k+RU2RGWokP9Xe/B1r28Y=
X-Authority-Info-Out: v=2.4 cv=FMQWBuos c=1 sm=1 tr=0 ts=6991ad46
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=n4FVybPFTm1vobq06wUA:9
X-Proofpoint-GUID: 0S9OHb8sbkc-nVZUEIxVrkAB8pr3_gxi
X-Proofpoint-ORIG-GUID: 0S9OHb8sbkc-nVZUEIxVrkAB8pr3_gxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602150092
X-JNJ: AAAAAAABTugRFEp/3LPriL5v3Y7L7EGAf7dLjkmyDXZhubzT7+brPPwqi07aMtlca69lfksQZw5euA0Y5xzEy7KDD7D6tn/+h0s0OyBcNLNau6fG4KD8YHrcMxZik+5ZhY4FSpTKvt1CXWRSuFJPTXgDVK0jMZd6Scqc8bvXSAcTfsp7alhBsUQbKL3Ly8aNgfCeib/VQ4WoKRHlpYNjIJr7nRAkm5T7tf8cADuJLE4I7b6kaCuoBAfadhoC2aHJ0+ZtWrO0M/f+6Mt3yG68O8mfnGMNYx+YW7gSfNyjjNEjhdFbvTMdvyU58atgRavs6kIwczdcf33dhx69N3hvEZpo4ulkXdzkoqeDFmofUSzTOtD2GC465z592CICArH807x/bkojO5YDddYfGQIrVT4VCSfGuedOtrJpS3wWkj/+recnDb81LZMu3ZOl4cNiOq42m+22BKeew6eLbZ/6xRbFIUEdqMJ4SEnkyxxCK/SRUPZlYYwz3Qyj6vFLX4Q8un5HYKMViqKBzfVmzrmeQHq70m5Vh2wA2eHKwFg7H0Kk8AqmpsE2Ji0ify45QUr3meisNW4U978xMxiCMa4l6cj+LFSopld9Pdi9cl8yJBsK7bOUoricaZrcf4Gz830pn7DT5YMHwZOPWQYZ29875czIYceiTdRJ9nk9xByN6Lm/nj8ymxWa0mklc0yNGiSlJOEs9XfzHf+CAlUhRQ9U0hAXpcmzHLz1c0+w8dk+B/yGbPPIjVtHBQ==
Received-SPF: pass client-ip=57.103.68.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Misc changes needed for HVF vGIC enablement.

Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
Keeping an #ifdef here in case we end up supporting that...

However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 23 +++++++++++++++---
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677b6f..929f53fd37 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-common.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
 #include "system/address-spaces.h"
@@ -22,6 +24,7 @@
 #include "trace.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -217,6 +220,43 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    OnOffSplit mode;
+    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_SPLIT_ON:
+#ifdef HOST_X86_64
+        /* macOS 12 onwards exposes an HVF virtual APIC. */
+        error_setg(errp, "HVF: kernel irqchip is not currently implemented for x86.");
+        break;
+#else
+        hvf_kernel_irqchip = true;
+        break;
+#endif
+
+    case ON_OFF_SPLIT_OFF:
+        hvf_kernel_irqchip = false;
+        break;
+
+    case ON_OFF_SPLIT_SPLIT:
+        error_setg(errp, "HVF: split irqchip is not supported on HVF.");
+        break;
+
+    default:
+        /*
+         * The value was checked in visit_type_OnOffSplit() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -224,6 +264,16 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+#ifdef HOST_X86_64
+    hvf_kernel_irqchip = false;
+#else
+    hvf_kernel_irqchip = true;
+#endif
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
+        NULL, hvf_set_kernel_irqchip,
+        NULL, NULL);
+    object_class_property_set_description(oc, "kernel-irqchip",
+        "Configure HVF irqchip");
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 42eadc5ca9..6bd08759ba 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -10,3 +10,4 @@
 #include "system/hvf.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 50865e8115..391d5e6f76 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -838,7 +838,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -861,7 +861,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() &&
+         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
             if (vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
@@ -872,7 +873,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2119,7 +2120,15 @@ static void finalize_gic_version(VirtMachineState *vms)
         accel_name = "KVM with kernel-irqchip=off";
     } else if (whpx_enabled()) {
         gics_supported |= VIRT_GIC_VERSION_3_MASK;
-    } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
+    } else if (hvf_enabled()) {
+        if (!hvf_irqchip_in_kernel()) {
+            gics_supported |= VIRT_GIC_VERSION_2_MASK;
+        }
+        /* Hypervisor.framework doesn't expose EL2<->1 transition notifiers */
+        if (!(!hvf_irqchip_in_kernel() && vms->virt)) {
+            gics_supported |= VIRT_GIC_VERSION_3_MASK;
+        }
+    } else if (tcg_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
             gics_supported |= VIRT_GIC_VERSION_3_MASK;
@@ -2161,6 +2170,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2180,6 +2191,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("ITS not supported on WHPX.");
             exit(1);
         }
+        if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            error_report("ITS not supported on HVF when using the hardware vGIC.");
+            exit(1);
+        }
     }
 
     assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9c3fb2f4bf..f7ba74e6d5 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -33,6 +33,7 @@
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
 #include "system/whpx.h"
+#include "system/hvf.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -659,6 +660,8 @@ const char *gicv3_class_name(void)
         return "kvm-arm-gicv3";
     } else if (whpx_enabled()) {
         return TYPE_WHPX_GICV3;
+    } else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+        return TYPE_HVF_GICV3;
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d3dcf088b3..dc8da85979 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -26,8 +26,11 @@
 #ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
+extern bool hvf_kernel_irqchip;
+#define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
+#define hvf_irqchip_in_kernel() 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
diff --git a/system/vl.c b/system/vl.c
index aa9a155041..d3f311eff8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1778,6 +1778,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
                                    false);
         object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
                                    false);
+        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
+                                   false);
         qdict_del(qdict, "kernel-irqchip");
     }
 
-- 
2.50.1 (Apple Git-155)


