Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0097CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwk-0006Cg-BF; Thu, 19 Sep 2024 09:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00056d-Rm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwK-00012L-Mm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so6504085e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751478; x=1727356278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GQ8ITgrrInqmC6fIynxS3+7ZpXl54Hyy3K8cBEEh+Kk=;
 b=Sf1z9/eoNelu7GzUj3I94F1BKMdn7q2IaVpe/oOnRcgLdfwbBrQboGopNIYh6oveR+
 wa2f9AOOocOjE1E9xMy8bfqSrYgk3rtYYthcoaPgWDSrM8PRxm2RXm2/Gqo6v6Wiy+7R
 E8U7KHaizhyByhhGclntbceTErMtNSPfUzoihJpO1We/1ll9M0fCAHLNa1Gp2vgnJbzA
 8Bxk+70iAv+1sOdXCZtPBvLQzhyi7zF9CnZpQxssM8gT4AYkzTwGJc/SBC+JCB/362mf
 Nt+pkIpPYPp79ItD94vFcCHu5+Y+92qcbPwBO17dRIBxUIjkYNKPui82IG3rOdiCgv5P
 u9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751478; x=1727356278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQ8ITgrrInqmC6fIynxS3+7ZpXl54Hyy3K8cBEEh+Kk=;
 b=YtryM0t10FlVcW7d1+N7u5HZCd3rJYdOMn8j5/FBdF2qGYVX7PvXCaQ0WlwYG023rW
 yu8Ea3O+MQSYdKR4JcSE37cKvj9vR2BdxrPZW0vvO+yp63VCpLGNj7NFanJWVTdt/dyZ
 jRQ9XbsIwUiUkyyXTJ/kMkfgQNeoFtxCTnNTWbHnFnCaD70bVWdACnxUPB3G1KVmGXlB
 FCrME7SrI4zMGhdiefJGNVrYosCEpsym7duTVEJcgG5dMK9sH9Cd81WWYkVKZLXtTRit
 DUN5FRltn6DSrOvKX58nX4H11uadNt1PeZaiOwV65ukBgR0os2qKaJP+qPP8eev10jjJ
 PJLQ==
X-Gm-Message-State: AOJu0Yxb4Oc+R9Js5oJOVcsdCZ5GBCBWx3U3KovBzmFVLEFDVrPJixiJ
 icNU5nuVrCI90cCi4gZxrY0eeF4iPdcYQPPf8fgtv9jgIFuukOP8yPUyoZHQaS3BNHZDYjUtK7H
 P
X-Google-Smtp-Source: AGHT+IEDWdLNww9CemEZQTfxr9odX7d2mbEKo+e/A9Ff49OvzOKbyqWH51u4g6w4f6TPebybei9bKA==
X-Received: by 2002:a05:600c:1e1a:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42cdb567190mr204726725e9.23.1726751477752; 
 Thu, 19 Sep 2024 06:11:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] target/arm: Convert handle_vec_simd_shli to decodetree
Date: Thu, 19 Sep 2024 14:10:45 +0100
Message-Id: <20240919131106.3362543-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
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

This includes SHL and SLI.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 15 +++++++++++++++
 target/arm/tcg/translate-a64.c | 33 +++------------------------------
 2 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 74ba1fa07c9..77b860a3f2c 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5c76cdf1013..1225aac6654 100644
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
-- 
2.34.1


