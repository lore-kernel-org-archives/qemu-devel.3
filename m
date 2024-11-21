Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F546D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWY-00064M-H9; Thu, 21 Nov 2024 11:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVz-0004wp-Jn
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVa-00087j-6P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso13465235e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208300; x=1732813100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5sQx390WX16rPflQuG3fyG6MjkwMEEP336vMFADYxQ=;
 b=Hx3hoKQPrKAAoMuIOAFw9kY/cLrwerCMRpc/3QQMpQxRQgqV/QzWtR1qnkCOz3qOe9
 yapgCs93EnOqH4bsakisVkA2l/jS0xKQrQqZvzDvQr4gXZQt12SU+/1sssyN3i/Lg3ws
 LlEdBOAlB4yh3niXPWjskp6JCFwD1gvk46TKjjx6lw7P9IlOD+QwaskY9g9DfYcN9A4n
 GgHijXXAAyxLUfRbDtIVlTUp0+5SZItUBTU9I5B42mwuCN776vXFTnS6baIB6q9TSDPL
 sAgrRWu5aPjeVgplJ9IRuNfLwCdaLw5Ia6lNnNmxs4f2GFjMowJzXYBOW0GYSW2PKMuO
 w0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208300; x=1732813100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5sQx390WX16rPflQuG3fyG6MjkwMEEP336vMFADYxQ=;
 b=TNRitoo/6byWjJRu+vPK4AMSfZVxm6T8U+H9PGXfIulR5FZioitVOSYM6IHzfmO672
 pBpIR3+cBflUyTkwfx8RMNumpXpN/9x8a9JYZ3MQf8C5k9LVVzqWn9LqSSLKgYaSjmab
 pGhknY75igKRBfSyevB2qJ7gD5CF+SYu0r5xfpQhZGPmRp2pFckbLYivZaxSTaZnrH1P
 Gi7HZwEgN86yA3ph4L76GQM9wsqNTCfp/rpm7ehAqAMtmc+cJ62HMn8T7qeQ4PxBa3/1
 XLCjmYYkD/K7fdPcWdIcd/2d1UBtTi5H+eqaGs+VJGsAn39OO3jXYV6iikxw99FIuSAZ
 N6Vg==
X-Gm-Message-State: AOJu0YzBcHVuMI2B8/YIPvS5yOEDD/dl8wn2OMAXNtDbqLdP/SPEJoz0
 VKfa5tz+VJkQMPvVDDvXJUB5cL8xZJNuPQL58g6MqWJ1oyf74Hxzo+pEUv1Gutw=
X-Gm-Gg: ASbGncsWO3H7lSvWxA6+58Do6megkmjc4LGuSh0nsoxqJo+fZO5iWueDdYVlG8ieMWL
 6LgVdyVpwJ+yjeGYGR9kn++AxtTieJMZdwnbQ14tOCn9eB4CITiKdXEcbNCL07gHZ+XghWBEBIt
 kTAoX4VYWIjocn+u+mTkomow5kesZIWp3QHyNgXar7EsENu3ltvQxMpIQsfVepWhIYpB3m8uAmf
 SnNHv2UmUyIvYdwHz0BJ6nC4jVk1D/rAkzO8hTmEXDA0cv+
X-Google-Smtp-Source: AGHT+IFfOxCiQV45h8DxYrwdRyuAkAKBudFuCE/1IvOgdFqlvwf/mDBmijE50A4pf0QU6/MMcK1u6g==
X-Received: by 2002:a05:600c:3514:b0:431:9a26:3cf6 with SMTP id
 5b1f17b1804b1-43348981878mr80506225e9.4.1732208298915; 
 Thu, 21 Nov 2024 08:58:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d17e3sm64258435e9.5.2024.11.21.08.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B509B604F0;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 36/39] plugins: detect qemu plugin API symbols from header
Date: Thu, 21 Nov 2024 16:58:03 +0000
Message-Id: <20241121165806.476008-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 MAINTAINERS                    |  1 +
 plugins/meson.build            | 12 ++++++---
 scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100755 scripts/qemu-plugin-symbols.py

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


