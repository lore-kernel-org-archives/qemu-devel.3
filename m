Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E346C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeI7-00081j-AR; Fri, 24 May 2024 19:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHj-0007Jd-UC
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHY-0006g0-3Z
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so2616720b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593101; x=1717197901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DNXHK5xqHy7EXmKEeWHyhfM7wr361NDLjffbThLrQE=;
 b=Nn/qN8AFMuiqv0jOct0ln2BCI6RV2vISDczcfTCmRPUhPXG8I4ZOo2cyte6JI9ndZP
 Jmllxm8e+7uWHgDFPseowIXXmSsTJnVqpkDy0rbBUyZwpU1bbwQIsMwvga24/ZRVINsG
 H4ZUkKBKqceIbK/9md/PtvhMyJYFbGpIhp4TX197rilRPwxkRKMGqUy3ZbD9Mp8iCAId
 DWwBLLUhJQRt3HkuW4aJJucvvvC5xZGgjTQD0j3YBKI3gS99/Tj8LRKDNGIqupLSLxFZ
 OF9Umdp/pXJR+LNiAy+nmyS1foXLZuvrIU78kqjO6lgPq2eCMkau2gwnqRRkBo+OA11v
 vZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593101; x=1717197901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DNXHK5xqHy7EXmKEeWHyhfM7wr361NDLjffbThLrQE=;
 b=FDY7a+9C4kqOX5DWHffJZqFgMhl3qtSV9HrPTkUN7UsowOn7ZgA5EaDNXPmFj30l3T
 eQRiZbH1VP56Ltxe9d7NHvzVARXdjCdZg9OXRY59TCuLvIEADfvVXoJPxc8ysBiz84IH
 6+7orHVZt8n2m4170VO/xsAQbCnJMFryO5GnIVkCCLY3tCIkPYu/3VW+tmsbSk2iFeqy
 9LZ+lSq3pi6M9rzB7lmJ5ToJ7yaGpD2D+k31Reloys+Y+HjtiS5N5L0kaTK8dBPiWksa
 QnAKILeVFttUKd+MueOqcwQNZEhT2vIzPv5qCKxSLWNupsCDSlf94/i0mEPy3HYKorqC
 5LLg==
X-Gm-Message-State: AOJu0YwiYsZhdd+MPR0GHoUz2cUUgda0qFZ5d9PNqawmEV4MT5nYpSj8
 Xo8D6oV7gayU1FiBBIfE5dHLZvTQVQ7b9zdisJPTH7TRdNgb/96puFLJENAJ/kiCJx2JJPql9kG
 e
X-Google-Smtp-Source: AGHT+IF7Ea+l3S5Z94+W2hzYuZ46cZwpdU0sk+fAdA1oeBPkne92CjK9MCJvglufOjOdWvQeqB09AA==
X-Received: by 2002:a05:6a00:7c8:b0:6f4:74b8:3d57 with SMTP id
 d2e1a72fcca58-6f7726eb231mr6708525b3a.7.1716593100890; 
 Fri, 24 May 2024 16:25:00 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 42/67] target/arm: Convert SUQADD, USQADD to decodetree
Date: Fri, 24 May 2024 16:20:56 -0700
Message-Id: <20240524232121.284515-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

These are faux 2-operand instructions, reading from rd.
Sort them next to the other three-operand same insns for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 +++++
 target/arm/tcg/translate-a64.c | 64 ++++------------------------------
 2 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 19010af03b..7c350ba833 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -45,6 +45,7 @@
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 @rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
+@r2r_e          ........ esz:2 . ..... ...... rm:5 rd:5 &rrr_e rn=%rd
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -60,6 +61,7 @@
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
+@qr2r_e         . q:1 ...... esz:2 . ..... ...... rm:5 rd:5 &qrrr_e rn=%rd
 
 @qrrx_h         . q:1 .. .... .. .. rm:4 .... . . rn:5 rd:5 \
                 &qrrx_e esz=1 idx=%hlm
@@ -750,6 +752,9 @@ UQADD_s         0111 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
 SQSUB_s         0101 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 
+SUQADD_s        0101 1110 ..1 00000 00111 0 ..... ..... @r2r_e
+USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -868,6 +873,9 @@ UQADD_v         0.10 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
 SQSUB_v         0.00 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 
+SUQADD_v        0.00 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
+USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2f7298811d..fbcf18f92a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5096,6 +5096,8 @@ TRANS(SQADD_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqadd_bhs, gen_sqadd_d)
 TRANS(SQSUB_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqsub_bhs, gen_sqsub_d)
 TRANS(UQADD_s, do_satacc_s, a, 0, 0, gen_uqadd_bhs, gen_uqadd_d)
 TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
+TRANS(SUQADD_s, do_satacc_s, a, MO_SIGN, 0, gen_suqadd_bhs, gen_suqadd_d)
+TRANS(USQADD_s, do_satacc_s, a, 0, MO_SIGN, gen_usqadd_bhs, gen_usqadd_d)
 
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
@@ -5339,6 +5341,8 @@ TRANS(SQADD_v, do_gvec_fn3, a, gen_gvec_sqadd_qc)
 TRANS(UQADD_v, do_gvec_fn3, a, gen_gvec_uqadd_qc)
 TRANS(SQSUB_v, do_gvec_fn3, a, gen_gvec_sqsub_qc)
 TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
+TRANS(SUQADD_v, do_gvec_fn3, a, gen_gvec_suqadd_qc)
+TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -10009,48 +10013,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
     clear_vec_high(s, is_q, rd);
 }
 
-/* Remaining saturating accumulating ops */
-static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
-                                bool is_q, unsigned size, int rn, int rd)
-{
-    TCGv_i64 res, qc, a, b;
-
-    if (!is_scalar) {
-        gen_gvec_fn3(s, is_q, rd, rd, rn,
-                     is_u ? gen_gvec_usqadd_qc : gen_gvec_suqadd_qc, size);
-        return;
-    }
-
-    res = tcg_temp_new_i64();
-    qc = tcg_temp_new_i64();
-    a = tcg_temp_new_i64();
-    b = tcg_temp_new_i64();
-
-    /* Read and extend scalar inputs to 64-bits. */
-    read_vec_element(s, a, rd, 0, size | (is_u ? 0 : MO_SIGN));
-    read_vec_element(s, b, rn, 0, size | (is_u ? MO_SIGN : 0));
-    tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-
-    if (size == MO_64) {
-        if (is_u) {
-            gen_usqadd_d(res, qc, a, b);
-        } else {
-            gen_suqadd_d(res, qc, a, b);
-        }
-    } else {
-        if (is_u) {
-            gen_usqadd_bhs(res, qc, a, b, size);
-        } else {
-            gen_suqadd_bhs(res, qc, a, b, size);
-            /* Truncate signed 64-bit result for writeback. */
-            tcg_gen_ext_i64(res, res, size);
-        }
-    }
-
-    write_fp_dreg(s, rd, res);
-    tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-}
-
 /* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
@@ -10070,12 +10032,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x3: /* USQADD / SUQADD*/
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_satacc(s, true, u, false, size, rn, rd);
-        return;
     case 0x7: /* SQABS / SQNEG */
         break;
     case 0xa: /* CMLT */
@@ -10175,6 +10131,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x3: /* USQADD / SUQADD */
         unallocated_encoding(s);
         return;
     }
@@ -11666,16 +11623,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             return;
         }
         break;
-    case 0x3: /* SUQADD, USQADD */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_satacc(s, false, u, is_q, size, rn, rd);
-        return;
     case 0x7: /* SQABS, SQNEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
@@ -11850,6 +11797,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x3: /* SUQADD, USQADD */
         unallocated_encoding(s);
         return;
     }
-- 
2.34.1


