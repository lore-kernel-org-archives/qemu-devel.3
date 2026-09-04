Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8077CC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tas-0007cF-BO; Fri, 04 Sep 2026 09:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta8-0006VW-LX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZz-00039s-4x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so10349895e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527017; x=1789131817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cpw/0nKRaRtkPe8d98ZT7Q/KRUMuuy/+CYtAA+zakI=;
 b=XOkpc4oxqnezmQw3KNI5hAVMcAy3AcKsLAAAhKMQZyTbCC0YnB1FSeQnbbWROWP+dz
 XPUPqJSAo0PZAnqOPthdUXD4AQz8XeWHCW1Gct7Z+RKBmvkM1B9AUhJ81QEFjNlPhqhm
 jH1SsHUt8wVrGTgNfuYT2FZGjuK3n6KWl0+H6b1IZM9Lq0r4/2xhjnAOY5DBEDQ4B8vr
 mDXOw1pKPmsj/4YEG7VIPf4o6Kec/quHTTlZspxRXyGEcqFQ+zMrsglXRYzTVSjGDdkB
 lsMtEuqXoudbqSYBsmFkYNtMisa4TVXW++hXFUeN/Du+yzQoq9mPlCNTQ9kL5bIUySw+
 rHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527017; x=1789131817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cpw/0nKRaRtkPe8d98ZT7Q/KRUMuuy/+CYtAA+zakI=;
 b=srjTXGd+r6P+sCdMeSOhTLREqvGDFtDa6+Co/nU+1buiH72mRcEH0T0xznFe+OCIK5
 I9e5/obKgMn+qGCEtSsQXistXbqtTa3vNrblab/hm+bGWessqmxnUoNOFZsofw9vCqOO
 QwHUY4Jg2fIoCyqmK7XlxtON41dwBFC152SDbeLyP7LkGIM6EP1ZX2gjL49X6Ahzjv51
 wnCMqTYf0eYU0QVe8TWnm0O1xBcenOlx2nYbTcg2u1vBBHgNnpkeE4g1F6mxIYpHnI7E
 UFjkPdf+PZVqjKqamSUnGXPjgvLIGTcCMbJZGl5ntUnS3JsGmIzB95KTe5tGE/Shi42g
 lIHg==
X-Gm-Message-State: AFuF++kfy3ZOBmJXfjh1dlJkMf72DFMawyXc2mGdI671cYtSRTjuR1HH
 RG0MBllPHyT5ryA1jsUyUviI0K958ZZc2Z+w4iR3rH4yCgHMDz8xDgt6iqnQF3rTjYQ=
X-Gm-Gg: AYBFou0vvo89O5IcxSwNKLfv+HApQAWdqzR4Pnnruiz8ueyePO6TJoASHwBkCcY2E6L
 XyL2ZoKE01clhoDoDl/8BIRBfqtKdY7rkBUpM8HthXDQO4Kw5OrfBHuXAIzmzPXM0PxsiGxve2E
 /0H9njZGmUI9TbCvutixGWKDX121yZf6AsHG5MTncyY5UbX+Y9n0PoaBZjVzytDK1PqCTwOI3tR
 /toj917t41pl8aVp5UfPT7+H1KDuMweHZwEIEdNELmBiFa6t/1jzKOTzNJ43CO1Le/Gc4ou+3u4
 G8lFb9nBX8NIz1f/Lj4J6/SaDg35vZSZgVSDIYUjyzUBe12Kj6Ar4VAdXxsIfc6FoUZqxYbicGQ
 +/CZSbrvM+sMFE6l/ODSws157tPgKjJ2yJCRErj9qJXWe9rNnrmRJigLY4qpryZQhnM2Y3lCdT2
 pK+wy1djn9EPjviUWqxEd0QbDK4cUqes9kbwHMuDjchZNtOiweb0MPKg3s2DAEIMBPy1QxcvE=
X-Received: by 2002:a05:600c:4e8e:b0:49c:dada:f57f with SMTP id
 5b1f17b1804b1-49cf823cd42mr51387825e9.7.1788527017013; 
 Fri, 04 Sep 2026 06:03:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm94700585e9.5.2026.09.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E54C161DA5;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 089/105] tests/tcg/tricore: system tests
Date: Fri,  4 Sep 2026 13:45:43 +0100
Message-ID: <20260904124604.2207440-90-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260827221506.91574-90-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1c34b8e63c6..4903947a636 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -154,6 +154,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
deleted file mode 100644
index 258aeb40ae8..00000000000
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ /dev/null
@@ -1,53 +0,0 @@
-TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
-ASM_TESTS_PATH = $(TESTS_PATH)/asm
-C_TESTS_PATH = $(TESTS_PATH)/c
-
-LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
-ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c -I$(TESTS_PATH)
-
-TESTS += test_abs.asm.tst
-TESTS += test_bmerge.asm.tst
-TESTS += test_clz.asm.tst
-TESTS += test_crcn.asm.tst
-TESTS += test_dextr.asm.tst
-TESTS += test_dvstep.asm.tst
-TESTS += test_fadd.asm.tst
-TESTS += test_fmul.asm.tst
-TESTS += test_ftohp.asm.tst
-TESTS += test_ftoi.asm.tst
-TESTS += test_ftou.asm.tst
-TESTS += test_hptof.asm.tst
-TESTS += test_imask.asm.tst
-TESTS += test_insert.asm.tst
-TESTS += test_ld_bu.asm.tst
-TESTS += test_ld_h.asm.tst
-TESTS += test_madd.asm.tst
-TESTS += test_msub.asm.tst
-TESTS += test_muls.asm.tst
-
-TESTS += test_boot_to_main.c.tst
-TESTS += test_context_save_areas.c.tst
-
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
-
-%.pS: $(ASM_TESTS_PATH)/%.S
-	$(CC) -E -o $@ $<
-
-%.o: %.pS
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.asm.tst: %.o
-	$(LD) $(LDFLAGS) $< -o $@
-
-crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.o: $(C_TESTS_PATH)/%.c
-	$(CC) $(CFLAGS) -o $@ $<
-
-%.c.tst: %.o crt0-tc2x.o
-	$(LD) $(LDFLAGS) -o $@ $^
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..d0bf55dedce
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,57 @@
+tests = []
+
+link_script = files('link.ld')[0]
+crt0 = files('c'/'crt0-tc2x.S')
+asmflags = ['-Wl,--mcpu=tc162',
+            '-Wl,-T', link_script,
+            '-mtc162',
+            '-nostartfiles']
+cflags = [asmflags, crt0]
+qemu_args = ['-display', 'none',
+             '-M', 'tricore_testboard',
+             '-cpu', 'tc37x',
+             '-kernel']
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
+setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'asm/test_abs.S': setup_asm,
+  'asm/test_bmerge.S': setup_asm,
+  'asm/test_clz.S': setup_asm,
+  'asm/test_crcn.S': setup_asm,
+  'asm/test_dextr.S': setup_asm,
+  'asm/test_dvstep.S': setup_asm,
+  'asm/test_fadd.S': setup_asm,
+  'asm/test_fmul.S': setup_asm,
+  'asm/test_ftohp.S': setup_asm,
+  'asm/test_ftoi.S': setup_asm,
+  'asm/test_ftou.S': setup_asm,
+  'asm/test_hptof.S': setup_asm,
+  'asm/test_imask.S': setup_asm,
+  'asm/test_insert.S': setup_asm,
+  'asm/test_ld_bu.S': setup_asm,
+  'asm/test_ld_h.S': setup_asm,
+  'asm/test_madd.S': setup_asm,
+  'asm/test_msub.S': setup_asm,
+  'asm/test_muls.S': setup_asm,
+  'c/test_boot_to_main.c': setup_c,
+  'c/test_context_save_areas.c': setup_c,
+}
+
+if 'qemu-system-tricore' in emulators
+  tcg_tests += {
+    'tricore-softmmu': {
+      'cc': 'tricore-gcc',
+      'cc_dockerfile': 'debian-tricore-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


