Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE13AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKE-0003jB-O3; Wed, 24 Jan 2024 05:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJq-0003Mq-HN
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:20 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJo-0003q3-5Y
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:18 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so549244766b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091434; x=1706696234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCdApdVb2tqf6HzKRfmudkQU18WR02XSp7D7zgQR15M=;
 b=kr5swZd+2nM1QAnTrCMMOZ5KARfyobJ4HPJY86G0Bq94ies0QJLgO76Jg8dSEwpMKv
 TENaYADgGJc1GYDnhTKGowl2T5kjATMMmOVxo/prSpTQJrnHG+L0W6wXxMeauOdS6weC
 FbvyeD+09sY9SghpqGQ9F+uMMyP1XqJ8eGMAlGcd7U6cONePOYpnecJqAKeaC/H/LuV+
 NOC77FA6jl9Glcfo0pM6n+iRUtIQb1Lm4ZjlOod6GusRAQJ5sygksWl67w/Y60cOvnCt
 8ntMbBP+09oMX3d/GXAACSkcrBzMi/hxRhKh+7ygkUuppq+gxUJUQkANTuAMOvjMJJnk
 3jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091434; x=1706696234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCdApdVb2tqf6HzKRfmudkQU18WR02XSp7D7zgQR15M=;
 b=Gk2HuTa+JYJ4v5KadNmG/3WMAsAY/pUnkaKch4FsCDfWXhX2xP8PhdRHMShvLcv8ev
 pz7BbLyxaphqx3HCsgMryvJQrdu8G5whfiJxXo6lz+swr4C3FaLbVCdhMQ3olNYO7FmP
 4Bks6Dt4qKAqBOI/fAveurrJNWUMpMtAKhnKW/dEdDSVVZJKL99zUT5ooGTmK8IvsQeD
 6DYs70eCsWmmlnISQDD/gmW8kFOxDTJLdOroBoh53Po82knkyAkcv7IeWDtUie0XIwzB
 Vqc/5DlxzP0/Ebio5iUjaBMDEjysn+wO8w7tTSApuPdVY6piD+0Lx1YIrvkl0tk8hKPK
 Uv2Q==
X-Gm-Message-State: AOJu0YwNYQ1iiCp1oLrsybRDa7bW5iLfivtIqSwCF7g6A2eijlCvydcs
 wGgaJHOFs5uCBjWhMG/4yiLakr4O30kJpd/p4tD+mCRWJQSfu9Iral12HZ8i90Y=
X-Google-Smtp-Source: AGHT+IHn1Xvl36cwiqj9hcYhEW0WZ34e4eNFzBSz1q8ioyEEXwnTprlQ8V5G5MMuYOQNErFAxI3qog==
X-Received: by 2002:a17:907:8b87:b0:a31:1092:69b2 with SMTP id
 tb7-20020a1709078b8700b00a31109269b2mr339392ejc.77.1706091433618; 
 Wed, 24 Jan 2024 02:17:13 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 w17-20020a17090652d100b00a28116285e0sm10969588ejn.165.2024.01.24.02.17.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] accel/tcg: Hoist CPUClass arg to functions with external
 linkage
Date: Wed, 24 Jan 2024 11:16:35 +0100
Message-ID: <20240124101639.30056-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hoist the CPUClass argument from most of these internal helpers:

 - check_for_breakpoints_slow
 - check_for_breakpoints()
 - cpu_tb_exec()
 - cpu_exec_enter()
 - cpu_exec_exit()
 - cpu_handle_halt()
 - cpu_handle_debug_exception()
 - cpu_handle_exception()
 - need_replay_interrupt()
 - cpu_handle_interrupt()
 - cpu_loop_exec_tb()
 - cpu_exec_loop()
 - cpu_exec_setjmp()

to the following ones with external linkage:

 - lookup_tb_ptr()
 - cpu_exec_step_atomic()
 - cpu_exec()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 82 ++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d61b285d5e..b10472cbc7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -324,8 +324,8 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
     }
 }
 
-static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
-                                       uint32_t *cflags)
+static bool check_for_breakpoints_slow(CPUClass *cc, CPUState *cpu,
+                                       vaddr pc, uint32_t *cflags)
 {
     CPUBreakpoint *bp;
     bool match_page = false;
@@ -357,7 +357,6 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
 #ifdef CONFIG_USER_ONLY
                 g_assert_not_reached();
 #else
-                CPUClass *cc = CPU_GET_CLASS(cpu);
                 assert(cc->tcg_ops->debug_check_breakpoint);
                 match_bp = cc->tcg_ops->debug_check_breakpoint(cpu);
 #endif
@@ -390,11 +389,11 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
     return false;
 }
 
-static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
-                                         uint32_t *cflags)
+static inline bool check_for_breakpoints(CPUClass *cc, CPUState *cpu,
+                                         vaddr pc, uint32_t *cflags)
 {
     return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
-        check_for_breakpoints_slow(cpu, pc, cflags);
+        check_for_breakpoints_slow(cc, cpu, pc, cflags);
 }
 
 /**
@@ -408,6 +407,7 @@ static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
 const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
     TranslationBlock *tb;
     vaddr pc;
     uint64_t cs_base;
@@ -416,7 +416,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
     cflags = curr_cflags(cpu);
-    if (check_for_breakpoints(cpu, pc, &cflags)) {
+    if (check_for_breakpoints(cc, cpu, pc, &cflags)) {
         cpu_loop_exit(cpu);
     }
 
@@ -443,7 +443,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
  * affect the impact of CFI in environment with high security requirements
  */
 static inline TranslationBlock * QEMU_DISABLE_CFI
-cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
+cpu_tb_exec(CPUClass *cc, CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 {
     CPUArchState *env = cpu_env(cpu);
     uintptr_t ret;
@@ -476,8 +476,6 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
          */
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
         if (cc->tcg_ops->synchronize_from_tb) {
             cc->tcg_ops->synchronize_from_tb(cpu, last_tb);
         } else {
@@ -509,19 +507,15 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 }
 
 
-static void cpu_exec_enter(CPUState *cpu)
+static void cpu_exec_enter(CPUClass *cc, CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
     if (cc->tcg_ops->cpu_exec_enter) {
         cc->tcg_ops->cpu_exec_enter(cpu);
     }
 }
 
-static void cpu_exec_exit(CPUState *cpu)
+static void cpu_exec_exit(CPUClass *cc, CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
     if (cc->tcg_ops->cpu_exec_exit) {
         cc->tcg_ops->cpu_exec_exit(cpu);
     }
@@ -566,6 +560,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
 
 void cpu_exec_step_atomic(CPUState *cpu)
 {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu_env(cpu);
     TranslationBlock *tb;
     vaddr pc;
@@ -600,11 +595,11 @@ void cpu_exec_step_atomic(CPUState *cpu)
             mmap_unlock();
         }
 
-        cpu_exec_enter(cpu);
+        cpu_exec_enter(cc, cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
-        cpu_tb_exec(cpu, tb, &tb_exit);
-        cpu_exec_exit(cpu);
+        cpu_tb_exec(cc, cpu, tb, &tb_exit);
+        cpu_exec_exit(cc, cpu);
     } else {
         cpu_exec_longjmp_cleanup(cpu);
     }
@@ -673,7 +668,7 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
     return;
 }
 
-static inline bool cpu_handle_halt(CPUState *cpu)
+static inline bool cpu_handle_halt(CPUClass *cc, CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
@@ -697,9 +692,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
     return false;
 }
 
-static inline void cpu_handle_debug_exception(CPUState *cpu)
+static inline void cpu_handle_debug_exception(CPUClass *cc, CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUWatchpoint *wp;
 
     if (!cpu->watchpoint_hit) {
@@ -713,7 +707,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
     }
 }
 
-static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
+static inline bool cpu_handle_exception(CPUClass *cc, CPUState *cpu, int *ret)
 {
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
@@ -730,7 +724,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         /* exit request from the cpu execution loop */
         *ret = cpu->exception_index;
         if (*ret == EXCP_DEBUG) {
-            cpu_handle_debug_exception(cpu);
+            cpu_handle_debug_exception(cc, cpu);
         }
         cpu->exception_index = -1;
         return true;
@@ -740,7 +734,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
            which will be handled outside the cpu execution
            loop */
 #if defined(TARGET_I386)
-        CPUClass *cc = CPU_GET_CLASS(cpu);
         cc->tcg_ops->fake_user_interrupt(cpu);
 #endif /* TARGET_I386 */
         *ret = cpu->exception_index;
@@ -748,7 +741,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         return true;
 #else
         if (replay_exception()) {
-            CPUClass *cc = CPU_GET_CLASS(cpu);
             bql_lock();
             cc->tcg_ops->do_interrupt(cpu);
             bql_unlock();
@@ -761,7 +753,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
                  * next instruction.
                  */
                 *ret = EXCP_DEBUG;
-                cpu_handle_debug_exception(cpu);
+                cpu_handle_debug_exception(cc, cpu);
                 return true;
             }
         } else if (!replay_has_interrupt()) {
@@ -781,7 +773,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  * "real" interrupt event later. It does not need to be recorded for
  * replay purposes.
  */
-static inline bool need_replay_interrupt(int interrupt_request)
+static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
 {
 #if defined(TARGET_I386)
     return !(interrupt_request & CPU_INTERRUPT_POLL);
@@ -802,7 +794,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
 }
 
-static inline bool cpu_handle_interrupt(CPUState *cpu,
+static inline bool cpu_handle_interrupt(CPUClass *cc, CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     /*
@@ -870,11 +862,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
-            CPUClass *cc = CPU_GET_CLASS(cpu);
-
             if (cc->tcg_ops->cpu_exec_interrupt &&
                 cc->tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
-                if (need_replay_interrupt(interrupt_request)) {
+                if (need_replay_interrupt(cc, interrupt_request)) {
                     replay_interrupt();
                 }
                 /*
@@ -918,14 +908,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     return false;
 }
 
-static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
+static inline void cpu_loop_exec_tb(CPUClass *cc, CPUState *cpu,
+                                    TranslationBlock *tb,
                                     vaddr pc, TranslationBlock **last_tb,
                                     int *tb_exit)
 {
     int32_t insns_left;
 
     trace_exec_tb(tb, pc);
-    tb = cpu_tb_exec(cpu, tb, tb_exit);
+    tb = cpu_tb_exec(cc, cpu, tb, tb_exit);
     if (*tb_exit != TB_EXIT_REQUESTED) {
         *last_tb = tb;
         return;
@@ -970,16 +961,16 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 /* main execution loop */
 
 static int __attribute__((noinline))
-cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
+cpu_exec_loop(CPUClass *cc, CPUState *cpu, SyncClocks *sc)
 {
     int ret;
 
     /* if an exception is pending, we execute it here */
-    while (!cpu_handle_exception(cpu, &ret)) {
+    while (!cpu_handle_exception(cc, cpu, &ret)) {
         TranslationBlock *last_tb = NULL;
         int tb_exit = 0;
 
-        while (!cpu_handle_interrupt(cpu, &last_tb)) {
+        while (!cpu_handle_interrupt(cc, cpu, &last_tb)) {
             TranslationBlock *tb;
             vaddr pc;
             uint64_t cs_base;
@@ -1001,7 +992,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 cpu->cflags_next_tb = -1;
             }
 
-            if (check_for_breakpoints(cpu, pc, &cflags)) {
+            if (check_for_breakpoints(cc, cpu, pc, &cflags)) {
                 break;
             }
 
@@ -1046,7 +1037,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 tb_add_jump(last_tb, tb_exit, tb);
             }
 
-            cpu_loop_exec_tb(cpu, tb, pc, &last_tb, &tb_exit);
+            cpu_loop_exec_tb(cc, cpu, tb, pc, &last_tb, &tb_exit);
 
             /* Try to align the host and virtual clocks
                if the guest is in advance */
@@ -1056,30 +1047,31 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
     return ret;
 }
 
-static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
+static int cpu_exec_setjmp(CPUClass *cc, CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
     if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
         cpu_exec_longjmp_cleanup(cpu);
     }
 
-    return cpu_exec_loop(cpu, sc);
+    return cpu_exec_loop(cc, cpu, sc);
 }
 
 int cpu_exec(CPUState *cpu)
 {
     int ret;
     SyncClocks sc = { 0 };
+    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     /* replay_interrupt may need current_cpu */
     current_cpu = cpu;
 
-    if (cpu_handle_halt(cpu)) {
+    if (cpu_handle_halt(cc, cpu)) {
         return EXCP_HALTED;
     }
 
     WITH_RCU_READ_LOCK_GUARD() {
-        cpu_exec_enter(cpu);
+        cpu_exec_enter(cc, cpu);
 
         /*
          * Calculate difference between guest clock and host clock.
@@ -1089,9 +1081,9 @@ int cpu_exec(CPUState *cpu)
          */
         init_delay_params(&sc, cpu);
 
-        ret = cpu_exec_setjmp(cpu, &sc);
+        ret = cpu_exec_setjmp(cc, cpu, &sc);
 
-        cpu_exec_exit(cpu);
+        cpu_exec_exit(cc, cpu);
     };
 
     return ret;
-- 
2.41.0


