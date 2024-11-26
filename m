Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0FD65559
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2wi-0001WZ-JP; Tue, 26 Nov 2024 16:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wh-0001Vx-18
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:07 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wf-0001bB-6g
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:06 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so5368286a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732655883; x=1733260683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oi405Te5zlAvKGQ9MzdgLBP2VXUFNr+apC11qm7Xajc=;
 b=eJPDqdinsyb4+b0xf9fOP2KXIcKFJrTJiPFzV7WESEo2rREVAJMaR9n6iYtD4Mvx3e
 Dko7S4Tmc/zwhcp0gg4FoyKg1Z+qC3L2p/HNLodN1ZBv0mCWN0s/h6VpiczSj8eXxC7e
 9z66FFX1VCbtgLtFV04K+Dr7+9apltLVESFbZKXTQI2xjmW3ROu/TrQH8m5ZEq1blRo3
 bsRPeVa1r/m5O/drgBHt5ClKAf7GX77p0IxtHJXkEt4tsYBdK3BmVJRNL2kPs3Ge1QGV
 bdGPHOVBbKTdM6qeWGDk0MOHpIKryPwsEFOXTtUd1w81ZsMwVYdk4hcYZMoJ9qWtvShM
 tF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655883; x=1733260683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oi405Te5zlAvKGQ9MzdgLBP2VXUFNr+apC11qm7Xajc=;
 b=iw9uJ8bPmthDaMROK5AVPQB/Tv+dtXnk5oo+TY0TpZQVIMJC93GiXuTbehbHgVgzZ3
 jvVfGl1naIVV4mPtq2mctV3kCNlVhzhqcEScIYElEGSo1jXwdoMRAGVLBYG7EZ2ef//Z
 J5bzcE62pmiqD92PBSVoW4d8W8euu3DV+jLE8xwZujnGhE96AivLIu920kp7Au36lRBx
 bG0tHrfK7p7ShXkpSW8bHI0QL2ToxdocQqD4xkj50GP2kqn6UL+40wELWWZ2tptD9Uts
 xccXjAVvMkcYnEU6CWNpvgwZXRgHYJZb6ewbEcn/WwhUuYldoWaZLsraaXCCCNaPhP1u
 zAhw==
X-Gm-Message-State: AOJu0YyOVMo7uDW5djUzbFQnzLNoeZjXbZEJiWWkPkT6eIZWYho+likU
 poQfALLKnwotr1tb6eWa0GU/bKvEh5yAcRu8PGZb0GNkVEktabmxpA8q/r2EblFQbOkga9z8Ll7
 vLrw=
X-Gm-Gg: ASbGnctpfucuxMgaiTE4rMN2lIpnRtUjE8GjPQm+rlZYjonUnOjCE2KKm/1KddACVh1
 +3s/UMpQE0IR0HqTsP5IPdTHyL+dJn4hbhfOYXe1nYicgKYI4vlAyU3PXYG6XoCYPujCPjZH1IH
 2bPTPGCIq6Xb7IBdyNjsf8VRcKOOt+2hFjmit4m4s5Zx6Jl+PUaFvVZP/mjKSOaR1O36PMy7iIA
 c8Rq5oc1VRfE9+EGFNcPinW2RwjjpkftmXE9f2cUi4uEV6B86UauHaBVUXJCRW+AYdSatDgMsml
 82dDXhARium7KA==
X-Google-Smtp-Source: AGHT+IFSr0V6WplWRv6eT319QuhYwKto8CCOLi3Cz5OkU+v9X/NsB08e9UauvWq/liEV/iJal9wZnA==
X-Received: by 2002:a05:6a21:3397:b0:1e0:db67:e9f9 with SMTP id
 adf61e73a8af0-1e0e0b120ffmr1407474637.22.1732655883559; 
 Tue, 26 Nov 2024 13:18:03 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724fd95ed01sm5811766b3a.8.2024.11.26.13.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 13:18:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 3/3] plugins: enable linking with clang/lld
Date: Tue, 26 Nov 2024 13:17:36 -0800
Message-Id: <20241126211736.122285-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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
index fa6d24e1233..8ccee3f5b34 100644
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


