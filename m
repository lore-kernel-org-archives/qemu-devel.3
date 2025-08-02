Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B9C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLK5-0006ad-GS; Sat, 02 Aug 2025 19:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLK2-0006RB-UD
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:26 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLK1-0001Er-CE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:26 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-433f3bc84e0so623193b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176044; x=1754780844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rY2E7Jr8J8yMWkbd0RU0/ukH6+5hs0u0rTGs3Urkec=;
 b=AYzL03KCyKTqzR4ln7E6JAt0Tpld9UkIZh0QVP/ws5ibspfjFsEBfD3owi2ywka5rg
 Pfk7GA7/JqBAYXY6zKFQ65TmapnCj6Nw0jd2TSJDU8wfxKz5h0mogGK5n+ZZ6xd65n26
 y4QTxej3JCZ3Hzp489RwSR0wq9CWBQS3eFBKfrsu5Q3jL+oIg/AfVS4Lo6M0ftv2NuTb
 doM1/emDrlppHyoO8G5pxqZIDY5lAiJD9EvNwOD824A4SbSSeinkXM3Qfd87V+t35S3o
 iDSi8NsIdgbF6BXLbAOVj8SN2vaQFNh9cZ5dE9M8PppjgTFZgG8EYhQ+kYoDwRibebsh
 029g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176044; x=1754780844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rY2E7Jr8J8yMWkbd0RU0/ukH6+5hs0u0rTGs3Urkec=;
 b=styCT5M4Sov5hogmkBIqDiDT5wpfcLtQQ88J18IvBmZa/0gf60nZ7+csBPGbIzI9p1
 5eCyUVL8ORCfCWR9i/3P460SyiXYRUhORmw64ABozEb3tkbaiC6mf1o4yua+tBN/tS3e
 mHjCK7ePyEPd1riLPHF8SZ2XpKE1Fhb25/dLNpAiv8nPQka5QdvKdcD8nr9MQZcxq5OA
 zNAtoQ7U5H1qK908t23E26qlxuOiS0Md3ThdOjiPbUVFcGT2Wirg/BnN4cvCw3QjUXF4
 S5yCWk8j9P55P/qRSgVdjttlhV9GycxPC5SLLrt+/osr+dMMpFPbnzp6cAdEXhYOlxDK
 WCLQ==
X-Gm-Message-State: AOJu0Yw5lIWGutOIGWkXIkShk0mF+1W88TCxwAow7xkIwqaKNfFxAMb/
 Pte/8yhSCm4zLnZVIREeMcjngbBpaEWEWuQgjhs8dh2EvW3a7JdMOZIkN2SbuPByzWjXfI1p3NQ
 o5qhxJd0=
X-Gm-Gg: ASbGncuRigWF4MoPvVXKh2T3fVjIQ/MOvA8zwKBz5UPNDr6CwFtM0Z9eabYddTkp3Fo
 Sr2E8Euskllv8DILK6qEijfEEZK6o5qHBfcHHe6ls7D+LPJlp8gBCAER+x71qtZebdVAKzpkTSo
 WJReQQ8VQKXKbmlmfwZDg8ZRtgQ50TxTcIYiV2FXZrJwD4xT5BnvbcKqZb/qW8MOcm645fAR1Ii
 /Ef4mVdJ6HJMS9ODdkGjhLWpesalPtbGnsE+uwkvFc01kvu3qXEMp5hpe7oNGkOZ8iPjzuqoL7s
 PIrxZZMijU9aRnA07egzonoVRERFPLsNRySM/4FotpTeJ4yN3WVJEb3rztpWe1d9/d7NW2W9gKH
 vMGtapUvAZDkmPcob6D1ILsgBJ20XpjUcs300funk+3/baFww1r3HkwFvgOc+ICs=
X-Google-Smtp-Source: AGHT+IF8ag2VMy8PuOKruV4FjnaEA52SIBbJPMt5oFDFlAfgKCupLphEOF31Q917EfxOX8JhJUuSqg==
X-Received: by 2002:a05:6808:1910:b0:433:ff53:1b7e with SMTP id
 5614622812f47-433ff532639mr816505b6e.11.1754176044037; 
 Sat, 02 Aug 2025 16:07:24 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 38/95] linux-user/alpha: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:02 +1000
Message-ID: <20250802230459.412251-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 46150586af..a7de852d4d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -786,13 +786,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
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


