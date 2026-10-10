Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3CCA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQDS-0002xO-El; Sat, 10 Oct 2026 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCq-0002gu-Vo; Sat, 10 Oct 2026 02:05:18 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCj-00040h-0Y; Sat, 10 Oct 2026 02:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612284; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=oKYNueLq0nmAFYNjjh2Q1JSMZ+y8OjPMmFl8Y5yNDvw=;
 b=L9Y++wz9UUm/EQ6NDORutLQUFDpCTH7CRtKFTI0m1M60tv6EBpSEjiKp4YLX1QuRawEISjayq6G2WlAhiik1lWzpXHKbK0qbchq525kkSNGodNIKYdckMz5ZESHXGE1gVVDvoWSPSYKT2Tom6iI2mR7VId87loCuxg8SWPmFHgI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGsT_1791612283; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGsT_1791612283 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:43 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:27 +0800
Subject: [PATCH v3 03/14] target/riscv: Use VM-elapsed sources for fixed
 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-3-712bf814a7be@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612280; l=9443;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=6qcWrGa29rYNBqkjg42zQbBEqxnjvJU8ka56+VMIJt4=;
 b=Zg3Obh1+mUHjKqs9Dc4JDNftyRdKc8NhEu2hp5imDDjQar0Q4m+IJvcvXLyatISud6W1q4j0b
 k8WZOBuYze2Cy9maHjsHPcEThTPcypBdxsaC0hcSYBzWkfrZO0ylAFL
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
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

Raw host ticks keep advancing while the VM is stopped. Use
cpus_get_elapsed_ticks() for cycles and non-icount instruction counting,
and retain icount_get_raw() for instructions under icount. Document that
cpu_get_ticks() returns its stored value while VM ticks are disabled.

Under icount, cycles are already virtual nanoseconds. Convert only raw
instruction counts when scheduling overflow, avoiding a second scaling
of cycle distances. Add a cycle-overflow regression with icount shift=3.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg00668.html
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 system/cpu-timers.c                         |  4 +-
 system/cpus.c                               |  6 +--
 target/riscv/tcg/csr.c                      |  8 +---
 target/riscv/tcg/pmu.c                      | 52 +++++++++++++++-----------
 target/riscv/tcg/pmu.h                      |  1 +
 tests/tcg/riscv64/sscofpmf-cycle-overflow.S | 58 +++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build        |  7 ++++
 7 files changed, 103 insertions(+), 33 deletions(-)

diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 9919b46230f1caf8be1a1b6ef00acd94678437ce..0415636aff3f774f0de61fdac3969f5b45ae6993 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -118,8 +118,8 @@ void cpu_enable_ticks(void)
 }
 
 /*
- * disable cpu_get_ticks() : the clock is stopped. You must not call
- * cpu_get_ticks() after that.
+ * Freeze VM ticks. While disabled, cpu_get_ticks() returns the stored tick
+ * value instead of sampling the advancing host counter.
  * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
  */
 void cpu_disable_ticks(void)
diff --git a/system/cpus.c b/system/cpus.c
index e11a5aab6a696962d94ad30ac38acd8867b1bf88..f61639ae78277fd90cbddb0b9f75b134e3cc1a17 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -237,9 +237,9 @@ void cpus_set_virtual_clock(int64_t new_time)
 }
 
 /*
- * return the time elapsed in VM between vm_start and vm_stop.  Unless
- * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
- * counter.
+ * Return VM-elapsed ticks. While VM ticks are disabled, passage of host time
+ * does not advance the returned value. Unless icount is active, the units are
+ * those of the host CPU cycle counter.
  */
 int64_t cpus_get_elapsed_ticks(void)
 {
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index d2f15cfef0e63eaf4ca96d193983d1cb3d272ecc..f2fe7700fdc64600eff1bb0aef28a0ca212d687c 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1330,13 +1330,7 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     }
 
     if (!cfg_val) {
-        if (icount_enabled()) {
-                curr_val = inst ? icount_get_raw() : icount_get();
-        } else {
-            curr_val = cpu_get_host_ticks();
-        }
-
-        return curr_val;
+        return riscv_pmu_read_fixed_source(env, inst);
     }
 
     /* Update counter before reading. */
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index f19f417e90e33a94d00007ef132ef4e154175b19..ea0ffe41258d4dbef9dc952655e6301c14ba1d23 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -24,8 +24,14 @@
 #include "pmu.h"
 #include "exec/icount.h"
 #include "system/device_tree.h"
+#include "system/cpu-timers.h"
 
-#define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
+/*
+ * cpu_get_ticks() does not expose the host tick frequency.  Use a 1 GHz
+ * approximation only when scheduling non-icount overflow checks; fixed
+ * counter values remain in host-tick units.
+ */
+#define RISCV_PMU_HOST_TICK_HZ_ASSUMED 1000000000
 
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
@@ -75,6 +81,19 @@ static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
             (cfg & MHPMEVENT_BIT_UINH));
 }
 
+/*
+ * VM-elapsed ticks stop advancing while VM ticks are disabled.  Under
+ * icount, instruction events retain raw instruction-count units.
+ */
+uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
+{
+    if (instret && icount_enabled()) {
+        return icount_get_raw();
+    }
+
+    return cpus_get_elapsed_ticks();
+}
+
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -96,11 +115,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
     uint64_t *counter_arr;
     uint64_t delta;
 
-    if (icount_enabled()) {
-        current_icount = icount_get_raw();
-    } else {
-        current_icount = cpu_get_host_ticks();
-    }
+    current_icount = riscv_pmu_read_fixed_source(env, true);
 
     if (env->virt_enabled) {
         g_assert(env->priv <= PRV_S);
@@ -137,11 +152,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     uint64_t *counter_arr;
     uint64_t delta;
 
-    if (icount_enabled()) {
-        current_ticks = icount_get();
-    } else {
-        current_ticks = cpu_get_host_ticks();
-    }
+    current_ticks = riscv_pmu_read_fixed_source(env, false);
 
     if (env->virt_enabled) {
         g_assert(env->priv <= PRV_S);
@@ -286,17 +297,15 @@ static bool riscv_pmu_event_supported(uint32_t event_idx)
     }
 }
 
-static int64_t pmu_icount_ticks_to_ns(int64_t value)
+static int64_t pmu_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
+                               int64_t value)
 {
-    int64_t ret = 0;
-
-    if (icount_enabled()) {
-        ret = icount_to_ns(value);
-    } else {
-        ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
+    if (icount_enabled() &&
+        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        return icount_to_ns(value);
     }
 
-    return ret;
+    return (NANOSECONDS_PER_SECOND / RISCV_PMU_HOST_TICK_HZ_ASSUMED) * value;
 }
 
 void riscv_pmu_rebuild_event_map(CPURISCVState *env)
@@ -448,8 +457,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
-        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
+        overflow_ns = pmu_ticks_to_ns(env, ctr_idx,
+                                      (int64_t)overflow_delta);
+        overflow_left = pmu_ticks_to_ns(env, ctr_idx, overflow_left);
     } else {
         return -1;
     }
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 910091690290cac9f77855f479bb9d90b2762efe..339a4b3ac09c4a91cddd9250824284203b16b4fa 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -26,6 +26,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
                                   uint32_t target_ctr);
+uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 void riscv_pmu_rebuild_event_map(CPURISCVState *env);
diff --git a/tests/tcg/riscv64/sscofpmf-cycle-overflow.S b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
new file mode 100644
index 0000000000000000000000000000000000000000..846d4651c4ee8f06df83bed85512ab9794552c28
--- /dev/null
+++ b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/* UINT64_MAX - 4095 leaves 4096 cycle increments until overflow. */
+	csrw	mhpmevent3, zero
+	li	t0, -4096
+	csrw	mhpmcounter3, t0
+	li	t0, 1
+	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
+	csrr	t1, mcycle
+
+1:
+	csrr	t0, mhpmevent3
+	beqz	t0, fail
+	li	t2, 1
+	slli	t2, t2, 63
+	and	t0, t0, t2
+	bnez	t0, pass
+
+	/*
+	 * Allow 16384 cycles for OF to become visible. With shift=3, scaling
+	 * the 4096-cycle distance twice would delay it to about 32768 cycles.
+	 */
+	csrr	t0, mcycle
+	sub	t0, t0, t1
+	li	t2, 16384
+	bltu	t0, t2, 1b
+
+fail:
+	li	a0, 1
+	j	exit
+
+pass:
+	li	a0, 0
+
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
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
index b798b8ea38e8151f7a832ae3d582cc3a2ab1e98e..3108e6595d4e91e6a941e006206992a41ddbe436 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -68,6 +68,13 @@ tests += {
   },
 }
 
+tests += {
+  'sscofpmf-cycle-overflow.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=3', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


