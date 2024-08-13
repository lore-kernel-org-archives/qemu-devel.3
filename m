Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60829C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpeU-0001A3-4u; Tue, 13 Aug 2024 07:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdpeM-00014E-9X
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:25:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdpeJ-0001Aj-Lw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:25:13 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a80ea7084e9so61451866b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723548308; x=1724153108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O/ieWUNXdMTtU8qstGkpyqYRweTxfGCyppzY3AHfXJc=;
 b=zwU0/lPNICluefPTl419qZS6iM5m4UeKhmF2H649PuCfPdBIuq+afpSR4kr/xwWF8X
 1+lxJcd20QCIEA6JYJTaE1rrko4HKWjmOzSF1xWUQ10a+Qn+HqlQsvCS6FhK4nEhpIHp
 haRf9t/VQYxCvVRslMNqDl5DBlqZlPBSqvrh7fdKreh8f+SZ4E/omIg8tDyTTTWJc2VH
 BH59AoUAkcf06mMlOdZzoCN7SoHzxaoVcbhHoDAHPv4dvTLYpUq70jF1bcGwyTOSZWZQ
 Th/2H8VsxiYA3WaR2YFYtczt9G3PIt1Aomkt7D0UPxgy0f5OyOb4qZya/IUdUPT/zxSa
 WvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723548308; x=1724153108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O/ieWUNXdMTtU8qstGkpyqYRweTxfGCyppzY3AHfXJc=;
 b=UUAmkMqByv+P928L27alJ0EivK7yFIplrdkqYHC6VImAZuAoSUUMY+Ot/NNHM0VKcb
 K7AIp7hhJs2tC32q7KYe1r4PYx+4Lb5t447rLkFX4+uMTc32OgWZ/zGdEqpanPBlavNx
 95MhEqE6gS5KNAWY0i2vRfM4LPOnUHFVpW+v2/fwROtNATsyt7hOyJ9f6AV8wOvhuFCs
 vYkZ2aPxLR5s1yIuXSsHrsOmcgR82Fx7mQFKZnFc2aLE8JXX8USZhvD6z2Ar7MCB5lvL
 xJrGhUgeW6iKiDXH9ie3o7xavARlmiBH5RL6N1u0EO3sxbXDF0M+KbrT5OXofqpSUc5W
 A6wg==
X-Gm-Message-State: AOJu0YwUIKOrxjBtN8T5u3kXNRJ131C7ggCleCh6vdbJMvZlvpnCYUCt
 BGZLjjYyRPTe7DZVzacBP8yyeVBz9MHZqwSTCV7yODQeBywWXYA0hPOB+bVj/tMpgBLqXaJDsFK
 uWII=
X-Google-Smtp-Source: AGHT+IGIiafOzbkOji+rS3GEgOwiXqr5OIIHy6P/i4WqbIbN6cIIZLq/VGZgB7fzJ9Lj+L575zdrZg==
X-Received: by 2002:a05:6402:2111:b0:58e:2f7c:a9c with SMTP id
 4fb4d7f45d1cf-5bd44c66bd2mr3412760a12.26.1723548308025; 
 Tue, 13 Aug 2024 04:25:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a7ae8sm2914043a12.54.2024.08.13.04.25.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 04:25:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1] buildsys: Fix building without plugins on Darwin
Date: Tue, 13 Aug 2024 13:24:57 +0200
Message-ID: <20240813112457.92560-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since commit 0082475e26 the plugin symbol list is unconditionally
added to the linker flags, leading to a build failure:

  Undefined symbols for architecture arm64:
    "_qemu_plugin_entry_code", referenced from:
        <initial-undefines>
  ...
  ld: symbol(s) not found for architecture arm64
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  ninja: build stopped: subcommand failed.

Fix by restricting the whole meson file to the --enable-plugins
configure argument.

Fixes: 0082475e26 ("meson: merge plugin_ldflags into emulator_link_args")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/meson.build | 50 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 18a0303bff..1cc039d29b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,3 +1,7 @@
+if not get_option('plugins')
+  subdir_done()
+endif
+
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules
   if host_os == 'darwin'
@@ -12,29 +16,27 @@ if not enable_modules
   endif
 endif
 
-if get_option('plugins')
-  if host_os == 'windows'
-    dlltool = find_program('dlltool', required: true)
+if host_os == 'windows'
+  dlltool = find_program('dlltool', required: true)
 
-    # Generate a .lib file for plugins to link against.
-    # First, create a .def file listing all the symbols a plugin should expect to have
-    # available in qemu
-    win32_plugin_def = configure_file(
-      input: files('qemu-plugins.symbols'),
-      output: 'qemu_plugin_api.def',
-      capture: true,
-      command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
-    # then use dlltool to assemble a delaylib.
-    win32_qemu_plugin_api_lib = configure_file(
-      input: win32_plugin_def,
-      output: 'libqemu_plugin_api.a',
-      command: [dlltool, '--input-def', '@INPUT@',
-                '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
-    )
-  endif
-  specific_ss.add(files(
-    'loader.c',
-    'core.c',
-    'api.c',
-  ))
+  # Generate a .lib file for plugins to link against.
+  # First, create a .def file listing all the symbols a plugin should expect to have
+  # available in qemu
+  win32_plugin_def = configure_file(
+    input: files('qemu-plugins.symbols'),
+    output: 'qemu_plugin_api.def',
+    capture: true,
+    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+  # then use dlltool to assemble a delaylib.
+  win32_qemu_plugin_api_lib = configure_file(
+    input: win32_plugin_def,
+    output: 'libqemu_plugin_api.a',
+    command: [dlltool, '--input-def', '@INPUT@',
+              '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+  )
 endif
+specific_ss.add(files(
+  'loader.c',
+  'core.c',
+  'api.c',
+))
-- 
2.45.2


