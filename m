Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EA606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bvnv5AmG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSP-0002LD-4F; Thu, 12 Nov 2026 04:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRb-0001n8-69; Thu, 12 Nov 2026 04:50:12 -0500
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRT-0002yW-2G; Thu, 12 Nov 2026 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476975; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=yum81PMFqqdXDBS2jSab/Ok2PMc9HMg6in2va8TtdfI=;
 b=Bvnv5AmGEdPakuD9KKDYTfvtnk6NIEeplQ7qfLQFtK4u04k5XYl3wJaCdvPaeQJgbH78FpaY+/dGtTUuJX2UsZbH7O7xvSSNwDzEMtki+Rcz6QQ2FPpqmrtw9pKpVtYqMitnyOCtLAt/8pbp1g1UOwHLvR1l/IMJAB5xl75ZueE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdc7_1794476973; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdc7_1794476973 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:33 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:15 +0800
Subject: [PATCH v4 09/14] target/riscv: Rebuild fixed-event PMU overflow
 deadlines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-9-e9067bdf4df5@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=18736;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=qhDwRqpdJCwggKMLmZWyA6e8U51kJoefS7HTiHtF5HQ=;
 b=5hbKJlrm1awF0LGJMFPhuGHDa2q6uCkWra/SkVax0HjJrdPThzJhN+9N0zSUbSXxmli7ozkRA
 N0D9Jrs4uWZDipB635V6j+eSOqoCHrQTjEv1PRqKv+iJFcvAd0tcKvB
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 target/riscv/tcg/pmu.c                 | 245 +++++++++++++--------------------
 target/riscv/tcg/pmu.h                 |   3 +-
 target/riscv/tcg/tcg-cpu.c             |  13 +-
 tests/tcg/riscv64/pmu-cycle-controls.S |  27 ++++
 6 files changed, 137 insertions(+), 157 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1dd9136f620bfa5c4d8a18a9d3d3816af233c37e..d7cc36bc621def7bf3dae33e133807e5f5e13b5f 100644
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
@@ -591,6 +589,8 @@ struct ArchCPU {
     RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
+    uint64_t pmu_timer_instret_snapshot;
+    bool pmu_timer_stalled;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c29106f39074283a79038dbad255fae..2720eb3208b1a2319365d8f6e1a242f043573999 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -982,6 +982,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
             riscv_cpu_interrupt(env);
         }
     }
+
+    riscv_pmu_rebuild_timer(env);
 }
 
 /*
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 7b07524361f9b175dc7e9590380e70e1d6f97098..f88f6ae671d877ed874d22c9d4b840edb6f433a5 100644
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
@@ -551,154 +522,132 @@ void riscv_pmu_rebuild_event_map(CPURISCVState *env)
     }
 }
 
-static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
+static int64_t riscv_pmu_overflow_delay_ns(CPURISCVState *env,
+                                           uint32_t ctr_idx,
+                                           uint64_t value, int64_t now)
 {
-    if (!get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
-        env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-        return true;
-    } else {
-        return false;
-    }
-}
+    uint64_t remaining;
+    uint64_t max_delay = INT64_MAX - now;
 
-static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter;
-    int64_t irq_trigger_at;
-    target_ulong ctr_lo = 0, ctr_hi = 0;
-    uint64_t curr_ctr_val;
-    uint64_t ctr_val;
-
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
 
-    /*
-     * riscv_pmu_read_ctr() stores a target_ulong, so on RV32 each call fills
-     * only 32 bits. Read each half into its own target_ulong and build the
-     * 64 bit value explicitly instead of passing a cast uint64_t pointer,
-     * which would leave the upper half uninitialised.
-     */
-    riscv_pmu_read_ctr(env, &ctr_lo, false, ctr_idx, riscv_cpu_mxl(env));
-    curr_ctr_val = ctr_lo;
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, &ctr_hi, true, ctr_idx, riscv_cpu_mxl(env));
-        curr_ctr_val |= (uint64_t)ctr_hi << 32;
+        if (remaining > max_ticks) {
+            return max_delay;
+        }
+        return remaining * ns_per_tick;
     }
-    ctr_val = counter->mhpmcounter_val;
 
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
index 1369b7c4ded22fcb25d8dc491b305bb1370d4cbd..ec28f96899d70609aea6fcbeb9add7a085d47ca4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -279,14 +279,17 @@ static void riscv_cpu_exec_enter(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong pc = env->dpc;
 
-    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
-        return;
+    if (cpu->cfg.ext_sdext && env->debug_mode) {
+        target_ulong pc = env->dpc;
+
+        riscv_cpu_leave_debug_mode(env);
+        env->pc = pc;
     }
 
-    riscv_cpu_leave_debug_mode(env);
-    env->pc = pc;
+    if (cpu->pmu_timer_stalled) {
+        riscv_pmu_rebuild_timer(env);
+    }
 }
 #endif
 
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


