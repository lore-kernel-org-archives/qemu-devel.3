Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB8FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEN-0001hQ-F0; Wed, 29 Apr 2026 15:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEM-0001hE-Ph
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:54 -0400
Received: from ms-2001a-snip4-11.eps.apple.com ([57.103.73.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEJ-0000J6-6K
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:54 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 9E2A518002E1; Wed, 29 Apr 2026 19:05:47 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YGXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489549; x=1780081549;
 bh=NatLKEv6d0zG65diyXKXr77lBgzgowHBdS0lt+oeRus=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Lf9wyI5fXsyJ4S0151/vFeITW6Kkx4wmTVt4ol2tnEzTqQ4aq4BoXudT1rL6fqHqxgfahxtVuiuE5cPnezAShHuMFGJRnqYxV6vygMEEybr1s1bodZZCTqtV3goOczH2D7hgEzSJaq/b7Is82CYfxZPd185ajOpNzFGyXpkNGFl7T0wi8IRyYndJJAAdVK/WQDD1gGv4s0ynApATWkfGAc4a8Oljfh4PqSniEuz6UptYN6pPJJQ+PKH8o0HMjznwGWDm4zD+urXYEy4dk6TWxVszM1P23mBw5pYdi4SW07qiLG6SwwhenRUIBeNnlNZKBmooaFqRboSkyt6ccKzFNQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 A9BA118000C6; Wed, 29 Apr 2026 19:05:44 +0000 (UTC)
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
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 03/15] accel, hw/arm,
 include/system/hvf: infrastructure changes for HVF vGIC
Date: Wed, 29 Apr 2026 21:05:20 +0200
Message-ID: <20260429190532.26538-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=bcFmkePB c=1 sm=1 tr=0 ts=69f2568c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=n4FVybPFTm1vobq06wUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX5R3lcag1UCwJ
 2ppbAVxOtmSHMfoVpUpleDF2kC1dkNtVdJ5ky3LFbMBT9TBaqyw+KlMdAxwknbFZXBvkM7rH+JY
 JSFaX3E5VqTXyvwA+uP6ZBrI1MVJymQtvzXu6KV/1Ows8+GxJLyo6e8c4Zn7bMRi2ucWIkkaUUI
 laJJGUNIHDeT16dLgpRow9TqarOyZER/s69AN+nBaDieDhuNjPcDPhabeo4qDwGuocOHK+CY0Y2
 fGvSDIKgkvn1kaXRSDMKcpBSIL+/kFFqpA95zhaciEWJUwnYT84DhqTNVOoFNawBJ73pFsGGokG
 cpakpHAR9NcUINJyL2SHzNf1MHiW0Rj6JzP9eKxE9DFy1hedudS5hMrEs/qmYo=
X-Proofpoint-GUID: tjCcbUcjSlmEf5j9lly3nWDqwdcg7ZBR
X-Proofpoint-ORIG-GUID: tjCcbUcjSlmEf5j9lly3nWDqwdcg7ZBR
Received-SPF: pass client-ip=57.103.73.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Misc changes needed for HVF vGIC enablement.

Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
Keeping an #ifdef here in case we end up supporting that...

However, given that x86_64 macOS is on its way out, it'll probably (?)
not be supported in QEMU.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c        | 46 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 23 +++++++++++++++----
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d19..add265e0c8 100644
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
@@ -21,6 +23,7 @@
 #include "trace.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -216,6 +219,43 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
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
@@ -223,6 +263,12 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+    hvf_kernel_irqchip = false;
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
index 77891f0820..47400214a2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1163,7 +1163,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -1186,7 +1186,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() &&
+         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
             if (vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
@@ -1197,7 +1198,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2444,7 +2445,15 @@ static void finalize_gic_version(VirtMachineState *vms)
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
@@ -2486,6 +2495,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2505,6 +2516,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
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
index 0e1fc217b4..516ed7890b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1781,6 +1781,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
                                    false);
         object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
                                    false);
+        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
+                                   false);
         qdict_del(qdict, "kernel-irqchip");
     }
 
-- 
2.50.1 (Apple Git-155)


