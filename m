Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F3C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEd-0006qo-Ql; Fri, 24 May 2024 19:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEY-0006kM-DM
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEQ-0005sZ-Sz
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f3423646b7so20389455ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592909; x=1717197709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WueAIRV4KkSDNix8RgtPUT8OsRBBiAwBreqjSCczGFg=;
 b=CJxtD7IrvoFTUcrdovHyu4Dm79x8e33SrcufTKsJL+j2jy6w1Y0Zm4i1ZsVtt428IC
 qT4C9Jc6olaiigT9rNoFSX+yCkcQXcQ84b/Mb/SDO6J0AKsJgoaPW4SSHJ1ZYC05vROI
 4uxo7wpbXgN35NlBm8DTRIMH3vZu0GZY4cE9gWzfN03heKvzDhk3qcfGF22e1xNdmADY
 zVqrmHf+gZgw2xyagwgeWBx6nspjHaSqf1DBCkuw0VOprVzMF/n1vpAhYblgP67hk/AM
 D3iEctnP3hBzsqGfIguzUo9ojFEBu6QvTVBLsYLCZBYVL8+gwS7NjJrjFEuTrHDSMrGJ
 noKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592909; x=1717197709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WueAIRV4KkSDNix8RgtPUT8OsRBBiAwBreqjSCczGFg=;
 b=T3cYhcGNsK0l4qRSY8ihMyRzAaYD/1rzed4QScXvSazvkk0zZYkZZTcFlJHn1bf0z2
 ugiZTIoGMVbNYtxEvpgg3ZoSlhl1gKm7Ka69xnIxgkgy5rIXkeKSv8kLppx2hTtGCma9
 783BQ+SV6i2wCf2z2Idmr5rnPMseDpmuFCKm+OfZU4bMfMAkRh6inlYT0JOGrU3xFQxn
 KdXjqK+s1F5nmmXp8Y5OdsTpHTo1TzVLtTX7lN8z4TCe92l7yfoN2Q3KZcxrn+u5uMn+
 t7iavLWscaUms8Y8krpyHd1IrURTrOsnkIjSdtKnoBN3qbYsh0gjUefiQncx5pDW83wT
 yhMg==
X-Gm-Message-State: AOJu0Ywbuli2UwMn8sUZa0pRWH1uiBDXCEAEatRuQutToNJ7GoBakOyY
 g9yTyotNk+PPQ1uX0eV1/3kSuAgWiHzag/8x2tsJ8B5moDd5YuyxusvASGGBFOGqHnDA9YTUzAg
 h
X-Google-Smtp-Source: AGHT+IGij/XAlFbfoWdHiEk8BmozKRYGXjAWQ9FoAnGaDlCWxi/Jfm5YeToagV23KSTc/Cxv9hLjuA==
X-Received: by 2002:a17:902:d2c1:b0:1f3:26be:9886 with SMTP id
 d9443c01a7336-1f4486e134fmr46783225ad.23.1716592909318; 
 Fri, 24 May 2024 16:21:49 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 30/67] target/arm: Use gvec for neon faddp, fmaxp, fminp
Date: Fri, 24 May 2024 16:20:44 -0700
Message-Id: <20240524232121.284515-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  7 -----
 target/arm/tcg/translate-neon.c | 55 ++-------------------------------
 target/arm/tcg/vec_helper.c     | 45 ---------------------------
 3 files changed, 3 insertions(+), 104 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3268477329..065460ea80 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -650,13 +650,6 @@ DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 144f18ba22..2326a05a0a 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1144,6 +1144,9 @@ DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
 DO_3S_FP_GVEC(VRSQRTS, gen_helper_gvec_rsqrts_nf_s, gen_helper_gvec_rsqrts_nf_h)
+DO_3S_FP_GVEC(VPADD, gen_helper_gvec_faddp_s, gen_helper_gvec_faddp_h)
+DO_3S_FP_GVEC(VPMAX, gen_helper_gvec_fmaxp_s, gen_helper_gvec_fmaxp_h)
+DO_3S_FP_GVEC(VPMIN, gen_helper_gvec_fminp_s, gen_helper_gvec_fminp_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1180,58 +1183,6 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
-                             gen_helper_gvec_3_ptr *fn)
-{
-    /* FP pairwise operations */
-    TCGv_ptr fpstatus;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    assert(a->q == 0); /* enforced by decode patterns */
-
-
-    fpstatus = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
-                       vfp_reg_offset(1, a->vn),
-                       vfp_reg_offset(1, a->vm),
-                       fpstatus, 8, 8, 0, fn);
-
-    return true;
-}
-
-/*
- * For all the functions using this macro, size == 1 means fp16,
- * which is an architecture extension we don't implement yet.
- */
-#define DO_3S_FP_PAIR(INSN,FUNC)                                    \
-    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
-    {                                                               \
-        if (a->size == MO_16) {                                     \
-            if (!dc_isar_feature(aa32_fp16_arith, s)) {             \
-                return false;                                       \
-            }                                                       \
-            return do_3same_fp_pair(s, a, FUNC##h);                 \
-        }                                                           \
-        return do_3same_fp_pair(s, a, FUNC##s);                     \
-    }
-
-DO_3S_FP_PAIR(VPADD, gen_helper_neon_padd)
-DO_3S_FP_PAIR(VPMAX, gen_helper_neon_pmax)
-DO_3S_FP_PAIR(VPMIN, gen_helper_neon_pmin)
-
 static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 {
     /* Handle a 2-reg-shift insn which can be vectorized. */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 79e1fdcaa9..26a9ca9c14 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2192,51 +2192,6 @@ DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
 
-#define DO_NEON_PAIRWISE(NAME, OP)                                      \
-    void HELPER(NAME##s)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float32 *d = vd;                                                \
-        float32 *n = vn;                                                \
-        float32 *m = vm;                                                \
-        float32 r0, r1;                                                 \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float32_##OP(n[H4(0)], n[H4(1)], fpst);                    \
-        r1 = float32_##OP(m[H4(0)], m[H4(1)], fpst);                    \
-                                                                        \
-        d[H4(0)] = r0;                                                  \
-        d[H4(1)] = r1;                                                  \
-    }                                                                   \
-                                                                        \
-    void HELPER(NAME##h)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float16 *d = vd;                                                \
-        float16 *n = vn;                                                \
-        float16 *m = vm;                                                \
-        float16 r0, r1, r2, r3;                                         \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float16_##OP(n[H2(0)], n[H2(1)], fpst);                    \
-        r1 = float16_##OP(n[H2(2)], n[H2(3)], fpst);                    \
-        r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
-        r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
-                                                                        \
-        d[H2(0)] = r0;                                                  \
-        d[H2(1)] = r1;                                                  \
-        d[H2(2)] = r2;                                                  \
-        d[H2(3)] = r3;                                                  \
-    }
-
-DO_NEON_PAIRWISE(neon_padd, add)
-DO_NEON_PAIRWISE(neon_pmax, max)
-DO_NEON_PAIRWISE(neon_pmin, min)
-
-#undef DO_NEON_PAIRWISE
-
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.34.1


