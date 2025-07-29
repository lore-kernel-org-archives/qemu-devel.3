Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D53CC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguWe-0004AL-TR; Tue, 29 Jul 2025 20:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFi-00025v-TM
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-00047c-Fv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so4315202b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833658; x=1754438458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjWBhFweWYFvBaauM3J90jCEwpxjj3Dy5yFXWtDGGSg=;
 b=fYfsmvi7MyEimtLpxF+BzGfNuYvAykmPgpg8g0TlLJv82SiEPLxWZYNEAB2nUhvZ3L
 GaUqBXKcPz6KHvWWds3wWB/wf7X3gBFDdG7XgaB7Q/M+XStxH2y6QpXk0otiM8+hi2re
 Fb/s5eq036Nb+/5yYcjfxOJvxao1jvDbYv4C6VkaybTBTHjHQIYby3fo+StNaJ9UPhpq
 FoclHWbt1qy/dmz4N4bkgFJyiWrm6t5NydvxunHgIFfScZab2tEnwH9ycxdMOe39U+Wv
 GXVsbcEYu7TnjAeHmimyPPybF+CWh84v4A5yKQWtFmbyMqbdEuHV6lYL+Dm2ea4VnrZv
 bJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833658; x=1754438458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjWBhFweWYFvBaauM3J90jCEwpxjj3Dy5yFXWtDGGSg=;
 b=NVzSRKpP1Oe3PZiMWqCHGsisa+NrhjzMoQv7vRSLWfa303XZ9+NXUQi19jWDgzlfJi
 TQqgsv7E+L6KwB2mBF5T00DcLcYK1qReJUBktaXcPxhFD5xzVi/ib9kNu0BbCl7yEkr0
 OjfJ1zUFkubwkiPmIoejAUcceHSyOVlzn6Rz39MUY4VD8k6ji1t12zA+0T9+Yx8pRQph
 npfQwh4QCCZ+ktq6W36/TUt9ESR0jQpDL3XLK0Y1kzpRmeeWwt7SjTcQFJsde05XTpYG
 B4Fmw4HP59wZUv7VYhkMt1Oa+iRx69WzLclf0AWi5JWaK4uScJOKf0W/4UV4tQClSFAZ
 lj/A==
X-Gm-Message-State: AOJu0YwXEDaMg6jIpOKIY/PG9ywuFXEzYV+Gl317cVoHKGHLU4urjvpE
 mxY0DSpR+kr4OaloJQQPwkTA2FHeDdlwg+AXnT9NkzYp9J9LNK4kytn2hpA4D+thQ5SHHgEIprY
 Lng9T
X-Gm-Gg: ASbGncuqnzxsL6+01A+KQdF2iK8W5+e48mxsADEkSMu/Sa9xLzh8+m7H9chgAnGd7WR
 8gkJOyHU/Yd2K3c6HnyMl8zXA2qONoHNb4gVGqUmou5nH3Jfz85/L26eh6lBYePuFCT++6bPFRC
 WLcqR+YWxSAcTLQWJyC7OSH07yZzrgfOF3pZwkdTTdLS0hmstREDrW7J/Y8GrBCueZvym6WR6Gr
 zWydZLDL2MDl+o2zWf7DVs+4D0+3RNEc1vym+mY2F5eqPR8OjMFy+HyhM0o3eaF9HiCeTR5UcmL
 n4BbYtu+BNEh37qD7G55xu+79ybTGtKFhgWAioLMXCkHymHtg83FEWW3Ka0KBQ7HLmVPUSjD7Od
 srVonXPHWvwPSGtf+7W1OyYnUGv7y7erQ+k5S8ENkEMQLZz4B+Xp9B+ZY0KOcj7tCI6ELqkFvos
 yh5Mr2l5sDLA==
X-Google-Smtp-Source: AGHT+IHyUFtIZHkIG3O50qrcrbl3cxKkbwkiu7eSVuzb8jNLzwIK8FGqcxemN1UIT21EiJLJHw4OsA==
X-Received: by 2002:a05:6a20:258f:b0:237:d013:8a78 with SMTP id
 adf61e73a8af0-23dc0e99cd2mr1978011637.37.1753833656938; 
 Tue, 29 Jul 2025 17:00:56 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/89] linux-user/alpha: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:07 -1000
Message-ID: <20250730000003.599084-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Note that init_thread had set ps in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because alpha_cpu_initfn initializes flags properly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/cpu_loop.c | 11 ++++-------
 linux-user/elfload.c        |  8 +-------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 80ad536c5f..728b64906d 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -173,13 +173,10 @@ void cpu_loop(CPUAlphaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for(i = 0; i < 28; i++) {
-        env->ir[i] = ((abi_ulong *)regs)[i];
-    }
-    env->ir[IR_SP] = regs->usp;
-    env->pc = regs->pc;
+    env->pc = info->entry;
+    env->ir[IR_SP] = info->start_stack;
 }
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5029d9af9e..67c00f75fd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -792,13 +792,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->ps = 8;
-    regs->usp = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_EXEC_PAGESIZE        8192
 
-- 
2.43.0


