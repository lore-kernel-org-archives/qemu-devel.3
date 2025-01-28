Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A76C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryz-00044y-UI; Tue, 28 Jan 2025 15:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry8-0002RF-Un
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry7-0001g9-81
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso43788085e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095233; x=1738700033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zg6uEkcXsxdOHGhb9hB+d5zAFRHn6utnOyIvbOKHYjs=;
 b=wwYlzdpFeGJY54BxYodZ7tr3LlaIK0Wd1nXQSeN/L0pJdUgR2XpwFNm1l+WsP2psqb
 u39bHQy6B+PtyEM3AOxgHAS0jEmhMsX4FfEW58o4lbF4Vjd8sLz7YplQKSErjMJMXKVy
 HrcU/sxqNJEEXyRf4RbsO/RVlMofuZ2PrKeKkxKok16Kjo6d4cyu4Xt24y6m09ncQf9D
 3RhRDXPXJ0ND1Bh9+7CO4qR/k1YroggaVEeLQC/+D0Me8MInF9YISiIZk6yGzuSNCvWz
 np4JD2mBodQqv2inE9YANrGoISrbJ/gyPWiRmcdV7ZP9mUz2M7GZQxo//qUe30T2wgbD
 f72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095233; x=1738700033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zg6uEkcXsxdOHGhb9hB+d5zAFRHn6utnOyIvbOKHYjs=;
 b=AeK49+X+PZwz21W3aQJJkIFFztwSNZZ2tul2Q6hDtcleC0dtDV8z/Zxt7UlLvCT29Z
 cquKSEAtJBbPt1AMZhPRHEcu6qq69amkTWsRzuztNNMeSU9Poq9J5xv7zJP40JqXJPka
 AYgP3IEDxAu8EGh4Ac0tN5JIow7admQwb7gCRJUVjK19i8Q0Hn2gkWZLTkrU9AcnnD5R
 a9HbK+FRIKyt94moMJBGGQfdGPAS6Jaa7s7J2Y4+GfIg9ausrfitc1olMSxaSgRSJXnY
 t0XOTDnvDVSWzSXDA/U4wcTyIr7phqj65vVz6BGj99pPIvr6fPy6lNJVLg49LF4pdOTG
 sIGA==
X-Gm-Message-State: AOJu0YwUt69FG/zrDiqdnPOXIwSy8mYCGAQQdnrqCkMK8n02dRoXB/jB
 HFJaCcghKeNjHFPG04j82NEsShWNXgqw0tC7rozXyyAwy7ehcX8OBQTqMhFcWvsN8PVSUrXtXL7
 8
X-Gm-Gg: ASbGnctXyXHswZjB5bf0rsRsqQE3l09SA4GE/D3sOgxfDXPINhymh8L1zN6bzP1gTPD
 f1dvi2sfOqQdtRRY/sR6om2hpOLVnbpfWWJgdmmUS8RsPUuQM50+TdrQnw+BtQhEWyK+LmULdp9
 MmrJZpLgAD57HdyQMjT07ArYJIEAdmgZyaNeu1xwBXAGwKZYv8XI0+SbBMEhRPZODywAXS0FTvZ
 juek5RdgSaOYQ10i79lFilLSpVGHIJN1min6uMTA5M4qesC9L7Vihn7f4JAtsNRgc2lQFcd0OaZ
 dG5BSlqHq6RHGP7nzxOPiA==
X-Google-Smtp-Source: AGHT+IE3jKfFHTPiz76go8IAUVBaWbn2nAEH6rnxmcaYOtSSTL/ESiUVuLFIJS0Es+Rncld0UJTtbw==
X-Received: by 2002:a05:600c:b8d:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-438dc3c2221mr2420855e9.8.1738095233356; 
 Tue, 28 Jan 2025 12:13:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/36] target/arm: Remove redundant advsimd float16 helpers
Date: Tue, 28 Jan 2025 20:13:12 +0000
Message-Id: <20250128201314.44038-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The advsimd_addh etc helpers defined in helper-a64.c are identical to
the vfp_addh etc helpers defined in helper-vfp.c: both take two
float16 inputs (in a uint32_t type) plus a float_status* and are
simple wrappers around the softfloat float16_* functions.

(The duplication seems to be a historical accident: we added the
advsimd helpers in 2018 as part of the A64 implementation, and at
that time there was no f16 emulation in A32.  Then later we added the
A32 f16 handling by extending the existing VFP helper macros to
generate f16 versions as well as f32 and f64, and didn't realise we
could clean things up.)

Remove the now-unnecessary advsimd helpers and make the places that
generated calls to them use the vfp helpers instead. Many of the
helper functions were already unused.

(The remaining advsimd_ helpers are those which don't have vfp
versions.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-26-peter.maydell@linaro.org
---
 target/arm/tcg/helper-a64.h    |  8 --------
 target/arm/tcg/helper-a64.c    |  9 ---------
 target/arm/tcg/translate-a64.c | 16 ++++++++--------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 0c120bf3883..bac12fbe55b 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -47,14 +47,6 @@ DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
 DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, fpst)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
-DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
-DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
-DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
-DEF_HELPER_FLAGS_3(advsimd_minnumh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
-DEF_HELPER_3(advsimd_addh, f16, f16, f16, fpst)
-DEF_HELPER_3(advsimd_subh, f16, f16, f16, fpst)
-DEF_HELPER_3(advsimd_mulh, f16, f16, f16, fpst)
-DEF_HELPER_3(advsimd_divh, f16, f16, f16, fpst)
 DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, fpst)
 DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, fpst)
 DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, fpst)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 3b226daee78..05036089dd7 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -439,15 +439,6 @@ uint32_t ADVSIMD_HELPER(name, h)(uint32_t a, uint32_t b, float_status *fpst) \
     return float16_ ## name(a, b, fpst);    \
 }
 
-ADVSIMD_HALFOP(add)
-ADVSIMD_HALFOP(sub)
-ADVSIMD_HALFOP(mul)
-ADVSIMD_HALFOP(div)
-ADVSIMD_HALFOP(min)
-ADVSIMD_HALFOP(max)
-ADVSIMD_HALFOP(minnum)
-ADVSIMD_HALFOP(maxnum)
-
 #define ADVSIMD_TWOHALFOP(name)                                         \
 uint32_t ADVSIMD_HELPER(name, 2h)(uint32_t two_a, uint32_t two_b,       \
                                   float_status *fpst)                   \
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2b8b253479a..703f265f20e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5101,28 +5101,28 @@ static const FPScalar f_scalar_fmul = {
 TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul)
 
 static const FPScalar f_scalar_fmax = {
-    gen_helper_advsimd_maxh,
+    gen_helper_vfp_maxh,
     gen_helper_vfp_maxs,
     gen_helper_vfp_maxd,
 };
 TRANS(FMAX_s, do_fp3_scalar, a, &f_scalar_fmax)
 
 static const FPScalar f_scalar_fmin = {
-    gen_helper_advsimd_minh,
+    gen_helper_vfp_minh,
     gen_helper_vfp_mins,
     gen_helper_vfp_mind,
 };
 TRANS(FMIN_s, do_fp3_scalar, a, &f_scalar_fmin)
 
 static const FPScalar f_scalar_fmaxnm = {
-    gen_helper_advsimd_maxnumh,
+    gen_helper_vfp_maxnumh,
     gen_helper_vfp_maxnums,
     gen_helper_vfp_maxnumd,
 };
 TRANS(FMAXNM_s, do_fp3_scalar, a, &f_scalar_fmaxnm)
 
 static const FPScalar f_scalar_fminnm = {
-    gen_helper_advsimd_minnumh,
+    gen_helper_vfp_minnumh,
     gen_helper_vfp_minnums,
     gen_helper_vfp_minnumd,
 };
@@ -6902,10 +6902,10 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
-TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxnumh)
-TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minnumh)
-TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxh)
-TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minh)
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minh)
 
 TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
 TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
-- 
2.34.1


