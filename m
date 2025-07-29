Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D67C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguSu-0003w6-69; Tue, 29 Jul 2025 20:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFi-00025x-UO
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFf-00047E-7k
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so4315183b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833656; x=1754438456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6jlVWxS+ZhFPo9Sa2YXKd3yawYMa+CEulszKyl5Ioz4=;
 b=jhMljPEr3oWJNKviKmQO6Bvj6Q8f//R+q7N3VFUiY/P6xgQP4DiwtCrxf4pNgHYYtI
 5yRc819GYSzwRuI62KVmFC+Vem6UTSP4hp/I4sielLVhioDaOCWpiQ2iCeQQMe7JuX1N
 lxqPtB1csEXabd96y0rQ5bYho9ZcGsEgmqRF9vjzPbIYX1EYBujgsINBJwrAEJGJ6blr
 S7ANVRat9Jpbwmazm35Xxn7c/tVD16GLkhSUKC3p/+WOxUbNz/6suo6JOkimIGh3tA39
 u9Y6Lraqpq3uSjei0OjgfYQhl2XRORZ/MXg3OFeuUoKdwV+dbqRYwNuNZd9d8+FxN2+f
 1JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833656; x=1754438456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jlVWxS+ZhFPo9Sa2YXKd3yawYMa+CEulszKyl5Ioz4=;
 b=by+Oa0EYD5vEA/Qo+XDC4VGYVOrJRdLJBB8c7LFhyrYeHh1DR+FspWgh7UJKzEHH66
 jeBP5fHTlsvFTUicnZlh0PIbWPG+1RmvZ7ONjhwfw2qUW2+oa95lkF4Fn3FdxhcT+5ho
 TkSHiEQtiQnKUnMEhkf5qpiMJD+N2Nwn8GkGCQYexX0ufDVV3dOIhvw7TfV0kClytdkp
 DTnUcuulSLEn6CFZODW5KA5k/dKgw7mip7Uk5mUGgHpVtxZ/GFE5JfoyD53+mmc/MRr/
 TzvziodUqmCuWEl/hEbpICTru0HLMAj8lZByPMD2sao7jusJaJZPOtq6iMY3e26Y06Vf
 xo/Q==
X-Gm-Message-State: AOJu0YwwxL6qxf0As8czWcQq63fzBk2w5Sa1yXX+D+UFhw3ecSCHCx5y
 tOCNgWhKQdsZ9mr0hm7+YO27Hva27KvUp6lRFY6E8/mos44T+RDv7FhGzTW4OCF3FPWu80XbdkB
 jc5Cy
X-Gm-Gg: ASbGncuklkfyZtWT0uTwplDmxUCioZq/jO+vq56DqB6eqV8BQfqYeLe6rH+7dlOYkRA
 UCFW5b89Km0IXPn1XBEeUUZ3ZRPGhV4KVdIfgbRvo7w1zvo0fpsCYiO10scRRyYN2DRu+XhCVxD
 zFkDm8Nt0BDV8nX/fMpVj3GNUiA3yg5pG+Tp/szF8psNEle8W0GRGB5oISVBcW4pZ4xoZzmK8bq
 8kBs7VLeMucP85xTnoqAxgEFstd6qwI6+PRV2+uyA26EnvsouLFIEXCepqAlrBm0yqjJRFdQNrH
 6cn2fV4NC8pJCzuQc63lMPTlHJZ/D6d/AbZv382vQ0rkxWc6hDW3G9DrMt/gy/vPvuUfMx0OmT5
 2KgcoP0SojoBJAMFGsDxuKCzAG/gJU7B5EM+yW5mjKJLdYWZFF/KGYHOtmeyUCDsgMK1O2Q74Ro
 Uqcs187mD5ng==
X-Google-Smtp-Source: AGHT+IEZIIjuK3Zx/hAJM89SOO0nlOit91hvobr+senhb+6q5YRk2dlQT9Zr69khUrNhrCBpf8iyKg==
X-Received: by 2002:a05:6a20:939f:b0:232:6809:d41a with SMTP id
 adf61e73a8af0-23dc0d457ecmr1966467637.14.1753833655567; 
 Tue, 29 Jul 2025 17:00:55 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/89] linux-user/m68k: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:06 -1000
Message-ID: <20250730000003.599084-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 linux-user/elfload.c       | 11 +----------
 linux-user/m68k/cpu_loop.c | 25 ++++++-------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a0bddce3cf..5029d9af9e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -752,16 +752,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
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


