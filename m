Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C44C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNe-0000Gs-6b; Sat, 02 Aug 2025 19:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNH-0007y2-TV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:52 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNG-0001dH-9b
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:47 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-741af48e9e7so58970a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176245; x=1754781045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz5VaXvtV93wHMZKr+baduksZM5BuR3kgES/WJ5tu1M=;
 b=oNBdXsheG4fnBaHB6pl4cGUK/Glq34v2kk3loF2KpKJ3QVFHE1eLqVRyzVHdtpzG0P
 FQ5KReQeaQHDD29X1M6X2F+chMa2go2kAGjMg+mM7E7opUuGs8ZraT5DvBSz0ZklisMh
 +Iz/srG9RF6unezj8nZjAGCKC7wDt0EK519IWzLPjAY1YqI+xfCcAPC1GB1TNiPmmUE9
 b+urA9aNeDMQXYCCl/XynzhFtGvGf3DMmRKOAhF0wvbZz5KkGEGphxD9Y92qHlEZiZYG
 xubpASRNCSyVr1ovFXUtTrxZ8MAiv9F0QdhNUVZzxNne5/syTxBG93+k5iK7TLrKZ8Yu
 a8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176245; x=1754781045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tz5VaXvtV93wHMZKr+baduksZM5BuR3kgES/WJ5tu1M=;
 b=qv7PwbcdJkV20SUz057Afr7JZDaKijxmuTKlCKiyZtB2AKKkfeb9leKq1jZ++O0Y+L
 /GMN5uLUwsNhCPS+mI7/2FtA4sYchA5jnukNI8sqgPpaPDRr8yArCfv2wkA8UcZzYIr7
 7p3WE154vhQ2osiJJDttXeJUqkK/9httnJdxwBlJhYbwmnAnMPeX/pcArsaKID5Rgg01
 k/mHK9J4MpTX/eAem72ngVQ2w04PL0HC+fntFI6XaAwWyGUgyaA7sHvmL8BO+U8vxEE1
 oCES9DabrNMw3RVqIdJ8Z8X9xjtIOe8MVzS6NCV95RfTq2B+no94KZruwoLPzGBGkqWf
 7t/Q==
X-Gm-Message-State: AOJu0YxveJo7JKc6lpVFQZVRrpB0qVd/L5+K8+L1wWtqF/NLNxw10IwH
 mA/zE10T0Osqm5VfNA0iknxy7/aEzvSZtGT4NWVyLMuiP2HfrlcFEiolYLJdms99bHQJVvH9LIm
 yPTtDieo=
X-Gm-Gg: ASbGnct8YUhI0s+WIvc/BXCTAU0jPP7BoT3bxBeVydJMUKt+uZSygLga2FKwsX5+45t
 8KwRCroDazDpQ5yvz/POkRdNvF04krXB30s4u7mRhJPsasEzKnGT+taD0RWCy6kyFieRlKTw7wD
 +oSfumoxqoqMDf8iLqaTQo9zy4lXqtvY2AObLtJpIQiGlM5qgR9DM+bu52BXRMNJu+IECbuV7gd
 jHpAveSS+/pxOC5zvAzbcM2UQja4mMoph6Aqzlet1mGs240xNKveZ7tF8en75gPNUGR26O9+rqZ
 mvqQxBbY2GQAgogodLogibG+EX4yDqhWzwtPAXALL6jnOfR8Bagxt1Fz0aG3ot3unFKQWPpdHjj
 o3ivv+nGTFMAa8j/iwuEXaUhVUH0wa9XW+jXpN9WAWYfYdoBmDeQ43Yv31n09uv4=
X-Google-Smtp-Source: AGHT+IGku7YWDTortG0RZhkgYw3le5gi5UT7Rdsvu5r/J0ZbZKVpaUJBGP5A4q90DG22Op5hRAxOuA==
X-Received: by 2002:a05:6808:124e:b0:433:e660:16b6 with SMTP id
 5614622812f47-433f034a6c5mr2446849b6e.30.1754176244974; 
 Sat, 02 Aug 2025 16:10:44 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 42/95] linux-user/xtensa: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:06 +1000
Message-ID: <20250802230459.412251-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c         | 18 +-----------------
 linux-user/xtensa/cpu_loop.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4876e4b0a8..447a9be11d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -905,23 +905,7 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->windowbase = 0;
-    regs->windowstart = 1;
-    regs->areg[1] = infop->start_stack;
-    regs->pc = infop->entry;
-    if (info_is_fdpic(infop)) {
-        regs->areg[4] = infop->loadmap_addr;
-        regs->areg[5] = infop->interpreter_loadmap_addr;
-        if (infop->interpreter_loadmap_addr) {
-            regs->areg[6] = infop->interpreter_pt_dynamic_addr;
-        } else {
-            regs->areg[6] = infop->pt_dynamic_addr;
-        }
-    }
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index c0fcf743e7..43a194fc4a 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -238,12 +238,22 @@ void cpu_loop(CPUXtensaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 0; i < 16; ++i) {
-        env->regs[i] = regs->areg[i];
+    CPUArchState *env = cpu_env(cs);
+
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+    env->regs[1] = info->start_stack;
+    env->pc = info->entry;
+
+    if (info_is_fdpic(info)) {
+        env->regs[4] = info->loadmap_addr;
+        env->regs[5] = info->interpreter_loadmap_addr;
+        if (info->interpreter_loadmap_addr) {
+            env->regs[6] = info->interpreter_pt_dynamic_addr;
+        } else {
+            env->regs[6] = info->pt_dynamic_addr;
+        }
     }
-    env->sregs[WINDOW_START] = regs->windowstart;
-    env->pc = regs->pc;
 }
-- 
2.43.0


