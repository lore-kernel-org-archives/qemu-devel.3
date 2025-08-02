Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7171C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLK2-0006IE-0u; Sat, 02 Aug 2025 19:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJz-00065N-Ge
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:23 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJx-0001EY-T9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:23 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-741af48e9e7so58477a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176040; x=1754780840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeGroPrnRpObcnV2bOJGVQoai493yMe+Cg8ch1Rprt4=;
 b=Yue+NDnUBXefc2NXSbnO73TOzTvRJcJmmCsbCtZCj26RyeYyku+ettOfpNTULJ6gYh
 ImfxI0sdVAsi8cWYdw1NLVvxgY0qKslRO4BIN0SmzQS/oWHM83AJzc2Pe0aoLulMfCFT
 RVDSn/Eh5astZD9g0/8hgdeDmpJqHQlLQhJqTlFBJhT9oLV4TnpMMUrbVFAAQghY2eeo
 D7JrzJkIE7dyLesPzXbZTUudKAXfCm7xjkXnSwG0ZmVrFlyDO38nLzDbwowwlOmXnind
 u05bjkYkjgz0OXSCkCXQbonAowHVxCCOOLPJHFKRqGWYCJAaH4Mbl18RgTC66hNPwZdF
 ZLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176040; x=1754780840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeGroPrnRpObcnV2bOJGVQoai493yMe+Cg8ch1Rprt4=;
 b=lM4PV42usrrPwKRdcyPex5HODt/UARvUvtIMnwFxOh6JRyZslk8AVzRIZ/9QGdH/+N
 excdoYbZlfvHEoBg9y9c0TP01kaG+RBSM5LUayubJP/jzn1peJF8MS5cc+sce/p/qmr6
 Kjazw/jReD6Jln96wokW4s3BiMhqKW5tmFCHzHD+st6X5XAbiQt47J2qBRZQ8F/Ltsv7
 slpnyVWRlk4Ct641X4IYoNF26MAOGoQN3v+g6m64pl/ut4PZ0dE9dJBmhdmC2Jl99Z0E
 2I01QV3Yy9lWn+lWEchtNAOGwmvK7wYT7WgMKWNQxeTRVhgeTIqllGSglWR/EJ82HaMo
 WV/A==
X-Gm-Message-State: AOJu0YxsS31ENhuIIUm6Yg6BNN9KlNSCdAeV0vvAieEcxdHY+nZSQpmm
 foYiV3kKbBa3d0tZnVVqCklj0h5rGFpcHeTFvFh+sVBPWbLc6YmRQX5+mnpPcOEE1HzvaGoYuyB
 4sxZB+9Y=
X-Gm-Gg: ASbGncuYoYXepoEuOADO/Hc6vqrhgw32EsG/clG/iSMvxczFT+dhVtvYJdZvlg7uHPU
 PWxDmknUrP5idz8Uv9zlB7g5N0jVx8hJI6HUDoG54ks0xVyJIoDc/Lf08Rpbf39btYFkSxrB7Dl
 W2OevzlbbI568Fro1oAMwjo6JIrHjgyHaAuw1GM713ScY+BLtze+Wux0Q/GpB3CoqE1kdtUyC+Q
 0qjVyjibL9/m6stYCHMJes74qGAzunOvM4q+4fMOALyDiE2eeSwDjl592ajVm7Z9B894t9pggif
 WkZo0QsoffPOZr1UIYBSLSFjmyFHCNwYQOABIOe7SKerAz1SBWzZDToo7+e6kDxnpoSt3FVrO6v
 VgV5A9VBueo0/lrequxPHOQ4qVcBKtnrfKG11E7ttLWAm/KuS/zI+
X-Google-Smtp-Source: AGHT+IGWJCuamlNRYXD6Y7hpE68fW2r0qXYCAGeHgXrRRlmwjPhRvzR0WaE6QB1dp1ENx+2AVFv8PA==
X-Received: by 2002:a05:6808:4f29:b0:401:ea7b:e535 with SMTP id
 5614622812f47-433f030038fmr2677884b6e.22.1754176040546; 
 Sat, 02 Aug 2025 16:07:20 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 37/95] linux-user/m68k: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:01 +1000
Message-ID: <20250802230459.412251-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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


