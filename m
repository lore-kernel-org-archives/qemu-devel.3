Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A84C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwsU-0008Cq-9B; Thu, 25 Apr 2024 07:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsH-00085l-VR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsD-0008GT-Ov
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34a00533d08so477939f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042955; x=1714647755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFyOmcP9zazcZyBZQtyOmZdkDwwfij0kGGeaUavMPCY=;
 b=JM3p7lNoymgGwo9QJIAXFDLyYvg1zWCIQUh5HhR0sAs3LWhlzep73kVohA7FD0s2vC
 8lo0fdYq0Zz+1H9Q9PiMaouFeqw02Ia4CjrsrkcuwQdlHKiJ42h6+iVg+yKtoS4E2IyW
 0kOdUmeXjsAJLAZq0PKTp7gCP7clcREo4RB50sLth7LOLeJVZs77JNtkGmTVSPm0tR1+
 upfmRvEBXwK70BG6hZn0RcUhbYiCEolR3bqwdfjOylExtwTmewNlYGh8cTBh5FSg91NQ
 HxvAgOmmDie/fyqa/aghpkkbQBdEXQNjjIAFo205DGRVyUZ6vu2grWDXaifh/jHNuPDS
 +m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042955; x=1714647755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFyOmcP9zazcZyBZQtyOmZdkDwwfij0kGGeaUavMPCY=;
 b=Prb6W3cN8QZ/Z4k6wNl9EL2a2w5BaAxE4xQzFDhf15lwvxq3TgEL6nPZwtH+9yUnaW
 ZarigvqMrdDjh2G5jK1lIg0rHPT0oLXN411C+jA2b7j5kGNtIOdqJlvtdD6lE73eKZ0c
 EH1gN0jc8p1g6gJPKuiOfOdqBM+47ZhzCBVtfqvf7r1QI+cnG0WKGgA4yk6sBYtnKRdb
 yRe1oguFL3lS5ZTM/Akb1t22fyUnfoTRNrI/vjIcL1RweXar7Px2Op+2b7ODBKF6ytAL
 esu7fUYrGiFG8PtIeCzJAy9MP2/pQU0I8M+9r7Z/bbf2VrgrUmMeqqGmAEvY9CTDTiXd
 Hvbw==
X-Gm-Message-State: AOJu0YyUiD4slfzsPafcn++/esVHwfcLxJbL6rj9VrlRBKqMzkszW9Ox
 v+QK7I9jIteWNDRswOAfzowdFuMb0tlO7ESt8PztV0Av9+v3Q+uLJROYxyjLCOW43d1kHhTWxDq
 L
X-Google-Smtp-Source: AGHT+IGbYXBotcggNmvYjJn0SeDlza7RBgJd8SuRBaPyoda0C+BK+2E4ZRY1R2o55gkIYXrS+UqrnQ==
X-Received: by 2002:a5d:6709:0:b0:341:d3b0:ae7d with SMTP id
 o9-20020a5d6709000000b00341d3b0ae7dmr4204754wru.45.1714042955056; 
 Thu, 25 Apr 2024 04:02:35 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 m18-20020adff392000000b00345920fcb45sm19699321wro.13.2024.04.25.04.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/22] target/i386: Move APIC related code to cpu-apic.c
Date: Thu, 25 Apr 2024 13:01:39 +0200
Message-ID: <20240425110157.20328-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Move APIC related code split in cpu-sysemu.c and
monitor.c to cpu-apic.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240321154838.95771-4-philmd@linaro.org>
---
 target/i386/cpu-apic.c   | 112 +++++++++++++++++++++++++++++++++++++++
 target/i386/cpu-sysemu.c |  77 ---------------------------
 target/i386/monitor.c    |  25 ---------
 target/i386/meson.build  |   1 +
 4 files changed, 113 insertions(+), 102 deletions(-)
 create mode 100644 target/i386/cpu-apic.c

diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
new file mode 100644
index 0000000000..d397ec94dc
--- /dev/null
+++ b/target/i386/cpu-apic.c
@@ -0,0 +1,112 @@
+/*
+ * QEMU x86 CPU <-> APIC
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/kvm.h"
+#include "sysemu/xen.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "hw/i386/apic_internal.h"
+#include "cpu-internal.h"
+
+APICCommonClass *apic_get_class(Error **errp)
+{
+    const char *apic_type = "apic";
+
+    /* TODO: in-kernel irqchip for hvf */
+    if (kvm_enabled()) {
+        if (!kvm_irqchip_in_kernel()) {
+            error_setg(errp, "KVM does not support userspace APIC");
+            return NULL;
+        }
+        apic_type = "kvm-apic";
+    } else if (xen_enabled()) {
+        apic_type = "xen-apic";
+    } else if (whpx_apic_in_platform()) {
+        apic_type = "whpx-apic";
+    }
+
+    return APIC_COMMON_CLASS(object_class_by_name(apic_type));
+}
+
+void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
+{
+    APICCommonState *apic;
+    APICCommonClass *apic_class = apic_get_class(errp);
+
+    if (!apic_class) {
+        return;
+    }
+
+    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
+    object_property_add_child(OBJECT(cpu), "lapic",
+                              OBJECT(cpu->apic_state));
+    object_unref(OBJECT(cpu->apic_state));
+
+    /* TODO: convert to link<> */
+    apic = APIC_COMMON(cpu->apic_state);
+    apic->cpu = cpu;
+    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
+
+    /*
+     * apic_common_set_id needs to check if the CPU has x2APIC
+     * feature in case APIC ID >= 255, so we need to set apic->cpu
+     * before setting APIC ID
+     */
+    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
+}
+
+void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
+{
+    APICCommonState *apic;
+    static bool apic_mmio_map_once;
+
+    if (cpu->apic_state == NULL) {
+        return;
+    }
+    qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
+
+    /* Map APIC MMIO area */
+    apic = APIC_COMMON(cpu->apic_state);
+    if (!apic_mmio_map_once) {
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            apic->apicbase &
+                                            MSR_IA32_APICBASE_BASE,
+                                            &apic->io_memory,
+                                            0x1000);
+        apic_mmio_map_once = true;
+     }
+}
+
+void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
+{
+    CPUState *cs;
+
+    if (qdict_haskey(qdict, "apic-id")) {
+        int id = qdict_get_try_int(qdict, "apic-id", 0);
+
+        cs = cpu_by_arch_id(id);
+        if (cs) {
+            cpu_synchronize_state(cs);
+        }
+    } else {
+        cs = mon_get_cpu(mon);
+    }
+
+
+    if (!cs) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+    x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
+}
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 3f9093d285..227ac021f6 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -19,19 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/xen.h"
-#include "sysemu/whpx.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "hw/qdev-properties.h"
-
-#include "exec/address-spaces.h"
-#include "hw/i386/apic_internal.h"
 
 #include "cpu-internal.h"
 
@@ -273,75 +266,6 @@ void x86_cpu_machine_reset_cb(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-APICCommonClass *apic_get_class(Error **errp)
-{
-    const char *apic_type = "apic";
-
-    /* TODO: in-kernel irqchip for hvf */
-    if (kvm_enabled()) {
-        if (!kvm_irqchip_in_kernel()) {
-            error_setg(errp, "KVM does not support userspace APIC");
-            return NULL;
-        }
-        apic_type = "kvm-apic";
-    } else if (xen_enabled()) {
-        apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
-        apic_type = "whpx-apic";
-    }
-
-    return APIC_COMMON_CLASS(object_class_by_name(apic_type));
-}
-
-void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
-{
-    APICCommonState *apic;
-    APICCommonClass *apic_class = apic_get_class(errp);
-
-    if (!apic_class) {
-        return;
-    }
-
-    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
-    object_property_add_child(OBJECT(cpu), "lapic",
-                              OBJECT(cpu->apic_state));
-    object_unref(OBJECT(cpu->apic_state));
-
-    /* TODO: convert to link<> */
-    apic = APIC_COMMON(cpu->apic_state);
-    apic->cpu = cpu;
-    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
-
-    /*
-     * apic_common_set_id needs to check if the CPU has x2APIC
-     * feature in case APIC ID >= 255, so we need to set apic->cpu
-     * before setting APIC ID
-     */
-    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
-}
-
-void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
-{
-    APICCommonState *apic;
-    static bool apic_mmio_map_once;
-
-    if (cpu->apic_state == NULL) {
-        return;
-    }
-    qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
-
-    /* Map APIC MMIO area */
-    apic = APIC_COMMON(cpu->apic_state);
-    if (!apic_mmio_map_once) {
-        memory_region_add_subregion_overlap(get_system_memory(),
-                                            apic->apicbase &
-                                            MSR_IA32_APICBASE_BASE,
-                                            &apic->io_memory,
-                                            0x1000);
-        apic_mmio_map_once = true;
-     }
-}
-
 GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -385,4 +309,3 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
-
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3a281dab02..2d766b2637 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -28,8 +28,6 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
@@ -647,26 +645,3 @@ const MonitorDef *target_monitor_defs(void)
 {
     return monitor_defs;
 }
-
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
-{
-    CPUState *cs;
-
-    if (qdict_haskey(qdict, "apic-id")) {
-        int id = qdict_get_try_int(qdict, "apic-id", 0);
-
-        cs = cpu_by_arch_id(id);
-        if (cs) {
-            cpu_synchronize_state(cs);
-        }
-    } else {
-        cs = mon_get_cpu(mon);
-    }
-
-
-    if (!cs) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
-    }
-    x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
-}
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 8abce725f8..075117989b 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -18,6 +18,7 @@ i386_system_ss.add(files(
   'arch_memory_mapping.c',
   'machine.c',
   'monitor.c',
+  'cpu-apic.c',
   'cpu-sysemu.c',
 ))
 i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
-- 
2.41.0


