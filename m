Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53005CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRn1-0005Aq-RA; Mon, 27 Oct 2025 14:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRmf-0004x8-0P
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:33 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm9-0003yh-VY
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nGeu+85Hi5+EJq5vgIYTNqPfkBtn0ki7YBdluzj+x+I=; b=gfNRZmPGu5N07P8
 q001eqJpdIrWYnNCm79zfqMGfU+Wg6uNaoBnsOtkmU5iXjLJXJkwNNUKRV+iRliLNIW/QxwElQ/1+
 H9cegrXlrDyn8kjRyhPpyLZvG7UJtGhAi83yV+c7f5/BqEU1d2VRiT9PBGWAfvfeEnWtZaw7JK2CX
 7g=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 08/33] target/riscv: Combine mhpmcounter and mhpmcounterh
Date: Mon, 27 Oct 2025 19:18:05 +0100
Message-ID: <20251027181831.27016-9-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to version 20250508 of the privileged specification,
mhpmconter is a 64-bit register and mhpmcounterh refers to the top
32 bits of this register when XLEN == 32.  No real advantage is
gained by keeping them separate, and combining allows for slight
simplification.

Note, the cpu/pmu VMSTATE version is bumped breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  10 ++--
 target/riscv/csr.c     |  76 ++++++++++++++--------------
 target/riscv/machine.c |  10 ++--
 target/riscv/pmu.c     | 111 +++++++++++------------------------------
 4 files changed, 73 insertions(+), 134 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d41105ca5..2e0b86e68d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -196,13 +196,9 @@ FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
-    target_ulong mhpmcounter_val;
-    /* Current value of a counter in RV32 */
-    target_ulong mhpmcounterh_val;
-    /* Snapshot values of counter */
-    target_ulong mhpmcounter_prev;
-    /* Snapshort value of a counter in RV32 */
-    target_ulong mhpmcounterh_prev;
+    uint64_t mhpmcounter_val;
+    /* Snapshot value of a counter */
+    uint64_t mhpmcounter_prev;
     /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
     target_ulong irq_overflow_left;
 } PMUCTRState;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b28839d121..65b6469395 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1300,24 +1300,27 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = val;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int deposit_size = rv32 ? 32 : 64;
+    uint64_t ctr;
+
+    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                         0, deposit_size, val);
 
-    counter->mhpmcounter_val = val;
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                ctr_idx, false);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, false);
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              0, deposit_size, ctr);
         if (ctr_idx > 2) {
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                mhpmctr_val = mhpmctr_val |
-                              ((uint64_t)counter->mhpmcounterh_val << 32);
-            }
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
+            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
      } else {
         /* Other counters can keep incrementing from the given value */
-        counter->mhpmcounter_prev = val;
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              0, deposit_size, val);
+
     }
 
     return RISCV_EXCP_NONE;
@@ -1327,21 +1330,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = counter->mhpmcounter_val;
-    uint64_t mhpmctrh_val = val;
+    uint64_t ctrh;
 
-    counter->mhpmcounterh_val = val;
-    mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
+    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                         32, 32, val);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                 ctr_idx, true);
+        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true);
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              32, 32, ctrh);
         if (ctr_idx > 2) {
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
+            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
     } else {
-        counter->mhpmcounterh_prev = val;
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              32, 32, val);
     }
 
     return RISCV_EXCP_NONE;
@@ -1364,13 +1368,19 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                         bool upper_half, uint32_t ctr_idx)
+                                  bool upper_half, uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
-                                         counter->mhpmcounter_prev;
-    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
-                                        counter->mhpmcounter_val;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int start = upper_half ? 32 : 0;
+    int length = rv32 ? 32 : 64;
+    uint64_t ctr_prev, ctr_val;
+
+    /* Ensure upper_half is only set for XLEN == 32 */
+    g_assert(rv32 || !upper_half);
+
+    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
+    ctr_val  = extract64(counter->mhpmcounter_val, start, length);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -2994,6 +3004,7 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
     target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
     uint64_t mhpmctr_val, prev_count, curr_count;
+    uint64_t ctrh;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
     env->mcountinhibit = val & present_ctrs;
@@ -3012,17 +3023,13 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
             counter->mhpmcounter_prev =
                 riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
             if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_prev =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+                ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+                counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                                      32, 32, ctrh);
             }
 
             if (cidx > 2) {
-                mhpmctr_val = counter->mhpmcounter_val;
-                if (riscv_cpu_mxl(env) == MXL_RV32) {
-                    mhpmctr_val = mhpmctr_val |
-                            ((uint64_t)counter->mhpmcounterh_val << 32);
-                }
-                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
+                riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
             }
         } else {
             curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
@@ -3034,18 +3041,11 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
                     riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
 
                 curr_count = curr_count | (tmp << 32);
-                mhpmctr_val = mhpmctr_val |
-                    ((uint64_t)counter->mhpmcounterh_val << 32);
-                prev_count = prev_count |
-                    ((uint64_t)counter->mhpmcounterh_prev << 32);
             }
 
             /* Adjust the counter for later reads. */
             mhpmctr_val = curr_count - prev_count + mhpmctr_val;
             counter->mhpmcounter_val = mhpmctr_val;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_val = mhpmctr_val >> 32;
-            }
         }
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6146124229..09c032a879 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -335,14 +335,12 @@ static bool pmu_needed(void *opaque)
 
 static const VMStateDescription vmstate_pmu_ctr_state = {
     .name = "cpu/pmu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_val, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_prev, PMUCTRState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 273822e921..708f2ec7aa 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -101,82 +101,6 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
-static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    target_ulong max_val = UINT32_MAX;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool virt_on = env->virt_enabled;
-
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
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        if (counter->mhpmcounterh_val == max_val) {
-            counter->mhpmcounter_val = 0;
-            counter->mhpmcounterh_val = 0;
-            /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-            }
-        } else {
-            counter->mhpmcounterh_val++;
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-
-    return 0;
-}
-
-static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t max_val = UINT64_MAX;
-    bool virt_on = env->virt_enabled;
-
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
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        counter->mhpmcounter_val = 0;
-        /* Generate interrupt only if OF bit is clear */
-        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-    return 0;
-}
-
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -275,8 +199,10 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
-    int ret;
     CPURISCVState *env = &cpu->env;
+    uint64_t max_val = UINT64_MAX;
+    bool virt_on = env->virt_enabled;
+    PMUCTRState *counter;
     gpointer value;
 
     if (!cpu->cfg.pmu_mask) {
@@ -293,13 +219,34 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         return -1;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        ret = riscv_pmu_incr_ctr_rv32(cpu, ctr_idx);
+    /* Privilege mode filtering */
+    if ((env->priv == PRV_M &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
+        (env->priv == PRV_S && virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
+        (env->priv == PRV_U && virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
+        (env->priv == PRV_S && !virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
+        (env->priv == PRV_U && !virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
+        return 0;
+    }
+
+    /* Handle the overflow scenario */
+    counter = &env->pmu_ctrs[ctr_idx];
+    if (counter->mhpmcounter_val == max_val) {
+        counter->mhpmcounter_val = 0;
+        /* Generate interrupt only if OF bit is clear */
+        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
+        }
     } else {
-        ret = riscv_pmu_incr_ctr_rv64(cpu, ctr_idx);
+        counter->mhpmcounter_val++;
     }
 
-    return ret;
+    return 0;
 }
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
@@ -470,8 +417,6 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
         curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
-        ctr_val = ctr_val |
-                ((uint64_t)counter->mhpmcounterh_val << 32);
     }
 
     /*
-- 
2.51.0


