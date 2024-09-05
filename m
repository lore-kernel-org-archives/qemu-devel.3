Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62827CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC73-0001P7-3I; Thu, 05 Sep 2024 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6u-0000yE-06
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6p-0001ih-7d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:15 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so478706f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541264; x=1726146064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o6faGe6s53I53gCyvQfJrfuPm0tizhkfFDlXo8UUwQY=;
 b=u4MxKlgYM8vWWEqX9vQQRDkMIS0plTaa1GQCQrWvwyl98QWlZFVOvCIP2vhYYCffRt
 DmJTtueblZr9mSbA4//qhY5B2nwLC3Y0s4nD+HmOZp49jqhKn8RxEnhdqY4gLhgq8esE
 CrZWi45/dAc1Jtv1+PgIumIJNo/cBvLg8G7wL4GsfLUOvwN38H4tHhNSUM6pZqT049Dz
 LbNnwlnlzg31EVKp993TQ7iI8CpqoA37Tq2JBeQL/MhlFwc9KH1GeOId32ldJBH83X7v
 Sf672SYVpV1LIlv0QQXme89hJmH3XHIjJRcXT6onrnA3IMEUGcSEYwk3obIwWM1FwhxI
 WORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541264; x=1726146064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6faGe6s53I53gCyvQfJrfuPm0tizhkfFDlXo8UUwQY=;
 b=faBq8IwdsPOwZRdOjCWhVvbbbad1cnG4NILTzfA/qpB3wcGIWNeBoBEAORYJ56Rci5
 ei/Uyp0JQ4mkbkYnoi+IBd927gxgXxji6gmJMSPgtrxZriuAhPIpx0vHP5+iwK/V0ovM
 fCoSVArv16so2HdcCjWK+ugfAg/TrJppRy/IlFWF/rPlGPqAd9orvAzZ/TnVQfCOPFMJ
 OLO7MYvrlfTdq9Ih7DvmwiEgcPWLpcMXRnPd+RHBJgweyBqk5jRPXyK4ABae3Z1nD9Zl
 syjcwUGRYD74BRlNnVxNLivwa4HCMZnpt2gDF/E6rU69uXASMKJMfxbdzeh7AjOGR9Tj
 f3kA==
X-Gm-Message-State: AOJu0YxcGUP5RYDluDz83TN6JoRDkDJBMBS8jc5hZo8j0efw8Ie+iIaH
 xgq/ErS2h0B+N4xBdOF1bGxN4fSnihnsKFQPuMHfwflViyz7MxY8rM6Xn2JEl5tKgmmvREQr1Uq
 +
X-Google-Smtp-Source: AGHT+IFKHrbmeDOu6dc3CyftqWRnX3pyvdOWCWvmPaU766CoCYsIE6qH/k7DtbOLULbw0f8nrtxW0w==
X-Received: by 2002:a5d:58e6:0:b0:374:c6b8:50c3 with SMTP id
 ffacd0b85a97d-3776f92941fmr4434862f8f.32.1725541263906; 
 Thu, 05 Sep 2024 06:01:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/25] target/arm: Allow setting the FPCR.EBF bit for FEAT_EBF16
Date: Thu,  5 Sep 2024 14:00:36 +0100
Message-Id: <20240905130100.298768-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

FEAT_EBF16 adds one new bit to the FPCR floating point control
register.  Allow this bit to be read and written when the ID
registers indicate the presence of the feature.

Note that because this new bit is not in FPSCR_FPCR_MASK the bit is
not visible in the AArch32 FPSCR, and FPSCR writes do not affect it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 1 +
 target/arm/vfp_helper.c   | 8 ++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c59ca104fe1..cfb82c23cad 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -556,6 +556,11 @@ static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
 }
 
+static inline bool isar_feature_aa64_ebf16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) > 1;
+}
+
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a3fd595621..f065756c5c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1707,6 +1707,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
 #define FPCR_UFE    (1 << 11)   /* Underflow exception trap enable */
 #define FPCR_IXE    (1 << 12)   /* Inexact exception trap enable */
+#define FPCR_EBF    (1 << 13)   /* Extended BFloat16 behaviors */
 #define FPCR_IDE    (1 << 15)   /* Input Denormal exception trap enable */
 #define FPCR_LEN_MASK (7 << 16) /* LEN, A-profile only */
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index b3698da8ca7..203d37303bd 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -254,6 +254,10 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
         val &= ~FPCR_FZ16;
     }
 
+    if (!cpu_isar_feature(aa64_ebf16, cpu)) {
+        val &= ~FPCR_EBF;
+    }
+
     vfp_set_fpcr_to_host(env, val, mask);
 
     if (mask & (FPCR_LEN_MASK | FPCR_STRIDE_MASK)) {
@@ -278,12 +282,12 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF
      * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
-    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
+    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 | FPCR_EBF;
     env->vfp.fpcr &= ~mask;
     env->vfp.fpcr |= val;
 }
-- 
2.34.1


