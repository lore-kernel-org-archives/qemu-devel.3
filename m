Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6818ECD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX260-0007Rg-Ns; Tue, 09 Jun 2026 15:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21q-0003YG-7h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21f-0003zr-Uf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so27452415ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032874; x=1781637674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVjmzdyr5Lm6lgVp2HxXwqT/cVK11tOws/vdOSgu1Mg=;
 b=nnSj6WRduA9Ydh66/gVZtZznGi3hELQ+au8hIBaoEixVOdPEak5ls5Tf8lK1fz4m6I
 dBe+MaqIA9HaDRu+ivL5QB033bBzk86G2rdA16+Yxy4hgleKSUcY+lTZwQkjNlGmxiGL
 MC2EZGuturPltHVPgpp6U6JE7kEm2SFEu/Ypn032rwzVnvqL7myu+mzNa5rX2SviP+0Y
 C6mW9eXR8jCyEAOQvcgo+JyOay3jdnX8+DAu6yWE831NlwErKzuRBm78jUlWp7qcLQ+6
 la3oN5V+hNzJpW+0Jb2IRUmhV0q0zsGE5bXA98a0qGDg2quawkjbiNOx4YkGLkt+GSxW
 vQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032874; x=1781637674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xVjmzdyr5Lm6lgVp2HxXwqT/cVK11tOws/vdOSgu1Mg=;
 b=ejpAu9Q8nLxlBP1ANKpQIoaZavAMTAmxuzLYeLOi97PQ0YunC1X5+mQkgQ0ZlP+MN+
 PIUyiz7gZe5Ixz2DfCBp8sGdvOhxzQWCXJlIUlX2s/MAwxwvwICmqdAQ/JbrDv5MS4os
 P8R2son4YspW9x14IzVu/d/dDFuRrdF4aRL/VG1BiehABsSBsxDXRLAJEupH4AOTCXBJ
 t9qtLiefVRUggtwF7GlGwTem2XNmH3g+tWze6tDKG+qgwwdq5wwaFBwrjOXFUPsgO+mu
 u9ZnQys38teLBnR9ZL+0wwab2FWm7EGjuPMxFISGEMTBxhiHlc7pw4/9q6NagBLaFR9r
 PyKA==
X-Gm-Message-State: AOJu0Yyf4HPQdFoM9LD9FMLc0LtJ2ehX+kuwnHU7HWwSHSSy4j3w/iBi
 ROW7Zt+l1xLsTmHEYRmzDUr2Cc2gaY2vSmmHkGsD8V3YCFM6ngvs80stmfqM77oYa89DAGjDi9w
 hk41ZvzU=
X-Gm-Gg: Acq92OGr/r03yBBFzNOgEjRzpK7K7AREEzFqJEwHF0oRYo1PphYKSOSox+vaOySK3WE
 VvUXiN7rIjpKCle/3URGkTjBKm/ffi3S0HE6LCVs+3DOvc8UpEQpQtNS6sKht4KAjDX6vCK/f2m
 DlyRui3g914cbv2NDU1ySsfN/v8EB7QqRD8O/J8HseCEiRpj4n8mIC1LkgAv4MxFO8tTxVXDQH0
 n99fpq39kI46hoMBpv2kefLfpNkwdMEKkaZNqj/mjMKmc+4kLt8pbCCN5WAxbEOQy1QPDh/jcAb
 G/lIyE5kxEz+F4nZSY+9/KDnNRLLgnCQILO6kL9CLz+jIL6RPoQMGokbo3+oEaY3eJbbSFVkTcB
 e23jfBV0azf4BND+7st5aMXx1g8vw90bq1hfkRna2iKPQcSmpHHPzaJaY//r/jQ9HaGZPEp3wI0
 /MPiSYo2KsbU/9+6NuBlnzlJAsrqJKR1O+IphPECo=
X-Received: by 2002:a17:903:1b6c:b0:2ba:6601:8e3d with SMTP id
 d9443c01a7336-2c1ec513601mr183184395ad.9.1781032874135; 
 Tue, 09 Jun 2026 12:21:14 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 04/45] target/arm: Generalize TRANS_FEAT_STREAMING_SME2
Date: Tue,  9 Jun 2026 12:20:28 -0700
Message-ID: <20260609192110.752384-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Rename to TRANS_FEAT_STREAMING_IF and add a new parameter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  6 +++---
 target/arm/tcg/translate-sve.c | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d4bcc5bad4..beaffe914e 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -877,12 +877,12 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
 
 /*
  * For SVE insns which are only valid in Streaming SVE mode when
- * SME2 is implemented
+ * FEAT_STREAM is implemented.
  */
-#define TRANS_FEAT_STREAMING_SME2(NAME, FEAT, FUNC, ...)          \
+#define TRANS_FEAT_STREAMING_IF(NAME, FEAT, FEAT_STREAM, FUNC, ...) \
     static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
     {                                                             \
-        s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);      \
+        s->is_nonstreaming = !dc_isar_feature(FEAT_STREAM, s);    \
         return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
     }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fb9d379184..997d6b0451 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4261,9 +4261,9 @@ static gen_helper_gvec_4_ptr * const sve2_famax_zpzz_fns[4] = {
     gen_helper_sve2_famax_s,
     gen_helper_sve2_famax_d
 };
-TRANS_FEAT_STREAMING_SME2(FAMAX, aa64_sme2_or_sve2_faminmax,
-                          gen_gvec_fpst_arg_zpzz,
-                          sve2_famax_zpzz_fns[a->esz], a)
+TRANS_FEAT_STREAMING_IF(FAMAX, aa64_sme2_or_sve2_faminmax, aa64_sme2,
+                        gen_gvec_fpst_arg_zpzz,
+                        sve2_famax_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve2_famin_zpzz_fns[4] = {
     NULL,
@@ -4271,9 +4271,9 @@ static gen_helper_gvec_4_ptr * const sve2_famin_zpzz_fns[4] = {
     gen_helper_sve2_famin_s,
     gen_helper_sve2_famin_d
 };
-TRANS_FEAT_STREAMING_SME2(FAMIN, aa64_sme2_or_sve2_faminmax,
-                          gen_gvec_fpst_arg_zpzz,
-                          sve2_famin_zpzz_fns[a->esz], a)
+TRANS_FEAT_STREAMING_IF(FAMIN, aa64_sme2_or_sve2_faminmax, aa64_sme2,
+                        gen_gvec_fpst_arg_zpzz,
+                        sve2_famin_zpzz_fns[a->esz], a)
 
 typedef void gen_helper_sve_fp2scalar(TCGv_ptr, TCGv_ptr, TCGv_ptr,
                                       TCGv_i64, TCGv_ptr, TCGv_i32);
-- 
2.43.0


