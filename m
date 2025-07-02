Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03DFC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwqu-0006zh-BB; Wed, 02 Jul 2025 08:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn9-0008Ve-Ki
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:25 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0003Ay-09
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:20 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ef493de975so2769454fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460128; x=1752064928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8pLXBRSbNGqWDtojyhUrBAw/i3EEaYq1IvnvPRMtnQg=;
 b=tmUm9mNFg7mzE3KnPIzrRtWpUS/iLcktOKgmJ0EtTTC9ocNOSP9XdbjMRkuASB32tu
 siNes/j91cKtvcN9vbBJ2Oxm469w1TwsE6jg91OGS/qeKHJJ4xQAhRWazMxpq4QoguQw
 VmdUvWvyexPvklcrfw+vsBzFCql6lEQ+YfUaZKnchPR/c+9u6sA/tYwRX8fUIpuReXVU
 3jea+0OxlD1EbxsSIW+wJYb7qcrMO0WHguJGJVuzxXzX5JRRCmD3sO8ieGo4209DfEvG
 PQ5WAGt6ehOHaiiUxmcso9Lkv3j9hEOkoBwI3esKdXP31jBXeHte00WZZIOUnVjFDw2K
 yEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460128; x=1752064928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pLXBRSbNGqWDtojyhUrBAw/i3EEaYq1IvnvPRMtnQg=;
 b=foJw5B041KY2d69N13UZ/iFXKAAXovDpw14PiyoV0tHFul2GCb+GRuWOmifAfu+iXK
 QxD4f4+0q0p3nmlVPBeutzKHPBH/jFWcrEDMEGCaQnJNf9t2gSKp/4sF/aFcIKVc4+pA
 M0eFlhPxgGJyaoMSFBU1OTR1Phl9/eEzY4I7WM2gJX/xH87X3MjvS9CN3aL8NO60CZqO
 bhpuTpmKuYRUXdsKFj9gPYp8RBx0A/Sr9mYwIjtJ+0YqzpCLAuHp0qCQ+jZ/nT5bJS4T
 iAt+zxl2MONZk7EpWQaIY6eHpeYv5e3sFWd+DuRgwE19w0itEpIav/S35KCsN2IwLa4Z
 r7Jg==
X-Gm-Message-State: AOJu0YxuNQ1Z+COfvkdpeyuffBe6UWuFd71PV9ZX5q+U1kHFa1bDglfn
 R1esA+BKdlE/5iS83wLQ/RhJOJ0dHtFsvgsECljPSTdFzVum6ZAXamjAvzgu3Yuz2gpJ+4rsLq9
 LebYkmGc=
X-Gm-Gg: ASbGncvxZpPjb7koxkEPdjE3Aa2yAVAGyxpv4auhUR+YmvnKIEzLEWErPpNwfg8xe5F
 hfaR1w7Jk9LZRxOerduJ50B7NCanAAUaVdf/5F+q2K8rHuv8kDb1IPkVGSngxUeggbk9tJREVpf
 LviT3IOYP2vxDPwTtkV8ZVIjgz/AON20OBvKnBpFAgeQ9MJM5DyMIOHuqeafQcoVmjNVvvQWskN
 RCUqWZ+seJ1rNHggrYYEOwN9I5RCLag+43tz+9mxgEubjscxe8HD7uvjHKLnSGtHqmjIV4tOi/g
 M/4iT3f1/n89/FSq0CVE9VujNS2LiP33ozh4s0MM3uKNK52uTbsXo5TOPiDK9cN7JwEiCvRaupd
 pKAuL
X-Google-Smtp-Source: AGHT+IEGUEXH0koX+8SYRRx0ZRLA2wBuaxK1k/UVsYH18fcvF+HQtNH3BUwnexO23b6pv+NxDrqXKw==
X-Received: by 2002:a05:6870:6f09:b0:2c1:b4ce:e43c with SMTP id
 586e51a60fabf-2f5c7c38319mr1599795fac.21.1751460127804; 
 Wed, 02 Jul 2025 05:42:07 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 88/97] target/arm: Implement MOVAZ for SME2p1
Date: Wed,  2 Jul 2025 06:34:01 -0600
Message-ID: <20250702123410.761208-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 60 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 46 +++++++++++++++++++-------
 target/arm/tcg/sme.decode      | 36 ++++++++++++++++++++
 4 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 467073ea25..c9961d6b7f 100644
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
index 19c4c2efa2..bcaa67b0fd 100644
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
index 7407597177..9592f6a996 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -247,7 +247,8 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
 TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
 
-static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
+static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n,
+                           bool to_vec, bool zero)
 {
     static gen_helper_gvec_2 * const cz_fns[] = {
         gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
@@ -257,6 +258,11 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
         gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
     };
+    static gen_helper_gvec_2 * const zc_z_fns[] = {
+        gen_helper_sme2p1_movaz_zc_b, gen_helper_sme2p1_movaz_zc_h,
+        gen_helper_sme2p1_movaz_zc_s, gen_helper_sme2p1_movaz_zc_d,
+        gen_helper_sme2p1_movaz_zc_q,
+    };
     TCGv_ptr t_za;
     int svl, bytes_per_op = n << a->esz;
 
@@ -270,6 +276,8 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         return true;
     }
 
+    assert(a->esz <= MO_64 + zero);
+
     if (!sme_smza_enabled_check(s)) {
         return true;
     }
@@ -292,7 +300,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
             TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
             t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
                                    a->off * n + i, 1, n, a->v);
-            if (to_vec) {
+            if (zero) {
+                zc_z_fns[a->esz](t_zr, t_za, t_desc);
+            } else if (to_vec) {
                 zc_fns[a->esz](t_zr, t_za, t_desc);
             } else {
                 cz_fns[a->esz](t_za, t_zr, t_desc);
@@ -305,6 +315,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
                                    a->off * n + i, 1, n, a->v);
             if (to_vec) {
                 tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
+                if (zero) {
+                    tcg_gen_gvec_dup_imm_var(MO_8, t_za, 0, svl, svl, 0);
+                }
             } else {
                 tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
             }
@@ -313,12 +326,17 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
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
@@ -336,6 +354,9 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
 
         if (to_vec) {
             tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, o_za, svl, svl);
+            if (zero) {
+                tcg_gen_gvec_dup_imm_var(MO_8, t_za, o_za, svl, svl, 0);
+            }
         } else {
             tcg_gen_gvec_mov_var(MO_8, t_za, o_za, tcg_env, o_zr, svl, svl);
         }
@@ -343,10 +364,13 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
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
index 0a2ceea8be..f7e4143b7d 100644
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


