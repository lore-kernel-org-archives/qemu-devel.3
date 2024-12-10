Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487CAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xl-00056H-U5; Tue, 10 Dec 2024 11:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xc-0004iZ-PB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:46 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xY-0006Xj-QG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:43 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30225b2586cso20304771fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847576; x=1734452376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EG5ap3L6H0uS67mUIBk4bFPwmGZ4OMrw9+6SqLKnO3s=;
 b=DPszq0Z4IBwKv3Hdd2O2RRHZ1N7R+0Tg9IVEOnrshTegpLBLo6NOHgzlO2ymS/hyeI
 JI+yv5BhU6xlzPjJ2J5PV900psyqrs8mcyfNlTG3SiYUoWwhBf22NEgUYo2u7zHeVGjw
 8pTncjKq755bgtsHTk4nS0WKoF4eljVsio7G1OOz1xeFRFFU9RK2ZmtqYfLVjzftv0y9
 0OIEQhUogL8+cJxqXJHkc2dGznqv+NK/S0DKm2TvBo2bpMPCoA0yg9dTHSCh8p5d+UVf
 JigqKup0gwY3PMs7SUTGzDDcf8NvjCcXgO+c37B1omZhy9Uy/cRl5paTuk3MuSLvsXoy
 f13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847576; x=1734452376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG5ap3L6H0uS67mUIBk4bFPwmGZ4OMrw9+6SqLKnO3s=;
 b=rfR/sjm/Xf5rjRvCLP9FN/1kK1PLzWCH4hw8UOcV6sojUhbuXQ6fAvaajGb7dENI/E
 y84uke5tEnBtTOkoPMUzimWkfX7ZJCrV3AHrlTOwfj1OyDOBHa2xygsLoDlX2V2KWmd8
 15WVhGeFA0UJ4BdotJvh2v9Q4UE9Hg0Tuk836qa9GNx3ROHaKVU+e/Eo6cK2oK2GbubZ
 kfyZvlvPoUz+DrEsRAHHb+N/4v/5gU4Ye5mH9d8ARkwLEAIPS+HJWUN3cM99V/D18DCr
 qn+e07z00jtRO/iUhDx6xdm1hfdLrg0QNJYvz3T8aZRYlEcB24GroV3EA+I82mwHhqkV
 VLpw==
X-Gm-Message-State: AOJu0YyDahCO8vlmy21FYzw2qAr+Mz2BqB/SEyNeqIiwm8cKh7ZI7zgX
 beErQdqzFVIdKLy1Q7t3X3pTJM9zBmjD/0d2mbCYpP82WKZkK9ZedipnIEgb9je+nyAZSoaWVvh
 o55wdcq/V
X-Gm-Gg: ASbGncvZtZITWAy7KyGwXj4JiWmWtHD3obFPVdhxphGwW9taKpqikY/LTj9EBmh+98r
 s1Ndtrkh4fupgtrFCO5E/mIn6ac8e1FkbTM2pdEbCyYfiQxHW2PlYlTSoo0X2NeV6scyoMwUK/Q
 NNeIcuJOlj2w9rBJRc0rWYsYBEgCGXmCQw9Jm/eCkt8rd42EizIG/ouyFNGIowI4HOjf1k+TpQ4
 065WlJPLm6EkXNiLNL6guKeyLJcidPvl5ZoqkJwdpF38cCxlDSDh7Z0V+w=
X-Google-Smtp-Source: AGHT+IFiuDtK5oSrF00ziVwXF5EHACiLqL0ur5DBMbPLJhiqViGgVx+dsGVzeHOgNKZEDcIO8LMImQ==
X-Received: by 2002:a05:6512:308b:b0:53d:f2e8:b37f with SMTP id
 2adb3069b0e04-540251d4b7dmr1354003e87.6.1733847576008; 
 Tue, 10 Dec 2024 08:19:36 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 28/69] target/arm: Convert FRINT[NPMSAXI] (scalar) to
 decodetree
Date: Tue, 10 Dec 2024 10:16:52 -0600
Message-ID: <20241210161733.1830573-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22c.google.com
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

Remove handle_fp_1src_half as these were the last insns
decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 117 +++++++++++----------------------
 target/arm/tcg/a64.decode      |   8 +++
 2 files changed, 46 insertions(+), 79 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f32cc2f0af..45321cdca7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8401,46 +8401,24 @@ static const FPScalar1 f_scalar_fsqrt = {
 };
 TRANS(FSQRT_s, do_fp1_scalar, a, &f_scalar_fsqrt, -1)
 
-/* Floating-point data-processing (1 source) - half precision */
-static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
-{
-    TCGv_ptr fpst = NULL;
-    TCGv_i32 tcg_op = read_fp_hreg(s, rn);
-    TCGv_i32 tcg_res = tcg_temp_new_i32();
+static const FPScalar1 f_scalar_frint = {
+    gen_helper_advsimd_rinth,
+    gen_helper_rints,
+    gen_helper_rintd,
+};
+TRANS(FRINTN_s, do_fp1_scalar, a, &f_scalar_frint, FPROUNDING_TIEEVEN)
+TRANS(FRINTP_s, do_fp1_scalar, a, &f_scalar_frint, FPROUNDING_POSINF)
+TRANS(FRINTM_s, do_fp1_scalar, a, &f_scalar_frint, FPROUNDING_NEGINF)
+TRANS(FRINTZ_s, do_fp1_scalar, a, &f_scalar_frint, FPROUNDING_ZERO)
+TRANS(FRINTA_s, do_fp1_scalar, a, &f_scalar_frint, FPROUNDING_TIEAWAY)
+TRANS(FRINTI_s, do_fp1_scalar, a, &f_scalar_frint, -1)
 
-    switch (opcode) {
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-    {
-        TCGv_i32 tcg_rmode;
-
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        tcg_rmode = gen_set_rmode(opcode & 7, fpst);
-        gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
-        gen_restore_rmode(tcg_rmode, fpst);
-        break;
-    }
-    case 0xe: /* FRINTX */
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, fpst);
-        break;
-    case 0xf: /* FRINTI */
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
-        break;
-    default:
-    case 0x0: /* FMOV */
-    case 0x1: /* FABS */
-    case 0x2: /* FNEG */
-    case 0x3: /* FSQRT */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
+static const FPScalar1 f_scalar_frintx = {
+    gen_helper_advsimd_rinth_exact,
+    gen_helper_rints_exact,
+    gen_helper_rintd_exact,
+};
+TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
 /* Floating-point data-processing (1 source) - single precision */
 static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
@@ -8457,20 +8435,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-        rmode = opcode & 7;
-        gen_fpst = gen_helper_rints;
-        break;
-    case 0xe: /* FRINTX */
-        gen_fpst = gen_helper_rints_exact;
-        break;
-    case 0xf: /* FRINTI */
-        gen_fpst = gen_helper_rints;
-        break;
     case 0x10: /* FRINT32Z */
         rmode = FPROUNDING_ZERO;
         gen_fpst = gen_helper_frint32_s;
@@ -8490,6 +8454,13 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x8: /* FRINTN */
+    case 0x9: /* FRINTP */
+    case 0xa: /* FRINTM */
+    case 0xb: /* FRINTZ */
+    case 0xc: /* FRINTA */
+    case 0xe: /* FRINTX */
+    case 0xf: /* FRINTI */
         g_assert_not_reached();
     }
 
@@ -8517,20 +8488,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-        rmode = opcode & 7;
-        gen_fpst = gen_helper_rintd;
-        break;
-    case 0xe: /* FRINTX */
-        gen_fpst = gen_helper_rintd_exact;
-        break;
-    case 0xf: /* FRINTI */
-        gen_fpst = gen_helper_rintd;
-        break;
     case 0x10: /* FRINT32Z */
         rmode = FPROUNDING_ZERO;
         gen_fpst = gen_helper_frint32_d;
@@ -8550,6 +8507,13 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x8: /* FRINTN */
+    case 0x9: /* FRINTP */
+    case 0xa: /* FRINTM */
+    case 0xb: /* FRINTZ */
+    case 0xc: /* FRINTA */
+    case 0xe: /* FRINTX */
+    case 0xf: /* FRINTI */
         g_assert_not_reached();
     }
 
@@ -8668,9 +8632,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         if (type > 1 || !dc_isar_feature(aa64_frint, s)) {
             goto do_unallocated;
         }
-        /* fall through */
-    case 0x8 ... 0xc:
-    case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
         switch (type) {
         case 0:
@@ -8686,15 +8647,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             handle_fp_1src_double(s, opcode, rd, rn);
             break;
         case 3:
-            if (!dc_isar_feature(aa64_fp16, s)) {
-                goto do_unallocated;
-            }
-
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_fp_1src_half(s, opcode, rd, rn);
-            break;
         default:
             goto do_unallocated;
         }
@@ -8722,6 +8674,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x8: /* FRINTN */
+    case 0x9: /* FRINTP */
+    case 0xa: /* FRINTM */
+    case 0xb: /* FRINTZ */
+    case 0xc: /* FRINTA */
+    case 0xe: /* FRINTX */
+    case 0xf: /* FRINTI */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3b1e8e0776..9d2f099c9c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1329,6 +1329,14 @@ FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
 FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
 FSQRT_s         00011110 .. 1 000011 10000 ..... .....      @rr_hsd
 
+FRINTN_s        00011110 .. 1 001000 10000 ..... .....      @rr_hsd
+FRINTP_s        00011110 .. 1 001001 10000 ..... .....      @rr_hsd
+FRINTM_s        00011110 .. 1 001010 10000 ..... .....      @rr_hsd
+FRINTZ_s        00011110 .. 1 001011 10000 ..... .....      @rr_hsd
+FRINTA_s        00011110 .. 1 001100 10000 ..... .....      @rr_hsd
+FRINTX_s        00011110 .. 1 001110 10000 ..... .....      @rr_hsd
+FRINTI_s        00011110 .. 1 001111 10000 ..... .....      @rr_hsd
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


