Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A3C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp1P-00011e-9h; Fri, 18 Jul 2025 13:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucouw-0004zR-C2
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucout-0000pt-Ie
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so1872037f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859836; x=1753464636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKf/B8VHSsBfUBqECITYfDua3rP9fWZhGEM4I7F0JlY=;
 b=wdR6pxGtvoQ3tRrDmA/2adNUm3WyNsGXCqBgEkE80WoaussEaBhfi5nvFXNo2T3BBm
 KhAaZoJ5O5A1V1ba8Tw/abIAcsdCvwszJCo+lzlxim5cTpr17NaYyg65jHxSps5r1IsC
 +FWN8czbl4NWoUQSuOo2DqMDBGOxUwX6it5FmtmOqcL2dixq0rY4zhTVskfRaKxOIZ+q
 MK08lwHQYYLhqJYKmz65RgIPdJPNLa9U2uRnIW4XdvWhl96fxA9bAei35o0eQD2rml+/
 PSr1l/waVFmi4eFa9Zs9ZRz/XJC19UcKc5Vx6skNyZIsgdNNGiKc/LZa4ZP3aV0BKkJg
 n+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859836; x=1753464636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKf/B8VHSsBfUBqECITYfDua3rP9fWZhGEM4I7F0JlY=;
 b=YQpAxaKSk5CpHY9ZsTj1pH1bMT7bsmX+aRA7rNMes/Gk2UamPlruQ2+eESHlFWTWU3
 yWy5dya8vYQ3Y1gneXBDyhW7RIStGgHFx1D7uCx7plWzlfDepwlPHz9NgPg+0P0JB7jQ
 WY6nrrtIIQr7ZahrO2ei+aqP7vjzcLdFJZL5/IdwJP+l13naShkdv5XGNicb2lu+oPeV
 mASn+jj1FdH/k8QM47vROCUzuvBUvyByh9Uz3ULB2tKM3uBVBdhe5xxY6w4Yh3UlUelY
 MdmFXhly2E4PoZ4cQI8on/hrKYHoAIhqQ15J/nJgySkd7dQOAbQy1HT+qsw/MNAeo29T
 lC7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2kyyuN+Ghr6rqqIJ6XT6d5lUcJzNLl+sV+7cWRCud82A0jo/gN9mi+gbYfFJ9usvge/HHKi535LnZ@nongnu.org
X-Gm-Message-State: AOJu0YxJUfgM/1r2GscdAnODaZ3nOHeX1v1EL5pN9BDLLHCZIr0JPZuD
 tGC1+XzSDBp4auD9zlW70A5kJrcdE6eDqBXVc5tHrhc3oLBF3SOO749QEtcYdmzPT2+8Q7MrEzX
 Ju2mX
X-Gm-Gg: ASbGnctcGt94MSUiR5MNUFsMYfjoCdGKPdOwHAXh+bMpPVBP7V1obDiGyyk2fpK1437
 L8poScFFG59w90gKDh9u/N4/HIx+ihnIFKlkpKThjbCO+ticI+yW1hJ1fiUB1przdTn89M5xWnH
 r+avTliqgzOkKaENxtKsqa6xcod9zxugNof4ANZc2dkyh775ro18jXDWNBCkgIkkEmBhCm8j57V
 Ik/oSX3nxM71HL++emqhAhywI329QCEFpTajvqkrZCevHRC3icSO1UsSn2TzU+MjOb9fcfnYiKy
 i+fHyFaaldfy1h2l0DCWuNy6XCGXrsde/5D4qMKw8cyvsbXo6TLKsUKB/u51DHxMYHlLpSMLGeK
 7IxM5eRFHspn4KvncSz6m86KhFrPc
X-Google-Smtp-Source: AGHT+IEgNdhiz0KsbxfjF3n3pcGcpcrzTZcB5zmCjOLwN7kmeBH4xUvtwkyKLdlX81FnA+fDwqwHnA==
X-Received: by 2002:a05:6000:2309:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3b60e4be284mr10090209f8f.5.1752859835902; 
 Fri, 18 Jul 2025 10:30:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 01/10] target/arm: Add BFADD, BFSUB,
 BFMUL (unpredicated)
Date: Fri, 18 Jul 2025 18:30:23 +0100
Message-ID: <20250718173032.2498900-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

FEAT_SVE_B16B16 adds bfloat16 versions of the SVE floating point
(unpredicated) instructions, which are encoded via sz==0b00.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h        | 3 +++
 target/arm/tcg/translate-sve.c | 6 +++++-
 target/arm/tcg/vec_helper.c    | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 0a006d95142..d9ca5b7c56e 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -728,16 +728,19 @@ DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fadd_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_bfadd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fsub_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_bfsub, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmul_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7b575734fde..f00cccf1548 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -190,6 +190,10 @@ static bool gen_gvec_fpst_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
+    /* These insns use MO_8 to encode BFloat16 */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
@@ -4146,7 +4150,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
 
 #define DO_FP3(NAME, name) \
     static gen_helper_gvec_3_ptr * const name##_fns[4] = {          \
-        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_b16, gen_helper_gvec_##name##_h,   \
         gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
     };                                                              \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bae6165b505..76a9ab0da39 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1467,16 +1467,19 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
+DO_3OP(gvec_fadd_b16, bfloat16_add, float16)
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
 DO_3OP(gvec_fadd_d, float64_add, float64)
 DO_3OP(gvec_bfadd, bfloat16_add, bfloat16)
 
+DO_3OP(gvec_fsub_b16, bfloat16_sub, float16)
 DO_3OP(gvec_fsub_h, float16_sub, float16)
 DO_3OP(gvec_fsub_s, float32_sub, float32)
 DO_3OP(gvec_fsub_d, float64_sub, float64)
 DO_3OP(gvec_bfsub, bfloat16_sub, bfloat16)
 
+DO_3OP(gvec_fmul_b16, bfloat16_mul, float16)
 DO_3OP(gvec_fmul_h, float16_mul, float16)
 DO_3OP(gvec_fmul_s, float32_mul, float32)
 DO_3OP(gvec_fmul_d, float64_mul, float64)
-- 
2.43.0


