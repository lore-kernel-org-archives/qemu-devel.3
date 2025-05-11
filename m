Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDB4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOr-0002RP-Q2; Sun, 11 May 2025 16:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOp-0002Mv-Iy
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:51 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOn-0006Jq-Uh
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:51 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b1ffeda9363so3702360a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995748; x=1747600548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB6EucikZ5GuyLdpQZhqymhWhSSzXHh0jGDVun/Y4xc=;
 b=zhh1IyzXEV44Uz6hMZ5bxG4yd/QGJqTQgWpQJ/maWEQ010bV7NUdEXkiQN6sx8v2sS
 57QNuJBnyzCqvdHatZwiCbQ1ldj6Jr3ThTIrRJQ/0pNCDYbabXt07AQ+jMX3Er9Ke+ip
 XwpV4pmV6CvaLrzmIlp6bHRpSTGPmW0O5NL1uskBf2BXMYZuKHeak1sYUyI26LT4YylY
 wHh0dL1uE4J4H1jL0XYm6N4kq426X1jpEcY1k01vPyEig6lumHKclR0Mf/E2N0+Hw64i
 Wwn0EO9zG0RusmEDQjlPJZjDnWPYgCycuSYjAqVsaTeBcp2zNPGrcOL2exwXq9y/xrrl
 3//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995748; x=1747600548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB6EucikZ5GuyLdpQZhqymhWhSSzXHh0jGDVun/Y4xc=;
 b=UagJ6esx00UoQS+sxXqg/2fQcQdcjpwNPv0Z9bo5sXhheN1bNunY2FhvfiUcMWzNAi
 urNxfRwNsM4QvjFqKeCmcayecR2KGaXoTPbQACVSV6WhR1kseTwKnSS1k/P2X6bo9K9/
 icoPil9Td4hK4nJpQn6DUckPhIOzwx5g07v6m2B75dUcxvtCng/MQOrWxUw9A6sZLVMN
 zcFD8XyY26R20elMnWghBB0d7h1Rc4NigKm+rh0uJVIfahqWpm0tR2E6dyus02JJqFP0
 jy3pUJiKFWdOJUn6c9meDGfex9HNFonFOk7053GxMNo3o/oTQJJVuV9daG5syeL1hh4D
 LyDg==
X-Gm-Message-State: AOJu0YxKdseZOwAKhqlqWcNnhmqcIoiog4S86MX1xaQUeEIO8B4o70vI
 a/YZhYysi2v+I3YleDAf5JNmqSH/1QeQHYMFWys7HJpzDegu2FNDm8NtP9N4RF2sC/UOaWhHEYg
 f
X-Gm-Gg: ASbGncvTXdUhrOodeU3CQIpF0/MEjnHj6nRpHnIHxSwHIveWYaEwJSH0kEiXdduRKW+
 0TqVHmcrCjcyZISNdhu3m+OT83dDZqXxzarpQIpr9Jrgz4300/09p4mQoAMkYCdWvHQPs0fF/LH
 FMDKWizIcXLNG0z+QRfiqU4lfCXHx6FH1cajPUvjkYkBnMbNdDaRb1e10HAHpp0h+g9C5WaTe3E
 eqKSPmfoJcXJb5X6MxsaIEXQPzlrlAaCoLYh4Pxq70Qsoba+nLP2KwudnfSNwbBOSMwlbRPtWsR
 ej1dfPJc1Wm2u7B3WLHdlmW3+VgMSwaOnMk0dMf96nZjLPo6tXZvwmIuecKY91DXDzQu/UucUTP
 RD/swHMnOHQ==
X-Google-Smtp-Source: AGHT+IEk/n5UcAvxhZ8PGayS3sCaBCYHQrXw1JxvEfI6IEhrspO6ExCo75lUxK5h1FVTHlK/wP0LGg==
X-Received: by 2002:a17:902:f706:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22fc8b723ecmr185364515ad.19.1746995748584; 
 Sun, 11 May 2025 13:35:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 01/24] target/m68k: Add FPSR exception bit defines
Date: Sun, 11 May 2025 13:35:23 -0700
Message-ID: <20250511203546.139788-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h        | 21 +++++++++++++++++++++
 target/m68k/fpu_helper.c | 22 +++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d9db6a486a..035034772b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -442,6 +442,27 @@ typedef enum {
 #define FPSR_QT_MASK  0x00ff0000
 #define FPSR_QT_SHIFT 16
 
+/* Exception Status Byte */
+
+#define FPSR_EXC_MASK     0xff00
+#define FPSR_EXC_INEX1    0x0100
+#define FPSR_EXC_INEX2    0x0200
+#define FPSR_EXC_DZ       0x0400
+#define FPSR_EXC_UNFL     0x0800
+#define FPSR_EXC_OVFL     0x1000
+#define FPSR_EXC_OPERR    0x2000
+#define FPSR_EXC_SNAN     0x4000
+#define FPSR_EXC_BSUN     0x8000
+
+/* Accrued Exception Byte */
+
+#define FPSR_AEXC_MASK    0xf8
+#define FPSR_AEXC_INEX    0x08
+#define FPSR_AEXP_DZ      0x10
+#define FPSR_AEXP_UNFL    0x20
+#define FPSR_AEXP_OVFL    0x40
+#define FPSR_AEXP_IOP     0x80
+
 /* Floating-Point Control Register */
 /* Rounding mode */
 #define FPCR_RND_MASK   0x0030
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 56012863c8..3e35c20be3 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -169,19 +169,19 @@ static int cpu_m68k_exceptbits_from_host(int host_bits)
     int target_bits = 0;
 
     if (host_bits & float_flag_invalid) {
-        target_bits |= 0x80;
+        target_bits |= FPSR_AEXP_IOP;
     }
     if (host_bits & float_flag_overflow) {
-        target_bits |= 0x40;
+        target_bits |= FPSR_AEXP_OVFL;
     }
     if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
-        target_bits |= 0x20;
+        target_bits |= FPSR_AEXP_UNFL;
     }
     if (host_bits & float_flag_divbyzero) {
-        target_bits |= 0x10;
+        target_bits |= FPSR_AEXP_DZ;
     }
     if (host_bits & float_flag_inexact) {
-        target_bits |= 0x08;
+        target_bits |= FPSR_AEXC_INEX;
     }
     return target_bits;
 }
@@ -191,19 +191,19 @@ static int cpu_m68k_exceptbits_to_host(int target_bits)
 {
     int host_bits = 0;
 
-    if (target_bits & 0x80) {
+    if (target_bits & FPSR_AEXP_IOP) {
         host_bits |= float_flag_invalid;
     }
-    if (target_bits & 0x40) {
+    if (target_bits & FPSR_AEXP_OVFL) {
         host_bits |= float_flag_overflow;
     }
-    if (target_bits & 0x20) {
+    if (target_bits & FPSR_AEXP_UNFL) {
         host_bits |= float_flag_underflow;
     }
-    if (target_bits & 0x10) {
+    if (target_bits & FPSR_AEXP_DZ) {
         host_bits |= float_flag_divbyzero;
     }
-    if (target_bits & 0x08) {
+    if (target_bits & FPSR_AEXC_INEX) {
         host_bits |= float_flag_inexact;
     }
     return host_bits;
@@ -213,7 +213,7 @@ uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
 {
     int host_flags = get_float_exception_flags(&env->fp_status);
     int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
-    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    int except = (env->fpsr & ~FPSR_AEXC_MASK) | target_flags;
     return except;
 }
 
-- 
2.43.0


