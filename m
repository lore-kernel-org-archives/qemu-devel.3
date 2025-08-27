Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B65CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTC-0005CJ-JS; Wed, 27 Aug 2025 19:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSy-0004WI-PD
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSv-0004LO-0P
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7720c7cbcabso297102b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336923; x=1756941723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsK1dRAVucN5uYDjY51g3VI30aLAIpvpyFsxl3c/Nkw=;
 b=IXViq7418Yle243J2NUEIOryzZlzRknRLwPPPXkM56j5g3/5f/2QHq62BbNpVDY4Nu
 HPJMACCyTIYYumgYiwu+B1PzGQ5cXLeAyPxO5OIRB+deoNaYXeV8f0zXoBeZ1DM/SaSJ
 tcSRCTtiyHDLYYyUxfxXVs+6t1UhmOVMaTt4PyF4xWNA6avdkW+o5lcXfmJdwlre3v9o
 g13ErJYt/e/bpD+BM9Eqdg8JOnlaDOCmKklhpsjtVCZQh8aL/ppETCJ7XFLS6cf79w7d
 Y5z3MiZHjO+oA9xkLbhvYAwmlsxO2FZx9iQDEDEzX1VMyxLFLcnkeHg17invVymjnToq
 4ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336923; x=1756941723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsK1dRAVucN5uYDjY51g3VI30aLAIpvpyFsxl3c/Nkw=;
 b=Bw4Gu/jpPBwbZVQ8BM7drIUWgOKrh+DE+WQx9hFejv+muJrGEf5hOBWgHnzMzm2a1V
 SJA1Lr9N+L7qGMQx8P31Ce93epdRy+rI7usxic/odROufmTiLMy7MgY4n9SUsghmuDdw
 SjpLbs6m+pYaD/t49O9fChlKeOA4SGkytDk2/qmnOJiM12IebKnLxd4YfUKt6zy2W0yn
 pKGYmXJjh5GsO9qQ8s1WyN2ZyntBWocLUQLEVn4ewRWWlEc3zJusNlHDBq2tDPLBIEpA
 admTvt0tnm9KzDBAEiKtYcPjfABEDwT+Mv/ifdV+N0X4K8gx8LFfbI+NDo3szjkqdOfD
 +eAQ==
X-Gm-Message-State: AOJu0YzTnbYzCoShMNsbqXdvKwsnyHxYikVcjIK6qholX2Ap2XRuE4d+
 EfDDeYlrA9IKb3kmRk/nIp7v+bNxlJ2u1BwcGdHA6RsxvfcyVygCvXWDnc76mRJ6Id2xD8t5po+
 3hCfqhJQ=
X-Gm-Gg: ASbGncubno18kUPCY5ue9D5P+fm6ys9OAckzNwXCGLkvRB+94L0KfG/6LIN68N+vRXH
 pvKfu1fQiByuechW4Ptylqe1d8Z4deGbTczcUt3GlvDBAiCFQJlgkhDo+8HpG9Pk+80uB6Drrvz
 bFYRyiJsENWuxHL13hx4qW/YQm6yLyShWOiueGp3USCreekbJHV87PCM6GXFznUzjla/nQwRj9x
 6TMDesX3oKbbquv+hY8JXnwhC/9MWpcMLhXQ3PkHbyaZsT3gHYBv41ol05fz/zqmwwXW3cpu/6j
 dx+UI0G8VOUbZhDvcLh1PtxXwwALUehY+ytVFuB6JwDM0OzZrdKI8Z2w1YuGkCzo164qm731dUJ
 cTuyR4gWN1MqBI5Iunw3x+mHnyDfx6Aj26SxN
X-Google-Smtp-Source: AGHT+IHQa6/mY7sGgMUeuf3h3bGunarCvSRhaPq2raCSBaVeAGfePEfum9Tnex4L9Ws6q2Tc3yzD5Q==
X-Received: by 2002:a05:6a00:398a:b0:76b:d75c:8a76 with SMTP id
 d2e1a72fcca58-7702f9d90b9mr25706648b3a.1.1756336923420; 
 Wed, 27 Aug 2025 16:22:03 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 34/46] linux-user/microblaze: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:11 +1000
Message-ID: <20250827232023.50398-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 linux-user/elfload.c             |  8 +------
 linux-user/microblaze/cpu_loop.c | 39 ++++----------------------------
 2 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ac96755b06..3f9ec49359 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -640,13 +640,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->r1 = infop->start_stack;
-
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_EXEC_PAGESIZE        4096
 
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 87236c166f..d8277961c7 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -127,39 +127,10 @@ void cpu_loop(CPUMBState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->regs[0] = regs->r0;
-    env->regs[1] = regs->r1;
-    env->regs[2] = regs->r2;
-    env->regs[3] = regs->r3;
-    env->regs[4] = regs->r4;
-    env->regs[5] = regs->r5;
-    env->regs[6] = regs->r6;
-    env->regs[7] = regs->r7;
-    env->regs[8] = regs->r8;
-    env->regs[9] = regs->r9;
-    env->regs[10] = regs->r10;
-    env->regs[11] = regs->r11;
-    env->regs[12] = regs->r12;
-    env->regs[13] = regs->r13;
-    env->regs[14] = regs->r14;
-    env->regs[15] = regs->r15;
-    env->regs[16] = regs->r16;
-    env->regs[17] = regs->r17;
-    env->regs[18] = regs->r18;
-    env->regs[19] = regs->r19;
-    env->regs[20] = regs->r20;
-    env->regs[21] = regs->r21;
-    env->regs[22] = regs->r22;
-    env->regs[23] = regs->r23;
-    env->regs[24] = regs->r24;
-    env->regs[25] = regs->r25;
-    env->regs[26] = regs->r26;
-    env->regs[27] = regs->r27;
-    env->regs[28] = regs->r28;
-    env->regs[29] = regs->r29;
-    env->regs[30] = regs->r30;
-    env->regs[31] = regs->r31;
-    env->pc = regs->pc;
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->regs[1] = info->start_stack;
 }
-- 
2.43.0


