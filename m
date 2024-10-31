Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18E6E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQy-0003sP-OX; Thu, 31 Oct 2024 00:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQp-0003kW-43
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:11 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQn-00053e-5A
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:10 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e91403950dso392295a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347507; x=1730952307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sPdHdQJ35Fr/SOKKnyBguzQdXGmWsCiWtlEfDPVHMQ=;
 b=eqhjkCZ5x0rnw1R4BkY/zmAK2bN604e2aRg5MdiXurbRxcr/V0iKEsj56O8h+M+5Gb
 NcqiWa4m6fvfpcYDQG056R1Y1sMt/LPyw6z8TzXXbgsSxIhhA8LHEJjXdZ7WMtxsrkZu
 P1vkV9LuMwLrX0GA2AHVzUonzjJjFhlDx+a74PjTnJYcXG0hE/R7zsqiUmjTVNksfAIt
 +iuiCU5Bjmq0Ue7Rit8xVCatW0/IXsQAifXfxNQyuRc+GbKEydBvPL6mUOmLOX04x9d2
 q0NiHHtSDexLuJHKILvCeh1rhdf9EZZPGW+yDHT/dwpZt/0hWxsY4QdRTQUIbGtuseh9
 gTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347507; x=1730952307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sPdHdQJ35Fr/SOKKnyBguzQdXGmWsCiWtlEfDPVHMQ=;
 b=vLvZqAxXbgGW0kZG55O9bElB2tFUc4WpC85XOR0Q5lH8I8+agJ3MDnXN6Bda7czmSF
 8ik3xlGkpCVsDcxFwF6WP9BfiyX3f7ny2tB/YH9ZkoPRvrMfnbNPLzeNhSic4fVeiehZ
 oIQjx9Syk3CEymSwSJXNBef1nRIPhfo9xpWHpV6+c4/tmq+7AksVOWqJZ0M6z413Ks3g
 VKz9WV20dYtaof9YfyRmRxCafriCNGtrK+kA+vZ0kIwB6oLOlhF9dcCDd17r0NwANLqj
 IpEZqnU1tGHIy9vol7Vp55VJx7fUygxiJ8Ng6KH2Q8LipGsMwHZpylt5scxHqY3gW4Er
 d/8g==
X-Gm-Message-State: AOJu0YxhvEsAgkJNPkTQzCrYlMG2wiqWUmR2XiXrhcgA6evRGFNpVtZ/
 PWG1EV3Czu6Qs8Av+pONai4krkuZnFkawYhMPf/+dcpG4Dq6iqef94m7Rd4ONjHI/9dQg4DLG62
 A9+jozQ==
X-Google-Smtp-Source: AGHT+IHuNs/tznTYNp/AUVQMJ6NqDV9uYOqGmX0xPvakJbIHYFI2CFPqQ3UO41+4oI0oxgBxhgTN2g==
X-Received: by 2002:a17:90a:d481:b0:2e0:d957:1b9d with SMTP id
 98e67ed59e1d1-2e8f1071c8dmr21944997a91.13.1730347507133; 
 Wed, 30 Oct 2024 21:05:07 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/12] plugins: detect qemu plugin API symbols from header
Date: Wed, 30 Oct 2024 21:04:24 -0700
Message-Id: <20241031040426.772604-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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
index f48d9142b8a..d34b6606e95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3719,6 +3719,7 @@ F: plugins/
 F: tests/tcg/plugins/
 F: tests/avocado/tcg_plugins.py
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


