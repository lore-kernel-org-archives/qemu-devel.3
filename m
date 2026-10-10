Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41206CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQDL-0002sJ-KE; Sat, 10 Oct 2026 02:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCp-0002g3-7Z; Sat, 10 Oct 2026 02:05:16 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCi-00040p-WF; Sat, 10 Oct 2026 02:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612288; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=0LBL9rfxyeVv8adk3rsQPyqAwBcvGP7El6GJORaAPhk=;
 b=nWpOFK69OafMTeWI/d/3bKuHOfYyxKWxXyOm1DwgsGGqdBdNEFgwxU0X6A/PbrHUjOMGE/Y8NyoUzEMrgSEotITg3zUl96Od3Id5RqxDLY0gsT+knZkl9YBm1SJXeAMRn+sljlcKnBQWR9lYJqTPharyLD5RsO8FFvMiTf4EKR0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R781e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGtv_1791612287; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGtv_1791612287 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:47 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:33 +0800
Subject: [PATCH v3 09/14] target/riscv: Rebuild fixed-event PMU overflow
 deadlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-9-712bf814a7be@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612281; l=18632;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=I9wvvRLZPfyAeT7nCZYN/xqRPpM+s0XBc//8L15vN+s=;
 b=THZhjsDTnsMsziYb7pJmeQ5g3bt79QO9A6k49H5S4ZW7mHhcMJq3yCOKwWamHrtKB9FpBrBN+
 WWIMFSm8bv+D/EjAgHJ31bnuPLrYONf+ZDWcrKA2oRFQ1gwh5cf4qgW
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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

timer_mod_anticipate_ns() cannot postpone the shared overflow timer when
a counter is stopped or reconfigured. Recompute the earliest deadline
from all eligible counters after PMU changes and timer expiry. Check for
an actual counter wrap before setting OF or LCOFIP.

Keep counter arithmetic in source units. For timer scheduling, convert
only raw icount instruction counts to nanoseconds. Check how many fit
within INT64_MAX - now nanoseconds before conversion, using INT64_MAX as
the deadline if the count is larger. Recompute the remaining count at
expiry instead of keeping irq_overflow_left.

Icount time warp can expire the timer without executing instructions.
If the instruction source has not advanced, defer its next deadline
until execution resumes to avoid an endless warp/rearm loop.

Extend the cycle-control test to cover selector writes while CY is set
and resuming mcycle after CY is cleared.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h                     |   4 +-
 target/riscv/tcg/cpu_helper.c          |   2 +
 target/riscv/tcg/pmu.c                 | 239 +++++++++++++--------------------
 target/riscv/tcg/pmu.h                 |   3 +-
 target/riscv/tcg/tcg-cpu.c             |  10 ++
 tests/tcg/riscv64/pmu-cycle-controls.S |  27 ++++
 6 files changed, 139 insertions(+), 146 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a660e16cf6e38bd5c287ed2013539d51efc2848f..1ab6ae6937aeca524c4635eae6c000f4a6d1ac5a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -236,8 +236,6 @@ typedef struct PMUCTRState {
     uint64_t mhpmcounter_val;
     /* Snapshot value of a counter */
     uint64_t mhpmcounter_prev;
-    /* Value beyond INT64_MAX before overflow interrupt trigger */
-    uint64_t irq_overflow_left;
 } PMUCTRState;
 
 typedef enum {
@@ -586,6 +584,8 @@ struct ArchCPU {
     RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
+    uint64_t pmu_timer_instret_snapshot;
+    bool pmu_timer_stalled;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d92226527d85da93b8810e526d044e64fa4e3d..89751cdbf29f5bbd46d0d6b8c9d23eac5e3accac 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -889,6 +889,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
             riscv_cpu_update_mip(env, 0, 0);
         }
     }
+
+    riscv_pmu_rebuild_timer(env);
 }
 
 /*
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 2f600c5a0fc2d7ba380ef34f89af6366e3e27884..f88f6ae671d877ed874d22c9d4b840edb6f433a5 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -26,13 +26,6 @@
 #include "system/device_tree.h"
 #include "system/cpu-timers.h"
 
-/*
- * cpu_get_ticks() does not expose the host tick frequency.  Use a 1 GHz
- * approximation only when scheduling non-icount overflow checks; fixed
- * counter values remain in host-tick units.
- */
-#define RISCV_PMU_HOST_TICK_HZ_ASSUMED 1000000000
-
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
@@ -324,7 +317,6 @@ void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
                            uint64_t value, uint64_t wr_mask)
 {
     RISCVPMUFixedSnapshot snapshot;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
 
     riscv_pmu_take_fixed_snapshot(env, &snapshot);
     if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
@@ -337,10 +329,7 @@ void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
     if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
         riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
     }
-
-    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
-        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
-    }
+    riscv_pmu_rebuild_timer(env);
 }
 
 void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
@@ -349,23 +338,19 @@ void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
     RISCVPMUFixedSnapshot snapshot;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     bool rv32 = xl == MXL_RV32;
-    bool running;
     int start = upper_half ? 32 : 0;
     int length = rv32 ? 32 : 64;
 
     g_assert(rv32 || !upper_half);
 
     riscv_pmu_take_fixed_snapshot(env, &snapshot);
-    running = riscv_pmu_fixed_ctr_running(env, ctr_idx);
-    if (running) {
+    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
         riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
     }
     counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
                                          start, length, value);
     /* mhpmcounter_prev tracks the source, not the written counter value. */
-    if (running && ctr_idx > 2) {
-        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
-    }
+    riscv_pmu_rebuild_timer(env);
 }
 
 void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
@@ -396,11 +381,8 @@ void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
         if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
             riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
         }
-        if (ctr_idx > 2 && riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
-            riscv_pmu_setup_timer(env, env->pmu_ctrs[ctr_idx].mhpmcounter_val,
-                                  ctr_idx);
-        }
     }
+    riscv_pmu_rebuild_timer(env);
 }
 
 void riscv_pmu_decr_instret(CPURISCVState *env)
@@ -512,17 +494,6 @@ static bool riscv_pmu_event_supported(uint32_t event_idx)
     }
 }
 
-static int64_t pmu_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
-                               int64_t value)
-{
-    if (icount_enabled() &&
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        return icount_to_ns(value);
-    }
-
-    return (NANOSECONDS_PER_SECOND / RISCV_PMU_HOST_TICK_HZ_ASSUMED) * value;
-}
-
 void riscv_pmu_rebuild_event_map(CPURISCVState *env)
 {
     uint32_t ctr_idx, ctr_mask, event_idx;
@@ -551,148 +522,132 @@ void riscv_pmu_rebuild_event_map(CPURISCVState *env)
     }
 }
 
-static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
-{
-    if (!get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
-        env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-        return true;
-    } else {
-        return false;
-    }
-}
-
-static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
+static int64_t riscv_pmu_overflow_delay_ns(CPURISCVState *env,
+                                           uint32_t ctr_idx,
+                                           uint64_t value, int64_t now)
 {
-    CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter;
-    int64_t irq_trigger_at;
-    uint64_t curr_ctr_val, curr_ctrh_val;
-    uint64_t ctr_val;
+    uint64_t remaining;
+    uint64_t max_delay = INT64_MAX - now;
 
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
-        return;
+    if (!value) {
+        /* A complete 64-bit wrap is beyond the signed timer horizon. */
+        return max_delay;
     }
+    remaining = -value;
 
-    /* Generate interrupt only if OF bit is clear */
-    if (get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
-        return;
-    }
-
-    counter = &env->pmu_ctrs[ctr_idx];
-    if (counter->irq_overflow_left > 0) {
-        irq_trigger_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                        counter->irq_overflow_left;
-        timer_mod_anticipate_ns(cpu->pmu_timer, irq_trigger_at);
-        counter->irq_overflow_left = 0;
-        return;
-    }
+    if (icount_enabled() &&
+        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        /* Use one adaptive-shift sample for both bounds and conversion. */
+        uint64_t ns_per_tick = icount_to_ns(1);
+        uint64_t max_ticks = max_delay / ns_per_tick;
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx,
-                        riscv_cpu_mxl(env));
-    ctr_val = counter->mhpmcounter_val;
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx,
-                            riscv_cpu_mxl(env));
-        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
+        if (remaining > max_ticks) {
+            return max_delay;
+        }
+        return remaining * ns_per_tick;
     }
 
     /*
-     * We can not accommodate for inhibited modes when setting up timer. Check
-     * if the counter has actually overflowed or not by comparing current
-     * counter value (accommodated for inhibited modes) with software written
-     * counter value.
+     * Cycle under icount is already virtual ns.  Non-icount fixed events
+     * retain QEMU's existing one-host-tick-per-ns deadline approximation.
      */
-    if (curr_ctr_val >= ctr_val) {
-        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
-        return;
-    }
-
-    if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
-        if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
-            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-        }
-    }
+    return MIN(remaining, max_delay);
 }
 
-static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum riscv_pmu_event_idx evt_idx)
+static void riscv_pmu_rebuild_timer_internal(CPURISCVState *env,
+                                             bool timer_expired)
 {
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVPMUFixedSnapshot snapshot;
     uint32_t ctr_idx;
     uint32_t ctr_mask;
+    int64_t deadline = INT64_MAX;
+    int64_t now;
+    bool have_deadline = false;
+    bool timer_horizon_exhausted;
+    bool stalled = false;
 
-    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
-        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
+    if (!cpu->pmu_timer) {
         return;
     }
 
-    ctr_mask = riscv_pmu_event_counter_mask(cpu, evt_idx);
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    /* No future absolute timer deadline is representable at this point. */
+    timer_horizon_exhausted = now == INT64_MAX;
+
+    ctr_mask = riscv_pmu_event_counter_mask(
+        cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
+    ctr_mask |= riscv_pmu_event_counter_mask(
+        cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
 
     while (ctr_mask) {
+        PMUCTRState *counter;
+        int64_t candidate;
+
         ctr_idx = ctz32(ctr_mask);
         ctr_mask &= ~BIT(ctr_idx);
-        pmu_timer_trigger_irq_counter(cpu, ctr_idx);
-    }
-}
+        counter = &env->pmu_ctrs[ctr_idx];
 
-/* Timer callback for instret and cycle counter overflow */
-void riscv_pmu_timer_cb(void *priv)
-{
-    RISCVCPU *cpu = priv;
+        if (!riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+            continue;
+        }
+        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
+        if ((env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF) ||
+            riscv_pmu_counter_filtered(env,
+                                       env->mhpmevent_val[ctr_idx])) {
+            continue;
+        }
 
-    /* Timer event was triggered only for these events */
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
-}
+        /*
+         * Settle current deltas and overflows even when no future deadline is
+         * representable.
+         */
+        if (timer_horizon_exhausted) {
+            continue;
+        }
 
-int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
-{
-    uint64_t overflow_delta, overflow_at, curr_ns;
-    int64_t overflow_ns, overflow_left = 0;
-    RISCVCPU *cpu = env_archcpu(env);
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+        if (timer_expired && icount_enabled() &&
+            riscv_pmu_ctr_monitor_instructions(env, ctr_idx) &&
+            snapshot.instret == cpu->pmu_timer_instret_snapshot) {
+            /*
+             * Icount can warp QEMU_CLOCK_VIRTUAL to this deadline without
+             * executing an instruction. Re-arming the unchanged instruction
+             * distance would create a warp/rearm loop; defer it until this
+             * CPU enters execution again.
+             */
+            stalled = true;
+            continue;
+        }
 
-    /* No need to setup a timer if LCOFI is disabled when OF is set */
-    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
-        get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
-        return -1;
+        candidate = now + riscv_pmu_overflow_delay_ns(
+                              env, ctr_idx, counter->mhpmcounter_val, now);
+        if (!have_deadline || candidate < deadline) {
+            deadline = candidate;
+            have_deadline = true;
+        }
     }
 
-    if (value) {
-        overflow_delta = UINT64_MAX - value + 1;
+    cpu->pmu_timer_instret_snapshot = snapshot.instret;
+    cpu->pmu_timer_stalled = stalled;
+    if (have_deadline) {
+        timer_mod_ns(cpu->pmu_timer, deadline);
     } else {
-        overflow_delta = UINT64_MAX;
-    }
-
-    /*
-     * QEMU supports only int64_t timers while RISC-V counters are uint64_t.
-     * Compute the leftover and save it so that it can be reprogrammed again
-     * when timer expires.
-     */
-    if (overflow_delta > INT64_MAX) {
-        overflow_left = overflow_delta - INT64_MAX;
+        timer_del(cpu->pmu_timer);
     }
+}
 
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        overflow_ns = pmu_ticks_to_ns(env, ctr_idx,
-                                      (int64_t)overflow_delta);
-        overflow_left = pmu_ticks_to_ns(env, ctr_idx, overflow_left);
-    } else {
-        return -1;
-    }
-    curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    overflow_at =  curr_ns + overflow_ns;
-    if (overflow_at <= curr_ns)
-        overflow_at = UINT64_MAX;
+void riscv_pmu_rebuild_timer(CPURISCVState *env)
+{
+    riscv_pmu_rebuild_timer_internal(env, false);
+}
 
-    if (overflow_at > INT64_MAX) {
-        overflow_left += overflow_at - INT64_MAX;
-        counter->irq_overflow_left = overflow_left;
-        overflow_at = INT64_MAX;
-    }
-    timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
+/* Timer callback for instret and cycle counter overflow */
+void riscv_pmu_timer_cb(void *priv)
+{
+    RISCVCPU *cpu = priv;
 
-    return 0;
+    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
 }
 
 
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 1494fbc21f53137a90c1338f6ca8e3c3e750276a..d9238ae680f5e67031511db4f9afc2884212c5c2 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -44,12 +44,11 @@ void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
                              target_ulong value, bool upper_half, RISCVMXL xl);
 void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value);
 void riscv_pmu_timer_cb(void *priv);
+void riscv_pmu_rebuild_timer(CPURISCVState *env);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 void riscv_pmu_rebuild_event_map(CPURISCVState *env);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
-int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
-                          uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
 void riscv_pmu_decr_instret(CPURISCVState *env);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af8307c1e46d3f200c5313823d240eb7b3..cdcb94f3bcaf0526512f1994e9f7127209e1adcb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -247,6 +247,15 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
+static void riscv_cpu_exec_enter(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+
+    if (cpu->pmu_timer_stalled) {
+        riscv_pmu_rebuild_timer(&cpu->env);
+    }
+}
+
 static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
                                 vaddr result, vaddr base)
 {
@@ -283,6 +292,7 @@ const TCGCPUOps riscv_tcg_ops = {
     .mmu_index = riscv_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
diff --git a/tests/tcg/riscv64/pmu-cycle-controls.S b/tests/tcg/riscv64/pmu-cycle-controls.S
index fdd14755f4d196dc2a3ec6c8b8540adc40b3a253..474d46d61baa2c3ec55a5a40d7bdb7ddd3dd7f2f 100644
--- a/tests/tcg/riscv64/pmu-cycle-controls.S
+++ b/tests/tcg/riscv64/pmu-cycle-controls.S
@@ -17,6 +17,8 @@ _start:
 	 * 1: mcycle changes while M-mode is filtered
 	 * 2: disabling MINH adds the filtered interval
 	 * 3: mcycle does not resume after disabling MINH
+	 * 4: writing mhpmevent3 advances mcycle while CY is set
+	 * 5: mcycle does not resume after clearing CY
 	 */
 	li	t4, 0
 	csrw	mcountinhibit, zero
@@ -61,6 +63,31 @@ _start:
 	slli	t1, t1, 3
 	or	t4, t4, t1
 
+	/* Changing HPM3's event must leave mcycle stopped while CY is set. */
+	li	t0, 1			/* mcountinhibit.CY */
+	csrw	mcountinhibit, t0
+	csrr	s4, mcycle
+	.rept	128
+	nop
+	.endr
+	li	t0, 1			/* HW_CPU_CYCLES */
+	csrw	mhpmevent3, t0		/* mhpmevent3; rebuilds PMU timer */
+	csrr	s5, mcycle
+	xor	t1, s4, s5
+	sltu	t1, zero, t1
+	slli	t1, t1, 4
+	or	t4, t4, t1
+	csrw	mcountinhibit, zero
+	csrr	s6, mcycle
+	.rept	128
+	nop
+	.endr
+	csrr	t1, mcycle
+	sltu	t1, s6, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 5
+	or	t4, t4, t1
+	csrw	mhpmevent3, zero
 	lla	a1, semiargs
 	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
 	sd	t0, 0(a1)

-- 
2.43.0


