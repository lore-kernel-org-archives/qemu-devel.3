Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63DBCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoH-0006qP-FY; Thu, 04 Jun 2026 19:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoD-0006lE-Ax
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoA-0007vn-M9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf77d4a4e2so13994105ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616945; x=1781221745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbbg58X/kK8O9e+ZYcVUv/9JtyhK4N5Lsaw183Rioac=;
 b=zVWu4ZCanTu/DBN7mCqayn8WbkflFzUye3hQocNOFfZyX2FqcwDpYpabpjPsfQq+N+
 qMi0Wjq3FJf6WniBKF14SV+ptukUVUTapglgOk2y8C0gqiQsfE7atYjgIaaAijUPQDz7
 LOk92bg1teJJ+RoXU8hxW4b9s/nkR97TPvirPGAOUTspKH7UZsKu9O51keAulpuzDSbe
 QCWvGZB5jt7qc1f2kD41Jc/JJnQZB5ym0oigYYYC41jmjSJrWCnVonAvrlAjghpKNgXq
 tMjJNMgL5PJSDSBAvy9WwcMKMIou72h9OhiBoogOwkPrDPKopN68JfXkR5RWZUbzqCR9
 FeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616945; x=1781221745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hbbg58X/kK8O9e+ZYcVUv/9JtyhK4N5Lsaw183Rioac=;
 b=FlBTlD/m0cpqG1piOjKE4+lsCVSckBhk9o44ve5UXjwoR42zTpjVqEzn2MuuOgUeE4
 dzBZuJV7uTTgk3WXWy60Wa3z3nXc2uunk1sjC+CI8uKw6E4JfTmCJ12IjefyuIsNyjai
 lSkjuTa2mFywzXSDFgkGbbjyl0zdHZWSVbRuD6GPNpsLMNI4qCRCGmuRF88Gaf7UUg7A
 djoKEHC2okPPB0bHICqFGeufSpK4oKG2T5PQbKlZkVW30MA3Zo7zcjuPqBW1bZzZWoFX
 07T4LGZMwIDZzglR9i7HP3k7/P/Y+FR536yZEs/oUPyypzwC4UtceZflkRereaSU3XIU
 vucQ==
X-Gm-Message-State: AOJu0YzEgHuznQOUQnI86oxkeIBaEzH0z4iyS/j4ahBWTwXzZnxOb3lU
 H4u+/DF7iEyIO3FP4SgxL6QUy+q3sUsytqTtw7PklDv0jGtNt+BK5SU/+658sPxWvHZFy8C4pr0
 Zec1jimA=
X-Gm-Gg: Acq92OE3zoe/bdUhGDfPR9E6QnvvdjB5FW8vHFZutPsx24qkARJBiycpYJNukXLFwb7
 HQreOwICi92boSszCEYSNqzIyNnsoXcJYC4cAYhZQnjSeNALEEigTJlNDApL35O0TxO0Umm2hXd
 E1p/xyBTBeKWD0S+pvsAt5asjyMmxQ8m+v+L/KzMRE00Dmyt5gwCZlfkXRVbiqX1o/es8Ys1v1k
 jmL4tvzIJCYLn8dJcYqLg115nnQ77pADTOwp1hDEa/uUCOzwDangwCSOsTw4sOjUtE55gHbovXH
 /sROqdONNASYV+AYKbRJ8r9fYGjNiZN0cH/6wRlIez+GXmX+tDDM7jG8hWJ9VFs7GQRb9FQW174
 ux6dv+qLNJ1MjYoc1C+VePWvkeiYoEWstqQSpO9h3UkXj+8/+FIZiECxvjgrbY7tB4gtGALzNHa
 I0XEbV9D1otZ1CEEi8BxouRxORKTmBH198dGQdYk8=
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2c1ec80a4eamr1322845ad.10.1780616945238; 
 Thu, 04 Jun 2026 16:49:05 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/25] target/arm: Implement FRINT{32,64}{X,Z}
Date: Thu,  4 Jun 2026 16:48:42 -0700
Message-ID: <20260604234852.573178-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/helper-sve-defs.h |  9 ++++++++
 target/arm/tcg/sve_helper.c      |  5 +++++
 target/arm/tcg/translate-sve.c   | 36 ++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode        | 20 ++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index f97c31763f..de2254bb19 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -1441,6 +1441,15 @@ DEF_HELPER_FLAGS_5(sve_frintx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_frintx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(sve2p2_frint32_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint64_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint32_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint64_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_frecpx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frecpx_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 847c49d784..fa4bf02278 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5017,6 +5017,11 @@ DO_ZPZ_FP(sve_frintx_h, uint16_t, H1_2, float16_round_to_int)
 DO_ZPZ_FP(sve_frintx_s, uint32_t, H1_4, float32_round_to_int)
 DO_ZPZ_FP(sve_frintx_d, uint64_t, H1_8, float64_round_to_int)
 
+DO_ZPZ_FP(sve2p2_frint32_s, uint32_t, H1_4, helper_frint32_s)
+DO_ZPZ_FP(sve2p2_frint64_s, uint32_t, H1_4, helper_frint64_s)
+DO_ZPZ_FP(sve2p2_frint32_d, uint64_t, H1_8, helper_frint32_d)
+DO_ZPZ_FP(sve2p2_frint64_d, uint64_t, H1_8, helper_frint64_d)
+
 DO_ZPZ_FP(sve_frecpx_h, uint16_t, H1_2, helper_frecpx_f16)
 DO_ZPZ_FP(sve_frecpx_s, uint32_t, H1_4, helper_frecpx_f32)
 DO_ZPZ_FP(sve_frecpx_d, uint64_t, H1_8, helper_frecpx_f64)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 936396103f..842ef96221 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4730,6 +4730,42 @@ TRANS_FEAT(FRINTZ_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
 TRANS_FEAT(FRINTA_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
            FPROUNDING_TIEAWAY, 1, frint_fns[a->esz])
 
+TRANS_FEAT(FRINT32X_s_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_s, a, 0, FPST_A64)
+TRANS_FEAT(FRINT32X_d_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_d, a, 0, FPST_A64)
+TRANS_FEAT(FRINT64X_s_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_s, a, 0, FPST_A64)
+TRANS_FEAT(FRINT64X_d_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_d, a, 0, FPST_A64)
+
+TRANS_FEAT(FRINT32X_s_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_s, a, 1, FPST_A64)
+TRANS_FEAT(FRINT32X_d_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_d, a, 1, FPST_A64)
+TRANS_FEAT(FRINT64X_s_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_s, a, 1, FPST_A64)
+TRANS_FEAT(FRINT64X_d_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_d, a, 1, FPST_A64)
+
+TRANS_FEAT(FRINT32Z_s_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint32_s)
+TRANS_FEAT(FRINT32Z_d_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint32_d)
+TRANS_FEAT(FRINT64Z_s_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint64_s)
+TRANS_FEAT(FRINT64Z_d_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint64_d)
+
+TRANS_FEAT(FRINT32Z_s_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint32_s)
+TRANS_FEAT(FRINT32Z_d_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint32_d)
+TRANS_FEAT(FRINT64Z_s_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint64_s)
+TRANS_FEAT(FRINT64Z_d_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint64_d)
+
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7460eee4a9..5c814c7769 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1259,6 +1259,26 @@ FRINTA_z        01100100 .. 011 001 100 ... ..... .....         @rd_pg_rn
 FRINTX_z        01100100 .. 011 001 110 ... ..... .....         @rd_pg_rn
 FRINTI_z        01100100 .. 011 001 111 ... ..... .....         @rd_pg_rn
 
+FRINT32X_s_m    01100101 00 010 001 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32X_d_m    01100101 00 010 011 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_s_m    01100101 00 010 101 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_d_m    01100101 00 010 111 101 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32X_s_z    01100100 00 011 100 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32X_d_z    01100100 00 011 100 111 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_s_z    01100100 00 011 101 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_d_z    01100100 00 011 101 111 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32Z_s_m    01100101 00 010 000 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32Z_d_m    01100101 00 010 010 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_s_m    01100101 00 010 100 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_d_m    01100101 00 010 110 101 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32Z_s_z    01100100 00 011 100 100 ... ..... .....         @rd_pg_rn_e0
+FRINT32Z_d_z    01100100 00 011 100 110 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_s_z    01100100 00 011 101 100 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_d_z    01100100 00 011 101 110 ... ..... .....         @rd_pg_rn_e0
+
 # SVE floating-point unary operations
 FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
 FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
-- 
2.43.0


