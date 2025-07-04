Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32ADC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhJX-0007f9-Qp; Fri, 04 Jul 2025 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIB-00050j-DI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:34 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI9-0005Z3-Jl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:31 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eb6c422828so1283974fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638888; x=1752243688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qv/VxcFKc2nhD2P/0kekyRsDOu03G4xgMX0HwOwNFDA=;
 b=Y8kf/cx9AECCptZv1qOuJ8ZtRJ8mQkwlKiNj0mVv7nPrDhlzTHbaOHigbCpCIl1csr
 sQzaKsJbXRdL1gBJZswP4MsQshUoZxAvJz+FYT/qjwZjlfTxamrxcjvsPBwY5UDpe2a4
 FIi/tSrspozWh28jf1l3er14juyohG0XoD8y2mJJ2d23s+ESN+Euo8hbz7W17ObPfU2y
 qnl2of2xBxdy/ZIze3IzdkTnsP85gWa5f7eqZdqPPA/Msx/Qi6Z26wRCtSSHYtkjASpO
 NR/AX3cvr+Qw5zZon05rNKh3OmeYxMIk5Sdiwx5mzMMwsm4wbb60MjHKQuOf8jLCRn21
 1QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638888; x=1752243688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qv/VxcFKc2nhD2P/0kekyRsDOu03G4xgMX0HwOwNFDA=;
 b=ver5xgeIJVg4MCJFBwO0vvUvXsqJ1FdC4HFcVM5/cyWOpcRRmCE0KFfBhHplZ/iEk5
 DaQUxHpZFACni5y0E+m6fGVPquE7LB6v861beZujptPFUHObl81wYfNCXG94Z/kAbrEW
 5rfWDtls7deXAH7YoDPQcO9kbO70jq6yDSZoLrzv8JVlYadak3hLWDUQGDbEqD85R39/
 xeSl8CIpgCZ5xkyr1pppGtaROKbbrcmT4IOxR771qJt4ebCiXMxGbs50il0q8ZRx/fMg
 ryZOrW2oLyqnLGO/S/ZlI8cOcy9p0U55EKIaDZ/yOo5/UI331K2sY8Vk8Dix5grB2BtP
 coAg==
X-Gm-Message-State: AOJu0YwoA41/lYW9yGCiiieliwjyy1HJeqGtGNW4VgqzyMBDamNdeaGj
 3fK38qqKPwFc4IcnQSdKioG9ZrJsatQ25ixJhyplvdbcx2wFFwuWzGAR/OIcbqbpwSOPE2fO/Ga
 ajXVnjWc=
X-Gm-Gg: ASbGncutzrIYZaaFN3yvup8IYKC6aGAZ+BT2H0KPzqllntrFZbf3l2VQ8WrPnUjKs6C
 FkKEo6yh8LHAS27D3yB5rCdIUGPLLpyRO0trHxFyeI/uqRn/YnMEWg3vabQe9Ap/g3n+libp1/G
 Youfe+DWC1AvkDeBgQVku2IZCRx2wdptLg6IpSMl+xpwEtl77UoJcJx16ZLkaS3bRCxdXaFPrYb
 1wb4xu0/n9toApNt5AAJt4bL0VXDs14FQpT4450wjBEXqOnPb/87jNL7yYD2Bp32X0opIbB+7LZ
 J158AHTRV3mUxoz0EB/m/vzunQwV2jEOSjvamg7Lfe0qaien1oxy35EXRrnj4msc/cdEXeDeeQ5
 tr+ewzXNiU+KqQhSo5me6UkC4+yYse8ZSGGZkuepJD+37FjJcBHrG1YAjpd8=
X-Google-Smtp-Source: AGHT+IHGh9TQrhXvFiKKwpdqdRwtCHOGcCsh6+6C4Tm+Dr/Wd9rOrtBVFtEsWOxfWC3rBarTm4lEcQ==
X-Received: by 2002:a05:6870:d1d2:b0:2c1:2262:7941 with SMTP id
 586e51a60fabf-2f79203ecb9mr2099504fac.16.1751638888361; 
 Fri, 04 Jul 2025 07:21:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 012/108] target/arm: Use FPST_ZA for sme_fmopa_[hsd]
Date: Fri,  4 Jul 2025 08:19:35 -0600
Message-ID: <20250704142112.1018902-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c    | 37 ++++++++--------------------------
 target/arm/tcg/translate-sme.c |  4 ++--
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8f33387e4b..9942d717aa 100644
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
index fcbb350016..51175c923e 100644
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


