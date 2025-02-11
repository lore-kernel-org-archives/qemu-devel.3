Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A58FC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6U-0007Yc-V6; Tue, 11 Feb 2025 11:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5a-0006U7-6I
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5X-00038P-Po
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso39884245e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291178; x=1739895978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jzv36lXWBV913+k/GNHt1ww49Fjtm1eDjzOizNTD6d8=;
 b=pcYZep9bJdBNgPmV8v0FBL2cktz52JSy58uV6+Co5rpRadz6J2UOIGl9q3Vhdx/RUv
 veaS0LwhqmH6ItAsuPte5F7euPpKiGuBkV7Jb02WCpVn4QiZNsFhAfmq9IWLMhrJ727D
 UTJfuW6TmFglKax6L5ntfAiq0glzRPi0fTKSS04+6A7QPPb0WHAlVwjlzY2PdY77Ydfy
 Mv93TqjXAf2zGf/zBxPIQty8/fA8bLUoBf3UgydyvhLKRF5DVTJscKitMgnzTBMROO4o
 51KQ5yj/27aDPFoJMhbVBP066aZbTfll5ygiYSKbKRtg0AZ0yGyZ1SjQXmgUaEQx8SZr
 y5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291178; x=1739895978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jzv36lXWBV913+k/GNHt1ww49Fjtm1eDjzOizNTD6d8=;
 b=cjZc1MnqFItjXX0YsTMsARNLsXUJRb53Tmt7il1II7ezFnRYJl90S9P5eKg9mb9/ky
 anYHpni3KUTwiYwZePu0il+nytZnscv3SH50aJ68tod0wuIWk3/an/SctQ0Z0XUB0UYq
 V+CkGZrih7XORTmtACOqN9402GGibTZdfi+/kM8+1Wq2WPq3uhp1wOfBhDRy5HqgVRKj
 CsFFN5EBLchOY0DIlbDFh5n6iOggiRnX5Lbl0WZOb3gVrIsDKmxdD3sAN1xvm4dwj5My
 Gjd8vKkgYwYuzADt0LNEn/dtIH11WF7kOJos3XN5wzVC89J9FUe1sbja6QopnXPXoNrl
 O3EA==
X-Gm-Message-State: AOJu0YzeotxV+nYztrUWDOM6JypW2rRXvN4jE6RTTg/gk1IVHlUVEJKf
 cXywBbrDLhC/37Ysu3zGs9xYoycZUpkClOubTD7PVv9acgP30F9TuIyX+XMoMGFyX1v3LMEFj5F
 v
X-Gm-Gg: ASbGncssG5kcPsmQosDvDoNiRgrCY6gsZdfXAM6NQyj05LHX+JbjcZQB3RxLimK33aE
 4imkOyhEScuVXhMYwnsJOf4Jox/qZ6kfE1aEXNOd1H+Gi/NjB0DZGmALPAdfXifMuWdC7RxTwGk
 h7UizGxCgWwNb2ueY9TpI3egT0UWn7hT85kAyZx1fiTLmqdXvSaLFNitfkMhFzyLB/GVmcfYTEF
 iQeTIUtx/Zc2dVeAuVCtPNKZ9jqcb7bEF+35P84WCEXGpiozhfYiBvmOOyZRoH0WJA5rKGHWVsb
 eHVls+O8e2myEtXfBF/B
X-Google-Smtp-Source: AGHT+IHajPYtprDpY48QTZZnVuinSQ/9HafsTscv1jHT3QWbtw/7yePWQE2vnvzUuN7Ppv1keHO1hA==
X-Received: by 2002:a05:600c:468f:b0:436:e3ea:4447 with SMTP id
 5b1f17b1804b1-439249c38afmr179943575e9.30.1739291178370; 
 Tue, 11 Feb 2025 08:26:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/68] target/arm: Handle FPCR.NEP for scalar FABS and FNEG
Date: Tue, 11 Feb 2025 16:25:06 +0000
Message-Id: <20250211162554.4135349-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Handle FPCR.NEP merging for scalar FABS and FNEG; this requires
an extra parameter to do_fp1_scalar_int(), since FMOV scalar
does not have the merging behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 804b6b5b67d..3195cb5fef1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8426,21 +8426,30 @@ typedef struct FPScalar1Int {
 } FPScalar1Int;
 
 static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
-                              const FPScalar1Int *f)
+                              const FPScalar1Int *f,
+                              bool merging)
 {
     switch (a->esz) {
     case MO_64:
         if (fp_access_check(s)) {
             TCGv_i64 t = read_fp_dreg(s, a->rn);
             f->gen_d(t, t);
-            write_fp_dreg(s, a->rd, t);
+            if (merging) {
+                write_fp_dreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_dreg(s, a->rd, t);
+            }
         }
         break;
     case MO_32:
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_sreg(s, a->rn);
             f->gen_s(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_sreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     case MO_16:
@@ -8450,7 +8459,11 @@ static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_hreg(s, a->rn);
             f->gen_h(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_hreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     default:
@@ -8464,21 +8477,21 @@ static const FPScalar1Int f_scalar_fmov = {
     tcg_gen_mov_i32,
     tcg_gen_mov_i64,
 };
-TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov, false)
 
 static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_absh,
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
     gen_vfp_negs,
     gen_vfp_negd,
 };
-TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg, true)
 
 typedef struct FPScalar1 {
     void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
-- 
2.34.1


