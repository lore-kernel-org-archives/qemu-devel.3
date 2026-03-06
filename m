Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF43EFCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfq-0005zX-Ie; Fri, 06 Mar 2026 10:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfG-0004ha-IP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfD-0002mP-UA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso1372115e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809226; x=1773414026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I1bZ8nhuwxwX9BX57Sucbp1Bxm79tBvkjf4sRE4Bo1s=;
 b=wfsnsvpFCweBCWFWawukWVRtxcSRfCbAaLxBKptghkyyyDUfOvnikUUYoYEtCRMZmA
 aHU51u7L0qqsGWZbR6AiOaKVUI1oqBArQ0hyEmaKRXgG1uUTwbg0yiDeiFJe+uVMMiMf
 1h3K7JzbOu2DgWZKISD3qj8RLvDL70PVRs9iK139MRcG+9T9vi3F5bC+bvYrKlVe+IgR
 hGB0NTcH+1iejT9IQk0Git+TROvmqKmkXANqdwVQTnYLVPqqPs6DS8qjyi5FKIm954je
 wCq7q2qX5oRhO+aYIIGyzH6YHjJddxGT9pQ2cQQkCwRE/c9ujIUj7kXyBBaznBBaHlBM
 FRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809226; x=1773414026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I1bZ8nhuwxwX9BX57Sucbp1Bxm79tBvkjf4sRE4Bo1s=;
 b=cXT9EPW9z8quU260DXhlXpdtEirTqHcX983AymMqyMRyZ/FuZo5H3Q8O9exYddWVQi
 Ou9jis3jHdgNULowwI2avipxAO1d0U8pfbn1eVNnmWZka9mqWO+5HOW87vlfg5ea641a
 BC85PPmhH1iLgZY52UngoC/KtjUKN6aV64uHD+bv+Phori8GHJPLkwNGO0rkqG2j6sYH
 DTLXqSirLsIBqZRxtDs4r0lRpUffem/Gp5fNYFgO5ZywdD+OrHHEveC6MXme59WjqxWA
 yC9aVwFyFmfyUKCUwhY/IZ1iUKeFo0aUFAjyO8kqZMV02EpmeIg0UI3H2/7nP8kjLiRo
 A8nA==
X-Gm-Message-State: AOJu0YxKTYblV4NY4QGtd4FoOb1kwO/jB1/DCsW6HQlP1QuhaJLW1tDK
 ed0FcIKFoUAV82Bgckosewr8oTTDo+k/Cza4AN9X+KaLuIVGOgoYtC9aiv8WrwpIkDIILdjunJe
 rw2ek
X-Gm-Gg: ATEYQzx0+942CkUVHDrdLzqgZ7EZl/OLd/OfTdRtkASemLNcyFsBg6UxDF+vSTtkjXM
 geeVk1fU9YAnQvfI45a/nLd3qcvWH1FaZC1wX8NGnZewCRyoSsrolcoQuj8qbo8OWRBsrgsUTdg
 3Se40/dlcpvatgV0CSzuRqDtK/rAYaMDJSrNKbMrwpmJTVuvPdbmC/YBT8ZbawE6GUbVOPikufH
 LfkdJ8X4y7U4U4LL4MhsMBA2uDs6XfBnEVSgKvkOFGZL2b/S/Vmg9pUqDX7CE2qfCz6pw0KKI5i
 aWjzL6x+WKjVh+s487htPeIU+EJjxPcxGo73pwbZvtzoGDWuue7qj7ebrpXMYFEYumpahkGX6xS
 u6JRVBFvb6pwIW8rbkpGd+0JsWFT/AXGOUPWORmmAex6ADi7pB5PGfkptnnis8rC1lUjmkCEBSG
 /tZfDF4+tA4rWgxHhHv8JJ08E1q6RVWoHKvqnezKMYhgb4fE6Gw8s7RwA3mZrkGVzUdBqX0kJdy
 pyqkgHl0cz7ZMay2LVhwpNN3E5Sa9o=
X-Received: by 2002:a05:600c:c088:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-48526919935mr35859445e9.7.1772809225589; 
 Fri, 06 Mar 2026 07:00:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/49] accel, hw/arm,
 include/system/hvf: infrastructure changes for HVF vGIC
Date: Fri,  6 Mar 2026 14:59:29 +0000
Message-ID: <20260306145939.2162189-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Misc changes needed for HVF vGIC enablement.

Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
Keeping an #ifdef here in case we end up supporting that...

However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-8-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 23 +++++++++++++++---
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d19..a296b108bc 100644
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
@@ -223,6 +263,16 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
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
index 7456614d05..7a6fad1094 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -837,7 +837,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -860,7 +860,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() &&
+         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
             if (vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
@@ -871,7 +872,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2118,7 +2119,15 @@ static void finalize_gic_version(VirtMachineState *vms)
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
@@ -2160,6 +2169,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2179,6 +2190,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
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
index 3e341142a0..7a3db97ee6 100644
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
2.43.0


