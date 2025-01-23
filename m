Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D1FC0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6uT-0003eg-Sv; Thu, 23 Jan 2025 18:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6ts-0000hh-JF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tj-0004Wh-Au
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1723454f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675965; x=1738280765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQ+5PubFZrrCYmUor7z2ohXZLQOj0+FDz6CQ50FZwrM=;
 b=FoioRx3PL/AeeneJUvRu40Bny2NuyZT2KKG3kq8XnX9xK/X11rL/4+Spw6+0UUJpt3
 P2Uip/6zPQKajgwrtLF4OGWovHSmxgRMLtiEAWl7rGQQ3383vEfNQjIqUTFnR778f32R
 PBAjyOG3FqPu6puYIrTlhnzTvGA8pkr1j5Ndi4M5WxS1ruenUHXBWtz/C+Yi42f32CTK
 AhHQwqA5eJ0ZRHstQuCrq7fp+xFNTDcj8+6S4cG922fjvlJKVZmZHzKDVDjBndTx8eQJ
 L8wLRMpDY54t2qoyfcio9DQA4vq02SAhC0FD3EWRUk4jKuaCml/Su3tM2ijx/ah5ZFkS
 7VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675965; x=1738280765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQ+5PubFZrrCYmUor7z2ohXZLQOj0+FDz6CQ50FZwrM=;
 b=Cfy6Xo3qxtvzKIC+ndbbXOIGwdAZQCgOPQvl2Cc6806oO7xty8KJdCn+7El5p0DD6l
 kvOhYAul3elSofzs/QPkTM9uJtMIVDH8v0Pky4KYjqf7J4ieE2r2u2s6IQDll1AZO9IN
 WQTht82GiADUdRyaLbFs+SFxXk+zAgPC/yu4GVtvTISbNRDmuMY/W3Rs3w/JouMgo28W
 uatsZvNtxqa9icosRvxH3wRTI63oCgzOtUGxtp4L/BtFWKiwCugpD77RB0Jj1R3VwJRP
 OYxToi0+ej637XEessdiXyE3zGfyhsM5pb39wQqYO1DPbpJV8g9NxtjNFuZEru4OWW0b
 kroA==
X-Gm-Message-State: AOJu0YwooFbbq0XB0Kn0dK6WNoBf1FqcxAUnKK69/bieKXX9O8ePPMb2
 zz4AGd8KtjcFdY3DwvQ/bQRIKD3YenZL+O5k3TiwVgBd9NvxwN90nCJzXrhJDipZMvnTKqY8BFc
 FeWQ=
X-Gm-Gg: ASbGncs9KPwaV9JRSSnGPIe83xi1rs0a6/hC/QjAwBmTOYxfB9N5GjvNbsyExZLZA2T
 0h/7tl5Qhv06ibgBUm/4OYKt71a1Hw+iZfJsfoLG62+io14TaHNzJzQdREjcXpf5ypcDBUshVAD
 lUB4VOAPEVq+zGJiPpVyWM0YXbacvUWx5sCkAZjOKTyYudNykDaky1gum9pLcCoHPT4w5F8ig9a
 OjbWd+rG9qqsMKkMBXAemvhNi7zwqZIMYEXVq0A+uUwydWCL+nLsg7j1hWt5Fu3axRyb5xhIGTo
 MuXOWb/e5eo8LUOWp1WKdkJUzTDniAoVgeg5PPPQVakDWRHFextqoao=
X-Google-Smtp-Source: AGHT+IGsiKZVvuhBn67VKbvp7ZCKdJegwhgfqv/IiEk5xyysRNRbKSY3tyJ6LqHq9Om3O3Zv9Xfmsw==
X-Received: by 2002:adf:f250:0:b0:38a:5dc4:6dcd with SMTP id
 ffacd0b85a97d-38c22279dafmr4343550f8f.22.1737675965020; 
 Thu, 23 Jan 2025 15:46:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c403asm989733f8f.93.2025.01.23.15.46.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:46:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/20] cpus: Register VMState per user / system emulation
Date: Fri, 24 Jan 2025 00:44:13 +0100
Message-ID: <20250123234415.59850-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Simplify cpu-target.c by extracting mixed vmstate code
into the cpu_vmstate_register() / cpu_vmstate_unregister()
helpers, implemented in cpu-user.c and cpu-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
XXX: tlb_flush() temporary declared manually.

Only 2 more CONFIG_USER_ONLY to go.
---
 include/hw/core/cpu.h |   2 +
 cpu-target.c          | 122 +----------------------------------------
 hw/core/cpu-system.c  | 123 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/cpu-user.c    |  12 +++++
 4 files changed, 139 insertions(+), 120 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc53..aadbd2e1122 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1163,6 +1163,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_initfn(CPUState *cpu);
+void cpu_vmstate_register(CPUState *cpu);
+void cpu_vmstate_unregister(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
diff --git a/cpu-target.c b/cpu-target.c
index 3d33d20b8c8..bfcd48f9ae2 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -21,115 +21,16 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#include "migration/vmstate.h"
-#ifndef CONFIG_USER_ONLY
-#include "hw/core/sysemu-cpu-ops.h"
-#endif
 #include "system/accel-ops.h"
 #include "system/cpus.h"
-#include "system/tcg.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
-#include "exec/exec-all.h"
-#include "exec/tb-flush.h"
 #include "exec/log.h"
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 #include "hw/core/cpu.h"
 
-#ifndef CONFIG_USER_ONLY
-static int cpu_common_post_load(void *opaque, int version_id)
-{
-#ifdef CONFIG_TCG
-    if (tcg_enabled()) {
-        CPUState *cpu = opaque;
-
-        /*
-         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-         * version_id is increased.
-         */
-        cpu->interrupt_request &= ~0x01;
-
-        tlb_flush(cpu);
-
-        /*
-         * loadvm has just updated the content of RAM, bypassing the
-         * usual mechanisms that ensure we flush TBs for writes to
-         * memory we've translated code from. So we must flush all TBs,
-         * which will now be stale.
-         */
-        tb_flush(cpu);
-    }
-#endif
-
-    return 0;
-}
-
-static int cpu_common_pre_load(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    cpu->exception_index = -1;
-
-    return 0;
-}
-
-static bool cpu_common_exception_index_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return tcg_enabled() && cpu->exception_index != -1;
-}
-
-static const VMStateDescription vmstate_cpu_common_exception_index = {
-    .name = "cpu_common/exception_index",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_exception_index_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(exception_index, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static bool cpu_common_crash_occurred_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return cpu->crash_occurred;
-}
-
-static const VMStateDescription vmstate_cpu_common_crash_occurred = {
-    .name = "cpu_common/crash_occurred",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_crash_occurred_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_BOOL(crash_occurred, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-const VMStateDescription vmstate_cpu_common = {
-    .name = "cpu_common",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_load = cpu_common_pre_load,
-    .post_load = cpu_common_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(halted, CPUState),
-        VMSTATE_UINT32(interrupt_request, CPUState),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription * const []) {
-        &vmstate_cpu_common_exception_index,
-        &vmstate_cpu_common_crash_occurred,
-        NULL
-    }
-};
-#endif
-
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
@@ -139,33 +40,14 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
-#ifdef CONFIG_USER_ONLY
-    assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
-           qdev_get_vmsd(DEVICE(cpu))->unmigratable);
-#else
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
-    }
-    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_register(NULL, cpu->cpu_index, cpu->cc->sysemu_ops->legacy_vmsd, cpu);
-    }
-#endif /* CONFIG_USER_ONLY */
+    cpu_vmstate_register(cpu);
 
     return true;
 }
 
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
-    }
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
-    }
-#endif
+    cpu_vmstate_unregister(cpu);
 
     cpu_list_remove(cpu);
     /*
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 0520c362db4..3e1f60f23df 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -22,10 +22,21 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
+#include "exec/tb-flush.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
+#include "migration/vmstate.h"
+#include "system/tcg.h"
+
+/*
+ * XXX this series plan is to be applied on top on my exec/cputlb rework series,
+ * then tlb_flush() won't be declared target-specific in exec-all.h.
+ * Meanwhile, declare locally.
+ * XXX
+ */
+void tlb_flush(CPUState *cs);
 
 bool cpu_paging_enabled(const CPUState *cpu)
 {
@@ -189,3 +200,115 @@ void cpu_exec_initfn(CPUState *cpu)
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
 }
+
+static int cpu_common_post_load(void *opaque, int version_id)
+{
+#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
+        CPUState *cpu = opaque;
+
+        /*
+         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+         * version_id is increased.
+         */
+        cpu->interrupt_request &= ~0x01;
+
+        tlb_flush(cpu);
+
+        /*
+         * loadvm has just updated the content of RAM, bypassing the
+         * usual mechanisms that ensure we flush TBs for writes to
+         * memory we've translated code from. So we must flush all TBs,
+         * which will now be stale.
+         */
+        tb_flush(cpu);
+    }
+#endif
+
+    return 0;
+}
+
+static int cpu_common_pre_load(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    cpu->exception_index = -1;
+
+    return 0;
+}
+
+static bool cpu_common_exception_index_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return tcg_enabled() && cpu->exception_index != -1;
+}
+
+static const VMStateDescription vmstate_cpu_common_exception_index = {
+    .name = "cpu_common/exception_index",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_exception_index_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(exception_index, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cpu_common_crash_occurred_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return cpu->crash_occurred;
+}
+
+static const VMStateDescription vmstate_cpu_common_crash_occurred = {
+    .name = "cpu_common/crash_occurred",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_crash_occurred_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(crash_occurred, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_cpu_common = {
+    .name = "cpu_common",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = cpu_common_pre_load,
+    .post_load = cpu_common_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(halted, CPUState),
+        VMSTATE_UINT32(interrupt_request, CPUState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cpu_common_exception_index,
+        &vmstate_cpu_common_crash_occurred,
+        NULL
+    }
+};
+
+void cpu_vmstate_register(CPUState *cpu)
+{
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
+    }
+    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_register(NULL, cpu->cpu_index, cpu->cc->sysemu_ops->legacy_vmsd, cpu);
+    }
+}
+
+void cpu_vmstate_unregister(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
+    }
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
+    }
+}
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index cdd8de2fefa..1892acdee0f 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -10,6 +10,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
+#include "migration/vmstate.h"
 
 static const Property cpu_user_props[] = {
     /*
@@ -30,3 +31,14 @@ void cpu_exec_initfn(CPUState *cpu)
 {
     /* nothing to do */
 }
+
+void cpu_vmstate_register(CPUState *cpu)
+{
+    assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
+           qdev_get_vmsd(DEVICE(cpu))->unmigratable);
+}
+
+void cpu_vmstate_unregister(CPUState *cpu)
+{
+    /* nothing to do */
+}
-- 
2.47.1


