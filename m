Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98536C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZj-0002ox-Pk; Mon, 24 Aug 2026 01:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYv-0001gv-4e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:40 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYr-00021y-Bb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:35 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2861860a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550572; x=1788155372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9hvvtE/mLZxSo9keqAsE4vQdBL311za+hiZdp6fz9g=;
 b=eUFVlbPzeXRLLiUonwX7TqjYUREV6aynTriebYZo+gjeW3guTlcNji0JblEyQWEYy2
 p/DW0RWUTydjgdhNsT+lvGCVaW5DyqcgCNClPtSRP3Gn79Cmpdtx6xPxBEUm6COmD7jr
 VFy34dS2H7M+tUQNnrrrSJnBJX9Af86KRq6qIF2vVkM1VDJhojBlnGaTN1rjuXNUqsN0
 P6wMsJVE9yVD187J1khbnp5G/lK2EPc7gJZlnyM+RtLgAbmie5JtT5pvwJZeZMo8zq5b
 GjXpGbVc0ocH9CXbMxZma3LDKLQJfrzY+lZjvN6Od1cWX/EU6r6NGyHBPNTwMhl+/fDA
 xTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550572; x=1788155372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U9hvvtE/mLZxSo9keqAsE4vQdBL311za+hiZdp6fz9g=;
 b=G4gYpBV18yScOc/w8pIbyWErUiBINq4BLDTlx9atws1PLmloHGQWiHxXqimFzRvQXL
 irsUvsdFF34eVYkLFlOVB4eUUJgrwCq/q9v9XUwzhKW90Q+1vpkFPzr2VHoT40eISB0a
 TBkpdba00P15osiYR2WsL1/XVyfV0UWQPoJKSWtG7RLz0KY54x7HzvquVFW3Rx0JpvHQ
 MJ6EsdEksTMYdxun54YuFqBdsxBtLzZcvhkTYQp4+Z7hqr1XGyR2G3oE7JWkETBKYmLY
 1E3uFMdLZKXqZ0bEKRVYbq3WPkE+PEENZWiYC9k2OXup7wF4uv1C4elvv62UkVpjBpzL
 eibw==
X-Gm-Message-State: AFuF++lYP3smG/l1ebi/0m/OxuE2uxa3u45sFVKk0Ser5rl4evFA1Lxf
 X3eKz0+AlZnUI2zTLbZuW50gFs066Dtv1E+5DsXxozBXJtasQEbh+JJuCoRj9Q==
X-Gm-Gg: AR+sD12tOmIaUhewKfvzc4626XplNo/2XAGlx/lUkuMOnhy2ecWZ9+25HNDLhPeiBOl
 e0+DKJIP39IT9e7X122IGY0f2Iv+4uNb6BoZzlPgzXsDeI5KjHDZ6JiNh2+aZaTaka1QeN3CU1w
 5rKIvUpwY1h9U28Lt5kvqfWt4ItaXAuwwwxpLmrpMUK7JaM/QiKIpRYgm14VyjDIl3VnxZfPZGw
 fRbM6NtfKE4x1WDuvLeBiBEd5rdLn9C5l2X/aTFgPaphFrJmUe5gsTx/jDpC3VUgmXAvE1LKVS+
 fmpEkWn/ActPm2SxotT1EpogehrhoRPRtX+TOSv0ZhbO1YpuOktWWo8ZlUl5VCx7yfHIHDJJ/BK
 HJFDeX4CnjZE9JyxdVuZ4k1W8a6ztzOYRkjqGrvb/OZkxWr/1L4VQZMUxAn7KdxTIGYpDjELdPJ
 kRWxPAGsTZbyH1rdvpjqoyxjRb+6ZIUe3AU/3XlLXSmr0MWrR9XwJ/UbcI7PPX59MXn7MozGAGv
 NkFKA==
X-Received: by 2002:a17:90a:d404:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-395decde369mr29780501a91.0.1787550571741; 
 Sun, 23 Aug 2026 22:49:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 23/96] target/riscv: do not count ECALL in minstret
Date: Mon, 24 Aug 2026 15:46:53 +1000
Message-ID: <20260824054806.2790041-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
---
 target/riscv/tcg/pmu.h                    |  1 +
 target/riscv/tcg/op_helper.c              |  6 +++
 target/riscv/tcg/pmu.c                    | 44 +++++++++++++-----
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-minstret-ecall.S   | 55 +++++++++++++++++++++++
 5 files changed, 98 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-minstret-ecall.S

diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index b4f1e469a2..2429c01b77 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -36,6 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
+void riscv_pmu_decr_instret(CPURISCVState *env);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx);
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index ba3c7da375..acdccd1a97 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -21,6 +21,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
+#ifndef CONFIG_USER_ONLY
+#include "pmu.h"
+#endif
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -47,6 +50,9 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
+#ifndef CONFIG_USER_ONLY
+    riscv_pmu_decr_instret(env);
+#endif
     riscv_raise_exception(env, exception, 0);
 }
 
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 38ad2737e1..1a4658319b 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -49,6 +49,21 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
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
@@ -147,12 +162,27 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
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
 
@@ -170,17 +200,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
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
 
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 908fd008e4..fac0474746 100644
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
index 0000000000..ab268f7f22
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
2.54.0


