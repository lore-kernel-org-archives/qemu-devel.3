Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B640C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zz-0004Wd-4S; Fri, 31 May 2024 08:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zd-0004Lg-IU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zX-0003Qb-88
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:20 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ad8230bb9so2110123e87.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157053; x=1717761853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YKz2IZB+9v2Ext0CF0IVyAcLOjvZTKCG+3bOnl9sD2o=;
 b=Ly1U1Nq7EC5uOwfvW9CN4Aef5KdMpR0hNlMVh2krSqz6C4rSe+BfDY1iphPxQTx50D
 BXuSVEcDIY31zfxcc8TsQBLSEvcP3N9LsZeqAoj7wOBHzG7s8R+oqiFWvWbENFBDXbr1
 BnZRJlaOk8qERADDcT0PXIw9eIpViCI9xk1+0+lcLBpHOy9XqrHrM2HzfADa9foTlIK4
 +kmTDXfEuw02MS9rXdAA0Fu4bj6TRUaBFPkmD/47Mn0MpN/UkfLrJjAxTzC9BrIEoyOi
 4NlBT+iIB6ep/BjdNXGssNnhBrB2vy/b/+4ApokCnpRionWya/t50gVzRLbTWIUAdgq8
 sfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157053; x=1717761853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKz2IZB+9v2Ext0CF0IVyAcLOjvZTKCG+3bOnl9sD2o=;
 b=wjowgIFYkUCPR2jSSDFRLyceAfrNv1MXkESflg3+Und2zcgNVFGl53xP9xw4DNy6wk
 nMqdocYa7yQ19ZWFn4LcE65LgFGR0Lpvx3fBb0W3KCDCv1hqwH6X/JtiiZelkTU78R/F
 nWjCtIoHi3Vni+q1QELNWNyfbFj3yVd6CRMQyYHxcE3knWW0/WMTNXwlk9z+/vv3Ju42
 bugnTVQ/pZRATSG7/rL9W6uH75K7X4jt8p09NONpNNOdrLEz5jZYRei727nXpsRePJkx
 N1AeEezb8ssQVlolNXL5EJCuIUR7GLlw7g5vDWh2kpy+9BJhyHHe4bR/YZsPDvrWftpV
 wMDw==
X-Gm-Message-State: AOJu0YyKo6PfM5niS7sY20WvKFbSYEbzrqvhkHT+dELRVXfSHrNRaq4i
 CRCYrNZfUVLFdEM7bT/QCt5H6BaJtnXa6D7U3M1Rn4wrU4iQ0n/dH7/38nRGRvIYdynIjKxK/+1
 g
X-Google-Smtp-Source: AGHT+IFflxj3ItKq4D9s6ONGp87eNclX/gztXCFWuW+9w041xJrrjPIaIunLV61nIe7PTB4d2n6ekg==
X-Received: by 2002:a19:6455:0:b0:52b:796f:8af5 with SMTP id
 2adb3069b0e04-52b8958da31mr1064101e87.34.1717157053492; 
 Fri, 31 May 2024 05:04:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] target/arm: Convert SUQADD, USQADD to decodetree
Date: Fri, 31 May 2024 13:03:31 +0100
Message-Id: <20240531120401.394550-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are faux 2-operand instructions, reading from rd.
Sort them next to the other three-operand same insns for clarity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 +++++
 target/arm/tcg/translate-a64.c | 64 ++++------------------------------
 2 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 19010af03bb..7c350ba833f 100644
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
index 3956c415431..c0637bda0fc 100644
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
@@ -11662,16 +11619,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -11846,6 +11793,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x3: /* SUQADD, USQADD */
         unallocated_encoding(s);
         return;
     }
-- 
2.34.1


