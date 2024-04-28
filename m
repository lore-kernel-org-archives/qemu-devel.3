Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6434AC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cov-0000Qr-VW; Sun, 28 Apr 2024 18:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Coq-0008Ll-Bs
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:26 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Con-0005gJ-Lx
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:24 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51ae315bb20so4597020e87.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342579; x=1714947379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PypuXO6MWd/PfirCZaShH9WcvTwY8whCrxRa/JQC3P4=;
 b=abTo3YuYWw+YAlOP0zWar9BxvRWC6PdOcEUILhuYME4gM0gXwalr2J0rq6SuEt+U14
 4XBfLM82UtDTcwYFM32wOuzzej5A4NAxZZb4N6s5Uf+fAsRpLYO5MDrjObDEp+W1IAIW
 TKdnOZmJF96fNDOncCHqEkPsQuhSqw51M8RKFVPePFwxKd6OigwLyAPzG++V75gi3vpN
 gdL3MwoZ/FyZb1T9AGANsB/JcDBbWITY5de+nXohueliHw1L13nhMMInltHSR0x05tRR
 O9TOwUALf6/UOFYP9IuNDopN9CJPrrn7IFBp08qBeKfOzPZExUEAlQ78jFVhZRjFGSMd
 lj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342579; x=1714947379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PypuXO6MWd/PfirCZaShH9WcvTwY8whCrxRa/JQC3P4=;
 b=vVXEKJ1tx60wcpNUEo7b/NvBh/ZDPLWqKx0+NU1xK0ezxw0dPHHYJ70Ugz7ZPPkueh
 1/Bakiq7oLDE/yXRKVVXNlxdtS2V3qO20qVP+umxzGhV0SqVkK7vvGEuNskCZiLgX0Za
 JhBv2JeMAKOiPBrDLGha5po6EQGtrbErMVxYBjKYgwNDuIx+RONCH3O99It088Hb1R+V
 6StcDBRl8Bu+KFQsmffxaxgH5XALyxyCQ4v6o0/7ERlr+3MputzWU7JJYVvlIqdJM/X+
 2lQnZSOKex6fOc882Jll195ciQNHUwEwzgiZbjxAElDS7+rWCAGFF01DzXLCjh/YGraR
 qppw==
X-Gm-Message-State: AOJu0Yw9iacTMf60frI5MKqT7hTWcK8vsJD735g7f2GT8p9v9KM1fsYX
 sWgMU+wj9aHY+fj8ZkFKcSuTiv4FSipshl1W69aeoEW8p8BHD20432o9UAPyMG7k7FTqb8o2HIL
 V
X-Google-Smtp-Source: AGHT+IGiPxdAYTztLngL3XADhlDPqbUur+yyyl3QtYFrEmjqSpVs60sOu0KGsHE6LdyDm1vT0irRig==
X-Received: by 2002:a05:6512:238c:b0:51d:682d:c2ab with SMTP id
 c12-20020a056512238c00b0051d682dc2abmr2555020lfv.32.1714342579509; 
 Sun, 28 Apr 2024 15:16:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170906388a00b00a46aba003eesm13129504ejd.215.2024.04.28.15.16.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/24] accel/tcg: Move @jmp_env from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:42 +0200
Message-ID: <20240428221450.26460-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

@jmp_env is specific to TCG accelerator, move it to its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 1 +
 accel/tcg/tcg-accel-ops.h   | 1 +
 accel/tcg/vcpu-state.h      | 2 ++
 include/hw/core/cpu.h       | 1 -
 accel/tcg/cpu-exec-common.c | 2 +-
 accel/tcg/cpu-exec.c        | 6 +++---
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index df317e7496..e2c80bc7ff 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -11,6 +11,7 @@
 
 #include "exec/cpu-common.h"
 #include "exec/translation-block.h"
+#include "accel/tcg/vcpu-state.h"
 
 extern int64_t max_delay;
 extern int64_t max_advance;
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 44c4079972..ed41a087a3 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -13,6 +13,7 @@
 #define TCG_ACCEL_OPS_H
 
 #include "sysemu/cpus.h"
+#include "accel/tcg/vcpu-state.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index cf8e3acef9..cb06f0412b 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -12,6 +12,8 @@
  * AccelCPUState:
  */
 struct AccelCPUState {
+    sigjmp_buf jmp_env;
+
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index dc28920bcc..6d3716f619 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -477,7 +477,6 @@ struct CPUState {
     int64_t icount_budget;
     int64_t icount_extra;
     uint64_t random_seed;
-    sigjmp_buf jmp_env;
 
     QemuMutex work_mutex;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bc9b1a260e..ec45482305 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -38,7 +38,7 @@ void cpu_loop_exit(CPUState *cpu)
     cpu->neg.can_do_io = true;
     /* Undo any setting in generated code.  */
     qemu_plugin_disable_mem_helpers(cpu);
-    siglongjmp(cpu->jmp_env, 1);
+    siglongjmp(cpu->accel->jmp_env, 1);
 }
 
 void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9af66bc191..46ad16f911 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -553,7 +553,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
      * support such a thing.  We'd have to properly register unwind info
      * for the JIT for EH, rather that just for GDB.
      *
-     * Alternative 2: Set and restore cpu->jmp_env in tb_gen_code to
+     * Alternative 2: Set and restore cpu->accel->jmp_env in tb_gen_code to
      * capture the cpu_loop_exit longjmp, perform the cleanup, and
      * jump again to arrive here.
      */
@@ -577,7 +577,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags, cflags;
     int tb_exit;
 
-    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+    if (sigsetjmp(cpu->accel->jmp_env, 0) == 0) {
         start_exclusive();
         g_assert(cpu == current_cpu);
         g_assert(!cpu->running);
@@ -1038,7 +1038,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
-    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+    if (unlikely(sigsetjmp(cpu->accel->jmp_env, 0) != 0)) {
         cpu_exec_longjmp_cleanup(cpu);
     }
 
-- 
2.41.0


