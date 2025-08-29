Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B1CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNm8-00061i-MT; Sat, 30 Aug 2025 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bi-0004dc-6O
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bc-0003gX-KS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7723bf02181so238871b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506599; x=1757111399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12YsfvP3/VIIWGpVMmOPs3wywmK/KwLEm63b9p2gpgs=;
 b=TetSHgqS754of3NfzHBo7Equy4WHteXmQHZZXyxbvfiK3JKL2yimUM+ZOzpvoh9XRm
 siGJ7Yj5EQhfPwLX45VCBRiZbK/2LDd0ibAubsZ5bfAXU9cMeQp7lkhFn80OAmr1h4r6
 cClR3f4IIRajF9rikRRITaI0nINSpHEywSvLPqgMLNIDWK/qTYX7rty1E5KIFQilRfDD
 cCkjoh+OziGg/o/miDbPrkY8LlamdHIF5ONio7NAu2pF9GJr/tUshfv95vUDD9EBvgBW
 0KC0y0PetjtxYaJyzCaxWPa6F3Vjv4HLwnU6zjBPmSKPi0tAKE9d3nWkUeIICoB+EONu
 TJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506599; x=1757111399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12YsfvP3/VIIWGpVMmOPs3wywmK/KwLEm63b9p2gpgs=;
 b=JM8RNdVDxui8+TeerJKNdwh4USsw1MpWqjSeoAQBtZarqPTo1/sp4r6AKIE0ZsU6ny
 gmemI3kKfwsF1enU19RI1WbIS9g7TSpOkcDTi8Rqol5FpEe3bC12yD3pUcpwv0g456RL
 BWFSk8MUr8tbQOCzRmvTuVm46NsOBBO7aaxegsLEGR5vAuJyB5t7Anydbhsk33lTbzrw
 Kl/0R+2pyIur0zB3Q0hs1jaJRqkUERNp9Zym19k/WOnNXE/Aa896mYgV9Cb8ooU7e2Fk
 6U7oUVWSresBX9WlfD73Ud8Z1QuF1teNn818bcFmFnG7Do4Q0fr0j7eAIa+PydGAIt+y
 aadA==
X-Gm-Message-State: AOJu0YyUVfg/Ta05h8lplk2Gs+hcU1tJdo07UFKr/NSfXkLH7F6My/nH
 5f45f80szMNiDYfYx1eSFSvsFwVs+Jx95tFinwxlhYF2MLeVwSN/1/YYf8kJdNqrrO3dUKlPiPI
 mFp9x88M=
X-Gm-Gg: ASbGncuo6LU9ngHmtuVFVTvMc187Yp65lyBcexN0x3sTt8JGA1L3GwV9GuAc5fsonSR
 4NmXY65fNpd6/L+jHcFlYdeYFaegsjNvtFeOoPgpxSQmqVQA1NUHuuuY8zuUq1vSfM3yT8yWAUB
 WSKOg5Uk4CB/UE1iGvPD1+kVPmDfghUmZTbyHwpueeH7YopWuZqP4TP/XdDTCJhshM3ou3VUP9R
 zLz/jTZAOJo05J3G3giFGME+7athUa4VyMijeko58g3Pae39mp3vUKNVzLvAR/NLnvSXd33vO14
 un3aVOACbo1zHZLQYatCbWG1mxY5pAgMA+IcQIW7lyDbuQBhaddeuZnxN7/wXG74TWL2J4pUavn
 F8IMpdNSqkw77eDjo/Pgs8FVH9GJqOIWpEfr685PxYscu7ciKNhGnPylN0wAgwWVWPI801u47Og
 ==
X-Google-Smtp-Source: AGHT+IFPcnUxN+Lu1N/qR0jgUThS70SRQT+EiLlXzmoss4JtxdGGhpiw/wDGccvuRCr2kc6m1elJ6w==
X-Received: by 2002:a05:6a00:bd90:b0:770:5736:4ecb with SMTP id
 d2e1a72fcca58-7723e38bf74mr269307b3a.28.1756506599181; 
 Fri, 29 Aug 2025 15:29:59 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 60/91] linux-user/xtensa: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:56 +1000
Message-ID: <20250829222427.289668-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_elf.h | 12 ++++++-----
 linux-user/xtensa/elfload.c    | 39 +++++++++++-----------------------
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 43e241aac1..850a7206a5 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,14 +8,16 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG                128
+/*
+ * See linux kernel: arch/xtensa/include/asm/elf.h, where elf_gregset_t
+ * is mapped to struct user_pt_regs via typedef and sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index 49e709a094..68aeed855f 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -11,36 +11,21 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return XTENSA_DEFAULT_CPU_MODEL;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
 {
-    unsigned i;
+    r->pt.pc = tswap32(env->pc);
+    r->pt.ps = tswap32(env->sregs[PS] & ~PS_EXCM);
+    r->pt.lbeg = tswap32(env->sregs[LBEG]);
+    r->pt.lend = tswap32(env->sregs[LEND]);
+    r->pt.lcount = tswap32(env->sregs[LCOUNT]);
+    r->pt.sar = tswap32(env->sregs[SAR]);
+    r->pt.windowstart = tswap32(env->sregs[WINDOW_START]);
+    r->pt.windowbase = tswap32(env->sregs[WINDOW_BASE]);
+    r->pt.threadptr = tswap32(env->uregs[THREADPTR]);
 
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+
+    for (unsigned i = 0; i < env->config->nareg; ++i) {
+        r->pt.a[i] = tswap32(env->phys_regs[i]);
     }
 }
-- 
2.43.0


