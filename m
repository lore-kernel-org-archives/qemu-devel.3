Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA70C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cpj-00032u-0p; Sun, 28 Apr 2024 18:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpX-000206-Nj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:07 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpU-0005m7-6A
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571ba432477so3938538a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342622; x=1714947422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpu8mPAjAI54fYmowTzJbxJYPBAzCYm8H+IKimQD/FY=;
 b=KctTi4IBZASaVwv0A9QM64WDZHYKgIdPdKWpYl5yAKHYeuyPKYwS6arsZQoBatPFMS
 4699Mk1iQkMy0BKUU8x4jg4sGN757uZ9sAOhVq7DnFFfnQRWF+zkf88GQpZo4imRGox7
 dE35Gj4ySrb6yYJ66Wv9h162ZGSXpVb9y99VjZifPOMEHX0Od30sovTh/EBnp+xjNIB0
 nfsmFaozkdwza3tihgeJ7Ov70xEWVIxwPXBbTOvnAHK8HgCkQEeUgjwT90b5GsOuB+nc
 qchAX7OBtbm6JPdnXEUiZZLuX5rMM1NZ+Zh2Y7SAZv58vbp8mKKXpE/RCWEXAG6VMnlo
 chLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342622; x=1714947422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpu8mPAjAI54fYmowTzJbxJYPBAzCYm8H+IKimQD/FY=;
 b=S317ynJ+Cl2cVqqhBAWhe+SLDv4qAsHCxBb8uoA1g4CsqrU1Eem5NRRcP5VtyrWtem
 gdb8g0B/r6FVvnPlIQhazSQWn8dn0f1Kfcbslr0Uv9k7fqN7TLlcjiOMi+1ukASbLWnJ
 WBoFBfwkpw2fo9euDUvEm3CQ4uDbUJW6Ki2rHYlRRCHCD7JdSTe75dZgPFYiP37+Jhy7
 VAkv6xE2fh58I3qV6cQ6Zh9nmYEgNqeTTJTsHzBTjULd31HXAV5bNFkwiG1gQ3Uzmyva
 ThlqZsbWX57EE5yllrF/axKjA4XT5/j1v59U/4MQySRSBpbPUruABRfRk18dHVZpf/gQ
 Z9pg==
X-Gm-Message-State: AOJu0YyuZvZTiScpKrHHUxhbdd/wZLVaKP1RpHvoHGu0eq0BdiYGkMOK
 7nkWH1mg5xRTxF+IENvCIU2IVhXFk9YVkMWuRwy/tAOEyuo3m8BB1ScHtacOqKQgjai/alPhEHN
 x
X-Google-Smtp-Source: AGHT+IGw3NV3Erx97+aWo950a3mzIGqxVZuARemBgxw4J3uJxziY2v8IVpWmsQZ9aLz0OyrSjlZIsw==
X-Received: by 2002:a05:6402:1cb8:b0:572:5310:4ae1 with SMTP id
 cz24-20020a0564021cb800b0057253104ae1mr4462942edb.0.1714342622584; 
 Sun, 28 Apr 2024 15:17:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 o12-20020aa7dd4c000000b005704419f56csm12398431edw.86.2024.04.28.15.17.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:17:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/24] accel/tcg: Move icount fields from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:50 +0200
Message-ID: <20240428221450.26460-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Both @icount_budget and @icount_extra fields are specific
to TCG accelerator, move them to its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h           |  4 ++++
 include/hw/core/cpu.h            |  3 ---
 accel/tcg/cpu-exec.c             | 14 +++++++-------
 accel/tcg/icount-common.c        |  7 ++++---
 accel/tcg/tcg-accel-ops-icount.c | 14 +++++++-------
 accel/tcg/tcg-accel-ops.c        |  1 +
 hw/core/cpu-common.c             |  1 -
 7 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 1cdca0e0d4..9bb8afac57 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -12,6 +12,7 @@
 /**
  * AccelCPUState:
  * @cflags: Pre-computed cflags for this cpu.
+ * @icount_extra: Instructions until next timer event.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  */
 struct AccelCPUState {
@@ -24,6 +25,9 @@ struct AccelCPUState {
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
 #else
+    int64_t icount_budget;
+    int64_t icount_extra;
+
     uintptr_t mem_io_pc;
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6bafa090a..bdcb09b464 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -411,7 +411,6 @@ struct qemu_work_item;
  * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
- * @icount_extra: Instructions until next timer event.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
@@ -471,8 +470,6 @@ struct CPUState {
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
-    int64_t icount_budget;
-    int64_t icount_extra;
     uint64_t random_seed;
 
     QemuMutex work_mutex;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1f618f6c2e..7c21542e52 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -74,7 +74,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+    cpu_icount = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -125,7 +125,7 @@ static void init_delay_params(SyncClocks *sc, CPUState *cpu)
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
     sc->last_cpu_icount
-        = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+        = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -718,7 +718,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
@@ -789,7 +789,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
-    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+    return cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0;
 #endif
 }
 
@@ -941,9 +941,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-    int32_t insns_left = MIN(0xffff, cpu->icount_budget);
+    int32_t insns_left = MIN(0xffff, cpu->accel->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
-    cpu->icount_extra = cpu->icount_budget - insns_left;
+    cpu->accel->icount_extra = cpu->accel->icount_budget - insns_left;
 
     /*
      * If the next tb has more instructions than we have left to
@@ -952,7 +952,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
      */
     if (insns_left > 0 && insns_left < tb->icount)  {
         assert(insns_left <= CF_COUNT_MASK);
-        assert(cpu->icount_extra == 0);
+        assert(cpu->accel->icount_extra == 0);
         cpu->accel->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
     }
 #endif
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..ff503f8e96 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -38,6 +38,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
+#include "accel/tcg/vcpu-state.h"
 
 /*
  * ICOUNT: Instruction Counter
@@ -71,8 +72,8 @@ static void icount_enable_adaptive(void)
  */
 static int64_t icount_get_executed(CPUState *cpu)
 {
-    return (cpu->icount_budget -
-            (cpu->neg.icount_decr.u16.low + cpu->icount_extra));
+    return (cpu->accel->icount_budget -
+            (cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra));
 }
 
 /*
@@ -83,7 +84,7 @@ static int64_t icount_get_executed(CPUState *cpu)
 static void icount_update_locked(CPUState *cpu)
 {
     int64_t executed = icount_get_executed(cpu);
-    cpu->icount_budget -= executed;
+    cpu->accel->icount_budget -= executed;
 
     qatomic_set_i64(&timers_state.qemu_icount,
                     timers_state.qemu_icount + executed);
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 9e1ae66f65..75073ec23f 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -112,16 +112,16 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
      * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
      */
     g_assert(cpu->neg.icount_decr.u16.low == 0);
-    g_assert(cpu->icount_extra == 0);
+    g_assert(cpu->accel->icount_extra == 0);
 
     replay_mutex_lock();
 
-    cpu->icount_budget = MIN(icount_get_limit(), cpu_budget);
-    insns_left = MIN(0xffff, cpu->icount_budget);
+    cpu->accel->icount_budget = MIN(icount_get_limit(), cpu_budget);
+    insns_left = MIN(0xffff, cpu->accel->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
-    cpu->icount_extra = cpu->icount_budget - insns_left;
+    cpu->accel->icount_extra = cpu->accel->icount_budget - insns_left;
 
-    if (cpu->icount_budget == 0) {
+    if (cpu->accel->icount_budget == 0) {
         /*
          * We're called without the BQL, so must take it while
          * we're calling timer handlers.
@@ -139,8 +139,8 @@ void icount_process_data(CPUState *cpu)
 
     /* Reset the counters */
     cpu->neg.icount_decr.u16.low = 0;
-    cpu->icount_extra = 0;
-    cpu->icount_budget = 0;
+    cpu->accel->icount_extra = 0;
+    cpu->accel->icount_budget = 0;
 
     replay_account_executed_instructions();
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 5429e2d219..86bc82b891 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -89,6 +89,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
+    cpu->accel->icount_extra = 0;
     cpu->accel->mem_io_pc = 0;
     cpu->accel->cflags_next_tb = -1;
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 684422991c..6dc94b1eaf 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -117,7 +117,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
-    cpu->icount_extra = 0;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
 
-- 
2.41.0


