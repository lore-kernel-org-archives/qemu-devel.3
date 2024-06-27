Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9709BC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpdx-0002Ri-9u; Thu, 27 Jun 2024 09:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdw-0002Qm-0J
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdr-0007r4-1l
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f9d9b57b90so53797765ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496704; x=1720101504;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=051823EgtBzstuD764vOjuzK26tAgdAGeHklAVfjV2g=;
 b=D//UMvRoNszHDuK0t5Dq5sUqDLsHOsBYwetXGfZm30X15ry6HFKxdCJAhfMukS1awP
 znSTx2wS75IbOZ6KkN4HyG4VjTMrVbB5xH2Jn83lrJ3S2BCg6wEpQtif52ivyKi6g+uV
 LHhdKjnXoiQj/7ZfNun2RrZ8v5eAy0zRtJGpH00Vw/nOticjphqqToPfrUKKbZ6r52Ji
 jqk5boTp42uDoWvhgXq8bZgFzf7y8lte8U6sAcxuRTokGlIaO0Qzpq9ju/hU8IySwYjJ
 Zng655rS5E8kqMmvLvNGaXcDw4X33FFVMqpDeMvdjEvujq/MIHsPgIwWDyGmSHWnFNZL
 guuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496704; x=1720101504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=051823EgtBzstuD764vOjuzK26tAgdAGeHklAVfjV2g=;
 b=hrqNeqYr2xzXX6kwEgzWPh1Q6ZU1IOGFqaAFChSymcXoigZrIg8BiUnxHJQYCatuD2
 HDm6lj0QTwqZVbWrI+m35n/l7yMXV6P/AXDzNgUzTwqcXONZohNimTASJzu2KBFmmQ3Q
 CY5V6vIDuRjRD5rr4qS9XZdgATjcXMR6c8/dTXG9yGZxzjAMWwuFL39LgYevfd6SzqiJ
 09cnmbX00Ojrg0mHabRzFUVi62pgvFn9TeDQqdVg+TPmNVHm86oY+s2YLCWTy6YDpVTq
 7HB1va1LsZ+VhM1McS0A+hV+9X2n8j740wUZ+B/6LPkvpJnTq/eek/qzun4W5pCj+5sg
 wngA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOOXHrdMdU5TLHMCWiLJMYOSw0wMrX5FYGNvp6/PG4UQWySeh0LVrF9e+jy0XCwECIqhOz1vbFDSnFQ6rnEQ2tDEL9vLA=
X-Gm-Message-State: AOJu0YzHVgjoGrQKzSjqdCxfHWQhksF0CtILbPjJlSNA3aSBjx7oFhYG
 eDBbNLHllB3ywnBbhOy45Ofp9vNs2IUGdq5rg2N3RjpHKFkxDw3Ql8OyNCDF/AY=
X-Google-Smtp-Source: AGHT+IGKtG2fWmDbLIN8gcv2F0slGqWgLtvmlKC3nv1h0XIdevBGkCeHMFkiB0A3o7EiLJ9nDf8XYg==
X-Received: by 2002:a17:902:6847:b0:1f7:123e:2c6f with SMTP id
 d9443c01a7336-1fa23ee5b60mr114181745ad.37.1719496703973; 
 Thu, 27 Jun 2024 06:58:23 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac99525bsm13437755ad.192.2024.06.27.06.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:58:04 +0900
Subject: [PATCH v2 3/6] tests/tcg/aarch64: Explicitly specify register
 width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-tcg-v2-3-1690a813348e@daynix.com>
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

clang version 18.1.6 assumes a register is 64-bit by default and
complains if a 32-bit value is given. Explicitly specify register width
when passing a 32-bit value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/aarch64/bti-1.c | 6 +++---
 tests/tcg/aarch64/bti-3.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 99a879af23d4..1fada8108d22 100644
--- a/tests/tcg/aarch64/bti-1.c
+++ b/tests/tcg/aarch64/bti-1.c
@@ -17,15 +17,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 #define BTI_JC    "hint #38"
 
 #define BTYPE_1(DEST) \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16")
 
 #define BTYPE_2(DEST) \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3(DEST) \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x15")
 
 #define TEST(WHICH, DEST, EXPECT) \
diff --git a/tests/tcg/aarch64/bti-3.c b/tests/tcg/aarch64/bti-3.c
index 8c534c09d784..6a3bd037bcd6 100644
--- a/tests/tcg/aarch64/bti-3.c
+++ b/tests/tcg/aarch64/bti-3.c
@@ -11,15 +11,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 }
 
 #define BTYPE_1() \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_2() \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3() \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x15", "x30")
 
 #define TEST(WHICH, EXPECT) \

-- 
2.45.2


