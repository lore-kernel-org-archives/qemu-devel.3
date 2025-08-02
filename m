Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4828FC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNP-0007uv-1a; Sat, 02 Aug 2025 19:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNA-0007Zu-PC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:41 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLN8-0001cG-Qj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:40 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6196c753e69so1294880eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176237; x=1754781037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4kf8BI1YPBOaTtnCkPyQ8GhVkj2Nhm4gjasXIKyLdM=;
 b=cFdQY/6jYa6HOiXkeDk6CHPEPpiA2L3ccANttGtfp1daZtumqFTSzzkB9u0WCQgvi6
 x3pmC5K8tOk/z9ek0kLc7btiZcyedIHLzHiNj6QjM62e6GrqVpBAVkxEWE+il4Ikmo9s
 BzIPePE2Ran8oB4eFnm+q//S8kT7MKkeTQ2Ahgtu3Kfxoh3V9jCz+sYb4ftzAimtn9xD
 uZSf2QQ8jI7hQsEdZuVabDEvgYQ1fRgng6Ejbmav+X3PLmZ03VKgD5QEPFQVNTy8pFNk
 N3JdsF1aJZch0v4gL3vH8f87dysNn5e/z9qDTAeZvQvseuHroPzcuxWvxgDR/wtjulwd
 Wa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176237; x=1754781037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4kf8BI1YPBOaTtnCkPyQ8GhVkj2Nhm4gjasXIKyLdM=;
 b=u6xlWXB1YvWKy0EcC80nWdFb6GyfhAtSinEYXaXQ2j6KZ0ZQrzjeekA3FdYkp3C14Q
 6pSJAc+zI10za2aocNp+dD/wDtrd6fCwZNbC48puZXol+GiUq/PQrST/5rgvXCquqkXn
 y2iwyNAgFEVZu8OXeocyr+h09UCjFa/gHAE7oymYC+K3UYaGYVt/jS/S+88dvutPNs1+
 MoJqVKw9Q2iFvL+IBgyF81ChR+U5Q8RCc5W/P4d7Onje9P92od4Bwmjm/W0XvlphgCTm
 0IWXQPqey4OeFMxPJW5G5Li0nEMj5Avp0NmK9A+BS0R9mHHPGyAHvur3EFbdpEt6Lz+v
 fKLg==
X-Gm-Message-State: AOJu0YzdblasJSORwc13+xg/6qfwam5SHoEIXhPbZ31SNTdRlxUsK0/w
 HZucjEGLSGmbubDecshjTcsPmep1O0Cw8xK+A34vjG5wImiNE7FwBaq8ie6zJdO57wQGMwWdwKI
 2zXUpV4c=
X-Gm-Gg: ASbGnctj9/JMcsvG3h4/t9mBTYul39rd4X15nhrOcdnEeLcVTuLtzOFp70CYWtuOus6
 Pk33+6kDuDTzsm2Ip7oHfJkt7kDKxshnzSXam1OVeR570KL198PpWLPs68Mj/4z9VakBPyEXrxe
 WNtt6inNJCLc2DtNaf9Qd0Wg4OG0XDxnGR4E/BspxdtbYdbB7L/H8Oa9wLaydfWSXmeul0pgPi+
 NbY7+poDUSy6a2XvqG4YQ+FXE4BrD0x6mO5carF0GLJQI1tg9Nrgy9+gGyGvgiFrxDq2cms8Nh4
 qJx+9s0y0XCMF8IqMFv6voXxK2cNNU15ckZYbV0u3UIJ5dqJ6LMqzRi0tjiS0bw1MPVHfyKrPNa
 +OcgfvyWjqATcKbpZR8ZJarppVKpFnmcPaArBZSoY02R6kpUarscr
X-Google-Smtp-Source: AGHT+IEF91RtZkB4yvZVmc4Q/BVSuFUuQkhamPvFyrnwPG5c/kvGvMW+Ad5Lf14C2rH7gjTpgqeSGg==
X-Received: by 2002:a05:6820:81cc:b0:619:a44d:43a8 with SMTP id
 006d021491bc7-619a44d4639mr644730eaf.7.1754176237289; 
 Sat, 02 Aug 2025 16:10:37 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 40/95] linux-user/riscv: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:04 +1000
Message-ID: <20250802230459.412251-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
 linux-user/elfload.c        |  7 +------
 linux-user/riscv/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 16aa09214e..556f11d720 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -849,12 +849,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
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


