Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E600EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7Mb-0000Bu-4B; Tue, 25 Jun 2024 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sM7MY-0000B7-SH; Tue, 25 Jun 2024 10:41:38 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sM7MW-0000qz-20; Tue, 25 Jun 2024 10:41:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com CADDEC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719326485;
 bh=2gl8cvlNjg5deM4FjBtfADGUAw7RbFntY1yRiRsLYQE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=clwg6sFnYUMmDhSAIxef7vc4DqtwNJTvZMBF0F1iFgj1Gom3R/WEswQs14T04j16u
 Wn7SIAZD/ScXZCuk0AfQyZ7XSAj4/Qg0B2B7tQ3rOvvFtTOWXLzKiBwE4HgAPkus5J
 87E4rCOeMbENErS/27ZGMxThI//1ABD0GyfojnyKv0IIBauQw5wKdcoTh7CnZrE/d5
 fnvg962c23/c5/b5OWzbJ/qdID3bBbpmy6X+1fewzKMnegZ5vj1B37LaN2/JRtPx/h
 pGIbmPGwZPpwjf38Re2f5EU9+W4rOQboT2nJ9dUfwzg4NwUkCBoUv9JdmI69Mxnolv
 f4FPq2HXkxmcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719326485;
 bh=2gl8cvlNjg5deM4FjBtfADGUAw7RbFntY1yRiRsLYQE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=PKWpNveJ0JOJ5NTTi37w4CCRIRmRUpxI64F0+vLTnV8TKd821kU1de00G1LDBMptQ
 7t8kdth0okqeVa3kRQMlCBXEph+o2Mc5inNHQYLBxu1CLr4mYGP3t7VKchzjxGAKjR
 HQGWKLSE7CXyJHlBwUYKoticQ0waLH5X+y07vP3K0SSb6R7ct7vZbkZmrU6quUe0ED
 B4GKyEzoKmLchVb5VdiZk0xC5LgqHIxDneEQX45Y0RjTw5iLSsHo4ER8xRdSk1plVx
 VsV6chDFCHF8bHtBx1tLFYnvMtk9O/ohcvWZWqvYXj2JmaTa0AfLAf/wMBwFUcLNiA
 a29BUS+bxn6GA==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH] target/riscv: Add support for machine specific pmu's events
Date: Tue, 25 Jun 2024 17:41:18 +0300
Message-ID: <20240625144118.32194-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Was added call backs for machine specific pmu events.
Simplify monitor functions by adding new hash table, which going to map
counter number and event index.
Was added read/write callbacks which going to simplify support for events,
which expected to have different behavior.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
---
 target/riscv/cpu.h |   9 +++
 target/riscv/csr.c |  43 +++++++++-----
 target/riscv/pmu.c | 139 ++++++++++++++++++++++-----------------------
 target/riscv/pmu.h |  11 ++--
 4 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a137b0f5a1..12542f413b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -368,6 +368,13 @@ struct CPUArchState {
     uint64_t (*rdtime_fn)(void *);
     void *rdtime_fn_arg;
 
+    /*machine specific pmu callback */
+    void (*pmu_ctr_write)(PMUCTRState *counter, uint32_t event_idx,
+                          target_ulong val, bool high_half);
+    target_ulong (*pmu_ctr_read)(PMUCTRState *counter, uint32_t event_idx,
+                                 bool high_half);
+    bool (*pmu_vendor_support)(uint32_t event_idx);
+
     /* machine specific AIA ireg read-modify-write callback */
 #define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
     ((((__xlen) & 0xff) << 24) | \
@@ -454,6 +461,8 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    /* Mapping of counters to events */
+    GHashTable *pmu_ctr_event_map;
 };
 
 /**
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c47056ec33..21bb5bfdc4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -862,20 +862,25 @@ static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
     int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
+    int event_idx;
 
     counter->mhpmcounter_val = val;
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounter_prev = get_ticks(false);
-        if (ctr_idx > 2) {
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+
+    if (event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx) && env->pmu_ctr_write) {
+            env->pmu_ctr_write(counter, event_idx, val, false);
+        } else {
+            counter->mhpmcounter_prev = get_ticks(false);
+        }
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
                 mhpmctr_val = mhpmctr_val |
                               ((uint64_t)counter->mhpmcounterh_val << 32);
             }
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
-     } else {
-        /* Other counters can keep incrementing from the given value */
+    } else {
         counter->mhpmcounter_prev = val;
     }
 
@@ -888,13 +893,19 @@ static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
+    int event_idx;
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounterh_prev = get_ticks(true);
-        if (ctr_idx > 2) {
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+
+    if (event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx) && env->pmu_ctr_write) {
+            env->pmu_ctr_write(counter, event_idx, val, true);
+        } else {
+            counter->mhpmcounterh_prev = get_ticks(true);
+        }
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
     } else {
@@ -912,6 +923,7 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          counter->mhpmcounter_prev;
     target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
                                         counter->mhpmcounter_val;
+    int event_idx;
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -932,9 +944,14 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      * The kernel computes the perf delta by subtracting the current value from
      * the value it initialized previously (ctr_val).
      */
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+    if (event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx) && env->pmu_ctr_read) {
+            *val = env->pmu_ctr_read(counter, event_idx,
+                                     upper_half);
+        } else {
+            *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+        }
     } else {
         *val = ctr_val;
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0e7d58b8a5..c3b6b20337 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -88,7 +88,7 @@ static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
-static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
+bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     CPURISCVState *env = &cpu->env;
 
@@ -207,59 +207,28 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
     return ret;
 }
 
-bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
-                                        uint32_t target_ctr)
+int riscv_pmu_get_event_by_ctr(CPURISCVState *env,
+                               uint32_t target_ctr)
 {
     RISCVCPU *cpu;
     uint32_t event_idx;
-    uint32_t ctr_idx;
-
-    /* Fixed instret counter */
-    if (target_ctr == 2) {
-        return true;
-    }
-
-    cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
-    }
-
-    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-    if (!ctr_idx) {
-        return false;
-    }
 
-    return target_ctr == ctr_idx ? true : false;
-}
-
-bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
-{
-    RISCVCPU *cpu;
-    uint32_t event_idx;
-    uint32_t ctr_idx;
-
-    /* Fixed mcycle counter */
-    if (target_ctr == 0) {
-        return true;
+    if (target_ctr < 3) {
+        return target_ctr;
     }
 
     cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
+    if (!cpu->pmu_ctr_event_map || !cpu->pmu_event_ctr_map) {
+        return RISCV_PMU_EVENT_NOT_PRESENTED;
     }
 
-    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-
-    /* Counter zero is not used for event_ctr_map */
-    if (!ctr_idx) {
-        return false;
+    event_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_ctr_event_map,
+                                                     GUINT_TO_POINTER(target_ctr)));
+    if (!event_idx) {
+        return RISCV_PMU_EVENT_NOT_PRESENTED;
     }
 
-    return (target_ctr == ctr_idx) ? true : false;
+    return event_idx;
 }
 
 static gboolean pmu_remove_event_map(gpointer key, gpointer value,
@@ -268,6 +237,12 @@ static gboolean pmu_remove_event_map(gpointer key, gpointer value,
     return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
 }
 
+static gboolean pmu_remove_ctr_map(gpointer key, gpointer value,
+                                   gpointer udata)
+{
+    return (GPOINTER_TO_UINT(key) == GPOINTER_TO_UINT(udata)) ? true : false;
+}
+
 static int64_t pmu_icount_ticks_to_ns(int64_t value)
 {
     int64_t ret = 0;
@@ -286,8 +261,11 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
 {
     uint32_t event_idx;
     RISCVCPU *cpu = env_archcpu(env);
+    bool machine_specific = false;
 
-    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
+    if (!riscv_pmu_counter_valid(cpu, ctr_idx) ||
+        !cpu->pmu_event_ctr_map ||
+        !cpu->pmu_ctr_event_map) {
         return -1;
     }
 
@@ -299,6 +277,9 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));
+        g_hash_table_foreach_remove(cpu->pmu_ctr_event_map,
+                                    pmu_remove_ctr_map,
+                                    GUINT_TO_POINTER(ctr_idx));
         return 0;
     }
 
@@ -308,40 +289,39 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         return 0;
     }
 
-    switch (event_idx) {
-    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
-    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
-    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
-    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
-    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
-        break;
-    default:
-        /* We don't support any raw events right now */
-        return -1;
+    if (RISCV_PMU_CTR_IS_HPM(ctr_idx) && env->pmu_vendor_support) {
+        machine_specific = env->pmu_vendor_support(event_idx);
+    }
+
+    if (!machine_specific) {
+        switch (event_idx) {
+        case RISCV_PMU_EVENT_HW_CPU_CYCLES:
+        case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
+        case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
+        case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
+        case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
+            break;
+        default:
+            return -1;
+        }
     }
     g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
                         GUINT_TO_POINTER(ctr_idx));
+    g_hash_table_insert(cpu->pmu_ctr_event_map, GUINT_TO_POINTER(ctr_idx),
+                        GUINT_TO_POINTER(event_idx));
 
     return 0;
 }
 
 static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum riscv_pmu_event_idx evt_idx)
+                                  uint32_t ctr_idx)
 {
-    uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
     target_ulong *mhpmevent_val;
     uint64_t of_bit_mask;
     int64_t irq_trigger_at;
 
-    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
-        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
-        return;
-    }
-
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(evt_idx)));
     if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return;
     }
@@ -349,7 +329,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
         of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
+    } else {
         mhpmevent_val = &env->mhpmevent_val[ctr_idx];
         of_bit_mask = MHPMEVENT_BIT_OF;
     }
@@ -372,14 +352,25 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 }
 
+static void riscv_pmu_timer_trigger_irq(gpointer ctr, gpointer event_idx,
+                                            gpointer opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    pmu_timer_trigger_irq(cpu, GPOINTER_TO_UINT(ctr));
+}
+
 /* Timer callback for instret and cycle counter overflow */
 void riscv_pmu_timer_cb(void *priv)
 {
     RISCVCPU *cpu = priv;
 
-    /* Timer event was triggered only for these events */
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
+    if (!cpu->pmu_ctr_event_map || !cpu->pmu_event_ctr_map) {
+        return;
+    }
+    g_hash_table_foreach(cpu->pmu_ctr_event_map,
+                         riscv_pmu_timer_trigger_irq,
+                         cpu);
 }
 
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
@@ -388,6 +379,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
     int64_t overflow_ns, overflow_left = 0;
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    uint32_t event_idx;
 
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf) {
         return -1;
@@ -408,8 +400,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
         overflow_left = overflow_delta - INT64_MAX;
     }
 
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+
+    if (event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
         overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
         overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
     } else {
@@ -443,7 +436,13 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 
     cpu->pmu_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
     if (!cpu->pmu_event_ctr_map) {
-        error_setg(errp, "Unable to allocate PMU event hash table");
+        error_setg(errp, "Unable to allocate first PMU event hash table");
+        return;
+    }
+
+    cpu->pmu_ctr_event_map = g_hash_table_new(g_direct_hash, g_direct_equal);
+    if (!cpu->pmu_ctr_event_map) {
+        error_setg(errp, "Unable to allocate second PMU event hash table");
         return;
     }
 
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 505fc850d3..f80e757055 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -19,10 +19,12 @@
 #include "cpu.h"
 #include "qapi/error.h"
 
-bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
-                                        uint32_t target_ctr);
-bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
-                                  uint32_t target_ctr);
+#define RISCV_PMU_EVENT_NOT_PRESENTED -1
+
+#define RISCV_PMU_CTR_IS_HPM(x) (x > 2)
+
+int riscv_pmu_get_event_by_ctr(CPURISCVState *env,
+                               uint32_t target_ctr);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
@@ -31,3 +33,4 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx);
-- 
2.34.1


