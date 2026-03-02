Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A4E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1qa-0000yG-Qj; Mon, 02 Mar 2026 06:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qU-0000xC-OE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:54 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qQ-0007is-NI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=f2LdQ+ShPWhBpo+Qx9LvngELjv3j8IsLbzASGGZ8ZKA=; b=qnX8Qn7AOqSkXF5
 YBRwBrpi6cD2uZatePL0zSqdWiueqUYq8EJQxAFMLP7oIRyavntvsT943EGaZC/08Nzsno3t+LrMg
 +ZekiaGcpQ4Ew62qzVyB0rIJ/YR2vydo9zi7KH417WKqAKoK0BMOlgFUxLcBjC0xXr9sDc1JTsrEh
 M4=;
Date: Mon, 02 Mar 2026 12:56:43 +0100
Subject: [PATCH v4 1/4] hppa: Restructure CPU Class heirarchy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-hppa-c3600-v4-1-447a800da8cc@rev.ng>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
In-Reply-To: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772452649; l=6835;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=SfMB+PlLX//tToVM5JAbgc6Lak7IHcGzoWZgo1M+ZMI=;
 b=FC07TAai5GJOcpuYl2pOxtdWDQIw+ubpDS8zf8jkVQNM448h+Q5V2ODMB7UjgBEZucHqEn40i
 tCVgyftgeFyApJLpNi9qmnJl2DwLEJQ2AAuvcuaeCbAhLSfGC7pMmar
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Clarifies current CPU model names, assuming 32-bit HPPA runs a PA-7300LC
whereas 64-bit runs a PA-8700.  The PA-8500 model is added, which will
later be used by the A400 machine.  All CPU models are made into children
of the now abstract TYPE_HPPA_CPU base class.

References to "hppa/hppa64" models in test cases are also updated.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu-qom.h           |  8 +++++++-
 hw/hppa/machine.c               | 21 +++++++++++++--------
 linux-user/hppa/elfload.c       |  2 +-
 target/hppa/cpu.c               | 25 ++++++++++++++++++++-----
 tests/qtest/machine-none-test.c |  2 +-
 5 files changed, 42 insertions(+), 16 deletions(-)

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
index 714f3bbdaf..910a919923 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -207,7 +207,9 @@ static void hppa_cpu_initfn(Object *obj)
 {
     CPUHPPAState *env = cpu_env(CPU(obj));
 
-    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8500) ||
+                   !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8700);
+
 }
 
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
@@ -236,9 +238,14 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
-    g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
+    ObjectClass *oc;
+    char *typename;
+
+    typename = g_strdup_printf(HPPA_CPU_TYPE_NAME("%s"), cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
 
-    return object_class_by_name(typename);
+    return oc;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -314,12 +321,20 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
         .instance_init = hppa_cpu_initfn,
-        .abstract = false,
+        .abstract = true,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
     },
     {
-        .name = TYPE_HPPA64_CPU,
+        .name = TYPE_HPPA_CPU_PA_7300LC,
+        .parent = TYPE_HPPA_CPU,
+    },
+    {
+        .name = TYPE_HPPA_CPU_PA_8500,
+        .parent = TYPE_HPPA_CPU,
+    },
+    {
+        .name = TYPE_HPPA_CPU_PA_8700,
         .parent = TYPE_HPPA_CPU,
     },
 };
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index b6a87d27ed..f871056fa4 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -48,7 +48,7 @@ static struct arch2cpu cpus_map[] = {
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


