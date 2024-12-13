Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590B7E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YQ-00028n-6u; Fri, 13 Dec 2024 12:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XH-00078k-H4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XC-0001Y6-Mo
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso6413825e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111181; x=1734715981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D//O6XDkX742b9GaodjaS3JMRSMmgDBdq+AzZ965Trg=;
 b=vx9cjzc3URtWNSy24vikh6vvc1giMAVdZaao3eXUJ4WIRDYeOE4qu4TW+Pq5blZL0I
 pSXaX9fdPe8N8TnJeXA4XtsKeD7O0tW4AFg3m7Xq4V+mkG5hHopmGjpsAZ9F1oSsmNMn
 3ZlkaCrU3Fx5IkMBEpcjmTjdTPxJIgMtXG/82PYfNgH4F91VfkTMkkKpOrU9PznVgMo1
 txw/2pabc71JnjVBCgJ3lty7WOB/12GioCuKO1Lsc1deAnZPX1gWYVX+BlEW3jN3+QQC
 jqfhZo2Wv0cT/Ej6hFn9EEMtFAsmRPTpXbVjfJLtXhp7N5YQUae/s8VgGBnEgmIUC5gd
 I2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111181; x=1734715981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D//O6XDkX742b9GaodjaS3JMRSMmgDBdq+AzZ965Trg=;
 b=AympbkLWxnLNN8EASEuHv2LEIRxjKxFkclXd48ttqADNlMNgDXCb7BV/LsQvRWeHii
 WrLkvyqM/6nkUAaiZ7I8DZAFBwIQNTq/p/SZayD24TshZY1kNZbZtZ+I4rvvGanCKapm
 eOBSKeEVzXAWj8yRyD04b8G22lynpsLFQoagK9k4ePNnT1Ro+1eRmz4CcwFMm+5AgbhI
 eLeU+w4cWaOFV/638DVcI+OcuWGtnSgdZqqUzYilZ0ZF3BUppKYTinWgiWvvYAdfDBr5
 54kN4OuTW2a/iSHI4yCGys8TDoaJ6C/SDMm+4AA3X6844L/xFY63/7wN8fb1PFKX4/Gn
 e8tg==
X-Gm-Message-State: AOJu0YzZNhhM4nri8UgO4Luu1wy+ouVnMePQQUFAykAMdx9mI0hsNVK+
 /4SSQAuM82Z07SXMQu6G6484FNss8XjFr7GTOTLXsbrUOfhWAREuhjAWwW68ag2cSWdybWZPMIt
 A
X-Gm-Gg: ASbGnct9j7ELbxcX6gOv5V4Hk2a6PxZS7Nqxya5eOEytu384MVN6poUmJ1bkLmPqABW
 7dqeG3KHBjHWiic7dBqiluMjxwoIaIbciLtQtJOVDKAVLO8ftC4VEMastCDxGcIlBUUumGzMZfR
 3TXe3Fa06Qu7tDtgroxtL70hD2WF2OpWCXvkYv3z/PinEWYsjR5/RDEqnTyur0fPz5fYzqFUnr0
 JpMQinTEB4B8gj5RlCKPJU9Hzb4Z0fTsNQgnal5Dtqs+q6kuNRUzQIOY9fCrQ==
X-Google-Smtp-Source: AGHT+IFohOmZUQrHrp9zJjIBC6Zn35FeP6J1ejS1GmtncvIbP5QzbGPyIcWA3LQQfc4vF/8z7lAdTQ==
X-Received: by 2002:a05:600c:1906:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-4362aa42b9bmr41144875e9.10.1734111181005; 
 Fri, 13 Dec 2024 09:33:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/85] target/arm: Convert FRINT[NPMSAXI] (scalar) to decodetree
Date: Fri, 13 Dec 2024 17:31:32 +0000
Message-Id: <20241213173229.3308926-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Remove handle_fp_1src_half as these were the last insns
decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   8 +++
 target/arm/tcg/translate-a64.c | 117 +++++++++++----------------------
 2 files changed, 46 insertions(+), 79 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3b1e8e07760..9d2f099c9ca 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f3989246f9c..5a347bece37 100644
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
-- 
2.34.1


