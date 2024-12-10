Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D338E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xa-0004c0-Qh; Tue, 10 Dec 2024 11:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xT-0004AB-2N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:35 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xR-0006Wc-6U
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:34 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30227ccf803so18380601fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847571; x=1734452371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McfZQURJzCV4MG39Dc+S7lfs3y6jo+IbKtnV4z9uT+g=;
 b=yizj0zUgovLfbsoqJ2HBFQQTUai9qA+O/gi9mTqTT+VRqd0FeAtRK7aJOJtT3UdK+N
 WrGo5h9nJK5UyRkO0g2aw3qfjjo8foE7JkFWBH78Pa961CIVWFYvEeljsJYMKKt8AvvV
 IPwGsHmbnY6bU+6p/I4PFzWpaFqrZDP7AKhQ0rKk0UMGTE3WMZ5dvBUXOCvmOyNs9yy9
 HU8DA96apNDVc0nMzIVHX2ET13VR/J12bsoqmkNHh6ZQnh9GmKZSVq6ytbKONBg5euND
 SHS1JXGS1vhBXd8Tr6Yg2XWwuXLBdHMhJTr0hGyZWwyAumJdju/bf4GJ+FVnmfthyknP
 n8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847571; x=1734452371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McfZQURJzCV4MG39Dc+S7lfs3y6jo+IbKtnV4z9uT+g=;
 b=qR3o1QX5/NT21LrXtdkbRRXMiooiHSLZvi3F5mr7vi2/b0RAXcEu/Wz5CdSzWbfJHK
 1HzSUcB1LfGFdXH4cUML1Y2L+mtqPZJb2VYWF5069JrGqUAWOqhRNZgLD8UCUUIudwzV
 PhzEIUXLvK1fK5TeVRcHVw5EoTDDHjpkEqs6BMFKTvZRNjjk3YmofGodN1ZLc3vRpX5L
 Re+S7euPifvU7Tk2RLUV2oln15KHMPPnIPZww97spEZZmn0cQPQjYc2KaSBvynoXkwkX
 Eqrq/3z5Ct3wvQM2LGMzIIyErXbBazlg0CJLGtLZ36UyybFLfi+hIB8nOSu3CjqFztiA
 apDw==
X-Gm-Message-State: AOJu0YzYJ8MW7jbYwuiBIK+jx+nPgWxlSI/C96vpFM8S4T14vzEeXjy3
 SbNAEUTr0z54livF1ezjm0dvJhsd6GR2jIAZnSCT6b0IPFGQPE4fonLxmE9OgXr1PFRY4WfwBuD
 ocbyO/56a
X-Gm-Gg: ASbGncvay45WhmieIeMz0RhD8HqTXfOoAmIX5Kty1UTZv7bh1AxUfK7mVgJv+dnNZRi
 tR23NAov3YESSEw66S1Lq3R3KBJT/9tva87IXUQ0BuVULV3D3Dk+TNNzEGBGo7mZ0y+Q93nyNsQ
 mg1MeGTe4hkRjIqQtoNgfXa/yG4A60ydczLLq7NwwiXmOh7Rc8plYYV1R8uFKBEtLg5CdFXbGJD
 3qxMno/imayKDlG3MV7r92hBUL8r7DdO6PhcYksbM3yXQ7BIdgQtOtXBcc=
X-Google-Smtp-Source: AGHT+IETjqqoPyz3wEoFoAvwxQXPfuYihBmIGfVWqelryWNloAH+1rlUrGz2BLQ+m1Rszm2s+riiiw==
X-Received: by 2002:a05:651c:1992:b0:302:1b18:2c09 with SMTP id
 38308e7fff4ca-3021b182f7fmr42697561fa.27.1733847571441; 
 Tue, 10 Dec 2024 08:19:31 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 27/69] target/arm: Convert FSQRT (scalar) to decodetree
Date: Tue, 10 Dec 2024 10:16:51 -0600
Message-ID: <20241210161733.1830573-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
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
 target/arm/tcg/translate-a64.c | 72 ++++++++++++++++++++++++++++------
 target/arm/tcg/a64.decode      |  1 +
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e6878abd35..f32cc2f0af 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8344,6 +8344,63 @@ static const FPScalar1Int f_scalar_fneg = {
 };
 TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
 
+typedef struct FPScalar1 {
+    void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_s)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_ptr);
+} FPScalar1;
+
+static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr fpst;
+    TCGv_i64 t64;
+    TCGv_i32 t32;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    if (rmode >= 0) {
+        tcg_rmode = gen_set_rmode(rmode, fpst);
+    }
+
+    switch (a->esz) {
+    case MO_64:
+        t64 = read_fp_dreg(s, a->rn);
+        f->gen_d(t64, t64, fpst);
+        write_fp_dreg(s, a->rd, t64);
+        break;
+    case MO_32:
+        t32 = read_fp_sreg(s, a->rn);
+        f->gen_s(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    case MO_16:
+        t32 = read_fp_hreg(s, a->rn);
+        f->gen_h(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (rmode >= 0) {
+        gen_restore_rmode(tcg_rmode, fpst);
+    }
+    return true;
+}
+
+static const FPScalar1 f_scalar_fsqrt = {
+    gen_helper_vfp_sqrth,
+    gen_helper_vfp_sqrts,
+    gen_helper_vfp_sqrtd,
+};
+TRANS(FSQRT_s, do_fp1_scalar, a, &f_scalar_fsqrt, -1)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8352,10 +8409,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8382,6 +8435,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8400,9 +8454,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrts;
-        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8438,6 +8489,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8465,9 +8517,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrtd;
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8500,6 +8549,7 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8619,7 +8669,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             goto do_unallocated;
         }
         /* fall through */
-    case 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
@@ -8672,6 +8721,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b9cc8963da..3b1e8e0776 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1327,6 +1327,7 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
 FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
 FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+FSQRT_s         00011110 .. 1 000011 10000 ..... .....      @rr_hsd
 
 # Floating-point Immediate
 
-- 
2.43.0


