Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9267C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQB-0001Zd-Gm; Fri, 04 Sep 2026 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ9-0001YO-PV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ7-0000eM-Ba
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-482f9309813so882498f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526406; x=1789131206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YInPOfi+J5WbTMOr1WjVt/C35IoOaen+Lma3WkubtKY=;
 b=xXH4M9tmiNkHeMt6Ta2bOrei48zewtVtyzR97NaNi+/xHVxhd8hxwQIZVDpkgfMcqJ
 qStqA36KMuyu500LOLuW9MpqIn6vJBVGknXjqfS7qXcinrs0aabcU41r302dZbwpNCs6
 IRkQ66mpLdB63H1n6XvWMoKBWOD2wHK/lB1M9NlY7MqETjnxQwcjH8n9zcxMSR0qU/UQ
 EzoUOUR2opzzhr7Q/fL0czgCB2lJMsPmjm6fgEgnTWuZ6o9n+uub/XpZCYfWjexv2u3X
 kQonv3+0eapf+1mrdXTUetuPOkbMGtHHi6yv6JfdzJsIHg25sRpxp/S8YmYCbOkMaL+4
 meNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526406; x=1789131206;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YInPOfi+J5WbTMOr1WjVt/C35IoOaen+Lma3WkubtKY=;
 b=o3dHbfrmx3WNTGtH1238ZxDDIku+FTnjkoJeRjWhNPyMgsAZGY5p6eO4t7ue2jMZKN
 J6rz2SfyG8Qm8HrKJ2XMlQH71sxjFy+giL4AhEOWLU6x0SKnljCxKgmwobhGiSUbN35f
 e+pAOWu0ljcei5Atlq1ovun6MzhpGNvC21DJKaudg574dS2HqmuhYCXmODdg0/AR8JUa
 ipzS2zCRFAhn+j8nSVCPeYPuosWjhreCBEjVl4ebg3J+mc+CuqFJRxGf6PqrmzgQcgaG
 8qBMnEtFA27WAt4Ab4wnO+/Ed1yhFcPIiOGNlEdVWKICvt7vCV6MWT+TqR3XZVu/MVV2
 /lXQ==
X-Gm-Message-State: AFuF++ko9KaVC14G6fmOKtwzy5rRraOMYiJusNNSZP0SbEXMtxmDq/Lw
 glKeBaDZP6wiC7DtUhQa4lwnOFNIrhZj9S5ESd99rzS0rssm6PqUZfTGQVcZtfrt0iDwxb5RBZN
 vXmCpKQw=
X-Gm-Gg: AYBFou3KVVa7988FxrJo7gPxGjHEnWD5giI/romHp1Nl5mXaDCEXeh/JHSknGsEH08a
 IOtQkQ6t+4D8mnBURM8+aZAXgHiENI4nOgUiLJDReVPiwl3FyE/o/1oZgC9fGPY3Iay+MrM6J8Y
 +yOXBDm71Yg79rbhAx63GNNiRtnc+1AVND0E7YmhGHsOCeHYIn4pnV0hhSxhS7eKhIssrrREpxc
 m/NHYWwNXV8AJjWnT5N1Qra9spmzKFKaTxNMuH/j7uQtm7+bcuvfIzksgWoVUiVFVtYz37+PC9r
 +Lzta3GLhMARy+4JlA+84DYdoNC9mObMvLTGAbm5D7qJJ2fDTPjYpfBSdRXrEnncTLq9dOJZ/rO
 JuG3Zf8+axniWzUC/zUZvzK+mop7ZMTU7JWYbLhQe+AhasmYQ4uH7XQJiQDMwGNm9pM7cxi5Yfl
 YtZbekfcHqxc+QSkbbJclomylfM7/3+rW+sy+JiB2VDHiz/QH9/7HmNASRsBp2yJBrMiwq8LwjN
 Q==
X-Received: by 2002:a05:6000:29d1:b0:47f:8b24:ef01 with SMTP id
 ffacd0b85a97d-48587091569mr6638825f8f.1.1788526405585; 
 Fri, 04 Sep 2026 05:53:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm2475317f8f.3.2026.09.04.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57EFF61AF2;
 Fri, 04 Sep 2026 13:46:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Song Gao <17746591750@163.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 058/105] tests/tcg/loongarch64: system tests
Date: Fri,  4 Sep 2026 13:45:12 +0100
Message-ID: <20260904124604.2207440-59-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-59-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
deleted file mode 100644
index 6d4a20fde73..00000000000
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Loongarch64 system tests
-#
-
-LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
-VPATH+=$(LOONGARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
-LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
-
-CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 209179fd96c..1d62de64ed6 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..5bf4c56e385
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,48 @@
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
+          '-march=loongarch64',
+          '-mabi=lp64d',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


