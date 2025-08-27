Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE35CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWb-00082T-4Z; Wed, 27 Aug 2025 19:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWR-0007vm-Pf
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWO-00059E-Id
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24458272c00so4142305ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337138; x=1756941938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz5VaXvtV93wHMZKr+baduksZM5BuR3kgES/WJ5tu1M=;
 b=tnAvzTCgQF9aBzYdIW/+gMds8inRiwoROImMyX2ak2eRxMiLzW/FPBzD4NtT+vu1Zd
 gRFgabcIk1F1UlrEi8VQ/K6obdfQhJRIrqARASyjmbLffk00ppzkXvwKSOHrXl7KdVSb
 hMjAsk+dyCidmZufBr6CAtUI7YyG0pJ+SjJzRvLfKb5U7aMDTHzJWGHNmvLkrguFgS6J
 y+GxqZiNX4ELFB2H0YP/0epqsd99g8WGPw/LLTnhv2X/8HlVIGpc4ruGY/3AHxLZ3GTA
 omL3P+X2k3v9ih2idtclTVKWygowVXMJoFNnAPEidjYmETwlzfHRg41ihrag2ExQwdCd
 bHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337138; x=1756941938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tz5VaXvtV93wHMZKr+baduksZM5BuR3kgES/WJ5tu1M=;
 b=sVAy9s67ZdJQum55oOKC2xTfW9f0e4/CeO80SoCaEkcaWMSGdf2F3v0N+0BcIIRHpq
 reUc/ktqZ0egDycC48pnQ/zyri7lDoICEYHrktX7RvoC87vaiqv9NQ9uhkCfrkv3Ia9K
 WqdGi2vztrdLGaOE6Zmo1+77JkXwi8LvvynvH/cMBza8BtQySTUkAohTH4JauG1OXki7
 vLsUzNJgPo0H0PwoT+4biQbOjcFhmbnoWXLXAZPt10wUhokqDriyHvQ4g/saNLyl3u15
 utXPL79Npx9BvE9kXtyuuql+qOlXKXBgBMHvyZMQxcRLHzkwQwIf44SzQGhWE93QeqCN
 klMQ==
X-Gm-Message-State: AOJu0YzvbJp0wgtIScDf5cJe40kqxwNznjYc0i7e8noUg/3O50Fha/3n
 G8nqWU+5FYZQqSOkRMdBkuGqYSbyGZPvjwfFEOfIa82z3Z1pMi+3CEiZj4BDsbQapvu1zS9VR+G
 90Bhwheo=
X-Gm-Gg: ASbGncsD3jwdBXvnp8sHTbmFVjXb4nxYkTiLIWjFR8taIJaFQ4sG2Zf2kdRAzjy4lNP
 3PqRo4Dbwca3Ng0sMBiUsVaFc/3MMUjGntkXu2P7hMjAy3Amd88sm9KjHiDooScE9I9EiPZJXvk
 yCVLGFdJgDJnJdBeWwBSjhw6ggec7BbPfQs+BPT7nkyzhhmUDEhpDuYiT41SJSMlGwF9+8mMf3J
 PDanM5Y0NARN/PdT/L41mKeuVNnMtKETikfkkcTPZQ4Ps7go4zEPxb1Zqg5j7VFaCEPsnqkNiI+
 qvrXkLFQQgxoLDhXEnmFVcV2ztrHwK4WrysOOfyHnTeQ13GXkwk+TviKDpG0E6lFwIMXOjK3KDM
 13XSixMAtROOjnRrSEjn5B30NCf59+Z0DUSuw
X-Google-Smtp-Source: AGHT+IHThR34inx67JKrwgXo7eVPcVZ5m53rYbS8EwI5SaJI07l34y3Ml+3irgHlaMadWlU4jyzgBA==
X-Received: by 2002:a17:903:1ac4:b0:240:83af:e2e0 with SMTP id
 d9443c01a7336-2462ef93339mr297747995ad.47.1756337137795; 
 Wed, 27 Aug 2025 16:25:37 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 42/46] linux-user/xtensa: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:19 +1000
Message-ID: <20250827232023.50398-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 linux-user/elfload.c         | 18 +-----------------
 linux-user/xtensa/cpu_loop.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4876e4b0a8..447a9be11d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -905,23 +905,7 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->windowbase = 0;
-    regs->windowstart = 1;
-    regs->areg[1] = infop->start_stack;
-    regs->pc = infop->entry;
-    if (info_is_fdpic(infop)) {
-        regs->areg[4] = infop->loadmap_addr;
-        regs->areg[5] = infop->interpreter_loadmap_addr;
-        if (infop->interpreter_loadmap_addr) {
-            regs->areg[6] = infop->interpreter_pt_dynamic_addr;
-        } else {
-            regs->areg[6] = infop->pt_dynamic_addr;
-        }
-    }
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index c0fcf743e7..43a194fc4a 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -238,12 +238,22 @@ void cpu_loop(CPUXtensaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 0; i < 16; ++i) {
-        env->regs[i] = regs->areg[i];
+    CPUArchState *env = cpu_env(cs);
+
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+    env->regs[1] = info->start_stack;
+    env->pc = info->entry;
+
+    if (info_is_fdpic(info)) {
+        env->regs[4] = info->loadmap_addr;
+        env->regs[5] = info->interpreter_loadmap_addr;
+        if (info->interpreter_loadmap_addr) {
+            env->regs[6] = info->interpreter_pt_dynamic_addr;
+        } else {
+            env->regs[6] = info->pt_dynamic_addr;
+        }
     }
-    env->sregs[WINDOW_START] = regs->windowstart;
-    env->pc = regs->pc;
 }
-- 
2.43.0


