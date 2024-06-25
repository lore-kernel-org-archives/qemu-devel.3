Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED6C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 20:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMCtM-0005Fx-Qs; Tue, 25 Jun 2024 16:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMCsg-000585-MJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:35:26 -0400
Received: from [2607:f8b0:4864:20::d30] (helo=mail-io1-xd30.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMCoX-00077q-D9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:34:52 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7e21dfbc310so219102039f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719347323; x=1719952123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN1Efob1I3xatF3I5F8UROtAF2gQdoNN9Kj4+5dUxQA=;
 b=dlPA5B9N/0JF6XQbWR0eHBVrWS3VfsFnpN0+KCaTKg0eHl8hSsJqZ7uMnPLnwQxnCC
 nkDlkr+SHKSTOTspRiKkWFpzl6qK95xUsZu7UhjWUcjg0bCHk0dEo+Tn9wHb6Mj0P4CF
 8sqQgS4eqHgOw10Q0JS1H0HliLvMRhW71lTD9jPQm+VqfTjO/tEbg9qo2y+ez6xxmeOh
 3801mCLKQWbZmbIEjOOFHj+6GcjfurGkJRUAyEvwO2q/OHR8y5HjkLa7l4teSKT6qHfC
 eBzpcDJMzH5CuHQMPmBu3l0s/z0yXt9i1OczFkv8FLRKKWWsFHmqe0eoyhBjUrdhEBvJ
 Vw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719347323; x=1719952123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eN1Efob1I3xatF3I5F8UROtAF2gQdoNN9Kj4+5dUxQA=;
 b=QCJKsT+LXUyQ676EGlE8RIgyru+WIPlz7OyV1Rku2CjAr4WIEgWP1Jx+t8YVz2URlU
 +6JxmqvtA6bohZZFm/nSwi1eRmjknkkTwb1N8WG+hAUtsafeaLkPuqhSuwJfW43WwRxE
 ZUz4opvuVC5eSbuwQPQF43YhcltzaFRO0vLp6L1bj4EDzlg/7CDVhfOSHPlXPW91/7VY
 +kuQo0sJBuuG8jrTCjCinqlLcxpAWBzPtYmqA5kImIL4468OOWSCn9kMOPAtNbB+sPcz
 LsGhLHBMgrM10QfRsUH4UqF4sHvq/B7CT08i4zuhlU1zXl6t3z/+pOsnUNbCVoOXHiAg
 SiOA==
X-Gm-Message-State: AOJu0Yx1V6a27hiL5JhmgUryP2r7ZPK7yoiFhQT/QZgFeRHnLQhfzqOa
 by8zGFbEVdFOE0F2tZYGW/qeXX2bjb62y71PCX/RFVg8Ni2/NKqLV2li0JTkkO8tCqI4eAhZfDZ
 S
X-Google-Smtp-Source: AGHT+IE9swytu+mWzkrvUlWnOVCCTnrNTp9MyM/NefwvNvXaEYNlFnYM+mJSu+K7wPK/G+dLgHVddQ==
X-Received: by 2002:a17:903:32ce:b0:1fa:643:f424 with SMTP id
 d9443c01a7336-1fa238e46ddmr109487635ad.14.1719340542474; 
 Tue, 25 Jun 2024 11:35:42 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/13] target/arm: Convert SDOT, UDOT to decodetree
Date: Tue, 25 Jun 2024 11:35:28 -0700
Message-Id: <20240625183536.1672454-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::d30
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd30.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 target/arm/tcg/a64.decode      |  7 +++++
 target/arm/tcg/translate-a64.c | 54 ++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 613cc9365c..7411d4ba97 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -61,6 +61,7 @@
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
+@qrrr_s         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=2
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
 @qr2r_e         . q:1 ...... esz:2 . ..... ...... rm:5 rd:5 &qrrr_e rn=%rd
@@ -946,6 +947,9 @@ SQRDMULH_v      0.10 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
 SQRDMLAH_v      0.10 1110 ..0 ..... 10000 1 ..... ..... @qrrr_e
 SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 
+SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
+UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1020,6 +1024,9 @@ SQRDMLAH_vi     0.10 1111 10 .. .... 1101 . 0 ..... .....   @qrrx_s
 SQRDMLSH_vi     0.10 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_h
 SQRDMLSH_vi     0.10 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 
+SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
+UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 32c24c7422..f2e7d8d75c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5592,6 +5592,18 @@ TRANS(SQRDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmulh_qc)
 TRANS_FEAT(SQRDMLAH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlah_qc)
 TRANS_FEAT(SQRDMLSH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlsh_qc)
 
+static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
+                          gen_helper_gvec_4 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
+TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5914,6 +5926,18 @@ static gen_helper_gvec_4 * const f_vector_idx_sqrdmlsh[2] = {
 TRANS_FEAT(SQRDMLSH_vi, aa64_rdm, do_int3_qc_vector_idx, a,
            f_vector_idx_sqrdmlsh)
 
+static bool do_dot_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                              gen_helper_gvec_4 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd, a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
+TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10890,14 +10914,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x02: /* SDOT (vector) */
-    case 0x12: /* UDOT (vector) */
-        if (size != MO_32) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_dp, s);
-        break;
     case 0x03: /* USDOT */
         if (size != MO_32) {
             unallocated_encoding(s);
@@ -10947,8 +10963,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x02: /* SDOT (vector) */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
+    case 0x12: /* UDOT (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10961,11 +10979,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x2: /* SDOT / UDOT */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0,
-                         u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b);
-        return;
-
     case 0x3: /* USDOT */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_usdot_b);
         return;
@@ -12043,13 +12056,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0e: /* SDOT */
-    case 0x1e: /* UDOT */
-        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x0f:
         switch (size) {
         case 0: /* SUDOT */
@@ -12099,12 +12105,14 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x09: /* FMUL */
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
+    case 0x0e: /* SDOT */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
     case 0x1d: /* SQRDMLAH */
+    case 0x1e: /* UDOT */
     case 0x1f: /* SQRDMLSH */
         unallocated_encoding(s);
         return;
@@ -12180,12 +12188,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     switch (16 * u + opcode) {
-    case 0x0e: /* SDOT */
-    case 0x1e: /* UDOT */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                         u ? gen_helper_gvec_udot_idx_b
-                         : gen_helper_gvec_sdot_idx_b);
-        return;
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
         case 0: /* SUDOT */
-- 
2.34.1


