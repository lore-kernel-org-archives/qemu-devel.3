Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50738C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEA-0008RO-WC; Fri, 04 Jul 2025 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE9-0008PV-4J
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE6-00069e-Kk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so930539f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646325; x=1752251125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sej+V2Rr9AtmU3YQ9vXb4to4NlQ7GYAchQCQX2HueIA=;
 b=Vg0ucKm5+V64l4WtKvH6QTGGUoqANtG22rWiT90b+DnoLyxtgd/GU4BaxD3iRWvPs4
 tFzcycOJ1Zg56X5lzB9r3z4Wc0PGohZCj09O+Fw0sp2YThSd8nj1IDLS2PPDYidu3mO7
 a4D+k1/sZA/TxlEMR6ZgE4ZWtHiudDd6cugZRX9DdODFkygODZZsJBhvJ+ph/AQQJ7VL
 ga0HTMkpDTBZoFjh93yoK0OI8Sv1DDy/VsHdsthLl3EKzgS3RNrCBtHWgEDKxbH/zq+n
 NVfyIyeSBMjVgDJip+17YjUfGZADzy9ILRbuZrz5wTZebiH7lDUdYs6LpFUYqzIexTMW
 qEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646325; x=1752251125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sej+V2Rr9AtmU3YQ9vXb4to4NlQ7GYAchQCQX2HueIA=;
 b=vB9wOet4mV2OQdaOPSB+PkBVfh3J0KVNBn6u5aCpDbzVRjI/l7cQydyXDkF+bEGoJV
 KafXBPfpSSIPr/OihMOoTms62unU8v1myZ3MJmv7rpvf+rwDYizAFAFmcibPWvGGVzrQ
 gDsI0JQIKRLTK+FIuruKNLXa1P9z9N0xAVlYXa3fbRu4PmroQUvXKp7CCbowsUQtrdH4
 qOQ1QF6caPazP6kPaPL47+PsdCu8LhZJFIBAUPH4yZ9WtSXY0DnmJUJCwI75pDa7Stjh
 mptROHYAhKUDiT+P6ESI99Mo7F72aRkHkzdGaPLlm7Pu7fYsVdoWHJbU3hCEr/ayWVXV
 uT3A==
X-Gm-Message-State: AOJu0Yz8C3ATxA7kd5f6ke7VX8VW5v/OETd0wvLUc/mFwy8YPoejxfdv
 1QxqDgrMIHFFwWhKQlxYY4gQNZ3ABw22g2QvHIkN2YhzOTRBEu03sbTpvOMU+2dAEexB19XeD2x
 HlJ8u
X-Gm-Gg: ASbGncvKfcTdWPzhblzOW7c5c+b2TYPtds7n4LxDJX9ejgaKrjfZ2bryVPmZnoHQnP2
 afvFdJBJLrEpDhlRRJt40oHIZEhg3NsWV1tb7/+pgr0uXoBPppelc+9eWvFm3pvFTsy+bDzxOk5
 OXIRhunha4ISVHOZqR8KPZpCeNG6ZjOK2LVPYbqT5GhkTZc/GGcqroCwPNHkUrZ18/NEPBrz5e9
 kmyV6hdcDvbtJaSoP5j2TgX36JvcFDmwYdWGzT/W6K/JS/L1r0s0rYfbEqwmat2tEhuZO00Hzy2
 F8rfovWke15lbX1tkDmuS/nJPRS9GqZwq+7bwKfR3TRG9d+X+t96STZ2x9HyrWQH3Sh9
X-Google-Smtp-Source: AGHT+IGUmhW6eNTRwsbb5HsIv9LS8J62fSTewm9pdP4g8U92KOSDwbq+mrw4C6KB8jKXZNuFeuKydg==
X-Received: by 2002:a05:6000:2384:b0:3a4:ee3f:e9a6 with SMTP id
 ffacd0b85a97d-3b49703d9acmr2327350f8f.54.1751646325173; 
 Fri, 04 Jul 2025 09:25:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 024/119] target/arm: Use FPST_ZA for sme_fmopa_[hsd]
Date: Fri,  4 Jul 2025 17:23:24 +0100
Message-ID: <20250704162501.249138-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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
Message-id: 20250704142112.1018902-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c    | 37 ++++++++--------------------------
 target/arm/tcg/translate-sme.c |  4 ++--
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8f33387e4bd..9942d717aaa 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -904,20 +904,11 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
 }
 
 void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, float_status *fpst_in, uint32_t desc)
+                         void *vpm, float_status *fpst, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) << 31;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst;
-
-    /*
-     * Make a copy of float_status because this operation does not
-     * update the cumulative fp exception status.  It also produces
-     * default nans.
-     */
-    fpst = *fpst_in;
-    set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ) {
         uint16_t pa = pn[H2(row >> 4)];
@@ -932,7 +923,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, &fpst);
+                            *a = float32_muladd(n, *m, *a, 0, fpst);
                         }
                         col += 4;
                         pb >>= 4;
@@ -946,15 +937,12 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
 }
 
 void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, float_status *fpst_in, uint32_t desc)
+                         void *vpm, float_status *fpst, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     uint64_t neg = (uint64_t)simd_data(desc) << 63;
     uint64_t *za = vza, *zn = vzn, *zm = vzm;
     uint8_t *pn = vpn, *pm = vpm;
-    float_status fpst = *fpst_in;
-
-    set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ++row) {
         if (pn[H1(row)] & 1) {
@@ -964,7 +952,7 @@ void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
             for (col = 0; col < oprsz; ++col) {
                 if (pm[H1(col)] & 1) {
                     uint64_t *a = &za_row[col];
-                    *a = float64_muladd(n, zm[col], *a, 0, &fpst);
+                    *a = float64_muladd(n, zm[col], *a, 0, fpst);
                 }
             }
         }
@@ -1065,19 +1053,8 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst_odd, fpst_std, fpst_f16;
+    float_status fpst_odd = env->vfp.fp_status[FPST_ZA];
 
-    /*
-     * Make copies of the fp status fields we use, because this operation
-     * does not update the cumulative fp exception status.  It also
-     * produces default NaNs. We also need a second copy of fp_status with
-     * round-to-odd -- see above.
-     */
-    fpst_f16 = env->vfp.fp_status[FPST_A64_F16];
-    fpst_std = env->vfp.fp_status[FPST_A64];
-    set_default_nan_mode(true, &fpst_std);
-    set_default_nan_mode(true, &fpst_f16);
-    fpst_odd = fpst_std;
     set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
     for (row = 0; row < oprsz; ) {
@@ -1097,7 +1074,9 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
 
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = f16_dotadd(*a, n, m,
-                                        &fpst_f16, &fpst_std, &fpst_odd);
+                                        &env->vfp.fp_status[FPST_ZA_F16],
+                                        &env->vfp.fp_status[FPST_ZA],
+                                        &fpst_odd);
                     }
                     col += 4;
                     pcol >>= 4;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index fcbb3500161..51175c923ef 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -358,9 +358,9 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
 TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
            MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_A64, gen_helper_sme_fmopa_s)
+           MO_32, FPST_ZA, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-           MO_64, FPST_A64, gen_helper_sme_fmopa_d)
+           MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
 
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
-- 
2.43.0


