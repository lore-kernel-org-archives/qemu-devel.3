Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB7C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUajV-000307-ID; Mon, 29 Jan 2024 18:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeE-0006yO-HI
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeC-00005Q-Gu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:38 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59a1896b45eso1149595eaf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569354; x=1707174154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7BY3FC/8lb12NjJs4/taRcBSMiYCFRNyNU57iKW6Ebg=;
 b=ZSPB/XlROGKHclBdMiV9WZmy/BzSp409OvFUsbK7VlEU6yndZ27o9WzuUmq6F217UM
 jXZeukLLVKrnwv291ftUWwKb0pM8KWJ2TC8ior9Dwg9l3nEqTzVElsrnNqxHq9TKKLGM
 CA8+bs30O0MuSdCfx7TY1tKxY6aDrCk9dx937GHcf+T7n9XLySJJuQ0Bot+sf4e4reuA
 eTdyCTTwRdv+YbEOxa6pE3tVTBPaK6OGlCRFphSrS66qJYnrteD5eJYpxt755HyGTwpa
 dW6hxOqDfslQd5G0SwBGCSE6G4kovFGY8oznWX7mp5RlR+wYA5nIaw1e8EGpF/DJ1AdU
 2Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569354; x=1707174154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BY3FC/8lb12NjJs4/taRcBSMiYCFRNyNU57iKW6Ebg=;
 b=n/l7lVp3JmmRu1DRUfwg/m/8tOaD3CwrDhyaVb2zeYDjY6TT3mPRhv2cy7Q2eekPJK
 vtl/1GS2llTJa/cGFKJpGeve/BmggoAwqWBLAnMcV9JehSX9S4Kqv0P7KVexIPP+yLE7
 AqolnuOBUvfY0jYipG5BSJFIa/xP3Ido0YrMLypBz6vB5d7DDqOs/fOivWSEnr5GKxby
 E7b+oh7IULoGRSZN3ZqBLvxmMy+xxbx3TJIBSUvDnJA72uhGplvWhpKkYczwT9XJ72K3
 9H0OftusEbjVvsuRR32I8gDNDHpzsY1FDZ8EaKGvk8rgIn2jwBIbqthnzxTzCAoy56pb
 mNcA==
X-Gm-Message-State: AOJu0YxlVIfy+y3e+eBtMK7RmZJhkIZ5NxwsERDk3/pmUihsB0fEXbee
 qGeQ3YcKITTv741czIZDEoXiggldzg4TGUn14eg0qvumqJYjBrz4ESSNH6wxKIOochgjLR+h+xO
 haeg=
X-Google-Smtp-Source: AGHT+IHKaEWq3K6xRYFttQ7vmsuYSHO75hEiXZLC7nBIct0Ko59Zqhh3Wcjzhz+00GEtJetrusC0bg==
X-Received: by 2002:a05:6358:722:b0:178:6463:d40b with SMTP id
 e34-20020a056358072200b001786463d40bmr6929010rwj.17.1706569353860; 
 Mon, 29 Jan 2024 15:02:33 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] accel/tcg: Use CPUState.cc instead of CPU_GET_CLASS in
 cpu-exec.c
Date: Tue, 30 Jan 2024 09:01:16 +1000
Message-Id: <20240129230121.8091-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

CPU_GET_CLASS does runtime type checking; use the cached
copy of the class instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 109 ++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f2535a2991..3aebf46849 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -343,9 +343,9 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
 #ifdef CONFIG_USER_ONLY
                 g_assert_not_reached();
 #else
-                CPUClass *cc = CPU_GET_CLASS(cpu);
-                assert(cc->tcg_ops->debug_check_breakpoint);
-                match_bp = cc->tcg_ops->debug_check_breakpoint(cpu);
+                const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+                assert(tcg_ops->debug_check_breakpoint);
+                match_bp = tcg_ops->debug_check_breakpoint(cpu);
 #endif
             }
 
@@ -462,10 +462,11 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
          */
-        CPUClass *cc = CPU_GET_CLASS(cpu);
+        CPUClass *cc = cpu->cc;
+        const TCGCPUOps *tcg_ops = cc->tcg_ops;
 
-        if (cc->tcg_ops->synchronize_from_tb) {
-            cc->tcg_ops->synchronize_from_tb(cpu, last_tb);
+        if (tcg_ops->synchronize_from_tb) {
+            tcg_ops->synchronize_from_tb(cpu, last_tb);
         } else {
             tcg_debug_assert(!(tb_cflags(last_tb) & CF_PCREL));
             assert(cc->set_pc);
@@ -497,19 +498,19 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 
 static void cpu_exec_enter(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-    if (cc->tcg_ops->cpu_exec_enter) {
-        cc->tcg_ops->cpu_exec_enter(cpu);
+    if (tcg_ops->cpu_exec_enter) {
+        tcg_ops->cpu_exec_enter(cpu);
     }
 }
 
 static void cpu_exec_exit(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-    if (cc->tcg_ops->cpu_exec_exit) {
-        cc->tcg_ops->cpu_exec_exit(cpu);
+    if (tcg_ops->cpu_exec_exit) {
+        tcg_ops->cpu_exec_exit(cpu);
     }
 }
 
@@ -685,7 +686,7 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     CPUWatchpoint *wp;
 
     if (!cpu->watchpoint_hit) {
@@ -694,8 +695,8 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
         }
     }
 
-    if (cc->tcg_ops->debug_excp_handler) {
-        cc->tcg_ops->debug_excp_handler(cpu);
+    if (tcg_ops->debug_excp_handler) {
+        tcg_ops->debug_excp_handler(cpu);
     }
 }
 
@@ -712,6 +713,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #endif
         return false;
     }
+
     if (cpu->exception_index >= EXCP_INTERRUPT) {
         /* exit request from the cpu execution loop */
         *ret = cpu->exception_index;
@@ -720,43 +722,45 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         }
         cpu->exception_index = -1;
         return true;
-    } else {
-#if defined(CONFIG_USER_ONLY)
-        /* if user mode only, we simulate a fake exception
-           which will be handled outside the cpu execution
-           loop */
-#if defined(TARGET_I386)
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-        cc->tcg_ops->fake_user_interrupt(cpu);
-#endif /* TARGET_I386 */
-        *ret = cpu->exception_index;
-        cpu->exception_index = -1;
-        return true;
-#else
-        if (replay_exception()) {
-            CPUClass *cc = CPU_GET_CLASS(cpu);
-            bql_lock();
-            cc->tcg_ops->do_interrupt(cpu);
-            bql_unlock();
-            cpu->exception_index = -1;
+    }
 
-            if (unlikely(cpu->singlestep_enabled)) {
-                /*
-                 * After processing the exception, ensure an EXCP_DEBUG is
-                 * raised when single-stepping so that GDB doesn't miss the
-                 * next instruction.
-                 */
-                *ret = EXCP_DEBUG;
-                cpu_handle_debug_exception(cpu);
-                return true;
-            }
-        } else if (!replay_has_interrupt()) {
-            /* give a chance to iothread in replay mode */
-            *ret = EXCP_INTERRUPT;
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * If user mode only, we simulate a fake exception which will be
+     * handled outside the cpu execution loop.
+     */
+#if defined(TARGET_I386)
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+    tcg_ops->fake_user_interrupt(cpu);
+#endif /* TARGET_I386 */
+    *ret = cpu->exception_index;
+    cpu->exception_index = -1;
+    return true;
+#else
+    if (replay_exception()) {
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+        bql_lock();
+        tcg_ops->do_interrupt(cpu);
+        bql_unlock();
+        cpu->exception_index = -1;
+
+        if (unlikely(cpu->singlestep_enabled)) {
+            /*
+             * After processing the exception, ensure an EXCP_DEBUG is
+             * raised when single-stepping so that GDB doesn't miss the
+             * next instruction.
+             */
+            *ret = EXCP_DEBUG;
+            cpu_handle_debug_exception(cpu);
             return true;
         }
-#endif
+    } else if (!replay_has_interrupt()) {
+        /* give a chance to iothread in replay mode */
+        *ret = EXCP_INTERRUPT;
+        return true;
     }
+#endif
 
     return false;
 }
@@ -856,10 +860,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
-            CPUClass *cc = CPU_GET_CLASS(cpu);
+            const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-            if (cc->tcg_ops->cpu_exec_interrupt &&
-                cc->tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
+            if (tcg_ops->cpu_exec_interrupt &&
+                tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
                 if (need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
                 }
@@ -1078,10 +1082,9 @@ int cpu_exec(CPUState *cpu)
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
-    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (!tcg_target_initialized) {
-        cc->tcg_ops->initialize();
+        cpu->cc->tcg_ops->initialize();
         tcg_target_initialized = true;
     }
 
-- 
2.34.1


