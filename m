Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B82ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAM-00036P-OV; Mon, 09 Sep 2024 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAK-0002ye-SH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAJ-0007l7-1L
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso3222689a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898977; x=1726503777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJbXt7pOg4FXFelFynZLe3iemHyaou99mZ5a4Xb7T/U=;
 b=tS0QaKK5+lszJM0SozRYaNn/TI+ntkKDboPqXCUh573PEzBuPHIBbITNFIW0/uHFZy
 Vtywh2PJoxjTPijjvmwB60uq6FfOBqEC2Pl5H20i522JXLOzosrZXR/IRTX8nQnPFiNY
 /88UJ0bYAyKz9EjbdgFIRP0vSPADjAYU1dhUWxE2v5bNdsYaiyVATT7XQt6fc3MC49rd
 KxdGLEBH1oIqt2Sf0SUIzw6cam5imCLa8MFuXbrUDYSm7ofdX4NovOmC3IN3HUb1zXwR
 8kTPXAv/Xr6UCMcrhsvvElbHXULdU1ma+s3eDbeOU47OU0C9nSblVlo9+h9Ry0iZdAw3
 rBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898977; x=1726503777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJbXt7pOg4FXFelFynZLe3iemHyaou99mZ5a4Xb7T/U=;
 b=K5oC5VVyHgw5P9E6hZTDPpWszYu1B1tdo/WD9JXU/6Qs1tjb4Lob15WckpmuGOa6xY
 w62wNXMeedTKNHZBSXLWO7KaMjs+mKrHZKIkxUqKSci00c9UEaSYWrLc1wY0NNb90rCJ
 IYbzcNUJhGoskU1YECJmHI2OxIEt/760jYaij7edZC5y/aPjrfeNTg7U6Kib7YiBUBhK
 eWzgpkGC55N5hnBFDRnTIJd4UE8HweVcebL7j4b2M/7G+YQki3dOL7kphiidWKM51608
 lXJ8DuJVkWStuwTaQix3b4/l+8vjgG5+cVr4B7HJ8xSxY8pBrtM+V7hE1hAhh7nMJKp7
 Xddw==
X-Gm-Message-State: AOJu0Yzl1kpxxGIP05dn/tcI1eWqdYooLRC14HU7dgwJqssncU1taQVG
 GtvqiRXAyp+HyFRV+eNfUKx5JWF8mKbHJlzG1Wisc/sponzyyt3BwL5Gdx02q0Ec/RicE6wB06Q
 m
X-Google-Smtp-Source: AGHT+IFAsidh+fHjwPARNH+NMCcjlz+/5rsL8HUlLOfMjyxwocph97/5FULg0DOkZdOXaqituud8MA==
X-Received: by 2002:a17:902:d50a:b0:205:861c:5c3e with SMTP id
 d9443c01a7336-206f054d85amr195034605ad.30.1725898977637; 
 Mon, 09 Sep 2024 09:22:57 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 17/29] target/arm: Convert handle_vec_simd_shli to
 decodetree
Date: Mon,  9 Sep 2024 09:22:27 -0700
Message-ID: <20240909162240.647173-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

This includes SHL and SLI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 33 +++------------------------------
 target/arm/tcg/a64.decode      | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5c76cdf101..1225aac665 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6980,6 +6980,8 @@ TRANS(URSHR_v, do_vec_shift_imm, a, gen_gvec_urshr)
 TRANS(SRSRA_v, do_vec_shift_imm, a, gen_gvec_srsra)
 TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
 TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
+TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
+TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -10445,33 +10447,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SHL/SLI - Vector shift left */
-static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-
-    /* Range of size is limited by decode: immh is a non-zero 4 bit field */
-    assert(size >= 0 && size <= 3);
-
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (insert) {
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sli, size);
-    } else {
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
-    }
-}
-
 /* USHLL/SHLL - Vector shift left with widening */
 static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10585,9 +10560,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SHL / SLI */
-        handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x10: /* SHRN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
@@ -10628,6 +10600,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x04: /* SRSHR / URSHR (rounding) */
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
+    case 0x0a: /* SHL / SLI */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 74ba1fa07c..77b860a3f2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1205,6 +1205,11 @@ FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 @q_shri_d       . 1 .. ..... 1 ...... ..... . rn:5 rd:5     \
                 &qrri_e esz=3 imm=%neon_rshift_i6 q=1
 
+@q_shli_b       . q:1 .. ..... 0001 imm:3 ..... . rn:5 rd:5 &qrri_e esz=0
+@q_shli_h       . q:1 .. ..... 001  imm:4 ..... . rn:5 rd:5 &qrri_e esz=1
+@q_shli_s       . q:1 .. ..... 01   imm:5 ..... . rn:5 rd:5 &qrri_e esz=2
+@q_shli_d       . 1   .. ..... 1    imm:6 ..... . rn:5 rd:5 &qrri_e esz=3 q=1
+
 FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
 # MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
@@ -1254,3 +1259,13 @@ SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_b
 SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_h
 SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_s
 SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_d
+
+SHL_v           0.00 11110 .... ... 01010 1 ..... .....     @q_shli_b
+SHL_v           0.00 11110 .... ... 01010 1 ..... .....     @q_shli_h
+SHL_v           0.00 11110 .... ... 01010 1 ..... .....     @q_shli_s
+SHL_v           0.00 11110 .... ... 01010 1 ..... .....     @q_shli_d
+
+SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_b
+SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_h
+SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_s
+SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_d
-- 
2.43.0


