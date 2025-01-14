Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60890E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFw-0005De-LO; Tue, 14 Jan 2025 06:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-00057u-V0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFi-0005RI-2F
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:36 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso9602522a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854713; x=1737459513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=castUuYEMS9/+bXLMhhSaPLlf0YHd3GiZGeVC9CY3P4=;
 b=bwqhtIfttTmB7N5DbHXjHxsx9so4aljvjfvaw8WX+oXfSf0Qliwhl7xTymivnenPms
 EPjR9PBYMopJM1ZgDuTwwmhams/70cq3IxT/1zpK7Ku1mjWQEITYYKl6xUjIntsIfjwZ
 ZYR4SFPLE0yQL/wQr3ziNW0cjYisv9WfX+7f8RdaPuwvgfiAvHqIfj3d7uZWT6R+gOqn
 ZHrnTTFPHdVJohHVYZkRNBhy9j58bDmCyH/IjnHkkBgvBcQK3/n3QXoWzHJzzsNMmFHg
 i4VnFbC6KsB22lg7Ma73LDdvNiSpRJLr1Ej8xEi5tELpYmxSyzXPZZl28KF993iFb7vB
 tcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854713; x=1737459513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=castUuYEMS9/+bXLMhhSaPLlf0YHd3GiZGeVC9CY3P4=;
 b=jKjtLy85cwkkCWc8tOo0GqRE+HOqiDMzMiPhmrf9pDrFU5JVkbANZcJ8RjUAewEfvF
 pw1uFUd3PswgKbZSJmfZ7H+U86KQoMt289GaE0CHCA6RNm+G+/i4441Gjkj+DbHYVwAc
 D3rzuerdU3xu/tCLbx7ts9A6GZtNmbYrz0GUftfZ3o0Y9Hwxxi86AGsDjVw8J6lUTC4u
 ZwgB+6M1p9MB8NWCI1Cotd7YBgNv82ynpcpJ7Xx0RJe6BDP1XIQThB3O59E8IY3lo/PO
 a0yhoVrThRY/AmLedxZZSMzUcoOOIUtH7ZWgpsvBWP+7+GCKvN8v1jqzOPy7yhEhNLbE
 pHqw==
X-Gm-Message-State: AOJu0YyvGbcD5QMaa5cjhIWOv4nLWvk+OLTHosxO5YabIx/uyOtxrdPP
 XTCibvafqRwNmFgO331F32eXXy8J4RfeSPOujApSpyjaV/Fbb41Ma1UrJ1IXlts=
X-Gm-Gg: ASbGnct0elBuEOqRzCSGIHnY+Tn8e9f/wg3bs5WqN3IZMAsg+jqTxsxwYBA/U12euz/
 nbVe/XhQRMAi6EtwtAtZUNMhF5VhnRdukjURDYB2TEBqIf9fiMaMcB7DkVa5kfoBGZMKdb3GtMl
 qcNAhARNfv7yjy0IB0Bcjvz3FRcTGZSrFF8wh13PqSOxh/L1CqYC94YTJiiLRPYRjIHjdAUBv46
 veMox22xSFi39jQDjLeOJK4pLoPXWWPL83Wq5hxyJAGkIsh0CHPFdc=
X-Google-Smtp-Source: AGHT+IFbeRp5YCoHnXj242N/5AUNoNw3XKjWsZq4URpMhYXnqoXgSKEkz4ArfYxT61MSs1EXz203mQ==
X-Received: by 2002:a05:6402:2355:b0:5d9:a55:4307 with SMTP id
 4fb4d7f45d1cf-5d972e4eeabmr23355229a12.22.1736854712680; 
 Tue, 14 Jan 2025 03:38:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046d7d5sm5911756a12.66.2025.01.14.03.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A45B5FA99;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 25/37] plugins: enable linking with clang/lld
Date: Tue, 14 Jan 2025 11:38:09 +0000
Message-Id: <20250114113821.768750-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Windows uses a special mechanism to enable plugins to work (DLL delay
loading). Option for lld is different than ld.

MSYS2 clang based environment use lld by default, so restricting to this
config on Windows is safe, and will avoid false bug reports.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                   |  5 +++++
 contrib/plugins/meson.build   |  2 +-
 plugins/meson.build           | 24 ++++++++++++++++++++----
 tests/tcg/plugins/meson.build |  3 +--
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index da279cc112..15a066043b 100644
--- a/meson.build
+++ b/meson.build
@@ -377,6 +377,11 @@ elif host_os == 'sunos'
   qemu_common_flags += '-D__EXTENSIONS__'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
+elif host_os == 'windows'
+  # plugins use delaylib, and clang needs to be used with lld to make it work.
+  if compiler.get_id() == 'clang' and compiler.get_linker_id() != 'ld.lld'
+    error('On windows, you need to use lld with clang - use msys2 clang64/clangarm64 env')
+  endif
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 63a32c2b4f..484b9a808c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -12,7 +12,7 @@ if get_option('plugins')
       t += shared_module(i, files(i + '.c') + 'win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        link_args: win32_qemu_plugin_api_link_flags,
                         dependencies: glib)
     else
       t += shared_module(i, files(i + '.c'),
diff --git a/plugins/meson.build b/plugins/meson.build
index 98542e926f..d60be2a4d6 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -17,14 +17,15 @@ if not enable_modules
       capture: true,
       command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
     emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
+  elif host_os == 'windows' and meson.get_compiler('c').get_id() == 'clang'
+    # LLVM/lld does not support exporting specific symbols. However, it works
+    # out of the box with dllexport/dllimport attribute we set in the code.
   else
     emulator_link_args += ['-Xlinker', '--dynamic-list=' + qemu_plugin_symbols.full_path()]
   endif
 endif
 
 if host_os == 'windows'
-  dlltool = find_program('dlltool', required: true)
-
   # Generate a .lib file for plugins to link against.
   # First, create a .def file listing all the symbols a plugin should expect to have
   # available in qemu
@@ -33,12 +34,27 @@ if host_os == 'windows'
     output: 'qemu_plugin_api.def',
     capture: true,
     command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+
   # then use dlltool to assemble a delaylib.
+  # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
+  # linker file we add with plugins (win32_linker.c) to identify that we want
+  # to find missing symbols in current program.
+  win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
+  if meson.get_compiler('c').get_id() == 'clang'
+    # With LLVM/lld, delaylib is specified at link time (-delayload)
+    dlltool = find_program('llvm-dlltool', required: true)
+    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
+    win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
+  else
+    # With gcc/ld, delay lib is built with a specific delay parameter.
+    dlltool = find_program('dlltool', required: true)
+    dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
+                   '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+  endif
   win32_qemu_plugin_api_lib = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
-    command: [dlltool, '--input-def', '@INPUT@',
-              '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+    command: dlltool_cmd
   )
 endif
 specific_ss.add(files(
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index f847849b1b..87a17d67bd 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -5,9 +5,8 @@ if get_option('plugins')
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        link_args: win32_qemu_plugin_api_link_flags,
                         dependencies: glib)
-
     else
       t += shared_module(i, files(i + '.c'),
                         include_directories: '../../../include/qemu',
-- 
2.39.5


