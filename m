Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B6EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMmX-0006tQ-0u; Sun, 08 Mar 2026 18:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmV-0006pv-IF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmT-0003kO-4j
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so14720125e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009562; x=1773614362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PfjxtWhAJ3CuZYePYTssU/iwsvuWkdbwakKwc8f5rYI=;
 b=H71VdGSurUqtJsed/b+q7xEcgU0xKudmuMMDiLGcPycXuRLCB4/QtqkYsE4ssPQV6f
 w5r7qXKXKz3ybr7w6PmpxNbPsdYugq3pKnkOh7N9pDMQBvMUL4X9AL0joZ1Cardb1uvA
 +fPhDduEuPFtY9LUeAr/DAhwS4q/4/89bdSSDFZac7bSjic8qIvRN1s1WhqwlRj5WrO+
 s3vAX33KBJq3syUdDbq+kyBzMIJ/kUN5k6Hk3dNqdxRCjFpkBrvn9Xlq2zKe7/wTTYat
 wqRgb8E6JsqiVa56JSX5pvQSIaJHCVG9PR7qBAV2oizRqkgroug+ZsZWqgSKEyGunKhK
 F3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009562; x=1773614362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PfjxtWhAJ3CuZYePYTssU/iwsvuWkdbwakKwc8f5rYI=;
 b=UBYp5LYo5gceoVTLmsciXSu0KGhz0Y1tIp6UP2xDTmWTw5snYE8MA4tTXgyqbPBDvx
 SmVa42vZy3UDJYBGOLlu1ioUoLj62QXb5TPZB7z1pZak6tMRz1WjAK39iBaa9rQrIyVf
 P21STOmeI0W50qvVrau8oW1zhAqGAy3dpECItfpbtnZnwgcduC02yHvbqXvUMMoaclXW
 w1pFQznJOyn7NVTDp32T0DglYifgqCk3r9TJK2jpn33E3tK9LYPwMtqk+U3aG+fpnbND
 XzY1xwZouKJo4x+fN7GsLN3pETQ/GY48o1Zw+GoCH2RzO5t/hVmooNhMcQYFcMDTuszj
 Vm0Q==
X-Gm-Message-State: AOJu0YykBetcEY4A7WWPNYrLiCKrE4v1x64WGOgPumfgbVEX/I88uM5t
 UyOlixeus8lf6+vuhZx+r/flOtPloE/u0GRrNNTX5G51fZCMal8SrogSOWr+XSKiWmsRCkTfSG6
 EyRUlIkY=
X-Gm-Gg: ATEYQzxDvaQo/3yJK6gSLvSRgAnqZ+AMQZTSLtKhvOISRijQEINReIIF87m0QH6BP7y
 pKKKsVdK2xSscKqlbb3jEBzpw3G58FbM/0nYk7vAAMJkRFYxyzda2n1yCbTNBaj9gQgOKJtAhkN
 ZEbSdP2Crhk+Cygtx4CyqItNURgv4W0aNlIrOGr0Ewl5QviwDgCcKszYsss8aHA9B0u2Hk95xqH
 3oEaxFtiMjpHlyAVucvBuQBIQhauB+oXjHHDGuJSqghNsZS8WXChxXHW/Zp7FsGMGbOsFfCT+bG
 /9uWPY5/LyIw0hTbw1YiXuupLm1YT1HmY4jHElAdg0GzMV/gzXbFkcGKTcT1gjUl9bUXVrlewG2
 xoe9/+NCPnf5FFFyvUPkE5iVBNYf68raTjhIEcZBbpmpQoCoi63toeHaF8GHYRRv9yTaS8St1rK
 Lm4foeMOLDp9iJgP5V1z+btTcSxHNRa//Mo6i2dRjOmkbJ3Lnfx1Ua7sjCDL4YS01nXdKvDIMa1
 48BKg==
X-Received: by 2002:a05:600c:4e4e:b0:485:363b:fafd with SMTP id
 5b1f17b1804b1-485363bfc84mr49922665e9.6.1773009562321; 
 Sun, 08 Mar 2026 15:39:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853c22762esm7155975e9.28.2026.03.08.15.39.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] hppa: Introduce HPPACPUDef
Date: Sun,  8 Mar 2026 23:34:26 +0100
Message-ID: <20260308223433.25503-43-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Anton Johansson <anjo@rev.ng>

Restructures the CPU class heirarchy to clarify model names and allow
for per-model configuration options via HPPACPUDef. 32-bit HPPA is
assumed to run a PA-7300LC, and 64-bit assumed to run a PA-8700.
A new PA-8500 model is added, which will later be used by the A400
machine.  All CPU models are made into children of the now abstract
TYPE_HPPA_CPU base class.

Two fields are added to HPPACPUDef describing the size of the physical
address space, and whether or not the CPU uses the PA-RISC 2.0
architecture.  The latter was previously a field in CPUHPPAState.

phys_addr_bits is currently set but unused, and will be used in the
following commit.  Likewise, PA-8700 is moved to use 44 bit physical
addresses in a followup commit to not break bisection.

References to "hppa/hppa64" models in test cases are also updated.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305-hppa-c3600-v6-1-d51526e5269c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu-qom.h           |  8 +++++-
 target/hppa/cpu.h               | 24 +++++++++++++---
 hw/hppa/machine.c               | 21 ++++++++------
 linux-user/hppa/elfload.c       |  2 +-
 target/hppa/cpu.c               | 50 +++++++++++++++++++++++++--------
 tests/qtest/machine-none-test.c |  2 +-
 6 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 5c454bf543b..7541c25b3d5 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -23,7 +23,13 @@
 #include "hw/core/cpu.h"
 
 #define TYPE_HPPA_CPU "hppa-cpu"
-#define TYPE_HPPA64_CPU "hppa64-cpu"
+
+#define HPPA_CPU_TYPE_SUFFIX "-" TYPE_HPPA_CPU
+#define HPPA_CPU_TYPE_NAME(name) (name HPPA_CPU_TYPE_SUFFIX)
+
+#define TYPE_HPPA_CPU_PA_7300LC HPPA_CPU_TYPE_NAME("pa-7300lc")
+#define TYPE_HPPA_CPU_PA_8500   HPPA_CPU_TYPE_NAME("pa-8500")
+#define TYPE_HPPA_CPU_PA_8700   HPPA_CPU_TYPE_NAME("pa-8700")
 
 OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 092e647ccf5..43b4882fb4f 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -270,8 +270,6 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    bool is_pa20;
-
     target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
@@ -290,6 +288,18 @@ struct ArchCPU {
     QEMUTimer *alarm_timer;
 };
 
+/**
+ * HPPACPUDef:
+ * @phys_addr_bits: Number of bits in the physical address space.
+ * @is_pa20: Whether the CPU model follows the PA-RISC 2.0 or 1.1 spec.
+ *
+ * Configuration options for a HPPA CPU model.
+ */
+typedef struct HPPACPUDef {
+    uint8_t phys_addr_bits;
+    bool is_pa20;
+} HPPACPUDef;
+
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -302,11 +312,17 @@ struct HPPACPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+    const HPPACPUDef *def;
 };
 
-static inline bool hppa_is_pa20(const CPUHPPAState *env)
+static inline const HPPACPUDef *hppa_def(CPUHPPAState *env)
 {
-    return env->is_pa20;
+    return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
+}
+
+static inline bool hppa_is_pa20(CPUHPPAState *env)
+{
+    return hppa_def(env)->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f55e84529f6..5d0d4de09ed 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -801,13 +801,13 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
-        TYPE_HPPA_CPU,
+        TYPE_HPPA_CPU_PA_7300LC,
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "HP B160L workstation";
-    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->default_cpu_type = TYPE_HPPA_CPU_PA_7300LC;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_B160L_init;
     mc->is_default = true;
@@ -817,13 +817,13 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
-        TYPE_HPPA64_CPU,
+        TYPE_HPPA_CPU_PA_8700,
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
-    mc->default_cpu_type = TYPE_HPPA64_CPU;
+    mc->default_cpu_type = TYPE_HPPA_CPU_PA_8700;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_C3700_init;
     mc->max_cpus = HPPA_MAX_CPUS;
@@ -833,13 +833,13 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
-        TYPE_HPPA64_CPU,
+        TYPE_HPPA_CPU_PA_8500,
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "HP A400-44 workstation";
-    mc->default_cpu_type = TYPE_HPPA64_CPU;
+    mc->default_cpu_type = TYPE_HPPA_CPU_PA_8500;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_A400_init;
     mc->max_cpus = HPPA_MAX_CPUS;
@@ -849,13 +849,18 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
 static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
-        TYPE_HPPA_CPU,
+        TYPE_HPPA_CPU_PA_7300LC,
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "HP 715/64 workstation";
-    mc->default_cpu_type = TYPE_HPPA_CPU;
+    /*
+     * Although the 715 workstation should use a 7100LC, it can be safely
+     * modeled as a 7300LC as the difference is a moving of the L1 data cache
+     * to on-chip.
+     */
+    mc->default_cpu_type = TYPE_HPPA_CPU_PA_7300LC;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_715_init;
     /* can only support up to max. 8 CPUs due inventory major numbers */
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 46007087020..7f7ece6dc19 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -8,7 +8,7 @@
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
-    return "hppa";
+    return "pa-7300lc";
 }
 
 const char *get_elf_platform(CPUState *cs)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 714f3bbdaf7..cc755da8be2 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -203,13 +203,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 }
 
-static void hppa_cpu_initfn(Object *obj)
-{
-    CPUHPPAState *env = cpu_env(CPU(obj));
-
-    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
-}
-
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 {
     HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
@@ -236,9 +229,14 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
-    g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
+    ObjectClass *oc;
+    char *typename;
 
-    return object_class_by_name(typename);
+    typename = g_strdup_printf(HPPA_CPU_TYPE_NAME("%s"), cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
+
+    return oc;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -279,6 +277,14 @@ static const TCGCPUOps hppa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
+{
+    HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+    /* Make sure all CPU models define a HPPACPUDef */
+    g_assert(!object_class_is_abstract(oc) && data != NULL);
+    acc->def = data;
+}
+
 static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -313,14 +319,34 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
-        .instance_init = hppa_cpu_initfn,
-        .abstract = false,
+        .abstract = true,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
+        .class_base_init = hppa_cpu_class_base_init,
     },
     {
-        .name = TYPE_HPPA64_CPU,
+        .name = TYPE_HPPA_CPU_PA_7300LC,
         .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 32,
+            .is_pa20 = false,
+        },
+    },
+    {
+        .name = TYPE_HPPA_CPU_PA_8500,
+        .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 40,
+            .is_pa20 = true,
+        },
+    },
+    {
+        .name = TYPE_HPPA_CPU_PA_8700,
+        .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 40,
+            .is_pa20 = true,
+        },
     },
 };
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index c1e22dcecc7..bafd7d660ec 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -47,7 +47,7 @@ static struct arch2cpu cpus_map[] = {
     { "tricore", "tc1796" },
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
-    { "hppa", "hppa" },
+    { "hppa", "pa-7300lc" },
     { "riscv64", "rv64" },
     { "riscv32", "rv32" },
     { "rx", "rx62n" },
-- 
2.53.0


