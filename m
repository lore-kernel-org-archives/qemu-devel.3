Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF7C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVY-0002J3-8h; Tue, 29 Jul 2025 20:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFX-00022v-9g
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFT-00045P-AS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7600271f3e9so396319b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833645; x=1754438445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQ1MYaLkxKnpaVxmxRBfo1krfJS0j3tvMJ/7oAKawiE=;
 b=ZlX61rqmKHV+tts3a7vyViOb29x4tuTtmJkC7uGq9OMirbAPnx5LZHLSMcFIAQtnvy
 9dTv4o7T2215xP7REWH1UW1cCtL5gzEReYgbMkI5vXiKEytVXGcT5J8BoQtkA5O/pm04
 8aIyuRlGmzlcJ3Q2qmBVpYJPspkp55PaWKZZ6OIYJpIer7sQX8viF3nNYjKp0diDIgVe
 D6dFh5icawL/1PtfszYrv9ggv9bcuhECLLUcSxBASftIg5+EpRsLVax5THAPYxtUi3bX
 I+KuZ4GsIPw1khcudplcAcYqyzbB1wQqeJBJN2WOmuNaP+XcA3/IT4oPoVWCC46LpME8
 Cs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833646; x=1754438446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ1MYaLkxKnpaVxmxRBfo1krfJS0j3tvMJ/7oAKawiE=;
 b=j3YKnZNSaOjkR2MyAjqKkF6zJ4/ugWdUVF0uek1wBV4C3Wk/IGNiTxtqL5XzpXFaCV
 6F0y7LYWR7LJsLiFNZ0za1B18RcbSd88F8afErNiPV6cnGLeVDMNiefam/dWOqxdt6/e
 Trt6NtQdtgJwSBBz1gXk2mo+OIxupHN3o7a8cfjyH3WYL1/TwrCFqwUKoJyH0U2MwKLe
 06t7tERCXHDa4KFnHA1ZlwhaGeikyi6+LIpvNO0fxZrpvCfnaUUzJ1zTGqOsaSywQIgY
 Z3uRfZMCcPy4qtAAuoDMwd88fhTy/YUi+ppWLNL28JXuZr9zGnNLHheEbjpg7x9uX2Ya
 UCoA==
X-Gm-Message-State: AOJu0YxelGhlWbv0lih5QuqyJW6WkL46WDdJ+a9W3QdtigPQJyhMrJcb
 1IxJtppoz4VwzlTqUba1VJQAZV4bIy97hyBkfkOaeEnfEU0C+4wepeHI0G6hfaMVtb0jTSgDOhi
 EyASj
X-Gm-Gg: ASbGncu/FqQHflRRZ5iQXRnbg9wLMQ121ZUP90vD5wcPGkMWAgCnPpDv0yVm2LHI4cU
 U3me5BUYKDUJjynWnOxnDVrvy9Z474rWatofyllrJ8A7GoaLskBnXoqHnNEBc+T0nKMXsKcacRG
 JtLJyU766ZohDCndb61ejbt70YhnNHfrIYa5gpeHdG03vq9tVACN4OVeH7UkIRfcO+/G4zlGMRQ
 h4zhPeVE5DjlI9KtEXr6NcB6PqQGB2RM99JyYEmD5j3epAUyXK6eqSxT4nb37qqEr9g/Kp3GTQh
 cKSYjyLFxjagkCRXyJ+v7ovrArdAMwhh0TFk+nt98e6r7dTDAjxn1xTffpg3S1DnNSE9+deXdoR
 hpMipdDAFUNGvobn0A8IeVhm+Q/0sqQFNpaqwlkc7ExMDXDg73bwL4H8FDrNXbWMGNsp8yKFV9l
 HQOIpbQfErqg==
X-Google-Smtp-Source: AGHT+IF553ztk568SX07F6B+uh6Kx1QIiodwfW2YcYk3Oa6aZze0l0108mJmFsCoPv6gTqzyj9jUJg==
X-Received: by 2002:a05:6a00:9290:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-76ab68551e6mr1881821b3a.4.1753833644539; 
 Tue, 29 Jul 2025 17:00:44 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/89] linux-user/aarch64: Create init_main_thread
Date: Tue, 29 Jul 2025 13:58:58 -1000
Message-ID: <20250730000003.599084-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 linux-user/aarch64/cpu_loop.c | 14 ++++++--------
 linux-user/elfload.c          | 10 +---------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 030a630c93..4c4921152e 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -137,10 +137,10 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
+    CPUARMState *env = cpu_env(cs);
     ARMCPU *cpu = env_archcpu(env);
-    int i;
 
     if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
         fprintf(stderr,
@@ -148,14 +148,12 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         exit(EXIT_FAILURE);
     }
 
-    for (i = 0; i < 31; i++) {
-        env->xregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
-    env->xregs[31] = regs->sp;
+    env->pc = info->entry & ~0x3ULL;
+    env->xregs[31] = info->start_stack;
+
 #if TARGET_BIG_ENDIAN
     env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    for (i = 1; i < 4; ++i) {
+    for (int i = 1; i < 4; ++i) {
         env->cp15.sctlr_el[i] |= SCTLR_EE;
     }
     arm_rebuild_hflags(env);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a9a1d7222a..0fe15eab72 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -401,15 +401,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-
-    regs->pc = infop->entry & ~0x3ULL;
-    regs->sp = stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_NREG    34
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-- 
2.43.0


