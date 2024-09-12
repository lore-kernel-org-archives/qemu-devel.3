Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F5EE6423
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmp-00075k-TN; Wed, 11 Sep 2024 22:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm9-0003gi-2X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm7-0004FV-EF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20543fdb7acso4005225ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108898; x=1726713698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kgeom0orQyCoH8W6cLgDwpuRJ/jfJeEw1kOvWE0iihw=;
 b=VQtZFxpWO9opRNB1G3S24IdqqTINqfeveEeQ7SX8kb9vKDiu3qKBF2pEJXOHVWoGz6
 APaQpD2TUAIOenrcaGNMg+RiMlut8Uw2J3o+0VZNB9ptiyZupGYb9Mwl5PWHPbxuMU7E
 6+j4elNmxquLis9UJdFdb3uZeBxzTInsfK5ggw3c7EYlcAbSiP93ZTx94aodkoRzvTI+
 Geol5KlNXOgHNvsfKHWQgSj7pj0Lo1iPSpjTd0KG6NjgfjLWXOjtV8lnrgoVAc/QdY2+
 MZZnFlsdNn7gwI6Y0+w/jxXxQuo0bkMy51wcPcz3Xqq4LsCNJ3Xo3YolvoDVxRvBEf/8
 lwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108898; x=1726713698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kgeom0orQyCoH8W6cLgDwpuRJ/jfJeEw1kOvWE0iihw=;
 b=DB/SgOinEJqoK89Aqu4vS9pKJ8xBVYRKRmj4IyHwemKZJzX+H102aO8ETAnLBmOZ+H
 xOdvTxazZFB4n+SdcDKPNBCz9tDOUXxjsoDzdO3sSTF4P4eRyNOe1MK92mmsjw6LYiDt
 wrL6uMspboKnir+Cib4JNSRgoM8oZnFCQnzdVKF0hoPrTwqxpzNhwZsiMjpkFQRWaXbm
 wn4LzTfdpi4C40o73abhnkNAamhf6rjXxr8Y2ABdH+/ROMDaHv+9+92uJ3jCLniQX1rw
 F4LaPB/fl22mf6KoCq6e5jAMaXRfTAyVK30kj1NswwZ61aGv8U3PwZqhIKtZS8JnrLAH
 9iJA==
X-Gm-Message-State: AOJu0Yz+KWGwmwU+IGrApAXoyiXO5E2+hcDW9QVZFcZOfpxYDzDKf7Ly
 8+45q5R+SpOzjDDBXnh7BrvEmBQOPDnONNvVDPhCr1jHvSygfGJMuHDDM+7KFki8CEWShWRRAZp
 Z
X-Google-Smtp-Source: AGHT+IEgIQUB9SlaWeDya2oI07UQHB7jNQQMVwdvNVX/8VNf9n+6CUfGLG+kKVwNvmL4ls0E5JKVhw==
X-Received: by 2002:a17:903:41cb:b0:206:ae39:9f4 with SMTP id
 d9443c01a7336-2076e35ebfamr15947455ad.20.1726108897922; 
 Wed, 11 Sep 2024 19:41:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 24/29] target/arm: Convert handle_scalar_simd_shli to
 decodetree
Date: Wed, 11 Sep 2024 19:41:09 -0700
Message-ID: <20240912024114.1097832-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This includes SHL and SLI.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 44 +++++++---------------------------
 target/arm/tcg/a64.decode      |  4 ++++
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index efd93a7f23..934746d2f2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7124,6 +7124,11 @@ static void gen_sri_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static void gen_sli_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    tcg_gen_deposit_i64(dst, dst, src, shift, 64 - shift);
+}
+
 static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
                                     WideShiftImmFn * const fns[3], MemOp sign)
 {
@@ -7201,6 +7206,9 @@ TRANS(SRSRA_s, do_scalar_shift_imm, a, gen_srsra_d, true, 0)
 TRANS(URSRA_s, do_scalar_shift_imm, a, gen_ursra_d, true, 0)
 TRANS(SRI_s, do_scalar_shift_imm, a, gen_sri_d, true, 0)
 
+TRANS(SHL_s, do_scalar_shift_imm, a, tcg_gen_shli_i64, false, 0)
+TRANS(SLI_s, do_scalar_shift_imm, a, gen_sli_d, true, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9417,38 +9425,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
-/* SHL/SLI - Scalar shift left */
-static void handle_scalar_simd_shli(DisasContext *s, bool insert,
-                                    int immh, int immb, int opcode,
-                                    int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-    TCGv_i64 tcg_rn;
-    TCGv_i64 tcg_rd;
-
-    if (!extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rn = read_fp_dreg(s, rn);
-    tcg_rd = insert ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
-
-    if (insert) {
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, shift, 64 - shift);
-    } else {
-        tcg_gen_shli_i64(tcg_rd, tcg_rn, shift);
-    }
-
-    write_fp_dreg(s, rd, tcg_rd);
-}
-
 /* SQSHRN/SQSHRUN - Saturating (signed/unsigned) shift right with
  * (signed/unsigned) narrowing */
 static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
@@ -9900,9 +9876,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SHL / SLI */
-        handle_scalar_simd_shli(s, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF, UCVTF */
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -9940,6 +9913,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x04: /* SRSHR / URSHR */
     case 0x06: /* SRSRA / URSRA */
     case 0x08: /* SRI */
+    case 0x0a: /* SHL / SLI */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6c2362b3bb..96803fe6e4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1291,6 +1291,7 @@ RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
 
 @shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
                 &rri_e esz=3 imm=%neon_rshift_i6
+@shli_d         .... ..... 1 imm:6  ..... . rn:5 rd:5   &rri_e esz=3 
 
 SSHR_s          0101 11110 .... ... 00000 1 ..... .....     @shri_d
 USHR_s          0111 11110 .... ... 00000 1 ..... .....     @shri_d
@@ -1301,3 +1302,6 @@ URSHR_s         0111 11110 .... ... 00100 1 ..... .....     @shri_d
 SRSRA_s         0101 11110 .... ... 00110 1 ..... .....     @shri_d
 URSRA_s         0111 11110 .... ... 00110 1 ..... .....     @shri_d
 SRI_s           0111 11110 .... ... 01000 1 ..... .....     @shri_d
+
+SHL_s           0101 11110 .... ... 01010 1 ..... .....     @shli_d
+SLI_s           0111 11110 .... ... 01010 1 ..... .....     @shli_d
-- 
2.43.0


