Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE20EC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6T-0007Q3-0H; Tue, 11 Feb 2025 11:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5h-0006WV-19
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5f-0003An-8B
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43944181e68so26546585e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291185; x=1739895985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g0Z2ycNCf9W70DtwUEodSWkhpWcrCzYt5vzIvDPUjeo=;
 b=zM8xyrFyX9V+xUy1IJ41O3roYZowT3ZPMT+c3xCXn1+bFU0UuWNwzkvXfpJdn6+Rwx
 +5fwXxqbD79mJHlugpb9JzgNypP23V236UQcmAkIr7ajoiKvgDFWYqHiV/aIINmnRpCk
 xld2u70+8yb3Vm0MQYd/dbrWpxYAvJn0ryXQdmMwxuuuKw88H9F1WAocHhtiviCGFmzr
 7dhJHcA/YD4MvEHibCAtKje9QhXQY58V5/6JkpRoNhYxNYDj8KqxNi+TnGZP1yO/xhbH
 EZaF9l/TbcKiap8V17Lmc1Z1dUuH0ap4ASqZ9Zfxp8gWR359EJlkB3qfcQ3lnxIXWQ0y
 7wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291185; x=1739895985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0Z2ycNCf9W70DtwUEodSWkhpWcrCzYt5vzIvDPUjeo=;
 b=GGqbRdbTdJf7ENdMctoakQioGic6Y8m1rGtSsfEtB/eql5QGCIg4Hr/0TvfEAP6yoO
 tYhRpWX99B0KNL7oZskmVDIG5R2ANpngrj9B5+05D/9xHNTuGTRhw6hXyjHk7UiiOUaz
 +32vD19BO3iCDavE0KiauUxUUyFxJFWyS0+xqAHbMAW5/XEaMj3370i9wwsTzHMtT21P
 5oPp+i6Nb/IUt493OlXm9s3OU7Ir4/RGfY9CFg41HQ/WDC3/8D6zejkEJFC0h25Wst8a
 6HXbns78w1xhexmwkdS1D/lB8CiW5pkMY+4Y2DEUvg7LUwHu9MDTeZJ+cndeDDQNY7OB
 hUbA==
X-Gm-Message-State: AOJu0Yz/TVdNhBaPNAByace4Qj+KyWQhFEzcDW/LMl0UsHWwTxFM4es8
 4c0GS9df+wNryneJqoYQhUYRdthnT8+Xf1E8mwCZYtzHZs9nOMCrw5k6926SsjkNIsGXacFyu1j
 L
X-Gm-Gg: ASbGncuAWenK11BB1UItqmChHQM+HLx7TOTXhQZsGM85HVAU8rE8i6hUCeRvnHWiAsk
 yvDm2Z5JxRwRGL/HswJr7VvAk1eunEnhKxwWhv/XwNSrLwJ8HFyMIM9j0jaYWPnqZCEeFdAoFPl
 jUCiYSAQfTIVE2zb9XgYuwEy/KOYwq0sv6t8w+EviKG6artUVdHSPJlVGiJpZBcUKxgqdo4qGGG
 k3R3J8IbIl0tP8wmMNURiIZO9Vrs4npLrnbQQnGOO8ovGmJyYCzsSh6BB4RhPaMTpPg+nbRSUu6
 vABj8ifOp19l6TKmcNzj
X-Google-Smtp-Source: AGHT+IG+tqVWfbJtFllqGxcJXK/0XbgD7TuehYXtANeh+E0fGIWs8D4aazLYG7bB4vYHze3P3RnxyA==
X-Received: by 2002:a05:600c:1d1a:b0:439:5760:39a with SMTP id
 5b1f17b1804b1-439576003cfmr7345125e9.23.1739291185495; 
 Tue, 11 Feb 2025 08:26:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/68] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX immediate
Date: Tue, 11 Feb 2025 16:25:14 +0000
Message-Id: <20250211162554.4135349-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Implement the FPCR.AH semantics for the SVE FMAX and FMIN operations
that take an immediate as the second operand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c    |  8 ++++++++
 target/arm/tcg/translate-sve.c | 25 +++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 7ca95b8fa94..3c1d2624ed4 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1231,6 +1231,20 @@ DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i64, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve_ah_fmins_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fcvt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_dh, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 3631d85f23a..2f6fc82ee4f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4459,6 +4459,14 @@ DO_ZPZS_FP(sve_fmins_h, float16, H1_2, float16_min)
 DO_ZPZS_FP(sve_fmins_s, float32, H1_4, float32_min)
 DO_ZPZS_FP(sve_fmins_d, float64, H1_8, float64_min)
 
+DO_ZPZS_FP(sve_ah_fmaxs_h, float16, H1_2, helper_vfp_ah_maxh)
+DO_ZPZS_FP(sve_ah_fmaxs_s, float32, H1_4, helper_vfp_ah_maxs)
+DO_ZPZS_FP(sve_ah_fmaxs_d, float64, H1_8, helper_vfp_ah_maxd)
+
+DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, helper_vfp_ah_minh)
+DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, helper_vfp_ah_mins)
+DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, helper_vfp_ah_mind)
+
 /* Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 35f6d78a0e0..187bd647c29 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3821,14 +3821,35 @@ static bool do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
     TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
                name##_const[a->esz][a->imm], name##_fns[a->esz])
 
+#define DO_FP_AH_IMM(NAME, name, const0, const1)                        \
+    static gen_helper_sve_fp2scalar * const name##_fns[4] = {           \
+        NULL, gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_s,                                      \
+        gen_helper_sve_##name##_d                                       \
+    };                                                                  \
+    static gen_helper_sve_fp2scalar * const name##_ah_fns[4] = {        \
+        NULL, gen_helper_sve_ah_##name##_h,                             \
+        gen_helper_sve_ah_##name##_s,                                   \
+        gen_helper_sve_ah_##name##_d                                    \
+    };                                                                  \
+    static uint64_t const name##_const[4][2] = {                        \
+        { -1, -1 },                                                     \
+        { float16_##const0, float16_##const1 },                         \
+        { float32_##const0, float32_##const1 },                         \
+        { float64_##const0, float64_##const1 },                         \
+    };                                                                  \
+    TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
+               name##_const[a->esz][a->imm],                            \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
+
 DO_FP_IMM(FADD, fadds, half, one)
 DO_FP_IMM(FSUB, fsubs, half, one)
 DO_FP_IMM(FMUL, fmuls, half, two)
 DO_FP_IMM(FSUBR, fsubrs, half, one)
 DO_FP_IMM(FMAXNM, fmaxnms, zero, one)
 DO_FP_IMM(FMINNM, fminnms, zero, one)
-DO_FP_IMM(FMAX, fmaxs, zero, one)
-DO_FP_IMM(FMIN, fmins, zero, one)
+DO_FP_AH_IMM(FMAX, fmaxs, zero, one)
+DO_FP_AH_IMM(FMIN, fmins, zero, one)
 
 #undef DO_FP_IMM
 
-- 
2.34.1


