Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E2C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguUT-00081F-R1; Tue, 29 Jul 2025 20:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-000254-T2
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFc-000473-MU
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5931363b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833654; x=1754438454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVfoUl/DKTfI+MiMVfZ/07akR6c7S9lrM90yKBf7ElU=;
 b=Dv2iz6wl34KN2i/4zJY5JhRjCZ8JPXKx+Oieg134FxnijII6bihOCKKUWJdqBacKwX
 OLt6LjzfBMkpnJ/ft+Uv42pEhOYBfjYiY6GJba7V6nSoNHjK0KsC/nuAtYD4fNztro0s
 eOUVE71+qs/4fkQNk2itP3x4KIR2zheujN0lHisd7+3/FnGKVjYEUudRDBJJilL2hzDv
 Oexc7PoZ6uk1wQisfeH9Jpbtu6YsXFtapSHQZCj5CJqRRxPtaJVX0OiHBV4VyeGYwBN3
 rRzjTScl0SMHuzqEdkYzKojgAwOyq2TIi8guBNO54ki56UXagoJrnyl4q75mC7F0kNyU
 MwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833654; x=1754438454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVfoUl/DKTfI+MiMVfZ/07akR6c7S9lrM90yKBf7ElU=;
 b=sokttJZ6o7jzWGdyrJeeCz3xHzNt9CrW7vfK8BCeRelE4xa9Uf5QTm4UsbjSMDWeL7
 jTDOzlsm3cgudzbOCpL3TLpqPK/bdMyB4BFEh2gOW3YAdDjdHEvghZF5LPSkc7rR1Id9
 a5W+Jk3ZMhzcuke8kHj7r/pldbz8+3Y1q1h4ghFTWAVGzRlcj8j+ZwAlg7C9hyalE24p
 djK9/A8N6YNXiGe2bdzQbro58PJ5Xfw2C92U7tinXjg47H10/vHwxm8NNM0sbVFOwLhF
 MDx9b4hRnjOvXtoofNVvITZvpv9yeLlgtO9vhNOK+IH8phtDxn7BYcV6jPX+3t4M6x05
 ruAg==
X-Gm-Message-State: AOJu0YwATpXlwD2L8poc6ZjLHsAznWI2qM1+1tGqaDbBni3474beXZdN
 9FcgxNq3YrQhcaJMsh5U0WH49zp4u2YptojF/6mTmYSQrGaytyGUgM7CrNDuDXYHDzU0QuX+6k4
 lwHSu
X-Gm-Gg: ASbGncvKfZVCoE9OB6fSKvxWFMTwBrMPvWKS6GLgMNzuQ6hixxIsCG3YcqcCLZYVAp1
 Rj7NVts0GtiJ52MsksbgsOFsnlVvL0NsSIr2B0vZET9ov6k4h3nZB9vvUM+VeYOEenEev/w6Rl3
 PXHrMHSq0fsdAGn1YVJhLWthRGyej5e1oebOyWOrLvg72E6y5g8ORYi6eHFLKUB++vJsPaxosw9
 5P5LuTmXrlF16qpXG2Dz4a6m/2xxrtpYenXVJ191DS710SHNQr1ZsdJSUIbPaXRbeTRJnhOoOpy
 E0+cMcli3huaiC1ejFuHyTf7xbMBaCXF6wQcaQGwKkRbKKDMBP6/dbnvA45032Dhf+gdqnMIfcX
 aAc6lM+qcw04W9s5yrLAXVCHw4ED9Ub9vfRzsGOYPK5qjm4gIKWf9QO5caiOv/59fZ6Me2QMw2y
 GPhnvV3Hj+vw==
X-Google-Smtp-Source: AGHT+IEmLtYxE9Rcd/8fe8lvNksH+hMFyoK40GU6i0Darpnzhz/G90zSb7I+XU+ldvGwPz/ET4iYGA==
X-Received: by 2002:a05:6a00:2d14:b0:742:a77b:8bc with SMTP id
 d2e1a72fcca58-76ab092314bmr1841944b3a.2.1753833654337; 
 Tue, 29 Jul 2025 17:00:54 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/89] linux-user/sh4: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:05 -1000
Message-ID: <20250730000003.599084-33-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      |  8 +-------
 linux-user/sh4/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 808f9f9ad0..a0bddce3cf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -707,13 +707,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Check other registers XXXXX */
-    regs->pc = infop->entry;
-    regs->regs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee9eff3428..259ea1cc8b 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,12 +81,10 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for(i = 0; i < 16; i++) {
-        env->gregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
+    env->pc = info->entry;
+    env->gregs[15] = info->start_stack;
 }
-- 
2.43.0


