Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F53DC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZN-0001EF-Vq; Mon, 01 Jul 2024 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ6-0000fz-Ed
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ3-0005Qj-VF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-424ad289912so23112615e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850055; x=1720454855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KO+Ue5WI+Dk6bpHtouuUAVCsqXLYR79qpaKwGCAIHiM=;
 b=egDQKOVzYIYuj8BYa8rgTiXbdOX31rxbLQ7EAKbfgLZ1j2+iDt2McAnd94IQNY2QMd
 aDppJB8nLy//jrkG0TZVmPq7UaFBQeuG7abcXBHnEOnSVAlvsKLpmUxZvMVWXbWki5w6
 Cxah8obq3KA0YBKtnRD+xGWhmp9ybspmCo+gYD78PmDYTi249SC1dR/ONwO3PB91H9DG
 zHSgMv011QcsFJbZZR1xBCR53nvqZ5nukbxTukPBS+DqvNQURWkHWDPUUJwz8x3WPLl4
 wUdN7u9Tt0fyICUQU8hmnyC6hgo522dL4YVbP0sKJa+GUrrGtyEmfDTp9mWMnJ5tQ3Co
 Krzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850055; x=1720454855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KO+Ue5WI+Dk6bpHtouuUAVCsqXLYR79qpaKwGCAIHiM=;
 b=wa2ie3XF6t5RFCECRTxp9mSoQncKEoP3JsMql4yqEK6TrN9PE1lLl0ysdoEc/CKhvQ
 4NZu7C0ZzC95P68g5uLEuTRb2Z9Jw0BtKoeavGv9ZPzwH4xG1ptFKwfkWDlPVdlwuHAD
 T6D3FUB0n2uG3EVmak7k9BdNmBLkDax7twmY5eYQpVOXswDjVqz7r/3iH/UncD9ED29B
 UcIVURSTCMn45UVPsJvInVsBGnfzsYHiDHz+U1ULPQWzzQDzCgzB9X0gJh8bKeMR40gE
 UQGRPn4i3bDPBFobVndCkC5VEQaAcSy9tkJzeh3dI+Eh9Dlv3OFOX98qoNte/eYy+iJu
 EUkw==
X-Gm-Message-State: AOJu0YystVVntDMGF9mi3toSwPMNVEoDhg7Fm8GI7PXa3kAnx2sqwq55
 bqrz+3Nz6dSRN6nZjFWh5oHSllhXu1+hzguJt30hu8eMNj5BD/wppjQHUyoKtEx8aGosBq5AOIb
 3vBg=
X-Google-Smtp-Source: AGHT+IEsdmPbN3MKoA15V4a22s3M3Dsn/r3jYitjgROwCc6Ydf1ZfNFlQtg/slVIAv8oh4AUqzTuDQ==
X-Received: by 2002:a05:600c:4da1:b0:424:acf6:6068 with SMTP id
 5b1f17b1804b1-4257a03479emr47823985e9.34.1719850055334; 
 Mon, 01 Jul 2024 09:07:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] target/arm: Convert SDOT, UDOT to decodetree
Date: Mon,  1 Jul 2024 17:07:11 +0100
Message-Id: <20240701160729.1910763-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 +++++
 target/arm/tcg/translate-a64.c | 54 ++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 613cc9365cf..7411d4ba979 100644
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
index 32c24c74220..f2e7d8d75c6 100644
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


