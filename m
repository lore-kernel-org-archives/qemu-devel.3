Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22342D78323
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Yc-00014O-4w; Mon, 02 Dec 2024 08:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002xM-6F
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Bd-Kq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-382610c7116so2821526f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145245; x=1733750045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4kNtCiwJHe+Pk4Qi2sHCtONsH6gpm3d9+pTiscaZow=;
 b=CJKipe4cr5uo13n37A+kP615eP86lXChGTbfyx+j7T9jHnkOkcnPCd9ekigPDtCsG2
 blQncN0AhoJ79arvRkJnVpu3xzoEueaonB56FJz41es/SRaKJJVHAa0z+Bt02sZeokUd
 9/mgsxp4zxT/bgk0pjnppsODtESfG3wukNLvQZK4niBk0aRUryPESbV6Uyu/fWyYiry0
 LT+eSn8R80HhoCtKySj6B5ttgqA/CDpk4V1QPsyHNVYjmZ25XJJ9C3Hu2CH8HOF3ClUi
 vNV1ilVMW1VB+HqXFCD46+buvDxpX0MnehEQgwlVjCh161sA7KNKa2uVNL6Jv6yg88OT
 Xc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145245; x=1733750045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4kNtCiwJHe+Pk4Qi2sHCtONsH6gpm3d9+pTiscaZow=;
 b=mSHS/6tU0sEVU8kYx0ije1+AJSf32o4ECg7k7tjcglPYYYx+BHe/cfnpYX7WznK7X8
 VVIgjfd/mHOVeKGQ+wSCyoQaeFZB79t8IPQBi7GvFo+02xWjfvNP5IU3ygyaT8nX2VJ2
 JD+0j8UXzlFtoBO5e+SuTdskinApqPwuseR3eiTyyT+ha8xE3ccAn1AuExvlOiVANQ1l
 qCzoWJWA1Wapdv+7/XZrBxhaSSOwd4uBOqRcLmcO0rCDiSA25UdJe8AZ5OlaSJD2JL+z
 4lAnL3iSThHv7r6zbcFBkU4TMCciMCK5GIbjDebOidAjS2LZKb9ZMISXaxkCSe5kPSYq
 KOHA==
X-Gm-Message-State: AOJu0YznX4xkjjEIDcTbbglIeXh8KywSTqU14pzMwUtke+LItljHvY2k
 dQ7kCwRz6dRXBYaGV0xewcuzojWGzLhIu3Uj4djroG/BMkCTasTyYK20dVh+3RJsStLPnEoApTD
 d
X-Gm-Gg: ASbGncvWx8dUVO9c0VXFrGVDnkHGrs5Zg3gaG745OTSERxQv6mDIt5mm0T1mH/kG6LX
 KF9adXsSPCaRgWRzpM/5rhfIUrHXUW6HhSJX/Qa9y+uIpIb23UHJ7k2RVOiZP5giwgV5Pg8nUNh
 Zris3bD4OHz042kiyJ/dGIAe8ryVFJsG/UD8l7rQ+nQXiTnEL9QiHpuqDNt+HRYj8t2UgAh0Y0U
 IwdpJWmUEaau/OufgS5CsjTjQkaIX67F+S0MLoV0ClqEE1OIfFyMFQ=
X-Google-Smtp-Source: AGHT+IGd2Yn0QVxN56A7BlMwFtqVEZnLl3ztItNlndvu0+AAcffqEeZuYQTc1zSsEDdvnH9FAJZOEg==
X-Received: by 2002:a5d:5983:0:b0:385:f409:b42 with SMTP id
 ffacd0b85a97d-385f4090e8bmr2787900f8f.53.1733145240053; 
 Mon, 02 Dec 2024 05:14:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 08/54] target/mips: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:01 +0000
Message-Id: <20241202131347.498124-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Set the FloatInfZeroNaNRule explicitly for the MIPS target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/fpu_helper.h       |  9 +++++++++
 target/mips/msa.c              |  4 ++++
 fpu/softfloat-specialize.c.inc | 16 +---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 7c3c7897b45..be66f2f813a 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -28,6 +28,7 @@ static inline void restore_flush_mode(CPUMIPSState *env)
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     bool nan2008 = env->active_fpu.fcr31 & (1 << FCR31_NAN2008);
+    FloatInfZeroNaNRule izn_rule;
 
     /*
      * With nan2008, SNaNs are silenced in the usual way.
@@ -35,6 +36,14 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      */
     set_snan_bit_is_one(!nan2008, &env->active_fpu.fp_status);
     set_default_nan_mode(!nan2008, &env->active_fpu.fp_status);
+    /*
+     * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
+     * case sets InvalidOp and returns the default NaN.
+     * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
+     * case sets InvalidOp and returns the input value 'c'.
+     */
+    izn_rule = nan2008 ? float_infzeronan_dnan_never : float_infzeronan_dnan_always;
+    set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
 }
 
 static inline void restore_fp_status(CPUMIPSState *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 9dffc428f5c..cc152db27f9 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -74,4 +74,8 @@ void msa_reset(CPUMIPSState *env)
 
     /* set proper signanling bit meaning ("1" means "quiet") */
     set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
+
+    /* Inf * 0 + NaN returns the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never,
+                              &env->active_tc.msa_fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2023b2bd632..db9a466e05b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,21 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_MIPS)
-        if (snan_bit_is_one(status)) {
-            /*
-             * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-             * case sets InvalidOp and returns the default NaN
-             */
-            rule = float_infzeronan_dnan_always;
-        } else {
-            /*
-             * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
-             * case sets InvalidOp and returns the input value 'c'
-             */
-            rule = float_infzeronan_dnan_never;
-        }
-#elif defined(TARGET_SPARC) || \
+#if defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
-- 
2.34.1


