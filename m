Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C33E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32L-0007iC-7I; Tue, 10 Dec 2024 11:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31t-0007UY-JB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:12 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31r-0007TT-DL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:09 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5401ab97206so2433135e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847846; x=1734452646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUecK3E1/dcQry3nyFCyRebBoZWMuQHeuKyFcmMyNaU=;
 b=lwcIT3Xj4zDfOsxLZ/U8BuanAyp8Sj34gAVBdASeG20/E4ubSs008Ka4EdxO6KXhof
 n6h+Y0lEmWVHfOBaCGdw05/OpuyGVjwjBNXBkn6Tnq+AtY58bgdrbOiZU2nS5LU1Yt/1
 oovzaI47zXNK96zU7Kx9g5whKZmt3dXzalTYFgW0U2OjRgjsiqtwTCc/acnVKQxFfPL7
 EuJcNm9jznckYaXKU5iUX643OuUDIajyV1BGuZ2AthqLITNNpxL6s+KTAc189DfmZqNW
 1lMVvhdQYkjsQAa1hJuwL1jUiH7Zy9GBTpXpWr541LEgdv3sEvZxGoPHSH0jXjKv59OA
 liVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847846; x=1734452646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUecK3E1/dcQry3nyFCyRebBoZWMuQHeuKyFcmMyNaU=;
 b=jNVSqnEaS1sYazHI9d90h5mpwM4JNMZ1lTJqhb7swW6XYDjYxSd4IyxwZ1DrYPGjlH
 KgrFiaFXSrv37dUHR+zY38BvHOgcjpekaVmPOrvnA1Xa/KP04R2wStDe4U15JjYx8vbS
 F8kIHBCRtBUSK7/rX9bYStGIhYH7U0Dam1HjggTK9NXfmxMBv1EwSMjipyzDqriHhdnX
 yB52rLOsnYKsNqU3fJqnioEZ1MZDoH9sL5dGMhkInclTsMlBoILkGtZjBOO6M5152DXK
 A++PbV6m7FsxFb/HgAUTmcV1HwTeBNpdfFHObt6dTdARGJZKDasknLEClRZbsMPVi9nT
 +gDQ==
X-Gm-Message-State: AOJu0Yx0B3NG6ZQNdwddbnbBsL3fMzix5lejfKnzkwqvJSIDnkcynC2v
 xh23lTY39GYKc2i5XTFyDjxQ2lfQOYb85+xh+QcGr0Zv1tYgmgFlvXsjFFSg8mzH7jTp5dUZnYg
 O6SUfUFUQ
X-Gm-Gg: ASbGncs1qGpbywTBR4Ws5Zs7FZiJqg2N1jcm6Rn6eGpMO6/+R2KjS25UU/DVVAhPv48
 rI3Qq2vVhlw55DZIVBJNwMcXenyHQk/sQbnreCR1CH7frjUYxtKKvptG9jvX7FM7a9ntc1a4Gok
 0BISbMyv2yfteZS89gxHhmsvfNpgugCdsCk432IMJHpUX6uCY65pokulgJ8CijvFANafMQyABIE
 M+KmSCXYxIL/21CIPxB+DlFkeKApVz9dL0EPmM6HKx95JHoGu3T0A/pjHE=
X-Google-Smtp-Source: AGHT+IEBSL1L6TT4K2wyUJERBstZGsnLVtaqGKSRS5OQvjLTqxNF05Wvt9Zjp1TWQspE3DFhPUGjtQ==
X-Received: by 2002:a05:6512:68b:b0:53e:39ba:fb4b with SMTP id
 2adb3069b0e04-540240d9b76mr1734672e87.26.1733847845682; 
 Tue, 10 Dec 2024 08:24:05 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 49/69] target/arm: Convert XTN, SQXTUN, SQXTN,
 UQXTN to decodetree
Date: Tue, 10 Dec 2024 10:17:13 -0600
Message-ID: <20241210161733.1830573-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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
 target/arm/tcg/translate-a64.c | 153 ++++++++++++++++++++-------------
 target/arm/tcg/a64.decode      |   9 ++
 2 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6655468df0..f9d203f7e6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8921,6 +8921,62 @@ TRANS(CMLE0_s, do_cmop0_d, a, TCG_COND_LE)
 TRANS(CMLT0_s, do_cmop0_d, a, TCG_COND_LT)
 TRANS(CMEQ0_s, do_cmop0_d, a, TCG_COND_EQ)
 
+static bool do_2misc_narrow_scalar(DisasContext *s, arg_rr_e *a,
+                                   ArithOneOp * const fn[3])
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        read_vec_element(s, t, a->rn, 0, a->esz + 1);
+        fn[a->esz](t, t);
+        clear_vec(s, a->rd);
+        write_vec_element(s, t, a->rd, 0, a->esz);
+    }
+    return true;
+}
+
+#define WRAP_ENV(NAME) \
+    static void gen_##NAME(TCGv_i64 d, TCGv_i64 n) \
+    { gen_helper_##NAME(d, tcg_env, n); }
+
+WRAP_ENV(neon_unarrow_sat8)
+WRAP_ENV(neon_unarrow_sat16)
+WRAP_ENV(neon_unarrow_sat32)
+
+static ArithOneOp * const f_scalar_sqxtun[] = {
+    gen_neon_unarrow_sat8,
+    gen_neon_unarrow_sat16,
+    gen_neon_unarrow_sat32,
+};
+TRANS(SQXTUN_s, do_2misc_narrow_scalar, a, f_scalar_sqxtun)
+
+WRAP_ENV(neon_narrow_sat_s8)
+WRAP_ENV(neon_narrow_sat_s16)
+WRAP_ENV(neon_narrow_sat_s32)
+
+static ArithOneOp * const f_scalar_sqxtn[] = {
+    gen_neon_narrow_sat_s8,
+    gen_neon_narrow_sat_s16,
+    gen_neon_narrow_sat_s32,
+};
+TRANS(SQXTN_s, do_2misc_narrow_scalar, a, f_scalar_sqxtn)
+
+WRAP_ENV(neon_narrow_sat_u8)
+WRAP_ENV(neon_narrow_sat_u16)
+WRAP_ENV(neon_narrow_sat_u32)
+
+static ArithOneOp * const f_scalar_uqxtn[] = {
+    gen_neon_narrow_sat_u8,
+    gen_neon_narrow_sat_u16,
+    gen_neon_narrow_sat_u32,
+};
+TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
+
+#undef WRAP_ENV
+
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -8964,6 +9020,37 @@ TRANS(UADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_uaddlp)
 TRANS(SADALP_v, do_gvec_fn2_bhs, a, gen_gvec_sadalp)
 TRANS(UADALP_v, do_gvec_fn2_bhs, a, gen_gvec_uadalp)
 
+static bool do_2misc_narrow_vector(DisasContext *s, arg_qrr_e *a,
+                                   ArithOneOp * const fn[3])
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        read_vec_element(s, t0, a->rn, 0, MO_64);
+        read_vec_element(s, t1, a->rn, 1, MO_64);
+        fn[a->esz](t0, t0);
+        fn[a->esz](t1, t1);
+        write_vec_element(s, t0, a->rd, a->q ? 2 : 0, MO_32);
+        write_vec_element(s, t1, a->rd, a->q ? 3 : 1, MO_32);
+        clear_vec_high(s, a->q, a->rd);
+    }
+    return true;
+}
+
+static ArithOneOp * const f_scalar_xtn[] = {
+    gen_helper_neon_narrow_u8,
+    gen_helper_neon_narrow_u16,
+    tcg_gen_ext32u_i64,
+};
+TRANS(XTN, do_2misc_narrow_vector, a, f_scalar_xtn)
+TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
+TRANS(SQXTN_v, do_2misc_narrow_vector, a, f_scalar_sqxtn)
+TRANS(UQXTN_v, do_2misc_narrow_vector, a, f_scalar_uqxtn)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9546,38 +9633,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
-        case 0x12: /* XTN, SQXTUN */
-        {
-            static NeonGenOne64OpFn * const xtnfns[3] = {
-                gen_helper_neon_narrow_u8,
-                gen_helper_neon_narrow_u16,
-                tcg_gen_ext32u_i64,
-            };
-            static NeonGenOne64OpEnvFn * const sqxtunfns[3] = {
-                gen_helper_neon_unarrow_sat8,
-                gen_helper_neon_unarrow_sat16,
-                gen_helper_neon_unarrow_sat32,
-            };
-            if (u) {
-                genenvfn = sqxtunfns[size];
-            } else {
-                genfn = xtnfns[size];
-            }
-            break;
-        }
-        case 0x14: /* SQXTN, UQXTN */
-        {
-            static NeonGenOne64OpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_narrow_sat_s8,
-                  gen_helper_neon_narrow_sat_u8 },
-                { gen_helper_neon_narrow_sat_s16,
-                  gen_helper_neon_narrow_sat_u16 },
-                { gen_helper_neon_narrow_sat_s32,
-                  gen_helper_neon_narrow_sat_u32 },
-            };
-            genenvfn = fns[size][u];
-            break;
-        }
         case 0x16: /* FCVTN, FCVTN2 */
             /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
             if (size == 2) {
@@ -9618,6 +9673,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
             }
             break;
         default:
+        case 0x12: /* XTN, SQXTUN */
+        case 0x14: /* SQXTN, UQXTN */
             g_assert_not_reached();
         }
 
@@ -9653,22 +9710,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x12: /* SQXTUN */
-        if (!u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x14: /* SQXTN, UQXTN */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_narrow(s, true, opcode, u, false, size, rn, rd);
-        return;
     case 0xc ... 0xf:
     case 0x16 ... 0x1d:
     case 0x1f:
@@ -9742,6 +9783,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x12: /* SQXTUN */
+    case 0x14: /* SQXTN, UQXTN */
         unallocated_encoding(s);
         return;
     }
@@ -9939,18 +9982,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
-    case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-
-        handle_2misc_narrow(s, false, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x13: /* SHLL, SHLL2 */
         if (u == 0 || size == 3) {
             unallocated_encoding(s);
@@ -10142,6 +10173,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
+    case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f3488766b2..295329448f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1642,6 +1642,10 @@ CMEQ0_s         0101 1110 111 00000 10011 0 ..... .....     @rr
 CMLE0_s         0111 1110 111 00000 10011 0 ..... .....     @rr
 CMLT0_s         0101 1110 111 00000 10101 0 ..... .....     @rr
 
+SQXTUN_s        0111 1110 ..1 00001 00101 0 ..... .....     @rr_e
+SQXTN_s         0101 1110 ..1 00001 01001 0 ..... .....     @rr_e
+UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
@@ -1667,3 +1671,8 @@ SADDLP_v        0.00 1110 ..1 00000 00101 0 ..... .....     @qrr_e
 UADDLP_v        0.10 1110 ..1 00000 00101 0 ..... .....     @qrr_e
 SADALP_v        0.00 1110 ..1 00000 01101 0 ..... .....     @qrr_e
 UADALP_v        0.10 1110 ..1 00000 01101 0 ..... .....     @qrr_e
+
+XTN             0.00 1110 ..1 00001 00101 0 ..... .....     @qrr_e
+SQXTUN_v        0.10 1110 ..1 00001 00101 0 ..... .....     @qrr_e
+SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
+UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
-- 
2.43.0


