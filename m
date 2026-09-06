Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA01C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3FsY-0002tq-1T; Sun, 06 Sep 2026 12:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsW-0002rk-5K; Sun, 06 Sep 2026 12:38:00 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsQ-00034r-1T; Sun, 06 Sep 2026 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712661; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=viOOe7smLkpWORSnnyjZ7fkNNcWDtL6fhqM5XkykUVY=;
 b=iWT5ke6zr0qxKa9MuZX8WBjcuTl4Ec/ebltXWepFRbzXeJs2VcQsZMo7Kr3OuKx44GWDULzl77TQT0V4IqG2mP4UHGnFD1b2qS75HEGJ7rCZvN5VEFDkre0Iw5Wb/e0LL5z6CDB8GRsjPX/gMfVDsXkGvO2wTP4nUAHxTImofwM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIKw_1788712659; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIKw_1788712659 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:39 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:30 +0800
Subject: [PATCH 14/14] target/riscv: Preserve fixed PMU state across reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-14-5f1f41458989@linux.alibaba.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
In-Reply-To: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=7074;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=2enD98ZE6bl3nA0tsxaYMcS19QEg1Xx+ZgF2vOA5LYM=;
 b=R073xL1WvFir862XvJDQhJiTfXD07OyvVjhsl3n3xmUd63ApkQRcVFIX8EVV0y2oscdO9gOoT
 W4H0LKmiPbcBxZd9iQGnfTDP/g2BSrsG+VlOehCrFOGvGe7qp4SaKgc
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.c                        |  16 +++++
 target/riscv/tcg/pmu.c                    |  11 ++++
 target/riscv/tcg/pmu.h                    |   1 +
 tests/tcg/riscv64/Makefile.softmmu-target |   6 ++
 tests/tcg/riscv64/pmu-reset-vs.S          | 102 ++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b7ce3ebd45d8467464654a8b8560e88deeea4ff9..4355f72cdfda41ab4e9678a066821c0f410fe17c 100644
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
@@ -1092,6 +1105,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
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
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index deb44ece5feeb13756f9f3abcd38258d75bd9ba1..ef7641b16deb449e3a84e429dfca998dbd63a54e 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -95,6 +95,12 @@ TESTS += pmu-cycle-controls
 run-pmu-cycle-controls: pmu-cycle-controls
 	$(call run-test, $<, $(QEMU) -cpu max -icount shift=0 $(QEMU_OPTS)$<)
 
+TESTS += pmu-reset-vs
+run-pmu-reset-vs: pmu-reset-vs
+	$(call run-test, $<, $(QEMU) -M virt -bios none -kernel $< \
+		-display none -semihosting -cpu max$(COMMA)smcntrpmf=true \
+		-icount shift=0)
+
 EXTRA_RUNS += run-plugin-doubletrap
 run-plugin-doubletrap: doubletrap
 	$(call run-test, $<, \
diff --git a/tests/tcg/riscv64/pmu-reset-vs.S b/tests/tcg/riscv64/pmu-reset-vs.S
new file mode 100644
index 0000000000000000000000000000000000000000..856ca003fa1115fdba5e789128aa1d6fd0f950b6
--- /dev/null
+++ b/tests/tcg/riscv64/pmu-reset-vs.S
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+	/* MTIMECMP retains the marker and saved count across the RAM reload. */
+	li	t0, MTIMECMP
+	ld	t1, 0(t0)
+	srli	t2, t1, 48
+	li	t3, 0xa5a5
+	beq	t2, t3, after_reset
+
+	/* Count VS only, then remember the value before entering VS-mode. */
+	li	t0, 0x1d		/* MINH | SINH | UINH | VUINH */
+	slli	t0, t0, 58
+	csrw	0x321, t0		/* mcyclecfg */
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

-- 
2.43.0


