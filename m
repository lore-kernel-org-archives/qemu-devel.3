Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0C6C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJt-0005bF-3y; Sat, 02 Aug 2025 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJp-0005QO-B8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:13 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJn-0001Dg-GM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:13 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6199e7dea32so180583eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176030; x=1754780830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsK1dRAVucN5uYDjY51g3VI30aLAIpvpyFsxl3c/Nkw=;
 b=ms6G/8ZooRHxK4153TdVvHAIaiR6wR8pClujCv4RXfU7G581vf8Gp0JzZmSsHDSua6
 Uh87B3bF8G4AxBx6kQAqJ6NohvmmdrlsQM8ygtJyLuqnSyjjfh6DoAvHyztykoJnGlMG
 6zwRN94ogOtaPgGfOXlJjq0O4/8Q5a8S3jnDw1UjjZqjIr7v2d/BCfdaOg7NJGOi7c8g
 UYwFIvLlZolaY4730BdAH991HPMpomHiBrbZy6sakeHEZug8yVDdHaUOK5ZzyHhhzHzX
 lPSoCrDLJzJV1snCtpQb4kqNyxaUe2amCmRfHzYDPwtC+IUnV2t9Zo/O3AOchmeBrbl9
 2MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176030; x=1754780830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsK1dRAVucN5uYDjY51g3VI30aLAIpvpyFsxl3c/Nkw=;
 b=ezp+drLknnQXl/bKmTc5PL7k9HK6hPG+k2liUyFiohd7CX/8elPvpDnfhWZ+/2G9PI
 jLsHVd54d47jn3cvQj/qcvb5blvcZ/EGs9SldzpNPMPUXNmtQFxiRJm9IwzPhMkTdOSU
 31x25eFKSdx7DhXj5Ku/d6AR22EFKqz237sv1Sj4kri0L7BxTdT4r0TEF3LgsE956eHY
 p/Hbjxx5IZdxrX55KWkRdbpJ9D7lxfiIUCj6vnc9twt6XShtXNu874a/QSAqs20S158s
 PZLaMZ3fd2XZL6oXZbre+7XJ6dn1nBB8gVfv1wX6yzGnoJGqzQ+QWUgsG3d8Mt+9u+Wv
 KpEw==
X-Gm-Message-State: AOJu0YzFG5getDpElUg4dJz1lDrzD0rM75yUrKJL0pZYhrV1t88xhhmo
 5eJEoiS9DOKmmEr8M6+Rk5cVtadEj3CgOQQubFRKDJ2QQRDN14n50mjT0vAEPhIk0dyCnhWvswH
 TxY1gHwA=
X-Gm-Gg: ASbGncu7vr/QmGVrr5aNPJTkS5SJPkwR18LTASKs+34zkKp5vKjJ4VKcW9wsJ9crR6Y
 31oMMu+1ujDC9nrMqUcPttAEbu6yIl1fikf0+ey2bMSqhnC60Qz6b7/lpdY0HkNw35I2p1c4F6n
 jUkKlAqbpuPaYtXFJHKoZDypIp+H6MuxrgYMZtdrlIbr+epoF+NQ+ZtPQFWt19qDtZupNo0j4Kf
 tGh9wwrZtJIxIoqnQaQZkP29dzUla2z7LMI5fVLsiDsJnJlL1Oi/zaXwkTIXLemkABc0X/K3Ypt
 JV3cigrdmbMRSHgOMQIg31vdXQrNJXyl3vSdhg4kGIYfgqFX/Eow2edKWhVaI5zcPq5uUTe7rah
 g6Jz2/CallqLuWBWxZWBl+iGTSsXcJwVwHwyM1usBPIVUG439Ula+
X-Google-Smtp-Source: AGHT+IF/2fMk1AzyfhN3Q1/P4F9LRmHkfad4j4wNvYMVwalATbWp94xyayqlGjemFm8hvgy61gOMGw==
X-Received: by 2002:a05:6820:290a:b0:619:6fea:2fb8 with SMTP id
 006d021491bc7-6198f256e93mr2628529eaf.5.1754176030200; 
 Sat, 02 Aug 2025 16:07:10 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 34/95] linux-user/microblaze: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:58 +1000
Message-ID: <20250802230459.412251-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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


