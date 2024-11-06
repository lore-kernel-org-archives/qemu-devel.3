Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B593D59F53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jXR-0004r5-8o; Wed, 06 Nov 2024 12:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXO-0004oF-J5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:46 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXM-0004ZZ-Mn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:46 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f84907caso7687279e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730912983; x=1731517783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPA8Cc1mdZFWuTHCl3i+/VHbdFpR2xccyaZdsIZIIaM=;
 b=WzFGC/bB5DdPciU2yk986DGoqqvUV7+/CFU1rgjRvcj1wmS/XQP2B4eVyK+00N16ti
 W5yQYADOQOtTMRWiXd7rc+uEmyyVyaZ2YCZYPOEfPJpqA0ZCvaPQSE4hO5FaS1LzPT58
 GvnUoZ+REwSvflaxp5FxqgGpkzbEYSg3+eydkJylx6aH0b0uNldJEdtYVZxM5V6m+FZk
 8g7RKu+hKYKEzeGpKNL0E9n25vRfjkTOJstwt4jhHvgCHmvQLM2FR3vmOigx9L3wzm9f
 OtPWH3sUXVwL9/zqHwYnwXeihAPviojvjH0CK8R+RtzIZi7xsLbmRxGZE4o5FNc/hU/E
 vKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730912983; x=1731517783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPA8Cc1mdZFWuTHCl3i+/VHbdFpR2xccyaZdsIZIIaM=;
 b=vyRc4Zx1C7CNQNcxqqc7WBfabIwAvMtk6w2EAu0saUJsY8BV5ailqGiP9z7qA6d1GV
 hIryKcoidFmC7qHX/EskkEiwwnJTya94xe62TdncYqWU8K7u+tMoN0/2v5xDRHsy+IkS
 fA6AFOvz9DEii56JncYDLIycwOQLlVknS1AEuKhFEfl+08kRQnMqaJiuOtrlnaen2kYN
 +6VlvBRSnCJLEHkNPT8p1zHO63uqxStfAsFBXyv+Xhha2BdouSUvpNlkigfu9hggCpR4
 t2vkCo+/iypvuOE+2DCwEKvNerVu8uBm/XYy9Nc4iW4zqaj0ZDmuv5RBiPlSXneW4K8G
 hPRA==
X-Gm-Message-State: AOJu0YxAEo3Ok2sfK5j5g0wWQmGUjFN+QP19U2vGC3nYcwoWLGceqYuC
 nv1iROXm5y7KUTXPszJ89LZDTL2KELrsiTMgm0zxXPUymkR8p2sjawVVAfZmVngk8Rhp0/OCJa+
 B7gYtTfgo
X-Google-Smtp-Source: AGHT+IEXPLKjeYiRUIuihCfqZe7rkM/WO+E4IDstpWtT9SuoQrgZOm9yRk16B6FcIzRhEkTbEzen0Q==
X-Received: by 2002:a05:6512:b82:b0:539:e4b5:10e5 with SMTP id
 2adb3069b0e04-53b348ec004mr21536432e87.9.1730912982670; 
 Wed, 06 Nov 2024 09:09:42 -0800 (PST)
Received: from linaro.. ([193.32.126.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2d13sm28918935e9.12.2024.11.06.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:09:42 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 2/3] plugins: detect qemu plugin API symbols from header
Date: Wed,  6 Nov 2024 09:09:22 -0800
Message-Id: <20241106170923.2976750-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12f.google.com
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

Instead of using a static file (error prone and hard to keep in sync),
we generate it using a script.

Note: if a symbol is not exported, we'll now notice it when linking for
Windows/MacOS platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                    |  1 +
 plugins/meson.build            | 12 ++++++---
 scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100755 scripts/qemu-plugin-symbols.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0844f5da196..022e9f0f57f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3746,6 +3746,7 @@ F: plugins/
 F: tests/tcg/plugins/
 F: tests/functional/test_aarch64_tcg_plugins.py
 F: contrib/plugins/
+F: scripts/qemu-plugin-symbols.py
 
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/plugins/meson.build b/plugins/meson.build
index 51297582f93..d60be2a4d6d 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -2,11 +2,17 @@ if not get_option('plugins')
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
@@ -15,7 +21,7 @@ if not enable_modules
     # LLVM/lld does not support exporting specific symbols. However, it works
     # out of the box with dllexport/dllimport attribute we set in the code.
   else
-    emulator_link_args += ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
+    emulator_link_args += ['-Xlinker', '--dynamic-list=' + qemu_plugin_symbols.full_path()]
   endif
 endif
 
@@ -24,7 +30,7 @@ if host_os == 'windows'
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
index 00000000000..e285ebb8f9e
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


