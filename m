Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E39EC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVh-0002ua-Rc; Tue, 29 Jul 2025 20:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFm-00028m-CI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFk-00048s-5W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76b0724d64bso90621b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833663; x=1754438463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9fFn3MTAeeWjS0HLCyZy5t4uqOdGjI4wSstVmtHm08=;
 b=a4pHPM5XcPsaQzAJtW5JD0vaMsIgwefB37cq5l1vi5GOWtr4KJcxKF2yN/AQLCNICj
 N14rlRXrFmnfF/vad9fVS8qObTnzQl5FliIvmn4k3xR9ErCLfkbh3EkxW+1htJayuBjp
 T7lLX/aTKlD6rxfzKV6mG92C8KgIqBjbS59G1NqoG1mbKkkt+PQ/flUgZrBl9huwv/52
 hp43mIsHxzG+dpYALA8Nr8chls0a1Qvtt1V8u74J43iNA08BkCk7+QNVJEeIJ9GzMVg8
 CM0Zw08BHpwN3i7NT2mdOdDeJCrHMCYaVap0wlQt7HDGP46HU3e8omDfklyX+TZfZTa1
 QIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833663; x=1754438463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9fFn3MTAeeWjS0HLCyZy5t4uqOdGjI4wSstVmtHm08=;
 b=NdI8QWnPBb0/aP8SN1S8o0KlggxyatFu8oGjrxN/2OMhwSU9JZh8pV9LN/20cFIgrx
 CqyJHPQCjo5qR+5LmovsTM6k/0uYr/bZWOvyo4z5UL6mTjF4Hb3LDGBjuPI8zDl3KAr5
 YRZdWuofb75curDgzI6dDctszkVr2u4syC7gzSniP1Jfe9+441DpC6QTgcEdaD8axeG8
 X6afwQ39C2kdRVnQtHyisftXxugvkW/bHiwBk222ctnipKHSKtpojNKQ/XiF7QyqIxGw
 suOrf240qNSCrp0nXzqBVdnX8d+oNVwg3fAHL8+jZv5RCq2mxSuC/N2bhuxSHdiF6qHx
 7jIA==
X-Gm-Message-State: AOJu0Yzv1+/XUpo3xxP3J9Zhcc+NG27Lk2Gv2BsQ2IUr7zLR3ig1Mydq
 b6PWV3mMU9ldKDuluR8yeUsVjKuT+ghWhpmaYivve3FyzCiwOtlyuFA5TJg/h1Ps52gveSzQYWR
 Wut1+
X-Gm-Gg: ASbGncsYlBrRsm1bQYuCsmP7Vbqs2192ivfC/mHPl7OlhWdIphvrZLXKE+yBNr9JuhB
 BZza2gLrMjLYlS6wTehbIlKTuVMfDIadb2PW9mBNTTTZnGiDc+wQbzft/wN6aD7s7IObn0/vmWm
 tf2WLozQFSodIn4lV6HMq2tsdoE7VuAesNgqY4fXIvhxeQ+/9sghZ6iNp1vVkkiYOhdhihFrk+J
 M6e5H+IsIk0XfTFOZzP6yFIEwsva58PrXUUicgkfALWqNe2K5bEfBTY+mrDTJCT+yBADaiMPj1N
 6+OTmDMVWafNfGjTDOMJloogWxnDLPdxTSF2UjUPTfll/Zw9ScenJVJCtmP2+Ovu5JdaGp5myFr
 1S8jB3LX+nLr3R1flkEf7xBByS5yp7ZQg7YFW+a57MNteoID3SaVJKjwr4AOxuvtyivCJAA5gwy
 FJ7mkjxr1n/w==
X-Google-Smtp-Source: AGHT+IHxRXDoYoB7R0oG1qRC1Se/hiBqxljSsCy6IJFYlOMwu3SwwvjPIxl770Q58cnVkFuQqV/rsg==
X-Received: by 2002:a05:6a00:9285:b0:76a:e87a:998b with SMTP id
 d2e1a72fcca58-76ae87a9c36mr855490b3a.12.1753833662560; 
 Tue, 29 Jul 2025 17:01:02 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:01:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/89] linux-user/xtensa: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:11 -1000
Message-ID: <20250730000003.599084-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 linux-user/elfload.c         | 18 +-----------------
 linux-user/xtensa/cpu_loop.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 48c04f9f33..4a58811f4f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -911,23 +911,7 @@ static bool init_guest_commpage(void)
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


