Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23EAC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGw-0000jx-6I; Fri, 04 Jul 2025 12:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFX-0005S5-QG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFV-0006yO-1E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so709529f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646411; x=1752251211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sspvGbiwkvFUsLHBGvUKOtPXlep+IBFp2de53cXvK70=;
 b=uSJTC8/ta3MnPCa7hFYaswoqXlrlCdodlxuXmHPrTp/7jyyhmHEaGaaNlbwa7KYChi
 KsFIQL5fgAgkprOQ8r4I/0cX6d+yUGBHNq87OAUs6je/WTCzJFWtVg2Dbk/XDcxJBDCS
 pekyQhoa57rRKmR5bBqAzsDFnV7DnEv3bIalP8KmGZszrSBZptiBQMQnJ0hNsRn1pm2q
 1cH0YJJlTDMqVOp2w6noqtP3zgyERIrkn/AlCvafmHQq0gldPqNuRwckOcdnfFNqon2G
 MaMk2UkGi/BV+YhL8kbUctvVgCpAfdrSKcwnwYdsHFl5PA59IuDy8Kn68BBoGpwNIMR7
 qIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646411; x=1752251211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sspvGbiwkvFUsLHBGvUKOtPXlep+IBFp2de53cXvK70=;
 b=SijiF6tyPCFIxeoF2jC1PuPDVy5MW9hscZalo/ZtqJxex+hpQAhAmMBduL1RSG+FA9
 s2DEO3HZYSD23xRpv2wSaIEUrj9EarDUs9V3RkI5416Ldzm7Av8fdYyK39TJ87ds6bq5
 4C6V06TozNjrAhCGzlAu+nXsgd8hcq5LUTBozK7XZDagAMnGsTTugma7SKhpYmA2O3/C
 5aD/EiXwuwQ+oE7g8n6OT0dwgt7mnaEGKg9bRo7BBRbz0JMdE8III8MZ5f46CxQI1Zx5
 tMAUFO7qWpz40822G8C6Nu8wNiS3T0kS8pJQSVzqyxJim+6o/uWKAYd6DJ9gDVb3I52C
 jDhQ==
X-Gm-Message-State: AOJu0YzPEAcEUSJfBW8w84/odESLaG2jd38igeVFVrkAw1NNhuIAICIj
 iD3LCGG6mRCSqnGBVBQOUk7+Lrql3NIndXaEWuZHrzeFQ6lEqKDu7GWitedTXrv7p0XYHxP84QI
 VGGPA
X-Gm-Gg: ASbGncsDllLJENf6OaqDZ/u1CASlyhWacRFZWpGmw0X2KY59KvuL6zWaEAUNyFAvN07
 Qioyah1KtpGIscKEg4kF9ps8V4BLAe/Y+EjRxn04ZtA6qibLK8j4BEt1SdT/bmgUK6PwZaIqvj7
 ltGRsLYQ3wzc/ggjIHg9VT7X1A5GpDLFDut+/KwB8g4uFKUECwUtQ+mH2qUYCu2tuhnJ/pPF18l
 L0vYb+eroYM2gfm7U49DzY+sD5mf0LDanuN9BX1x3/MTNXlxfA4LQXCUuSRNrwRptShFCwxGlEf
 48WC85oH+0fJpMMCTImuLzBaP8JVf6W540XfSKTsBbuGPbifhO0nAFYc7Q8AsFvm0hMp
X-Google-Smtp-Source: AGHT+IHsHDyFP1iGXUM73Zr0CIrH7ajq7pEwEUJVfpre2QTZnn+jMfTGQ9FCKdXyXW1HSkh0lb8i4g==
X-Received: by 2002:a05:6000:250d:b0:3a4:e8bc:594 with SMTP id
 ffacd0b85a97d-3b4964bb64emr2251565f8f.8.1751646411423; 
 Fri, 04 Jul 2025 09:26:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 115/119] target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
Date: Fri,  4 Jul 2025 17:24:55 +0100
Message-ID: <20250704162501.249138-116-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For non-widening, we can use float_muladd_negate_product,
For widening, which uses dot-product, we need to handle
the negation explicitly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-104-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  19 +++++
 target/arm/tcg/vec_internal.h  |   5 ++
 target/arm/tcg/sme_helper.c    | 141 +++++++++++++++++++++++++++------
 target/arm/tcg/translate-sme.c |  27 ++++---
 4 files changed, 160 insertions(+), 32 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 16083660e2f..2b22c6aee50 100644
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
index 957bf6d9fca..cf41b03dbcd 100644
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
index 4772c97debb..eff0ce74808 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1002,19 +1002,18 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
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
@@ -1022,7 +1021,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, fpst);
+                            *a = float32_muladd(n, *m, *a, negf, fpst);
                         }
                         col += 4;
                         pb >>= 4;
@@ -1035,29 +1034,65 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
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
@@ -1078,6 +1113,20 @@ static inline uint32_t f16mop_adj_pair(uint32_t pair, uint32_t pg, uint32_t neg)
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
@@ -1146,12 +1195,11 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
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
@@ -1162,7 +1210,11 @@ void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
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
@@ -1187,6 +1239,24 @@ void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
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
@@ -1261,12 +1331,11 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
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
@@ -1276,7 +1345,11 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
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
@@ -1303,7 +1376,11 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
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
@@ -1326,6 +1403,24 @@ void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
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
index 38d0231b0a9..782f4080611 100644
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


