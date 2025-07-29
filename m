Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F6AC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVH-0001b2-OO; Tue, 29 Jul 2025 20:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFk-00026r-Vo
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFi-00048S-Lr
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so6690990b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833661; x=1754438461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S5vNzUUh3jbJHFNtrK88iBk7CBPkMv1LN+8yxo1pnKg=;
 b=Dkkfbc4DdFfk5SN6/PnO+f1fO+VH4Rsm27CEGZBhPzZNC8D9IEFkXu6NA2SZW/+u3x
 9vJ8poCGxjmFCV2pLT7J7YjrpqALV+NzFfBk8VOWYIBb1UQ+0hyVjeQJZCndVrUH6msn
 jL3sd9c6tpTD1FhIN2NlhU6TOr6L4in+bNgnr6KiJFn7pF8CWI7H9JB+4aypEw+Dt2Eg
 L/3ghC8Kmj1nHXNNklctnnzJTNmERqwC/EuqpSW+eNvQVlhKwzJPvwmnwL8kmJpar+NI
 pzvqCipq2GoRGG4B14CyAc41um1sG4tq219CULyw5P+4irajRMYwujBN7CHbUn62wXXO
 eaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833661; x=1754438461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5vNzUUh3jbJHFNtrK88iBk7CBPkMv1LN+8yxo1pnKg=;
 b=efHO48dvX3BJgCIZ0YUBt3SWPiIjnbNzG3mxbhW6FLTouW+DBPlF6xav7tuFu0Ly7n
 sWpx/4zvnwpN3Z7d/LJBAj1YyEEhpgy+aaG7LInWVW3TJ0bTKCsvAtPrnBwlTcCULZvS
 OR0R4zsH0hD6j5YzHujOCPGthovHysqS6a9pLjxcGesAqHHGsrNrHT0uysUbk8ujJYSf
 S4pDdeBdm811ea1yUGh3ShFT8P/lvoan6xPqG6lUh5QjM4UT9pnN54pwk+LlYMeTzfZE
 mWv8fOYrq3/B4nL4ROi6cdnMUEWyhLDBrzWFt9W74//uNGbbyTDy5nN8SFjvGTslof/I
 y8Yg==
X-Gm-Message-State: AOJu0Yz21aBUPZ+FN6qplInZpRGlhrXA2HsYbrcrLKVBvSkGhreBaWwI
 sKHdNeqc0VX+c4Y8Juo2BENi2iam3mX3qn2mkZL2QjvY1QRA9Z1/HgLBO0ZqGmlKiUWQaPGJvqe
 INafq
X-Gm-Gg: ASbGnctXGuqj32NbkCLLWcCjiQhZOyV+rS4X0vKs5g1QxSpWFPK3W8cbTR+j1gZmyA4
 FVZLOpmrc6g9sWGerPdwjPoRi9RNlpjlPXcZEE9hi7ppVaNaNQCOpX+YjP9mUW2rVG4rko7W5U7
 p4m4FJf64k6E5lKgIfVqiHGUW+xc7Jv8OXrt1KHgF4KPZa66Q/PeKQMDDji9MRFcb68BoRU4HtD
 uNsN3FY/+DHJ87rHzoGwvKuNnk9/UYIoVjHOhCv+xVSJP7HOk67bQLbhTRjavAFw2pkpGaqyx/n
 fyHDeFUOVUEvQY2F1/yBNaDoRKQmgFWId1fDSdTRDdSCgAQZhh84a2UAWYJVaDhFCAMG5ADo5A9
 CAD+v2EepSWlxfV9RebFb62mmcd8l/K5+7AOpYhRX4SjpATCemDMpFjWY2RwpQFTiBy+Iw6O6Bx
 4bARipi9MOVw==
X-Google-Smtp-Source: AGHT+IGgR1gkZ/nFiAi3Df0sb+QHLPuOY0Gn+a+wM1z9ID1LCIHEyVo+v9sOeSJgVJaREhCMghK76g==
X-Received: by 2002:a05:6a00:cc4:b0:74c:f1d8:c42a with SMTP id
 d2e1a72fcca58-76ab294703bmr2022730b3a.13.1753833660660; 
 Tue, 29 Jul 2025 17:01:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:01:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/89] linux-user/hppa: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:10 -1000
Message-ID: <20250730000003.599084-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c       | 13 +------------
 linux-user/hppa/cpu_loop.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b1f889193e..48c04f9f33 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -870,18 +870,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #define VDSO_HEADER "vdso.c.inc"
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->iaoq[0] = infop->entry | PRIV_USER;
-    regs->iaoq[1] = regs->iaoq[0] + 4;
-    regs->gr[23] = 0;
-    regs->gr[24] = infop->argv;
-    regs->gr[25] = infop->argc;
-    /* The top-of-stack contains a linkage buffer.  */
-    regs->gr[30] = infop->start_stack + 64;
-    regs->gr[31] = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define LO_COMMPAGE  0
 
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 9abaad5ef8..3af50653bb 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -196,12 +196,16 @@ void cpu_loop(CPUHPPAState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 1; i < 32; i++) {
-        env->gr[i] = regs->gr[i];
-    }
-    env->iaoq_f = regs->iaoq[0];
-    env->iaoq_b = regs->iaoq[1];
+    CPUArchState *env = cpu_env(cs);
+
+    env->iaoq_f = info->entry | PRIV_USER;
+    env->iaoq_b = env->iaoq_f + 4;
+    env->gr[23] = 0;
+    env->gr[24] = info->argv;
+    env->gr[25] = info->argc;
+    /* The top-of-stack contains a linkage buffer.  */
+    env->gr[30] = info->start_stack + 64;
+    env->gr[31] = info->entry;
 }
-- 
2.43.0


