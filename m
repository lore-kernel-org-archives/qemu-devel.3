Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C6FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTt2-0006zC-6e; Sat, 29 Jun 2024 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt0-0006yr-7b
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:46 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsy-0008Gp-J9
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:45 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso709112eaf.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651403; x=1720256203;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JoZEFutlkhBaaeS7Srf3QSHs/2P96eJP2zssQxT6y9M=;
 b=iuQ+8l99aDyPQ/d6H6/nOT7+wp6LkFxiESGBI6p9QZxLfI93M7B7U+wKxBxrUYkpj1
 q2F0mKaQa2ldO2pG1AY7YfseJp3RCFOK/N6Db002/SvFIclOzmfJMosFV8Z5KuMu1zO1
 gKhDKT5tO1ZyXPW4QIpjRF7xpp6GucRLWmTMzbqhpxe0BeFBM3zJg2CY6yoKVsxOwJht
 tjAILeoAPa9v2dhWYfwP0lgr65xuvwpPVJ0fPnhyyh2EJNjAT/k6/YefXRIZbbhOO8GV
 vWhmL0aNwKBVUUlBbbfdkLqXazvFXFp4//1lE2BEV5X5lUx2cpozJXc/d62Vx4TCVcir
 umZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651403; x=1720256203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoZEFutlkhBaaeS7Srf3QSHs/2P96eJP2zssQxT6y9M=;
 b=lUdZ76WLCJLRfdvoe+HyjX4NCtHWNxx0fRWMkNQWMJx7+P1H8vfdibFbSowNrdTH83
 4dkrIRek56a+B811BrY1VFM3VBtO2U5vruQu/GUYzFPXS/yqrrRukdgaMBKqOJ3k11bi
 6Co+aqrZKeeVz71aN8tTAiVP5LcJGAMdtf1FqU+cUwpddFBjGVtp0nGPrN2yRz91D6wN
 LoEoS4OHGZEdfeb7Gdyzr8DtgAhkgH2s4MvnOiQwtiITUTl/SLI6XaSAajmwPGF5RZ9N
 gRHB/ANadPkhhVJfCJX0MgVWTirDWYXKknC6fPy8KqribCdmVToBBABRd/E8hsYfq5ux
 6lEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKHpwOvW4Tk4b66QHB3+BCIBNt5c77JJgawATqSndmrawk75WD98+wUJALtd5HTR5HGLmQ5ZTrKGPfD302vKDt7GH+GcQ=
X-Gm-Message-State: AOJu0Yy+U8hCqlvvexuPcVJ49r4EaXU7OiuHQ7IODgwmFc4pxR4tR+Fl
 DO5a8e0DTj6SDuqfCzZOOzd8UZHXfr0jYKcvfofBse8VSWA7xcqMJ+nek2YsF04cvOvJUk8yPZ4
 qHnk=
X-Google-Smtp-Source: AGHT+IH7uod4cU1nnorN+UBUAj/YL5C6Ev6xxDPF4aWcN+NPMfKNyg68J4qXvy2EA8xjqzjdXYcLHg==
X-Received: by 2002:a05:6358:4327:b0:19f:4ca6:86c2 with SMTP id
 e5c5f4694b2df-1a6acf39c25mr59803755d.25.1719651403110; 
 Sat, 29 Jun 2024 01:56:43 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c91d3eb9bbsm2882725a91.57.2024.06.29.01.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:29 +0900
Subject: [PATCH v3 3/7] tests/tcg/aarch64: Fix test architecture specification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-3-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
specify it. Instead, the extension was specified with the inline
assembly, resulting in mixing assembly code targeting sme-i1664 and C
code that does not target sme-i1664.

clang version 18.1.6 does not support such mixing so properly specify
the extension with the compiler option instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
 tests/tcg/aarch64/Makefile.target | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
index c9f48c3bfca2..2c9707065992 100644
--- a/tests/tcg/aarch64/sme-smopa-2.c
+++ b/tests/tcg/aarch64/sme-smopa-2.c
@@ -14,7 +14,7 @@ int main()
     long svl;
 
     /* Validate that we have a wide enough vector for 4 elements. */
-    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
+    asm("rdsvl %0, #1" : "=r"(svl));
     if (svl < 32) {
         return 0;
     }
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index d3e739b566d9..0a527a9821c2 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -30,7 +30,8 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fno_integrated_as, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fno_integrated_as, CROSS_AS_HAS_ARMV9_SME); \
+	    $(call cc-option,-march=armv9-a+sme-i16i64 $$fno_integrated_as,     CROSS_AS_HAS_ARMV9_SME_I1664)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -71,10 +72,19 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
-sme-%: CFLAGS += -Wa,-march=armv9-a+sme
+AARCH64_TESTS += sme-outprod1 sme-smopa-1
+sme-outprod1 sme-smopa-1: CFLAGS += -Wa,-march=armv9-a+sme
 ifneq ($(CROSS_CC_HAS_FNO_INTEGRATED_AS),)
-sme-%: CFLAGS += -fno-integrated-as
+sme-outprod1 sme-smopa-1: CFLAGS += -fno-integrated-as
+endif
+endif
+
+# SME I16I64 Tests
+ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
+AARCH64_TESTS += sme-smopa-2
+sme-smopa-2: CFLAGS += -march=armv9-a+sme-i16i64
+ifneq ($(CROSS_CC_HAS_FNO_INTEGRATED_AS),)
+sme-smopa-2: CFLAGS += -fno-integrated-as
 endif
 endif
 

-- 
2.45.2


