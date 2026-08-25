Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27270C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn5Z-0000OL-CP; Tue, 25 Aug 2026 05:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn5X-0000LN-9d; Tue, 25 Aug 2026 05:04:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn5U-0003Ml-QY; Tue, 25 Aug 2026 05:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=ZaE8B0Wfpu7aGMlnP0potIFRqdoOEMNGz4Mb2XqOIQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IPtukSj9grSyYlLMBaIqZFgH2xNivLsdocJyw/f6/ez0W2JyGO/IznQvLBZzJiKDD
 PI545x56uiwjSSfoQKdzGFILxWFVjP/ZTxFqxdpoC1ReGaD02d3kTCnk+pLA/zb2ws
 YoId3bbEbRgM9udSatYdbVgaoeqC3/5tIag9KCBydnE676HljGhcwgrf6pQ4JvAIcv
 EjUGaitalsEQnSfWnPMu+JEAq2vdeRPaHo1tprM4puBMhoKIXYfjyQ6WC3RghTg4B9
 0sAT5UlAhLJplAGHLutiBFfbwv9R9txkBb4X1delbtLosMOrKr13R0vnZs1HnoA/bk
 uTPSPliM6xEww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 977751CE3C0;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 835B6416182;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E811432569; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 182/196] target/riscv: do not count ECALL in
 minstret
Date: Tue, 25 Aug 2026 12:01:39 +0300
Message-ID: <20260825090157.471948-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

With icount enabled, helper_raise_exception() leaves ECALL in
icount_get_raw() because it exits without restoring the current TB
state. This makes minstret count an instruction that does not retire.

Adjust only the fixed minstret baseline so that mcycle accounting
remains unchanged.

Add an RV64 softmmu regression test for the issue.

Fixes: 4fe8ae09062d ("target/riscv: Combine mhpmcounter and mhpmcounterh")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4087
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260730032122.2564190-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 5a9fa8b5820998a5aca02ecf3df12819f7ff2173)
(Mjt: trivial context fixup in #include statement)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b5693663699..43251179efc 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -20,6 +20,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#ifndef CONFIG_USER_ONLY
+#include "pmu.h"
+#endif
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -59,6 +62,9 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
+#ifndef CONFIG_USER_ONLY
+    riscv_pmu_decr_instret(env);
+#endif
     riscv_raise_exception(env, exception, 0);
 }
 
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 708f2ec7aaa..137fc5c39e2 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -101,6 +101,21 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
+static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
+{
+    bool virt_on = env->virt_enabled;
+
+    return (env->priv == PRV_M && (cfg & MHPMEVENT_BIT_MINH)) ||
+           (env->priv == PRV_S && virt_on &&
+            (cfg & MHPMEVENT_BIT_VSINH)) ||
+           (env->priv == PRV_U && virt_on &&
+            (cfg & MHPMEVENT_BIT_VUINH)) ||
+           (env->priv == PRV_S && !virt_on &&
+            (cfg & MHPMEVENT_BIT_SINH)) ||
+           (env->priv == PRV_U && !virt_on &&
+            (cfg & MHPMEVENT_BIT_UINH));
+}
+
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -196,12 +211,27 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
     riscv_pmu_icount_update_priv(env, newpriv, new_virt);
 }
 
+void riscv_pmu_decr_instret(CPURISCVState *env)
+{
+    if (!icount_enabled() ||
+        (env->mcountinhibit & COUNTEREN_IR) ||
+        riscv_pmu_counter_filtered(env, env->minstretcfg)) {
+        return;
+    }
+
+    /*
+     * minstret is derived from icount, which includes the current
+     * instruction.  Move the baseline forward to exclude an instruction
+     * that raises an exception and therefore does not retire.
+     */
+    env->pmu_ctrs[2].mhpmcounter_prev++;
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
     uint64_t max_val = UINT64_MAX;
-    bool virt_on = env->virt_enabled;
     PMUCTRState *counter;
     gpointer value;
 
@@ -219,17 +249,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         return -1;
     }
 
-    /* Privilege mode filtering */
-    if ((env->priv == PRV_M &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
-        (env->priv == PRV_S && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
-        (env->priv == PRV_U && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
-        (env->priv == PRV_S && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
-        (env->priv == PRV_U && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
+    if (riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
         return 0;
     }
 
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 3853d0e2629..a9a67869e65 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -36,6 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
+void riscv_pmu_decr_instret(CPURISCVState *env);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx);
 
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index eb1ce6504a0..a50aa3236f6 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -24,6 +24,10 @@ EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-minstret-ecall
+run-test-minstret-ecall: test-minstret-ecall
+	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
+
 EXTRA_RUNS += run-plugin-doubletrap
 run-plugin-doubletrap: doubletrap
 	$(call run-test, $<, \
diff --git a/tests/tcg/riscv64/test-minstret-ecall.S b/tests/tcg/riscv64/test-minstret-ecall.S
new file mode 100644
index 00000000000..ab268f7f229
--- /dev/null
+++ b/tests/tcg/riscv64/test-minstret-ecall.S
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/*
+	 * The first CSR read retires after obtaining s0.  The ecall does not
+	 * retire, so the trap handler must observe a difference of one.
+	 */
+	csrr	s0, minstret
+	ecall
+	sub	t0, s1, s0
+	li	t1, 1
+	bne	t0, t1, fail
+
+	li	a0, 0
+	j	_exit
+
+trap:
+	csrr	s1, minstret
+	csrr	t0, mcause
+	li	t1, 11		/* Environment call from M-mode */
+	bne	t0, t1, fail
+
+	csrr	t0, mepc
+	addi	t0, t0, 4
+	csrw	mepc, t0
+	mret
+
+fail:
+	li	a0, 1
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.47.3


