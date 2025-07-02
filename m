Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD620C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwU1-0004tS-35; Wed, 02 Jul 2025 08:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTw-0004s7-U1
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:32 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTn-0007DL-V6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:32 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ea2fee5471so3661506fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458942; x=1752063742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baCvuXNefMQymQ80qbfxmxR0glq7SPYFcTPfnY9zD18=;
 b=uYalkl9ETx8HTCo4bDXkxCfFmjpfWPsplJd2PZDZBVVBHbVww0o8QSn2xxbyVzFWuB
 gfUMe4f2LIvkrvTqhER4nN8qHlhUEzsK6i30XDmO39cxZK59+znt7OWml1KoiG1jGTvT
 f9GoLebRXPAxSCjFzpQLyE14UxlXMoMsgfdnMNNzPqPCB+sE1U4Rn8Ts05BMT7BnU4st
 sHobEe3TW53vTAh25026VlZ38jTa1OVgOMJSD/Ei+AztqfKpN+lcuF9gj21Whg/emecg
 BZ8o405+v1OHgzyk4UCIM7zlvdqeSooEXqhN2vFRzDeFCNCB2Z81NMZdW1lCEIP2gSCI
 G88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458942; x=1752063742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baCvuXNefMQymQ80qbfxmxR0glq7SPYFcTPfnY9zD18=;
 b=tgtJrdtrNIM1yRQ30JhwdHzQGzOwsWTipAfX71VZ+sRts51WL2p+/ERfnLprgZc0Gt
 Ev+dHHG3Nwmdl/PUbBJXjDSq0TJL8g513XHmXPyetQb31Un3X8m2xE9UG2h3YHUFnf5R
 pSdhQ08Nz+naVORJZfOuq+HiRMmy2sN520DlrAmMgB0BAi/M25qHCiXxeuxoF4uEQHaP
 NyMkSFj/Om1WyF+Jdgi86A0fN4D1JHA7lr392FPKSldil09SjYVQHCQNdcbHMTfh8IUd
 TedDi55ER8AIRTDQkxJl2of1JdOXCxaV35tjuSc1W0OtDxqwt87eSEQW9XZYFsynIhVk
 v//Q==
X-Gm-Message-State: AOJu0YwysZFK6XxMQN0pVJDp310jL8XVgSrKmQOXC/h+DahzdwDRCGLl
 b/Yj96puzcdkkqkxYc8UYc7USf/XD0FvkDzJ9Ee7kydJOly3s3tREDfPUx2MNxMeg7bodMPgAHu
 UeztWnsg=
X-Gm-Gg: ASbGncv35u7RcvGzf8P3vFPdlulQgFaCGphYi1Cz8vghRGefRyborHvQ+32AaEv+MTl
 9fr04jmqiRc6fV06jR69WVQ/CvHBsI2vMbJ3/cfrETR5HRVWlRuVe9r0h58IklmbmNrI1KpXC3V
 swI5elwd7Wnfmz8Y1vPb6AxqAk0AiTvWZTXo2AfXmWOt5145SACOUiNXa7QxF4reKNy+ShB6xRn
 n7DvdG27D3l4yMEDV2MZ0yp+tE2Aw+B0+nIvl/CxweWd1fMJQlYe+E2nUADiTICVv254pWc42O4
 DtpbJeMbC+aNhL/yIOba2/2R8zuXO414BX37IkC1sglYH9/7/7AYtVsO8z+6JxI7yWaV9g==
X-Google-Smtp-Source: AGHT+IG8O3c7Ayf5OIaO8OywKFYvhsiMOcGZA3xkdFhWHxf2fMTvk3P+uYoh0ZS3b2h2j5VR8FBvzg==
X-Received: by 2002:a05:6871:4409:b0:2e9:925b:206f with SMTP id
 586e51a60fabf-2f6649c53cemr1615173fac.17.1751458942123; 
 Wed, 02 Jul 2025 05:22:22 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 05/10] target/arm: Fix FMMLA (64-bit element) for 128-bit VL
Date: Wed,  2 Jul 2025 06:22:08 -0600
Message-ID: <20250702122213.758588-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 588a5b006b..a0de5b488d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7025,17 +7025,26 @@ DO_ZPZZ_FP(FMINNMP, aa64_sve2, sve2_fminnmp_zpzz)
 DO_ZPZZ_FP(FMAXP, aa64_sve2, sve2_fmaxp_zpzz)
 DO_ZPZZ_FP(FMINP, aa64_sve2, sve2_fminp_zpzz)
 
+static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
+                     gen_helper_gvec_4_ptr *fn)
+{
+    if (sve_access_check(s)) {
+        if (vec_full_reg_size(s) < 4 * memop_size(a->esz)) {
+            unallocated_encoding(s);
+        } else {
+            gen_gvec_fpst_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, 0, FPST_A64);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, do_fmmla, a, gen_helper_fmmla_s)
+TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, do_fmmla, a, gen_helper_fmmla_d)
+
 /*
  * SVE Integer Multiply-Add (unpredicated)
  */
 
-TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, gen_gvec_fpst_zzzz,
-                        gen_helper_fmmla_s, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_A64)
-TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, gen_gvec_fpst_zzzz,
-                        gen_helper_fmmla_d, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_A64)
-
 static gen_helper_gvec_4 * const sqdmlal_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlal_zzzw_h,
     gen_helper_sve2_sqdmlal_zzzw_s, gen_helper_sve2_sqdmlal_zzzw_d,
-- 
2.43.0


