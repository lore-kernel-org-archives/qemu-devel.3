Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D131EC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNZ-0008Nw-G7; Sat, 02 Aug 2025 19:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNM-00085L-0q
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:54 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNK-0001di-D9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:51 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-306e88f0b0aso891873fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176248; x=1754781048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrimBB+faaHzZ0a+sOK+yKBp8vwT8/efwhqeBA5wVfA=;
 b=VoXaAbixrlrqIsplJ0Bc1JKMfIRVJR+Kv84vg5x+IWTdElFUo2cSnBWx867U+QGNJD
 ApN34LW4156hzxJsMsS6KtlKU8Tj/keLRs9e3gJKpigtcH/rOm9TKCINdoqnQJMJYc/+
 C8XOXBeH/IDkoCzwuF7kSMkVHO9b3hlTnvxjxsmI6dSsWRRZgyD6iPGXn/mFv2ReZCVn
 EBk6JF18Rd9R8tKy0uEj35YXGwPbCvuJiUZBdin16cVsoi8o8QQeNkxmc64q1whFWHRd
 u+vwhbAFWzIZI8zKU8gBBb6xjENtYktIslTSxCpqhoKJmizx3RXmAIlla2epM3pBQczT
 ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176248; x=1754781048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrimBB+faaHzZ0a+sOK+yKBp8vwT8/efwhqeBA5wVfA=;
 b=pCRLNHVHlxbf5R8BHURLgjW16m17e+tylrGK/+OLrzD8NnwaHHlXiAWvMtAAZDMKYN
 pO+EYdqolU3jzM1nvlPirpTOc9XBS4agGSiCI/QJHyrEvB0rED3ATBvwoojXUbJ1qfxV
 W/F9JxWpJaQw6rZKicz1P+bGHufFDi2gMIX6dF5rSrqNRwMISC4SbGR9gbgcS81vkZzt
 /OZYYsj/Kb3o4vYXRB4smJ/AuO//YLF7iCKaYvqSXfQbdJbt8DHkh7QT0w3C6fsMJu58
 HwiDSWrD2wtQt9lszuqQCwDGYM3kHI2QrovX32YQxe7eO9uWeSyOjaP8N+Y8JNttTLWT
 2eBA==
X-Gm-Message-State: AOJu0YxLRIz9Kg/b8uI5y3sp73uNuFLhMuiaOF429MVgQPSJD2kFhWRM
 77YjOrDXNihzOWACIHcPy4Atv4/ll2e6mxg5WJ2hihBHqEJ+urF7nvuGMHCTj0z4lVx3s1l6oX4
 f4uHhpDw=
X-Gm-Gg: ASbGncs63Apn+OmZN4IVwYgir68Z51OGdx6sqD6wxtzx1oyr3Zxqy9gegYxc7I1MXEs
 JAgu5Yf/C1NcKzoKp2EthpUBUtMRlEhYlEmAbjugFPkPYci64BJlB8oqxO54n8uDEcHvcf+/sh6
 PLVUCpt2Uim0VNBP3kMuEX0biNjr+nMsQ+BM0nT0qAVtr88njBj5XbRjcOsJMbcqjn8pgQ4WAgb
 W65MO/HQhhUD+vnBBfJPpNxTGBfohD0wrwP4R6dm/wK/k7+bZVrOWavg/XHtBsccmbKXAidEBsg
 mGDTfanrcwlO6M0sI1AEyMQUe66XG3NYD+vNbtRgCpdwrC7WwLpFajmbPJAgbO1AZw3tmqKRisw
 AtDfK+x6QXCCImwCP9jkUiLX3VZoncNvPH+Bbytcn9cF8OJrOybVW
X-Google-Smtp-Source: AGHT+IHXrL0Nu6una+z3n+HdSAnEMZHdayXxyc4SUELtYSROBXFuUQuf/NJbNLzmYrAhHrKrDdj6/w==
X-Received: by 2002:a05:6820:a082:b0:619:932b:3db9 with SMTP id
 006d021491bc7-619932b3eebmr1419748eaf.3.1754176248524; 
 Sat, 02 Aug 2025 16:10:48 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 43/95] linux-user/hexagon: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:07 +1000
Message-ID: <20250802230459.412251-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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


