Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm3-0002WK-Re; Fri, 17 Jan 2025 08:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlv-0002UV-B6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:27 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003kz-2z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:27 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab2c9b8aecaso330535066b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121939; x=1737726739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DsD0KNZtCjKGcEGcvgtBm3TE+kh+pIdctH3xrF6qRk=;
 b=fy662R/vjX5rwXPgvCPjKyCvfYby9SmriIUm/DHPb4c9/8tVxa3wUWwLJ6aSFUnNhz
 aPKl1CIrIvpSBTpoobRBHmadEFhq2eX/r47R7JU6KoClHS3lbFomlFXYZXgGUpNE7Qhu
 ualMixRx4FUbV80bOOqu9Vfnp3EJnQYBcgNRTMair4NITrQlyyr8rKHI92VhktNX0bpW
 /EPngm6zhvCoTAdpyiqbk4k3KZNDizwT8T/Vg3d54kYdruuWjA+iECO4j9ERnpQkYSKf
 gphjpPqHB9qZRBHtjqtYi6rO4S+0K26URpqzMW6uDzrKNLfKokcXSczdj9S9vDdFJ6y5
 px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121939; x=1737726739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DsD0KNZtCjKGcEGcvgtBm3TE+kh+pIdctH3xrF6qRk=;
 b=VHKA/OqawLRtZy438kW+BrCN96DtJEgSyqwpHVOUPcH5ofciyiu79ahXLWXt3RFa2+
 Ju8e9iIjOFBwRhskGSaQOHhYuRgxHQfJhGRUGGodEfQT9Hlid6Hc+Xd6xBjkV/6XYpMg
 ZmVq7Fasqqmt03XWPC1PT1vXVdF4pUCVqDkdJ22NqzYSS2mmSEjpefpSsmZH/fLDqMFb
 y4KgvPbhaZNZinJz1uVgjxIzOFWvtIgYgilLjAd9AVRrYRXdsBXSoFoAY92QmajSZdn6
 FWLXSn7BXFj9bAvEHgjRyfL1N2Y85bbzo1iNGP6lo89ZZOq6vaMt+Va1bAZSqOVTOZ2n
 967A==
X-Gm-Message-State: AOJu0YyZM/ttI/LdQIbv2cwVpsrGHoR4egwF9uNX80s6bgleBKCprI/i
 gS0PMlDmbD4oTd0gaV8MJJgjlrgp91JqS0U7pjLSASuCYqmq6gDGRJvVgpZCU4k=
X-Gm-Gg: ASbGnctRQMr+y7z9DvTRsNwwQ///mDMbpI+vwgij2r/VmK44neRHlN7DIYh22zIqfdi
 B5UHfEq6bs7vbUDW7XnOoTkOM54KiM0gve2xZvN2qXNBBuTlQJR+Gsx6I4rbI55P/Gsuba+gdwx
 z2hqWcPRTgqpohrD13E9xYqwER6jBB8X90Y0dkl7Vm7Gt9cHhwGRV4p1IGfRYDGtrhE5afP7DcC
 /NMG2Lt969Euy7nkFQTH6Aamfgltkqmcyk/jIRvzBq1NvYRkuVXYMY=
X-Google-Smtp-Source: AGHT+IGj8DyFJ+DNPzjQ0BI2My3osml72k4v+m89Ojwq+r/dL1UZJOmlcpnD5GshcjDtFe2BwjRf5g==
X-Received: by 2002:a17:907:72c1:b0:ab3:61e8:aa16 with SMTP id
 a640c23a62f3a-ab38b38134amr322541466b.43.1737121939347; 
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73eb59c6sm1482637a12.62.2025.01.17.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C1FF608D9;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 25/37] plugins: enable linking with clang/lld
Date: Fri, 17 Jan 2025 13:42:44 +0000
Message-Id: <20250117134256.2079356-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
Message-Id: <20250116160306.1709518-26-alex.bennee@linaro.org>

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


