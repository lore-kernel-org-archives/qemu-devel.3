Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEBFE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YX-0002rb-Gl; Fri, 13 Dec 2024 12:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xf-0007eb-BB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xc-0001eI-DD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:31 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1082593f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111205; x=1734716005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q5D537/TkN0iatJV/r504lV14FuBKX7MulHaFGn4dqY=;
 b=DPJZcIWnDNpDp6AiFbK3FPYw3jW+HzIV2EmpBI4s3UqjQlD6jTvxC88eGfg0ErpiYY
 Idldnq8yFlezonNil+Wu6BgWsQ1NFWviIxPNor+/5+rrt2Ei9d8tJjmPTqyUxBGfeI2t
 sAW+FbozffHuBykl9otMtlXQ+zHeZHGkPK/OsVA4AyqsfN7zTo8VNTW3QR3wDAwAsmNH
 ezTu/5esqXosDoE0RQuQxGysW9MDHmnSjdGWMM+zQP4+kRAeX4FCgrFloFCtWlomj5FS
 v/fJqpmcP6GHb+7HsJv8h2Fymu3aeBFM/rhzUpb7nuTo/KRW6rCne56q9tydEDcNikl9
 mS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111205; x=1734716005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5D537/TkN0iatJV/r504lV14FuBKX7MulHaFGn4dqY=;
 b=py2+NxFFefRFRiBO85uRFfLmf9M/OfBrvGm7+T7E3Orhg9Wv8nnuYFVfZQLLoJdzDN
 fQ7R9oKZR/juoSln3N2rsdggB8uD65sHMaiLHSnKpfwa4PgZXeKEq1sNX/t9fbAwQpTP
 hoiridBOPPYSvfMqggp2uQFeGGJox5d8/tP9wFmZkOisCYQRxhnH8IY5QoQny/CEdprY
 IXy+TbzHcNLvKucipGBxrbfZQhpdWgIPGA+XJraqTvj0FpJqQk47zaUCTl3YOKs88qVj
 Nj71E6XNBYtLD+QPFzekNYgcDJCOQ+vKtzV04MdpnKqrCykIPq/Key2rVTBO6Rm4PFO5
 G2dA==
X-Gm-Message-State: AOJu0YzoxvSkT/JSifFpPo/6PRt2qMat1li/CG4Imf12uwO8emFmwaWU
 Yy34aU44MihWVDjvvhWychTCg4YPnbJ38dQLbkvV4H+GMZ5EioXal98gZKP9nFxUgByNMTbACS9
 X
X-Gm-Gg: ASbGnctPc/CORlszfzwteYr2PgU4MT4dohaFGkKkROse+rk9hpCXKq5CIzvuvDj6eoq
 Mj0bd2/lsgJarZkf0lg34++5e1UEh4DsQjuc08CEo1/DSGtm1SeYDLUB3MxAUJq1CW3S6H+6K4b
 ocrhAM0K1LgJkSsMCVNWLZaQXssIHQcJtl1ShWyGveaMVHkEAox9Lz+rAP4Xn2DbWrMAsOf6zFY
 546AThPsmi+w1E2oxKb7C47HyezkdAB/hTfXcj5HbAZnalD1D6jfMNArvV6gQ==
X-Google-Smtp-Source: AGHT+IEz2NrjCOtsvHl74p7sQclufAC+3lt/20rfuHI9VSxnscDuV0H79FkARtNo7Ya99H1hLvBiIg==
X-Received: by 2002:a05:6000:4b0b:b0:386:32ca:1672 with SMTP id
 ffacd0b85a97d-38880ac218bmr3080089f8f.4.1734111205289; 
 Fri, 13 Dec 2024 09:33:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/85] target/arm: Convert FCVTN, BFCVTN to decodetree
Date: Fri, 13 Dec 2024 17:31:54 +0000
Message-Id: <20241213173229.3308926-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-id: 20241211163036.2297116-51-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 ++
 target/arm/tcg/translate-a64.c | 89 ++++++++++++++++++----------------
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 295329448f1..456912cd7ca 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 %rd             0:5
 %esz_sd         22:1 !function=plus_2
+%esz_hs         22:1 !function=plus_1
 %esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
@@ -74,6 +75,7 @@
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
+@qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1676,3 +1678,6 @@ XTN             0.00 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTUN_v        0.10 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
+
+FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
+BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7b76945b0ac..d4d19c9caaf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9051,6 +9051,49 @@ TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
 TRANS(SQXTN_v, do_2misc_narrow_vector, a, f_scalar_sqxtn)
 TRANS(UQXTN_v, do_2misc_narrow_vector, a, f_scalar_uqxtn)
 
+static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tcg_lo = tcg_temp_new_i32();
+    TCGv_i32 tcg_hi = tcg_temp_new_i32();
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 ahp = get_ahp_flag();
+
+    tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, n);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
+    tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
+    tcg_gen_extu_i32_i64(d, tcg_lo);
+}
+
+static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_vfp_fcvtsd(tmp, n, tcg_env);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_fcvtn[] = {
+    NULL,
+    gen_fcvtn_hs,
+    gen_fcvtn_sd,
+};
+TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
+
+static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_bfcvt_pair(tmp, n, fpst);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_bfcvtn[] = {
+    NULL,
+    gen_bfcvtn_hs,
+    NULL,
+};
+TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9633,33 +9676,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
-            if (size == 2) {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_vfp_fcvtsd(tmp, tcg_op, tcg_env);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            } else {
-                TCGv_i32 tcg_lo = tcg_temp_new_i32();
-                TCGv_i32 tcg_hi = tcg_temp_new_i32();
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 ahp = get_ahp_flag();
-
-                tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
-                tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tcg_lo);
-            }
-            break;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            {
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_bfcvt_pair(tmp, tcg_op, fpst);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            }
-            break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
             {
                 /*
@@ -9675,6 +9691,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         default:
         case 0x12: /* XTN, SQXTUN */
         case 0x14: /* SQXTN, UQXTN */
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             g_assert_not_reached();
         }
 
@@ -10088,21 +10106,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* handle_2misc_narrow does a 2*size -> size operation, but these
-             * instructions encode the source size rather than dest size.
-             */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
-            return;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            if (!dc_isar_feature(aa64_bf16, s) || size != 2) {
-                unallocated_encoding(s);
-                return;
-            }
             if (!fp_access_check(s)) {
                 return;
             }
@@ -10155,6 +10158,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             break;
         default:
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             unallocated_encoding(s);
             return;
         }
-- 
2.34.1


