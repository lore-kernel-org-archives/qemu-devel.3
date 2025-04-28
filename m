Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20364C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoI-00058h-PF; Mon, 28 Apr 2025 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoG-00057v-8S
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:36 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoE-0000cG-Dp
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso4632630b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871033; x=1746475833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ0ltXmMLAseVMXMt+PRkdJL8bxs0+GQjSw4gZylX5E=;
 b=uCW9e5E6mjVlhSrqS/3gtuYaIWW61l7CZhwWw3qt4YmpJFNkrXuSyp5HFRZR0bw2fw
 n7Wy7EOLF0khvPZHplJw1lOmsxBbrHI2pUmeT7pFB9F+Blqbz84eZGcSMWPqEFkQl/or
 b+F0aqoP/eREZRwaH3FtMmxGJBLcGhLvFuMH8I4hiG73AfeFwuQ2PNjwDqDBEi2NafBo
 +6bvcoxFoo7cy8TzdCaLwH1EwnEqm7Z/3E/Wya4UvDPsYY/bGM8W/KPqbqiDrReiQq6B
 6+UUhuOyuDjIJS20Rww/2FxtxjoCGMiK6hKuMuGaXROm2KJoI+l1w8XtLGDQnT7vIn5K
 CzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871033; x=1746475833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ0ltXmMLAseVMXMt+PRkdJL8bxs0+GQjSw4gZylX5E=;
 b=ec8uV/dPNJ3hvisL2vsh4iRizprJIMI2IzO9zl+zKHi1MJ02YJmIV2Ma3MnDSZNNWF
 9sEnnaB6NnUaOH+IOX7v9EEOAE+TNKwHxSk4LjbTzyZ4HcVXPNFBsqwEQWu38nWM1xfe
 VYJ5h7giVo77PEBVtAOFJNbhICjoMtIFCJxZFBOSfafQFeTNhxiDYsGL7nOdIGMEEQSH
 5tCgJFq6Ig+hvXqYZb9HENxVCFFMOvYyrmG3O9PgCpW03IHU5MV++rNpww9xRUGSCeqz
 L83YqMvXqyItOoCOXVIxShHyiQASxjkkZ5CYTlhG3rJL0R7533Lwe9NAEu4ivyC4BrQ4
 03Tg==
X-Gm-Message-State: AOJu0YyLUD6HXgTRpC8qVyAGriLs6tUYnmcoskag5H+Iy9eyHFJ1JpSU
 tL0v/vDM+ZrL+U2yCsSVk4FwJzQ2mEAEyMkdLLPbFunEO16cb+Pu8Rt7Sgge4QBJHpDQgJSvgp7
 A
X-Gm-Gg: ASbGncsPrUhxWb+FyVVZzdU38fAAive7ZtiR2+739b2F9SSQmjpVHfgxRSTUgitKxSm
 xs75WXafRuYNxTejIRS66tfTLgOSZzL0WaXLmbzCFNqpwDVH+L1cAUl99zho9wFUPnEy0qZBK1M
 n1NlMn0Fff48nYi4eTGbcCLOgg0Lrdj8LgaapDo1qufQknx01eyCkgP5ZOwuTtVBOMYeqMHtolL
 //WYJ4gckjeT1J2hEprqVktA0q9uvOFd1mR1AiKwI1K7vYQyTIG+8w/JNOZYQBRc6TzZgSUz8yO
 SE5sIyNcEWhd+n0/RAG5U8mnMmIEw7Spt5yeUOQYi7v06LYHMmvh5ftIqDA15ABbu6jRPwmoAYc
 =
X-Google-Smtp-Source: AGHT+IGIJ9N+r08WzNceb3U5RwH9TMRJRdka/DzZizWGG02B7UxWb6+ZuMOFCd7YT2gEJqjF+tRzeg==
X-Received: by 2002:a05:6a00:3a14:b0:736:b101:aed3 with SMTP id
 d2e1a72fcca58-74028f93bffmr541451b3a.1.1745871032817; 
 Mon, 28 Apr 2025 13:10:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 04/10] target/i386: Split out x86_cpu_exec_reset
Date: Mon, 28 Apr 2025 13:10:22 -0700
Message-ID: <20250428201028.1699157-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Note that target/i386/cpu.h defines CPU_INTERRUPT_INIT
as CPU_INTERRUPT_RESET.  Therefore we can handle the
#if TARGET_I386 block in cpu_handle_interrupt with the
new TCGCPUOps.cpu_exec_reset hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c      | 39 ++++++++++++++-------------------------
 target/i386/tcg/tcg-cpu.c | 11 ++++++++++-
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 010f38edaa..c21c5d202d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -819,33 +819,22 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             cpu->exception_index = EXCP_HLT;
             bql_unlock();
             return true;
-        }
-#if defined(TARGET_I386)
-        else if (interrupt_request & CPU_INTERRUPT_INIT) {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUArchState *env = &x86_cpu->env;
-            replay_interrupt();
-            cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
-            do_cpu_init(x86_cpu);
-            cpu->exception_index = EXCP_HALTED;
-            bql_unlock();
-            return true;
-        }
-#else
-        else if (interrupt_request & CPU_INTERRUPT_RESET) {
-            replay_interrupt();
-            cpu->cc->tcg_ops->cpu_exec_reset(cpu);
-            bql_unlock();
-            return true;
-        }
-#endif /* !TARGET_I386 */
-        /* The target hook has 3 exit conditions:
-           False when the interrupt isn't processed,
-           True when it is, and we should restart on a new TB,
-           and via longjmp via cpu_loop_exit.  */
-        else {
+        } else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
+            if (interrupt_request & CPU_INTERRUPT_RESET) {
+                replay_interrupt();
+                tcg_ops->cpu_exec_reset(cpu);
+                bql_unlock();
+                return true;
+            }
+
+            /*
+             * The target hook has 3 exit conditions:
+             * False when the interrupt isn't processed,
+             * True when it is, and we should restart on a new TB,
+             * and via longjmp via cpu_loop_exit.
+             */
             if (tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
                 if (!tcg_ops->need_replay_interrupt ||
                     tcg_ops->need_replay_interrupt(interrupt_request)) {
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 63ddf87aa8..0184e308e6 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -120,6 +120,15 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
     /* RF disables all architectural breakpoints. */
     return !(env->eflags & RF_MASK);
 }
+
+static void x86_cpu_exec_reset(CPUState *cs)
+{
+    CPUArchState *env = cpu_env(cs);
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
+    do_cpu_init(env_archcpu(env));
+    cs->exception_index = EXCP_HALTED;
+}
 #endif
 
 #include "accel/tcg/cpu-ops.h"
@@ -147,7 +156,7 @@ const TCGCPUOps x86_tcg_ops = {
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
-    .cpu_exec_reset = cpu_reset,
+    .cpu_exec_reset = x86_cpu_exec_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
-- 
2.43.0


