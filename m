Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4523FC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVC-0001BS-00; Tue, 29 Jul 2025 20:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFk-00026m-OR
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFi-000483-Kq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76b0724d64bso90578b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833659; x=1754438459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EYspnp1ztLEUXf37HM6g1cB76LgbBlY755CmhOzz3PA=;
 b=LyPbE6lIKgRpN0OtdYEc1BzjEyvCYPkG+3Y+37JV6df+bqPnM2b9cUbwTQXzALseNl
 GI+KNCBH7+m8DFppHRl7Tpmc39Q1IiB+ZVKQifBdlphK1Us1WaqG2jyyg/Q8VopuuIsq
 JvZGNVDQXugueM+1Auv6Cqb1B5HVXP6zf8jVyXs6mPJeP3/XV/G5+McqtKKYDOdHmwPW
 kn95nPwkDD6lULUK12Op0oM4wvbCPOKjqVW2gRVF9ZcPK3GdnW/dtxqDVDYESQOdIfFS
 4EA9HEtlO8BCMs7lXpQmwvupEYvYu9fY4QCNs/MdUX/0IFv9jgMLfPuvsgQdwiOpBs9O
 shMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833659; x=1754438459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYspnp1ztLEUXf37HM6g1cB76LgbBlY755CmhOzz3PA=;
 b=KwYLzq5w4JcWLuvrtty06piVEQZe1jbk+aiEqAEatu8ihSU2XV1osPcI1ZI5UH6pr5
 CCmDS498dk053sLyIHPa1E1qpQEmTHCIrXzMBKjX+CX9bOw23oFiIX3zUB7CHd4D5kRT
 tSbZ5cJ4kJbXem/4RHPHZWlDLeNCzEHeZI4wu5KJSYKgTP/P0EHj9Fq/rNclNYLaaQ8e
 sGALTJRh2TI4oEls6IWJxa7KSP/dJLGi8UtM9GxUnwW9Wl6rsYuKgvwOO+p8yUDuyLLt
 vy+VYDtlygOmhoWMGJhmIj5e/CDdrl+Ke+4VqowTc99nTRU9+QXqAptV/hThdvKqNVTR
 badw==
X-Gm-Message-State: AOJu0YxgIlzGXHl5891Wk/JH2MKqzTTfgDSH4Xhr34yXmMGOVUVo0TgS
 I0xjeVQ0/edOXTbIqwqkMkGxu3jn7DWkA1IOIt6QWm9oE8G49y2ok74R0EVphIr9El61nIjvf5z
 NvGfN
X-Gm-Gg: ASbGncvbztNgH0KBvXDByUc83O4ztVFD/vQ8RUJNzuqoch2nxr4jvbZReCfegGi5t9N
 5617WrQrsvzN2QpNr6168EItR3FD85vWofZocDAKUSSkHSPaT/WlwPDOgEvoaaZv8uKOF2zcLWG
 ybZC1fXeejNr9/oQhB/0dpbyY/Y50tKnxboCVDqmqIeZrP1Nq97V44npS74RAIh+ML8GvGgU3Jy
 KFojWsFF+Gy6w8DOEfzafcEb6xgbDk6kezy1C21jdIxz4B4vGcO+F21s+1eHmx8BJYhB3FDXBPE
 TC2GlBnNBbzlfRNOrt1nHPkC39hGnLWW121t2/lyMWh42SKu7OMSi0L+WIUgiEeiAhjfTJUQQhp
 JrOlCCod88d/hpZHZc45q0HcLYaj8hB383TyuXbuMUf290W1Ni24jYT5trVXQvE1f9fg5pwAL2V
 wqkMNL4nvS5g==
X-Google-Smtp-Source: AGHT+IH3OvUwK97LlfqNg686WonSaj0DOR4lJ2c1enCDT0wS/bsKJr06RAaOVTdQ+k5CF0v+/61BPA==
X-Received: by 2002:a05:6a00:1913:b0:748:ef04:99d with SMTP id
 d2e1a72fcca58-76ab283f293mr1933263b3a.14.1753833659508; 
 Tue, 29 Jul 2025 17:00:59 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/89] linux-user/riscv: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:09 -1000
Message-ID: <20250730000003.599084-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c        |  7 +------
 linux-user/riscv/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 62452d7c45..b1f889193e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -855,12 +855,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->sepc = infop->entry;
-    regs->sp = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_EXEC_PAGESIZE 4096
 
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 2dd30c7b28..b316281532 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -94,14 +94,12 @@ void cpu_loop(CPURISCVState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
+    CPUArchState *env = cpu_env(cs);
 
-    env->pc = regs->sepc;
-    env->gpr[xSP] = regs->sp;
+    env->pc = info->entry;
+    env->gpr[xSP] = info->start_stack;
     env->elf_flags = info->elf_flags;
 
     if ((env->misa_ext & RVE) && !(env->elf_flags & EF_RISCV_RVE)) {
-- 
2.43.0


