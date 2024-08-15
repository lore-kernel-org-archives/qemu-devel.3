Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B9C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnH-0004Bx-KG; Thu, 15 Aug 2024 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn4-0003VX-0k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-0000Co-P2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso1341963a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733358; x=1724338158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYuCdV1ZyypnBkOQom8SjG60bCuzuxobSZg1OwBHFdk=;
 b=O2d5eFYarK8rjagqIDeHbgc3JGFlXkBXWDO1GqeL10a5wjvNeomQPZG7WhjLJ/oSs2
 5jbF+U7e+rai1ryxhrUYoWIokJgjxe/jVsG3gEqdj1VAJnwIYspkul4VriJ/6VgHKCTp
 +mMQiO6eUCbUftzVXd0skSGoPI8Cb3M06d3aqvz5OFJXEoPBqItEerggZ/s/xjdgvFKh
 w3wPrK37E9vmM8C0rGujyAOeipVIw0NH+7/ZlrUy3ydyNOReqftgeyP+0RzArbzmN2tR
 yIyylRwX1pluOeqEmng0CxuWAoacJ8vSEXtA9t3BTpQv9WK69lfFxwh9ey++vXBtapLN
 cZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733358; x=1724338158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYuCdV1ZyypnBkOQom8SjG60bCuzuxobSZg1OwBHFdk=;
 b=hLcQ1KU9K6t2B9VsCg2WO4StQGzVhq30HbVA9aX066H1qETkDVJsgCObWdHDBGZrOo
 RoqAXcaIu9sXuZdFcldcbycUH6rvNgEzYyHkAskqwYESWl8EpYJrv7KDkR22TexSPCNv
 7TfER46XMUzBhMlz9o465x8O7K4mbdBqeDXPwvjrpMXQWqyiqdfffqk6SVU/z6bG91mg
 h6wmpEv7y62M72SwFzjAgY5I9kiiZ0u+Vt/jyKcDThdsf5pbXMtnOT1RP5ZCmpLsbtMO
 V9tobm2HpiqRl9XXMl0ktNlA/flAaqVI47qzLzgD1fnFaeEtaSAPg6uN5RoLpP3In/zl
 jzJQ==
X-Gm-Message-State: AOJu0YxeWAmSpv2Ayl06mIsTOqrwn4lqE3wQ8p5D0n0uBqqTwX9VdXaA
 cYhED8kHNzOG1RhCkBPgXB7JDETLkX5pyQkWzLGmLrzbM3y1QC8zz8zUN70cVOo=
X-Google-Smtp-Source: AGHT+IHnK0W0JlmGU+dwzmyXNucu9cfL2BQktxsgdXDkBXHDvall0HsYxSdryLlDUzuzVx97PTJ4ew==
X-Received: by 2002:a05:6402:27c8:b0:5af:874d:1b7b with SMTP id
 4fb4d7f45d1cf-5bea1c6ccfamr4177154a12.1.1723733357941; 
 Thu, 15 Aug 2024 07:49:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfb923sm964102a12.54.2024.08.15.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71A825F9DD;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/21] buildsys: Fix building without plugins on Darwin
Date: Thu, 15 Aug 2024 15:48:58 +0100
Message-Id: <20240815144911.1931487-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2476
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240813112457.92560-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-9-alex.bennee@linaro.org>

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
2.39.2


