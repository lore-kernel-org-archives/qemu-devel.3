Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B348BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWl-0008OE-CV; Wed, 27 Aug 2025 19:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWZ-000833-JN
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:53 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWR-00059r-3f
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4bafe2e538so400318a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337141; x=1756941941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrimBB+faaHzZ0a+sOK+yKBp8vwT8/efwhqeBA5wVfA=;
 b=To0lgDyFoMbk5iyZ8L1xu7N0DU+ttdp0MxI/Xp4setyuklZGRMnfxQQix76RQQEDqK
 kc5V1B8lu33XGBfARib7VqXhQCS5Z3urQ02gN5fTIhVIm5oY4+7liu2iLfTtnXqtqUti
 Qwb3ZIxKjx4g+0cNZitOZrqrt5aeBB+N7OQoGMFKZv2Q3VghuZh1RzRwXX4Wg+6yrp4v
 cILNAKiziRFtmQzUZmDJTtkHJDMHdrLkAZo4eqet4EGIF1BltNN2lmYZ4BVnZ4ErE6I0
 K0g++AsFcfmUKjZtpQPIU7CNeZ/cRsp5YkNTAMoKnU9gZ+P0C4b2WAcoNhVLY4hiX9fW
 1tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337141; x=1756941941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrimBB+faaHzZ0a+sOK+yKBp8vwT8/efwhqeBA5wVfA=;
 b=QXULzTlfF7VgEEp2a6swNzhSERqeuH7NYVi4yHvoXVt89VOqQMrxytclZ9VaoKfUEz
 81YSkNdj9qiXlcvL4GlOxLSiXl9/eFKWHkTkZo2amUmlseFFQoejj0VEkn8IkwYn/9Kx
 ObYVYisRQZDQ2rLKLjIbF9M0aDay1CgrVCWXgKOXXI30z7iYe7Jq4AJzwyoHvP8iYbIq
 D1s5zltXU/dtVhMsaKkBz/wJ6Z3VQvj410h6tvTGUP0QdNVicle+3ikwu0oIAB62AIXJ
 Hq4KFm9jRUZC+mBjtLWYC70eI7l7rMh9Lx3LvVHHP81cAtzGilb7Ey2VO+3PSSqRSxzI
 IXUw==
X-Gm-Message-State: AOJu0YxNoG04wVNYrK0xO0bIZBAJggbJU+RRjqun7A9usFhmCRmnrEZg
 ZoXoJuclR3X7h50bytgBqh0GtTLSWUbDJ8Oc2hfue0DUr7RVhyp/ggkt1uiEHfPXa7CqZ7cGfip
 O/VwwEuw=
X-Gm-Gg: ASbGnctfzn/Uj/F5iRUSZkDpgamhJq/6F/6M8pSmOsXmS9350blP3mq8lYXXSSuIbad
 4/UAE4nK8942X7x5sF6lTUZcoD9ODkSSdwH883Yhc7zTpiwkNVSR0LrIik6HQZBVAMPWpmhKZU/
 3sl2cV0NdiTb3tiCsbA/+UXS/LEegy6NdAvq/HMRZRJZYhLoxRP7Q/bm81KIYLF5928AUeYRxAH
 Sg3sLtd3NEsgcbXcMZNupWwS363xMbeJ4Se0FKlNgNt9/6ira13LeswLjbz0IjHptWqIU6g8qdc
 IfKkirMe3h7tK6IxqeTPBzXkvyOgRuGKgjFTi4UsV0UpSJD5EOUqZ49SllkeW/dtog1xs8KZNBr
 8Le8Ff/mSuO5sk9GDMeBen0Gm9dhx8Gu5qUHH
X-Google-Smtp-Source: AGHT+IFOVMMuJQvlgmeAhO0VZl/4+ImoXW5bKxlXve4JjJ5vFqUOh6m4gBPq1qkVSHJ+oPg2hrsh/Q==
X-Received: by 2002:a17:903:240c:b0:246:cb50:f42f with SMTP id
 d9443c01a7336-246cb50fe74mr209732285ad.19.1756337141273; 
 Wed, 27 Aug 2025 16:25:41 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 43/46] linux-user/hexagon: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:20 +1000
Message-ID: <20250827232023.50398-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 linux-user/elfload.c          | 7 +------
 linux-user/hexagon/cpu_loop.c | 8 +++++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 447a9be11d..4417c2d99a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -954,12 +954,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->sepc = infop->entry;
-    regs->sp = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #endif /* TARGET_HEXAGON */
 
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index e18a0183b5..25c97edcae 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -79,9 +79,11 @@ void cpu_loop(CPUHexagonState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->gpr[HEX_REG_PC] = regs->sepc;
-    env->gpr[HEX_REG_SP] = regs->sp;
+    CPUArchState *env = cpu_env(cs);
+
+    env->gpr[HEX_REG_PC] = info->entry;
+    env->gpr[HEX_REG_SP] = info->start_stack;
     env->gpr[HEX_REG_USR] = 0x56000;
 }
-- 
2.43.0


