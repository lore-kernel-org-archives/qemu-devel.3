Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BCDD29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufK-0006mn-3E; Mon, 19 Jan 2026 14:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufG-0006kp-Kh
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:50 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufE-0001TN-Tf
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:50 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so31100905ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849907; x=1769454707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFKbsM3qIWMkfta7hvDRMqA1Yk5rjnAEb5KzFLPEyHs=;
 b=IGMe+Wz2vsboKLhRgAJy2kYkVutuLloGUbQCv5q7SGrJsJANnvvpC7bOsoZNyM/10t
 7dEiQL1ZzqmchGJ3AWFo3Tst9iC3QSCrb6APcsVKYvdUMOHohs9eAdp9Jb54o2lZ+r/0
 F4KIuTklV37v3+b2ezDCQeucqx91IkiLfp5XRMm2wNZiXb4GPEP7xIIzgxC1Y7KuGCeO
 RA7OTg6nTk7RAutVZGpmqwZhQerlkm+fwKHD46sfjXjti4OhSOKTbqDKmnNxu6uRK3Ii
 LnlGpJdkD9Ekauf1tHY3RZ6scQsSQs90NIgfB909ogbWLjnLKlctjEjM0ZZZ2J0JZKzq
 tuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849907; x=1769454707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFKbsM3qIWMkfta7hvDRMqA1Yk5rjnAEb5KzFLPEyHs=;
 b=L3CmdZ0pUV/g4HPQJq7DBcycV3MOSFnkf9Zxlnc6yB/4dvzrf0Y2dYOjfmZnr+UYD9
 REYBka2VKFsRrelvEYSWSERImopG/q5pfaBKnMIs5DmvoYfLJdqfKSjSh/zlxRxUmq7Q
 RZ9DnMIH/J20a/jJDBVbRRtnsQ1Fs3cgMJ8HPzUmR/YxoL30hPHEGu4r6KHYJ/5VCU1G
 /J0exnN/lfB0hjePKHfTQjpM6WH+111uU9Rf6xujDdPFDB7LDNeUp/lMyRoJFot4zcEw
 kN5Vt10IQoaagGpVd+rP1uMmn4gIwd1fFxhsLFPmaLszgqWaIwP4xrrs59jIu2uyokMR
 hFRA==
X-Gm-Message-State: AOJu0Yw8g6syyCLSHA6qfwBgFmKZ33kWWmR6Q45FdvPtFD9gETxq3TaC
 bs7abWsiA1z2xX/yBC9+q6oEMpdYbZeXScpM+eaMqZCo3M5+hYnOvf/Os9caefAZKq7zxxDc3Q/
 dWVJE
X-Gm-Gg: AZuq6aL8b4ZtsQcchOv2v2gmRLLZi319PcRPSepUZbudTukNSyX4ZKtpD/WFsUCmJk7
 dr8GohqFQ8nDzGQcDJwpqsaYK7Af4x4jjSzAUVOtBP2KI+0G680/ENhnWGI0amz8ABUZGAMc8PY
 JS4gnTTPmIhL207p098MYyKj++YeVkeP3+7vTqFT2UCFHA2NleZTKXwGXABmQCk4h/54zkS793X
 Dtn3bOLJlldxemu7Odt5fxWX3UrHMUQjO7ii5/lHyTpeU2GTzdPLOof4M2uZeTEDnGzaAbWMQAv
 EzJto9QcgXcNbyt0tOTmRVf1lMsQfV53tbU95YfHAW/8fzWxR0RGu0l0PaCMvLvVOd1NuETZiab
 lIvQagtGdl+r3MBhi3aVCTE8jwimq+fsrFRo2ZTPM1gloQzIQeYZyrCoPbb0klzYPq1qOP4Hf8u
 U1uDWX/dhmieY9OfHUM8zZXcTQztu9IKEJx9MQoMjwMAYMHlgy7kmNleKYfSFbs0hLUpWGwGONE
 8g=
X-Received: by 2002:a17:903:2288:b0:295:9cb5:ae07 with SMTP id
 d9443c01a7336-2a718928ebdmr101565225ad.38.1768849907302; 
 Mon, 19 Jan 2026 11:11:47 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/11] plugins: factorize plugin dependencies and library
 details
Date: Mon, 19 Jan 2026 11:11:28 -0800
Message-ID: <20260119191138.811069-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 3108f01e887..6f02547df9b 100644
--- a/meson.build
+++ b/meson.build
@@ -4447,7 +4447,7 @@ if get_option('plugins')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
-    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+    install_data(win32_qemu_plugin_api, install_dir: 'lib')
   endif
 endif
 
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6f72b2ce0c9..6915ffa5fbc 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -9,17 +9,8 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
-                        include_directories: '../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87fc..4318e3a1671 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -51,11 +51,24 @@ if host_os == 'windows'
     dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
                    '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
   endif
-  win32_qemu_plugin_api_lib = configure_file(
+  win32_qemu_plugin_api = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
     command: dlltool_cmd
   )
+  win32_qemu_plugin_api_lib = static_library('win32_qemu_plugin_api',
+                                             link_depends: win32_qemu_plugin_api)
+endif
+
+if host_os == 'windows'
+  plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
+                                    include_directories: '../include/qemu',
+                                    link_with: win32_qemu_plugin_api_lib,
+                                    link_args: win32_qemu_plugin_api_link_flags,
+                                    dependencies: glib)
+else
+  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+                                    dependencies: glib)
 endif
 
 user_ss.add(files('user.c', 'api-user.c'))
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index a6e78438510..d7823704616 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,17 +1,8 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
-                        include_directories: '../../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


