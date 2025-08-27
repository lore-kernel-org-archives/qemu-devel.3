Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB27CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPT9-0004wk-Oi; Wed, 27 Aug 2025 19:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSr-0004MS-A4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSm-0004Jc-0k
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:00 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32326e5f058so331597a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336913; x=1756941713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RixljIz+HOjrys5KmnaZU9bK0ysdxVWlZPGtRGwn11E=;
 b=dhL7J5jmzSUiu7S1iunupXxAOovBud9sufzjOrt9ewvtluOnzi54IypxJXzw5ppOOi
 LgiqHPYwVTPof5EP+UUIfhEiGNgcvRsy36vb28i94Dn5jsWhhkJa10V9J2vjV/M9rxTB
 Cgnb+ntgRECTvNHbHFu/I/ademFhiBqKE8vDJmxnL1PUAoB3CuZTJasKxplFd0XNxJJz
 K+52dWVDhTpnFIzzUSOYPTQlqVIiupoDvwP1J5VQV6CAg2QVY9ttAu6Ol66dfCMlWNu8
 mbC8n7bXadj30dWztcFahsv/lKmoin+n56BdcWYX1bUMfP1H+0LrMhjx9Z2cYR5oD5Kn
 UNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336913; x=1756941713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RixljIz+HOjrys5KmnaZU9bK0ysdxVWlZPGtRGwn11E=;
 b=sE359zzDVhbXnUwmfNAqdSU6Np/F4k1uBotYaqHuKKo5iql63KeIupOo2DX/LmX0oO
 ktOXQ8NdQMsaB4fCVM9J2Q8JJa72Za6f6n76eYH5ACwKJWVSBpKpwxqMDZ7pD/h4gSVv
 NM/0pXZMt99Wbw1RurEVdFNyfLSoSz36WuTvSrBFaZOY0RyPfeXtxzYAfi5JMbeGmbiI
 Z890V7UW0L6xPQKmLhNHOiKLV5CfkWOqZxXNT8J6YoMgEC3TMftrzOMFHYuBKpUlsClJ
 8Tg4djg0iM8mYL+/DXKaf+puY+5hcY2xsMRmamcGMy5/HBHKrbi7dsxAJpLDEfAj1unr
 tCKQ==
X-Gm-Message-State: AOJu0YxXvNAqEUTYYjN7qEsBo8cwRoUue6qy/somDED6qFDHcg35o93Q
 mmPExD8+EPRQ91TC/+x9xv7+NtbjYbWp28djN9ro1ciyXLiEPxs0tDSDd+lqsazn05zz2uiqiAs
 B1QRHhCg=
X-Gm-Gg: ASbGncvGqO8tuMj1/gByQgm3db5J1AGnrwdiQtH/j8roNwkQdI9eO8JQ0n4Gk22JgyO
 vHe/xtsfvDYc1v6z+vSRW+h9loPLql3c2hW5tsSwBe/wu2HHGOv0Wdy0uTAlqOIPWvNfQHP2h/f
 v8cSpQCr1pB4fFbmfG8OfJsb6WAP8Puz67S29ENwk+8jYXq0uWYsQmy7cUwMrxJCBvKJnR/hfXF
 qdiLHtsJIEqS+BAh5cnuptbQlYk1JrcbdXqsTeobO8kcpVQ4zRUfjTHaYzxxi13xBTLXc8GImvF
 33DOsygbeLkoEPvi57bzXsqeEyhhvsZkdxcmjYZsGXO45ErQZ/lG0xaTSS5YRQWvEW9RKyXrNfV
 7JTi1n4MwBUqHB8O0F/sC96YIzXIaAUrzd02w
X-Google-Smtp-Source: AGHT+IGRCrZrd/2R/25PwgIBqGnvuwZgE16LKsLb4qbiz86kYYPu1Po0rcKCQPlKLc2kiY+KtTtJUA==
X-Received: by 2002:a17:90b:2790:b0:325:46e4:b171 with SMTP id
 98e67ed59e1d1-32546e4b308mr23795471a91.6.1756336912675; 
 Wed, 27 Aug 2025 16:21:52 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 29/46] linux-user/aarch64: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:06 +1000
Message-ID: <20250827232023.50398-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
index 9586873954..f93afbdcea 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -395,15 +395,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
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


