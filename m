Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC9F513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHXf-0007fS-5S; Thu, 05 Mar 2026 17:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXd-0007Zq-9f
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:37 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXb-0008Q8-0Q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=21vQG7vaneBGja49Q9ttUYUjtDN4zWdrOelgdFYyL/Y=; b=CS781HnCbyK0sZs
 imXPkdopFS6z25237kSo8O9/KAYL1Ew+YJDxQGuaDSJLLWixg/GL8uuIxo/mD9KhEZpbZk52CvBzE
 rrgu9XLjwER1UnDuFafGLNE4V3h3fq6GLchNl2Y80eowBMXPaMxKlWLLq84mijT9v9yZrP0OwzYx2
 xU=;
Date: Thu, 05 Mar 2026 23:54:20 +0100
Subject: [PATCH v6 1/3] hppa: Introduce HPPACPUDef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-hppa-c3600-v6-1-d51526e5269c@rev.ng>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
In-Reply-To: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772751314; l=9903;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=bP5w4Uw4mtobEQawfD2dhbdBX6swNEHwuIIjzpmZsR0=;
 b=B3FVtHh1uF0UVfAKvZC+Xun0kRW2I4Nu7SLvGWJGrP7Dap4BCxBhungJ1MJDB64smyXMgtcBs
 6ytxbUfDRPQBSApOcYxBmx8eA+80BxsdLtfyGv7ohOk7/n/6i211VPm
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 target/hppa/cpu-qom.h           |  8 ++++++-
 target/hppa/cpu.h               | 24 ++++++++++++++++----
 hw/hppa/machine.c               | 21 ++++++++++-------
 linux-user/hppa/elfload.c       |  2 +-
 target/hppa/cpu.c               | 50 +++++++++++++++++++++++++++++++----------
 tests/qtest/machine-none-test.c |  2 +-
 6 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 5c454bf543..7541c25b3d 100644
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
index 092e647ccf..43b4882fb4 100644
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
+{
+    return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
+}
+
+static inline bool hppa_is_pa20(CPUHPPAState *env)
 {
-    return env->is_pa20;
+    return hppa_def(env)->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f55e84529f..5d0d4de09e 100644
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
index 4600708702..7f7ece6dc1 100644
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
index 714f3bbdaf..cc755da8be 100644
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
+    },
+    {
+        .name = TYPE_HPPA_CPU_PA_7300LC,
+        .parent = TYPE_HPPA_CPU,
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
     },
     {
-        .name = TYPE_HPPA64_CPU,
+        .name = TYPE_HPPA_CPU_PA_8700,
         .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 40,
+            .is_pa20 = true,
+        },
     },
 };
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index c1e22dcecc..bafd7d660e 100644
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
2.52.0


