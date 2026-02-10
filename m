Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5629CEA8109
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnNl-0003vs-L4; Tue, 10 Feb 2026 08:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNi-0003rZ-2V
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNe-0002qp-5d
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=q609Nmaahc8rfJBQxkAcSbnQ9Y7UQbnHzKxOCiEj8+Q=; b=c3PxCfbIsKRjIi0
 67g6PpLvIlIlDFYm5FnQF6wmJ7IB3PwRoPhElVnm2goerARJhZlIf0dziEZmxVp+kHsp6eAab+03Z
 e4tRrkBQ6OQjKmLe12vQEekc6Ob6QVjeWB9zWEYH0rQ8e3GQ9uljWJXuApl5F+pbR/ry4B+SNqhtu
 mc=;
Date: Tue, 10 Feb 2026 14:04:55 +0100
Subject: [PATCH 1/4] hppa: Prepare for additional CPU models
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-hppa-c3600-v1-1-a17ec58f053f@rev.ng>
References: <20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng>
In-Reply-To: <20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Current CPU model names are clarified, assuming 32-bit HPPA runs a PA-7300LC
whereas 64-bit runs a PA-8700.  Both CPU models are made into children
of the now abstract TYPE_HPPA_CPU base class, simplifying the addition of
other CPU models.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu-qom.h           |  7 ++++++-
 hw/hppa/machine.c               | 17 +++++++++++------
 target/hppa/cpu.c               | 19 ++++++++++++++-----
 tests/qtest/machine-none-test.c |  2 +-
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 5c454bf543..c6b82dc09b 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -23,7 +23,12 @@
 #include "hw/core/cpu.h"
 
 #define TYPE_HPPA_CPU "hppa-cpu"
-#define TYPE_HPPA64_CPU "hppa64-cpu"
+
+#define HPPA_CPU_TYPE_SUFFIX "-" TYPE_HPPA_CPU
+#define HPPA_CPU_TYPE_NAME(name) (name HPPA_CPU_TYPE_SUFFIX)
+
+#define TYPE_HPPA_CPU_PA_7300LC HPPA_CPU_TYPE_NAME("pa-7300lc")
+#define TYPE_HPPA_CPU_PA_8700   HPPA_CPU_TYPE_NAME("pa-8700")
 
 OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 472b90aab0..6a0487c362 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -791,13 +791,13 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
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
@@ -807,13 +807,13 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
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
@@ -823,13 +823,18 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
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
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 714f3bbdaf..c8079016bf 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -207,7 +207,7 @@ static void hppa_cpu_initfn(Object *obj)
 {
     CPUHPPAState *env = cpu_env(CPU(obj));
 
-    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU_PA_8700);
 }
 
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
@@ -236,9 +236,14 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 
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
@@ -314,12 +319,16 @@ static const TypeInfo hppa_cpu_type_infos[] = {
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


