Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1C606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m9sxCByS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRRh-0001pX-RU; Thu, 12 Nov 2026 04:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRU-0001lH-2d; Thu, 12 Nov 2026 04:50:05 -0500
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRH-0002yY-6O; Thu, 12 Nov 2026 04:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476975; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=Xy6WDJMo6kEy2FPjE54FEb37T1x0ljd6lMeUEcJZ6Hw=;
 b=m9sxCBySwb0TsYQFGXDOrMD9jU2q50RK+fMa75FpH1s2sUcws19QA8/jIrmUkWsoye0Jht3fT9EM6i6iqznp7BizdYJVuqn231uh/L51+VMO4ERFnIfCrAGASAtAi9kxJsbybnuMv38YUutGPu+SZ0/Mr1XxGxeePkCL0zPRJec=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdcZ_1794476974; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdcZ_1794476974 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:34 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:16 +0800
Subject: [PATCH v4 10/14] target/riscv: Apply minstret exception accounting
 to HPM counters
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-10-e9067bdf4df5@linux.alibaba.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
In-Reply-To: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=6563;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=Sepbp21F7tZ+a5jB4MuifNFMj2AzagdIdKv8SLLV6Z4=;
 b=3b6kfMmXr813ikhHUi2V8sJbmU+2LUGqpKv45Qbiujh9634ybuAvaJmBU+Sjq7RKJWi2duLid
 5KGGSt3p6B5DXCXMKk1fZGJKA4K7KRS7+m9h8dbRWKskNYEhRUy6oeI
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With icount, helper_raise_exception() excludes faulting instructions from
minstret but not HPM counters selecting HW_INSTRUCTIONS.

Adjust the baseline of every running instruction counter that counts the
current privilege mode. Do not read icount here: the helper can run inside
a TB. Keep the existing timer, since excluding an instruction can only
postpone overflow and expiry checks for an actual wrap.

Extend the ECALL regression to compare both counters and add an LPAD
fault test covering an exception inside a multi-instruction TB.

Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/pmu.c                  | 35 ++++++++++++----
 tests/tcg/riscv64/pmu-lpad.S            | 72 +++++++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build    |  7 ++++
 tests/tcg/riscv64/test-minstret-ecall.S | 26 ++++++++++++
 4 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index f88f6ae671d877ed874d22c9d4b840edb6f433a5..08298010b6d06f5792fa14ff81fe2f7a28c6476f 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -387,18 +387,39 @@ void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
 
 void riscv_pmu_decr_instret(CPURISCVState *env)
 {
-    if (!icount_enabled() ||
-        (env->mcountinhibit & COUNTEREN_IR) ||
-        riscv_pmu_counter_filtered(env, env->minstretcfg)) {
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t ctr_mask;
+
+    if (!icount_enabled()) {
         return;
     }
 
     /*
-     * minstret is derived from icount, which includes the current
-     * instruction.  Move the baseline forward to exclude an instruction
-     * that raises an exception and therefore does not retire.
+     * Fixed instruction events are derived from icount, which includes the
+     * current instruction.  Move the baseline of each running
+     * instruction-source counter that counts the current privilege mode to
+     * exclude an instruction that raises an exception and does not retire.
+     *
+     * Do not read icount here: this helper can run in the middle of a TB.
+     * Excluding an instruction only postpones overflow, so keep the current
+     * timer deadline. The expiry handler checks for an actual counter wrap.
      */
-    env->pmu_ctrs[2].mhpmcounter_prev++;
+    ctr_mask = COUNTEREN_IR |
+               riscv_pmu_event_counter_mask(
+                   cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
+    while (ctr_mask) {
+        uint32_t ctr_idx = ctz32(ctr_mask);
+        uint64_t cfg = ctr_idx == 2 ? env->minstretcfg :
+                                      env->mhpmevent_val[ctr_idx];
+
+        ctr_mask &= ~BIT(ctr_idx);
+        if (!riscv_pmu_fixed_ctr_running(env, ctr_idx) ||
+            riscv_pmu_counter_filtered(env, cfg)) {
+            continue;
+        }
+
+        env->pmu_ctrs[ctr_idx].mhpmcounter_prev++;
+    }
 }
 
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
diff --git a/tests/tcg/riscv64/pmu-lpad.S b/tests/tcg/riscv64/pmu-lpad.S
new file mode 100644
index 0000000000000000000000000000000000000000..40a6b34b7c2b71dd42e78b6873d72df4d508289d
--- /dev/null
+++ b/tests/tcg/riscv64/pmu-lpad.S
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR number for older assemblers. */
+#define CSR_MSECCFG          0x747
+
+/* An LPAD fault must be deliverable with HPM instruction counting enabled. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global	_start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	li	t0, 2		/* HW_INSTRUCTIONS */
+	csrw	mhpmevent3, t0
+	li	t0, 1 << 10	/* mseccfg.MLPE */
+	csrs	CSR_MSECCFG, t0
+
+	/* x7[31:12] = 0 does not match the nonzero LPAD label. */
+	li	t2, 0
+	lla	a0, target
+	jalr	ra, a0, 0
+	j	fail
+
+	.balign	4
+target:
+	.word	0x00001017	/* lpad 1 */
+	/*
+	 * Keep the LPAD check inside a multi-instruction TB. Its exception
+	 * helper must not read icount before leaving generated code.
+	 */
+	.rept	16
+	nop
+	.endr
+	j	fail
+
+trap:
+	csrr	t0, mcause
+	li	t1, 18		/* Software-check exception */
+	bne	t0, t1, fail
+	csrr	t0, mtval
+	li	t1, 2		/* Landing-pad fault */
+	bne	t0, t1, fail
+	csrr	t0, mepc
+	lla	t1, target
+	bne	t0, t1, fail
+	li	a0, 0
+	j	exit
+
+fail:
+	li	a0, 1
+
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
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
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 4092bab25985400a69003ec00e973aa5011e1057..66b68509c5e1bb05d699f93e4570767da7e88b97 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -74,6 +74,13 @@ tests += {
   }
 }
 
+tests += {
+  'pmu-lpad.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 # Exercise RV32 CSRs with the RV64 emulator's 64-bit target_ulong.
 tests += {
   '../riscv32/smcdeleg-rv32.S': {
diff --git a/tests/tcg/riscv64/test-minstret-ecall.S b/tests/tcg/riscv64/test-minstret-ecall.S
index ab268f7f22985820f19bde353215385608643f3a..b1857543d488df984b923ad1c135edb35cb948c7 100644
--- a/tests/tcg/riscv64/test-minstret-ecall.S
+++ b/tests/tcg/riscv64/test-minstret-ecall.S
@@ -18,11 +18,37 @@ _start:
 	li	t1, 1
 	bne	t0, t1, fail
 
+	/*
+	 * minstret and a counter selecting HW_INSTRUCTIONS must both exclude
+	 * ECALL, so they must contain the same number of retired instructions.
+	 */
+	li	t0, 12		/* mcountinhibit.IR | mcountinhibit.HPM3 */
+	csrs	mcountinhibit, t0
+	csrw	minstret, zero
+	csrw	mhpmcounter3, zero
+	li	t0, 2		/* RISCV_PMU_EVENT_HW_INSTRUCTIONS */
+	csrw	mhpmevent3, t0
+	lla	t0, trap_hpm
+	csrw	mtvec, t0
+	li	t0, 12
+	csrc	mcountinhibit, t0
+	ecall
+	bne	s3, s4, fail
+
 	li	a0, 0
 	j	_exit
 
 trap:
 	csrr	s1, minstret
+	j	trap_check
+
+trap_hpm:
+	li	t0, 12
+	csrs	mcountinhibit, t0
+	csrr	s3, minstret
+	csrr	s4, mhpmcounter3
+
+trap_check:
 	csrr	t0, mcause
 	li	t1, 11		/* Environment call from M-mode */
 	bne	t0, t1, fail

-- 
2.43.0


