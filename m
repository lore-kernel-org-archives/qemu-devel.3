Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6B1C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOt-0002SX-Qk; Sun, 11 May 2025 16:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOs-0002RY-7p
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOq-0006KF-Ln
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22fb33898bbso45012975ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995751; x=1747600551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nCjOAsJJrs0cOllpEn8wbCHdD6i2qsocFmc3YVZlU4=;
 b=S1+RGDxQRFTbUMdkpinR6gmZGI9TLtukBKrPO6qY6/zMD//Xzzp0PjuYm7GvsN4t04
 Gf36QPdv2s+yWZKRw5x3AftvQ/N7yaqp16LW32ok/qr35KKtVil+Q7Au3HoRmH/RlVap
 LlhCek7uQmYvPv9lP0KbRc8ruwx+h7vyxpZDEZUjEXf0QR3RfBSX42eb76aKlEWyUcGj
 oiaNYAqwPsfH0R+lOHwX70dGZNbgBPVhJNlIt5DfjfEQSVAaeqELcfnExKB3EDTyKZqT
 s/WFiCA9q79pvjx8PdEfbLVuuGK9KeuX0lePbH5RVH9kZ5+AwfOsbdkbLDCf58OF2n5F
 zQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995751; x=1747600551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nCjOAsJJrs0cOllpEn8wbCHdD6i2qsocFmc3YVZlU4=;
 b=iX0GJmaiYEA4QhiFcGZTFJo2zjaY40wj86quiD4ZUR5l3v/4LO4a6aQRwVzYBbKHD+
 s9FyCg3PKXceCBnfFoUC0GdT1f7PSiqffdZGfgi1wHW7Xu6MpASVtO1ZLBW0XGs6cXDj
 PiZKdLb0P5oue60Gbffhk1m/kMrsBu1wD5lKQiA+167l2CixEFiCYdyHynNDrJexv69s
 ESTKLz6aR/ezj1owJTP7G0Z0pHU1skPjBAlRi+2cLH0ybyA8D9v/tbFEbZbblzA/sYMB
 AwW3iCpRb1h158y1KsXfxJAP3M+VhhchCVK4rhzQn39TZm5RG5xtAPS6A8p+Oh9NZExy
 p96A==
X-Gm-Message-State: AOJu0Yz0T4PBIpA32KUqQQdHdzakZoABQD3L3PSeB5iSzUdCJelSdizC
 3NDhpLgkXbKbNx4qv6Xuhl9UzKTULhpfBu47Iu0zBci6eWBJUcRCKdUF/RPE18w+rYOr7/0CAze
 w
X-Gm-Gg: ASbGncsteTzpagv5MmQjZdhKnSmXw2W4QbJKv0UeZl7+tjJS2Mk4tpVcsCYya3IkFO/
 4jLMH4hzHmh2Y4XcK5i5sBxW1Q8IZnNjrDEmIvHmhHzSwfuvIV37kqT5MgrQ2Iy0w4wA/3k0p41
 M+115TU0JQT6pdMNAXJYHK/RT7GTcZuq05ax+DmndIBaWHdqmVqP7EHC2HO9wTJO6JPb4oCuHNc
 WuVmwHhtaGiAvP4A2tLX92XgH4YrfmL0tTEj4ciuL23QgrpiT2xYV47fp4hdsYJ1ZvUBOWqagEE
 2AK8WDNABPiNTVnfa8j32UR4O8H+d8GvM1TFLaH0Iryf3n4VCvPmMfR28JLZH6Ee+PmPJiuut0I
 3+aNuLTfWxg==
X-Google-Smtp-Source: AGHT+IFciOHaQwMpLsuwxqyXd3RbFCNTEylTemwzUtvORVvwEC+n/fIDo9b6kmiZwOCmXVorHcNiBQ==
X-Received: by 2002:a17:902:dac6:b0:223:f639:69df with SMTP id
 d9443c01a7336-22fc91a56c7mr171776595ad.41.1746995751006; 
 Sun, 11 May 2025 13:35:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 04/24] target/m68k: Update FPSR.EXC
Date: Sun, 11 May 2025 13:35:26 -0700
Message-ID: <20250511203546.139788-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

So far we've only been updating the AEXC byte.
Update the EXC byte as well.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 195281f118..deae94b0ee 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -168,26 +168,28 @@ static void update_fpsr(CPUM68KState *env, int cc)
     uint32_t fpsr = env->fpsr;
     int flags = get_float_exception_flags(&env->fp_status);
 
-    fpsr &= ~FPSR_CC_MASK;
+    fpsr &= ~(FPSR_CC_MASK | FPSR_EXC_MASK);
     fpsr |= cc;
 
     if (flags) {
         set_float_exception_flags(0, &env->fp_status);
 
-        if (flags & float_flag_invalid) {
-            fpsr |= FPSR_AEXP_IOP;
+        if (flags & float_flag_invalid_snan) {
+            fpsr |= FPSR_EXC_SNAN | FPSR_AEXP_IOP;
+        } else if (flags & float_flag_invalid) {
+            fpsr |= FPSR_EXC_OPERR | FPSR_AEXP_IOP;
         }
         if (flags & float_flag_overflow) {
-            fpsr |= FPSR_AEXP_OVFL;
+            fpsr |= FPSR_EXC_OVFL | FPSR_AEXP_OVFL;
         }
         if (flags & (float_flag_underflow | float_flag_output_denormal_flushed)) {
-            fpsr |= FPSR_AEXP_UNFL;
+            fpsr |= FPSR_EXC_UNFL | FPSR_AEXP_UNFL;
         }
         if (flags & float_flag_divbyzero) {
-            fpsr |= FPSR_AEXP_DZ;
+            fpsr |= FPSR_EXC_DZ | FPSR_AEXP_DZ;
         }
         if (flags & float_flag_inexact) {
-            fpsr |= FPSR_AEXC_INEX;
+            fpsr |= FPSR_EXC_INEX2 | FPSR_AEXC_INEX;
         }
     }
     env->fpsr = fpsr;
-- 
2.43.0


