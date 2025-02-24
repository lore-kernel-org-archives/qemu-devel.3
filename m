Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD11C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2h-0006tk-1W; Mon, 24 Feb 2025 12:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2f-0006tL-9z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:53 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2d-0005XP-K1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d132f16dso72140425ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417289; x=1741022089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOLV2f1+5SpreY+ykl9+JCvQNpcdVrqJeVor++6cQm4=;
 b=S1+9r0wKDVVc8kKR9XAFd9vd9fVZ3rkzOE5FfxR/r/lUVPwfKm6DGc89mjyS5X0t49
 VdWzJsqcdZz1eJ7pbKKK08wbbVqcp0Fol12Z8aqJ3VtePSx5Lus85fNti6YA0bhOIckg
 rfk2prglc3Fuo/RDAuj0NmEiPShaJQCcSfFnsySo4eslgfqiwOruOXvP+4OR2JdkiEeG
 sskunUiwhtsD3GyEryd5bR8PxzQG0RjCagZe/e50XDkuvM8a4bPaQ5uoCrHQJq/p0wHT
 2wv1tBC+wScsi8dw8tTe23/jhPDbTbwYueBedMjSG9lRsHLkav+h/gwEmq3ln9Db3Ocr
 255Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417289; x=1741022089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOLV2f1+5SpreY+ykl9+JCvQNpcdVrqJeVor++6cQm4=;
 b=GAaanz2UILLyXBv8lO29J4/wsPRdaGYBQ38HFpbr8EZvd9CWiKaRsWOrRASdFJIQ9g
 7H5JD+/NkbV7boPd2qRNm1nUTUhSRR49TW6AT+ZaCGJud0woulc9sPAu0V2QOuDa6Ngu
 qeGuNLy5qLZIuhm2zylz/H5EXRy/Id8bwQxpOSRwvVBVPxBd4C9iP+3wCLtyw+UykM53
 g55BLC1RlMzEaZxw7CI8YXVUZzQbn1gto2daIjYPoIeqmxVqRhoYyd3GpVV5WQ2I/DZ4
 q9gfiwIgX35NBSotLZgZLDd53xm0mvNQVSuE8bVlLzktOxVt7UZMtubLK+k+SBn/5dIS
 Tuzg==
X-Gm-Message-State: AOJu0Yw4qMy6/ID/eeCRw17AJQ1j+M9Uj+Euds5pxMB5WAI8CF6D+Kcc
 52LANZTG5tY/4aIHDoT9JjAvUWOwisBF/1bh3oTSRs/OSL15mSsy8Z+l04d3Wdv8SurnBpdbkiX
 O
X-Gm-Gg: ASbGncsen1O/FERUT86Q/y7n8xbNMBuVVcQNTHSwWJTTuXRuA7yBbJKKzJhry10epZH
 eESwwO+7zzoOsKr0lnjTpidp83i4Ye8kjiT/lZzM/4Ay16z93JbC/oNAI5V/UMMK55VJoLhVSNY
 vq4vR72zduahmOXUoDa0CjUCUkjw2M7tiIJNcyWTLoieqV69ZX07tKRP4YOlY2FJCqcUMj0voRT
 D12K6FkuyeS5XR+jBx/dlgcKcAxXSSLGm85ojwT8KGL61KzbK2d3gq+KXGCpl/bB8JyDck16p9S
 2LLnSYoOju6r3EX/ELJJOGPb7kW37ZBAPmY=
X-Google-Smtp-Source: AGHT+IFsB+EAIhH2SziVeYdwL7WDfZynZwFZ2Xed/HWZyxoufl3wMu/RhVBM1+kKiJflkAZtVaT8ag==
X-Received: by 2002:a05:6a00:4649:b0:730:9567:c3d4 with SMTP id
 d2e1a72fcca58-73426c8d910mr25620186b3a.3.1740417289384; 
 Mon, 24 Feb 2025 09:14:49 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 01/24] target/m68k: Add FPSR exception bit defines
Date: Mon, 24 Feb 2025 09:14:21 -0800
Message-ID: <20250224171444.440135-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h        | 21 +++++++++++++++++++++
 target/m68k/fpu_helper.c | 22 +++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ddb0f29f4a..e26d416bf4 100644
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
index 339b73ad7d..a6d93ff325 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -170,19 +170,19 @@ static int cpu_m68k_exceptbits_from_host(int host_bits)
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
@@ -192,19 +192,19 @@ static int cpu_m68k_exceptbits_to_host(int target_bits)
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
@@ -214,7 +214,7 @@ uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
 {
     int host_flags = get_float_exception_flags(&env->fp_status);
     int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
-    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    int except = (env->fpsr & ~FPSR_AEXC_MASK) | target_flags;
     return except;
 }
 
-- 
2.43.0


