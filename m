Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C899C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3l-0005RF-7B; Tue, 13 Aug 2024 16:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3j-0005NT-RQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3R-0006Cz-0O
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso3888734f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580618; x=1724185418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K1C3X/MhQMRep+HimQDatYHRQUqPTx7ZX7Xy6/ZA3U=;
 b=f4R3VzB41z0tyDSiA/kinJjA4wV2z5S8JhLV6lAENTw6X97Gj88Y3sv4ZTaO7Ol1DL
 1Rr8heyItrZmMjT0ZYbz3nWBxDBlnRcYabFzQNQaWgCQz/GZ8NDygLuvv+rfaD1gWCLh
 Zrq0ApOwxtuJHRJq3uD8zBpQqOYfiFyx6HaWIEgEQcJUe/qBndhnzJRWPIFBH5h1HBJi
 RyxyTwUuhoghg8qk0XwUJFTC9jeBjmS44FgiPd9ldfCPzMisZYOg72hC79FILnvUTFQG
 L415foepNLdqWp3poBF1Y7QUxeg9v+bvScPeTdFlFpKTxKSotag+AV+GuKMGcl7lkCNf
 Ql2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580618; x=1724185418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K1C3X/MhQMRep+HimQDatYHRQUqPTx7ZX7Xy6/ZA3U=;
 b=P9T636QINO/BiQ4TjnlMn242GSe4TjcGWqzB/uJQKGVvsgIWsVvMBx5rbnCSRos1yq
 VAmsCRJqHaH0CHKSC1xvvwnYu4z06B0g4LDwliEQ/G2WWX2L58uwCXzKBd78ulLowoee
 Tycb9jcw3Q8je/RsxCsldv7QPi//CINNCHB0EVnhYqgTbFQcj1UD4x+Au+HYKmu+CFj6
 s+/UezN07pDMvJwLRA8qNn6ZaIOCB0sM95WnrpW+JLxzl+eCH65YTXz1rKZyrYsBy7QR
 /oxObzaS6Rvgo6HYgLKkGwBM605F1qTOlP9B9nkxVsGIkxRSwFwbNlCvoFxru8UHKKxZ
 +8pA==
X-Gm-Message-State: AOJu0YwK2bzSW9bEl5r87KylY63XvkOZVlFLDWQLyBoMtZo4fAT6wgQw
 BxlRKAaGuBOdRJzK2InndlzIN3Zvh2omvbJnlsqeUlm6cQIh6yppZa83mxvPez0=
X-Google-Smtp-Source: AGHT+IEU+aaBShj6NyVlR1MYI7wsafuWxTum9koxEZZyFw+THPkXCTfrrGOD44yAHcYOsLlxxnwvpw==
X-Received: by 2002:a05:6000:1fa1:b0:368:31c7:19dd with SMTP id
 ffacd0b85a97d-37177769777mr575507f8f.5.1723580617875; 
 Tue, 13 Aug 2024 13:23:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4e51ebc2sm11228817f8f.83.2024.08.13.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25FD35F9E6;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 08/21] buildsys: Fix building without plugins on Darwin
Date: Tue, 13 Aug 2024 21:23:16 +0100
Message-Id: <20240813202329.1237572-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240813112457.92560-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


