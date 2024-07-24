Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FEC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQU0-0003hn-4L; Tue, 23 Jul 2024 21:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTr-0003de-5I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTo-0001uR-4G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d153fec2fso2619826b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721783262; x=1722388062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tn7mhOOTb+dyTpB/8ysxMOxZiY5Mj1///H9tCKM6bo0=;
 b=PInf7IL2y20lpNaNtym63gMTHloqDiVBIObIZ1vb/loZrmYVvQFnT10aluqIZ43Y+N
 O/DVC49ALwnOhf00DSwzbIU6VUWRvfIEfIR3UP3xlQ8aBnvdVdsbe2W+64ag7LoaU5QH
 k+9INza0do1d/oL3AnX5RWxUTieIjRR4i+awrLLMOSPBDf2nqFbAmnxyIjovaD/RsbhS
 faebBHEgw0DmXutqw/Omp1BL0Npa46nRGBLdjFkcMO5L6C2SJmanR7wVtpXEThTdpOA5
 ZC9WTe8WCbq2iFOlqCQhQqqkM0ifbFeOfdpqDMXFt7AtWljtQ7yqSLCNiY7doUZC9fYp
 gr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721783262; x=1722388062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tn7mhOOTb+dyTpB/8ysxMOxZiY5Mj1///H9tCKM6bo0=;
 b=QKXolPiaHikXLP/d++UN28qQEVTM0D/o2cOh1dj42ICr+IxUAdKNGRfduhD3u6uLFn
 tJhYox16eYeoxSC3xCLqha2IBGVy4ojEvr/AJ6GEYpfWLyH+2FW16UyP6GanCZDXHCHR
 L4c4qdEJmQo8P4dRbyK4IXw28snflApxwkvwhJFw0mxEdY9wQhqRowlX+tIMnCxZgL+d
 FyFWgxGHENhyWK/73W2X+j+RROziONluRU6T1l54lVIh07Q/TUID1p2xiTYSI/XGukKj
 x1gbbLKu10NwVDCsK4hnrkJLHo2JsnuKgLVHLjZffug1m8QRY0UkMwqcZzrUVjVO6Adg
 Q2jA==
X-Gm-Message-State: AOJu0Yx92I9qBnCIGbH5dT2sFLIZE0VFwW6BzJYK03DpM22PPhAR8pCR
 Puzsh9UpWyl8G6jLdAF4MIwCcNwPZd3/LuSMqf9UG8xV1ekRrbfWRGM4K6DlhQ5HlsTZlCmZsRE
 Okpj2CA==
X-Google-Smtp-Source: AGHT+IFVjJaHzx/LDlnb+6n1o6tjCkwtCmwgYMcIiWcLBbOeEsj7tT39mvUadamdJVGyy8mZh14+cg==
X-Received: by 2002:a05:6a00:138b:b0:70b:aa7:3232 with SMTP id
 d2e1a72fcca58-70e997119a8mr1822888b3a.27.1721783261636; 
 Tue, 23 Jul 2024 18:07:41 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0e6c947esm6961093a12.74.2024.07.23.18.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 18:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 1/2] tests/tcg: Use --noexecstack with assembler files
Date: Wed, 24 Jul 2024 11:07:32 +1000
Message-ID: <20240724010733.22129-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724010733.22129-1-richard.henderson@linaro.org>
References: <20240724010733.22129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Add the --noexecstack assembler command-line option to avoid:

  /usr/bin/ld: warning: boot.o: missing .note.GNU-stack section implies executable stack
  /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

which is enabled by default with current debian cross toolchains.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile.target                     | 2 +-
 tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
 tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
 tests/tcg/arm/Makefile.softmmu-target         | 2 +-
 tests/tcg/arm/Makefile.target                 | 2 +-
 tests/tcg/i386/Makefile.softmmu-target        | 2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
 tests/tcg/riscv64/Makefile.softmmu-target     | 2 +-
 tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index cb8cfeb6da..1f8e5b3d30 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -115,7 +115,7 @@ endif
 %: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 %: %.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack $< -o $@ $(LDFLAGS)
 else
 # For system targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index dd6d595830..139e04d15f 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -28,7 +28,7 @@ config-cc.mak: Makefile
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
index 09193a62d6..a0eca4d6ea 100644
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ b/tests/tcg/alpha/Makefile.softmmu-target
@@ -22,7 +22,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 547063c08c..b66074b0b4 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -36,7 +36,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(ARM_SRC)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 8e287191af..06ddf3e04f 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -25,7 +25,7 @@ ARM_TESTS += test-arm-iwmmxt
 # Clang assembler does not support IWMXT, so use the external assembler.
 test-arm-iwmmxt: CFLAGS += -marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16 $(CROSS_CC_HAS_FNIA)
 test-arm-iwmmxt: test-arm-iwmmxt.S
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) -Wa,--noexecstack $< -o $@ $(LDFLAGS)
 
 # Float-convert Tests
 ARM_TESTS += fcvt
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 5266f2335a..4096a1cf31 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -25,7 +25,7 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
index 908f3a8c0f..d5d5c1a7f6 100644
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ b/tests/tcg/loongarch64/Makefile.softmmu-target
@@ -22,7 +22,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index d5b126e5f1..7c1d44d3f4 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -10,7 +10,7 @@ LDFLAGS = -T $(LINK_SCRIPT)
 CFLAGS += -g -Og
 
 %.o: %.S
-	$(CC) $(CFLAGS) $< -c -o $@
+	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
 %: %.o $(LINK_SCRIPT)
 	$(LD) $(LDFLAGS) $< -o $@
 
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 4c8e15e625..f60f94b090 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -6,7 +6,7 @@ CFLAGS+=-ggdb -O0
 LDFLAGS=-nostdlib -static
 
 %.o: %.S
-	$(CC) -march=z13 -m64 -c $< -o $@
+	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
 
 %.o: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 1bd763f2e6..ef6bcb4dc7 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -25,7 +25,7 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-- 
2.43.0


