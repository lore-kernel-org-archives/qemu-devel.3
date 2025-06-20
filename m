Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5217C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6y-000684-JT; Fri, 20 Jun 2025 18:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfX6-00074N-MV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfX4-0005so-NM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so13485465e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440484; x=1751045284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WY9x0NPRZ8lLtMj2Ul1MxvXDA5qTO7mgp4F1gZCrJ00=;
 b=ZSkfG3VRV8xlWrxaK7LrILYqSSx1mH54z5nJa2Cft9G5JPMsAGqwXMIYGrAwUDw5Qq
 emO7rQeK8csi2Qi1oBRbRYXiX3qXKvOsY/ppidMMm7iggeXq36dqRGBRCu/XCHHd/saN
 B9tzKzfeO9xIGMtl1HAKE44CKhhplI63uNqkkPkACUNbdikXmlIBrBnVOkT/rfRLUTvu
 iQgFz39yTCkjvX9K2I2Uq/aLPE7Aw9AmB3UJoaEIirHZv4DuJb7nU6+TpnLJoN6eXDOU
 vOB5ZMs0XxrkZ7/WWu5iXyrFUw6AW5aoVZiomFXbfHJafeW6IAm0Dr2q1BoJqLPa80kJ
 ZqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440484; x=1751045284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WY9x0NPRZ8lLtMj2Ul1MxvXDA5qTO7mgp4F1gZCrJ00=;
 b=f2T118EHBE/8jWg/ComcYKqT8OCC3Retvik8jCrztXX+jsELagh/ay2SRykHs6bb2f
 ocAm2QOt/xRTZp0oeIIA8smTbRE1LGClLK9ANje+w+sQoJiQXTz3uvEhx8Q+GCDvLIQy
 p1N9AQr5any7UBHpf6VZQX2iitB+K7nD5SHJZAgU61fbyuKvc3BWrIc9knlSVV15Trsf
 6JDCunPSS3ToR8Fb5Sm72KZuFvrMbA9ZhAwRmk4w1W+Zt8Grdk3NZnSufSOaRbJdgF+U
 OH+XHxBtcZha/FXo10ArdOt9vwOpu/Atc9Mr/qqXaRvTf9ZmNEwXlk+RLRtYFTv2pqE7
 X+iQ==
X-Gm-Message-State: AOJu0YzOH6ALswoWfg45mJmcY6fRYWiqJY8MzRu0Q/pSQabPEeK16gyW
 qGfBc3a0Rcms6WKrotKdTF5UJj249Sc+jo7vpg2osLuST2uqgTVyAdDXtBQknubH6xQqfWzMGBw
 quSD0NC5cEQ==
X-Gm-Gg: ASbGncu3IsVZvew0yG2+zbs/cRalEuVOISbLIn2HCd86fA61s8+Uvrax0t6B+LSnzaz
 MSJZ7tYq5DYB3av+Fa1jeEc7uKA0NkgLFiBS7mEKy3WO1YJ5BdJqBqCJinNjF/EJCHKZ4sN5knC
 ASomtavygc6og4LENlYJIkb/JRC0UarqVfFKyJiLyLpE2cYBoI/m0ng+O5UC2NHJfKAIwOn50D2
 jQv5LPUPFgQxhkNU33ZiauzqjS6Ruww5MtrXVOyBCeP9swOhK91+AIXwLGbd0ZUScjHc2xqkBHa
 XgOc1dXuHoF1iTS2mNxDpS2ZJ/3PLyt1zjuhXjB2zcx9OmRpXNhjHyIOmI422+wF4fxJ7q1FUsq
 JtYGLF9aIh9GoIDT/ulZBjfVgxffyU0XfcMKklD7xp83mKEROnAh3gX63
X-Google-Smtp-Source: AGHT+IGfPbks2FB37bm5yo7wepwWDdRzVZPIELoie3p25O7BG+jzrxcfrj9nNfHtvdkzYDre3/gRig==
X-Received: by 2002:a05:600c:83c7:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-453655c6169mr42573945e9.17.1750440484389; 
 Fri, 20 Jun 2025 10:28:04 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8e19sm65079415e9.21.2025.06.20.10.28.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 01/42] accel/split: Minimal stubs for split
 accelerator
Date: Fri, 20 Jun 2025 19:27:09 +0200
Message-ID: <20250620172751.94231-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Julian Armistead <julian.armistead@linaro.org>

Signed-off-by: Julian Armistead <julian.armistead@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 161 ++++++++++++++++++++++++++++++++++
 accel/split/split-all.c       |  77 ++++++++++++++++
 system/vl.c                   |   4 +
 accel/Kconfig                 |   6 ++
 accel/meson.build             |   1 +
 accel/split/meson.build       |   9 ++
 6 files changed, 258 insertions(+)
 create mode 100644 accel/split/split-accel-ops.c
 create mode 100644 accel/split/split-all.c
 create mode 100644 accel/split/meson.build

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
new file mode 100644
index 00000000000..e5c1d51d426
--- /dev/null
+++ b/accel/split/split-accel-ops.c
@@ -0,0 +1,161 @@
+/*
+ * QEMU "split" accelerator (HW + SW) ops
+ *
+ * Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/accel-ops.h"
+
+static void *split_cpu_thread_routine(void *arg)
+{
+    g_assert_not_reached();
+}
+
+static void split_ops_init(AccelClass *ac)
+{
+    g_assert_not_reached();
+}
+
+static bool split_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+static void split_cpu_common_unrealize(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_cpu_reset_hold(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_kick_vcpu_thread(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static bool split_cpu_thread_is_idle(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_synchronize_post_reset(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_synchronize_post_init(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_synchronize_state(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_synchronize_pre_loadvm(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_synchronize_pre_resume(bool step_pending)
+{
+    g_assert_not_reached();
+}
+
+static void split_handle_interrupt(CPUState *cpu, int mask)
+{
+    g_assert_not_reached();
+}
+
+static int64_t split_get_virtual_clock(void)
+{
+    g_assert_not_reached();
+}
+
+static void split_set_virtual_clock(int64_t time)
+{
+    g_assert_not_reached();
+}
+
+static int64_t split_get_elapsed_ticks(void)
+{
+    g_assert_not_reached();
+}
+
+static int split_update_guest_debug(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static int split_insert_breakpoint(CPUState *cpu, int type,
+                                   vaddr addr, vaddr len)
+{
+    g_assert_not_reached();
+}
+
+static int split_remove_breakpoint(CPUState *cpu, int type,
+                                   vaddr addr, vaddr len)
+{
+    g_assert_not_reached();
+}
+
+static void split_remove_all_breakpoints(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
+
+static void split_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    g_assert_not_reached();
+}
+
+static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->ops_init = split_ops_init;
+    ops->cpu_common_realize = split_cpu_common_realize;
+    ops->cpu_common_unrealize = split_cpu_common_unrealize;
+    ops->cpu_reset_hold = split_cpu_reset_hold;
+    ops->cpu_thread_routine = split_cpu_thread_routine;
+    ops->kick_vcpu_thread = split_kick_vcpu_thread;
+    ops->cpu_thread_is_idle = split_cpu_thread_is_idle;
+
+    ops->synchronize_post_reset = split_synchronize_post_reset;
+    ops->synchronize_post_init = split_synchronize_post_init;
+    ops->synchronize_state = split_synchronize_state;
+    ops->synchronize_pre_loadvm = split_synchronize_pre_loadvm;
+    ops->synchronize_pre_resume = split_synchronize_pre_resume;
+
+    ops->handle_interrupt = split_handle_interrupt;
+    ops->get_vcpu_stats = split_get_vcpu_stats;
+
+    ops->get_virtual_clock = split_get_virtual_clock;
+    ops->set_virtual_clock = split_set_virtual_clock;
+    ops->get_elapsed_ticks = split_get_elapsed_ticks;
+
+    ops->update_guest_debug = split_update_guest_debug;
+    ops->insert_breakpoint = split_insert_breakpoint;
+    ops->remove_breakpoint = split_remove_breakpoint;
+    ops->remove_all_breakpoints = split_remove_all_breakpoints;
+}
+
+static const TypeInfo split_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("split"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = split_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void split_accel_ops_register_types(void)
+{
+    type_register_static(&split_accel_ops_type);
+}
+type_init(split_accel_ops_register_types);
diff --git a/accel/split/split-all.c b/accel/split/split-all.c
new file mode 100644
index 00000000000..7e308f3c1e7
--- /dev/null
+++ b/accel/split/split-all.c
@@ -0,0 +1,77 @@
+/*
+ * QEMU "split" accelerator (HW + SW emulator)
+ *
+ * Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+
+bool split_allowed;
+
+static int split_accel_init_machine(MachineState *ms, AccelState *as)
+{
+    g_assert_not_reached();
+}
+
+static void split_setup_post(MachineState *ms, AccelState *accel)
+{
+    g_assert_not_reached();
+}
+
+static bool split_has_memory(MachineState *ms, AddressSpace *as,
+                             hwaddr start_addr, hwaddr size)
+{
+    g_assert_not_reached();
+}
+
+static bool split_cpus_are_resettable(AccelState *as)
+{
+    g_assert_not_reached();
+}
+
+static bool split_supports_guest_debug(AccelState *as)
+{
+    g_assert_not_reached();
+}
+
+static int split_gdbstub_supported_sstep_flags(AccelState *as)
+{
+    g_assert_not_reached();
+}
+
+static void split_get_stats(AccelState *as, GString *buf)
+{
+    g_assert_not_reached();
+}
+
+static void split_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "split";
+    ac->init_machine = split_accel_init_machine;
+    ac->setup_post = split_setup_post;
+    ac->has_memory = split_has_memory;
+    ac->cpus_are_resettable = split_cpus_are_resettable;
+    ac->supports_guest_debug = split_supports_guest_debug;
+    ac->gdbstub_supported_sstep_flags = split_gdbstub_supported_sstep_flags;
+    ac->get_stats = split_get_stats;
+    ac->allowed = &split_allowed;
+    ac->compat_props = NULL;
+}
+
+static const TypeInfo split_accel_type = {
+    .name = ACCEL_CLASS_NAME("split"),
+    .parent = TYPE_ACCEL,
+    .class_init = split_accel_class_init,
+};
+
+static void register_accel_types(void)
+{
+    type_register_static(&split_accel_type);
+}
+
+type_init(register_accel_types);
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c66..c7111d743ab 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2433,6 +2433,7 @@ static void configure_accelerators(const char *progname)
             bool have_tcg = accel_find("tcg");
             bool have_kvm = accel_find("kvm");
             bool have_hvf = accel_find("hvf");
+            bool have_split = accel_find("split");
 
             if (have_tcg && have_kvm) {
                 if (g_str_has_suffix(progname, "kvm")) {
@@ -2447,6 +2448,9 @@ static void configure_accelerators(const char *progname)
                 accelerators = "tcg";
             } else if (have_hvf) {
                 accelerators = "hvf";
+            } else if (have_split) {
+                assert(have_tcg);
+                accelerators = "split";
             } else {
                 error_report("No accelerator selected and"
                              " no default accelerator available");
diff --git a/accel/Kconfig b/accel/Kconfig
index 4263cab7227..122ca9945ad 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -10,6 +10,12 @@ config HVF
 config TCG
     bool
 
+config SPLIT
+    bool
+    default y
+    depends on TCG
+    depends on HVF
+
 config KVM
     bool
 
diff --git a/accel/meson.build b/accel/meson.build
index 52909314bfa..b6d4740725f 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -9,6 +9,7 @@ if have_system
   subdir('qtest')
   subdir('kvm')
   subdir('xen')
+  subdir('split')
   subdir('stubs')
 endif
 
diff --git a/accel/split/meson.build b/accel/split/meson.build
new file mode 100644
index 00000000000..fbc68593180
--- /dev/null
+++ b/accel/split/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+split_ss = ss.source_set()
+split_ss.add(files(
+  'split-all.c',
+  'split-accel-ops.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_SPLIT', if_true: split_ss)
-- 
2.49.0


