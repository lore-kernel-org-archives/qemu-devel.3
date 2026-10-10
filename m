Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D93CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQDE-0002mv-K3; Sat, 10 Oct 2026 02:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCp-0002g4-Ha; Sat, 10 Oct 2026 02:05:16 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCj-00040z-JF; Sat, 10 Oct 2026 02:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612291; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=gX8QLqnW2TXRtibakJdxF3o7Jtgbdv3RBeWGvu7oSnc=;
 b=oted3b02fmpGSdxyTLCipC0OhseJawxLIwkdAdYRbQrNaprzJQRlv+0jx6POG5qbU2I2YHFIiuuDsr3nw0F3IWGNvE94P8PivEdUHluC7KLXB4/498ncGGG1cQdhWbYh0Wlu5r57xhQtCn7J3eHjbaNkmbkozR89og+jubVQQXs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGv7_1791612290; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGv7_1791612290 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:50 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:38 +0800
Subject: [PATCH v3 14/14] target/riscv: Preserve fixed PMU state across reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-14-712bf814a7be@linux.alibaba.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
In-Reply-To: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612281; l=6982;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=TJnrfRQl9h9APvTXXv1oZrDWMh6OEJbODHiPdkwFZFc=;
 b=K1x8teL1H+zTgMQSbl43t/ZEqi9kA6FQooR2EPzKLsEzcbB968JvGjMt324fP4r8SFobanaxX
 WZOgGeIJWjiAKx4XVxOYzVWmnT3bo2sOUcBIl2VKYGQIBgY0Ccli3XK
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Privilege filtering records cycle/instruction increments per mode. Reset
overwrites privilege/V without adding the final interval to the old
mode's total, so a counter filtering for that mode loses those counts.

Account for the old mode before entering M-mode with V=0 and rebuild the
overflow timer after reset. On initial reset, only initialize baselines:
no guest code has run, so pre-execution QEMU time must not count.
Preserve architectural counter and selector state, as before.

Test that a VS-only cycle counter retains its counts across reset.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.c                   |  16 ++++++
 target/riscv/tcg/pmu.c               |  11 ++++
 target/riscv/tcg/pmu.h               |   1 +
 tests/tcg/riscv64/pmu-reset-vs.S     | 105 +++++++++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build |   7 +++
 5 files changed, 140 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 34422d0204e7c1532c3424626c70d33f805833d5..2a05c91bbe09313c22e4263d6dfa16bb5aca11d5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -42,6 +42,9 @@
 #include "disas/capstone.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/tcg/debug.h"
+#ifdef CONFIG_TCG
+#include "target/riscv/tcg/pmu.h"
+#endif
 #endif
 
 /* RISC-V CPU definitions */
@@ -979,6 +982,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->def->misa_mxl_max;
+#ifdef CONFIG_TCG
+    /* The initial reset has no guest execution to count. */
+    if (tcg_enabled()) {
+        if (qdev_is_realized(DEVICE(cpu))) {
+            riscv_pmu_update_fixed_ctrs(env, PRV_M, false);
+        } else {
+            riscv_pmu_init_fixed_counter_baselines(env);
+        }
+    }
+#endif
     env->priv = PRV_M;
     env->virt_enabled = false;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
@@ -1095,6 +1108,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
+    if (tcg_enabled()) {
+        riscv_pmu_rebuild_timer(env);
+    }
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index df99b572a4c16cb1ac65c2f7cde35c6f8349e681..1d692a0a8e3f7759e033214d579103627d070b5b 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -171,6 +171,17 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
     riscv_pmu_update_fixed_ctrs_snapshot(env, newpriv, new_virt, &snapshot);
 }
 
+void riscv_pmu_init_fixed_counter_baselines(CPURISCVState *env)
+{
+    RISCVPMUFixedSnapshot snapshot;
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_CYCLE]
+        .counter_prev[PRV_M] = snapshot.cycle;
+    env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_INSTRET]
+        .counter_prev[PRV_M] = snapshot.instret;
+}
+
 uint64_t
 riscv_pmu_ctr_get_fixed_value(CPURISCVState *env, uint32_t ctr_idx,
                               const RISCVPMUFixedSnapshot *snapshot)
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 1cfe6acf55b5468f5c00c4a136ece88981384341..fac84dbb1a8a6c637f7241ca27910e5e212223e9 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -53,6 +53,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
+void riscv_pmu_init_fixed_counter_baselines(CPURISCVState *env);
 void riscv_pmu_decr_instret(CPURISCVState *env);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx,
diff --git a/tests/tcg/riscv64/pmu-reset-vs.S b/tests/tcg/riscv64/pmu-reset-vs.S
new file mode 100644
index 0000000000000000000000000000000000000000..d216faef17a2a395120cb3a71166a821a43dee88
--- /dev/null
+++ b/tests/tcg/riscv64/pmu-reset-vs.S
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR number for older assemblers. */
+#define CSR_MCYCLECFG        0x321
+
+	.option	norvc
+	.option	norelax
+
+	.equ	MSTATUS_MPP_S,  (1 << 11)
+	.equ	MSTATUS_MPP,    (3 << 11)
+	.equ	MSTATUS_SPP,    (1 << 8)
+	.equ	HSTATUS_SPV,    (1 << 7)
+	.equ	SIFIVE_TEST,    0x100000
+	.equ	MTIMECMP,       0x2004000
+	.equ	FINISHER_RESET, 0x7777
+
+	.text
+	.global _start
+_start:
+	/* Preserve the reset marker and saved count in MTIMECMP. */
+	li	t0, MTIMECMP
+	ld	t1, 0(t0)
+	srli	t2, t1, 48
+	li	t3, 0xa5a5
+	beq	t2, t3, after_reset
+
+	/* Count VS only, then remember the value before entering VS-mode. */
+	li	t0, 0x1d		/* MINH | SINH | UINH | VUINH */
+	slli	t0, t0, 58
+	csrw	CSR_MCYCLECFG, t0
+	csrr	t1, mcycle
+	slli	t1, t1, 16
+	srli	t1, t1, 16
+	li	t2, 0xa5a5
+	slli	t2, t2, 48
+	or	t1, t1, t2
+	li	t0, MTIMECMP
+	sd	t1, 0(t0)
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f		/* RWX, NAPOT */
+	csrw	pmpcfg0, t0
+
+	/* Enter HS-mode first. */
+	csrr	t0, mstatus
+	li	t1, MSTATUS_MPP
+	not	t1, t1
+	and	t0, t0, t1
+	li	t1, MSTATUS_MPP_S
+	or	t0, t0, t1
+	csrw	mstatus, t0
+	lla	t0, hs_enter
+	csrw	mepc, t0
+	mret
+
+hs_enter:
+	li	t0, HSTATUS_SPV
+	csrs	hstatus, t0
+	li	t0, MSTATUS_SPP
+	csrs	sstatus, t0
+	lla	t0, vs_reset
+	csrw	sepc, t0
+	sret
+
+vs_reset:
+	/* These VS-mode cycles must remain in mcycle after reset. */
+	li	t0, 128
+1:
+	addi	t0, t0, -1
+	bnez	t0, 1b
+
+	li	t0, SIFIVE_TEST
+	li	t1, FINISHER_RESET
+	sw	t1, 0(t0)
+	j	.
+
+after_reset:
+	csrr	t0, mcycle
+	slli	t1, t1, 16		/* Clear the MTIMECMP marker. */
+	srli	t1, t1, 16
+	addi	t1, t1, 128
+	bgeu	t1, t0, fail
+	li	t3, 0
+	j	exit
+
+fail:
+	li	t3, 1
+
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t3, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
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
index c24468ab560ccf525f7ded98c0dd53a67e0833e2..d89d72ac49a57e87bf6e8ae905c3af6f3550f77c 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -142,6 +142,13 @@ tests += {
   },
 }
 
+tests += {
+  'pmu-reset-vs.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max,smcntrpmf=true', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


