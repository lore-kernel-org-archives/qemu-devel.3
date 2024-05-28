Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9466C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3TX-0002xW-WD; Tue, 28 May 2024 16:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TP-0002pq-6r
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TF-0003at-F5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8e9870e72so1038045b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928254; x=1717533054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/FjU0M55RLw+Hkc72eRplzn49I5GGZq6i4SnMj19Wc=;
 b=Wz9Fk4tdDaJRAkBIrL0kXzZvSlVQwtl4KihuzsA19lNf/Un1NL6eMzwwi6z/xFvg7V
 Aqsn6ooJ5BIwECS+fNeUyLnKHnFnSeS3frBv2P1jSaQ60RHZBazl0VqImwYAP8WdeZdu
 UUNRFynA6GwTlI4yBC5U/rMZ433l6dHyyxhtDlndMD8VGHDntoMx4PmMH9JFJkHszjpb
 cVnIXvPIYcnqcx01r+AYq+YEf3b41miy1kSe+efaUksBCVfSbKffn24fWHCOft9sDD9q
 hRX2mSqR4i4X1490aUmyWMt/aF40CLr/zmI7HqmsP/idATeESSu88LmFqBOYmu+DQV6T
 MXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928254; x=1717533054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/FjU0M55RLw+Hkc72eRplzn49I5GGZq6i4SnMj19Wc=;
 b=nzE4Yjwb7HbORTrwXy0v6Aa/K7dLHYMKbkWIViZWHFNVz7BUeqqyY5XJqw4EtnW+te
 ez7wdhV88obcdTyIDnTqPt2zkk8ko6gK5W0zf3fXn35WJhykic4YoojjeXL+c9m3KbcZ
 iLhgPjppwnP/zt5UuHTkY2PF4aoR/1+KaZ8CQ1WoapONQGAb69Q0tVIw8S0H3US5GSu/
 b+d+n3BM3NZ3q59n7CkwoBG5T6+jt7cpdgYlVM+2bgnTMs0PN3l+v16GSvyj9iJ1uIXq
 kldbV7IllngnRXSWhGj1aEMvbBlEba+Q/6P4lbMo4M7oiiR1Un9bDG+KxDAhe7hKuH4k
 FtzQ==
X-Gm-Message-State: AOJu0YyZ+oeL5ECQUAL3zuH9tpyPJHVS7/P/P3rQWz9VF7jniKAJijgk
 Kh6L3fvxXUUZb7vKtXjAU/dsDnA/FlUsUPL7rVvPP2gJrVb8MMf+mTvb72KYP+5piwjwbIWwmEh
 R
X-Google-Smtp-Source: AGHT+IEbI+OsXUvsmaoeALgc9/jqo3N4OjBmbnSwGVUkh2zbmNu0re3BV1msmG/4dIjsvpd/4abETg==
X-Received: by 2002:a05:6a00:4206:b0:6f3:ea4b:d235 with SMTP id
 d2e1a72fcca58-6f8f1a68c6emr16353851b3a.0.1716928253818; 
 Tue, 28 May 2024 13:30:53 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 09/33] target/arm: Convert SSHL, USHL to decodetree
Date: Tue, 28 May 2024 13:30:20 -0700
Message-Id: <20240528203044.612851-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/a64.decode      |  7 ++++++
 target/arm/tcg/translate-a64.c | 40 +++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7c350ba833..ea897d6732 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -42,6 +42,7 @@
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
+@rrr_d          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=3
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 @rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
@@ -755,6 +756,9 @@ UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 SUQADD_s        0101 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 
+SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
+USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -876,6 +880,9 @@ UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 SUQADD_v        0.00 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 
+SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0637bda0f..7c7a22985b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5099,6 +5099,24 @@ TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
 TRANS(SUQADD_s, do_satacc_s, a, MO_SIGN, 0, gen_suqadd_bhs, gen_suqadd_d)
 TRANS(USQADD_s, do_satacc_s, a, 0, MO_SIGN, gen_usqadd_bhs, gen_usqadd_d)
 
+static bool do_int3_scalar_d(DisasContext *s, arg_rrr_e *a,
+                             void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        read_vec_element(s, t0, a->rn, 0, MO_64);
+        read_vec_element(s, t1, a->rm, 0, MO_64);
+        fn(t0, t0, t1);
+        write_fp_dreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
+TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5344,6 +5362,10 @@ TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
 TRANS(SUQADD_v, do_gvec_fn3, a, gen_gvec_suqadd_qc)
 TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
+TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
+TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
+
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9355,13 +9377,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x8: /* SSHL, USHL */
-        if (u) {
-            gen_ushl_i64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            gen_sshl_i64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     case 0x9: /* SQSHL, UQSHL */
         if (u) {
             gen_helper_neon_qshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9393,6 +9408,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     default:
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
+    case 0x8: /* SSHL, USHL */
         g_assert_not_reached();
     }
 }
@@ -9417,7 +9433,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
-    case 0x8: /* SSHL, USHL */
     case 0xa: /* SRSHL, URSHL */
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
@@ -9437,6 +9452,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     default:
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
+    case 0x8: /* SSHL, USHL */
         unallocated_encoding(s);
         return;
     }
@@ -10912,6 +10928,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
+    case 0x08: /* SSHL, USHL */
         unallocated_encoding(s);
         return;
     }
@@ -10921,13 +10938,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SSHL, USHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


