Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84676C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Th3-0008WA-2f; Wed, 23 Sep 2026 16:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgD-0008Bw-I5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:06 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgA-00051y-Tj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:01 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so713638a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195697; x=1790800497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jLp6ahCU93BTd2BLkEfZzfIJIRR9NWTXSUP87yd1ubw=;
 b=Qhr6ZtNJaUiaWhaQrjhlaFfHyrAMRsnKJuKXuOU2B7I1l/8gO06b5QuO8+xAxMO3Uw
 ciF1nj7xnJbBzeF/9c19l8E/wMZtqZkFfvWuZZJ5SMoGVTNY3ot4bzSTAstxk0I8p/Z5
 JEWj6/y4GJ0iPl+wDLyvVc8ArpAWwFULBXeiTiwkqE5I8bQgP8yOKOMYLGQuX5cS8Ji4
 nMemFt4nFyj1D/ck8Vy2iRQPFUFJFvsvPcSUH2Nak9kFNJux/ZhG2p261b7LIT2eULGs
 eT/S/t0lxd9orIyAP8xzToQIpA8nzhNMzcYNTOL32uz5tZy1k4AUoyc7IjewO8TrcvrJ
 HbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195697; x=1790800497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jLp6ahCU93BTd2BLkEfZzfIJIRR9NWTXSUP87yd1ubw=;
 b=1z4UMc4P2Lg/WXCc5WNOcQUqmJQCZNRwJhrTQJY5ZFWJmwYbZwa+gWaY9oZL3a1NBX
 2CbIzRechJBWtaivzd+n+83JtUBO4mv0NoxMWLL9F+oKZ1tc4bUyrGZcrLMzRpQCgnJ4
 N2pJnoy+5vLne8gKcYePgzgAlJNu2HtKOLcHwfZH51FAyio3YAlDng7FNaOT6hCgoaQh
 P0BV27QYSqqWLXdMFtAKLpwUsdLqCGB88mzclfWMskic7cWljS7u/P4Jz4UEfxsdb96h
 6/eW5Osc45SL1rCStPoTlNoC8G4/c9HmPdKKaWJZtmXDwy4OYajH/goGRIayLevkhSxI
 Tk7A==
X-Gm-Message-State: AFuF++mmM5QvhclRlGG10KMeoy4guEId+p7WC9rmLvqagmphSdVDsuZB
 q2pwbvCrE6idjwM90FSzv6Q4n09AVQtfc8pKI2fTrsmt8zGbkZr7t9/sA66xSDE1bd4mW0Ba5P9
 oCRcL
X-Gm-Gg: AYBFou0lXAb8HFEPz+N9D77wteIRr9gAwie6pJevqk+1t7pZU80MPIfLPEgsLFVqwRV
 TkrS82opB2CYLilHV8/EyAi2L6m/oiPv0f4NtcbfDX+idRwX/YVkpHANPhPTM652kVSlEVJ9f/o
 d4T9I0octgAxdR8Yhj9Tq/JHG1YWXfVU7Qxz6lGEQswvMUum4XC8cz+yfN4G5nzKMJLaBPRLzLl
 sW53O1Ap5mlJNoMoPuOFZ8ytXQBxf7dJNsrcAbv6A1XuNFRe1NnjTUoLw/509n7oxb+R2qr9Lvt
 fn8hzZWCsznKAmyIn7vSskF6H6TjDeH9FLl3SaPjriXEa14bLdC9vmbiBbVTea/ZgSpvbAjrpZN
 niKaKXyZERUpQxrNxDQ0bUMZQ7rHrUaf736Lp1wm9Atc5TPPYaRNyDQDUW49hyaqhgZGOvVLPUp
 0XiAbe2h/o+pKnIoCWcCIWj4X5N95OO7C777EeXXArsO8n5J5RHs1xoBL2cl32rgkxXnVmM2cQP
 bDzFg6CPhixiUThxBCl1ON5LXRLJw==
X-Received: by 2002:a05:6a20:d704:b0:3dd:a196:30a9 with SMTP id
 adf61e73a8af0-3de0e9bafa6mr268650637.89.1790195697259; 
 Wed, 23 Sep 2026 13:34:57 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 16/16] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
Date: Wed, 23 Sep 2026 13:34:41 -0700
Message-ID: <20260923203441.31276-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
and from the cpu_exec() loop. It recomputes the same value every time:

    uint32_t cflags = cpu->tcg_cflags;
    if (unlikely(cpu_single_stepping(cpu))) { ... }
    else if (qatomic_read(&one_insn_per_tb)) { ... }
    else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }

That is three loads and three branches on the hottest path in the
interpreter, for state that changes only when gdb enables single-step,
when one-insn-per-tb is toggled, or when the log mask changes.

None of the three has to be sampled at dispatch time. Fold each into
CPUState::tcg_cflags where it changes and curr_cflags() becomes a single
load of a field that TB lookup has to read anyway.

The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cflags()
can recompute them in place without disturbing the rest, and conversely
tcg_cflags_set() ORs in its bits without disturbing them.

There are three places to call it:

  - tcg_exec_realizefn(), so that a CPU created after the command line has
    been parsed starts out with the right value. This covers user-only,
    where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
    copies tcg_cflags wholesale, so a cloned thread inherits it.

  - cpu_single_step(), which changes one CPU.  gdb is the only caller that
    matters; in system mode it runs with the vCPUs stopped, and in user mode
    gdb_continue_partial() can reach a thread that is still running, because
    gdb_handlesig() stops only the thread that trapped. That is exactly the
    plain cross-thread store to another CPU's CPUState that
    cpu->singlestep_flags already was, read back by that CPU through
    cpu_single_stepping() in curr_cflags(). This patch changes which field
    carries it, not who writes it or how.

  - hmp_one_insn_per_tb() and hmp_log(), which change every CPU while the
    vCPUs are running, so the update is queued with async_run_on_cpu() and
    each CPU writes its own cflags from its own thread. The command line
    spellings of those two settings need nothing: they are parsed before
    any CPU is realized, so tcg_exec_realizefn() picks them up.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
build configured with --enable-lto:

    before: 1,646,994,254,249 instructions
    after:  1,562,204,796,597 instructions   -5.15%

That workload issues 8.4 billion dispatches, so the per-call saving is
small but the aggregate is not. The emulated compiler produces
byte-identical output before and after.

Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against a
run-to-run spread larger than that. The removed work is a few predictable
loads and branches that the host executes largely in parallel with the
surrounding dispatch, so this patch is worth taking for the instruction
count and for what it enables, not for a time saving that can be measured
on its own.

v4: Update the cflags from the HMP handlers for 'log' and 'one-insn-per-tb'
    rather than from qemu_set_log_internal() and the accelerator property
    setter. Those are the paths that reach a running vCPU, and the monitor
    is the only thing that does. Suggested by Richard Henderson.

v4: Queue the per-CPU update with async_run_on_cpu() rather than
    async_safe_run_on_cpu(). Halting the other vCPUs buys nothing: the
    queued work already runs on the owning CPU's own thread. Suggested by
    Alex Bennee, who also asked whether there are cross-vCPU updates of
    tcg_cflags at all. With this change the monitor path has none: the
    only remaining writer from another thread is cpu_single_step(), above,
    which is neither new nor made worse here.

v4: Move the stub to accel/stubs/, which is where the other accelerator
    stubs live.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-2-mattst88@gmail.com>
---
 accel/tcg/internal-common.h | 11 +++++++++--
 include/system/tcg.h        | 12 ++++++++++++
 accel/tcg/cpu-exec-common.c | 37 ++++++++++++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c        |  3 +++
 accel/tcg/tcg-accel-ops.c   |  1 +
 cpu-target.c                |  5 ++++-
 monitor/hmp-cmds.c          |  7 +++++++
 system/runstate-hmp-cmds.c  | 18 ++++++++++++------
 8 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 9e7be2d78df..853d1b51eeb 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -69,8 +69,15 @@ void tlb_destroy(CPUState *cpu);
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
+/*
+ * Current cflags for hashing/comparison.  Everything that feeds into the
+ * value is folded into CPUState::tcg_cflags when it changes, by
+ * tcg_update_cflags(), so that TB dispatch only has to load it.
+ */
+static inline uint32_t curr_cflags(CPUState *cpu)
+{
+    return cpu->tcg_cflags;
+}
 
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 7622dcea302..2c2dbc753b3 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,6 +17,18 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/*
+ * Recompute the parts of CPUState::tcg_cflags that TB dispatch consumes but
+ * tcg_cflags_set() does not provide: gdb single-step, one-insn-per-tb and
+ * the CPU_LOG_TB_NOCHAIN log flag.  Call whenever one of those changes.
+ *
+ * tcg_update_cflags() updates one CPU and must be called from that CPU's
+ * thread, or with it stopped.  tcg_update_all_cflags() updates every CPU
+ * and is safe to call from the monitor while the vCPUs run.
+ */
+void tcg_update_cflags(CPUState *cpu);
+void tcg_update_all_cflags(void);
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 44e84344f3b..68077c8fd9d 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -21,11 +21,19 @@
 #include "exec/log.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
+#include "qemu/main-loop.h"
 #include "accel/tcg/cpu-loop.h"
 #include "internal-common.h"
 
 bool tcg_allowed;
 
+/*
+ * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, because
+ * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
+ */
+#define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
+                     CF_SINGLE_STEP)
+
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 {
     return cpu->tcg_cflags & flags;
@@ -33,12 +41,13 @@ bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 
 void tcg_cflags_set(CPUState *cpu, uint32_t flags)
 {
+    assert((flags & CF_DERIVED) == 0);
     cpu->tcg_cflags |= flags;
 }
 
-uint32_t curr_cflags(CPUState *cpu)
+void tcg_update_cflags(CPUState *cpu)
 {
-    uint32_t cflags = cpu->tcg_cflags;
+    uint32_t cflags = cpu->tcg_cflags & ~CF_DERIVED;
 
     /*
      * Record gdb single-step.  We should be exiting the TB by raising
@@ -55,7 +64,29 @@ uint32_t curr_cflags(CPUState *cpu)
         cflags |= CF_NO_GOTO_TB;
     }
 
-    return cflags;
+    cpu->tcg_cflags = cflags;
+}
+
+static void tcg_update_cflags_work(CPUState *cpu, run_on_cpu_data data)
+{
+    tcg_update_cflags(cpu);
+}
+
+void tcg_update_all_cflags(void)
+{
+    CPUState *cpu;
+
+    g_assert(bql_locked());
+
+    /*
+     * one-insn-per-tb and -d nochain can both be changed from the monitor
+     * while the vCPUs are running.  Queue the update onto each CPU rather
+     * than writing tcg_cflags from here, so that the field is only ever
+     * written by the CPU that owns it.
+     */
+    CPU_FOREACH(cpu) {
+        async_run_on_cpu(cpu, tcg_update_cflags_work, RUN_ON_CPU_NULL);
+    }
 }
 
 /* exit the current TB, but without causing any exception to be raised */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 46b723cb734..5226cfb7650 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1071,6 +1071,9 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
+    /* Pick up one-insn-per-tb and -d nochain from the command line. */
+    tcg_update_cflags(cpu);
+
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9c3d2214162..61e0051b53b 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -222,6 +222,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     ops->insert_gdbstub_breakpoint = tcg_insert_gdbstub_breakpoint;
     ops->remove_gdbstub_breakpoint = tcg_remove_gdbstub_breakpoint;
     ops->remove_all_gdbstub_breakpoints = tcg_remove_all_gdbstub_breakpoints;
+    ops->update_guest_debug = tcg_update_cflags;
 }
 
 static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/cpu-target.c b/cpu-target.c
index 4783845c9bf..9bd1605e831 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -24,6 +24,7 @@
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
@@ -35,7 +36,9 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
                                           cpu->singlestep_flags, flags);
         cpu->singlestep_flags = flags;
 
-#if !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_USER_ONLY
+        tcg_update_cflags(cpu);
+#else
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
             ops->update_guest_debug(cpu);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 91701ddf331..9b1b94f8ea9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -40,6 +40,7 @@
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
+#include "system/tcg.h"
 #include "disas/disas.h"
 
 /* Please update hmp-commands.hx when adding or changing commands */
@@ -340,6 +341,12 @@ void hmp_log(MonitorHMP *hmp, const QDict *qdict)
 
     if (!qemu_set_log(mask, &err)) {
         error_report_err(err);
+        return;
+    }
+
+    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
+    if (tcg_enabled()) {
+        tcg_update_all_cflags();
     }
 }
 
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index ad70b53f8ab..eb34d14d062 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -22,6 +22,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qobject/qdict.h"
 #include "qemu/accel.h"
+#include "system/tcg.h"
 
 void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
 {
@@ -43,16 +44,17 @@ void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
 {
-    const char *option = qdict_get_try_str(qdict, "option");
-    AccelState *accel = current_accel();
+    const char *option;
+    AccelState *accel;
     bool newval;
 
-    if (!object_property_find(OBJECT(accel), "one-insn-per-tb")) {
-        monitor_hmp_printf(hmp,
-                           "This accelerator does not support setting one-insn-per-tb\n");
+    if (!tcg_enabled()) {
+        monitor_hmp_printf(hmp, "This accelerator does not support "
+                           "setting one-insn-per-tb\n");
         return;
     }
 
+    option = qdict_get_try_str(qdict, "option");
     if (!option || !strcmp(option, "on")) {
         newval = true;
     } else if (!strcmp(option, "off")) {
@@ -61,9 +63,13 @@ void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "unexpected option %s\n", option);
         return;
     }
-    /* If the property exists then setting it can never fail */
+
+    accel = current_accel();
     object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                              newval, &error_abort);
+
+    /* one-insn-per-tb feeds into the per-CPU cflags. */
+    tcg_update_all_cflags();
 }
 
 void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
-- 
2.53.0


