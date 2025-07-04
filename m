Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C64C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhL7-0002By-QY; Fri, 04 Jul 2025 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIR-0005Ni-Gw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:49 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIP-00064n-Qa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:47 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ef891cd058so853280fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638905; x=1752243705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMdweUCeXr0ws90t7Pfr3ZnPLeSvedfSjs9EhIvlp+U=;
 b=Zbj04D9jXpN0WQk/OUr8G1nC6actZ2wzaVw2Ls26iPwn5FnFEb3lNYz8VOVRkNbJ98
 Y/SxRDsO2u7lsi2omPei0ZxAfOrNLEAK+mvGoeeVdCcAyTAwB/PStyu+a4/Ic3eStU62
 OliLZih+P8cujHeSWsamLUMK47RnN/e9YWnOvuEdqIC32jVW+M5sbE95m81BvGHjftmG
 I8GtODwBXxEn3SGicYSan3xGp1vSZ0xwBJQ77UG/44K71OUY7YI/S8l5PTD5WgHTSaQK
 iFpCfHGoctfUtrKSPbCJRR4AiXCI7+uK/grjqut5C+jFYK0jiBiJ59+Od/zaYPsbdmQh
 lkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638905; x=1752243705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMdweUCeXr0ws90t7Pfr3ZnPLeSvedfSjs9EhIvlp+U=;
 b=RWnFYWQG7jCCal+n6XaIo6Rj0WcNRJ50ar7eM6G1ZFzD4homdudJthMVG8nbw+iWcC
 amVJlpjQCuJ9f9EWWhvo8DSOEuqH8wth63xtzIdMJd+OJS2EF4M78vt4wSI/yM1CKQkz
 Exidm7DbDb8nUorFWmqLHkqArzkyMJotogDjCYIEGUdzowo86SnI3OusRyFIYaVgHnUj
 jrYK9ZQyGMPbgmafPiXptUY7r5bi0stDy49gTsDWpEI2DbHEWP3YCv32OIPRT6g/+E1R
 +TgsEME83zfDCUk3hUPw5TchgfKNDhyYWztuVQDYJP2Bzo5KEcOKeHNfOzw/Ei0k+1jy
 8pvw==
X-Gm-Message-State: AOJu0Yy9HfylhSfmoz6G1tadQA6BbTb9fsRaxHfBiQiCAEg9gt5k1Va8
 TFai9XEOilbmUxdfwnWFUFx8wVW+OJSpCdKtusSG7QQ6nAZq41PiCDOYTOWZsPOmCIwBQrasjSA
 CsutCQWs=
X-Gm-Gg: ASbGncvtoDfBncu7cxIB3AUUEFkXw0cl8krYZFkGelqRi5ZbOVX9FbWUSCNlLP3quSC
 hFXWYh638tDVg2PR9J2zWkUbuHKXUkKRKaTu7fhimEGX4Sl/stKYDlg40w6TmyltZWHp+SEh6dH
 I4wBuMms+2Itw7DquRaNQgoyt6hST1Xe58wlNh5pl59Qw/4J+g5Ax0wqAH50am3XZyXaFK4N7XX
 fe8ElJHF9Rv53v2JXb51IJEoz0/MZBVP/43DOiJh4wfMF3A/qXVQQLvKZX1BrHe5Ddh/176YI1j
 GyNcIWeOaFk0zKbTw0xKB4XOpqY2L0a09bikukaGMsq1AcHBiKHShxVFDEmzOnFGHqa2AfCDrA9
 I7Ir0onC58+PevoEuERmHEqkoNCn9KiK0L5gkI56P1UUEOPCr
X-Google-Smtp-Source: AGHT+IE0lu6vFD2ajOMSh136r0dJeSbFhdYUChrcNZLm2xpS5cMQSWm1GmlfALxyJYmk10F8bMqUmw==
X-Received: by 2002:a05:6870:d907:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-2f796d8020fmr1716287fac.38.1751638904659; 
 Fri, 04 Jul 2025 07:21:44 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 029/108] target/arm: Introduce gen_gvec_sve2_sqdmulh
Date: Fri,  4 Jul 2025 08:19:52 -0600
Message-ID: <20250704142112.1018902-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

To be used by both SVE2 and SME2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  4 ++++
 target/arm/tcg/gengvec64.c     | 11 +++++++++++
 target/arm/tcg/translate-sve.c |  8 +-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 8a9f4b2053..993dde61a4 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,6 +225,10 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz);
+
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs,
                  int len, int rn, int imm, MemOp align);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs,
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2617cde0a5..2429cab1b8 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -369,3 +369,14 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
+
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
+        gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
+    };
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d2cd298b5b..7e304245c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5948,6 +5948,7 @@ TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
  */
 
 TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
@@ -5966,13 +5967,6 @@ TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(PMUL_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
            gen_helper_gvec_pmul_b, a, 0)
 
-static gen_helper_gvec_3 * const sqdmulh_zzz_fns[4] = {
-    gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
-    gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
-};
-TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
-           sqdmulh_zzz_fns[a->esz], a, 0)
-
 static gen_helper_gvec_3 * const sqrdmulh_zzz_fns[4] = {
     gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
     gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
-- 
2.43.0


