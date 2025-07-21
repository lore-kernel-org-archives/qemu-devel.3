Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC66C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYo-0006Ng-Og; Mon, 21 Jul 2025 09:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYL-0000KM-Q3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYF-0005J1-MC
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3288219f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104449; x=1753709249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wsBQYXDC8tkYaoMs+LV1i0h/jiobJ0UwGkaSUMbkmUM=;
 b=hO2qzZ74flOLHlhGqLd/0kmbsucPCPKh1Phj/ah4vCvZAB4XWWvD0/wy/1fsv2XfXK
 Lj+y1wJNFZFqLiSySxZ5bgAUMLv/2m/Hq6XoMZmQbt0Pj0uXGWKc+Jo/eI4OKn+ktH9h
 MGOaYd99utC447wwVogF6BTnriPvQrJbKqOawUCqlqs/bEOMYI8nvcN0YDNyh4ts6vW5
 p4Qz0bb7o4RdDc9HP/wktYezsiiAciDh2KV44ljWaLJc2trESICWaX8WCCmr8lxrMioP
 s0qHHTWwmnr5wp8IXL310nHZtNtljvh2SLC1RYoX1cWc9YNXjfI2e5DXLLYvO8HkSvhd
 SIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104449; x=1753709249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsBQYXDC8tkYaoMs+LV1i0h/jiobJ0UwGkaSUMbkmUM=;
 b=TbkzjbboBwpdv+hnw9Qvocto+0fOQ8+7N92Mf8CkInGapLXFsiaHSksCABOXe0fFP2
 K1eIRcKM+BHOPuMwKZDHSmvi+VQlj44VLqANnZBBuDoGJSJvL021iG60QvinbXSHa8IG
 fUhXKpxCvPDty48nkqUleTxlYQ0zZI+23+pGWFdz/PyeYgv5vvNpbeh2bblsM7N4DTgr
 n1WhNVahf99eL8Ub9vXgGmjXs5wrbGzZyaMLsHxj+vl9h5I01nvGRNGOnHQYIB7kfL3f
 ibZC+cfFWuR2fbMyiavnFWZV3MVxciGze8opw2xn7PZ+Sq3/IZE5Osm67OrSUQhgvHI1
 fOoA==
X-Gm-Message-State: AOJu0YxiuN3+RooArrJekYq1gpnOLO4jwq+uLxtbkCX+zIHAra8Uoc6E
 e2LIuaR19FUFi/nyEvoOhyd3MBpsktTC9jKcg4W43PJdK8t4x5u9aloAiCeNaujxclAjlOiSIHV
 Hfu8i
X-Gm-Gg: ASbGncvrMI8Cg88U/J3V13S/cahx3SqllOiazC3mtpGXD2obEVh1Ti9BFc4lO9QLEit
 MuXkzOgvzXkyUl1Xi1tvRDj5rAnFTK95XIDw6Bzbmq0krI9BVhHr0xyhAfgbbwly0Vk6JvonPDl
 CUBcsxN52P1KoRPsd+Z6fUihczPUg1u/ZLI3JtVpE9r93XGN8moy8piN02lhNtyHQaGwVUDbaA1
 JcHQDkeH+AobBrBFQJAD1+VT3UnAF1qt2VzsbjYwJmIesXc2XkLpKiOgZ2SpSkFB91Ipb6IyiPf
 GFCodCyytQy+NjR3ZHaBd89KJtmBrMpt+BHdHzhYeqcECNv0C6DXbvcEoUck2Fw55qS7km6N0II
 W+pa/Nu0BplAP0HrbfdrbqRa1naRk
X-Google-Smtp-Source: AGHT+IHXMoUMvhQAv4a4EU1JJn9PRPpU/6Qoig1qeCORdnvGNOBLRe0xA52Kqpfd/Wkwpe8KJzcUPQ==
X-Received: by 2002:a05:6000:288a:b0:3b2:fe84:a10 with SMTP id
 ffacd0b85a97d-3b60e440dddmr14736188f8f.0.1753104449556; 
 Mon, 21 Jul 2025 06:27:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] target/arm: Add BFMIN, BFMAX (predicated)
Date: Mon, 21 Jul 2025 14:27:07 +0100
Message-ID: <20250721132718.2835729-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
(predicated) instructions, which are encoded via sz=0b00.  Add the
BFMAX and BFMIN insns.  These have separate behaviour for AH=1 and
AH=0; we have already implemented the AH=1 helper for the SME2
versions of these insns.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-4-peter.maydell@linaro.org
---
 target/arm/tcg/helper-sve.h    |  8 ++++++++
 target/arm/tcg/sve_helper.c    |  4 ++++
 target/arm/tcg/translate-sve.c | 17 +++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index d612bcaded3..cb6c2355e58 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1230,6 +1230,8 @@ DEF_HELPER_FLAGS_6(sve_fdiv_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fdiv_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fmin_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmin_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmin_s, TCG_CALL_NO_RWG,
@@ -1237,6 +1239,8 @@ DEF_HELPER_FLAGS_6(sve_fmin_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fmax_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmax_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
@@ -1244,6 +1248,8 @@ DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmax_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmin_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_ah_fmin_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_ah_fmin_s, TCG_CALL_NO_RWG,
@@ -1251,6 +1257,8 @@ DEF_HELPER_FLAGS_6(sve_ah_fmin_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_ah_fmin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmax_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_ah_fmax_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_ah_fmax_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a229503bc21..1a56fa86d9c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4648,18 +4648,22 @@ DO_ZPZZ_FP(sve_fdiv_h, uint16_t, H1_2, float16_div)
 DO_ZPZZ_FP(sve_fdiv_s, uint32_t, H1_4, float32_div)
 DO_ZPZZ_FP(sve_fdiv_d, uint64_t, H1_8, float64_div)
 
+DO_ZPZZ_FP(sve_fmin_b16, uint16_t, H1_2, bfloat16_min)
 DO_ZPZZ_FP(sve_fmin_h, uint16_t, H1_2, float16_min)
 DO_ZPZZ_FP(sve_fmin_s, uint32_t, H1_4, float32_min)
 DO_ZPZZ_FP(sve_fmin_d, uint64_t, H1_8, float64_min)
 
+DO_ZPZZ_FP(sve_fmax_b16, uint16_t, H1_2, bfloat16_max)
 DO_ZPZZ_FP(sve_fmax_h, uint16_t, H1_2, float16_max)
 DO_ZPZZ_FP(sve_fmax_s, uint32_t, H1_4, float32_max)
 DO_ZPZZ_FP(sve_fmax_d, uint64_t, H1_8, float64_max)
 
+DO_ZPZZ_FP(sve_ah_fmin_b16, uint16_t, H1_2, helper_sme2_ah_fmin_b16)
 DO_ZPZZ_FP(sve_ah_fmin_h, uint16_t, H1_2, helper_vfp_ah_minh)
 DO_ZPZZ_FP(sve_ah_fmin_s, uint32_t, H1_4, helper_vfp_ah_mins)
 DO_ZPZZ_FP(sve_ah_fmin_d, uint64_t, H1_8, helper_vfp_ah_mind)
 
+DO_ZPZZ_FP(sve_ah_fmax_b16, uint16_t, H1_2, helper_sme2_ah_fmax_b16)
 DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, helper_vfp_ah_maxh)
 DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, helper_vfp_ah_maxs)
 DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, helper_vfp_ah_maxd)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2739c226d73..27af3df9a4b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4218,11 +4218,24 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
     };                                                          \
     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
 
+#define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
+    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
+        gen_helper_##name##_b16, gen_helper_##name##_h,                 \
+        gen_helper_##name##_s, gen_helper_##name##_d                    \
+    };                                                                  \
+    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
+        gen_helper_##ah_name##_b16, gen_helper_##ah_name##_h,           \
+        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
+    };                                                                  \
+    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
+               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
+               name##_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sve, sve_fadd)
 DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sve, sve_fsub)
 DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sve, sve_fmul)
-DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
-DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
+DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
+DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sve, sve_fminnum)
 DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
 DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
-- 
2.43.0


