Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A18C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY5-0006Dl-SY; Sat, 01 Feb 2025 11:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXu-000643-KQ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXs-00015j-2R
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436341f575fso35238065e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428033; x=1739032833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ON/Q5A+D+dYxinxhBdih1LIywvHUNEqZZNcBcHMSebw=;
 b=ueXaG5doDV0LGTarxoWpR4hQpeQwq/243u+vetdF7vWRZ7ZgveUB+pHm5ROArisJyt
 ZDJDeFvFLMAFtmr6iv+WOpMvODLyxcXD8hMAQt7Pp6QtmRxL8X3IupChu3i0G4hY0NeJ
 4VdAb7hFXVgfSUJ2DwBIPD2xHGWj7zRYxaDBuzZtYL1p+IuWV1CruU2kQYRrYkDi3/es
 52jZso2M8yIVIwVzS6OsfHwj+5YoQfnoQE+ipFAVj+O6H9YqRtX2HMWt9QN7l1wVOiOE
 BeBd6qAT1H07XZsnpnF5knvdgYA0iGPdvoik8w8UdCbOrsIIn+q+bU9jfGnIzDRIm6lG
 /6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428033; x=1739032833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ON/Q5A+D+dYxinxhBdih1LIywvHUNEqZZNcBcHMSebw=;
 b=OZ/6vgYj9eLEBkUIL0Tuyl4/Kfv4sqEImOqYrHtdnWky91QxuXKd+s1ioRaDKbHtM6
 jGmCr8w5iKlgYin5t40LIKIrMrOF8U8hyv/GNKrIOtXUfl0ISFDrN1H8PRR3OKeCiJmn
 Du32EnT5xeD4vkCgErikD9KMQt5uaCaevaavmAEyjmTvRnHkPPeqf3+5SVxx0YPbx9+d
 Ua5JZ/DriMMPGgD5AXxSmPRhpQD2TTlUKYhs3Gob7PLaGKl0yjXa1Em77L4LgU/hwzzB
 ZT0qTcuWEQzdkDJ7rtBKrws5PC47Q5dL0wpL2KVsHZNCnVzyi3v1b+RUNWCEm9tPAdR3
 W0zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwhMBSGoL/2sgjIy2/1enBDofYMX+45ovJolGr3aTIsKJHGErQusbHdUIJIA36jDlFjc3olXgVTfk3@nongnu.org
X-Gm-Message-State: AOJu0Yw3kQf9P7ERdk4PmOwAXRYgMFfxd3vKb++Jk5hdIXIBU457FjQ3
 M99V+ksHuOpIh1EuU2ZNoCnLKQJ9xtiBOR5eajCGCQrFPbOWCeLWJuD+N9/7ZoLQ7LrhSJNoYK/
 e
X-Gm-Gg: ASbGncsK+qDwAQNopew6jfsZ6NQJGVO0DKbODAp/x74AvQ/f6EZwBwBSIw/KOOVLXAz
 8yXRxKDcYwXPAc9T2hmAS8jk8mo0s6b3QRINmQzATMbKgtx3xXbBlwqYI6kUIPcM1Q6rVLnGIvv
 sxJte/uQX/hrV00JVzfFJVyNe5LRqbh1wOl8W2555qg3Sk+oSO7l612thpKpdOmWi8dd8So4FO6
 pAZYuaBTvLp8epF0kYfsRk0cnLHQ/sLQTyBlOveO7l2TUcLJNmsmfBiIiJnCPJL/z+G/J0AUf88
 xYauR/OCvdpjgE7PYm/q
X-Google-Smtp-Source: AGHT+IFuqUCtcPTq7sn43s4aL31aQs+BtliyTmzofTJzH35ssEA6Ej0jnUj0rczR82MN6BCrUjssWw==
X-Received: by 2002:a05:600c:3d05:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-438dc3ab518mr183893725e9.5.1738428033121; 
 Sat, 01 Feb 2025 08:40:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/69] target/arm: Use FPST_FPCR_AH for BFCVT* insns
Date: Sat,  1 Feb 2025 16:39:16 +0000
Message-Id: <20250201164012.1660228-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

When FPCR.AH is 1, use FPST_FPCR_AH for:
 * AdvSIMD BFCVT, BFCVTN, BFCVTN2
 * SVE BFCVT, BFCVTNT

so that they get the required behaviour changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b01d05fe30e..bb32ccabf0e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8514,7 +8514,7 @@ TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 static const FPScalar1 f_scalar_bfcvt = {
     .gen_s = gen_helper_bfcvt,
 };
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar, a, &f_scalar_bfcvt, -1)
+TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
@@ -9290,12 +9290,27 @@ static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
-static ArithOneOp * const f_vector_bfcvtn[] = {
-    NULL,
-    gen_bfcvtn_hs,
-    NULL,
+static void gen_bfcvtn_ah_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_AH);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_bfcvt_pair(tmp, n, fpst);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_bfcvtn[2][3] = {
+    {
+        NULL,
+        gen_bfcvtn_hs,
+        NULL,
+    }, {
+        NULL,
+        gen_bfcvtn_ah_hs,
+        NULL,
+    }
 };
-TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
+TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a,
+           f_vector_bfcvtn[s->fpcr_ah])
 
 static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c084bb58e7e..be2b5528ba0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3904,7 +3904,8 @@ TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvt, a, 0, FPST_A64)
+           gen_helper_sve_bfcvt, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
@@ -7054,7 +7055,8 @@ TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvtnt, a, 0, FPST_A64)
+           gen_helper_sve_bfcvtnt, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
-- 
2.34.1


