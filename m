Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584DECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWW-0007vj-MD; Wed, 27 Aug 2025 19:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWO-0007lk-Fk
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWL-00058o-6T
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b49d98691faso313701a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337135; x=1756941935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcKY3nbqGoTt331KVt3AQH8Upmaeqmua001Bsshfz4I=;
 b=AE3U/E/wuSpn4F3bQcFkJO9nWklQubn4YbrcCGSfF1iVqYB3BaH3S9eU9Pq4AGVw7m
 58T/pveFR+a1jTs1ogxFxOTxACDWxPzWJBwrZneuzDO3439JiwdoqLkCPlu+BdZgsg1F
 FS3hMvrUU2IHBuNeEfZuh1Wrz4lJkwOS+QR5ArSt59Umzc0CT//+Vx2sWN02TpFt5Hv0
 yko2TjuC9FA7pLpVRAnqY5gWkxZal4sgMseV7QrjKzPeeTFtvAvWNQbJcQVeVXeVC7lF
 0L6Ew6QB750mXqsK6Ul2lcYVjVwjHSxRkVAa4EsonxGhB/iMcW1E4Jr3312ZLjH9Vi/A
 1+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337135; x=1756941935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcKY3nbqGoTt331KVt3AQH8Upmaeqmua001Bsshfz4I=;
 b=gbvCdLZaVZrrdIlFooMi6rWefjDlFatgnZHdobjw4VI3WfgfqBjjBy82jpJiFxJ5SU
 yCw17NQYc9uTP3viiRZbvCcsZPGBUislIE0xsOXF5pLM2Zfe34GhOnRxGWPS1nMGXjLt
 8uNcW2OiBHwWTxXKbDixkkk7Vfzc7guDvfTznxUCt4nx7p8MY9hBopbTti1h5oTdWjR2
 oqJ9xHPvmsfmFmvB4Dmf7zXXnwsfej1w0WPrcyBZTdCDyqrX9nj7HiSB63v++k6QBK4p
 GuVRDshyE6G3ihL2Yx/sBDTp+jU7iVaifWJNmcQUmiLWYpNVjHWZ03FSom9kHbMgMAeg
 buNQ==
X-Gm-Message-State: AOJu0YxN12kA58AnIZnc3bOZfhAsChk7er2B26nTOGzOjuOri8tw9e6L
 I6wwBoVnhfM70XbxBZQuMrbApdB+WqZpbqhns+OhvTMTVYABthcC7nB8VLtfaayzI7+rMrlSgmC
 QfVCHxh8=
X-Gm-Gg: ASbGnctN9qbWwJuxOzgzYXa37V7MtrNm/ULsmVhGxMnJL8RnQbpsOq+wAKavFGtv93K
 FKT/2VCsn0lARY1Bzw3BjWN20xmQ1nNcnBye0pLf5hscL4CoujXQajLSJy7oOqeyy/hwqHgdqhP
 NXq5rkS3gLsncNYKJ3PlSPpdC4aj9avgm0vsaGPG7/U8RTp/QOoR6rubDEaUB1Tq7rwPfy30/6n
 pCAGgNp6Q5nGtkzEb3WGZb+B9M/Gs3duaTuQcIGi8pS4nMxvQFVht98XV03JW9xs9WZjG6H7dl5
 g7RqCWRfEmQhhl7Ff3SpPZh+EUsjiCMT16YIF2JPj+rFuXbsuuVWfewi84jklXUBL6REJC4UZOL
 E8hG4NPmeEBHVoLIsb581tkBmcg==
X-Google-Smtp-Source: AGHT+IGWW6Y6s5DROvpMGSxgL5+zVxyVvXLayJdTZF+qAfP+SXgwgidwsX+6/334SPci9GKr/dnB1A==
X-Received: by 2002:a17:902:ef06:b0:244:9c27:9829 with SMTP id
 d9443c01a7336-2462ee0c6edmr246079665ad.10.1756337134843; 
 Wed, 27 Aug 2025 16:25:34 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 41/46] linux-user/hppa: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:18 +1000
Message-ID: <20250827232023.50398-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 linux-user/elfload.c       | 13 +------------
 linux-user/hppa/cpu_loop.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 556f11d720..4876e4b0a8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -864,18 +864,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
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


