Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD57BE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfia-0002NQ-1m; Fri, 20 Dec 2024 11:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiB-0001WA-6R
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfi8-0008C6-Aq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so22851595e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711522; x=1735316322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9N5R4jVOn9EmqTq+klLXLHYEgnhRoHrMyBiXguPuoE4=;
 b=rPIOrGxgdt46y/Vz1We+dO0Hw4oisP9Brr1/oR2d3/HVNF+GPViMzQcimS8BCVW0JC
 LPrfEvJzDTYw+yrwpTkHuTIlR3FAnmqkEI4DGKI6ujTLDRGCBLqjN+ImeTC81aLPWbdB
 5lVqXU5iZ51z2mlCnt/cRvk9QzeFpA4L3cw5LEzx38VlPIWCeYDmGb3NyGbV2mrHtgY8
 JSZTyBicl13Tf1EQ8GXyBhGof6AeH7Hk/tTOxoPJ1Ex92mA7vNZ1gkdfzryi9KW4Xyn/
 G2/e12AbRt0uTYroNpBS5FUgbPyiZF8stijdXBTrFbUwidH2xI2t2zh+91H/r3yVwKYX
 RG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711522; x=1735316322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9N5R4jVOn9EmqTq+klLXLHYEgnhRoHrMyBiXguPuoE4=;
 b=mD15MKXceGMm+L2GKK7dmmAWJK8kujGYYb6yr7Kd5Hz8gbjnSz08c6OytztEzzrnoS
 +Ro3MSLIL6rpLpTx43ny8wSyQ9IQY+kuGdQAziodFOEusreKh7utH+fEFaHRm7InKddb
 5XTJmEdmN+lf94fzJbi8UAAO9GC2Fx5n7lNboPz5O2K3ZDk8tfR7U92dHFAXR4vPV2xI
 EQobEnganOWkvp5GDf65BR9cU7xBXcHm/e5j3Q9j3TZXrhymHw2JRSxCrWW9oQOOAZdU
 3spqRWjphxWzbM1hcS440qemfZiij3aJdOe191n3oa6K9XxPP2/Np323RqO/awl1rzN0
 vpFw==
X-Gm-Message-State: AOJu0YyehcKB0IHbvBJectLL5dLttkKBhn5Ekrr8t4BrbCG+hqG7Q3K0
 NJGQeZ0OO5BifGBlpCYnAw1aH7NQ/j8R3Fet+inacYkaS8bE+zgaTz43HoyZW41bUcP6hgLogIz
 m
X-Gm-Gg: ASbGnctyFkCFygxOnRoTB3nVcqZ54I9l9WBh1XoNUbd68XT4KAyFG2ipDfgbOiTjwQH
 8sYj8MRcdfDdJcESljj22V4iMzxVhnY0prtvf4PDtjWJgK1Gz5jB20CK/X2eYoysSkz33v7yEJA
 m4UPrlPq9kodPkzINAE+aPEJHWF8JgCSlBXLfttBuHOaJX3xX3+yfHz82F/ft1LOj+4wJAGwCoZ
 ofsmx/JxIL+zKJ0+2+Kfwu5aJ5Plr/LoqdVZf+VtqgCQHVgJ0pRoM5XBDRcuoNIAzM8t2ozxRM=
X-Google-Smtp-Source: AGHT+IHNEcCcUfN577eqIyswEmNP4qTBovaBjplPO6C3q+ZxuKF3Ku+dm5Z8nP56DDXd6ZWMfcfzUg==
X-Received: by 2002:a05:600c:1913:b0:434:f396:525e with SMTP id
 5b1f17b1804b1-4366b2fa0a6mr28443355e9.9.1734711522542; 
 Fri, 20 Dec 2024 08:18:42 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a2432e587sm1480525f8f.95.2024.12.20.08.18.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/59] user: Forward declare target_cpu_copy_regs structure
Date: Fri, 20 Dec 2024 17:15:28 +0100
Message-ID: <20241220161551.89317-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-16-philmd@linaro.org>
---
 linux-user/cpu_loop-common.h      | 5 ++++-
 linux-user/aarch64/cpu_loop.c     | 2 +-
 linux-user/alpha/cpu_loop.c       | 2 +-
 linux-user/arm/cpu_loop.c         | 2 +-
 linux-user/hexagon/cpu_loop.c     | 2 +-
 linux-user/hppa/cpu_loop.c        | 2 +-
 linux-user/i386/cpu_loop.c        | 2 +-
 linux-user/loongarch64/cpu_loop.c | 2 +-
 linux-user/m68k/cpu_loop.c        | 2 +-
 linux-user/microblaze/cpu_loop.c  | 2 +-
 linux-user/mips/cpu_loop.c        | 2 +-
 linux-user/openrisc/cpu_loop.c    | 2 +-
 linux-user/ppc/cpu_loop.c         | 2 +-
 linux-user/riscv/cpu_loop.c       | 2 +-
 linux-user/s390x/cpu_loop.c       | 2 +-
 linux-user/sh4/cpu_loop.c         | 2 +-
 linux-user/sparc/cpu_loop.c       | 2 +-
 linux-user/xtensa/cpu_loop.c      | 2 +-
 18 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
index e644d2ef909..aca51f53238 100644
--- a/linux-user/cpu_loop-common.h
+++ b/linux-user/cpu_loop-common.h
@@ -27,5 +27,8 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs);
+typedef struct target_pt_regs target_pt_regs;
+
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 71cdc8be50c..77f857a8216 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -185,7 +185,7 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 2ea039aa71f..b5403ed0e46 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -173,7 +173,7 @@ void cpu_loop(CPUAlphaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 709f718a99d..be1f11022a7 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -513,7 +513,7 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 40db596301a..750150a78db 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -79,7 +79,7 @@ void cpu_loop(CPUHexagonState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     env->gpr[HEX_REG_PC] = regs->sepc;
     env->gpr[HEX_REG_SP] = regs->sp;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 23b38ff9b28..503a204460e 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -188,7 +188,7 @@ void cpu_loop(CPUHPPAState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 1; i < 32; i++) {
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 7a35215278a..e06aa23de4c 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -331,7 +331,7 @@ static void target_cpu_free(void *obj)
     g_free(obj);
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     bool is64 = (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) != 0;
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 73d7b6796a4..935d5bcf2c8 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -97,7 +97,7 @@ void cpu_loop(CPULoongArchState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index f79b8e4ab05..69cdce95518 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -92,7 +92,7 @@ void cpu_loop(CPUM68KState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 212e62d0a62..ee4ba768691 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -127,7 +127,7 @@ void cpu_loop(CPUMBState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     env->regs[0] = regs->r0;
     env->regs[1] = regs->r1;
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a0737..1331a9a2b8d 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -211,7 +211,7 @@ done_syscall:
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index a7aa586c8f9..1bf9542d16a 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 02204ad8beb..e168f1ce947 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -378,7 +378,7 @@ void cpu_loop(CPUPPCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 0af533e186f..a72bc76da3d 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -94,7 +94,7 @@ void cpu_loop(CPURISCVState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 8b7ac2879ef..42e4d24102e 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -180,7 +180,7 @@ void cpu_loop(CPUS390XState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 0; i < 16; i++) {
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index c805f9db110..937d9fa265d 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,7 +81,7 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 50424a54df5..58a2464da9f 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -357,7 +357,7 @@ void cpu_loop (CPUSPARCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     env->pc = regs->pc;
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index d51ce053926..7564e25a966 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -238,7 +238,7 @@ void cpu_loop(CPUXtensaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 0; i < 16; ++i) {
-- 
2.47.1


