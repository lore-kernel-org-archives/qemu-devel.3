Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA42E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPe4-0008Qe-VB; Wed, 11 Dec 2024 11:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdH-0005M8-PC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:17 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdF-0001Ow-VF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:15 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-46677ef6910so61749881cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934733; x=1734539533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoIR8opIdikMP5mTlzA+lDmXoupiuxSezg0zvazHeRg=;
 b=G644OZSvM+75bs+WGhEiKCaw7SXFIk1wSNy5FLOppD9WRz+RqM00/8Vte0YnOf407x
 KkjjLkKs/pkdgj+ewGRVJmuqIanHgDMlRehgHWKoBW73WDlgcCzu3NoaVYx91ObFFnou
 vCDqhcFbhOI/xkbZ/CjnEswmy/4/daTfHX0p4Q80Qm0dfPR/e31SCVvO3bNkwXFeSgmX
 e+s2eal4SSdIILEs6hh7oH2GriUG6wAhZnjZRqQLp1YG3aabFolvML//gxnZPXbZcZvl
 g4bndmk5p/q4uNB/zCCOXIpj4nl5w5sUqhLGUWNcrjgfI4p/Uuui7dngCjJjp3hDUk5T
 XPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934733; x=1734539533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoIR8opIdikMP5mTlzA+lDmXoupiuxSezg0zvazHeRg=;
 b=Pf5zsDgeFqFJq9FsthUh7pDZUnBRRdw02wMzwhRNSjI95uGG6RIeYVOlgRBtFX+g1d
 CPqD1g6YPThHPJWFvBBoEMZySNk95rFNQJV3YWyPdreoZdF8ELJ9iQn2R0vzNONNVlCJ
 PTgWNL8/FXhuYMhKI4lzC+xoZ+/nuHJGMi0ezlnYUk2ZjtJ0g97jWOJd5F1hJ5qwXW9z
 rEdqnXxQBxKUMHHJ2ivqoyQw96txVnyFNboF6TVh1dpUnFSoCpeyQC1C8o6GyV9T/jz+
 oIrl1UZjIJUIKoCRGqcKJY5jZneHPQoM9VSeWZ2pExvSbSz+AwHt6Zllgv68/TazF3eR
 sVYQ==
X-Gm-Message-State: AOJu0YwcirP1bLBJvNI3GQ6Fe/YdlAXL9XfDMorQ4JYkrNNhWx82PXFQ
 oP/KGNjNJvCbSUrByczxNZs383IWuyeE7CGbEeUZkUKAk67RqyilbUPCUYCEysnbOH8mNrJT3jp
 OjHCBCX43
X-Gm-Gg: ASbGncv9wukBeoFPTXIYhRvI+04hCONqjG0wKQwGXkh4o81XQQ4VfSo1wsLlzmJpa/7
 doqDEvZXMdaWMvk0MX3vXB1VR/3j8Ou87UD/FqblISaODsd3TbQ6tgGS4la8Z6y0P4UHjJZBCoZ
 wnEF1lTZTHHVEau+5BTQ4YcJ6ZULp/lLYWFQ0f25B4k8jBJb3XMQzBcDtEG9awti9PdgI4O0Qep
 sY44T1ZoRj1megG6KoO+ZkcK2gYL3A5gRo5HT3zJKk2O4CMK9rskQa2oDY/wg==
X-Google-Smtp-Source: AGHT+IHhKTUa5X9CxybN+xjcI6uXn8vEpc4vke6z/N15kmIlWTQOmF+35Kqq5KoEuNueveZH2/o31g==
X-Received: by 2002:a05:622a:1b8f:b0:467:71bb:480c with SMTP id
 d75a77b69052e-4678938414bmr65204761cf.49.1733934732594; 
 Wed, 11 Dec 2024 08:32:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 27/69] target/arm: Convert FSQRT (scalar) to decodetree
Date: Wed, 11 Dec 2024 10:29:54 -0600
Message-ID: <20241211163036.2297116-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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
index 2a5cb70475..f3989246f9 100644
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


