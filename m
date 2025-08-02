Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F898C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJf-0004Ui-0e; Sat, 02 Aug 2025 19:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJb-0004BT-49
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:59 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJZ-0001Cb-H2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:58 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741b1657dd8so47745a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176016; x=1754780816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyAgW55H5bM3qji66ZgE4qa6mv5NgUjvr6IxHop/cLg=;
 b=RONogJmqcAUKpw0b+ueGlMrgybAidaZpTZj9dX4UazlxSOXeZblrGhc98nCYiD560X
 hAhtMD0gU41MEiYGBrchzv9Y7shRwYG1eBRof/kzMLXcAorqc4TAw7FHcvxzSL2B0jTP
 8E72zecYIcMQyZ3F4ZufsC83bnyPAeFwYQg1IXEpYTMtPlhxBnrlkQ3Xu9tqQ/+9VOJc
 T90vXzC6l8YrHavOpj0fLC4XHjw8PNAKoP54JgVtc7hfW5aPORXHKB0TZNF9K8X/Jnx3
 XPW16jpQkYfuNxaRzjVdYGIMl8e+minBZyZPG75+IwYu+VnSlWpPAsZS3fKcQg9F6LY6
 LGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176016; x=1754780816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyAgW55H5bM3qji66ZgE4qa6mv5NgUjvr6IxHop/cLg=;
 b=MONRILOZw0bso+GHtAZiP2Yp9osc84cHxDHZkb5gBOQpIenu54j6s69+d+ixDkLhC7
 dQ5F9D7ua2JLhYxHzCSxdj51tA+VHqMoI62XHKxwovmU/aLn2bdFsNC7QraWaNCV+BZN
 bRBNvQhylMwX8avYOY3JOwc1TfqygtQg/nutE7LV124EoGAdypPFUUOd0+TXM7nH5Wft
 8BKmGgp1bPYznPsS5/Q2ZOI3Tp934Ghve1Td9a1UyURxOiGQ18MD5eWHMyrOUKjeUUvR
 ImePvcFKe2Q4filu4JYKoj5f8j+3acpSe/lLqv/NJAdjW34uVnY02qNNfqmjfgGfmyom
 VHfw==
X-Gm-Message-State: AOJu0Yz7swBckXLuWDwYsaORHb0y87h/K+SO/lF5OhgyhJS06D3HORzD
 5mCRwNsfsYNnjzcPrXFngGobK7BXqIkmh7Xw34hEovjNkqst/SACJsEjZje5S+GQ88fz84tThCX
 bXgFndyc=
X-Gm-Gg: ASbGncsj24E+QkZo7yOYClJqj9B+RipN/C9q2HQu611/i19AR06b8Dup4zrfsFIXyKt
 iVfrMWQzw/K2Vumc9eejdCn+qgo7B6Eo0fnmL++YMOiDzs+fD79SHkrLt/JhOtzAAWNcBHou1FZ
 sT40SwDuZOQmaH/aAe/ImjiQs3lQXAQ0Hk5JmL7Hemageh3ahOOcZKLsqVv4UKiXvpOV4a+wget
 4MWVvYgv3XWlzH0hPHdMtWjAdwWQ5Phv9HPhP1VPuA9a/Bi91dlGJVJU67XIpxQeS0fox+lzXpb
 J/E9BLJrv8eWzKPJgOp+ZPdQXpnZ7A6Vi+nN4TFpIGzqOPqxZtMeX/EpJqiol6I16O+yNQx4QIH
 9Lky9lSRnwJDf6xk7EciodMA6pMho0lPVywhh8loflMGjVZmoat+u26hOStw7Z+9cUYuk8yitwg
 ==
X-Google-Smtp-Source: AGHT+IGZKLSRRnorRKOSOgKsPk4zPYH7/3/jyZDKW/kwyAMpEz3f0+M+rvDNgmkQ1GmNTuFI8tQrSA==
X-Received: by 2002:a05:6820:4de5:b0:615:b1e4:62e3 with SMTP id
 006d021491bc7-6198ef7b403mr2439837eaf.0.1754176016379; 
 Sat, 02 Aug 2025 16:06:56 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 30/95] linux-user/sparc: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:54 +1000
Message-ID: <20250802230459.412251-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
 linux-user/elfload.c        | 12 ++----------
 linux-user/sparc/cpu_loop.c | 16 +++++++---------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f93afbdcea..887a3a1cb2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -438,16 +438,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Note that target_cpu_copy_regs does not read psr/tstate. */
-    regs->pc = infop->entry;
-    regs->npc = regs->pc + 4;
-    regs->y = 0;
-    regs->u_regs[14] = (infop->start_stack - 16 * sizeof(abi_ulong)
-                        - TARGET_STACK_BIAS);
-}
+#define HAVE_INIT_MAIN_THREAD
+
 #endif /* TARGET_SPARC */
 
 #ifdef TARGET_PPC
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 68f1e8ecd4..7d30cd1ff2 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -357,14 +357,12 @@ void cpu_loop (CPUSPARCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    env->pc = regs->pc;
-    env->npc = regs->npc;
-    env->y = regs->y;
-    for(i = 0; i < 8; i++)
-        env->gregs[i] = regs->u_regs[i];
-    for(i = 0; i < 8; i++)
-        env->regwptr[i] = regs->u_regs[i + 8];
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->npc = env->pc + 4;
+    env->regwptr[WREG_SP] = (info->start_stack - 16 * sizeof(abi_ulong)
+                             - TARGET_STACK_BIAS);
 }
-- 
2.43.0


