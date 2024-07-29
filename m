Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75386C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc2-0004Qg-9G; Mon, 29 Jul 2024 10:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRby-0004B8-Sg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbq-0008Od-Dd
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:30 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso459416366b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264261; x=1722869061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5nNh5K9JK+/T3reUDrggUkqIh+tpzSlqYJ3Fy2gqeo=;
 b=rmyPFoaYhDPr0aTXUcIqtaUD0GKlNs5ZMWU9QgaayAnuuP2i6Tj9JYKYgHFjN7EwbX
 eCKGgzqAIRCLn1sxdT28ryljaBkjnCzmiWMOdYfRLsKc3CMJYLDQWGJrPzkBa2CmUe3U
 4TinW/dCgPLhCeyjj1QxtQBc97foWahkhZTceXPHqpsO+jBN5ULq8V9iADDQ4y3KEv2H
 GktuOSCfHHsWuZZ6xY7sza21cXUwn5olXErdbxVkUD3Fp+Rp4RAaTX8dAquz0uVUTJAI
 34yKBlo4y2vMGKzffGqGyurz6aQvOGCjcL1FMRbGjdGW9C+vnuXudfxQAEU+xdletoHN
 0mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264261; x=1722869061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5nNh5K9JK+/T3reUDrggUkqIh+tpzSlqYJ3Fy2gqeo=;
 b=lLQOgYWY39R+RSzzaXBLBupOMYDJjFdSDiHj5P8g7LyqYuvCRN/IGYm+6Vz1gCH6XJ
 Gu+u7JZc/vFGVSckF4yzzcOYMtfkK1ctXzXP57zgBMleGkYlC+NUXI7/wU+Vk5K4Uscn
 WVPxBHtnpF77+kzrUNmxd5JHv+G3P8fNGfcBZZQ1jzqCK91myXJUqSqs4Yui5HfoB+mm
 oT7AdUxKE+BkCdT9g3iEjOkkcs8Z83zfxjzmc8HJfazrRdF423DTDYYhG/iU4U3I+qmF
 6hyxjQtR3K7vjb40xTQZmaTmrkyvyImvCg/LU2p/uGQH9TbfVogK8SDky+tB7d5f5fPp
 sZUA==
X-Gm-Message-State: AOJu0YwPXWBoq/ohlD0HQNSCKcYLjxUIAB62zni9SRuycRDjaV4VJL8J
 TvNYmY21ONPnwU0e0OqY/EcAATwuPXAKgdYRVKyL7lqd7f5C/qsIWxr6DoS1u+M=
X-Google-Smtp-Source: AGHT+IF9IdjkQYGmEiFx1If2oalFfkPo8nhunRaTr/FU0hYbqn+5gt/XC/cjA2mLIrDjBjI1TMcoOg==
X-Received: by 2002:a17:907:97c4:b0:a7a:bd5a:1eb3 with SMTP id
 a640c23a62f3a-a7d3fdb7aa1mr669122166b.8.1722264260641; 
 Mon, 29 Jul 2024 07:44:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de06sm514722166b.71.2024.07.29.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E88105FA0C;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 09/14] tests/tcg: move test plugins into tcg subdir
Date: Mon, 29 Jul 2024 15:44:09 +0100
Message-Id: <20240729144414.830369-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               | 2 +-
 tests/{plugin => tcg/plugins}/bb.c        | 0
 tests/{plugin => tcg/plugins}/empty.c     | 0
 tests/{plugin => tcg/plugins}/inline.c    | 0
 tests/{plugin => tcg/plugins}/insn.c      | 0
 tests/{plugin => tcg/plugins}/mem.c       | 0
 tests/{plugin => tcg/plugins}/syscall.c   | 0
 tests/avocado/tcg_plugins.py              | 4 ++--
 tests/meson.build                         | 2 +-
 tests/tcg/Makefile.target                 | 4 ++--
 tests/{plugin => tcg/plugins}/meson.build | 6 +++---
 11 files changed, 9 insertions(+), 9 deletions(-)
 rename tests/{plugin => tcg/plugins}/bb.c (100%)
 rename tests/{plugin => tcg/plugins}/empty.c (100%)
 rename tests/{plugin => tcg/plugins}/inline.c (100%)
 rename tests/{plugin => tcg/plugins}/insn.c (100%)
 rename tests/{plugin => tcg/plugins}/mem.c (100%)
 rename tests/{plugin => tcg/plugins}/syscall.c (100%)
 rename tests/{plugin => tcg/plugins}/meson.build (70%)

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


