Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05AC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMc4-00044d-7Q; Fri, 24 Jan 2025 11:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYn-0004uA-CB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYl-0005ej-Hx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso16645565e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736170; x=1738340970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34luHZDyy2429KmxgwNFbXGPJ5mxedoShXZjqrjksvU=;
 b=q/EKfThNwnS6F1UljhblK22mmQeYpI/va+Q0N4FmJwAugqvip2HI5i0xZL/l7aIwe/
 f2zoyS3qB22EmCvVKzVJ71QdDERD7USgFV6Zpb7RMZJEXGH2S+4KRczFwqt7j8zNY+YL
 lNeemEveOcrohE6GHBHkarx6kiFd7stHcXf5ZHKMrjgyho4kA5D3Jk/vI3KwdCKdurDo
 x8SRYZFObHit2Wx7leePVLXnvRGhH+CnU4Lx4dZiIBqZ4yB55Fx/KmgUHw0ZN3O8tCFQ
 rXDZ8+pgUb5/m/7vCNxON6F6V96ZXu+qKM0f8tkp4A3U9mcPLC7oiUM9zMUAYY90BumX
 ueSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736170; x=1738340970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34luHZDyy2429KmxgwNFbXGPJ5mxedoShXZjqrjksvU=;
 b=i3pfAoxK2ZRvdze0P4KJCT33fGVt7HW79FBNeojZd4nZXXnRYCQ9iixcmo2pOrdMDu
 WHmozI2me0TWX2GElNUBRblgW3+bz9+T5oep4GxdWGPRoahds1C3nCZ00BTwd3KyV8OH
 TWlKMgd4Qooed+wTe6svERfBUoOaYW2Qzl4c/mC7M5Eiv62YBfzbCb/9FatRfZkHOoKx
 BG7YqJJwXRLhhoSIVQnxVBY8+IcY3a+RtH/w1n09CjeP8XtJTZ36hqXtHl8u0Pz/CXJq
 nUN7cwoMogF3S6bAdyeyg6Hd5UyYmtPfyVUv5iuFyRRKFIsk1wjcFZQTDFfW2JfeMSF9
 zedA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEyj4LwSe5ylXCyexHp8js9NZJrdRP5LD+PkP8XY7/t1uOiej7lCNI+h9A0+frhbWBo/zEybTI6uZs@nongnu.org
X-Gm-Message-State: AOJu0Yy+9Hzmx0ji7fUI3rMG/BNVA+f5ODFxTbM0TWwNdI+dRUF5CvjS
 LnH9RwYXF3cjOJ0HR7yPxtSkQyE9E7NI3XuOQCnOolSX2XCLPNbR2ddFzGQ5aZU=
X-Gm-Gg: ASbGncvkYE2j2NuD8edRW7/oKAJ8MknQ1Od0JWTrqaeZHLsDBpuVU3OJqCa43b2Jv7H
 A0UDN7s2G2XY2OERmeymiZoiPN/DfBIhkKOuYFU/KrxlcrQRK0vyHQ98nlkGT24A1RI+OqNTqRd
 NPSUD2ExYCIrvRC2v8rkvsmTTj+8SX4SGDwthOkSv7l0ttGS/Qmhn9pduaTLnyLU425kfg3Jl1B
 vPJ8Z1DjvYdWw/50t6MVPA8inaikeSFkWHfnV63U4kF5Al5dChkXq+mA2yp5nO0gNGSKEbDGRG1
 5OaL6zVfxkc=
X-Google-Smtp-Source: AGHT+IGWz4w6Fzo6hmbLkmmikabUgPyecV011m5r95vt1qy3x03c5L0nwrKjMbxWo2rETIys99WvGg==
X-Received: by 2002:a05:600c:3542:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-4389145137dmr242320265e9.25.1737736170078; 
 Fri, 24 Jan 2025 08:29:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 42/76] target/arm: Handle FPCR.NEP for scalar FABS and FNEG
Date: Fri, 24 Jan 2025 16:28:02 +0000
Message-Id: <20250124162836.2332150-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Handle FPCR.NEP merging for scalar FABS and FNEG; this requires
an extra parameter to do_fp1_scalar_int(), since FMOV scalar
does not have the merging behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6c20293961a..7412787b6b6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8437,21 +8437,30 @@ typedef struct FPScalar1Int {
 } FPScalar1Int;
 
 static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
-                              const FPScalar1Int *f)
+                              const FPScalar1Int *f,
+                              bool merging)
 {
     switch (a->esz) {
     case MO_64:
         if (fp_access_check(s)) {
             TCGv_i64 t = read_fp_dreg(s, a->rn);
             f->gen_d(t, t);
-            write_fp_dreg(s, a->rd, t);
+            if (merging) {
+                write_fp_dreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_dreg(s, a->rd, t);
+            }
         }
         break;
     case MO_32:
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_sreg(s, a->rn);
             f->gen_s(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_sreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     case MO_16:
@@ -8461,7 +8470,11 @@ static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
         if (fp_access_check(s)) {
             TCGv_i32 t = read_fp_hreg(s, a->rn);
             f->gen_h(t, t);
-            write_fp_sreg(s, a->rd, t);
+            if (merging) {
+                write_fp_hreg_merging(s, a->rd, a->rd, t);
+            } else {
+                write_fp_sreg(s, a->rd, t);
+            }
         }
         break;
     default:
@@ -8475,21 +8488,21 @@ static const FPScalar1Int f_scalar_fmov = {
     tcg_gen_mov_i32,
     tcg_gen_mov_i64,
 };
-TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov, false)
 
 static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_absh,
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
     gen_vfp_negs,
     gen_vfp_negd,
 };
-TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg, true)
 
 typedef struct FPScalar1 {
     void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
-- 
2.34.1


