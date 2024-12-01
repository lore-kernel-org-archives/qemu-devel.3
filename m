Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0422D49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX0-0001UG-Fj; Sun, 01 Dec 2024 10:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWw-0001Qk-Uv
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:39 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWu-0004Gx-TJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:38 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5eede9695ffso1697028eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065595; x=1733670395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TGahI6XPreKm44KKynLHSSYI/OCUPbNrmeZGwSZP2s=;
 b=Dv9scDpIY6BMMGiuMV0hm/ZNO5r0vRpONTWu7gm9gQBKeNnzKQkFEt23TEBhNElvqo
 wPFYI8Gr78ww0jg3gTm+4Q7tjNtgPYvwAEOozdLd02JE8RgCK7cXgYUPx7bGl7oS8B0P
 6IIXtUSFNKYXJU9zAK1p0uw3L9qC11COaMMnmsMfM46bgTJBslzcMfCN3NqNokhQIfr7
 f5vzPXjq7D40rWxScSL2KcK1ZKdFQ13dL21gFtd/fgEhmJMGE42hGB7ijbJBXHb3o2zf
 +Z9QqGfAhL9r+4FwCKGe/uGd8CzYZjKxtJyGFhGHaCD4Uy0EFsJL9ykzbWyzMh/N01mN
 N2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065595; x=1733670395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TGahI6XPreKm44KKynLHSSYI/OCUPbNrmeZGwSZP2s=;
 b=woY5HdzPhbk1QUG5B3Khw3l0qJbPF0UlNj+EtDWgdedpfYp12e8zPTKs9vlSqVzYbp
 g4JT3dsk331pqCNud9P39C+ynRqwAdzrxDXibiLFbFi5pRfOtUlUra8aRngB51hr6m++
 yGpEz9ddgJlJw+qDqsowsLXzW/p0H3FdeKhLnA4aNbJD4Icf1mPJbHf7X5mGuTvXH80s
 wFUCYm2BhzMQSfhuwM21M5BIwvaaD3CYXV3i+rzEZKkJTBKe9i8zo2RgQtklBmBVIMrb
 J3EeC3JxAwWJVTt46/ZJ9gDeRxAUYtsloVnLc9OyQ/UJxD2SdwZfxZ0MyGnckeHPDq4B
 nUTA==
X-Gm-Message-State: AOJu0YxAZipVpkNnIbc0uUcQ4VriLg0tkpozCTURf8E15WmYqJKH7v6b
 n/Rw2V690kZ2banKeO/+XWcu3X0g3yF09MYgVgiBTpb5MfpZWsYPAFVWztCui45uDP4C/7sPYZu
 VZkk=
X-Gm-Gg: ASbGnctekQoIvO26epQMA6+kz85r76qd+/8qdTInl1vR2JBFlLRmF25tV+IOoOwIXsB
 n9LStb3d1tLJBDpNw3h97lMMB+2wuj6y5nZcgIleMaoVzpp7A1flH+RR7l/laoaUCuG34r48AGT
 5YIQfcVEozMn3TgNOqFrtVBXOD9b0hV4AJnDescjis6FuneUzODoS2lEbUpAGmgGVKEpqVdhiNm
 7ZipDOUFiw39b9vMnIxiY57vPh6+IHJ8pWU9LnYi8IG45V+b+5IVv2XyCHy88FrnNNRVxCPC328
 yVjM+wkIKMqTHDaHQrs00/xXw/CJDD/kusEZ
X-Google-Smtp-Source: AGHT+IGxarH7k8wvVdmrXl1rDWCjBsLJ+zwcGtiyCT6TQkw9Bg+mIaFr96dVdiZJqNNu+i8E68v7Og==
X-Received: by 2002:a05:6830:3808:b0:71d:634a:e0d6 with SMTP id
 46e09a7af769-71d65c7e1famr15429603a34.6.1733065595491; 
 Sun, 01 Dec 2024 07:06:35 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 23/67] target/arm: Convert FMOV, FABS,
 FNEG (scalar) to decodetree
Date: Sun,  1 Dec 2024 09:05:22 -0600
Message-ID: <20241201150607.12812-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
 target/arm/tcg/translate-a64.c | 104 ++++++++++++++++++++++-----------
 target/arm/tcg/a64.decode      |   7 +++
 2 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2d3566e45c..87731e0be4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8287,6 +8287,67 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     return true;
 }
 
+typedef struct FPScalar1Int {
+    void (*gen_h)(TCGv_i32, TCGv_i32);
+    void (*gen_s)(TCGv_i32, TCGv_i32);
+    void (*gen_d)(TCGv_i64, TCGv_i64);
+} FPScalar1Int;
+
+static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
+                              const FPScalar1Int *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t = read_fp_dreg(s, a->rn);
+            f->gen_d(t, t);
+            write_fp_dreg(s, a->rd, t);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_sreg(s, a->rn);
+            f->gen_s(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_hreg(s, a->rn);
+            f->gen_h(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
+static const FPScalar1Int f_scalar_fmov = {
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i64,
+};
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+
+static const FPScalar1Int f_scalar_fabs = {
+    gen_vfp_absh,
+    gen_vfp_abss,
+    gen_vfp_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+
+static const FPScalar1Int f_scalar_fneg = {
+    gen_vfp_negh,
+    gen_vfp_negs,
+    gen_vfp_negd,
+};
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8295,15 +8356,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        break;
-    case 0x1: /* FABS */
-        gen_vfp_absh(tcg_res, tcg_op);
-        break;
-    case 0x2: /* FNEG */
-        gen_vfp_negh(tcg_res, tcg_op);
-        break;
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
@@ -8331,6 +8383,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8349,15 +8404,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        goto done;
-    case 0x1: /* FABS */
-        gen_vfp_abss(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negs(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8393,6 +8439,9 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_s;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8417,22 +8466,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     TCGv_ptr fpst;
     int rmode = -1;
 
-    switch (opcode) {
-    case 0x0: /* FMOV */
-        gen_gvec_fn2(s, false, rd, rn, tcg_gen_gvec_mov, 0);
-        return;
-    }
-
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x1: /* FABS */
-        gen_vfp_absd(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negd(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8465,6 +8502,9 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_d;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -10881,13 +10921,11 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
             gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
-        case 0x6f: /* FNEG */
-            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-            break;
         case 0x7d: /* FRSQRTE */
             gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
         default:
+        case 0x6f: /* FNEG */
             g_assert_not_reached();
         }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 928e69da69..fca64c63c3 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -47,6 +47,7 @@
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
+@rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
 
 @rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
@@ -1321,6 +1322,12 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
+# Floating-point data processing (1 source)
+
+FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
+FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
+FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


