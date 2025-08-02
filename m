Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9234C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJo-0005Hq-8z; Sat, 02 Aug 2025 19:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJk-00054l-Sn
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:09 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJj-0001DO-A4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:08 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so2551534fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176026; x=1754780826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5IHWXiuirOhIdHwAX/EQgapibaS75RzzatEhNgb4z0=;
 b=urt7YnaBUuLBkX1ghhGfjXPHuoWxiph9jBwZhIMy7dUQDusOQvHmNw8OV7YPSzxKBG
 nchit4VaGyIMC8wdqupUe6nqKgx9sOg8EPHUwYdBxVQDhQMPcaNCMKAVERtnya4+dIlm
 OBGgkfh/+Q4PWoTQIVVAtV2Am3vgJ9YeVZ02TkerBiAItAlhHB1628Jg6nFaH7J8X6/H
 naiEAnAIoQ2l5LHsxsTTid68o30omzT56BDIe7qCw6Z9KKAmnO5KSiXRZo3ndxh98b0C
 4e+5bQ3egm+5mcpxCkWeXEZh6dZSAXSBqboO9mvbSrWDGTX3o8odSg+dcAorrHA2/R5U
 aHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176026; x=1754780826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5IHWXiuirOhIdHwAX/EQgapibaS75RzzatEhNgb4z0=;
 b=dqAWT8XSU4JihuOAhssVGZsJaO96aEEHpUCN1+WcyejSAVJ6toBCxJZckVw3iWfS5R
 /OJ88qXhLycBTrKkKHbRWsQVrUsWIG4CWYKiXrobJp1jBJJDNDpMrPvjz+ReE22UT3rw
 dW4ywYojtxpVC+SNojQm6P5eXtVqPze/0uU1E7srIHXjF4eqf/v3qxXOao4p7bL5KOIO
 1bTVRBTcqGfxalDuOW6CU+xk7D083zarfb0osqyoTYJk6CjSkCxCJk6Aq8VcOBCxbpMa
 npvleqQE1fWncnDL807UxVhhvqgxFBdkxwXOAkKCj34S3bIi8Vb1bfy/wj8kzQtj4NPl
 kd5g==
X-Gm-Message-State: AOJu0YyVJncy6PZGF7b8OuWgf5V9Zcoljto+10jTbWCOE75Z+iBx++b+
 yAECCX3gEx4P+UdOaAZ22q0RjcegQOdoTBJ/J5s4WuSNPlLblHk7IogAPS9lqb2RNODQVAlmRJj
 Hjf/Bwqg=
X-Gm-Gg: ASbGncvClFdIQUU+zdK7btANISNMygaaJuoUICks/yTRayh3Geb/35HlptiXjNQCgCl
 Yjtixd/uAHBLX4XudILeJQnUJasvg41IsUpdPTjN8Mm6tJFvW3NnwqYq9eXbCWeSitJX7EZz+G4
 aeJAVBMQYFstvYwd7M6P3bHk1vkr9kUiXskPUm1B8La+ih/h/wYKuiKpiiQacBI85TcDALnWTwq
 P7wvLSpDuPfIf/20vnfKTjFdCSFosM5uyffedx4awz5ICnywF32PgEv5UXe2y0vCCfHiCQdtKK9
 L+9WIV4DqdytF5iBdUA31qgbOOJm21SkZmVoC0VwGTvJv8hiUKnoCj76zCZB39xbP84j/B1asxD
 ZW9NMv1ca3kqlybjfTGhPHhMoKnCzQwem1ioOf5tFvniCicE8UZdeLBV2W7Ep4Cw=
X-Google-Smtp-Source: AGHT+IEJ/DA0gszHKLCuVzO1gkrjGhLss/UI0MlHrp3gdnZ7PLQTbXyu9zIREV5u3cOKq9Y9DWPV4g==
X-Received: by 2002:a05:6820:992:b0:619:950f:2413 with SMTP id
 006d021491bc7-619950f26a5mr1588553eaf.2.1754176025951; 
 Sat, 02 Aug 2025 16:07:05 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 33/95] linux-user/mips: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:57 +1000
Message-ID: <20250802230459.412251-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Note that init_thread had set cp0_status in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because mips_cpu_reset_hold initializes CP0_Status properly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c       |  8 +-------
 linux-user/mips/cpu_loop.c | 16 ++++++----------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0feccfbe91..ac96755b06 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -581,13 +581,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->cp0_status = 2 << CP0St_KSU;
-    regs->cp0_epc = infop->entry;
-    regs->regs[29] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 6405806eb0..e67b8a2e46 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -211,12 +211,9 @@ done_syscall:
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
     struct mode_req {
         bool single;
@@ -245,12 +242,11 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 
     struct mode_req prog_req;
     struct mode_req interp_req;
+    target_ulong entry = info->entry;
 
-    for(i = 0; i < 32; i++) {
-        env->active_tc.gpr[i] = regs->regs[i];
-    }
-    env->active_tc.PC = regs->cp0_epc & ~(target_ulong)1;
-    if (regs->cp0_epc & 1) {
+    env->active_tc.gpr[29] = info->start_stack;
+    env->active_tc.PC = entry & ~(target_ulong)1;
+    if (entry & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     }
 
-- 
2.43.0


