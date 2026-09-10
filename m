Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55827C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fwp-000341-1r; Thu, 10 Sep 2026 10:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwk-0002yZ-Lb; Thu, 10 Sep 2026 10:40:14 -0400
Received: from [115.124.30.133] (helo=out30-133.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwc-0003Pq-EY; Thu, 10 Sep 2026 10:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789051193; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=6QB9Wg5wul/4ejfuCicWnHoFeUOCpvMI7cTCZbtZ1nE=;
 b=xqr3ORg1mdrSG7nICcodryEFaGaGspRifSvKFVhivzmJsnRH6kmZcKgzwMB1eQah8ICW30xxjMEmCjVCMRL0EE0FNeVt+LLGjslb/Y8zZF4vAepTMj8GeKGd41X+DI+M4MiK9Bm7p5UbGM7hSGeR7YGHsq4ed/hQzdrZ614s6Y8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XAhkcDz_1789051192; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XAhkcDz_1789051192 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 10 Sep 2026 22:39:52 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 10 Sep 2026 22:39:38 +0800
Subject: [PATCH v2 01/14] target/riscv: Preserve PMU state across event
 selector writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-riscv-pmu-correctness-v2-1-5da5159a0c64@linux.alibaba.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
In-Reply-To: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789051191; l=10059;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=1GxQCcZMwvXqgh+qyLGeY2NR8CuEqs1kzB9vVtjD8tA=;
 b=7ZYdeuAvOT1RxSSMg3mkR7AzvdRum+wQqpnuQTbvYpIqnWxI4Jcn2KzK2pUILfQDvmIYAWtPW
 MPn7d+w2FpGBKOgtUZhZx9RuZxHdSPfcM27etZP1T21aBDQP3V7afXJ
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.133 (deferred)
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Changing mhpmevent can lose pending cycle/instruction counts or leave a
new fixed source without a baseline and overflow timer.

Account for the old source before replacing the selector, then establish
the enabled counter's new baseline and timer. Apply this to direct and
indirect writes.

Test overflow after initializing a counter with event zero and then
selecting instructions.

Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                | 73 +++++++++++++++++++++++++----------
 tests/tcg/riscv64/sscofpmf-overflow.S | 60 ++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build  |  7 ++++
 3 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 65985efb220c80023cfd9d08e1878a19342aa879..52664a26f5a97a5dc8ff37abf99b4d10927fb120 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1209,23 +1209,58 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
 
-    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
+    *val = extract64(env->mhpmevent_val[ctr_idx], 0, rv32 ? 32 : 64);
 
     return RISCV_EXCP_NONE;
 }
 
+static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                     int counter_idx);
+
+static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
+                                      uint32_t ctr_idx, uint64_t value)
+{
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    bool enabled = !get_field(env->mcountinhibit, BIT(ctr_idx));
+
+    /*
+     * A programmable counter backed by a fixed source uses mhpmcounter_val
+     * as its base and mhpmcounter_prev as the source snapshot.  Preserve the
+     * visible value before changing the source or its privilege filters.
+     */
+    if (enabled &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
+        uint64_t source = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                               ctr_idx);
+
+        counter->mhpmcounter_val += source - counter->mhpmcounter_prev;
+    }
+
+    env->mhpmevent_val[ctr_idx] = value;
+    riscv_pmu_update_event_map(env, value, ctr_idx);
+
+    if (enabled &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
+        counter->mhpmcounter_prev =
+            riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
+        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
+    }
+}
+
 static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
-    int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val;
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
+        mhpmevt_val = deposit64(env->mhpmevent_val[ctr_idx], 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1237,8 +1272,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         mhpmevt_val = val & inh_avail_mask;
     }
 
-    env->mhpmevent_val[evt_index] = mhpmevt_val;
-    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
 
     return RISCV_EXCP_NONE;
 }
@@ -1246,9 +1280,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
 static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
+    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
 
-    *val = extract64(env->mhpmevent_val[evt_index], 32, 32);
+    *val = extract64(env->mhpmevent_val[ctr_idx], 32, 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -1256,7 +1290,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
-    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
+    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
@@ -1267,10 +1301,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
-    env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
-                                              32, 32, val & inh_avail_mask);
-
-    riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
+    riscv_pmu_write_mhpmevent(env, ctr_idx,
+                              deposit64(env->mhpmevent_val[ctr_idx], 32, 32,
+                                        val & inh_avail_mask));
 
     return RISCV_EXCP_NONE;
 }
@@ -1512,11 +1545,11 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
     return 0;
 }
 
-static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
+static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
                             target_ulong *val, target_ulong new_val,
                             uint64_t wr_mask)
 {
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
 
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
@@ -1531,8 +1564,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
         wr_mask &= ~MHPMEVENT_BIT_MINH;
         /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
         mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
-        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
     } else {
         return -EINVAL;
     }
@@ -1540,11 +1572,11 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
     return 0;
 }
 
-static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
+static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
                              target_ulong *val, target_ulong new_val,
                              target_ulong wr_mask)
 {
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
     uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
 
     if (wr_mask != 0 && wr_mask != -1) {
@@ -1560,8 +1592,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
         wr_mask &= ~MHPMEVENTH_BIT_MINH;
         mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
         mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
-        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
     } else {
         return -EINVAL;
     }
diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
new file mode 100644
index 0000000000000000000000000000000000000000..97f03037bbfdd44f2288b257afb91499e4534f13
--- /dev/null
+++ b/tests/tcg/riscv64/sscofpmf-overflow.S
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/* Program hpmcounter3 while no event is selected. */
+	csrw	mhpmevent3, zero
+	li	t0, -256
+	csrw	mhpmcounter3, t0
+
+	/* Start counting retired instructions with overflow enabled. */
+	li	t0, 2
+	csrw	mhpmevent3, t0
+
+	/* Cross the 64-bit unsigned overflow boundary. */
+	.rept	1024
+	nop
+	.endr
+
+	/* OF must be sticky and LCOFIP must pend even with LCOFIE clear. */
+	li	t4, 0
+	csrr	t0, mhpmevent3
+	srli	t1, t0, 63
+	xori	t1, t1, 1
+	or	t4, t4, t1
+
+	csrr	t0, mip
+	li	t1, 1 << 13
+	and	t0, t0, t1
+	sltu	t0, zero, t0
+	xori	t0, t0, 1
+	or	t4, t4, t0
+
+	/* The counter wraps and continues counting after overflow. */
+	csrr	t0, mhpmcounter3
+	li	t1, -256
+	sltu	t0, t0, t1
+	xori	t0, t0, 1
+	or	t4, t4, t0
+
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t4, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
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
index 8604c2a45a9ad6bf8589f90d5b0d8fd1b2736db4..ebe78200fd551b42d3c99ae19ca03803797f803d 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -61,6 +61,13 @@ tests += {
   }
 }
 
+tests += {
+  'sscofpmf-overflow.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


