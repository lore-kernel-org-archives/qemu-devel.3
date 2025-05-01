Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56C9C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLr-00013S-Lz; Thu, 01 May 2025 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLg-0000sv-NQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLe-0001XW-Pj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:40 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso1540556a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134497; x=1746739297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj7bdjIxhUGMCWdPS49pLEhAXBQWGoqis5NhDT45PZA=;
 b=Q2UlBmGIV3uss+joe7gyFGcg/y7hWrUdqOXDOCbDIwiP1lJiF250CYt1BaHZTenjIH
 axEgVfq69mP+xiqFyDTf34jkYtApE3ZnyyTSt7Ovs5+9DYcZHOK9xz5YZPSJOoLwSSb6
 GOdGK938NJAH7c6A6p/Ol8yP+VsCsIbmdMGOQTx/O6CCH83Y+E+9LR1NzGjGpggouRBO
 nuoALraciX22GFLJQPT+eYIPhHk4fuOsLd/9J5q6/abK7jVboHg30ZPPkFS8nPucr17l
 zRpyyir7lLvbdDIinVE5LaJ2xDcywle0jOP8temV/cUxUcxa6P7mjL4Sfoc56N+OiRWZ
 cYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134497; x=1746739297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj7bdjIxhUGMCWdPS49pLEhAXBQWGoqis5NhDT45PZA=;
 b=kBNcncNqTZHijclhc/Po57L9TGpEKfiBRVYJ1Vtk2UqkfjMiCpvJ/af8zYcE9l+bo2
 7h26E++12AwDUGCXaA4C273WXOsJYGVcWQhnmE4kVkIjjkiSAoJHJbMEP+Kefj5PofWS
 zo9GqQ3Ig8JJwRVS5guj0QDGhzxtboOlEqYKYVTX4+42jq/EDeMXCcytxIirMSaGKMDi
 8LP23EWIEw94BS02J9gYE8M1tpopHd0lyL//OfcbwGMNHQYaA2NVRvo7usVoCKyO3tsu
 oe9qvauS+76INV7B3z9wy147dic5txKETcEr4ef//yc/wuBm2LTpIyRMxDMGpU1/WgVX
 e03w==
X-Gm-Message-State: AOJu0Ywght22Hpm0b9tT6QByN0HMYmfphavsPSz3gXGpZduIKSQ8xtvQ
 +bxfSAvZPYhD4P17DlsZytXHD6duWVtz1PPliL9XmHchm6FIpLpHkIjA33m7SdnA796RQTsgVov
 G
X-Gm-Gg: ASbGncuqP/E0SdpnzS31Ntlrbp238S/Y4BB/xHHQf1eloNMRW9mS7fkBGKaKw1aNZDs
 KBc2jzhsHeUmnel1R8WlF5HsmhtIlvUev+O2KsU8WAYlWXsWnWmNRFpRKFx3NmRJnaLLs2VNAtj
 sn9OxQs4Y7RMJA1sft0QCGhWywAV1MziIpUAaISrCqhZ8/nVRDFST2oOUJeExoJ0IREqm5E55k9
 CEnPTzykzwKNGdXgSprNaHxNf1z0K7C9AE8qQ/DUU33wXIXQAakkTE7lfdkZJ6WxOH8PMqhw/lT
 YtOUJjA49WmC2TGgU7W5W5Bvcofop3lk9yH2DZZQEO6UjXPRkoVvV2I7Yv7629uvDLYMreUkfVk
 11shunmuzTA==
X-Google-Smtp-Source: AGHT+IEaQKWUdKFiDj/+/8/kyCoUaQX7J9I7yoM1WDSnXzHdNvtZf7/QRgyNelW6khyEFMoQiB6Wuw==
X-Received: by 2002:a17:90b:2711:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-30a4e5aa625mr1041415a91.10.1746134497395; 
 Thu, 01 May 2025 14:21:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/59] target/i386: Split out x86_cpu_exec_reset
Date: Thu,  1 May 2025 14:20:41 -0700
Message-ID: <20250501212113.2961531-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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


