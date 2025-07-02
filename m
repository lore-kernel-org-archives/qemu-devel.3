Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A26C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgI-0008E3-1H; Wed, 02 Jul 2025 08:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgA-000814-4e
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:10 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfo-00015B-5l
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:07 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2eb6c422828so3963265fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459686; x=1752064486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+o9WtWIZF7CJjfjA2GAPrFXLh1beSrq23YpovmlbJIg=;
 b=ix6OY9ZKFTCRTF2/3pvN8ApXyzA7G9bmv7r0IzLGXn+3SjGC2IjLd7FoD0N6zwTOoA
 VfHdkGGHd+ZV7QtC3rlqta8BXQgr9IykqsyahTuwxPs77+JKm0XJm3ZqEjEfmAfO51HH
 W64IgkmEoKmgBVE7n5ueLQYJgU0mVvzFK8mMawKS7d58IEj/37e7VWvBzES2fO9LFg1Z
 0Xln/6jrXLvewtBvmKPYDXauicQgdWIQJ2vtOmGOlxNfdiBWZLNxJ/9AtvrmEntgO0Tc
 vohXyu/hFXKH7KwoZ2ymYXH8lC4mSexMqnjjLBhX4OAUZz/3ma0dBMYLqK9rH7Aq5lWA
 X2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459686; x=1752064486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+o9WtWIZF7CJjfjA2GAPrFXLh1beSrq23YpovmlbJIg=;
 b=ni21q+03IXKzz392sWpa/dHNjW8Ch3k4m76TPo3/+6OJNEKPvsJfsLL2mKfXJ18n+9
 bpfhjNhY/xexdkzydIHZUbcGh5n99pU6kQKpPwu3vSqm7OqsUADSl5lbLrzC/UaCIBb4
 QxIi0ipytnGvR7Su1DUeI3pNMzb4cW7KWabnScCkHQrS6W3/qi7y4nBfuO+q++u1+zmY
 Oqp/5o2xtKTxb5vDr/nYPCqmaabou97YF6ey1kdxYN2qVZFSMNidPwufAYylkfcj3cxF
 NQ91dyQ8F1nRpFX4nK7ZiuMBAySX/wWBxa8ovZVWkgtWCP0wrlxObk3O6nvcA07c6u7/
 1agQ==
X-Gm-Message-State: AOJu0Yz5NhIca/b/o+hU63pWMrDTqxWr0mZIYGdOvw4ewaWr40YsZPhj
 b0Hlq5v9Td1B0kTWKvr+uIej7lDJO5k/7pmTxdCsMaVBnHg1YPTSML9ZuCaDBTef86PvcddQ9+c
 8qNbgS10=
X-Gm-Gg: ASbGncunTpWTfrw80GjcZnf1RwB9HKVyJ18hct1RbFzkw/HU/E1/Cz6qRN2On5yOrXS
 0JWNt5tDfkjMN1/70qGu1OBmoY4GiDS6MLFdhZkVxjUdha56Z7rBk4fUjk8eu7AqtfXiD9XRQH0
 PiUAkxJikW03sSRR7fEXo6R27MmhEXS8Qpgu40eK3aAzQK8Cn1WXW14zwKPWS5R8xi/42FIikdv
 /o2YyONT7quGh0vL308LwfUPAs/dJ0KRWOttBIt7wq+gRBD7W+8NB8N7zKuk/8+sk5H+5uKFAgL
 UaUkgujxkvwoD4AQUA0e7R9kyD2wtkZ0W17Fpp9vOCtZUrlICTHEgOG+B2GVxNH451gnrA==
X-Google-Smtp-Source: AGHT+IHc8H4efE8fOryzclqD+czw1sfR2LRxe+4bKscYqGiQ816zSPrG99LnHyLV4/c9PE56xkNa0Q==
X-Received: by 2002:a05:6871:4984:b0:2e4:c5c8:707b with SMTP id
 586e51a60fabf-2f6472a31e9mr1337827fac.6.1751459686433; 
 Wed, 02 Jul 2025 05:34:46 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 27/97] target/arm: Implement SME2 FDOT
Date: Wed,  2 Jul 2025 06:33:00 -0600
Message-ID: <20250702123410.761208-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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
 target/arm/tcg/helper-sme.h    |  5 ++++
 target/arm/tcg/sme_helper.c    | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++
 target/arm/tcg/translate-sve.c |  5 ++++
 target/arm/tcg/sme.decode      | 14 +++++++++++
 target/arm/tcg/sve.decode      |  7 ++++--
 6 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index cdd7058aed..ec93ff57ff 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -173,3 +173,8 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_b16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnum_b16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8ce50653b4..60322be3d0 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1152,6 +1152,50 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
+void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
+                         CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_maxsz(desc);
+    bool za = extract32(desc, SIMD_DATA_SHIFT, 1);
+    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
+    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
+    float_status fpst_odd = *fpst_std;
+    float32 *d = vd, *a = va;
+    uint32_t *n = vn, *m = vm;
+
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < oprsz / sizeof(float32); ++i) {
+        d[H4(i)] = f16_dotadd(a[H4(i)], n[H4(i)], m[H4(i)],
+                              fpst_f16, fpst_std, &fpst_odd);
+    }
+}
+
+void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
+                             CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    intptr_t eltspersegment = MIN(4, elements);
+    int idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
+    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
+    float_status fpst_odd = *fpst_std;
+    float32 *d = vd, *a = va;
+    uint32_t *n = vn, *m = (uint32_t *)vm + H4(idx);
+
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < elements; i += eltspersegment) {
+        uint32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[H4(i + j)] = f16_dotadd(a[H4(i + j)], n[H4(i + j)], mm,
+                                      fpst_f16, fpst_std, &fpst_odd);
+        }
+    }
+}
+
 void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
                         void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9ec02d960d..761584c90b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -903,3 +903,21 @@ static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 
 TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
 TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
+
+static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
+                         multi, FPST_ENV, gen_helper_sme2_fdot_h);
+}
+
+TRANS_FEAT(FDOT_n1, aa64_sme2, do_fdot, a, false)
+TRANS_FEAT(FDOT_nn, aa64_sme2, do_fdot, a, true)
+
+static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                         a->idx | (1 << 2), 0, false, FPST_ENV,
+                         gen_helper_sme2_fdot_idx_h);
+}
+
+TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index b85bd885f9..4acd22f55e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7229,6 +7229,11 @@ TRANS_FEAT_NONSTREAMING(USMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT_NONSTREAMING(UMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
                         gen_helper_gvec_ummla_b, a, 0)
 
+TRANS_FEAT(FDOT_zzzz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzzz,
+           gen_helper_sme2_fdot_h, a, 0)
+TRANS_FEAT(FDOT_zzxz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzxz,
+           gen_helper_sme2_fdot_idx_h, a)
+
 TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
 TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9850c19d90..a2b93519c4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -285,6 +285,9 @@ BFMLSL_n1       11000001 001 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
 BFMLSL_n1       11000001 001 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
 BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 
+FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
+FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -322,6 +325,9 @@ BFMLAL_nn       11000001 101 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
 BFMLSL_nn       11000001 101 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
 BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 
+FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
+FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -351,3 +357,11 @@ BFMLAL_nx       11000001 1001 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
 BFMLSL_nx       11000001 1000 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
 BFMLSL_nx       11000001 1001 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
 BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
+
+@azx_2x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax2
+@azx_4x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax4
+
+FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
+FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3a99eb7299..5970ed9ac4 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1662,7 +1662,8 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
-### SVE2 floating-point bfloat16 dot-product
+### SVE2 floating-point dot-product
+FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
@@ -1673,7 +1674,9 @@ FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 
-### SVE2 floating-point bfloat16 dot-product (indexed)
+### SVE2 floating-point dot-product (indexed)
+
+FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
 ### SVE broadcast predicate element
-- 
2.43.0


