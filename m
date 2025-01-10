Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0D2E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLhz-0000WH-SO; Fri, 10 Jan 2025 15:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhx-0000Vb-OA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhv-0005f4-IV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso42728915ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736541254; x=1737146054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYJSyPKU8fgKG+LBRgRKgUriNwBs8tsNOa/EDE0vjZM=;
 b=wdUNmwt8H5cyyUZzoi/iRFpqeDr8xaPftlL6DV2FKDDtyzy1icReicI2FMxq6MvoeB
 CWE7hxE21rCBJF5EJ7skT96ob7hn1fdlsIVIdpCvmGEaPGQEGxc6CWmIsC61fGpvV6Is
 pXNMA9EQ/t2tKD4LIS5u5VFAAF7Oul/PrVqE3IXMoh+8oHHOyGJGWLt75wrql2wVM+hs
 qTYv3hoRIGNyrP/yiVCdgTb4I64d38br3dHrsWsv77iukdv7q/dtEjOwpDdzmJQBAkN3
 hh9l4DjgI7Z+Oi8vak7f2xVXjLmsNMGH6PNb7oKERcSNnxdu+jxTyAeYZSROY55XR99V
 jaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541254; x=1737146054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYJSyPKU8fgKG+LBRgRKgUriNwBs8tsNOa/EDE0vjZM=;
 b=UMQqlDf3zB//rBxcTdDAawhLNOreLLKG0numUfH0KsY9ezAREVWHwXrGDcXR9vgp3g
 pPFio/80VwgPPUWT7RNkMcyrJPzK330grEW0Zh+DmgWx30UWLzkKa1ABD9EKdpSpiQ8P
 Km2FdzFeqbRPgo/9zj2oVmbe/sr1wxBeE9Tb9xfoCBXxDM9aKDEO13yOxcvEf/pju3Wz
 S/a1PGB3+q/V6ND8zt6IXNN4yJrOXRzXZnXPi6uJ+sMnFORRj9lcqr0cGhzpivnpPCH7
 zPOIfsEo5uim1WseXgkqY0DZAhXhVo7vYGpvDBMJzKXJKw+36WXh66WnW/1zwaGq/Kqu
 pVjg==
X-Gm-Message-State: AOJu0YxVWnyo+V0y74nNMq7QkStqrVF6xocAd3a9SURLyfRQEzQVbTDd
 alK39W39hqYl9iUIkfr9wYw7e/Mg8LeuRzE+K1NxpxPVfErRUXMq9XH7/f6lXMOSCGfGuzZszJB
 jIeKAxg==
X-Gm-Gg: ASbGnct5CrTOSWvb70I+e651m+RyrFlfOnHCIAY97bqm6Y/6bV+IG0TWeRSNegS0OsC
 wM1mAQjxKfAQBcZocy9vE/w8t70KI3A2BovMdpB5oEyNn3dn7BBlHsY0vfQM95UTkvKPnk2l2Sm
 QqwYtCR+szEOg9ADE8wikV6YPtlpUeJxBkiSuXWXn1F6kf35a/8uZJuhGTT+wycTKcqZDGCB6as
 9yml0T8H+xaNCxj6GDemmaqRzcNn6QkV83OPoL4rO76DDrq+XQKKqyT
X-Google-Smtp-Source: AGHT+IHctK0WE4UJ95SCd3OmRF0ltj5QCrmBVWlxc8t/jiLsdIzrlDzt5obBa92De56PbdkX8UIEew==
X-Received: by 2002:a05:6a20:c999:b0:1e4:80a9:b8fa with SMTP id
 adf61e73a8af0-1e88cfa6fc5mr22018024637.13.1736541254214; 
 Fri, 10 Jan 2025 12:34:14 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318e8ecacfsm3215947a12.38.2025.01.10.12.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 12:34:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 3/3] plugins: enable linking with clang/lld
Date: Fri, 10 Jan 2025 12:34:01 -0800
Message-Id: <20250110203401.178532-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  5 +++++
 contrib/plugins/meson.build   |  2 +-
 plugins/meson.build           | 24 ++++++++++++++++++++----
 tests/tcg/plugins/meson.build |  3 +--
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index da279cc1124..15a066043b7 100644
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


