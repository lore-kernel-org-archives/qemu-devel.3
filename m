Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F32CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWR-0007vJ-U7; Wed, 27 Aug 2025 19:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWO-0007lt-Jo
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWK-00058Q-Va
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-248a638dbbeso3326245ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337131; x=1756941931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4kf8BI1YPBOaTtnCkPyQ8GhVkj2Nhm4gjasXIKyLdM=;
 b=iQJmBHFEUaffVuucWX9G6NW1nZUJMtqubPHM7TB+ZohBt+KAXOfYFh6s27G3ZcKVsr
 PG/yzOgJQoDyXEJ/x0+23eNQb/ABmh+Jo8VA9rMZawPiuUFnL2+9RE2M6he/kZ05LXCA
 vcPxMQ5hmjhR2FJ3Aqr8AX8kDaHNsoVATI5IOcZwB0IciPbv2xbTPMYSvdWCGszSCd69
 y+HdcPk2+0/VwnPRbgFAgOsGYWFU7JRlToW3bmRK77JQxrX4NQ5VL2nKz1uRXn7KdKCj
 qTvG3ksTLP5YEmBqJMASK6dLSpjijWDLLC/d3bG46G4y/H3Nt2anOPsXRYUE7H2/s6H1
 4L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337131; x=1756941931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4kf8BI1YPBOaTtnCkPyQ8GhVkj2Nhm4gjasXIKyLdM=;
 b=lBZ+k9KmlicVqbc/D3m0uH/K7cnCkhxI/8APRhwE8QG5jnKJvMnuhRK1PaI0glDvbd
 F+AB2pYMN/xOLGW/NfuEYtnMy3vR4T4Sn9igvsQPDvBLno+gB8obvYJcx4b/OGAn6sYW
 PDDIIOPpTRjzZBELZOPx0TVb1X29WNxJNvVEJkzcn7DbTih9zCletWt0/vqWuHamFaPh
 q9qAUZApYrUUJQtP2Iug3OhTfERD9KD3JCbTyqJppUa2vFbxrdxAiGkeR2ggCAW+M7S5
 OkrrU62c1f77wsA/ayVCeHdezKxvlcXyIZ9DCz6dBWLXY2FV5tdCuMtjddHkhPRwpg9J
 Czqw==
X-Gm-Message-State: AOJu0YyeU8bMWVVQ2VE4PkLobh0D2Asb3l0vttDsqfJzzwwNlcftMgMo
 F0cGNQSKklwxf4uXMFGr9EJiAAA1Ewp9J2vh6NOq2n3bfqgWoDCp23nGBynRdAQns9jZWOPH3mx
 pr55TpD0=
X-Gm-Gg: ASbGncsJoMbQJaP5GW+py+lgOpwLjJgso3Nr/kdNLFnrCZ3v4rSIgfVWOattWCL/rEU
 bbq66XqPY6jpJ1OZH1lZMoni8xeDtd7yqmMOUcxY5ZtvTFTnEMBkGHeJrBO+FvLBG1EsEp5EfIs
 SSP2LAZC8H4NsGQSYyFMZqosQfHbElhMpMrZjAMqD6PV35eEZEbaTijXzgCW6LWT+okTnSzwnc7
 xBUfyH9O9j3a803IeyLKJ5YJVfSIr5zXEUfTB9Hg9e7RU0mhmXSf8AM5Fr4+OmXnlrt7t4qUrd/
 pCEmDxNFMKcl56ywfDHxw/mNVo6qB0yc67S7MJQbDjIfsZqLl9XG8P5UXxSUUb4TgOwfq32laxF
 zVw5tMUjn0Xi41msbumoRDAz4LX7L47kVtwiX
X-Google-Smtp-Source: AGHT+IEea5JafBzdxn9y+gTbwnPJRFUjUMGWvzVs9IqX+sdOb/qchRvoVEgvJoVnRKJyvqD1JPYeNA==
X-Received: by 2002:a17:903:ac5:b0:246:a132:8edb with SMTP id
 d9443c01a7336-246a13291b0mr179985635ad.32.1756337130702; 
 Wed, 27 Aug 2025 16:25:30 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 40/46] linux-user/riscv: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:17 +1000
Message-ID: <20250827232023.50398-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


