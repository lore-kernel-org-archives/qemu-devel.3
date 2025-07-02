Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0189C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwrh-00084X-Tv; Wed, 02 Jul 2025 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnH-0000Ab-FO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:32 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn2-0003DE-Ts
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:30 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea35edc691so1682912fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460133; x=1752064933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DexnswzUI2GONBzk8DwGtUzhXp9CZ8U1qNwAguLf1rQ=;
 b=nr/g32sEb/e6Uiz0BzDeRTNg+H28YHJBEugzkwLnl+txvQHVXNSEZ3MdD04h4w5bcr
 vfW9SBaY2DGsy00jbECg4mlPEXbAbBIOKbti84zrKe6h3rFT4MZw4kPIPbPzB2d0EOqG
 RP338gh+211TCRrTEWHVsXTVGZ8NtYL31iKMmbdLp+iTLXRPRehmtc6EuK4C8MHzDzvW
 QEjqziIAHnL3mSJuhcx9CxuseMd3g0M+bGpjD1d/Tc/3Ck1FCHBhiyOjW0KHT2LpgF48
 FnfKVu+Wx+993SujztV7rfeY00i0fAMPZhHts2+ACMWmVMmZW+ZHem2h16cHMV+DtHy4
 zMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460133; x=1752064933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DexnswzUI2GONBzk8DwGtUzhXp9CZ8U1qNwAguLf1rQ=;
 b=McQZUs0SpjQty4Mo6FmUGUmJrVYmPc4Ug/6Dw0gNCCbSJO2w1DqSaaxiiSE+EuQJLA
 E9KUjNmp8/5Qj0oDF3MZ8FFQ5Yo24KQaN5EcCleFuGVLBRfiMw9Ux7EFWAuSsgDl5Kpz
 4GW76L/hs8Mee3vLUyQX1b5S+OYfJLFoKq6qVSdaqi+MWMp984BZcrR4DU+BCfTY3/Dc
 Cavphc/SdkOmZA+Y2KgVDBAPeaFvTmh92Kfqi+49Cw+DOyfQQ4BU42XBgg7qnf2RUYnI
 H5sr0/KFgLgFq2jnMN6FsSJNS0gHBhOnaDfs5jphaYsLgTkXlbO1fLehPwp2Gnu9Bfcu
 076g==
X-Gm-Message-State: AOJu0YyMIxtjJLUvXvVkEjPimnibNz45FrWgqnoDTJGX0xW+eoghQR98
 puIPkF9LvKV5J1a2LuJ/c8CdJFUfZYn2iI1Iq5zvmNb+obHxKfhVDPdinGe7RU73E8anjo0efzj
 dQlxeKzg=
X-Gm-Gg: ASbGnctEK7q7xltFBDm+bYqPF236irYgIVA5jILZ8ZPat3C0mYZ1+STQ7TNz+AGci9B
 gCXgvxJ4pJu3N+lJyHfEpPoXgG5C4vG7JaF4Fd035/sxctEWs2e52TE54vl84VwTbVLnQXDseq2
 c6ObKqN9suo9ieydvL9x6di0eXtOvbKWNW/EB41GZUm+Q48ctFik6sgcBoNasP6llefuM7JCKji
 PWmRot64g6pUgxduq3+Gpwv6LLsnpuZ84PmbVgXIzu7UmdU4rGfCzHrefmXbqwbCX/Xy9bKrPwo
 1QtmKatZFehVTfhd/uMmITOmEFGIP8DO5LK646PBN1KWTvo1bKyGWBdinOfka3ais/V4GamqiCv
 yrETn
X-Google-Smtp-Source: AGHT+IG5hYMZolYrwEjLBBVZmiIxBgXLb9YitowLaowV/xx+hw83OogaNtUoQanJdchHNYllaQrEcw==
X-Received: by 2002:a05:6870:e80a:b0:2db:a997:7a62 with SMTP id
 586e51a60fabf-2f5a8ae305fmr1722476fac.17.1751460132887; 
 Wed, 02 Jul 2025 05:42:12 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 92/97] target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
Date: Wed,  2 Jul 2025 06:34:05 -0600
Message-ID: <20250702123410.761208-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

For non-widening, we can use float_muladd_negate_product,
For widening, which uses dot-product, we need to handle
the negation explicitly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  19 +++++
 target/arm/tcg/vec_internal.h  |   5 ++
 target/arm/tcg/sme_helper.c    | 141 +++++++++++++++++++++++++++------
 target/arm/tcg/translate-sme.c |  27 ++++---
 4 files changed, 160 insertions(+), 32 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 16083660e2..2b22c6aee5 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -143,6 +143,25 @@ DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmops_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_fmops_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sme_ah_bfmops_w, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
+
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_umopa_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index ad3bfabc34..609ec09062 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -300,6 +300,11 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 /*
  * Negate as for FPCR.AH=1 -- do not negate NaNs.
  */
+static inline float16 bfloat16_ah_chs(float16 a)
+{
+    return bfloat16_is_any_nan(a) ? a : bfloat16_chs(a);
+}
+
 static inline float16 float16_ah_chs(float16 a)
 {
     return float16_is_any_nan(a) ? a : float16_chs(a);
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b6d1adbbf2..cf7ac3eda0 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -995,19 +995,18 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
     }
 }
 
-void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, float_status *fpst, uint32_t desc)
+static void do_fmopa_s(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                       uint16_t *pm, float_status *fpst, uint32_t desc,
+                       uint32_t negx, int negf)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    uint32_t neg = simd_data(desc) << 31;
-    uint16_t *pn = vpn, *pm = vpm;
 
     for (row = 0; row < oprsz; ) {
         uint16_t pa = pn[H2(row >> 4)];
         do {
             if (pa & 1) {
                 void *vza_row = vza + tile_vslice_offset(row);
-                uint32_t n = *(uint32_t *)(vzn + H1_4(row)) ^ neg;
+                uint32_t n = *(uint32_t *)(vzn + H1_4(row)) ^ negx;
 
                 for (col = 0; col < oprsz; ) {
                     uint16_t pb = pm[H2(col >> 4)];
@@ -1015,7 +1014,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, fpst);
+                            *a = float32_muladd(n, *m, *a, negf, fpst);
                         }
                         col += 4;
                         pb >>= 4;
@@ -1028,29 +1027,65 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
-void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
+void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                          void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_s(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_fmops_s)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_s(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 31, 0);
+}
+
+void HELPER(sme_ah_fmops_s)(void *vza, void *vzn, void *vzm, void *vpn,
+                            void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_s(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+               float_muladd_negate_product);
+}
+
+static void do_fmopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm, uint8_t *pn,
+                       uint8_t *pm, float_status *fpst, uint32_t desc,
+                       uint64_t negx, int negf)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
-    uint64_t neg = (uint64_t)simd_data(desc) << 63;
-    uint64_t *za = vza, *zn = vzn, *zm = vzm;
-    uint8_t *pn = vpn, *pm = vpm;
 
     for (row = 0; row < oprsz; ++row) {
         if (pn[H1(row)] & 1) {
             uint64_t *za_row = &za[tile_vslice_index(row)];
-            uint64_t n = zn[row] ^ neg;
+            uint64_t n = zn[row] ^ negx;
 
             for (col = 0; col < oprsz; ++col) {
                 if (pm[H1(col)] & 1) {
                     uint64_t *a = &za_row[col];
-                    *a = float64_muladd(n, zm[col], *a, 0, fpst);
+                    *a = float64_muladd(n, zm[col], *a, negf, fpst);
                 }
             }
         }
     }
 }
 
+void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_d(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_fmops_d)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_d(vza, vzn, vzm, vpn, vpm, fpst, desc, 1ull << 63, 0);
+}
+
+void HELPER(sme_ah_fmops_d)(void *vza, void *vzn, void *vzm, void *vpn,
+                            void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_d(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+               float_muladd_negate_product);
+}
+
 /*
  * Alter PAIR as needed for controlling predicates being false,
  * and for NEG on an enabled row element.
@@ -1071,6 +1106,20 @@ static inline uint32_t f16mop_adj_pair(uint32_t pair, uint32_t pg, uint32_t neg)
     return pair;
 }
 
+static inline uint32_t f16mop_ah_neg_adj_pair(uint32_t pair, uint32_t pg)
+{
+    uint32_t l = pg & 1 ? float16_ah_chs(pair) : 0;
+    uint32_t h = pg & 4 ? float16_ah_chs(pair >> 16) : 0;
+    return l | (h << 16);
+}
+
+static inline uint32_t bf16mop_ah_neg_adj_pair(uint32_t pair, uint32_t pg)
+{
+    uint32_t l = pg & 1 ? bfloat16_ah_chs(pair) : 0;
+    uint32_t h = pg & 4 ? bfloat16_ah_chs(pair >> 16) : 0;
+    return l | (h << 16);
+}
+
 static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
                           float_status *s_f16, float_status *s_std,
                           float_status *s_odd)
@@ -1139,12 +1188,11 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     return float32_add(sum, t32, s_std);
 }
 
-void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
-                           void *vpm, CPUARMState *env, uint32_t desc)
+static void do_fmopa_w_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                         uint16_t *pm, CPUARMState *env, uint32_t desc,
+                         uint32_t negx, bool ah_neg)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    uint32_t neg = simd_data(desc) * 0x80008000u;
-    uint16_t *pn = vpn, *pm = vpm;
     float_status fpst_odd = env->vfp.fp_status[FPST_ZA];
 
     set_float_rounding_mode(float_round_to_odd, &fpst_odd);
@@ -1155,7 +1203,11 @@ void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
             void *vza_row = vza + tile_vslice_offset(row);
             uint32_t n = *(uint32_t *)(vzn + H1_4(row));
 
-            n = f16mop_adj_pair(n, prow, neg);
+            if (ah_neg) {
+                n = f16mop_ah_neg_adj_pair(n, prow);
+            } else {
+                n = f16mop_adj_pair(n, prow, negx);
+            }
 
             for (col = 0; col < oprsz; ) {
                 uint16_t pcol = pm[H2(col >> 4)];
@@ -1180,6 +1232,24 @@ void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
+void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_fmopa_w_h(vza, vzn, vzm, vpn, vpm, env, desc, 0, false);
+}
+
+void HELPER(sme_fmops_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_fmopa_w_h(vza, vzn, vzm, vpn, vpm, env, desc, 0x80008000u, false);
+}
+
+void HELPER(sme_ah_fmops_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                              void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_fmopa_w_h(vza, vzn, vzm, vpn, vpm, env, desc, 0, true);
+}
+
 void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
                          CPUARMState *env, uint32_t desc)
 {
@@ -1254,12 +1324,11 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
-void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
-                          void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
+static void do_bfmopa_w(void *vza, void *vzn, void *vzm,
+                        uint16_t *pn, uint16_t *pm, CPUARMState *env,
+                        uint32_t desc, uint32_t negx, bool ah_neg)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    uint32_t neg = simd_data(desc) * 0x80008000u;
-    uint16_t *pn = vpn, *pm = vpm;
     float_status fpst, fpst_odd;
 
     if (is_ebf(env, &fpst, &fpst_odd)) {
@@ -1269,7 +1338,11 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
                 void *vza_row = vza + tile_vslice_offset(row);
                 uint32_t n = *(uint32_t *)(vzn + H1_4(row));
 
-                n = f16mop_adj_pair(n, prow, neg);
+                if (ah_neg) {
+                    n = bf16mop_ah_neg_adj_pair(n, prow);
+                } else {
+                    n = f16mop_adj_pair(n, prow, negx);
+                }
 
                 for (col = 0; col < oprsz; ) {
                     uint16_t pcol = pm[H2(col >> 4)];
@@ -1296,7 +1369,11 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
                 void *vza_row = vza + tile_vslice_offset(row);
                 uint32_t n = *(uint32_t *)(vzn + H1_4(row));
 
-                n = f16mop_adj_pair(n, prow, neg);
+                if (ah_neg) {
+                    n = bf16mop_ah_neg_adj_pair(n, prow);
+                } else {
+                    n = f16mop_adj_pair(n, prow, negx);
+                }
 
                 for (col = 0; col < oprsz; ) {
                     uint16_t pcol = pm[H2(col >> 4)];
@@ -1319,6 +1396,24 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
     }
 }
 
+void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_bfmopa_w(vza, vzn, vzm, vpn, vpm, env, desc, 0, false);
+}
+
+void HELPER(sme_bfmops_w)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_bfmopa_w(vza, vzn, vzm, vpn, vpm, env, desc, 0x80008000u, false);
+}
+
+void HELPER(sme_ah_bfmops_w)(void *vza, void *vzn, void *vzm, void *vpn,
+                             void *vpm, CPUARMState *env, uint32_t desc)
+{
+    do_bfmopa_w(vza, vzn, vzm, vpn, vpm, env, desc, 0, true);
+}
+
 typedef uint32_t IMOPFn32(uint32_t, uint32_t, uint32_t, uint8_t, bool);
 static inline void do_imopa_s(uint32_t *za, uint32_t *zn, uint32_t *zm,
                               uint8_t *pn, uint8_t *pm,
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 38d0231b0a..782f408061 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -526,7 +526,7 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
                             gen_helper_gvec_5_ptr *fn)
 {
     int svl = streaming_vec_reg_size(s);
-    uint32_t desc = simd_desc(svl, svl, a->sub);
+    uint32_t desc = simd_desc(svl, svl, 0);
     TCGv_ptr za, zn, zm, pn, pm, fpst;
 
     if (!sme_smza_enabled_check(s)) {
@@ -548,7 +548,7 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
                            gen_helper_gvec_5_ptr *fn)
 {
     int svl = streaming_vec_reg_size(s);
-    uint32_t desc = simd_desc(svl, svl, a->sub);
+    uint32_t desc = simd_desc(svl, svl, 0);
     TCGv_ptr za, zn, zm, pn, pm;
 
     if (!sme_smza_enabled_check(s)) {
@@ -565,14 +565,23 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a,
-           MO_32, gen_helper_sme_fmopa_w_h)
-TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_ZA, gen_helper_sme_fmopa_s)
-TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-           MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
+TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a, MO_32,
+           !a->sub ? gen_helper_sme_fmopa_w_h
+           : !s->fpcr_ah ? gen_helper_sme_fmops_w_h
+           : gen_helper_sme_ah_fmops_w_h)
+TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, FPST_ZA,
+           !a->sub ? gen_helper_sme_fmopa_s
+           : !s->fpcr_ah ? gen_helper_sme_fmops_s
+           : gen_helper_sme_ah_fmops_s)
+TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a, MO_64, FPST_ZA,
+           !a->sub ? gen_helper_sme_fmopa_d
+           : !s->fpcr_ah ? gen_helper_sme_fmops_d
+           : gen_helper_sme_ah_fmops_d)
 
-TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa_w)
+TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
+           !a->sub ? gen_helper_sme_bfmopa_w
+           : !s->fpcr_ah ? gen_helper_sme_bfmops_w
+           : gen_helper_sme_ah_bfmops_w)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
-- 
2.43.0


