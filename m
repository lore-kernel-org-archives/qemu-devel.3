Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB78C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82P-0002CU-NY; Sat, 21 Jun 2025 19:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82E-00020f-02
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82A-0004u5-KB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so1829658b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550045; x=1751154845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEE7C7n35S8bJ5u3EgumxTfAtwNM+J8UROeFiGVpH6w=;
 b=vVjWk02D50dsktlNB3KcUcHzuVyud9Fr4/3gpCpk9EV7U9vLjYEMvtEdXm4Tp4JXZw
 Dkceokt6Y538xenW8PnRAjLjH9USFjzJ/wDG7JRobTGFK6e99P2zFWwDa4vSAjJfZzDz
 H4AhLh3TTuf3iIyCgY4rlW46v0gh+gkWu6PV6/yjc8wqmIXHiM+Ejvj84bzeZFt4J0rz
 EIE4qf2hHppwMaOr1BkrlOR8q38FidqptyjesSSdaCv1mTAQAxaty6ceH+B2jOEojXd9
 qemg2dFgDOJr31DmpyYBIwl+OGiu1+sIK3GUyYY4EuiW6tDEZ4h5JlJCFXRWwsAx7azu
 qgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550045; x=1751154845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEE7C7n35S8bJ5u3EgumxTfAtwNM+J8UROeFiGVpH6w=;
 b=WK/T+r5KA0JCWQhxRqxHEPaA5p8iBrFfQVfPpIVzoLq+CnJEXO8uGlZadV+Igjdwcs
 Mb/7v0gIU76IYzdveXobK12MbmMEHpSZk1fSCK5UM9decYG58aVdC4nhBBwaRCYQy9JP
 OzZ7EN53tn1SzSeo3Z4aNwHyJ2EIip2TwaKdbWohCs7gKlVT5ejGm/WR19jx/xmaqFXM
 /g2zLv9vXvWMe0qGxPoeY+QfMcuU+ui7YrCRU6uItv9WhUtALusSIH1IrdKdUy5iL7c3
 yYVRTMxq52Go+qWyjkkgx2oy/PQ9gr1wHVVjngBHGWP58EHxxShwFtg6W3SRbk81zlIa
 3XTQ==
X-Gm-Message-State: AOJu0YyUssKhXGlKIgxNKYKtFw8YrXp23ahXV80ffJVxnAtZF9QYI2g1
 ZNkLG7r8Hao/TVsqF7e1nlE+9sG7IEfhAoSkdizFEO0XtTLJLNDS6p0s8amsK7sMgdXueqZ9SI1
 fZJ2iAOA=
X-Gm-Gg: ASbGnctVGjvMxdDub/HxYCbxn15khBOwew8lZ80ksu/Ek6fIH3sUSz+ml4y5KUElZrl
 tRPIhpRQpBS1tskPcCIuAUvZ0/Fd8TqWWmWk4QjSda9icierKeAHUVbb6g2CyllfaH97/OEMGsE
 mjRAzAqv4kVE4xGrhQo5u1TugrprbLkN/5vEk6kjH/w28MdGyTRxuQyDyp705pl5XFRD5DNqsZs
 j0OPrfzCujFvLWCV1jOme+KwDwJo4H0jtzKnzfI1XlXNcayiwCxeoLC4XFnSIp857v6DikldIvs
 pc1sHRTpM+q1IzaSaGlTA2PJ60HsQBhYXCv6F55Gb0xDGhu6BqAASBt+5jW+qKC1iC94i87gU+v
 yBgiV4Wx8UJrnF1uAQ2gC
X-Google-Smtp-Source: AGHT+IHyoW2XZZS7Rv7Z/jBYT4Y00rHwucWL2MP0D5c+C2DsuVhS6wb5YqNVNgcR0tULT0te0aKYwQ==
X-Received: by 2002:a05:6a20:3948:b0:220:3a5:43e9 with SMTP id
 adf61e73a8af0-22026ef7865mr15418227637.32.1750550044940; 
 Sat, 21 Jun 2025 16:54:04 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 040/101] target/arm: Implemement SME2 SDOT, UDOT, USDOT,
 SUDOT
Date: Sat, 21 Jun 2025 16:49:36 -0700
Message-ID: <20250621235037.74091-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h        |  8 ++++
 target/arm/tcg/translate-sme.c | 85 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 51 ++++++++++++++++++++
 target/arm/tcg/sme.decode      | 63 ++++++++++++++++++++++++-
 4 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 2702627eab..fa44b34dd5 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -614,6 +614,9 @@ DEF_HELPER_FLAGS_5(gvec_sdot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_usdot_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_sdot_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_sdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_idx_4b, TCG_CALL_NO_RWG,
@@ -625,6 +628,11 @@ DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_2h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_idx_2h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5d6fd4cd03..ea1aff004c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -895,3 +895,88 @@ static bool trans_BFVDOT(DisasContext *s, arg_azx_n *a)
                          a->idx, 2, false, FPST_ENV,
                          gen_helper_sme2_bfvdot_idx);
 }
+
+/*
+ * Expand array multi-vector single (n1), array multi-vector (nn),
+ * and array multi-vector indexed (nx), for integer accumulate.
+ *   multi: true for nn, false for n1.
+ *   data: stuff for simd_data, including any index.
+ */
+static bool do_azz_acc(DisasContext *s, int nreg, int nsel,
+                       int rv, int off, int zn, int zm,
+                       int data, int shsel, bool multi,
+                       gen_helper_gvec_4 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, t, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
+static bool do_dot(DisasContext *s, arg_azz_n *a, bool multi,
+                   gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+static void gen_helper_gvec_sudot_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                     TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_gvec_usdot_4b(d, m, n, a, desc);
+}
+
+TRANS_FEAT(USDOT_n1, aa64_sme, do_dot, a, false, gen_helper_gvec_usdot_4b)
+TRANS_FEAT(SUDOT_n1, aa64_sme, do_dot, a, false, gen_helper_gvec_sudot_4b)
+TRANS_FEAT(SDOT_n1_2h, aa64_sme, do_dot, a, false, gen_helper_gvec_sdot_2h)
+TRANS_FEAT(UDOT_n1_2h, aa64_sme, do_dot, a, false, gen_helper_gvec_udot_2h)
+TRANS_FEAT(SDOT_n1_4b, aa64_sme, do_dot, a, false, gen_helper_gvec_sdot_4b)
+TRANS_FEAT(UDOT_n1_4b, aa64_sme, do_dot, a, false, gen_helper_gvec_udot_4b)
+TRANS_FEAT(SDOT_n1_4h, aa64_sme2_i16i64, do_dot, a, false, gen_helper_gvec_sdot_4h)
+TRANS_FEAT(UDOT_n1_4h, aa64_sme2_i16i64, do_dot, a, false, gen_helper_gvec_udot_4h)
+
+TRANS_FEAT(USDOT_nn, aa64_sme, do_dot, a, true, gen_helper_gvec_usdot_4b)
+TRANS_FEAT(SDOT_nn_2h, aa64_sme, do_dot, a, true, gen_helper_gvec_sdot_2h)
+TRANS_FEAT(UDOT_nn_2h, aa64_sme, do_dot, a, true, gen_helper_gvec_udot_2h)
+TRANS_FEAT(SDOT_nn_4b, aa64_sme, do_dot, a, true, gen_helper_gvec_sdot_4b)
+TRANS_FEAT(UDOT_nn_4b, aa64_sme, do_dot, a, true, gen_helper_gvec_udot_4b)
+TRANS_FEAT(SDOT_nn_4h, aa64_sme2_i16i64, do_dot, a, true, gen_helper_gvec_sdot_4h)
+TRANS_FEAT(UDOT_nn_4h, aa64_sme2_i16i64, do_dot, a, true, gen_helper_gvec_udot_4h)
+
+static bool do_dot_nx(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                      a->idx, 0, false, fn);
+}
+
+TRANS_FEAT(USDOT_nx, aa64_sme, do_dot_nx, a, gen_helper_gvec_usdot_idx_4b)
+TRANS_FEAT(SUDOT_nx, aa64_sme, do_dot_nx, a, gen_helper_gvec_sudot_idx_4b)
+TRANS_FEAT(SDOT_nx_2h, aa64_sme, do_dot_nx, a, gen_helper_gvec_sdot_idx_2h)
+TRANS_FEAT(UDOT_nx_2h, aa64_sme, do_dot_nx, a, gen_helper_gvec_udot_idx_2h)
+TRANS_FEAT(SDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_sdot_idx_4b)
+TRANS_FEAT(UDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_udot_idx_4b)
+TRANS_FEAT(SDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_sdot_idx_4h)
+TRANS_FEAT(UDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_udot_idx_4h)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7904159d57..ce7f55bfc8 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -871,6 +871,57 @@ DO_DOT_IDX(gvec_usdot_idx_4b, int32_t, uint8_t, int8_t, H4)
 DO_DOT_IDX(gvec_sdot_idx_4h, int64_t, int16_t, int16_t, H8)
 DO_DOT_IDX(gvec_udot_idx_4h, uint64_t, uint16_t, uint16_t, H8)
 
+#undef DO_DOT
+#undef DO_DOT_IDX
+
+/* Similar for 2-way dot product */
+#define DO_DOT(NAME, TYPED, TYPEN, TYPEM) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
+{                                                                         \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                \
+    TYPED *d = vd, *a = va;                                               \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m = vm;                                                        \
+    for (i = 0; i < opr_sz / sizeof(TYPED); ++i) {                        \
+        d[i] = (a[i] +                                                    \
+                (TYPED)n[i * 2 + 0] * m[i * 2 + 0] +                      \
+                (TYPED)n[i * 2 + 1] * m[i * 2 + 1]);                      \
+    }                                                                     \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
+}
+
+#define DO_DOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
+{                                                                         \
+    intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
+    intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
+    intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
+    intptr_t index = simd_data(desc);                                     \
+    TYPED *d = vd, *a = va;                                               \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m_indexed = (TYPEM *)vm + HD(index) * 2;                       \
+    do {                                                                  \
+        TYPED m0 = m_indexed[i * 2 + 0];                                  \
+        TYPED m1 = m_indexed[i * 2 + 1];                                  \
+        do {                                                              \
+            d[i] = (a[i] +                                                \
+                    n[i * 4 + 0] * m0 +                                   \
+                    n[i * 4 + 1] * m1);                                   \
+        } while (++i < segend);                                           \
+        segend = i + (16 / sizeof(TYPED));                                \
+    } while (i < opr_sz_n);                                               \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
+}
+
+DO_DOT(gvec_sdot_2h, int32_t, int16_t, int16_t)
+DO_DOT(gvec_udot_2h, uint32_t, uint16_t, uint16_t)
+
+DO_DOT_IDX(gvec_sdot_idx_2h, int32_t, int16_t, int16_t, H4)
+DO_DOT_IDX(gvec_udot_idx_2h, uint32_t, uint16_t, uint16_t, H4)
+
+#undef DO_DOT
+#undef DO_DOT_IDX
+
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 7c057bcad2..338637decd 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -291,6 +291,26 @@ FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
 BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
 
+USDOT_n1        11000001 001 0 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=2
+USDOT_n1        11000001 001 1 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=4
+
+SUDOT_n1        11000001 001 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
+SUDOT_n1        11000001 001 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
+
+SDOT_n1_4b      11000001 001 0 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=2
+SDOT_n1_4b      11000001 001 1 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=4
+SDOT_n1_4h      11000001 011 0 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=2
+SDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=4
+SDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=2
+SDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=4
+
+UDOT_n1_4b      11000001 001 0 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=2
+UDOT_n1_4b      11000001 001 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
+UDOT_n1_4h      11000001 011 0 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=2
+UDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
+UDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
+UDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -334,6 +354,23 @@ FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
 BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
 
+USDOT_nn        11000001 101 ....0 0 .. 101 ....0 01 ...    @azz_2x2_o3
+USDOT_nn        11000001 101 ...01 0 .. 101 ...00 01 ...    @azz_4x4_o3
+
+SDOT_nn_4b      11000001 101 ....0 0 .. 101 ....0 00 ...    @azz_2x2_o3
+SDOT_nn_4b      11000001 101 ...01 0 .. 101 ...00 00 ...    @azz_4x4_o3
+SDOT_nn_4h      11000001 111 ....0 0 .. 101 ....0 00 ...    @azz_2x2_o3
+SDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 00 ...    @azz_4x4_o3
+SDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 01 ...    @azz_2x2_o3
+SDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 01 ...    @azz_4x4_o3
+
+UDOT_nn_4b      11000001 101 ....0 0 .. 101 ....0 10 ...    @azz_2x2_o3
+UDOT_nn_4b      11000001 101 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
+UDOT_nn_4h      11000001 111 ....0 0 .. 101 ....0 10 ...    @azz_2x2_o3
+UDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
+UDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 11 ...    @azz_2x2_o3
+UDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 11 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -367,7 +404,11 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 @azx_2x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
                 &azx_n n=2 rv=%mova_rv zn=%zn_ax2
 @azx_4x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
-                &azx_n n=2 rv=%mova_rv zn=%zn_ax4
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax4
+@azx_2x1_i1_o3  ........ .... zm:4 . .. .. idx:1 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax2
+@azx_4x1_i1_o3  ........ .... zm:4 . .. .. idx:1 .... ... off:3 \
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax4
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
@@ -377,3 +418,23 @@ BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
 
 FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
 BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
+
+SDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_i2_o3
+SDOT_nx_2h      11000001 0101 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_i2_o3
+SDOT_nx_4b      11000001 0101 .... 0 .. 1 .. ....1 00 ...   @azx_2x1_i2_o3
+SDOT_nx_4b      11000001 0101 .... 1 .. 1 .. ...01 00 ...   @azx_4x1_i2_o3
+SDOT_nx_4h      11000001 1101 .... 0 .. 00 . ....0 01 ...   @azx_2x1_i1_o3
+SDOT_nx_4h      11000001 1101 .... 1 .. 00 . ...00 01 ...   @azx_4x1_i1_o3
+
+UDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_i2_o3
+UDOT_nx_2h      11000001 0101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_i2_o3
+UDOT_nx_4b      11000001 0101 .... 0 .. 1 .. ....1 10 ...   @azx_2x1_i2_o3
+UDOT_nx_4b      11000001 0101 .... 1 .. 1 .. ...01 10 ...   @azx_4x1_i2_o3
+UDOT_nx_4h      11000001 1101 .... 0 .. 00 . ....0 11 ...   @azx_2x1_i1_o3
+UDOT_nx_4h      11000001 1101 .... 1 .. 00 . ...00 11 ...   @azx_4x1_i1_o3
+
+USDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 01 ...   @azx_2x1_i2_o3
+USDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 01 ...   @azx_4x1_i2_o3
+
+SUDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 11 ...   @azx_2x1_i2_o3
+SUDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 11 ...   @azx_4x1_i2_o3
-- 
2.43.0


