Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1914FD5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JGj-0006Ps-EZ; Fri, 08 Nov 2024 02:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGU-0006Kt-Az
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:42 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGR-0007PD-Jg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731050319; x=1762586319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=btE2N/+WTXZCx3oanGi+tZdW8La69qQYP7KKi9es/lg=;
 b=lmPsPXyv7V7Z3G/Zb2yylWXWQfr9epPvwD0/um6soBdebtqSCUFDJ56Q
 JuOA8OtbxWiDlIzJggUCNsq+44+/SFehH69x9sWyTFa/+YWXZtPKVh7q4
 F3MiDKs+9nvX5YIzpGjKnQeNNacXyuQJxKoxKYSBmKzorNsmCPbbIcrcf
 3L5KrdKpPeKn/ppyjlFH9d4frkvfABhEoFGiyVArfRMJ4BNNIUhvadve9
 C/yG3ALsAUpAooZ2LWl4Nuvoqyo1FoO30v0DAKiu/YbgclwCJoPe/43EU
 0S+j/QSkpclD60EZzoBrrC6VVq89WjObKYbL4M31Qjrhjm9JzA6gTrlUh A==;
X-CSE-ConnectionGUID: B+Xg+Eh0SPyFOV0OuyTHbQ==
X-CSE-MsgGUID: +Qdc5RhBTUORYca/GfIIvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31082905"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31082905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 23:18:38 -0800
X-CSE-ConnectionGUID: NKPtfFqZSMegpk3pnAWufg==
X-CSE-MsgGUID: jR3oOqh3RtG0iKPjhdCGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="86240933"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 07 Nov 2024 23:18:33 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH v1 1/4] cpu: Introduce qemu_early_init_vcpu() to initialize
 nr_cores and nr_threads inside it
Date: Fri,  8 Nov 2024 02:06:06 -0500
Message-Id: <20241108070609.3653085-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108070609.3653085-1-xiaoyao.li@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently cpu->nr_cores and cpu->nr_threads are initialized in
qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
each ARCHes.

x86 arch would like to use nr_cores and nr_threads earlier in its
realizefn(). Introduce qemu_early_init_vcpu() and move the
initialization of nr_cores and nr_threads from qemu_init_vcpu() to it.
Call qemu_early_init_vcpu() at the beginning of realizefn() for each
ARCH.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
This patch only is testes on x86 machine, please help test on other ARCHes.
---
 accel/tcg/user-exec-stub.c | 4 ++++
 hw/core/cpu-common.c       | 2 +-
 include/hw/core/cpu.h      | 8 ++++++++
 system/cpus.c              | 6 +++++-
 target/alpha/cpu.c         | 2 ++
 target/arm/cpu.c           | 2 ++
 target/avr/cpu.c           | 2 ++
 target/hexagon/cpu.c       | 2 ++
 target/hppa/cpu.c          | 2 ++
 target/i386/cpu.c          | 2 ++
 target/loongarch/cpu.c     | 2 ++
 target/m68k/cpu.c          | 2 ++
 target/microblaze/cpu.c    | 2 ++
 target/mips/cpu.c          | 2 ++
 target/openrisc/cpu.c      | 2 ++
 target/ppc/cpu_init.c      | 2 ++
 target/riscv/cpu.c         | 2 ++
 target/rx/cpu.c            | 2 ++
 target/s390x/cpu.c         | 2 ++
 target/sh4/cpu.c           | 2 ++
 target/sparc/cpu.c         | 2 ++
 target/tricore/cpu.c       | 2 ++
 target/xtensa/cpu.c        | 2 ++
 23 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc883..64baf917b55c 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -10,6 +10,10 @@ void cpu_remove_sync(CPUState *cpu)
 {
 }
 
+void qemu_early_init_vcpu(CPUState *cpu)
+{
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c79035949b..3b60e62228e4 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -242,7 +242,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     /* user-mode doesn't have configurable SMP topology */
-    /* the default value is changed by qemu_init_vcpu() for system-mode */
+    /* the default value is changed by qemu_early_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3f..99ecf18eec02 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1063,6 +1063,14 @@ void start_exclusive(void);
  */
 void end_exclusive(void);
 
+/**
+ * qemu_early_init_vcpu:
+ * @cpu: The vCPU to initialize.
+ *
+ * Early initialize a vCPU.
+ */
+void qemu_early_init_vcpu(CPUState *cpu);
+
 /**
  * qemu_init_vcpu:
  * @cpu: The vCPU to initialize.
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828c..a1b46f68476a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -662,12 +662,16 @@ const AccelOpsClass *cpus_get_accel(void)
     return cpus_accel;
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+void qemu_early_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
     cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
+}
+
+void qemu_init_vcpu(CPUState *cpu)
+{
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 9db1dffc03ec..56309a647763 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -93,6 +93,8 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
 #ifndef CONFIG_USER_ONLY
     /* Use pc-relative instructions in system-mode */
     cs->tcg_cflags |= CF_PCREL;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5b751439bdc7..98dcc0855868 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1971,6 +1971,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
     tcg_cflags_set(cs, CF_PCREL);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d5654..b8beaf9682c0 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -111,6 +111,8 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc4902..5931dce05bec 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -299,6 +299,8 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c1800e..cf7b46e4ff42 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -169,6 +169,8 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fbc..1179b7a3ce62 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7757,6 +7757,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     unsigned requested_lbr_fmt;
 
+    qemu_early_init_vcpu(cs);
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
     tcg_cflags_set(cs, CF_PCREL);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314bf7..9572cbd2a4f5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -598,6 +598,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb2382..77acbadeb65f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -304,6 +304,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     register_m68k_insns(&cpu->env);
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee8004..0850043ca1a2 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -226,6 +226,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     int i = 0;
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 9724e71a5e0f..8cd1b794e0af 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -460,6 +460,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     if (!clock_get(cpu->clock)) {
 #ifndef CONFIG_USER_ONLY
         if (!qtest_enabled()) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6ec54ad7a6cf..071239dd3134 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -147,6 +147,8 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9f3..5c2ab87319e7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6949,6 +6949,8 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b527..40cf24d2e759 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1166,6 +1166,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36d2a6f18906..a24b3f28b455 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -117,6 +117,8 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     RXCPUClass *rcc = RX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e41a3dff59b..20f083834309 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -247,6 +247,8 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
     Error *err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     /* the model has to be realized before qemu_init_vcpu() due to kvm */
     s390_realize_cpu_model(cs, &err);
     if (err) {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcfd5..74488a1c0ba4 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -212,6 +212,8 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 54cb269e0af1..57cd7911263e 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -788,6 +788,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     CPUSPARCState *env = cpu_env(cs);
 
+    qemu_early_init_vcpu(cs);
+
 #if defined(CONFIG_USER_ONLY)
     /* We are emulating the kernel, which will trap and emulate float128. */
     env->def.features |= CPU_FEATURE_FLOAT128;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a261715907d..d58271696631 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -88,6 +88,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUTriCoreState *env = &cpu->env;
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a08c7a0b1f20..92120141fee2 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -163,6 +163,8 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    qemu_early_init_vcpu(cs);
+
 #ifndef CONFIG_USER_ONLY
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
-- 
2.34.1


