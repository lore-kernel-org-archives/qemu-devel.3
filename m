Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A38AC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcd-0008Gk-0U; Tue, 30 Jul 2024 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcb-0008BG-Ki
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:45 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcY-0003Wy-GU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso663999666b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356561; x=1722961361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o53zhyLHN7aZhlmeir/x1yyb+LIZzMpKweMU3c5VOlw=;
 b=Bumw/CXlJEbRZPa47vIYE7gVZlX6L2cTC2RBe3FS6AC56TlFzN3Wp8xEwFbUmP7WDa
 pF5g1OkFEUd0Qfqv4ltRHlwrtOJli6RblWg3idyc8YSj4Dmgbo6o39zCsiP7VoC+liou
 j+HogPK7q2stvNoOSCOO/mTSM3w79Jom84RZFul8Gs1HfIXdSFK6duClKDdYeablY3rj
 fdAR70hZRexmxrQNRe44zzzulEZweY8nJUkxmlpX3fY+2sc8gVEcBelmtZ/UnP3ELYVt
 ewfpvyC1bVi9XqwHwZP/Bl2sfJKVEvDYTbIrlx+M4Sm4z4WR6NfQ4nyf/qwW2T/grdb8
 0LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356561; x=1722961361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o53zhyLHN7aZhlmeir/x1yyb+LIZzMpKweMU3c5VOlw=;
 b=gPyIjT6cT/Juaitsd2Mv84iflIdtGdxNj7cz5qJaeZYCTK3oOfYlgbz4U1Kc3piEib
 aXltyYJaG4jKe9jnajm9kztWw6u/rODdGMR4Rau3/UGQ1pK25fK66qzuhn5rhKVf2AHE
 q4cnHDdtQ1anBTynMM6B+K74LHOYR0JWGC/YIRkj8CrASaUYmusbX1HLzOaVFt+eBYhc
 2qWXeDVeurbxh18yPNOJb1nd3Rz95bhO86TkPB4qHimCX4WtxXwW7wPs6qeV50+GHiG5
 KTpgR1RZetpyhPERzdFI8o0bRvPZ8vwHlWEXCS08LTam4DZ7JJfmM4OXhIwWSMNeoJQL
 6Lyg==
X-Gm-Message-State: AOJu0Yz3tjtDgWecyY5TGJgjAxVbOJqnyNmDnw4N8F19aIbBFGdmsium
 ZZTsqgsTW2D6EsW/xiDEtAntTCeFdGkI0510O34E+hbG9g8Q+EPsVMlH45i2spA=
X-Google-Smtp-Source: AGHT+IFj0qEgnWwdWL5r7M2qhFzK8XTcqLWkgCc5gALWAuxDTdfcXcVuZ/cG1iSEgxseX1W90lJIVw==
X-Received: by 2002:a17:907:9443:b0:a72:633d:5fd6 with SMTP id
 a640c23a62f3a-a7d400adb62mr737614266b.32.1722356560275; 
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41621sm660753866b.113.2024.07.30.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27DC15F92D;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 03/14] tests/tcg: Use --noexecstack with assembler files
Date: Tue, 30 Jul 2024 17:22:26 +0100
Message-Id: <20240730162237.1425515-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add the --noexecstack assembler command-line option to avoid:

  /usr/bin/ld: warning: boot.o: missing .note.GNU-stack section implies executable stack
  /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

which is enabled by default with current debian cross toolchains.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240724010733.22129-2-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-4-alex.bennee@linaro.org>

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
2.39.2


