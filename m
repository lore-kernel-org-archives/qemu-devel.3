Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA61FD1CA04
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85P2-0004FC-IG; Mon, 04 Nov 2024 17:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t85P0-0004Ez-Bp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:18:26 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t85Oy-0003OV-7C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:18:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7CDD05C44CF;
 Mon,  4 Nov 2024 22:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76B3C4CECE;
 Mon,  4 Nov 2024 22:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730758694;
 bh=/DPEM0nMUR7FEg053j9g2zBcZyeWCMCoIhkS1isDLqE=;
 h=Date:From:To:Subject:From;
 b=F+fzWfHFFn+R02bbQLTk7fissKCS3am+cGhArfDVCI/oBj+TlADKmmb/JhwiglRZb
 eT+DGtjsKmSkJfiB0QfEAVgm0nd5PM/ABqwcTxDhaAloAG6M1fZNwtmQ20OylPeJsx
 fRE57GclLXAhPYY9b9Tf0BREvu0M2kjl1uMA0Y/qk3a9YB0U93cQO20BtLrZdkQfq6
 xVcwrmYlmcx5s9a5haeNmilVSoyMsw9mdWo5ckGUcRfnpp8riY5Gw2yS+K5Sn94pLd
 H5AyKWN2O5zV7ktIj0kcc/S5brBakOtLTiRyIjbffV8CJcrPUt9c+u4gKBobt+NF5f
 x9je7vFGnGvuA==
Date: Mon, 4 Nov 2024 23:18:10 +0100
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v2] target/hppa: Add CPU reset method
Message-ID: <ZylIIkk7k69QIBmn@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add the CPU reset method, which resets all CPU registers and the TLB to
zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
start execution at address 0xf0000004.
Although we currently want to zero out all values in the CPUHPPAState
struct, add the end_reset_fields marker in case the state structs gets
extended with other variables later on which should not be reset.

Signed-off-by: Helge Deller <deller@gmx.de>

V2: (based on feedback by Peter Maydell)
- Add end_reset_fields marker
- call reset function in hppa_cpu_initfn()

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c180..d12bf65021 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -194,13 +194,8 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void hppa_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
-    HPPACPU *cpu = HPPA_CPU(obj);
-    CPUHPPAState *env = &cpu->env;
-
-    cs->exception_index = -1;
-    cpu_hppa_loaded_fr0(env);
-    cpu_hppa_put_psw(env, PSW_W);
+    /* inital values loaded via reset in hppa_cpu_reset_hold() */
+    resettable_reset(obj, RESET_TYPE_COLD);
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
@@ -235,15 +230,39 @@ static const TCGCPUOps hppa_tcg_ops = {
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

