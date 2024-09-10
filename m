Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53A2EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4yI-0005Jc-TB; Tue, 10 Sep 2024 13:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so4yH-0005Cp-2A; Tue, 10 Sep 2024 13:48:09 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so4yE-0005QK-B3; Tue, 10 Sep 2024 13:48:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3A3E6C0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725990483;
 bh=Hy9dad28MCnezxE6voSGiv7yABTY/G3VHYyOGnUiCUw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=W5j+/3f+vCrfJpzmR1yIjjvN3rpZzJ3vXZxtnC51Aic4nNYmRxPSn3WQKAea2Rd6h
 +ILVUNj2N1bHuhANQb6ON82arV9kPCe38N+jDtZaIbvglYcsqq+Z9sXxwR5XaZzBlH
 ao7MEA/dZpBh6uvhZu9gd2wHoCITgxKn8qImcw65oeeEqOys+7QQ8+zcgzrBUp01gf
 rHJ9jWhUwsDQTfe4AiuGEBZO1DMKvX7pnwdWVsX01/4bpo/CuTpa+13MMKuvPhhXFA
 gfh7vvyhPIIMIKutV/eS+guubu6taFwpWFkcfudMLPTult7qVDRMif3iiswN/gKV6J
 4KeaKxkTgIIKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725990483;
 bh=Hy9dad28MCnezxE6voSGiv7yABTY/G3VHYyOGnUiCUw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=wg/jeYv6xyWZG3LdIxHrULunuxxRy25yc5QTp5Y/bkGmJLXoQVUmF7i0keSzbBnIW
 e2qRLBQsVqQV0LMlxyGJLtKPD9VnxiZ1cELN/YqsityFaOGiqAKSDgTGg7euHYw+cv
 T2vdKnqeSdJ1l4CK+0NjdrOcKSgrgRlTvh6XrMRabmEKbXwOjx0zOoITQ8W7j3+I+K
 Ci4/seT1nwxq92ZTL3ltdOQbCFlBzy560FKnRM0FtJWTXZEEKYovnoqCK7h9hd7Qrs
 jbgdBGyYSP/BT6eW18+SyP3vSBCQeZtQVZbPjEHDT+AE4IsWYvbvsm/ogUfg7vKQ83
 u0xxIXPo71Csw==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [RFC PATCH 1/2] target/riscv: Add support for machine specific pmu's
 events
Date: Tue, 10 Sep 2024 20:47:46 +0300
Message-ID: <20240910174747.148141-2-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910174747.148141-1-alexei.filippov@syntacore.com>
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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
 target/riscv/csr.c |  93 ++++++++++++++++++++----------
 target/riscv/pmu.c | 138 ++++++++++++++++++++++-----------------------
 target/riscv/pmu.h |  19 +++++--
 4 files changed, 157 insertions(+), 102 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..3fca02a670 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -415,6 +415,13 @@ struct CPUArchState {
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
@@ -496,6 +503,8 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    /* Mapping of counters to events */
+    GHashTable *pmu_ctr_event_map;
     const GPtrArray *decoders;
 };
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..ed46314a1c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1009,7 +1009,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
                                                          int counter_idx,
                                                          bool upper_half)
 {
-    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
+    int inst = riscv_pmu_get_event_by_ctr(env, counter_idx) - 1;
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
     target_ulong result = 0;
@@ -1078,22 +1078,27 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
+    int event_idx;
 
     counter->mhpmcounter_val = val;
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+        event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (!RISCV_PMU_EVENT_IS_FIXED(event_idx) && env->pmu_ctr_write) {
+            env->pmu_ctr_write(counter, event_idx, val, false);
+        } else {
+            counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                 ctr_idx, false);
-        if (ctr_idx > 2) {
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
 
@@ -1107,15 +1112,21 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
+    int event_idx;
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                 ctr_idx, true);
-        if (ctr_idx > 2) {
+        event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (!RISCV_PMU_EVENT_IS_FIXED(event_idx) && env->pmu_ctr_write) {
+            env->pmu_ctr_write(counter, event_idx, val, true);
+        } else {
+            counter->mhpmcounterh_prev =
+                riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true);
+        }
+        if (RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
     } else {
@@ -1133,6 +1144,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          counter->mhpmcounter_prev;
     target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
                                         counter->mhpmcounter_val;
+    int event_idx;
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -1147,10 +1159,15 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      * The kernel computes the perf delta by subtracting the current value from
      * the value it initialized previously (ctr_val).
      */
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+    event_idx = riscv_pmu_get_event_by_ctr(env, ctr_idx);
+    if (event_idx != RISCV_PMU_EVENT_NOT_PRESENTED) {
+        if (!RISCV_PMU_EVENT_IS_FIXED(event_idx) && env->pmu_ctr_read) {
+            *val = env->pmu_ctr_read(counter, event_idx,
+                                     upper_half) - ctr_prev + ctr_val;
+        } else {
+            *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
                                                     ctr_prev + ctr_val;
+        }
     } else {
         *val = ctr_val;
     }
@@ -2182,25 +2199,33 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     /* WARL register - disable unavailable counters; TM bit is always 0 */
     env->mcountinhibit = val & present_ctrs;
 
-    /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
+        int event_idx = riscv_pmu_get_event_by_ctr(env, cidx);
         if (!(updated_ctrs & BIT(cidx)) ||
-            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
-            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
+            event_idx == RISCV_PMU_EVENT_NOT_PRESENTED) {
             continue;
         }
 
         counter = &env->pmu_ctrs[cidx];
 
         if (!get_field(env->mcountinhibit, BIT(cidx))) {
-            counter->mhpmcounter_prev =
-                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_prev =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+            if (!RISCV_PMU_EVENT_IS_FIXED(event_idx) && env->pmu_ctr_read) {
+                counter->mhpmcounter_prev =
+                    env->pmu_ctr_read(counter, event_idx, false);
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    counter->mhpmcounterh_prev =
+                        env->pmu_ctr_read(counter, event_idx, true);
+                }
+            } else {
+                counter->mhpmcounter_prev =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    counter->mhpmcounterh_prev =
+                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+                }
             }
 
-            if (cidx > 2) {
+            if (RISCV_PMU_CTR_IS_HPM(cidx)) {
                 mhpmctr_val = counter->mhpmcounter_val;
                 if (riscv_cpu_mxl(env) == MXL_RV32) {
                     mhpmctr_val = mhpmctr_val |
@@ -2209,15 +2234,25 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
                 riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
             }
         } else {
-            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+
+            if (!RISCV_PMU_EVENT_IS_FIXED(event_idx) && env->pmu_ctr_read) {
+                curr_count = env->pmu_ctr_read(counter, event_idx, false);
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    curr_count = curr_count |
+                        ((uint64_t)env->pmu_ctr_read(counter, event_idx, true) << 32);
+                }
+            } else {
+                curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    curr_count = curr_count |
+                        ((uint64_t)
+                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) << 32);
+                }
+            }
 
             mhpmctr_val = counter->mhpmcounter_val;
             prev_count = counter->mhpmcounter_prev;
             if (riscv_cpu_mxl(env) == MXL_RV32) {
-                uint64_t tmp =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-
-                curr_count = curr_count | (tmp << 32);
                 mhpmctr_val = mhpmctr_val |
                     ((uint64_t)counter->mhpmcounterh_val << 32);
                 prev_count = prev_count |
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index e05ab067d2..76edcfcbb6 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -89,7 +89,7 @@ static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
-static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
+bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     CPURISCVState *env = &cpu->env;
 
@@ -302,59 +302,30 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
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
-
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
     if (target_ctr == 0) {
-        return true;
+        return RISCV_PMU_EVENT_HW_CPU_CYCLES;
+    } else if (target_ctr == 1) {
+        return RISCV_PMU_EVENT_HW_INSTRUCTIONS;
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
@@ -363,6 +334,12 @@ static gboolean pmu_remove_event_map(gpointer key, gpointer value,
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
@@ -381,8 +358,11 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
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
 
@@ -394,6 +374,9 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));
+        g_hash_table_foreach_remove(cpu->pmu_ctr_event_map,
+                                    pmu_remove_ctr_map,
+                                    GUINT_TO_POINTER(ctr_idx));
         return 0;
     }
 
@@ -403,19 +386,26 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
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
@@ -458,22 +448,14 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
 }
 
 static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum riscv_pmu_event_idx evt_idx)
+                                  uint32_t ctr_idx)
 {
-    uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
     int64_t irq_trigger_at;
     uint64_t curr_ctr_val, curr_ctrh_val;
     uint64_t ctr_val;
 
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
@@ -519,14 +501,24 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 }
 
-/* Timer callback for instret and cycle counter overflow */
+static void riscv_pmu_timer_trigger_irq(gpointer ctr, gpointer event_idx,
+                                            gpointer opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    pmu_timer_trigger_irq(cpu, GPOINTER_TO_UINT(ctr));
+}
+
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
@@ -535,6 +527,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
     int64_t overflow_ns, overflow_left = 0;
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    uint32_t event_idx;
 
     /* No need to setup a timer if LCOFI is disabled when OF is set */
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
@@ -557,8 +550,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
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
@@ -594,7 +588,13 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 
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
index 3853d0e262..e29dbc9ed5 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -22,10 +22,20 @@
 #include "cpu.h"
 #include "qapi/error.h"
 
-bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
-                                        uint32_t target_ctr);
-bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
-                                  uint32_t target_ctr);
+#define RISCV_PMU_EVENT_NOT_PRESENTED -1
+
+#define RISCV_PMU_CTR_IS_HPM(x) (x > 2)
+#define RISCV_PMU_EVENT_IS_FIXED(x) ({              \
+    bool ret = false;                               \
+    if ((x) == RISCV_PMU_EVENT_HW_CPU_CYCLES ||     \
+        (x) == RISCV_PMU_EVENT_HW_INSTRUCTIONS) {   \
+        ret = true;                                 \
+    }                                               \
+    ret;                                            \
+})
+
+int riscv_pmu_get_event_by_ctr(CPURISCVState *env,
+                               uint32_t target_ctr);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
@@ -38,5 +48,6 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx);
+bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */
-- 
2.34.1


