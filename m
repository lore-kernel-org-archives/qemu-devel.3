Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05133D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaz6-0007Wd-Uk; Mon, 25 Nov 2024 10:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayn-0006zk-TO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayk-0002Ym-RZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso3508324f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548379; x=1733153179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZrySn/V6spoVfFw52szUouQyzG89nZr7ULlEg8CZ30=;
 b=Y8VK0qKg7bkAwMDBZehEzPKgIdfh77XUwkZ9aneEy8ByeyjA8cMihoIWYD2LzUVDV/
 vakJtPaMN4twUMOub4WIa9mWwZfaa/m3K6UqSIDgd89GfslGLLcMnDM38qBX5bDqVp1i
 RkZUzBjPVFr2VqKfCJiV/kHlmwCUEOvqUvhPVPDJErk8wIrHYg0vefc2QZaomu+s5/iS
 CFPuRyEsh1Ir9Y0yQ1wWUc7kmR8dbSS8yRdOo7ZCmLGc9ZCJk5pA0jSc/1u2v71NuIuJ
 Jr0ooeTV0L/BoIc0xjHUrNMhlrAgM1CUUfvDDu8B0eH398BqzlYc3ENHRloW5LH8yS6g
 EojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548379; x=1733153179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZrySn/V6spoVfFw52szUouQyzG89nZr7ULlEg8CZ30=;
 b=Fn13D/NVZ7C75TfVQSCxgjsP/ag2aoq1Uky6siWifrkWQvjHn8u3ZWzchj2a3yHQ7x
 2pH8ccfQjssclWCtu4ahoCMyxLFjSQfj670qx5zKGhiulJ4Wq0ujKG2l51wWkIzIvmID
 cfg+VxiaXd+vMUBOKsoqT5hsUBPH8ClSezgmi9pU2Lz+zXF1oRrGA2Yhw498zGp7P0j4
 8cuyYLOh9v2rNAwqaXoSRHU+zRn7pRuOm7+vuvA7qGKrdFyLXsPUn/W0t0ROvUGkMnOO
 H0Qq3V53F+6srCY0fOCAFIttt75wSxa+4Yana03HulgrSaA5uE8QWpeoqsIWoSsdZNb/
 1QMg==
X-Gm-Message-State: AOJu0YzB3rbnvg/OOnsIjIoK75lf1fXeCgTSJKNjarRSyRLNaJIHfAYb
 Ea61RGclaeoQ7xXLVOfbBn6iGDYZKixXaw2j4SBPt4QtrPNdDPXvYzpqTQfrcPs=
X-Gm-Gg: ASbGncurWiPid663udaljZn6vNGJYCTuPKmuVZYVGz8cqjlcg676CczBYruQddcZDoO
 poGJqqxOj06M7b3oFOKydAMq/vuIQZWJvi6rXrOZlEfHuuan7kILrYnfYCiqy3FPb+MS7MLsx2q
 u+fM+b4KPB5DfOUgRt1dpYFKBL2a/o+qW97y2oZEjDP07K9NEr/Dp+hWyWayUhD9zvfDrBhXUTs
 tbjmAPwNUSl4p5G4rDL9ov4AUauZWCYq7vo6/gtCg4AzfzU
X-Google-Smtp-Source: AGHT+IFegvUvrTW5uM/EorYhklEIGS0i1K9NRZZrMB5qzIcglBsw1bsvvJWj10buUiRpMCFV6byWzg==
X-Received: by 2002:a05:6000:144c:b0:37d:2d27:cd93 with SMTP id
 ffacd0b85a97d-38260bcb460mr12243489f8f.43.1732548378686; 
 Mon, 25 Nov 2024 07:26:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbee043sm10684677f8f.104.2024.11.25.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8EED62948;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 22/28] plugins: detect qemu plugin API symbols from header
Date: Mon, 25 Nov 2024 15:20:59 +0000
Message-Id: <20241125152105.2100395-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Instead of using a static file (error prone and hard to keep in sync),
we generate it using a script.

Note: if a symbol is not exported, we'll now notice it when linking for
Windows/MacOS platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241112212622.3590693-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-37-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index eb7149bf1a..2b1c4abed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3752,6 +3752,7 @@ F: plugins/
 F: tests/tcg/plugins/
 F: tests/functional/test_aarch64_tcg_plugins.py
 F: contrib/plugins/
+F: scripts/qemu-plugin-symbols.py
 
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/plugins/meson.build b/plugins/meson.build
index 1cc039d29b..98542e926f 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -2,17 +2,23 @@ if not get_option('plugins')
   subdir_done()
 endif
 
+qemu_plugin_symbols = configure_file(
+  input: files('../include/qemu/qemu-plugin.h'),
+  output: 'qemu-plugin.symbols',
+  capture: true,
+  command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
+
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules
   if host_os == 'darwin'
     configure_file(
-      input: files('qemu-plugins.symbols'),
+      input: qemu_plugin_symbols,
       output: 'qemu-plugins-ld64.symbols',
       capture: true,
       command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
     emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
   else
-    emulator_link_args += ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
+    emulator_link_args += ['-Xlinker', '--dynamic-list=' + qemu_plugin_symbols.full_path()]
   endif
 endif
 
@@ -23,7 +29,7 @@ if host_os == 'windows'
   # First, create a .def file listing all the symbols a plugin should expect to have
   # available in qemu
   win32_plugin_def = configure_file(
-    input: files('qemu-plugins.symbols'),
+    input: qemu_plugin_symbols,
     output: 'qemu_plugin_api.def',
     capture: true,
     command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
new file mode 100755
index 0000000000..e285ebb8f9
--- /dev/null
+++ b/scripts/qemu-plugin-symbols.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+#
+# Extract QEMU Plugin API symbols from a header file
+#
+# Copyright 2024 Linaro Ltd
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import re
+
+def extract_symbols(plugin_header):
+    with open(plugin_header) as file:
+        content = file.read()
+    # Remove QEMU_PLUGIN_API macro definition.
+    content = content.replace('#define QEMU_PLUGIN_API', '')
+    expected = content.count('QEMU_PLUGIN_API')
+    # Find last word between QEMU_PLUGIN_API and (, matching on several lines.
+    # We use *? non-greedy quantifier.
+    syms = re.findall(r'QEMU_PLUGIN_API.*?(\w+)\s*\(', content, re.DOTALL)
+    syms.sort()
+    # Ensure we found as many symbols as API markers.
+    assert len(syms) == expected
+    return syms
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description='Extract QEMU plugin symbols')
+    parser.add_argument('plugin_header', help='Path to QEMU plugin header.')
+    args = parser.parse_args()
+
+    syms = extract_symbols(args.plugin_header)
+
+    print('{')
+    for s in syms:
+        print("  {};".format(s))
+    print('};')
+
+if __name__ == '__main__':
+    main()
-- 
2.39.5


