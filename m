Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C129C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJR-0006Dq-H7; Fri, 04 Sep 2026 08:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJP-0006CX-Ay
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJK-0006vD-Jv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so826605f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525985; x=1789130785; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ggXS7l97nrKzR6GenQN1rryY07BIOL38kvZD8Vp/lOc=;
 b=B7gGLs8XPzA1GvrkqdpyeG3A9Tyt1dS/9rpfG13VTvtnoXODWFKT6QF+YxZKhyNGiV
 V/I78K/mm+dkn5rPuiJ0eQWQEW536mfvobynxQwNFK8lDAcUIzN6d1Bmu29RlSVeXpKY
 lrxTWDXHovyOJ2e9wUsytff39/8rWFoIZiXMwAFVyEt6arMYyQKsA0QAK12vQKtAXzY2
 f2zrkWkHADaC1/tO/FFUt6Cb7MaDHwj+cPRTiFYtldDdnKMlyt7y0qjwSjNSScjhkwBr
 iMphK9GOhNTj0sLVAJBgwQoSPamHFfYm+A/mNBMPLKQB4rOHu5i1CbgpI7k5UIQ6SLkT
 K9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525985; x=1789130785;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ggXS7l97nrKzR6GenQN1rryY07BIOL38kvZD8Vp/lOc=;
 b=ShvdMU3MN6iHME07Pr/UyF4/QlqhChBjfDZYCXMCS7KZQCJqIMu7Z4d6NkPaLMEiwf
 R7iA8+A1u9Z6hCpPIagOLUsf6S0+PyAY2lCeKmEtH+TBeztvJNKji5vNXWOnWEwNTJTf
 j7kPtJC6RgJF7v2wSEQBojYbTYpNtNy9RhmBDeP9jDoeMcypQyYU0KAxWaj5GPzIrw/d
 8HIwzLXS2YanRU2zd+86i6EUX1kjayPFZyo3na4HZqCl/v2yPEpVs3EEWIBlcu3rkMSR
 KlnAJ3hNbxfB6A0B8OTXWSn/Jkw4kiMmDc0FHmgt8dwPyrABc+/W7EGWOJLpvRydDH+g
 dUPw==
X-Gm-Message-State: AFuF++k1YfKhpMrZHZaOfaWrQU1gPcMgwjbseJGg8x3e3XoYYJrgYwu7
 kgi8xX10j+BjIwLV+mOaGxYDWGFWhlIpF8p7/fAaCEnSstdCSlvKAzrodTg+zs82ujE=
X-Gm-Gg: AYBFou0MZcgWRNS3FCSUVydOfkauzXbX81rVqDZiHCeFN3dd8TtB5rqVrdYQF/EufRu
 GK2kj7//noRH/NdOjqTGjmWTVRuu3hEKj6khKyGsPOSJujkb5O4fiEryuQcjcTS7ZeajfhTWsAW
 058Uv5A0IUWYRBFMbSSTD/a7jwlbyulkhJYuMp3Cm4mrbUEPNJ+ubAiC3SjwjkWWRS8iMb2Gh4L
 ssE0kax0shaRbAiz2m/xQIyaePN21MjdL4sHB2ZyrHKROggC98YR9XPvxKtWeZA7g+3bMVM+MlZ
 vXH7zr4N0Qy4whVGlA1QCatu9uBea2RnRIBYM50ojhpLFiZHn4QC0Wwr32Cozl9sOgrljb/NzGc
 llf04y/B5d+sQ4mM7nOXmKjieJWpzgnJpqzTm77xawf9XY3xCjoRQrwZDmh3SSnua4lQPrLOgT2
 ybIeN4KVocFdvikPY9jW3LSRMjpC7cxeIjzpUfcTEicRbtx6tCCt7P03EicjEi
X-Received: by 2002:a05:600c:3b17:b0:49c:fc6e:8cb1 with SMTP id
 5b1f17b1804b1-49cfc6e8db3mr25469445e9.21.1788525984764; 
 Fri, 04 Sep 2026 05:46:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm5759002f8f.36.2026.09.04.05.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DA6261351;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 086/105] tests/tcg/s390x: system tests
Date: Fri,  4 Sep 2026 13:45:40 +0100
Message-ID: <20260904124604.2207440-87-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-87-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/s390x/pgm-specification.mak b/tests/tcg/s390x/pgm-specification.mak
deleted file mode 100644
index 73dc47af0d2..00000000000
--- a/tests/tcg/s390x/pgm-specification.mak
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# List of specification exception tests.
-# Shared between the system and the user makefiles.
-PGM_SPECIFICATION_TESTS = \
-	br-odd \
-	cgrl-unaligned \
-	clrl-unaligned \
-	crl-unaligned \
-	ex-odd \
-	lgrl-unaligned \
-	llgfrl-unaligned \
-	lpswe-unaligned \
-	lrl-unaligned \
-	stgrl-unaligned \
-	strl-unaligned
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
deleted file mode 100644
index a4425d3184a..00000000000
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ /dev/null
@@ -1,57 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-# EXTFLAGS can be passed by the user, e.g. to override the --accel
-QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
-LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0 -I$(SRC_PATH)/include/hw/s390x/ipl/
-LDFLAGS=-nostdlib -static
-
-%.o: %.S
-	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
-
-%: %.o
-	$(CC) $< -o $@ $(LDFLAGS)
-
-ASM_TESTS =                                                                    \
-    bal                                                                        \
-    cksm                                                                       \
-    clm                                                                        \
-    exrl-ssm-early                                                             \
-    icm                                                                        \
-    sam                                                                        \
-    lpsw                                                                       \
-    lpswe-early                                                                \
-    lra                                                                        \
-    mc                                                                         \
-    per                                                                        \
-    precise-smc-softmmu                                                        \
-    sckc                                                                       \
-    ssm-early                                                                  \
-    stosm-early                                                                \
-    stpq                                                                       \
-    unaligned-lowcore
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-softmmu.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-softmmu.o
-ASM_TESTS += $(PGM_SPECIFICATION_TESTS)
-
-$(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
-$(ASM_TESTS): $(LINK_SCRIPT)
-TESTS += $(ASM_TESTS)
-
-MULTIARCH_TESTS += mvc-smc
-S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
-$(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): CFLAGS += $(MINILIB_INC) \
-			      -I$(SRC_PATH)/roms/SLOF/lib/libc/include/
-memory: CFLAGS += -DCHECK_UNALIGNED=0
-
-# s390x clears the BSS section so we need to account for that
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py \
-		--bss-cleared $@.out
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index dcbbb463c43..dc6271c7c73 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..ca07f503058
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,92 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


