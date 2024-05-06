Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1A3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mqO-00020W-Fc; Sun, 05 May 2024 21:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mps-0008C0-TC
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:08:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpc-0003Oc-TO
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:08:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f44e3fd382so897808b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957671; x=1715562471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pg5PE4uCNyJoQzz7Wu/fhXy6Xq//DI/x03rYIO5TrJQ=;
 b=VMj0xofAKW4zrwlcplwTxELth0UnykpiK96Y61+nB7CoLY/amW/ZNMGJN/+PS1Q/TX
 B6A885UKJjEafrqGd3P/PFgkCuSJl7OPakyGIeWbHiphVFTJ7r3GZRvi9cIziJos6VHP
 YDMe5kWTdak6don7vj3cVkt+p4et0f25vlSd+pfwseDFqSEe6/stHK17rhPQRIzwwPA3
 twCa93zJLsyzT9LgOHkZbz9RahyP9zR3sCFhCAS4cmBwJBioCn2gNbieYEJYMJTxpOnh
 mV/gYZZt7/BcQQuV//2xRXVT0QQLgJ08J9/8BfPaZTQCp5GP2/RbzxRgfU8KHxtXSwT8
 IpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957671; x=1715562471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pg5PE4uCNyJoQzz7Wu/fhXy6Xq//DI/x03rYIO5TrJQ=;
 b=rZ3eb0iibbxcLPrk9S/yVXTzg+kUN5+T96Ofy670vM9cEvW+b63G2kMyL7mmgWpBbV
 7eW1GPnukr1tmsOw5u14w88O8xcPqhdPG8axXysHnolWXJSSABM6Lsbi2IE7f0VDiRmy
 +ZgLcsAjvVYklRwzaSyINNM4MrwWFLg89yc14fY8PbYvdqA+KqyJ+x9W+Cqw9GIupI8B
 MRmoN/W6K31EFfjZFVS8NUstX5b9vwPQU6FU9ROfAXPtAWcdpW/479CuuX76oERoDFaN
 i7hGUvOyWI69aqKmXz+jBpr3BLlvsMn/I9rml53zfA7rB+rKXBeANaHEfifgx7XymmHg
 QphA==
X-Gm-Message-State: AOJu0YwauZhvE3clH75TfX/uHdNUdR8XuiFj+jSLqdR57ALfqGSER3PY
 TCirmv2imr1J0Sh/ghd4i8hvhXAZOZVNQxWVt6zALtL4pOYfe/RPiw3brgV89CCIvYIOjYqNCmq
 8
X-Google-Smtp-Source: AGHT+IHJHfsIeBQPar+cy04JHubPmgulcdLhS7JBjVN026Dva8/AMHZSLVUQHPXT52VH4Sr2KjrN5Q==
X-Received: by 2002:a05:6a00:1381:b0:6ea:e2fd:6100 with SMTP id
 t1-20020a056a00138100b006eae2fd6100mr9933413pfg.30.1714957670831; 
 Sun, 05 May 2024 18:07:50 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 55/57] target/arm: Convert MLA, MLS to decodetree
Date: Sun,  5 May 2024 18:04:01 -0700
Message-Id: <20240506010403.6204-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/arm/tcg/a64.decode      |  8 ++++
 target/arm/tcg/translate-a64.c | 77 ++++++++++------------------------
 2 files changed, 31 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index dbeb5667fd..8f7ae63e17 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -928,6 +928,8 @@ SABA_v          0.00 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 UABA_v          0.10 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 MUL_v           0.00 1110 ..1 ..... 10011 1 ..... ..... @qrrr_e
 PMUL_v          0.10 1110 001 ..... 10011 1 ..... ..... @qrrr_b
+MLA_v           0.00 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
+MLS_v           0.10 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
@@ -972,3 +974,9 @@ FMLSL2_vi       0.10 1111 10 .. .... 1100 . 0 ..... .....   @qrrx_h
 
 MUL_vi          0.00 1111 01 .. .... 1000 . 0 ..... .....   @qrrx_h
 MUL_vi          0.00 1111 10 . ..... 1000 . 0 ..... .....   @qrrx_s
+
+MLA_vi          0.10 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
+MLA_vi          0.10 1111 10 . ..... 0000 . 0 ..... .....   @qrrx_s
+
+MLS_vi          0.10 1111 01 .. .... 0100 . 0 ..... .....   @qrrx_h
+MLS_vi          0.10 1111 10 . ..... 0100 . 0 ..... .....   @qrrx_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cd39fa1f20..c217522b2b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5471,6 +5471,8 @@ TRANS(SABD_v, do_gvec_fn3_no64, a, gen_gvec_sabd)
 TRANS(UABD_v, do_gvec_fn3_no64, a, gen_gvec_uabd)
 TRANS(MUL_v, do_gvec_fn3_no64, a, tcg_gen_gvec_mul)
 TRANS(PMUL_v, do_gvec_op3_ool, a, 0, gen_helper_gvec_pmul_b)
+TRANS(MLA_v, do_gvec_fn3_no64, a, gen_gvec_mla)
+TRANS(MLS_v, do_gvec_fn3_no64, a, gen_gvec_mls)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -5713,6 +5715,24 @@ static gen_helper_gvec_3 * const f_vector_idx_mul[2] = {
 };
 TRANS(MUL_vi, do_int3_vector_idx, a, f_vector_idx_mul)
 
+static bool do_mla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool sub)
+{
+    static gen_helper_gvec_4 * const fns[2][2] = {
+        { gen_helper_gvec_mla_idx_h, gen_helper_gvec_mls_idx_h },
+        { gen_helper_gvec_mla_idx_s, gen_helper_gvec_mls_idx_s },
+    };
+
+    assert(a->esz == MO_16 || a->esz == MO_32);
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                         a->idx, fns[a->esz - 1][sub]);
+    }
+    return true;
+}
+
+TRANS(MLA_vi, do_mla_vector_idx, a, false)
+TRANS(MLS_vi, do_mla_vector_idx, a, true)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10939,12 +10959,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 0x12: /* MLA, MLS */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x16: /* SQDMULH, SQRDMULH */
         if (size == 0 || size == 3) {
             unallocated_encoding(s);
@@ -10975,6 +10989,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x0f: /* SABA, UABA */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
+    case 0x12: /* MLA, MLS */
     case 0x13: /* MUL, PMUL */
         unallocated_encoding(s);
         return;
@@ -10985,13 +11000,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x12: /* MLA, MLS */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
-        }
-        return;
     case 0x16: /* SQDMULH, SQRDMULH */
         {
             static gen_helper_gvec_3_ptr * const fns[2][2] = {
@@ -12198,13 +12206,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     TCGv_ptr fpst;
 
     switch (16 * u + opcode) {
-    case 0x10: /* MLA */
-    case 0x14: /* MLS */
-        if (is_scalar) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x02: /* SMLAL, SMLAL2 */
     case 0x12: /* UMLAL, UMLAL2 */
     case 0x06: /* SMLSL, SMLSL2 */
@@ -12286,6 +12287,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x08: /* MUL */
     case 0x09: /* FMUL */
+    case 0x10: /* MLA */
+    case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
@@ -12406,40 +12409,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                : gen_helper_gvec_fcmlah_idx);
         }
         return;
-
-    case 0x10: /* MLA */
-        if (!is_long && !is_scalar) {
-            static gen_helper_gvec_4 * const fns[3] = {
-                gen_helper_gvec_mla_idx_h,
-                gen_helper_gvec_mla_idx_s,
-                gen_helper_gvec_mla_idx_d,
-            };
-            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               vec_full_reg_offset(s, rd),
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               index, fns[size - 1]);
-            return;
-        }
-        break;
-
-    case 0x14: /* MLS */
-        if (!is_long && !is_scalar) {
-            static gen_helper_gvec_4 * const fns[3] = {
-                gen_helper_gvec_mls_idx_h,
-                gen_helper_gvec_mls_idx_s,
-                gen_helper_gvec_mls_idx_d,
-            };
-            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               vec_full_reg_offset(s, rd),
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               index, fns[size - 1]);
-            return;
-        }
-        break;
     }
 
     if (size == 3) {
-- 
2.34.1


