Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA370E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSF-0000O0-BC; Wed, 11 Dec 2024 11:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSD-0000Mq-3S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSB-0007lC-Ie
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so545897f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934046; x=1734538846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jSuOu2n5x/+mHXTv9G32cuk510bUbTH6keT/6j4dWJk=;
 b=VP59xEBmncdJDStrrZo4x/oPBIClc5vGzMSuTGJ3BoKx9eqz62TPj8Rg4Lj/fjULuC
 RZfbkVXrnH7QqN8Cc3j5BJqidB4gezC3i8fjSp7oz6IlNXFwz7HByy8YuajF8d4rEpNf
 fB5CRCn02GB8hmxzTn1rhcafGb2+pYl2fcrZU6tG411/N74a53ucMvJ5fwoOPxb3DYpK
 GiWJsCMwxXmChmMijNydbaiaRd2qgEmY9SUcf0F57YOm3vrRpa5mD5Qv/0GXIq1tlZXl
 xIOzfBL5Wtyp0IC/902pE4whB6dXTqvTWpA3DWT3P8a7saQzg748BCNhnO7NMLyrWpC9
 /Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934046; x=1734538846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSuOu2n5x/+mHXTv9G32cuk510bUbTH6keT/6j4dWJk=;
 b=Wt+q89TseUUiooovrMs1tEiLvfagUUBeO9jw50XYcHdvFGZHjLHpA52LcCQ57eh2J4
 Z2g6LtpxM6toAisQ/4V6y3xUmeCWxjx0dRP4Y9EXx7OUIb9UPAlstxNh3YBII6U6h1Vr
 GiSCCkxLWVW8Xwi61RGVcuOkHffA5Rf5HcQGTwJRmxo5AvGA0VV6PEjQFZXTGg6dIiAr
 zndn1IRNiuO/GjRc45/5ilv7Cd4WLOr8fCmHv33s6GJdmGEQIczkNzwwbaJ2blXhGFa6
 O1eXEAU/3e1SrHK1Pg/0dDXlhqdnHEM0nigqXgVrGLHJqk7QuVLkNO1d2u+rqUqiufoI
 rXTg==
X-Gm-Message-State: AOJu0Yy3pmFQ1qe9mzduLvh8uhiy8EGzsS05cYazciYdvXCVU3zFjh5q
 guNcjLAFdFE3qk4dk9NXxrDhSj9xypuV0d9d0dBTpzyKAgVSNmKWm04vFGm42IrQQBjOxn+VhYp
 n
X-Gm-Gg: ASbGncsG2XxzgZJQhacGCw7rEPi6rsDJJ87rBjrz0sH3h5+v9vLjg6Hf/sii9jre1Ir
 ppgqwt5cMLVC4d3X9jiBpQcLLABPkl8ZhNx6AB6ab37UuRKSBOIs54DjOTI8yWOXp92ftfIkWcZ
 TvO6TLrQR74gxeZ4JV5qVyWSQutpyNCgQ6A3cIv8TWLn6q6I1w/cyO1e9ftn5nyaLW7jktD9aF9
 SKFWDy6n5drr5z5HWAj4wPlCUrevxOsuoakE+q8RswEQzeQRCWasbLUlWZV
X-Google-Smtp-Source: AGHT+IFs6i00E1V4Y3ueYPMb6K18RaWiU6pPPVjNRpjsaKZ+xZQxej9u1yCMzn4PjHSGSaHVaoWQsg==
X-Received: by 2002:a5d:47aa:0:b0:385:faf5:ebc8 with SMTP id
 ffacd0b85a97d-3864dedfe22mr2254661f8f.21.1733934046202; 
 Wed, 11 Dec 2024 08:20:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/72] target/loongarch: Use normal float_status in fclass_s
 and fclass_d helpers
Date: Wed, 11 Dec 2024 16:19:26 +0000
Message-Id: <20241211162004.2795499-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

In target/loongarch's helper_fclass_s() and helper_fclass_d() we pass
a zero-initialized float_status struct to float32_is_quiet_nan() and
float64_is_quiet_nan(), with the cryptic comment "for
snan_bit_is_one".

This pattern appears to have been copied from target/riscv, where it
is used because the functions there do not have ready access to the
CPU state struct. The comment presumably refers to the fact that the
main reason the is_quiet_nan() functions want the float_state is
because they want to know about the snan_bit_is_one config.

In the loongarch helpers, though, we have the CPU state struct
to hand. Use the usual env->fp_status here. This avoids our needing
to track that we need to update the initializer of the local
float_status structs when the core softfloat code adds new
options for targets to configure their behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-30-peter.maydell@linaro.org
---
 target/loongarch/tcg/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 37a48599366..aea5e0fe5e6 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -359,8 +359,7 @@ uint64_t helper_fclass_s(CPULoongArchState *env, uint64_t fj)
     } else if (float32_is_zero_or_denormal(f)) {
         return sign ? 1 << 4 : 1 << 8;
     } else if (float32_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float32_is_quiet_nan(f, &s) ? 1 << 1 : 1 << 0;
+        return float32_is_quiet_nan(f, &env->fp_status) ? 1 << 1 : 1 << 0;
     } else {
         return sign ? 1 << 3 : 1 << 7;
     }
@@ -378,8 +377,7 @@ uint64_t helper_fclass_d(CPULoongArchState *env, uint64_t fj)
     } else if (float64_is_zero_or_denormal(f)) {
         return sign ? 1 << 4 : 1 << 8;
     } else if (float64_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float64_is_quiet_nan(f, &s) ? 1 << 1 : 1 << 0;
+        return float64_is_quiet_nan(f, &env->fp_status) ? 1 << 1 : 1 << 0;
     } else {
         return sign ? 1 << 3 : 1 << 7;
     }
-- 
2.34.1


