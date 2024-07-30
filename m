Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF6AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpck-0000Os-Tp; Tue, 30 Jul 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcj-0000Gp-7D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:53 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcg-0003ZI-Qb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7abf92f57bso624400466b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356569; x=1722961369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fyYDcDv5KTze2j09O6ktgDBKd/K+i4jbbZxm6SZYgw=;
 b=Pt+uDukV6XzCkr4vg4hpZabtXJryBTUPsi7HPzhbappBGLSq3rjYUOaeSB1tA7z7ia
 HXNlYXXoXaheWKfbU4ICtlGByMJ/09z4+0nZsqq0ZAi0S9zhgr2an6HYyaYFI21u2JNo
 t37Y0ajHAxvfzwM4DLM6ODM3kbkwEQ9aYG24BsWcnWCsqlw8J9YPWJr5WhwvpJGgohnl
 TTs+bSTuC+7fVq3HM58j1QZyTLeHTwNnqcZ+x0sZSUPaVDqXRkqhsQbC/TXvTt3cmYKs
 7dUEkH1aL6HdIk/ODIlHFKD9IiuutxDoYyO/jN1xaM5fb9C8Nf9omGmsu1E1Fx52BZ5O
 Gs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356569; x=1722961369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fyYDcDv5KTze2j09O6ktgDBKd/K+i4jbbZxm6SZYgw=;
 b=SLj36Rs5RnGpWDAntausOCb6U37C1f5fRmt2Ml3D0qIoFhvT4FCC6Ld+QLob0YJ3WQ
 xFaX/9V7OV0ffwO93ygvKGt3zBhxdHy9skqXcSy+m5cO7xJjGHp7h0vmjqYti9/CFCj1
 5ZgB2tbp7gev/hCkBCSafiY2mQelSvxeckS88GX1urjpYomLtOyBT7K5M1WihSVNVeUw
 fY3yl163DZFj2+HYtp0SkNvyRRIST0YDGbS8DD7oPeiDcOPwM7LiD0UdRxIMSgnuin3A
 BWxH6mPv2PlVfBbFi6xirK5Xa1QcNGE/yiwEY+2RxYVoGa0H3PoUBAwGPr66lvjx6u+C
 ZGTw==
X-Gm-Message-State: AOJu0YyQg0FNUmXUJWmI1msgpcCud3LxcVZcQCl8nY5ZO1JN7et6L5nX
 1ccepMmqNtcU/S4eN9a+Cb7njryqLazy4u4k2MLBc249ta6jUhJhItNvd41u0aI=
X-Google-Smtp-Source: AGHT+IFWxAXdUncxTXiZl1ssCkZvkdc+Drue5mOXNNY6v8jjICG8loHUWTRYEqDjw/XGGqn7cEBXQw==
X-Received: by 2002:a17:906:d555:b0:a7d:3ab9:6a5d with SMTP id
 a640c23a62f3a-a7d40175219mr693454666b.69.1722356568939; 
 Tue, 30 Jul 2024 09:22:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad903f1sm663624766b.152.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B05D45FA06;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 09/14] tests/tcg: move test plugins into tcg subdir
Date: Tue, 30 Jul 2024 17:22:32 +0100
Message-Id: <20240730162237.1425515-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

You cannot use plugins without TCG enabled so it doesn't make sense to
have them separated off in the test directory structure. While we are
at it rename the directory to plugins to reflect the plural nature of
the directory and match up with contrib/plugins.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-10-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..72b3c67360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3751,7 +3751,7 @@ R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-F: tests/plugin/
+F: tests/tcg/plugins/
 F: tests/avocado/tcg_plugins.py
 F: contrib/plugins/
 
diff --git a/tests/plugin/bb.c b/tests/tcg/plugins/bb.c
similarity index 100%
rename from tests/plugin/bb.c
rename to tests/tcg/plugins/bb.c
diff --git a/tests/plugin/empty.c b/tests/tcg/plugins/empty.c
similarity index 100%
rename from tests/plugin/empty.c
rename to tests/tcg/plugins/empty.c
diff --git a/tests/plugin/inline.c b/tests/tcg/plugins/inline.c
similarity index 100%
rename from tests/plugin/inline.c
rename to tests/tcg/plugins/inline.c
diff --git a/tests/plugin/insn.c b/tests/tcg/plugins/insn.c
similarity index 100%
rename from tests/plugin/insn.c
rename to tests/tcg/plugins/insn.c
diff --git a/tests/plugin/mem.c b/tests/tcg/plugins/mem.c
similarity index 100%
rename from tests/plugin/mem.c
rename to tests/tcg/plugins/mem.c
diff --git a/tests/plugin/syscall.c b/tests/tcg/plugins/syscall.c
similarity index 100%
rename from tests/plugin/syscall.c
rename to tests/tcg/plugins/syscall.c
diff --git a/tests/avocado/tcg_plugins.py b/tests/avocado/tcg_plugins.py
index a930fca2c0..a6ff457e27 100644
--- a/tests/avocado/tcg_plugins.py
+++ b/tests/avocado/tcg_plugins.py
@@ -77,7 +77,7 @@ def test_aarch64_virt_insn(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/plugin/libinsn.so", plugin_log.name,
+                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
                     console_pattern)
 
         with plugin_log as lf, \
@@ -107,7 +107,7 @@ def test_aarch64_virt_insn_icount(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/plugin/libinsn.so", plugin_log.name,
+                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
                     console_pattern,
                     args=('-icount', 'shift=1'))
 
diff --git a/tests/meson.build b/tests/meson.build
index acb6807094..80dd3029cf 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -78,7 +78,7 @@ subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
   subdir('fp')
-  subdir('plugin')
+  subdir('tcg/plugins')
 endif
 
 subdir('unit')
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1f8e5b3d30..452a2cde65 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -142,8 +142,8 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 
 # If plugins exist also include those in the tests
 ifeq ($(CONFIG_PLUGIN),y)
-PLUGIN_SRC=$(SRC_PATH)/tests/plugin
-PLUGIN_LIB=../../plugin
+PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
+PLUGIN_LIB=../plugins
 VPATH+=$(PLUGIN_LIB)
 PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 
diff --git a/tests/plugin/meson.build b/tests/tcg/plugins/meson.build
similarity index 70%
rename from tests/plugin/meson.build
rename to tests/tcg/plugins/meson.build
index 9eece5bab5..f847849b1b 100644
--- a/tests/plugin/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,15 +2,15 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
-                        include_directories: '../../include/qemu',
+      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+                        include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: ['-Lplugins', '-lqemu_plugin_api'],
                         dependencies: glib)
 
     else
       t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../include/qemu',
+                        include_directories: '../../../include/qemu',
                         dependencies: glib)
     endif
   endforeach
-- 
2.39.2


