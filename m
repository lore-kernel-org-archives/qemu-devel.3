Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B52C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4i-00067z-Ue; Wed, 07 May 2025 17:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4h-00067d-Hl
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4f-0006BQ-NG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so412035b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652383; x=1747257183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB6EucikZ5GuyLdpQZhqymhWhSSzXHh0jGDVun/Y4xc=;
 b=UpDeYeLufcK1XHD3IP/nR5NEgMOka0aE727s7XU0M+JUhYvP8nPxFOqglE0S75mxyy
 HRKU1HKwvLZ4CRZw6sCEbGJjGeu+Bx9/iZDd6fN4VSA7b5ZTDPYtvvZAzX7rPTllyJY2
 2lsaSWPdLlPJVKOd0o4I3OniVLkkMJ8SJLJcPoQnY24UtwRkosL2qIkeMdbSpZ+C8BJB
 dF4G8wGxHVelQjQFcWjAsuQcDaX7lbfEEca0TXtAH6b4L2ZJaPuFKcX8UwnIHHIEX2DP
 W0yes+iXZPsl6z5zB17m1gTPeNHV4Rad9ySd4dRay0uGM/7rnC36HPRn5tpW75qjFFfc
 m4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652383; x=1747257183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB6EucikZ5GuyLdpQZhqymhWhSSzXHh0jGDVun/Y4xc=;
 b=PFLx1ffR6D7zm/3h1HYCLmlXkHlrh3IizvQjyaXVJCYewEEDfXWOXU2JhM3muI1EcJ
 ZQkvwjXfiUXwhm2NMbj73SmnPHducypSwKuyD1OyUsnzzK6PsHEJMtqK0G/tPdFHhfDD
 L88YZCjhlF45i82JvKFl677yUF+oY+GzptTg60Wpwh9WF3hWyGWUnEk0e7nL/ymhr0FO
 6635IH9Yws3hzA1QeNuayUcgNsJ4oK4GhSlOgkF/3fov57QI4w6sRM006wlizazoiKPC
 lU3f8BWueO+hcNOPDfY3z5EV+0lHlDM9U6g/EZ/ObFfHetbYehoLtvhgXEK9VtlzknqE
 Dd1w==
X-Gm-Message-State: AOJu0YyVTMBF6+0a+BjC5TVRxUE4wbA2zsLLQwHe/BdslZa0U60KJex3
 RQ59Zoetw7qreDe6xTGlwJjNO6MLLytcfeEvLlHEDjQwgxRkstR52YUhHg+v+encufx3gFfZi4J
 8
X-Gm-Gg: ASbGncuvo07P4ZqlbsKb4okcIba5xxAGFFUUdjiJvBotD4/y1pqQWCEwQoAD5uqsX/e
 2Ww4AXr38y+OwLLM0CJ6KvYpRRI2n+SEkzi/iDixNKDnTs7gdiXcBFeezFiydJ48hGra8xkJzLt
 ixSULkYtHmdwK8MiKLBl/L+/52Vl0wpA6r19TaxY1d3FbU4ojIAtu79EAOYQ/4Y66+jzN/FEMwr
 fb30AHigtEHH7IfKX4JY9JvAIs9lY/L5BSbkQnQx3RddGJHcu9e+JtXO3i8F2PPT3hnDQPSGgc/
 Pf/Grvpd/w040m1Zc8gmWj6R0m9Tj7uU1OU5VXGe4lmL4vleAPY6zKF882kuKfkrjCZKKWjkP3c
 =
X-Google-Smtp-Source: AGHT+IH6Yfv/FYFubasCFgdubRQnY7RgzHD/Xno+8/f+CmoUryI4c2DeYJ3hs3sG8dB5sDtZva3MgA==
X-Received: by 2002:a05:6a00:1414:b0:740:a921:f6de with SMTP id
 d2e1a72fcca58-740a921f777mr1643998b3a.23.1746652383080; 
 Wed, 07 May 2025 14:13:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 01/24] target/m68k: Add FPSR exception bit defines
Date: Wed,  7 May 2025 14:12:36 -0700
Message-ID: <20250507211300.9735-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


