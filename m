Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EA8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L41-0004e8-5x; Fri, 25 Apr 2025 11:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3R-00032V-6Q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3N-0004Kk-K9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so26295815e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595204; x=1746200004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgU18kMucyx42rS04v1N03yc2dnE26niA7+gRIPIZtY=;
 b=d8CMpqyCbztZQhpYyX1XeDIV6yZ1BqO0ii1WipKVGZ+ulmH+NncVFSKOkHo7Ic1LHI
 pagWUTf55XZBhUgzdR/ZTc+XPzoVg+RzI9xeGwcu4XDq0JDbMx8pJ0cYp12RDwtQE/s7
 48/R3VHPSTUiv+2c8864UNlLb2XdV6DVSkwEtpBjsNGoPuoY6rb/a66TK3xdoM2HFuZj
 EVuByLXKysGGMPFDBcXIztR0JMMkNj2GFShP450AbCIYGW1m7yQaQ00S/38EHP1ukVDT
 4m8XXpsymuKkog4DWn8bXAM5qNLukJtDEzfhsrVAy5qqqxGcfOwWSTk6pmxGTU0RJDc/
 Go3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595204; x=1746200004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgU18kMucyx42rS04v1N03yc2dnE26niA7+gRIPIZtY=;
 b=l8KDnYK8fU8FtQT65bVFl395Clcq6K89HlA99HD2EQzrSrmJNJVAIzQOXtlFDwcc+S
 lGkRIO+ES73cNPXsP654BUr/lyLUmQpMSMtFZ33wUD97T1Bt/FgZy2HNNA7ruuUcjzcE
 RvhCsTH5YTONyHVFR8p8E2DpSBi0FV2J9igX942nWOnYaZCmxcTcF7FsPMDOC8FRQeaO
 2gFaBBqh4nvwY+t3W+QQT0+9GZThG6ktgNuS979jHerJWsXo16OkkYDjK4i8UlIiqQtR
 M4THQmuA9bPcfEDpqD2ghSPWk4zfpUFK5RvhGAaEeireDJGOMBN0Ksjj54SIgdOINWAo
 dgew==
X-Gm-Message-State: AOJu0YwMHa/j1/fQOUYh7Y7oOa/QgWhuo1hofDYBM5zW5++sc/RRFYPu
 lMFh1oXbSEWkYJ0Cp/4S5sI934nRze/AaQ75TvpEmH51bYapyBO/M9Y0l2fU3xuUhrMt79RG/ME
 N
X-Gm-Gg: ASbGncsHl6+09TSwwHgv6AP5tVvSyxZNW8NxOlqT7RmlyfqtbqJ80usnhtAezrOi0im
 WPdxlMK9hBw3oCE8JCdLhoemtgwp4S0+baKxic+905sybbttqkVNaYLvyaDrGVePfQgv4V9PqJ7
 qz7KLdWJAXu3u2lJVlZeEixMEGA8IO0ANOTNgQ/rJ6K8dIhrMffGSpZ4KEfOHedS6hyPuki6meN
 qjpL3CiJBUqbAA1r/rt9ul7L+qshYAwTA+O6VQOteSCg/TbL/b9xSyzMsoUvt6aiYduysfSZYyd
 l6/aFfLuz9G7+oQMKiq+g4GMjBTa0ZH6NY6AgNbJXmkHHF3YkKqXdCen6UOW8Esx95/FUKN4z6x
 r3XqBru69b37OnT4=
X-Google-Smtp-Source: AGHT+IHE6WaWNI4pmpEOxv7xlzzPQAH3nM/FZWPiOyDDx8TtKwDdzF+HSv7b7KehRyE5qL7KnNaUcQ==
X-Received: by 2002:a05:600c:3b21:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-4409c454190mr73040605e9.3.1745595203750; 
 Fri, 25 Apr 2025 08:33:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedf4sm2647762f8f.45.2025.04.25.08.33.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 57/58] accel: Move target-agnostic code from accel-target.c ->
 accel-common.c
Date: Fri, 25 Apr 2025 17:28:41 +0200
Message-ID: <20250425152843.69638-58-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Various methods of accel-target.c don't use any target-specific
knowledge at all and can be built once in the target-agnostic
accel-common.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250417165430.58213-8-philmd@linaro.org>
---
 accel/accel-common.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 accel/accel-target.c | 129 ---------------------------------------
 accel/meson.build    |   1 +
 3 files changed, 143 insertions(+), 129 deletions(-)
 create mode 100644 accel/accel-common.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
new file mode 100644
index 00000000000..4894b98d64a
--- /dev/null
+++ b/accel/accel-common.c
@@ -0,0 +1,142 @@
+/*
+ * QEMU accel class, components common to system emulation and user mode
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/target-info.h"
+#include "accel/accel-cpu.h"
+#include "accel-internal.h"
+
+/* Lookup AccelClass from opt_name. Returns NULL if not found */
+AccelClass *accel_find(const char *opt_name)
+{
+    char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
+    AccelClass *ac = ACCEL_CLASS(module_object_class_by_name(class_name));
+    g_free(class_name);
+    return ac;
+}
+
+/* Return the name of the current accelerator */
+const char *current_accel_name(void)
+{
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+
+    return ac->name;
+}
+
+static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
+{
+    CPUClass *cc = CPU_CLASS(klass);
+    AccelCPUClass *accel_cpu = opaque;
+
+    /*
+     * The first callback allows accel-cpu to run initializations
+     * for the CPU, customizing CPU behavior according to the accelerator.
+     *
+     * The second one allows the CPU to customize the accel-cpu
+     * behavior according to the CPU.
+     *
+     * The second is currently only used by TCG, to specialize the
+     * TCGCPUOps depending on the CPU type.
+     */
+    cc->accel_cpu = accel_cpu;
+    if (accel_cpu->cpu_class_init) {
+        accel_cpu->cpu_class_init(cc);
+    }
+    if (cc->init_accel_cpu) {
+        cc->init_accel_cpu(accel_cpu, cc);
+    }
+}
+
+/* initialize the arch-specific accel CpuClass interfaces */
+static void accel_init_cpu_interfaces(AccelClass *ac)
+{
+    const char *ac_name; /* AccelClass name */
+    char *acc_name;      /* AccelCPUClass name */
+    ObjectClass *acc;    /* AccelCPUClass */
+    const char *cpu_resolving_type = target_cpu_type();
+
+    ac_name = object_class_get_name(OBJECT_CLASS(ac));
+    g_assert(ac_name != NULL);
+
+    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
+    acc = object_class_by_name(acc_name);
+    g_free(acc_name);
+
+    if (acc) {
+        object_class_foreach(accel_init_cpu_int_aux,
+                             cpu_resolving_type, false, acc);
+    }
+}
+
+void accel_init_interfaces(AccelClass *ac)
+{
+    accel_init_ops_interfaces(ac);
+    accel_init_cpu_interfaces(ac);
+}
+
+void accel_cpu_instance_init(CPUState *cpu)
+{
+    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+        cpu->cc->accel_cpu->cpu_instance_init(cpu);
+    }
+}
+
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* target specific realization */
+    if (cpu->cc->accel_cpu
+        && cpu->cc->accel_cpu->cpu_target_realize
+        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
+
+    /* generic realization */
+    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+void accel_cpu_common_unrealize(CPUState *cpu)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* generic unrealization */
+    if (acc->cpu_common_unrealize) {
+        acc->cpu_common_unrealize(cpu);
+    }
+}
+
+int accel_supported_gdbstub_sstep_flags(void)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->gdbstub_supported_sstep_flags) {
+        return acc->gdbstub_supported_sstep_flags();
+    }
+    return 0;
+}
+
+static const TypeInfo accel_types[] = {
+    {
+        .name           = TYPE_ACCEL,
+        .parent         = TYPE_OBJECT,
+        .class_size     = sizeof(AccelClass),
+        .instance_size  = sizeof(AccelState),
+        .abstract       = true,
+    },
+};
+
+DEFINE_TYPES(accel_types)
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 82a29e61476..7fd392fbc4a 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -24,135 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "qemu/target-info.h"
-
 #include "accel/accel-cpu-target.h"
-#include "accel-internal.h"
-
-static const TypeInfo accel_type = {
-    .name = TYPE_ACCEL,
-    .parent = TYPE_OBJECT,
-    .class_size = sizeof(AccelClass),
-    .instance_size = sizeof(AccelState),
-    .abstract = true,
-};
-
-/* Lookup AccelClass from opt_name. Returns NULL if not found */
-AccelClass *accel_find(const char *opt_name)
-{
-    char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
-    AccelClass *ac = ACCEL_CLASS(module_object_class_by_name(class_name));
-    g_free(class_name);
-    return ac;
-}
-
-/* Return the name of the current accelerator */
-const char *current_accel_name(void)
-{
-    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
-
-    return ac->name;
-}
-
-static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
-{
-    CPUClass *cc = CPU_CLASS(klass);
-    AccelCPUClass *accel_cpu = opaque;
-
-    /*
-     * The first callback allows accel-cpu to run initializations
-     * for the CPU, customizing CPU behavior according to the accelerator.
-     *
-     * The second one allows the CPU to customize the accel-cpu
-     * behavior according to the CPU.
-     *
-     * The second is currently only used by TCG, to specialize the
-     * TCGCPUOps depending on the CPU type.
-     */
-    cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
-    if (cc->init_accel_cpu) {
-        cc->init_accel_cpu(accel_cpu, cc);
-    }
-}
-
-/* initialize the arch-specific accel CpuClass interfaces */
-static void accel_init_cpu_interfaces(AccelClass *ac)
-{
-    const char *ac_name; /* AccelClass name */
-    char *acc_name;      /* AccelCPUClass name */
-    ObjectClass *acc;    /* AccelCPUClass */
-    const char *cpu_resolving_type = target_cpu_type();
-
-    ac_name = object_class_get_name(OBJECT_CLASS(ac));
-    g_assert(ac_name != NULL);
-
-    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
-    acc = object_class_by_name(acc_name);
-    g_free(acc_name);
-
-    if (acc) {
-        object_class_foreach(accel_init_cpu_int_aux,
-                             cpu_resolving_type, false, acc);
-    }
-}
-
-void accel_init_interfaces(AccelClass *ac)
-{
-    accel_init_ops_interfaces(ac);
-    accel_init_cpu_interfaces(ac);
-}
-
-void accel_cpu_instance_init(CPUState *cpu)
-{
-    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
-        cpu->cc->accel_cpu->cpu_instance_init(cpu);
-    }
-}
-
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-
-    /* target specific realization */
-    if (cpu->cc->accel_cpu
-        && cpu->cc->accel_cpu->cpu_target_realize
-        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
-        return false;
-    }
-
-    /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
-        return false;
-    }
-
-    return true;
-}
-
-void accel_cpu_common_unrealize(CPUState *cpu)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-
-    /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
-    }
-}
-
-int accel_supported_gdbstub_sstep_flags(void)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-    if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
-    }
-    return 0;
-}
 
 static const TypeInfo accel_cpu_type = {
     .name = TYPE_ACCEL_CPU,
@@ -163,7 +35,6 @@ static const TypeInfo accel_cpu_type = {
 
 static void register_accel_types(void)
 {
-    type_register_static(&accel_type);
     type_register_static(&accel_cpu_type);
 }
 
diff --git a/accel/meson.build b/accel/meson.build
index 5eaeb683385..52909314bfa 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,3 +1,4 @@
+common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-system.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
-- 
2.47.1


