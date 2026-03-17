Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C206FED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YZG-0006Ut-7x; Tue, 17 Mar 2026 13:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YZ1-0006Ar-FW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYz-0007S5-EC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-485345e1013so948745e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773769838; x=1774374638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pM5hm7GqrPWghq8ry8U3cW8j2X5kOQKZL/qNbWyN25Y=;
 b=HQb8Ma6e/NKS4HUEMlAQDhL6cNJ1LcnyRFF8NevQ+2LHjHIPiXV9hoOTqHziT8vpfp
 n93BFsPOH+hhuF7SCnPJ+fwpc+C7ugh96WvAsrqVdVPqruBc9Hz08+fD/AtePFcyTSZa
 ctIhUo519rUhhZXwir/2d/d7vRhBhTAkDjEycC/ri+SlrTHZ9QnXzvYD9EDuriJ7WNsR
 AdT7vWb+Ze9GrCTRFvSwr770EROSudS6eDX5lzp9G4qUVxuOKaOggPJ/X4FZbVCP7GBp
 sUvZXN0fne+9MZf5q3GzMeXnfW7nFYEL2SUdBOZhdKHISHzFfDkcNW8RjkdKYJHmhKcn
 NKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769838; x=1774374638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pM5hm7GqrPWghq8ry8U3cW8j2X5kOQKZL/qNbWyN25Y=;
 b=SEZ8j4VsDIIrZINu0/zvLs47/jrL2hmzvrDTqvJBJGC8v8ccvRpk1az4NqaXLk5zqF
 kcGIHYnEpTNAQJDMIQ1dkI6Yvn+RE9O0KtHzqHGxN67D75mRALLBfnGd0J7JZJNnLIFI
 TvceIpej4Ci+p9YEmQPKRk2OkOkP91T2upwyBxIg8gP+4mDhbCsps6gF/HVRcWn4gKs9
 pkO8PxBJLtelPGFf3kngn6dEaV4TTriRPgB/o9tVhG04TvCp7JVprUQXyW1NMa3VuBfl
 9IU5j1X/hQXquIrDYF1Ik9JecLw8WqQqYfYcPAV2km8FNbxJ2f+GmngWAPHzXbojKOoU
 XMBg==
X-Gm-Message-State: AOJu0Yw32iBxzfFd0DrgBAvRI2w3vdCWGwGQYLN0rSHMhVtFhPAmgT7f
 Nt/Gq303LWrxI7PMfthmFioluLkAxpFUmlhcvibmHNuviVEVmnNSXn/Aq5YXyHSQZRnHDO73n75
 9SFWr
X-Gm-Gg: ATEYQzwghI2xYlSWNhIvUNR+lo/yrJKm7z+DZpnjj1Jq2kHWkRzYNZLeNnAnQneF05H
 7HVCQ1S+WYfF9LNGz5Te2bTSqfXU61tZ0lM1+9XxgbgIHPRBjK2z5dTlEaYM/w6Qo0gsMqXGVXt
 q8WkgNVZn4SB5ydadBBfE9Aq29MVNEFuJRqbRPBwkFoEGJYJY/LWe/xOt/cGVcajI82ts9tH3cC
 DMeE5DgMNzSyZ0ljst+Ur+w8wu1U+UIJjJDIRf02aTIsyFQs4nRzMuwdVxEuGkOX0nJsqq11LuE
 6eSLfjjcfxAkdkFeaiTV5HQrRZbZLHUOKlmYCkXTCl8fE3M73AN9Ng3N6JPsfG3ht5Bmtch9leV
 Wj4MdKBuFt7gn07nRjJjsIYPtXg2jAji7Lh8uCoy8Lfvl0Yev8VvTu50MNh1YpZmZsB7rXkjqa7
 cm4Fu3O3Q3TJPPAuOeLI2YEOOS+eUW9BY1GQ9YSB4LXw/lxAXR3+E/AUvpdbIC6KsqOIuleP8LA
 1CZ3Xd6GVFxh2TrYjh4UVHx1zqBtOI=
X-Received: by 2002:a05:600c:699a:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-486f40a0d0emr10793575e9.3.1773769838335; 
 Tue, 17 Mar 2026 10:50:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm118786995e9.30.2026.03.17.10.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:50:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 3/3] target/mips: Move count_clock to MIPSCPU struct
Date: Tue, 17 Mar 2026 17:50:30 +0000
Message-ID: <20260317175031.3035740-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317175031.3035740-1-peter.maydell@linaro.org>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The count_clock pointer is not something we can do a shallow copy of,
as linux-user cpu_copy() does, and although it is a system-mode piece
of state we unconditionally create it, so it is present also in
user-mode.

There isn't any need to keep this in the env struct rather than the
CPU struct, so move it to avoid possible memory leaks or
double-usage. This also puts it next to the other Clocks that this
CPU has.

I haven't seen any sanitizer reports about this field, so this is
averting a possible problem rather than correcting an observed one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/cpu.c              |  4 ++--
 target/mips/cpu.h              |  2 +-
 target/mips/system/cp0_timer.c | 12 ++++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0663cda003..f803d47763 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -449,7 +449,7 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 
     clock_set_mul_div(cpu->count_div, env->cpu_model->CCRes, 1);
     clock_set_source(cpu->count_div, cpu->clock);
-    clock_set_source(env->count_clock, cpu->count_div);
+    clock_set_source(cpu->count_clock, cpu->count_div);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -520,7 +520,7 @@ static void mips_cpu_initfn(Object *obj)
 
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
-    env->count_clock = clock_new(OBJECT(obj), "clk-count");
+    cpu->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ca36ca0d6f..cb72be9336 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1188,7 +1188,6 @@ typedef struct CPUArchState {
 
     const mips_def_t *cpu_model;
     QEMUTimer *timer; /* Internal timer */
-    Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
 } CPUMIPSState;
 
@@ -1206,6 +1205,7 @@ struct ArchCPU {
     CPUMIPSState env;
 
     Clock *clock;
+    Clock *count_clock; /* CP0_Count clock */
     Clock *count_div; /* Divider for CP0_Count clock */
 
     CPUMIPSMVPContext *mvp;
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index afa163c319..634c2a66bb 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -29,14 +29,16 @@
 /* MIPS R4K timer */
 static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     int64_t now_ns;
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     return env->CP0_Count +
-            (uint32_t)clock_ns_to_ticks(env->count_clock, now_ns);
+            (uint32_t)clock_ns_to_ticks(cpu->count_clock, now_ns);
 }
 
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     uint64_t now_ns, next_ns;
     uint32_t wait;
 
@@ -46,7 +48,7 @@ static void cpu_mips_timer_update(CPUMIPSState *env)
     if (!wait) {
         wait = UINT32_MAX;
     }
-    next_ns = now_ns + clock_ticks_to_ns(env->count_clock, wait);
+    next_ns = now_ns + clock_ticks_to_ns(cpu->count_clock, wait);
     timer_mod(env->timer, next_ns);
 }
 
@@ -85,11 +87,12 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
      * So env->timer may be NULL, which is also the case with KVM enabled so
      * treat timer as disabled in that case.
      */
+    MIPSCPU *cpu = env_archcpu(env);
     if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
         env->CP0_Count = count;
     } else {
         /* Store new count register */
-        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(env->count_clock,
+        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         /* Update timer timer */
         cpu_mips_timer_update(env);
@@ -116,7 +119,8 @@ void cpu_mips_start_count(CPUMIPSState *env)
 void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
-    env->CP0_Count += (uint32_t)clock_ns_to_ticks(env->count_clock,
+    MIPSCPU *cpu = env_archcpu(env);
+    env->CP0_Count += (uint32_t)clock_ns_to_ticks(cpu->count_clock,
                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
-- 
2.43.0


