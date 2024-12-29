Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4159E7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 23:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS2vN-0003tK-3M; Sun, 29 Dec 2024 18:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vC-0003ro-G4
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:13 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vA-0001ew-Nx
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:10 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C375AA40157;
 Sun, 29 Dec 2024 23:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028ADC4CED1;
 Sun, 29 Dec 2024 23:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735515719;
 bh=3/NpwClqbsROPze7xbpqnoulOTvLNUQ3RzivWGlikH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rOH6688HjuY+oIQ1s6KIUMpp2p5XN7I8OccTDR1FgOGUgvnI/NqwRVy7spsMF9DJq
 0lCSFUX4/LkV/Ex82FXpi1AUUn7wKMGI9JWNUNocOjaUgT2pAKaTAdTM/r0Z/w6CgX
 3T55dof9wJW3jCMv2nxrvp4B3qraGAvI+gWXGaV2Mn3fA51L0ilbQxgm+XZEKMT8m4
 6j1GGeL/FZUzqDdffxXpuuvtxO3/paNeINm5taiTdX3JMWDG0T8NbocCX6fq9uUKIS
 9vlbBI//Z2yOHwc4qlF52Xb55YsCFoqMeRX18J1Pv6jjhDvB4s1cYaTob66TmKfiTB
 8do78HoInELsg==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] target/hppa: Add CPU reset method
Date: Mon, 30 Dec 2024 00:41:53 +0100
Message-ID: <20241229234154.32250-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241229234154.32250-1-deller@kernel.org>
References: <20241229234154.32250-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Add the CPU reset method, which resets all CPU registers and the TLB to
zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
start execution at address 0xf0000004.
Although we currently want to zero out all values in the CPUHPPAState
struct, add the end_reset_fields marker in case the state structs gets
extended with other variables later on which should not be reset.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

V4:
- Drop initialization of exception_index in hppa_cpu_initfn()

V3:
- Call reset function from hppa_machine_reset() instead

V2:
- Add end_reset_fields marker
- call reset function in hppa_cpu_initfn()
---
 hw/hppa/machine.c |  6 +++---
 target/hppa/cpu.c | 26 ++++++++++++++++++++++++--
 target/hppa/cpu.h |  5 +++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a31dc32a9f..05fd43ce9c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -655,12 +655,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     for (i = 0; i < smp_cpus; i++) {
         CPUState *cs = CPU(cpu[i]);
 
+        /* reset CPU */
+        resettable_reset(OBJECT(cs), RESET_TYPE_COLD);
+
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
-
-        cs->exception_index = -1;
-        cs->halted = 0;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c180..cb1b5191a4 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -194,11 +194,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void hppa_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     HPPACPU *cpu = HPPA_CPU(obj);
     CPUHPPAState *env = &cpu->env;
 
-    cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_W);
 }
@@ -235,15 +233,39 @@ static const TCGCPUOps hppa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static void hppa_cpu_reset_hold(Object *obj, ResetType type)
+{
+    HPPACPU *cpu = HPPA_CPU(obj);
+    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
+    CPUHPPAState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (scc->parent_phases.hold) {
+        scc->parent_phases.hold(obj, type);
+    }
+
+    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
+    cpu_set_pc(cs, 0xf0000004);
+    cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0);
+    cpu_hppa_loaded_fr0(env);
+
+    cs->exception_index = -1;
+    cs->halted = 0;
+}
+
 static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
     HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, hppa_cpu_realizefn,
                                     &acc->parent_realize);
 
+    resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,
+                                       &acc->parent_phases);
+
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e45ba50a59..32a674a8b8 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -263,6 +263,9 @@ typedef struct CPUArchState {
     IntervalTreeRoot tlb_root;
 
     HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
 } CPUHPPAState;
 
 /**
@@ -281,6 +284,7 @@ struct ArchCPU {
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
  *
  * An HPPA CPU model.
  */
@@ -288,6 +292,7 @@ struct HPPACPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #include "exec/cpu-all.h"
-- 
2.47.0


