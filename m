Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BA7CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPT6-0002mQ-T8; Sat, 16 May 2026 20:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSQ-0007Jh-5f
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSJ-0006uG-KR
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-366087480d8so824671a91.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978045; x=1779582845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke6jInMIcSbZvQJLAez0XGyYiEeJ5p5eH1CrpDu09no=;
 b=bOaYbuPi5DiyG1tLRjgdSrImfJgjS9cv6vhtfJH3jWxR0vmMHFOYRfP90C4gx0ELO2
 TIzyw/bQNTGAmGLKfiFBtAlXdbCFVJwYIH6Hu82EhIHxTOqGxSX61Hl6aUP97LlKP8wF
 n2KKkoTjtwtdz6PqvzAwh2nSWivb1VDKWepBkLQG+VloyPvdW6/a5RniaLVSCntPYWes
 40El1uwontw3gNFn8DvrdHlRl/ve+jhzfDMhJQp+040v0QFgOzrraxncMV0pIMYFzIYQ
 Ou3ZrklznqOAdd5EYgeCrB5IrPbFsu5RD+Ayn3BPmS2T5fwGWTs0K6bQBxp4xnqCQo/N
 6qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978045; x=1779582845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ke6jInMIcSbZvQJLAez0XGyYiEeJ5p5eH1CrpDu09no=;
 b=QpLiMlo5YQPeI/I8bqv3cGqWFrA+w71vsz1icqIAmS38YvQEi8co3WNcgh6SLiBTgR
 7p59PXvokQpmgvMBlEO3u5m+X41run22fooArhpkdTip4TbGS0H09aEf8MZyFv/CsaKk
 kDhhJZj05cO+Q9oZbnJaow2Bum4ZtHAlhsutZ8xWeOVHS3QQvbe+f67hcS4flv0wxbE8
 78n/6PcEAmInA170hsi9J2wjmsXwZH0IvLUom/7CCXjHMDgPqoOxUEUebcIxDojRNieU
 Xme/Eh5GQHrkiVo7V5h/RxqyteTgSBShS8V6lAKyVJAA05uE0YwamIUkF90+0jIqpEL7
 5QQQ==
X-Gm-Message-State: AOJu0Yy6SAzKOxan2ysBoUbaLq3gAbQz97UE2PGaRE8dmtxhwSnNfZI+
 aai/tixJcM/qOPTu/L00h6fZAiQ1dQv1+EYrHg5K5fOK1oDcFp/dsJegXhS3pRCHp0TjMcXNORZ
 0RLaL
X-Gm-Gg: Acq92OGd7XbiNd0sBUp+giCi2y0ZthO/h7wYFmtbXMEqpDSKovWVj5rsyQGo9/hBz3B
 BXMcoUs7qtVk8EUKYjBAuBJPhiBFMFmLUxDuM/Wh13VMrtHjDt0p2rTGbNe5ACirBOCrK3vJZXQ
 DWqXfx+3Ppw5/wjNVwmCHiJjSAFHtaDuKA4+5w91MCIupTpFlZwuNp7DIS7ZqgK0tp0THraIYG4
 T/DwmUkSCVU2eDY5AKQsnPawQ40E1ObspL6YXosQootjYGn6cLzVdxTIZtoumHYnR8hjYCOe8v6
 n1zE7nkgJU1/ZEZSB9AdzwOnVoDGQo3AGAdzzSZXR8HAQSR7bUSx4WghcwOHwPqHknOENhEalyQ
 AkzWvo+OPypTCt0JWbg/8W/gbjT4EqR12JIgvfoHWIGnDJnZGIArzrFPRpqdzaZslm2s1BqgPq8
 mXOQ5q/g//eR3gbntzQyo46dmmaJO2
X-Received: by 2002:a05:6a20:7294:b0:39b:ce34:f7df with SMTP id
 adf61e73a8af0-3b22e7ac6efmr10964896637.5.1778978044603; 
 Sat, 16 May 2026 17:34:04 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:34:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 63/63] linux-user/aarch64: Implement FPMR signal frames
Date: Sat, 16 May 2026 17:30:02 -0700
Message-ID: <20260517003002.321430-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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


