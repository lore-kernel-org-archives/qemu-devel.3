Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C6E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEi-0007sI-JU; Tue, 17 Dec 2024 12:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEd-0007rK-SO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEZ-00069V-7c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so60638495e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455983; x=1735060783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ahv5uE67Du1OI8fNWrJ58JFfvDykgnbrnsg5xcHCSec=;
 b=DyIT61xXINA8lA9R5PZr0d0p6LQcXXZlaCUsda5VjJnJ6WT6KgDF+IY7EHcAZ5Q6xw
 CRWCNlzCqRTzgim8kvPGYwHaquXCx68g94TFa5jxSVj3znotEwHpEzyiWTFJPLIlCVRq
 hsEW79k3/dGD6DS8o9fDDNb6nQrcksYT3okGympweu02er83UCmabhVBL1hcWx2iPUDE
 FovfHWkpGsDvEfGYJkmdQcuLQszzTllaDRcSSKioHJnqpqcH/DXgJJrnZn897/7U+3Lq
 3tTkPQn5/8/4S92w26iEMZq7HpLJZ9RsUVv2Flhnvb/4rPrH8DlvyxlbuAnzvwD3OcyM
 Xntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455983; x=1735060783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahv5uE67Du1OI8fNWrJ58JFfvDykgnbrnsg5xcHCSec=;
 b=cHUmLWxtmVcf9K2vMaYAMiMSB1ZIJegzyOoEL25iDO6ySmZNjAnE/Td/vE8tEPALYA
 qA/24wWKmYsFSUVTqAXE+h3DtjIAYTYoJ2rKMx2tOrYyAXlc0I1dBSt2gySrWhUdn28i
 p6P4Ykuj7etXc0L8ZMJKrdT4ffOiAIwTZgb6FDZ2pJJgoRY3QyDDSgHoLm4qtfRUwZfo
 RBX6bbKlzl5LYEWkgD/p8vIT2+OaVMI50fOAk1FAEu0ljMg/aY+Umer0em4MXECaakS+
 PNIKu2+A966DIQtTpfrM04qSx1lOQX/GT7OJj+gKzoUOgP9msw9f+FArwx7UoDMuH5QE
 ouLg==
X-Gm-Message-State: AOJu0Yz2DoUOWpo3230I6q/smn3+8kcTTH4k2OP21pRiFsm0dqwymfcG
 qU+lIjskFyuwjasG5KVuQbg7uWfEQ1tvPK4TrvAK2Sb0lR9qsxBZR89wRkl4JKxd9ZLiUtIrt1I
 5
X-Gm-Gg: ASbGnctHXtwfDW0oXuxdIk6qIPTZcxZVX0pDxvMvWCiGO9IvuolO/tgV3ZEezgai6rk
 FKQeSm3/WC4SzX6LgFXZ5QsMz3JoN80FSbFXB1RdqiW6cY1nKRd9RzVGrUzpCcCVVJ7Tb+G3i9w
 FGGB+Pafc9MMweLu3iA+Ik7d+womMFlx4G2Xs34maCuAcvVRhaBEuZJL+qr+wz9FTfRU4nh12ie
 Nv47Q88eiCL3/n6HZkIZ43G9fE4UD9ye+EQhR/Lzd5TvCM6V91HgClUx59/s9k=
X-Google-Smtp-Source: AGHT+IHdq7fUrZp0JeUiPUbMG6sUIJKgn2D45o6u+lmFIrjlEsUvHVmv7vvgQvTnJysgdIUt1PiRpw==
X-Received: by 2002:a05:600c:154b:b0:435:172:5052 with SMTP id
 5b1f17b1804b1-4362aa113e3mr130323935e9.1.1734455983133; 
 Tue, 17 Dec 2024 09:19:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] target/arm: Convert helper-a64.c to fpst alias
Date: Tue, 17 Dec 2024 17:19:21 +0000
Message-Id: <20241217171937.3899947-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h | 94 +++++++++++++++++------------------
 target/arm/tcg/helper-a64.c | 98 +++++++++++++------------------------
 2 files changed, 80 insertions(+), 112 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 3c0774139b2..f1bac6688ae 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -23,57 +23,57 @@ DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
 DEF_HELPER_1(msr_set_allint_el1, void, env)
-DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
-DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
-DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
-DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
-DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, ptr)
-DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, ptr)
+DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, fpst)
+DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, fpst)
+DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, fpst)
+DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, fpst)
+DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, fpst)
+DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, fpst)
 DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
-DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
-DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
-DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
-DEF_HELPER_FLAGS_3(recpsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
-DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
-DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
+DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
+DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
+DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
+DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
+DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
+DEF_HELPER_FLAGS_3(recpsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
+DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
+DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
+DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
 DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, env)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
-DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_FLAGS_3(advsimd_minnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_addh, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_subh, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_mulh, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_divh, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, ptr)
-DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
-DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
-DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, ptr)
-DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, ptr)
-DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
-DEF_HELPER_4(advsimd_muladdh, f16, f16, f16, f16, ptr)
-DEF_HELPER_3(advsimd_add2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_sub2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_mul2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_div2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_max2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_min2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_maxnum2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_minnum2h, i32, i32, i32, ptr)
-DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, ptr)
-DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, ptr)
-DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
-DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
+DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(advsimd_minnumh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_addh, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_subh, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_mulh, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_divh, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, fpst)
+DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, fpst)
+DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, fpst)
+DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, fpst)
+DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, fpst)
+DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, fpst)
+DEF_HELPER_4(advsimd_muladdh, f16, f16, f16, f16, fpst)
+DEF_HELPER_3(advsimd_add2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_sub2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_mul2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_div2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_max2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_min2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_maxnum2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_minnum2h, i32, i32, i32, fpst)
+DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, fpst)
+DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, fpst)
+DEF_HELPER_2(advsimd_rinth_exact, f16, f16, fpst)
+DEF_HELPER_2(advsimd_rinth, f16, f16, fpst)
 
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index fb6fe0fcaa9..ff48bac1a8e 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -130,40 +130,38 @@ static inline uint32_t float_rel_to_flags(int res)
     return flags;
 }
 
-uint64_t HELPER(vfp_cmph_a64)(uint32_t x, uint32_t y, void *fp_status)
+uint64_t HELPER(vfp_cmph_a64)(uint32_t x, uint32_t y, float_status *fp_status)
 {
     return float_rel_to_flags(float16_compare_quiet(x, y, fp_status));
 }
 
-uint64_t HELPER(vfp_cmpeh_a64)(uint32_t x, uint32_t y, void *fp_status)
+uint64_t HELPER(vfp_cmpeh_a64)(uint32_t x, uint32_t y, float_status *fp_status)
 {
     return float_rel_to_flags(float16_compare(x, y, fp_status));
 }
 
-uint64_t HELPER(vfp_cmps_a64)(float32 x, float32 y, void *fp_status)
+uint64_t HELPER(vfp_cmps_a64)(float32 x, float32 y, float_status *fp_status)
 {
     return float_rel_to_flags(float32_compare_quiet(x, y, fp_status));
 }
 
-uint64_t HELPER(vfp_cmpes_a64)(float32 x, float32 y, void *fp_status)
+uint64_t HELPER(vfp_cmpes_a64)(float32 x, float32 y, float_status *fp_status)
 {
     return float_rel_to_flags(float32_compare(x, y, fp_status));
 }
 
-uint64_t HELPER(vfp_cmpd_a64)(float64 x, float64 y, void *fp_status)
+uint64_t HELPER(vfp_cmpd_a64)(float64 x, float64 y, float_status *fp_status)
 {
     return float_rel_to_flags(float64_compare_quiet(x, y, fp_status));
 }
 
-uint64_t HELPER(vfp_cmped_a64)(float64 x, float64 y, void *fp_status)
+uint64_t HELPER(vfp_cmped_a64)(float64 x, float64 y, float_status *fp_status)
 {
     return float_rel_to_flags(float64_compare(x, y, fp_status));
 }
 
-float32 HELPER(vfp_mulxs)(float32 a, float32 b, void *fpstp)
+float32 HELPER(vfp_mulxs)(float32 a, float32 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float32_squash_input_denormal(a, fpst);
     b = float32_squash_input_denormal(b, fpst);
 
@@ -176,10 +174,8 @@ float32 HELPER(vfp_mulxs)(float32 a, float32 b, void *fpstp)
     return float32_mul(a, b, fpst);
 }
 
-float64 HELPER(vfp_mulxd)(float64 a, float64 b, void *fpstp)
+float64 HELPER(vfp_mulxd)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float64_squash_input_denormal(a, fpst);
     b = float64_squash_input_denormal(b, fpst);
 
@@ -193,21 +189,18 @@ float64 HELPER(vfp_mulxd)(float64 a, float64 b, void *fpstp)
 }
 
 /* 64bit/double versions of the neon float compare functions */
-uint64_t HELPER(neon_ceq_f64)(float64 a, float64 b, void *fpstp)
+uint64_t HELPER(neon_ceq_f64)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float64_eq_quiet(a, b, fpst);
 }
 
-uint64_t HELPER(neon_cge_f64)(float64 a, float64 b, void *fpstp)
+uint64_t HELPER(neon_cge_f64)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float64_le(b, a, fpst);
 }
 
-uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
+uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float64_lt(b, a, fpst);
 }
 
@@ -216,10 +209,8 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
  * multiply-add-and-halve.
  */
 
-uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float16_squash_input_denormal(a, fpst);
     b = float16_squash_input_denormal(b, fpst);
 
@@ -231,10 +222,8 @@ uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, void *fpstp)
     return float16_muladd(a, b, float16_two, 0, fpst);
 }
 
-float32 HELPER(recpsf_f32)(float32 a, float32 b, void *fpstp)
+float32 HELPER(recpsf_f32)(float32 a, float32 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float32_squash_input_denormal(a, fpst);
     b = float32_squash_input_denormal(b, fpst);
 
@@ -246,10 +235,8 @@ float32 HELPER(recpsf_f32)(float32 a, float32 b, void *fpstp)
     return float32_muladd(a, b, float32_two, 0, fpst);
 }
 
-float64 HELPER(recpsf_f64)(float64 a, float64 b, void *fpstp)
+float64 HELPER(recpsf_f64)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float64_squash_input_denormal(a, fpst);
     b = float64_squash_input_denormal(b, fpst);
 
@@ -261,10 +248,8 @@ float64 HELPER(recpsf_f64)(float64 a, float64 b, void *fpstp)
     return float64_muladd(a, b, float64_two, 0, fpst);
 }
 
-uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float16_squash_input_denormal(a, fpst);
     b = float16_squash_input_denormal(b, fpst);
 
@@ -276,10 +261,8 @@ uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, void *fpstp)
     return float16_muladd(a, b, float16_three, float_muladd_halve_result, fpst);
 }
 
-float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, void *fpstp)
+float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float32_squash_input_denormal(a, fpst);
     b = float32_squash_input_denormal(b, fpst);
 
@@ -291,10 +274,8 @@ float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, void *fpstp)
     return float32_muladd(a, b, float32_three, float_muladd_halve_result, fpst);
 }
 
-float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
+float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float64_squash_input_denormal(a, fpst);
     b = float64_squash_input_denormal(b, fpst);
 
@@ -307,9 +288,8 @@ float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
 }
 
 /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
-uint32_t HELPER(frecpx_f16)(uint32_t a, void *fpstp)
+uint32_t HELPER(frecpx_f16)(uint32_t a, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     uint16_t val16, sbit;
     int16_t exp;
 
@@ -340,9 +320,8 @@ uint32_t HELPER(frecpx_f16)(uint32_t a, void *fpstp)
     }
 }
 
-float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
+float32 HELPER(frecpx_f32)(float32 a, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     uint32_t val32, sbit;
     int32_t exp;
 
@@ -373,9 +352,8 @@ float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
     }
 }
 
-float64 HELPER(frecpx_f64)(float64 a, void *fpstp)
+float64 HELPER(frecpx_f64)(float64 a, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     uint64_t val64, sbit;
     int64_t exp;
 
@@ -453,9 +431,8 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t val, uint32_t bytes)
 #define ADVSIMD_HELPER(name, suffix) HELPER(glue(glue(advsimd_, name), suffix))
 
 #define ADVSIMD_HALFOP(name) \
-uint32_t ADVSIMD_HELPER(name, h)(uint32_t a, uint32_t b, void *fpstp) \
+uint32_t ADVSIMD_HELPER(name, h)(uint32_t a, uint32_t b, float_status *fpst) \
 { \
-    float_status *fpst = fpstp; \
     return float16_ ## name(a, b, fpst);    \
 }
 
@@ -469,11 +446,11 @@ ADVSIMD_HALFOP(minnum)
 ADVSIMD_HALFOP(maxnum)
 
 #define ADVSIMD_TWOHALFOP(name)                                         \
-uint32_t ADVSIMD_HELPER(name, 2h)(uint32_t two_a, uint32_t two_b, void *fpstp) \
+uint32_t ADVSIMD_HELPER(name, 2h)(uint32_t two_a, uint32_t two_b,       \
+                                  float_status *fpst)                   \
 { \
     float16  a1, a2, b1, b2;                        \
     uint32_t r1, r2;                                \
-    float_status *fpst = fpstp;                     \
     a1 = extract32(two_a, 0, 16);                   \
     a2 = extract32(two_a, 16, 16);                  \
     b1 = extract32(two_b, 0, 16);                   \
@@ -493,10 +470,8 @@ ADVSIMD_TWOHALFOP(minnum)
 ADVSIMD_TWOHALFOP(maxnum)
 
 /* Data processing - scalar floating-point and advanced SIMD */
-static float16 float16_mulx(float16 a, float16 b, void *fpstp)
+static float16 float16_mulx(float16 a, float16 b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
-
     a = float16_squash_input_denormal(a, fpst);
     b = float16_squash_input_denormal(b, fpst);
 
@@ -514,16 +489,14 @@ ADVSIMD_TWOHALFOP(mulx)
 
 /* fused multiply-accumulate */
 uint32_t HELPER(advsimd_muladdh)(uint32_t a, uint32_t b, uint32_t c,
-                                 void *fpstp)
+                                 float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return float16_muladd(a, b, c, 0, fpst);
 }
 
 uint32_t HELPER(advsimd_muladd2h)(uint32_t two_a, uint32_t two_b,
-                                  uint32_t two_c, void *fpstp)
+                                  uint32_t two_c, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float16  a1, a2, b1, b2, c1, c2;
     uint32_t r1, r2;
     a1 = extract32(two_a, 0, 16);
@@ -545,31 +518,27 @@ uint32_t HELPER(advsimd_muladd2h)(uint32_t two_a, uint32_t two_b,
 
 #define ADVSIMD_CMPRES(test) (test) ? 0xffff : 0
 
-uint32_t HELPER(advsimd_ceq_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(advsimd_ceq_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     int compare = float16_compare_quiet(a, b, fpst);
     return ADVSIMD_CMPRES(compare == float_relation_equal);
 }
 
-uint32_t HELPER(advsimd_cge_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(advsimd_cge_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     int compare = float16_compare(a, b, fpst);
     return ADVSIMD_CMPRES(compare == float_relation_greater ||
                           compare == float_relation_equal);
 }
 
-uint32_t HELPER(advsimd_cgt_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(advsimd_cgt_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     int compare = float16_compare(a, b, fpst);
     return ADVSIMD_CMPRES(compare == float_relation_greater);
 }
 
-uint32_t HELPER(advsimd_acge_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(advsimd_acge_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float16 f0 = float16_abs(a);
     float16 f1 = float16_abs(b);
     int compare = float16_compare(f0, f1, fpst);
@@ -577,9 +546,8 @@ uint32_t HELPER(advsimd_acge_f16)(uint32_t a, uint32_t b, void *fpstp)
                           compare == float_relation_equal);
 }
 
-uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float16 f0 = float16_abs(a);
     float16 f1 = float16_abs(b);
     int compare = float16_compare(f0, f1, fpst);
@@ -587,12 +555,12 @@ uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, void *fpstp)
 }
 
 /* round to integral */
-uint32_t HELPER(advsimd_rinth_exact)(uint32_t x, void *fp_status)
+uint32_t HELPER(advsimd_rinth_exact)(uint32_t x, float_status *fp_status)
 {
     return float16_round_to_int(x, fp_status);
 }
 
-uint32_t HELPER(advsimd_rinth)(uint32_t x, void *fp_status)
+uint32_t HELPER(advsimd_rinth)(uint32_t x, float_status *fp_status)
 {
     int old_flags = get_float_exception_flags(fp_status), new_flags;
     float16 ret;
-- 
2.34.1


