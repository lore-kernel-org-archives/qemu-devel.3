Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAAEC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaS-0006fO-Ob; Fri, 04 Sep 2026 09:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZw-0006P6-HT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZt-00036n-3P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso15246115e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527011; x=1789131811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0ZKsUexTYgmpm8KblGBVOPBvs/i1QuXtNlPzSUg/xbE=;
 b=rHV+Qrg0qhOQi14vbwKwjHWKLq9sDp2TAPWmRluMVi1aUocHhr3AOE9djOd76a9i7m
 R9rFQbWN4g+LwnYRTJnEdYLnDezWAzqX2EscoFlCTRUCq3RIl9OlwnOaJAim3xTXMohc
 0eGhkvrTMHM9qYElw9FMbAQwQTRcA4QfuGJdlKKRbSLS0ZEkHcnWYxP4wOrSj2fbzRzL
 nFv9B6YyHTi+S0fZosN55xf5kOc+vVt1aFpjyPfxHA/O3W09oVFrpfjFuncykQuCEPMG
 9kHwGFf2La3kdfE6wMwVU/DfJLpDvCjPO8K1ZayNstCzUQcYb+aIDGQVgtxrf+SxtG37
 qGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527011; x=1789131811;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ZKsUexTYgmpm8KblGBVOPBvs/i1QuXtNlPzSUg/xbE=;
 b=GkLl4lamEfzffw+DIiN7ECOpL9gPgNpvJuaCP25O85KGzcjzVe2e8WxrT+hvfesKkp
 vmrc3gOU1qzWvlbgc86NfG1lhFbgv/MB/1j7+LGHX7cZ+QArEq2x39AptFTWOfRmxkUI
 IV2iGUfzuusaWa5j2J6zpUouU2izRbQps0MppI/K5SjFi8MirgDY/1/SQumg0DBxNHo1
 ofr9nEA5HyGDm6eNpLeCkYajZO2e5fz5Ep7u2vBZyQO/64Qnvx3C1oAYLVWn3yVTmYlP
 Zn9YZLiJOiVqSf2gEwMCR+yyEcEQhY9pFRpF0cfYjTZoTpDwD44j1fjmEM9t2FE9p/yZ
 xBpA==
X-Gm-Message-State: AFuF++n0yNOAJ7E2Z8okfYIfv13Yh+WL0NkW7yuMAd0paud33RAyTiG4
 lwqkEP1K0IwbQQjCtQvuC6X13JOzZLlYfaqT189nCqJhBfBcO51BA0XlmXWfhM2VtCc=
X-Gm-Gg: AYBFou2Msbojh/CfPH6PR7uwvIvQ5fRPJhXzrDacaLNVK0EYjlwpWS/frWFn4Tz48rk
 FtCxZCmd/9fxSQHxiWV1NQDYt6+RAmpcXVq1YxU7/LvpwP9LO/Q3LRpAhqEDxvTtRbcfIuKvOiE
 ULHAJHMhRd/w25c31E7a5t6gnS2vETHmKvsovobAzIjwd4sSdiUJcZQU/3IJxindFj3wTb3dh/s
 8HYKjZEvJr7W68AGJ0hZo+wmqqvy6EFhl3Ik4FjJNUEowSsO0QkKX2p2sRxUl0zZIVXVnFQ7GJS
 UAFBfT8W/sJ5BGpKZ++9x5IKcA9tbvELL/xHqRsRE2dcY6u2dizyEOQ0HI0Zzg76GF/y0B8QKER
 p7gMWRp4VgWv/nklML3z7vUMR3xdSkZYSY4Bgtr4/lwOzn3K+ZPB3hYPNCeQnwsd++APUqjodrV
 8FXLNcDelXx3E+uOU74JhR7j2aFKawjMUXSRxoEDka5w1scQJcUqWnX9CRrgcB
X-Received: by 2002:a05:600c:a05:b0:49c:f501:e428 with SMTP id
 5b1f17b1804b1-49cf82e5b1amr44268815e9.8.1788527011036; 
 Fri, 04 Sep 2026 06:03:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm169675095e9.1.2026.09.04.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F5FD61DDB;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 092/105] tests/tcg/x86_64: system tests
Date: Fri,  4 Sep 2026 13:45:46 +0100
Message-ID: <20260904124604.2207440-93-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-ID: <20260827221506.91574-93-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
deleted file mode 100644
index 4e65f58b570..00000000000
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ /dev/null
@@ -1,44 +0,0 @@
-#
-# x86_64 system tests
-#
-
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
-
-VPATH+=$(X64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(X64_SYSTEM_SRC)
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
-
-ifeq ($(CONFIG_PLUGIN),y)
-run-plugin-patch-target-with-libpatch.so:		\
-	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
-run-plugin-patch-target-with-libpatch.so:		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
-run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
-EXTRA_RUNS_WITH_PLUGIN+=run-plugin-patch-target-with-libpatch.so
-endif
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 2607a1cbcf4..ab336eca9b2 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -2,6 +2,8 @@ cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
new file mode 100644
index 00000000000..80110d0ae57
--- /dev/null
+++ b/tests/tcg/x86_64/system/meson.build
@@ -0,0 +1,63 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-Wl,-melf_x86_64',
+          '-Wl,--no-warn-rwx-segments',
+          '-Wl,--build-id=none',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  'patch-target.c': {
+    'cflags': cflags,
+    'qemu_args': qemu_def_args,
+    'plugin_test': {
+      'plugin': 'patch',
+      'args': ['target=ffc0', 'patch=9090', 'use_hwaddr=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-patch.py')]
+  }
+}
+
+if 'qemu-system-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64/system',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-system-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


