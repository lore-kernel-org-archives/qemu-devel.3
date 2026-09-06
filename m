Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB26C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Fsb-0002yf-VM; Sun, 06 Sep 2026 12:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsX-0002tD-Eb; Sun, 06 Sep 2026 12:38:01 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsQ-00033H-0a; Sun, 06 Sep 2026 12:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712651; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=l1HhZwtGaf6CKvlWb/N294WTBOhOXZUvbgD0XTLVO/8=;
 b=ypQja9aekLylbzB4DC72JNKWCvGmb3fnysbhCYi+7dWjn1TKZUBKosFG444qUIo67iFoAwj/sxVKnkGCfLCceJpj1xgznA6fgSHJ7F0W6b/IjrVrCOxzJLR+yJNcwTmuPg+U/gnb6zXO2iJEGTh2wXAdk3Er/p8UC4bMhIG5tVY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIHy_1788712650; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIHy_1788712650 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:31 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:18 +0800
Subject: [PATCH 02/14] target/riscv: Support multiple counters per PMU
 event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-2-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=15770;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=ia4Y6fi2tkOaG+wUEBGAjReRt5gBQ1dxvJxUkRHuOEM=;
 b=G+H/5yFzBT1I5OKvprSegi4o59w7qE7RvFrep5qUbryfRl+mLaJ0pVM0K1ZNeBlzMYlSU4yIu
 OQigqC5BaHPCRO4EbplOAYKGDPqgaE4gPoaRWcda/q63kcj9vDRG/tB
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
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

The PMU FDT lists multiple eligible counters for each event, but the
event map stores only one counter per event. A second selector for the
same event is accepted by the CSR but ignored by the map, so its counter
does not count or overflow. Changing a selector between nonzero events
also leaves the old mapping.

Store a counter mask per event and rebuild the map from mhpmevent CSRs
after selector writes and migration. Update event delivery, fixed-source
accounting and overflow handling to cover every mapped counter.

Test selector replacement and multiple counters selecting instructions
or DTLB misses.

Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/machine.c                |   6 ++
 target/riscv/tcg/csr.c                |   2 +-
 target/riscv/tcg/pmu.c                | 182 +++++++++++++++++-----------------
 target/riscv/tcg/pmu.h                |   3 +-
 tests/tcg/riscv64/sscofpmf-overflow.S |  80 ++++++++++++++-
 5 files changed, 176 insertions(+), 97 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffcefb32710ed0f2af4d4f4595e122d1d9..b0ff2fc7f2ac10fab1f2ff845a953649091e1f43 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -24,6 +24,9 @@
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
+#ifdef CONFIG_TCG
+#include "target/riscv/tcg/pmu.h"
+#endif
 #ifdef CONFIG_KVM
 #include "kvm/kvm_riscv.h"
 #endif
@@ -311,6 +314,9 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
     CPURISCVState *env = &cpu->env;
 
     env->xl = cpu_recompute_xl(env);
+#ifdef CONFIG_TCG
+    riscv_pmu_rebuild_event_map(env);
+#endif
     return 0;
 }
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 52664a26f5a97a5dc8ff37abf99b4d10927fb120..d15a2d096cb6e13cd123ff9ae82ee7c643c2a961 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1241,7 +1241,7 @@ static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
     }
 
     env->mhpmevent_val[ctr_idx] = value;
-    riscv_pmu_update_event_map(env, value, ctr_idx);
+    riscv_pmu_rebuild_event_map(env);
 
     if (enabled &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 1a4658319b11a9a8a0edef18fc8a5abd0027eb31..f19f417e90e33a94d00007ef132ef4e154175b19 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -49,6 +49,17 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
+static uint32_t riscv_pmu_event_counter_mask(RISCVCPU *cpu,
+                                             uint32_t event_idx)
+{
+    if (!cpu->pmu_event_ctr_map) {
+        return 0;
+    }
+
+    return GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
+                                                GUINT_TO_POINTER(event_idx)));
+}
+
 static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
 {
     bool virt_on = env->virt_enabled;
@@ -180,41 +191,41 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
 
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
-    uint32_t ctr_idx;
+    uint32_t ctr_idx, ctr_mask;
     CPURISCVState *env = &cpu->env;
     uint64_t max_val = UINT64_MAX;
     PMUCTRState *counter;
-    gpointer value;
 
     if (!cpu->cfg.pmu_mask) {
         return 0;
     }
-    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                                GUINT_TO_POINTER(event_idx));
-    if (!value) {
-        return -1;
-    }
 
-    ctr_idx = GPOINTER_TO_UINT(value);
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
+    ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
+    if (!ctr_mask) {
         return -1;
     }
 
-    if (riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
-        return 0;
-    }
+    while (ctr_mask) {
+        ctr_idx = ctz32(ctr_mask);
+        ctr_mask &= ~BIT(ctr_idx);
 
-    /* Handle the overflow scenario */
-    counter = &env->pmu_ctrs[ctr_idx];
-    if (counter->mhpmcounter_val == max_val) {
-        counter->mhpmcounter_val = 0;
-        /* Generate interrupt only if OF bit is clear */
-        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
+        if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
+            riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
+            continue;
+        }
+
+        /* Handle the overflow scenario */
+        counter = &env->pmu_ctrs[ctr_idx];
+        if (counter->mhpmcounter_val == max_val) {
+            counter->mhpmcounter_val = 0;
+            /* Generate interrupt only if OF bit is clear */
+            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
+            }
+        } else {
+            counter->mhpmcounter_val++;
         }
-    } else {
-        counter->mhpmcounter_val++;
     }
 
     return 0;
@@ -224,8 +235,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr)
 {
     RISCVCPU *cpu;
-    uint32_t event_idx;
-    uint32_t ctr_idx;
+    uint32_t ctr_mask;
 
     /* Fixed instret counter */
     if (target_ctr == 2) {
@@ -237,21 +247,15 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
         return false;
     }
 
-    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-    if (!ctr_idx) {
-        return false;
-    }
-
-    return target_ctr == ctr_idx ? true : false;
+    ctr_mask = riscv_pmu_event_counter_mask(cpu,
+                                            RISCV_PMU_EVENT_HW_INSTRUCTIONS);
+    return (ctr_mask & BIT(target_ctr)) != 0;
 }
 
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
 {
     RISCVCPU *cpu;
-    uint32_t event_idx;
-    uint32_t ctr_idx;
+    uint32_t ctr_mask;
 
     /* Fixed mcycle counter */
     if (target_ctr == 0) {
@@ -263,22 +267,23 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
         return false;
     }
 
-    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-
-    /* Counter zero is not used for event_ctr_map */
-    if (!ctr_idx) {
-        return false;
-    }
-
-    return (target_ctr == ctr_idx) ? true : false;
+    ctr_mask = riscv_pmu_event_counter_mask(cpu,
+                                            RISCV_PMU_EVENT_HW_CPU_CYCLES);
+    return (ctr_mask & BIT(target_ctr)) != 0;
 }
 
-static gboolean pmu_remove_event_map(gpointer key, gpointer value,
-                                     gpointer udata)
+static bool riscv_pmu_event_supported(uint32_t event_idx)
 {
-    return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
+    switch (event_idx) {
+    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
+    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
+    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
+    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
+    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
+        return true;
+    default:
+        return false;
+    }
 }
 
 static int64_t pmu_icount_ticks_to_ns(int64_t value)
@@ -294,48 +299,32 @@ static int64_t pmu_icount_ticks_to_ns(int64_t value)
     return ret;
 }
 
-int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
-                               uint32_t ctr_idx)
+void riscv_pmu_rebuild_event_map(CPURISCVState *env)
 {
-    uint32_t event_idx;
+    uint32_t ctr_idx, ctr_mask, event_idx;
     RISCVCPU *cpu = env_archcpu(env);
 
-    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
-        return -1;
+    if (!cpu->pmu_event_ctr_map) {
+        return;
     }
 
-    /*
-     * Expected mhpmevent value is zero for reset case. Remove the current
-     * mapping.
-     */
-    if (!(value & MHPMEVENT_IDX_MASK)) {
-        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
-                                    pmu_remove_event_map,
-                                    GUINT_TO_POINTER(ctr_idx));
-        return 0;
-    }
+    g_hash_table_remove_all(cpu->pmu_event_ctr_map);
+    for (ctr_idx = 3; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        if (!riscv_pmu_counter_valid(cpu, ctr_idx)) {
+            continue;
+        }
 
-    event_idx = value & MHPMEVENT_IDX_MASK;
-    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                            GUINT_TO_POINTER(event_idx))) {
-        return 0;
-    }
+        event_idx = env->mhpmevent_val[ctr_idx] & MHPMEVENT_IDX_MASK;
+        if (!event_idx || !riscv_pmu_event_supported(event_idx)) {
+            continue;
+        }
 
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
+        ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
+        ctr_mask |= BIT(ctr_idx);
+        g_hash_table_insert(cpu->pmu_event_ctr_map,
+                            GUINT_TO_POINTER(event_idx),
+                            GUINT_TO_POINTER(ctr_mask));
     }
-    g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
-                        GUINT_TO_POINTER(ctr_idx));
-
-    return 0;
 }
 
 static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
@@ -348,23 +337,14 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
     }
 }
 
-static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum riscv_pmu_event_idx evt_idx)
+static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
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
@@ -408,6 +388,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 }
 
+static void pmu_timer_trigger_irq(RISCVCPU *cpu,
+                                  enum riscv_pmu_event_idx evt_idx)
+{
+    uint32_t ctr_idx;
+    uint32_t ctr_mask;
+
+    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
+        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
+        return;
+    }
+
+    ctr_mask = riscv_pmu_event_counter_mask(cpu, evt_idx);
+
+    while (ctr_mask) {
+        ctr_idx = ctz32(ctr_mask);
+        ctr_mask &= ~BIT(ctr_idx);
+        pmu_timer_trigger_irq_counter(cpu, ctr_idx);
+    }
+}
+
 /* Timer callback for instret and cycle counter overflow */
 void riscv_pmu_timer_cb(void *priv)
 {
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 2429c01b776693ebb324ed63fee1feb56c821c21..910091690290cac9f77855f479bb9d90b2762efe 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -28,8 +28,7 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
                                   uint32_t target_ctr);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
-int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
-                               uint32_t ctr_idx);
+void riscv_pmu_rebuild_event_map(CPURISCVState *env);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
index 587c7d3ec430aac984621dfb818f141088be7b23..b91d9dee825f9c9f547785225882b3fc6a87e3da 100644
--- a/tests/tcg/riscv64/sscofpmf-overflow.S
+++ b/tests/tcg/riscv64/sscofpmf-overflow.S
@@ -6,14 +6,18 @@
 	.text
 	.global _start
 _start:
-	/* Program hpmcounter3 while no event is selected. */
+	/* Program counters 3 and 4 while no event is selected. */
 	csrw	0x323, zero		/* mhpmevent3 */
 	li	t0, -256
 	csrw	0xb03, t0		/* mhpmcounter3 */
+	csrw	0x324, zero		/* mhpmevent4 */
+	li	t0, -512
+	csrw	0xb04, t0		/* mhpmcounter4 */
 
-	/* Start counting retired instructions with overflow enabled. */
+	/* Count the same event in both counters with overflow enabled. */
 	li	t0, 2
 	csrw	0x323, t0
+	csrw	0x324, t0
 
 	/* Cross the 64-bit unsigned overflow boundary. */
 	.rept	1024
@@ -26,6 +30,10 @@ _start:
 	srli	t1, t0, 63
 	xori	t1, t1, 1
 	or	t4, t4, t1
+	csrr	t0, 0x324
+	srli	t1, t0, 63
+	xori	t1, t1, 1
+	or	t4, t4, t1
 
 	csrr	t0, mip
 	li	t1, 1 << 13
@@ -34,12 +42,68 @@ _start:
 	xori	t0, t0, 1
 	or	t4, t4, t0
 
-	/* The counter wraps and continues counting after overflow. */
+	/* Both counters wrap and continue counting after overflow. */
 	csrr	t0, 0xb03
 	li	t1, -256
 	sltu	t0, t0, t1
 	xori	t0, t0, 1
 	or	t4, t4, t0
+	csrr	t0, 0xb04
+	li	t1, -512
+	sltu	t0, t0, t1
+	xori	t0, t0, 1
+	or	t4, t4, t0
+
+	/* After selecting write misses, read misses must not increment HPM3. */
+	csrw	0x323, zero		/* mhpmevent3 */
+	csrw	0xb03, zero		/* mhpmcounter3 */
+	li	t0, 0x10019		/* DTLB read miss */
+	csrw	0x323, t0
+	li	t0, 0x1001b		/* DTLB write miss */
+	csrw	0x323, t0
+	sfence.vma
+	lla	t2, stale_probe
+	lw	t3, 0(t2)
+	csrr	t0, 0xb03
+	or	t4, t4, t0
+
+	/* Both counters must count a DTLB read miss. */
+	csrw	0x323, zero		/* mhpmevent3 */
+	csrw	0x324, zero		/* mhpmevent4 */
+	csrw	0xb03, zero		/* mhpmcounter3 */
+	csrw	0xb04, zero		/* mhpmcounter4 */
+	li	t0, 0x10019		/* DTLB read miss */
+	csrw	0x323, t0
+	csrw	0x324, t0
+	sfence.vma
+	lla	t2, tlb_probe
+	lw	t3, 0(t2)
+	csrr	t0, 0xb03
+	csrr	t1, 0xb04
+	sltu	t2, zero, t0
+	xori	t2, t2, 1
+	or	t4, t4, t2
+	sltu	t2, zero, t1
+	xori	t2, t2, 1
+	or	t4, t4, t2
+	xor	t0, t0, t1
+	sltu	t0, zero, t0
+	or	t4, t4, t0
+
+	/* Disabling HPM3 must leave HPM4 counting the same event. */
+	csrr	t5, 0xb03
+	csrr	t6, 0xb04
+	csrw	0x323, zero		/* mhpmevent3 */
+	sfence.vma
+	lla	t2, tlb_probe2
+	lw	t3, 0(t2)
+	csrr	t0, 0xb03
+	xor	t0, t0, t5
+	or	t4, t4, t0
+	csrr	t0, 0xb04
+	sltu	t0, t6, t0
+	xori	t0, t0, 1
+	or	t4, t4, t0
 
 	lla	a1, semiargs
 	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
@@ -55,6 +119,16 @@ _start:
 	j	.
 
 	.data
+	/* Give each DTLB probe a separate page. */
+	.balign	4096
+stale_probe:
+	.word	0
+	.balign	4096
+tlb_probe:
+	.word	0
+	.balign	4096
+tlb_probe2:
+	.word	0
 	.balign	16
 semiargs:
 	.space	16

-- 
2.43.0


