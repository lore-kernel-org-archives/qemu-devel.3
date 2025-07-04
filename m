Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53314C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE8-0008Oj-5e; Fri, 04 Jul 2025 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE4-0008Lw-IT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE1-00067n-SL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453749af004so5390745e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646319; x=1752251119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7c4SCBPBgFQ7HiqrH6euDpAw542dy85MtrPOPy42xtg=;
 b=N/U8DOHPVOKGHAuuPQrtvMzOhpwaaWdQ1V51N4kH4PERHjwZvoYjjloMi4qAVZzDqW
 clZYZ07aCZa8jeB44uZS8a2y2BNYau44TAtQV3nBPkKLPXzQwzuKBDBKLXFD2KxxOaWW
 HUHM/I9xPyRYHykHAiYwc/4pVISZDvq4swaHnRPz6HMVmhwL0IE+XxsffuFMYS59/ISK
 GvIaBrlEV5Hkr7jfh7wMhaA2plOlxnmjxqkXMZYdmwVyGKnfchgE956p/uskj3Z7r1Jj
 eQkOvSaUuxviypEyXafpAyhPQ5HC1Tg7ATT7k/WhhfZW3OwUakZRpmCfgs8Onq8WCQuv
 7y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646319; x=1752251119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7c4SCBPBgFQ7HiqrH6euDpAw542dy85MtrPOPy42xtg=;
 b=aJ2vWMGCJLPmSzhUEL7bf2ZyAQABiOEasOItFrBHEClmB+bkrDjMfMn8xrs67U1H+Y
 k9dsjJmDxgUZu3t3vEGFgBUd17og/8l9f4zDd4ckEO9JZTbz9Q66X5skbq2WsNyM1yFf
 KXBJYDBBsp3/Fl9CsMEN4wEBvWHX1p9M11OeEC7o61wXqcUIAumk87U+DCtWts1FXGXn
 PQmteQD8u3rMgvMB8GfCwdt264H6WpHgv797FFq7xGlVdCscHK3za80y2taoF7hYppYo
 XMa6nFVwkAgXLQVlmmMFVhU1mopMUaimotsFTS0crgDHCfcSFzvA+2v1O2ipnz02NacL
 rNbw==
X-Gm-Message-State: AOJu0YxFVpuMj3dIztvgVhjgunop5iaQ4+i8Z2DLmldlu7W7gRoF5ZWT
 WKP5bTrCEc1SPjx0Hl3aefL8zGaQw9znYBaaRPvQNBRFaVqENy0PrBxs2K8npmLzED7gKiTeNLR
 7VJr8
X-Gm-Gg: ASbGncvFE4nsxNukGXm2AGJn55aNqqgE+SNDXcoysX2ldkKWyd/+haAaJb4jqS9WBw4
 fjxuueiqXLkl3ZEtwugaghu7Eig7Ulc4UKeV82gxvDCV24d3Ks9j4MUCegKfR1TnxypnhO4GJPS
 24l7p3MSEGvXbOWwM2IjvNmoVNleDY3XmKDqWUDpQZc5N7c0sf1izRzcVMcuE0HQogvFEvMA34F
 mWNLUczSzo6IJ9Baa4dc7Z31G3FMDqiPahAgtHjlyhrFSurJTSfdge/9ZnQ2nTluRAt292vIVg7
 eP1b8mcm1CMGXphURDnOvUT14G9XyilYj87ry7yaVrIE/u/6/gWxFxfcniBImSmeyspO
X-Google-Smtp-Source: AGHT+IGsFdZfAoRABm8aMH82NTS11QoInSsPtRui9zZHYJADBAJSGd6Kyxw/0oWzxjKfL4xycjpn1g==
X-Received: by 2002:a05:600c:35c2:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-454b9cf5297mr2687485e9.0.1751646319071; 
 Fri, 04 Jul 2025 09:25:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 017/119] target/arm: Fix FMMLA (64-bit element) for 128-bit VL
Date: Fri,  4 Jul 2025 17:23:17 +0100
Message-ID: <20250704162501.249138-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20250704142112.1018902-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 588a5b006b8..a0de5b488d6 100644
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


