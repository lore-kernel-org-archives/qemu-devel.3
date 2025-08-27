Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B8CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTL-00064t-Lj; Wed, 27 Aug 2025 19:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT5-0004iZ-3G
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT1-0004NJ-M8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-32326e8005bso376143a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336930; x=1756941730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeGroPrnRpObcnV2bOJGVQoai493yMe+Cg8ch1Rprt4=;
 b=fF4jMm2dP7h9cApt4YF0SovC2Ty6Wzkko6ej3JtWJ3cMn6XOzQu9tv9SjBHvSXanGG
 MVjRAS/DE/Zm7MdGIG5WYM2Kvdagzqy7QS3m+edLxc8aRwtdoK24zr3xfPP21jtSkLuu
 3/tkYYzTDWP6/A3bMe3ytLoQdukw43Hfaj36jUTVav2aczXRFz+xnNHLTpvq7zz24YrR
 eKKiLtROUeyqYa3IS8wL0BCaaluzyAaoui59qkDYQGPlyB1GtS1TNdkxq/+MOaUb1a6R
 QkO0pSOPBKEhr+/psUs0Fsxtw3MNcHvYEss1AGKptsdSGl1ivhgQwcU9Lmgqf5QbATM3
 ZZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336930; x=1756941730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeGroPrnRpObcnV2bOJGVQoai493yMe+Cg8ch1Rprt4=;
 b=sKe0iO4huf/VKzFPJOQIpQO1PhEUX29vRcBBvjxfnnerjLXWSJ972bD82gNCpL5mfB
 N1f96BiBv6XpO506JZQ43RuJofYtNnPcIynxyoJCY7vo1S6nUOe780XwxHgkex8wmyOX
 q6JnEoEZ4A7s51eXL+GYlaPUEyWWyIbf1HMJUz4LAbCyKkCGlEXzkDBTvmPCrQThBD73
 4Ga+9k/o82DhGmXHRhYTmhmkyeGv+jsG703AAF2/m0nUwiAH5AIlqgcrbZJUt5cnTcRT
 ZnNzn0LYl+RP4W5vDXfAeg1VWoGuveAOpxfmFIi/u6tffRa3m1scrdbNaY/OfRC4yhvK
 VN3A==
X-Gm-Message-State: AOJu0Yzs7+knAKUX44AELUxiaj58h7AjTnD33XalzcHUshLFhhtFKZU7
 8E4XO+B5LWw5YT96gdO/3+bcykj88614MNf9pk7sHy5nqMcxOh4TZsue2jM+oSGagkriWTF78mh
 EF6EPAws=
X-Gm-Gg: ASbGncsTObgUA8nCM5iHZoi8Ntydh5xyNEXsVuiaRUgmYkJEJvuUti+SYVJqLYxV908
 AQotaqoUxrV/1HbvF2qadTPtKHFqP/KDZCzhQf8EGlSczE2d1Nh4ew0pAGlwnuAaNQjaoDKE7dC
 tl8BQe9zIXPcPmkBUYhSoaN5ophK/7qYH3qfntzWQyme1koEIkgAcy5v+xD35l1np9+g05r9p5V
 4WdBYxZj2ynfSa0nFeeN9551bwceMM3f6/v18jtcRg/L/FdhY2eQOanLX5qZwAv4ETaVc/eM1z3
 Wd1YgN4r57QD/ef2uVLS+ui6PKPASRDgAG4Kw8F3xAzWpcmJSvVDxWMWEkEDdi6YYirQFq+Kvyd
 hN0nhVrUxOBU5Ux51cEjQeSQh7w==
X-Google-Smtp-Source: AGHT+IFd8mm8fHQLlU7tcgIv1imhaJETIj3uVCQeZNSw8TdIjaSkW9GsJ3AXY3Ys0fQT126SfX8kSg==
X-Received: by 2002:a17:90b:58ec:b0:327:a04b:aac with SMTP id
 98e67ed59e1d1-327a04b11e8mr2128141a91.24.1756336929904; 
 Wed, 27 Aug 2025 16:22:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 37/46] linux-user/m68k: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:14 +1000
Message-ID: <20250827232023.50398-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 linux-user/elfload.c       | 11 +----------
 linux-user/m68k/cpu_loop.c | 25 ++++++-------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8604308a31..46150586af 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -746,16 +746,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* ??? Does this need to do anything?
-   #define ELF_PLAT_INIT(_r) */
-
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->usp = infop->start_stack;
-    regs->sr = 0;
-    regs->pc = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 23693f3358..aca0bf23dc 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -92,24 +92,11 @@ void cpu_loop(CPUM68KState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->pc = regs->pc;
-    env->dregs[0] = regs->d0;
-    env->dregs[1] = regs->d1;
-    env->dregs[2] = regs->d2;
-    env->dregs[3] = regs->d3;
-    env->dregs[4] = regs->d4;
-    env->dregs[5] = regs->d5;
-    env->dregs[6] = regs->d6;
-    env->dregs[7] = regs->d7;
-    env->aregs[0] = regs->a0;
-    env->aregs[1] = regs->a1;
-    env->aregs[2] = regs->a2;
-    env->aregs[3] = regs->a3;
-    env->aregs[4] = regs->a4;
-    env->aregs[5] = regs->a5;
-    env->aregs[6] = regs->a6;
-    env->aregs[7] = regs->usp;
-    env->sr = regs->sr;
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->aregs[7] = info->start_stack;
+    env->sr = 0;
 }
-- 
2.43.0


