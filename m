Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E7D70DEF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkvO-0001NK-Ja; Thu, 28 Nov 2024 15:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkvB-0001Ij-Ip
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:29 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv7-0001mf-KJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:29 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ea45dac86eso927555a91.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732824924; x=1733429724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/WE4DdwfNtGJC4bBQHDV6Up1JyJz8d62bKAZjE6uOc=;
 b=AQdOrZSwBgh7kGOZQvr/cSxqvFk/QeVW+U0DcTekW4TJsg5xU24tQJNezPBLRfJsCX
 1umzAkPDaQ0PMbF/7To6kYQqO9rr2KZkBIQkSz8MoaWfhXIE7YKnk5h5qJzLJRVajxQy
 jMM/Obe7R6keL7aKYUqDW9sGTpl9BtQCgTxXBIDwfBBh0dBVJtYZOjZaEMc0iCCMqHnI
 mcxYQzVWCbBYUH7+Ao9Ddfq7TrGJJH3XchcPjjRtwxh4fAWX+r0mfHmFJvhrCyeGPfgw
 +iLK3rfpl3YuroSuJf/jXjob8pzBJWDg2/0voMhlAD7mPK05ISTDckUBRG0SYBG0Y0/q
 VevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732824924; x=1733429724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/WE4DdwfNtGJC4bBQHDV6Up1JyJz8d62bKAZjE6uOc=;
 b=gEfil7Ol0gOZTaGQLIVAaCJxeiGLj6msjaSOi3jabZISecGlpf4Qzlf1VO8OO53N7Q
 +paQXdo5OuGNmFdoG3EP52tZDX5r2Gz8IKK7lE0BueAsTojXIaLt1/6JU7a2pXkNM6JR
 ZeX4NrC7ttDvnoqyQXscoZ3EkD6RGPCG67FCE5IPvNZunahUcAwosHJ5NCH3DF5TyWwy
 v8Qi8AeedINXy9EfK+V1tEWIYPvPKiOBNtYOvehF4yI9Sbq81detoCFv43WdOyFrxRQF
 eDF0ca2zpC4VZ85h91DttbJbfiuWa1ugbXI0fNOikAI6Qi6cN6M7fCztRXeI9QkOQk05
 eBfQ==
X-Gm-Message-State: AOJu0Yx41L58ScMaApfq866HN7rSkRK5NMbKfq1JsceJLiQuSJ0owFZh
 pKDOPYTUs+q13AFBs+PZBNsRrfjOWZdoibOfLtVEZKfR2NXNufHDpkIyth5CmF/F9BNLoRs5fxa
 I2sQ=
X-Gm-Gg: ASbGncsoOzzaBajEvf7Zq8ZB187//gykDCCK9RK9YH9nFIhkDnlBT1gdP/ZSrNs7HCJ
 dooQg56ZLBPssv3p6HJKQZf9ET+q6yLCjolg4WmDj1plTzK46P1CWXtcFS17hyfRCwPg9rgRtqt
 ZPrGO+qDl7ehjqui+7sRE5LqGrfgfKMQzyPTvp9TUp9svCEdcIuZrqGjm4fsPMXt7KuTPV5kv1w
 1b1M6HXIMDCBtchbgK5SGbOKBLTs/5N1YyVeiYjXXTsnsScvIugcxpiLnmDPXjipXjdQEBzHiaS
 k8HGlTs6kVgzGQ==
X-Google-Smtp-Source: AGHT+IEc4/QEHN4luw0cd9jmF7OPCym+gMlxgj0UeiM+RCbpeUilJvm+VPinObdpQACqZ7psos2NHQ==
X-Received: by 2002:a17:90b:3e86:b0:2ea:9309:757e with SMTP id
 98e67ed59e1d1-2ee08e9fa32mr10969501a91.9.1732824924110; 
 Thu, 28 Nov 2024 12:15:24 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fb10049sm3912861a91.43.2024.11.28.12.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 12:15:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/3] plugins: enable linking with clang/lld
Date: Thu, 28 Nov 2024 12:15:10 -0800
Message-Id: <20241128201510.869974-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

Windows uses a special mechanism to enable plugins to work (DLL delay
loading). Option for lld is different than ld.

MSYS2 clang based environment use lld by default, so restricting to this
config on Windows is safe, and will avoid false bug reports.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  5 +++++
 contrib/plugins/meson.build   |  2 +-
 plugins/meson.build           | 24 ++++++++++++++++++++----
 tests/tcg/plugins/meson.build |  3 +--
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 97cefb7cdd7..f286fb4f4a0 100644
--- a/meson.build
+++ b/meson.build
@@ -354,6 +354,11 @@ elif host_os == 'sunos'
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
index 63a32c2b4f0..484b9a808c8 100644
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
index 98542e926f8..d60be2a4d6d 100644
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
index f847849b1b7..87a17d67bd4 100644
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


