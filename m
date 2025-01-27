Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2148C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNHD-0006sK-EN; Mon, 27 Jan 2025 06:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNH1-0006qe-7a
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNGy-0002vE-W7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2174668f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977239; x=1738582039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wy91VbHhEjATQmoRwLMo5JHfC5QFQNnnXcOC8jZC3LM=;
 b=OihiVa5PHH3LIobOZjgqsgRRrYAiSTvUc9D4BpykVvPyP3oEW+YePeYpwa6nCqQbBC
 hSewMaWrnLoR/JQglOOyylbkXcrONUgAJuSvaQsWzVM8jkUpFG6owteuPrm4lRJbeOwT
 htandbDVsgLSn71Pu6MNo+0ElNsvliptPPUakRqi+IhPRfwk/yOSp0KVVd+YEKiU0Dv2
 JWcb2rMrKrPQoO4ssSaxnEIGQiVnu9GnVsUZaOo3piA/71L8BnXoFCji53TY7+imEYyn
 8kUpdP6I/AM0mOhGZDI9YcbeRmbJQmrhnl3HeYxuzgj5rZhUZAq4vUzBF/ldjrNIV743
 6txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977239; x=1738582039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wy91VbHhEjATQmoRwLMo5JHfC5QFQNnnXcOC8jZC3LM=;
 b=WzjkS9+Q4ca9X35XNYRCToCeY0CEERJhvs1GfTll1SqpcIduFMxbMTCsF67fedfqbc
 pqEdUxSqm8lLzVXyvMGGE4mH/4hGbmedpr+A0xolmA4jTG/dOp8Uk6Zg+VpDX1Eu+Z+O
 nGSacPwNSccbUKpFUoCLF1RXlZCYBwAC81tzq1XGuCq1z8vYsdyWTTreS3GWgQzvZesO
 FL0BAxcLvfwMj5mMbwCz6TGugLGlG+QjcMkURA9Qk78b86odM4ZmEGCV1qk9wXaCWsDU
 1Z1/SKLoCsagDo13fZ2IginG+aW7ICekWred8Zfv/mxKRfsJfhTk3ohzX++o9MhjRNVU
 hyEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLwzqa50TvHS7GUygbmtpr6E91UDOrxTI1P7NBVKllV7YXa31li5aahJ232QNofPcibJ08xu6b0jxi@nongnu.org
X-Gm-Message-State: AOJu0Yzi51aIYeQm3s1Q62F6pLGB6uR8HmYaTxI0FtT79Wv941q/w28J
 P8nq522mCjX2/XgAFSg6hEqiuYd9xjg43R977SaOWAyggp2vA3I+spWiZ9rxS7w=
X-Gm-Gg: ASbGncswmxUP2kI6KAGiQCxpX42kCfsvoJIJg3ermYlbmF2EkIuIemkLuf2BagKlTUG
 vkN1rAWoLXWXsNd+RYuAvuYe+XBTLdNXYo1qUeTun/xwtO/oI5XuhHTKUVj8gdDDxFFiN23WJqR
 US1wZWUbLUgArdXIKANJLzBMwzD5PSKYFNlGJl8u9ei40QtXhCxemoKy/MxPi4ylJrakBz8qQtO
 PzdH3c6M9fh/elai9rSYnyqehLvQzbbilXnkSwcTFDKP+hO8zOEu9xEJ57KHJoQ5sGxNclJwgA+
 9Pnl1vbKGlzSEQvWrV3T
X-Google-Smtp-Source: AGHT+IGOkFuRg5l1Wz33lGgDoEnRvkEmREnYsW5iV2iEkkd0gPva1aE92mSp+sVsYsSbtLZiXDcw6A==
X-Received: by 2002:a5d:64e2:0:b0:38b:ef2b:422 with SMTP id
 ffacd0b85a97d-38bf57a9615mr32446944f8f.36.1737977239487; 
 Mon, 27 Jan 2025 03:27:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176449sm10925329f8f.11.2025.01.27.03.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 03:27:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/tcg/arm: Remove test-arm-iwmmxt test
Date: Mon, 27 Jan 2025 11:27:15 +0000
Message-Id: <20250127112715.2936555-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127112715.2936555-1-peter.maydell@linaro.org>
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The test-arm-iwmmmxt test isn't testing what it thinks it's testing.

If you run it with a CPU type that supports iwMMXt then it will crash
immediately with a SIGILL, because (even with -marm) GCC will link it
against startup code that is in Thumb mode, and no iwMMXt CPU has
Thumb:

00010338 <_start>:
   10338:       f04f 0b00       mov.w   fp, #0
   1033c:       f04f 0e00       mov.w   lr, #0

If you run it with a CPU type which does *not* support iwMMXt, which
is what 'make check-tcg' does, then QEMU will not try to handle the
insns as iwMMXt.  Instead the translator turns them into illegal
instructions.  Then in the linux-user cpu_loop() code we identify
them as FPA11 instructions inside emulate_arm_fpa11(), because the
FPA11 happened to use the same coprocessor number as these iwMMXt
insns.  So we execute a completely different set of FPA11 insns,
which means we don't crash, but we will print garbage to stdout.
Then the test binary always exits with a 0 return code, so 'make
check-tcg' thinks the test passes.

Modern gnueabihf toolchains assume in their startup code that the CPU
is not so old as to not support Thumb, so there's no way to get them
to generate a binary that actually does what the test wants.  Since
we're deprecating iwMMXt emulation anyway, it's not worth trying to
salvage the test case to get it to really test the iwMMXt insns.

Delete the test entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/arm/Makefile.target   |  7 -----
 tests/tcg/arm/README            |  5 ----
 tests/tcg/arm/test-arm-iwmmxt.S | 49 ---------------------------------
 3 files changed, 61 deletions(-)
 delete mode 100644 tests/tcg/arm/test-arm-iwmmxt.S

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 06ddf3e04fc..99a953b6671 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -20,13 +20,6 @@ ARM_TESTS = hello-arm
 hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
 hello-arm: LDFLAGS+=-nostdlib
 
-# IWMXT floating point extensions
-ARM_TESTS += test-arm-iwmmxt
-# Clang assembler does not support IWMXT, so use the external assembler.
-test-arm-iwmmxt: CFLAGS += -marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16 $(CROSS_CC_HAS_FNIA)
-test-arm-iwmmxt: test-arm-iwmmxt.S
-	$(CC) $(CFLAGS) -Wa,--noexecstack $< -o $@ $(LDFLAGS)
-
 # Float-convert Tests
 ARM_TESTS += fcvt
 fcvt: LDFLAGS += -lm
diff --git a/tests/tcg/arm/README b/tests/tcg/arm/README
index e6307116e23..aceccc127f7 100644
--- a/tests/tcg/arm/README
+++ b/tests/tcg/arm/README
@@ -4,8 +4,3 @@ hello-arm
 ---------
 
 A very simple inline assembly, write syscall based hello world
-
-test-arm-iwmmxt
----------------
-
-A simple test case for older iwmmxt extended ARMs
diff --git a/tests/tcg/arm/test-arm-iwmmxt.S b/tests/tcg/arm/test-arm-iwmmxt.S
deleted file mode 100644
index d647f9404ae..00000000000
--- a/tests/tcg/arm/test-arm-iwmmxt.S
+++ /dev/null
@@ -1,49 +0,0 @@
-@ Checks whether iwMMXt is functional.
-.code	32
-.globl	main
-
-main:
-ldr	r0, =data0
-ldr	r1, =data1
-ldr	r2, =data2
-#ifndef FPA
-wldrd	wr0, [r0, #0]
-wldrd	wr1, [r0, #8]
-wldrd	wr2, [r1, #0]
-wldrd	wr3, [r1, #8]
-wsubb	wr2, wr2, wr0
-wsubb	wr3, wr3, wr1
-wldrd	wr0, [r2, #0]
-wldrd	wr1, [r2, #8]
-waddb	wr0, wr0, wr2
-waddb	wr1, wr1, wr3
-wstrd	wr0, [r2, #0]
-wstrd	wr1, [r2, #8]
-#else
-ldfe	f0, [r0, #0]
-ldfe	f1, [r0, #8]
-ldfe	f2, [r1, #0]
-ldfe	f3, [r1, #8]
-adfdp	f2, f2, f0
-adfdp	f3, f3, f1
-ldfe	f0, [r2, #0]
-ldfe	f1, [r2, #8]
-adfd	f0, f0, f2
-adfd	f1, f1, f3
-stfe	f0, [r2, #0]
-stfe	f1, [r2, #8]
-#endif
-mov	r0, #1
-mov	r1, r2
-mov	r2, #0x11
-swi	#0x900004
-mov	r0, #0
-swi	#0x900001
-
-.data
-data0:
-.string	"aaaabbbbccccdddd"
-data1:
-.string	"bbbbccccddddeeee"
-data2:
-.string	"hvLLWs\x1fsdrs9\x1fNJ-\n"
-- 
2.34.1


