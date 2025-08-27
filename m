Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTF-0005YK-R6; Wed, 27 Aug 2025 19:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT7-0004qz-Rw
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT5-0004Nv-Sp
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso394503b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336932; x=1756941732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rY2E7Jr8J8yMWkbd0RU0/ukH6+5hs0u0rTGs3Urkec=;
 b=FB9tAI1TLVnHWjLr0BfJ2jq/OGRiwDFvslqq7W9+KCv8IkLQXqJnjj7Y8AZ319CC1a
 TlqF8kZx1lsJGVlv/KLMi2L4zJVAL8JS9yQfLZholjksplT8GshQKziaZQzSrQjkoBbK
 ti0HABvF9vPTNQyZtYPYC2FGnO8glzCaJN7oPiOWZla22+v93ekHyYuD06EA25ATyLk+
 yVOfTXxwewFfrRdfsl0Hjz7fF/gisV7T5X9/Z0GQFouXI11liRxCCOr3KwoPtO4qfKwn
 E87/TDdYuWe54USQ99IQTqO2Xem3WhmPCv6sjl86r3QzzTMIQ7rl3gmZe8UN3aE7xKMz
 BV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336932; x=1756941732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rY2E7Jr8J8yMWkbd0RU0/ukH6+5hs0u0rTGs3Urkec=;
 b=mzH9BIl6QK0csbNNtwG69mIS+Pp6GD+o3vBNqWT7DIOmcuacyMBBr2azIDftaBx7p/
 qr6Y0aKLVLYsMkVjOmc/PfT0c9p/7S4GdyfC1PcYPXdpNw8mhKLtaw5uDIDqKiqTSHKn
 FHnE3mo90LOQBnYr8/JNJVk61GBZjrw9zrFNpQLt1Da4FBUufxq/I2KhokuhBMYWGCkt
 oKGFB+fIqTIQwSoFfsB01M8DYFdgczPwEbFYCCcIYqAYU/2h0guiVgfpnc59fObLBhMc
 uRxug63Bah3k5SewMPkbgk1Fln71syXnd1XrbWQa35UAlgRg9FZMAoz/s2wAOhWbfrMf
 3JUg==
X-Gm-Message-State: AOJu0YwZZHaXSOjAzFPQNUaZDVsJq7dlsJ6zPLLi3vX35lJ+nO96ImCr
 Lowg7FDaKWtpoolWs4xRIzx4nE/AOpb1/qPVMksyMekajXfIZvOIgt9DIF+76Cg8R238wiQ0tFk
 +NFuA4AY=
X-Gm-Gg: ASbGncvU08XLWYyKPMrubpisK+dz98Bycih3Wv+2+Y5ooDI4bQT+mTxIb1o/CWvMr1e
 7us8tghClokGR8Pb3dMRBLKCtR2O21CNT7Cj9qs/Os9KYs50POB2F8ZMuxxDP7X0j5D9INdf7OO
 cn2Y7jW9t2WSGk+mbg62NshfXxqxIiNp+hlt8htHgN+iL9M/LJaPVT87YzjtKYPRqG2bwI7XLDa
 8m6zJ5Z2O6XU4Chbycbg4QSwELQbQPFKqoIwQblyBp0iB9qq6ubRnOJjcBT4XTRTdBy7bq6eqmw
 XD78c2WDc2A17ievY5OhfNCxnPCnKV9S3WdAvRNolCIGOiWZ6CvQB4HKoBTncfNfDd1VUlXH737
 eCtWU/dkdnSGH4c4KaMTfJmwizdQCRxUNvGIH
X-Google-Smtp-Source: AGHT+IER7pHI11tA4+QQ85S78/vK/lnRXOaTm1OeawnT3eJabWxzR2FWKnebrT/IR/bhFs/X7Rtf+g==
X-Received: by 2002:a05:6a00:3d0a:b0:770:48d1:e7b7 with SMTP id
 d2e1a72fcca58-77048d235c8mr16743584b3a.30.1756336931984; 
 Wed, 27 Aug 2025 16:22:11 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 38/46] linux-user/alpha: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:15 +1000
Message-ID: <20250827232023.50398-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


