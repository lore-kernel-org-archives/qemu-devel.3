Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D279C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcj-0005uC-6Z; Wed, 30 Apr 2025 12:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcI-0004wO-1d
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcG-0001tn-2e
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2255003f4c6so962775ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031739; x=1746636539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj7bdjIxhUGMCWdPS49pLEhAXBQWGoqis5NhDT45PZA=;
 b=AUXdtJSbfPfA4WE7q21CoEHKs13uSbohaEXcNlckZMvVCdQ0F1BqKWQwQqzqGafluR
 8pwOmMblaRoYLRMhaD7rKQdMzpFtUj3OA4/SX3oQyULJ/oMH8Q444Lv/k40F4+3Df/YH
 fRwEDCi86OmsI9uRDlywpTHj0FX0oG4Ymxko01+Rsw/cDWlVpDigCnli3ayL2YWhyNjk
 U0Q1TGbZRr58w1/Nhe29zsHoSdudMFzbxHcd0z4qcbxmd8/33xVJLponuF1PywLiM9Z0
 6Pe8tOkvO1qmobZMl3zjuy9z0lGiu7NEdW2sxLLWw/7ygKdKQDb/llI+0pjrAdeWkGUN
 l3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031739; x=1746636539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj7bdjIxhUGMCWdPS49pLEhAXBQWGoqis5NhDT45PZA=;
 b=etOkAk99PTnhJk6QBhwdzZX5GmxH6Z8xa3k3VKBwwjs2Qcj2UyNN54DAL8LpVKKOnT
 IVCXrpp5B0NBD/NiqAyOiw2v8+FutYQUpM8W7ADezgimOOu6CVXZElMlMDq1SoBM6KlS
 QfkZtIkd775ywMdK7nudY1USeAyVqytwydUjk7J2VwZNsdAR7jb5k8gvWG0dxxHMKsYS
 Sl6egt2fzlMh3YeCgoNoBpALEzSyh5Mvf0bKP598+GXGydAjMJ1MRdEx/3arb2WSu3Z9
 /cf64Cb1P1KWRGOJS9KfmoktaK2gQTf4Q9N52V+aCZaJaA/k38us7PWBOi+xiwAOJQPz
 dZYw==
X-Gm-Message-State: AOJu0YxiYH2XPgSILF7RltzBJsSOgMhjaG2CwyYIFtYndtytYjPd3h2M
 HPCsevpUxRwBKB2SqvuLPJVTGmxSOBosim+/iHQcULVCI6uUHOAfa57DUUMZCV3DGJ2gpRXqjXZ
 R
X-Gm-Gg: ASbGncvPIm1q4L3Jnhwo53Z709PbEqBC2ZiSUf4vUOxEB8QivuV/+HlIZyDIqR+CUYH
 L0WcWWrv4EK6ENiQdpeDWO+C00uEWrENSZ42fB5dWwg2VzGDIlV9fpKh+Q/pbq/b/8fNm5KL4Nv
 dROaCpCwMzQ6wV9wo7UBapokZxIutIFBH5AABiwsBHgS40lDxzSB2z0PFZM73v2eBN8m8uVXGeX
 pDhSqA3jUwrCn5y2xE+xWCltII9NdId6mMCPU3+3STCXsPum10vtQcoGU+at7cc8DR+iS5Yj/D8
 0dt6vOoGW4V8CE4FsWhNHKtwpHJrWUHJI0zkQ3KbJ3SVN1ho9FhLAmW7CvpCtBWuHpacCX8ZiMA
 =
X-Google-Smtp-Source: AGHT+IH8p9hTIkPhwLtOWTGQqssRSu2Dp/OZtJS2y6rM3de+/Dc8KgMYqK/Z4c5zuO0LBF/We1rDsQ==
X-Received: by 2002:a17:903:18b:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22df35ca8a0mr55955305ad.47.1746031738702; 
 Wed, 30 Apr 2025 09:48:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 04/16] target/i386: Split out x86_cpu_exec_reset
Date: Wed, 30 Apr 2025 09:48:42 -0700
Message-ID: <20250430164854.2233995-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
new TCGCPUOps.cpu_exec_reset hook.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 5d1c758ae3..f3f0380e70 100644
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


