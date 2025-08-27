Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPT7-0004jX-BS; Wed, 27 Aug 2025 19:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSx-0004V7-1U
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSn-0004Jp-3h
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-771e1e64fbbso476822b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336915; x=1756941715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyAgW55H5bM3qji66ZgE4qa6mv5NgUjvr6IxHop/cLg=;
 b=aosxZishaY5Y/WKVQlYLTuIVleiyA2ipyItnvBVDH8a0xBSw1BPknnIITXVgxbxA4T
 zDtObPUygpP53qFXISOsVTfPXO4QdRqE8RDzxp+Z8NErvaztsRiET27doQbksDptNuWg
 XfZhuySRCfffcgWM6qtZ1GeXxE4Ii6xp12temJeI+X8PEfbePAltNeQD7vlL5awLLC1g
 0fzc8dNFxo+lDfhB5xeEqD9366yDaPao2BwCtT6Pd+4zETNSlI+orDnknUs+Ly6SwHuj
 FEeXNHars+lVTbZRcrq5aLa596o+3Z/6XRYMvcSclgkdGTs0jjV/E9Hzz8b2FfmPoky/
 Wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336915; x=1756941715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyAgW55H5bM3qji66ZgE4qa6mv5NgUjvr6IxHop/cLg=;
 b=GSxw4Bt0Aoq0v8q8Ooo9ur7pL+TYna+IIIxsZaj9FXRibJ9n/YYn8UhV6EO20JRhCi
 fNOPZ9QpN50ZHQfhzICld6Chs2SNSpjIZChjyZo7bR12/P2BZON+6pUUskPLG3wHKzAB
 aUeNntg76y6VHRL+h9iJ5bm7+fLwHNNTHZ2Pf2RzImX336i0gpaY9HfQsxF+ZxoUe/7X
 qsPC0tI6rgsbi3xSEtvoVlQtK1Sj8pxIhUgsXd1rSQN1nvYADEDSOwBeIYalQ9NWtuXC
 0FQvD0j6fC2GOLNxrt08ND/EA6smjOxele6978jFu3+GzQRULikNkUDPwDJ/6ZtfNt+w
 HptA==
X-Gm-Message-State: AOJu0YzDDllsZbs7z1Dnv7UGomZw8zkBo3IxYbd76mM4bkjy4Klg5cCy
 WQ4MEUKBxgeIIWHDwoD1CzTbGOjnVM+ULIbmZC3reMrHuUo1zyrbIiY+oXP7VvXuHPGT787h32p
 Dh9U/2hw=
X-Gm-Gg: ASbGncvET6MWRdEosw7jiDUie3i4+heQhLpurmukzvEOlJD365NRBkXubFlBLIEmpLd
 pcvUHyLa2qO7aJO8CUgbiI8irnW633SbAhvqyzftasPho3bKADF7xPYDDcOB2Pvr+eNki1T83m7
 +S1+dUI8cTMxa8m1vBLHpChTQs7FjGKpriiKMnxk0vIzuIQGg3+kzpBJUGnSWX1U2+i8BmcgQn8
 v/ntaO7FgTf1TMCL/BHAezajMZ4vDe7KQ+NR9Dt/UzEWWMW7XwWgQjPatR4+KzOMXC0cRIP9eZZ
 oNOPtuyoG2bliFlv/sUqqaDqglpluHIkCH5fY6ar9sjNx6/09ifv3XJJ77Rd/U7+9mKCXBml229
 +BEV7TMACPT1HHf2Hy5lh9BPzuQ==
X-Google-Smtp-Source: AGHT+IFRSQZw6V7T96ih+2XYzwN2TGFSaPUnY2eNztmNLsodCeyz/eVhE4JqoaMfG7jmKakUlnvofQ==
X-Received: by 2002:a05:6a00:244e:b0:771:ef50:34c with SMTP id
 d2e1a72fcca58-771ef500a1cmr13713778b3a.24.1756336914783; 
 Wed, 27 Aug 2025 16:21:54 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/46] linux-user/sparc: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:07 +1000
Message-ID: <20250827232023.50398-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


