Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E91CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXz9-0001Mw-Ql; Fri, 22 May 2026 18:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxt-0007ku-3Q
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxq-0008F3-D6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:32 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so4706414a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487405; x=1780092205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke6jInMIcSbZvQJLAez0XGyYiEeJ5p5eH1CrpDu09no=;
 b=iMUQpoYe3ec8rxLPD/aMzzUs7DT9GQeTHcGYAixiSTiefTdkUWEym3MSHpxpQKXcLi
 jOw9FHc/mtnp5XoE0gpyg0RSNHEa7CLm1Rm/Pk7VoIV+7oe26X5yf1wffJJQExapm65n
 cqHiAnw5txaznShnxYayc7450avIz+O9Zdst9cj7KJbodiYJegMya9h3WrCCHvJXUPmW
 ui3WOw2XHNiQOyvpqbv/8mItP42y0xH8HGuFRD98U38mf3sGhOjzn8eI6w3jFWwNJfWP
 TCIB5LpAy7l6rPCmkEOBXyinjCXzPFu6EaevXJ4OdJ0VfjRY5melU3ZKGUrg270tCCic
 1jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487405; x=1780092205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ke6jInMIcSbZvQJLAez0XGyYiEeJ5p5eH1CrpDu09no=;
 b=P6GRVcNdosJbqp0n/x8Z0E+m/xzW9WzN4ETzPPfwgidUvZa7DRUi41B/EM+UZ6LeC7
 FENqZPOAkYSGe4jUdniF7zaqxqt2+nI5+EB+kt0fMILiKmgPtHqyPtXwk3tZHc6Id5tl
 uCtJhmJyvqiaLRybWH5JdkNTOHgb3typEflPQ/3qEClseotAxG5DNtyc/pB854gI7FqT
 c/PO3cbsovrzU/QOWPEHX2DcxaUk8Tl4y7+0A/axGnz6scseHnYtH7pHVa7sxWUYIWEi
 zWe5ZS46mfwSH0j7ZmUyrBNPYcm4emCuCXHAzCUeOGOfAbjAfUS8G8KXBntM+B+I4OuX
 J7fg==
X-Gm-Message-State: AOJu0YyoGndLWKL1F8z6yDzf4mzndqZPU1+4MueUbdAN5sEtRFUTPwxx
 rHkW6FvNAwnPjfTykU0D9hkmGuzumAxW0AeoaTQOfqIbsFo+N1tAIvnPQSobII+F1xYB0wW9uTS
 DPrsY
X-Gm-Gg: Acq92OHMFOYMD+z0OAPgvDE6PpCG8QXwm73tA3tSfnBMi81mR92uDBrWgiAcsF+JsuJ
 NlzYxjJRtu1itKUw8RC/v5zCUx2kT7BwyGFx5t1CBkeSC7pFxHRUBdlqKuh/4D6TQ4/9UFsmYWJ
 84BDZC9j3WRcSfPRloJrqXdRhRbe1roSFEeUKvIPAMbxRMf2XKSCg09nPyt1IiC9PLVM4WN1Y/+
 7TDBs786mbB21IV5jSBTyew0i9tZcDxz0vv/YoGHeVN0HXUQuFZxOdA6wlLmPvSWe0ujmstFgwL
 d9aBP1d5r1iuFmnH/jeizlnEThuoXdiIn0f94i/Dff74f1dGtJf/1cI76n29qUmT1yRM+UfMzUt
 9+wyh+yFhKLV9L5azrExMr6hj6bqPOxHD48UgZ+Ct2pfXV7ftdO9sWNofaQWMuh/na7dP9axDMg
 AOlLZS1ywP9kYnsKgfk3LlmnlsmpGi
X-Received: by 2002:a17:90b:5343:b0:368:b01c:85a0 with SMTP id
 98e67ed59e1d1-36a677fd392mr4427319a91.14.1779487404614; 
 Fri, 22 May 2026 15:03:24 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 16/64] linux-user/aarch64: Implement FPMR signal frames
Date: Fri, 22 May 2026 15:02:18 -0700
Message-ID: <20260522220306.235200-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f7edfa249e..899fce7643 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -73,6 +73,13 @@ struct target_esr_context {
     uint64_t esr;
 };
 
+#define TARGET_FPMR_MAGIC   0x46504d52
+
+struct target_fpmr_context {
+    struct target_aarch64_ctx head;
+    uint64_t fpmr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -362,6 +369,14 @@ static bool target_setup_gcs_record(struct target_gcs_context *ctx,
     return true;
 }
 
+static void target_setup_fpmr_record(struct target_fpmr_context *ctx,
+                                     CPUARMState *env)
+{
+    __put_user(TARGET_FPMR_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(env->vfp.fpmr, &ctx->fpmr);
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -518,6 +533,12 @@ static void target_restore_tpidr2_record(CPUARMState *env,
     __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
 }
 
+static void target_restore_fpmr_record(CPUARMState *env,
+                                       struct target_fpmr_context *fpmr)
+{
+    __get_user(env->vfp.fpmr, &fpmr->fpmr);
+}
+
 static bool target_restore_zt_record(CPUARMState *env,
                                      struct target_zt_context *zt, int size,
                                      int svcr)
@@ -610,6 +631,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_tpidr2_context *tpidr2 = NULL;
     struct target_zt_context *zt = NULL;
     struct target_gcs_context *gcs = NULL;
+    struct target_fpmr_context *fpmr = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     bool rebuild_hflags = false;
@@ -691,6 +713,15 @@ static int target_restore_sigframe(CPUARMState *env,
             gcs = (struct target_gcs_context *)ctx;
             break;
 
+        case TARGET_FPMR_MAGIC:
+            if (fpmr
+                || size != sizeof(struct target_fpmr_context)
+                || !cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+                goto err;
+            }
+            fpmr = (struct target_fpmr_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -735,6 +766,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (tpidr2) {
         target_restore_tpidr2_record(env, tpidr2);
     }
+    if (fpmr) {
+        target_restore_fpmr_record(env, fpmr);
+    }
     /*
      * NB that we must restore ZT after ZA so the check that there's
      * no ZT record if SVCR.ZA is 0 gets the right value of SVCR.
@@ -817,7 +851,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0, fpmr_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -841,6 +875,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                        &layout);
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        fpmr_ofs = alloc_sigframe_space(sizeof(struct target_fpmr_context),
+                                        &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -917,6 +956,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         !target_setup_gcs_record((void *)frame + gcs_ofs, env, return_addr)) {
         goto give_sigsegv;
     }
+    if (fpmr_ofs) {
+        target_setup_fpmr_record((void *)frame + fpmr_ofs, env);
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
-- 
2.43.0


