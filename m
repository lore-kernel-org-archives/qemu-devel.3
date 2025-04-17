Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045AFC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SWE-00008b-QF; Thu, 17 Apr 2025 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SW9-00005K-IV
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SW5-0003rk-Bp
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso2864365e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908906; x=1745513706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jysnHSLV8epANTA9h+/N0cIGwX54iTNV542u38RlNio=;
 b=toDfPKrBSSZceNd7O+Sg1GB5tuET5KId8bOezm9/9Hma5ZCz+FLnegSqLB4VEIh7PP
 WnoJq13PgXOU13HjdArsfxjyImIlOj1kueboZ424gHIQ2bmB+hjGeHKuYwOaToxywSd6
 6iQ/9XPrlAaFXpQEutB3WmNzeM6/qk2zbZWarf/bxg33QH3ZsHaSmFAVxOLI6tAw7QZp
 KdFcv2e2FhN6qwFjZXA4y0+slPSXNzS+tT8UsQ0k7L+kP0BUb/2XmasjRBBp5kiwf87g
 tQeLy2pLxYexuTc3srF2K6hGL1lLe3UGyE6SszBMEp+i5JkQiXRPdXOjMTaj6clkiL5c
 KJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908906; x=1745513706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jysnHSLV8epANTA9h+/N0cIGwX54iTNV542u38RlNio=;
 b=BhZ4TE8/GqRnUsFCn/I33hzC48oubHTnSpg8DBGIzqATKX4vJ9/0b1bypWDWG5JMUD
 VWKDr7cONwTASlJgM9IP1e3wIogRTp7wZ7FilDgAggmt4rFu4q3MQD9JqgeMik2rjXTa
 ib1sFlHxkJPWk97K8ltaDPUSYFZdg4zjJifouUr75nxOurEgfvmHF0I9OBU+HYKHwGUF
 Wz9JdTIfyS+/ywdMP0cpOV9vrNH3XDnXkmbU82UyMJbkFqiqkxAy/xW864Ur8ezUy+Lo
 36dQZHFDw7L0zTYQW0kCIuOS+AN8iK8/jk9LfSKVc6kQOuQ5sjpidmfmLFIiDEgKdoJk
 499w==
X-Gm-Message-State: AOJu0Yz0zldCBbifA7Uu3XTmw0uXWRbEQAi5ox/IWd6Xy+GjEtxZVO2B
 65Yr1ynkGUf6ngJK2aK4ZonOupmPtXI2NuXYTF9b52TgXHoCpsf5xLIkcgF/Dj6igwaNhSdlWev
 M
X-Gm-Gg: ASbGncvg7pcVZtVtA6bhvlevVHFMPrt/3vMML66vOockwlYXA6IgM9C/WVwRJK0nbfL
 f3i8RGzlz6NPxh8323ey4g8cSeXw6AmCo6l3Kc1YnIuMjb0+/5tV1y3SUufnsK2rS4dBAvdPnZ1
 zFanWbmfV9qBJuSjBsV0eSPkLkvSQIY4K2rRzx4T2aUtAMNb5ukcey5isytBTFh3ldwgisLnO67
 JrB1UuDPpCFgYPlDMIGHXGKYzL/aST581Fw9VmNIf76SPDAyh0eewOExZZ61KD/gZQIU3kuI8Pa
 PB16Tde/3FWat4S6yLev6os0X7Tu8AW2nVMdXiRO5o2cD6huzDzxMsL5u8LafDp5/BS1fjLJ7yT
 i5TV9sGWEt9RRaSU=
X-Google-Smtp-Source: AGHT+IEcjFtTJiNh0H5Fxo4DCDSn9a+7Zv9hCmcpTIjumR6jumvZcFyLPMz46wD/RPv2CpQLoJNlsA==
X-Received: by 2002:a05:600c:1d0d:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-4405d624f46mr63340495e9.14.1744908905754; 
 Thu, 17 Apr 2025 09:55:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440699454ccsm4508595e9.7.2025.04.17.09.55.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:55:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 7/7] accel: Move target-agnostic code from accel-target.c ->
 accel-common.c
Date: Thu, 17 Apr 2025 18:54:30 +0200
Message-ID: <20250417165430.58213-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
---
 accel/accel-common.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 accel/accel-target.c | 129 ---------------------------------------
 accel/meson.build    |   1 +
 3 files changed, 143 insertions(+), 129 deletions(-)
 create mode 100644 accel/accel-common.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
new file mode 100644
index 00000000000..f505461fc88
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
+#include "qemu/target_info.h"
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
index 769a90230bf..7fd392fbc4a 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -24,135 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "qemu/target_info.h"
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


