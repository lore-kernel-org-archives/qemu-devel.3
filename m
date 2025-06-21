Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE7C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT86b-0001fY-3w; Sat, 21 Jun 2025 19:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85h-000615-Qi
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85f-0006dH-BU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2353a2bc210so25791415ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550261; x=1751155061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0PYrDNJAEDLaOBUTSeRc0kN8F1JlQV3O0uBCjVzSB90=;
 b=n7ZFfh90PJo+r2Z0u7SmbMq3SIIKiZDaDKlIBgvcScMkWz5DP1AOQKL3bGF65lKNFS
 Y6MSM3yPl5N2p6WFP8V2T8YB8pGyk3GI8L5kutYUmGYVi6S6LbPbNi4/VqDLN4eksTSN
 Va+b1W7r1jgDBcmoHT2Xo0SXmLwm0yjx7CIswcCzqeRyEy19yWUMJQ89Y60ZcvGaLYsR
 xj9h9UxYvZnMfqpn1pc44deVNEkHw1E3XLCVgihugxIjdrvOv4lx5Rr/vasA8op+33H3
 X+xWtBEcDIXGOexgOx050Lz6OqRKKunFMDlm7u0VjaUeLI2MdO7oS/g0cKUchwNNHmDy
 48xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550261; x=1751155061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PYrDNJAEDLaOBUTSeRc0kN8F1JlQV3O0uBCjVzSB90=;
 b=BEn9SfZ7hGpRoB6fwGew+w9t98gOxQnXMjmdjLPzZqeL5EuUoUhFc3R5hSkoXdgegX
 cEN3h6KCLYnXylM30jxtdmzRLIh0lwx31QJVN0IRsNK64c0lSyhXAg7vpHStVpBIDHKW
 ddnenxbV4tAeUppLEnagAGqJrDeCVEQUPGlwSAoPYqxqrCIXGqZ6xM2thkitveyX+jZJ
 F/PxMykAWKosVOKl6au6nmyD7q9VUipWoFZTd9Mg2f8/q8bZ1ee8dhNVlUbZfXTcCKUd
 BWU1tNEwcb3EjmEPVUUANiqeQLYCr+njM1bAofIeUOdA16OTBWcPPIf4HqZRKjtlpt+7
 WO2Q==
X-Gm-Message-State: AOJu0YyBC8+5Z0O1JLv+ArWxwLbWA/aU0xkvxsfwa+/Hw3P122YrFvSB
 s1PfEUnm94raRLV9Q/tiZMsbqlC1gTA5jtTcnz0FX70N2KpwJxsFR+TdKBuq0J1yYivPQx9wmNf
 pb5XCp1Q=
X-Gm-Gg: ASbGncvz3MSKAIG9Vl5Q52drPdNufrRZYrAt/i8gKPVVk+gAmHVBlQXuJ8iVFjk+GnE
 a1FA6cGa8/26qBVDU0WrDAdGK5moNubzZBFhaE683PyhOLxjh5/uQV9S4wL/+eklo3ISuaCUllz
 1FNoltfC8dc9CIsKtzJQ3WMy4qaqgv4YJMJBCVfAK0SOKPTs/6SLhb/WFz6pxi1tXSMzQEMHUxo
 utB2IDSw7xMWnt5q93fklKicuKDMkYydKoOEix8l4Ccx01NtUCRIu8WgE752OTscVYL9LiMmHha
 ArIM5/cGMssArOMkzgtoVUXplqChL9jVOOYmncpf3KSKePrK1njPF/iQAcDzUF+QHkPaF8StQr0
 RToi3lWM2cw4ID4OA1FWTZRDoBSdXClM=
X-Google-Smtp-Source: AGHT+IFavNqz1RNOxTllm39RJq1sNnSXj5Yazi0Bv6jYcUf/YUAYkjJD1mR3mGmwFShAGjYUe1g4ng==
X-Received: by 2002:a17:902:ec8c:b0:237:c8de:f289 with SMTP id
 d9443c01a7336-237d996bf44mr115098925ad.36.1750550261424; 
 Sat, 21 Jun 2025 16:57:41 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 098/101] target/arm: Implement MOVAZ for SME2p1
Date: Sat, 21 Jun 2025 16:50:34 -0700
Message-ID: <20250621235037.74091-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 60 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 46 +++++++++++++++++++-------
 target/arm/tcg/sme.decode      | 36 ++++++++++++++++++++
 4 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index d86fdcbd83..3e2ae83fe5 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -42,6 +42,12 @@ DEF_HELPER_FLAGS_3(sme2_mova_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_mova_cz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7757085adf..16bdf61f51 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -250,6 +250,66 @@ void HELPER(sme2_mova_zc_d)(void *vdst, void *vsrc, uint32_t desc)
     }
 }
 
+void HELPER(sme2p1_movaz_zc_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint8_t *src = vsrc;
+    uint8_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc);
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint16_t *src = vsrc;
+    uint16_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 2;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint32_t *src = vsrc;
+    uint32_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 4;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint64_t *src = vsrc;
+    uint64_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 8;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_q)(void *vdst, void *vsrc, uint32_t desc)
+{
+    Int128 *src = vsrc;
+    Int128 *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 16;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        memset(&src[tile_vslice_index(i)], 0, 16);
+    }
+}
+
 /*
  * Clear elements in a tile slice comprising len bytes.
  */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 397e328a1b..12d32e3620 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -232,7 +232,8 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
 TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
 
-static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
+static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n,
+                           bool to_vec, bool zero)
 {
     static gen_helper_gvec_2 * const cz_fns[] = {
         gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
@@ -242,9 +243,16 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
         gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
     };
+    static gen_helper_gvec_2 * const zc_z_fns[] = {
+        gen_helper_sme2p1_movaz_zc_b, gen_helper_sme2p1_movaz_zc_h,
+        gen_helper_sme2p1_movaz_zc_s, gen_helper_sme2p1_movaz_zc_d,
+        gen_helper_sme2p1_movaz_zc_q,
+    };
     TCGv_ptr t_za;
     int svl;
 
+    assert(a->esz <= MO_64 + zero);
+
     if (!sme_smza_enabled_check(s)) {
         return true;
     }
@@ -262,7 +270,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
             TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
             t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
                                    a->off * n + i, 1, a->v);
-            if (to_vec) {
+            if (zero) {
+                zc_z_fns[a->esz](t_zr, t_za, t_desc);
+            } else if (to_vec) {
                 zc_fns[a->esz](t_zr, t_za, t_desc);
             } else {
                 cz_fns[a->esz](t_za, t_zr, t_desc);
@@ -275,6 +285,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
                                    a->off * n + i, 1, a->v);
             if (to_vec) {
                 tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
+                if (zero) {
+                    tcg_gen_gvec_dup_imm_var(MO_8, t_za, 0, svl, svl, 0);
+                }
             } else {
                 tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
             }
@@ -283,12 +296,17 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
     return true;
 }
 
-TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false)
-TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
-TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
-TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
+TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false, false)
+TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false, false)
+TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true, false)
+TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true, false)
 
-static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
+TRANS_FEAT(MOVAZ_zt, aa64_sme2p1, do_mova_tile_n, a, 1, true, true)
+TRANS_FEAT(MOVAZ_zt2, aa64_sme2p1, do_mova_tile_n, a, 2, true, true)
+TRANS_FEAT(MOVAZ_zt4, aa64_sme2p1, do_mova_tile_n, a, 4, true, true)
+
+static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n,
+                            bool to_vec, bool zero)
 {
     TCGv_ptr t_za;
     int svl;
@@ -306,6 +324,9 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
 
         if (to_vec) {
             tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, o_za, svl, svl);
+            if (zero) {
+                tcg_gen_gvec_dup_imm_var(MO_8, t_za, o_za, svl, svl, 0);
+            }
         } else {
             tcg_gen_gvec_mov_var(MO_8, t_za, o_za, tcg_env, o_zr, svl, svl);
         }
@@ -313,10 +334,13 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
     return true;
 }
 
-TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false)
-TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false)
-TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true)
-TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true)
+TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false, false)
+TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false, false)
+TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true, false)
+TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true, false)
+
+TRANS_FEAT(MOVAZ_za2, aa64_sme2p1, do_mova_array_n, a, 2, true, true)
+TRANS_FEAT(MOVAZ_za4, aa64_sme2p1, do_mova_array_n, a, 4, true, true)
 
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9740d74410..94e8653b89 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -100,6 +100,42 @@ MOVA_za2        11000000 00 00011 00 .. 010 00 off:3 zr:4 0  \
 MOVA_za4        11000000 00 00011 00 .. 011 00 off:3 zr:3 00 \
                 &mova_a rv=%mova_rv
 
+### SME Move and Zero
+
+MOVAZ_za2       11000000 00000110 0 .. 01010 off:3 zr:4 0    \
+                &mova_a rv=%mova_rv
+MOVAZ_za4       11000000 00000110 0 .. 01110 off:3 zr:3 00   \
+                &mova_a rv=%mova_rv
+
+MOVAZ_zt        11000000 00 00001 0 v:1 .. 0001 off:4 zr:5    \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt        11000000 01 00001 0 v:1 .. 0001 za:1 off:3 zr:5    \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt        11000000 10 00001 0 v:1 .. 0001 za:2 off:2 zr:5    \
+                &mova_t rs=%mova_rs esz=2
+MOVAZ_zt        11000000 11 00001 0 v:1 .. 0001 za:3 off:1 zr:5    \
+                &mova_t rs=%mova_rs esz=3
+MOVAZ_zt        11000000 11 00001 1 v:1 .. 0001 za:4 zr:5    \
+                &mova_t rs=%mova_rs esz=4 off=0
+
+MOVAZ_zt2       11000000 00 00011 0 v:1 .. 00010 off:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt2       11000000 01 00011 0 v:1 .. 00010 za:1 off:2 zr:4 0 \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt2       11000000 10 00011 0 v:1 .. 00010 za:2 off:1 zr:4 0 \
+                &mova_t rs=%mova_rs esz=2
+MOVAZ_zt2       11000000 11 00011 0 v:1 .. 00010 za:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVAZ_zt4       11000000 00 00011 0 v:1 .. 001100 off:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt4       11000000 01 00011 0 v:1 .. 001100 za:1 off:1 zr:3 00 \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt4       11000000 10 00011 0 v:1 .. 001100 za:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
-- 
2.43.0


