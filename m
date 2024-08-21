Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C43C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgku7-0008Ru-9b; Wed, 21 Aug 2024 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgku2-000889-N3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:57:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgku0-0005A6-JE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:57:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso54999145e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724245045; x=1724849845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd/SCxyYkI0efJQ+vnAG1pfl86SvWJjE5pQY9rON6c4=;
 b=YZODph6CMD6QXeCpE6+qoRSB9dd/MyNpeeV1DIKBm/iziofSOIjp7NnRZden46c3UB
 zuZ3mY+D6lkYHKSwKIQ/b7vUT0sTihExoMW7pM/vf88LBv42shauQ2AMe4rGL2gHOD3c
 QVXUMKc34Qi6yu3Zrvxv+o6E3NGpTyJLtL4SdOikAHnilOK6yKecgJCxMhNf1r/4BMvj
 bJFZhq+2KegUFnhgP0hVl+vpMtLkC3WJ37dDyonC99X+KzXGElWhgn5khBBxQe7JRnGr
 8W4Mr3GY+UQG+/3fIca5rCC1EUXP4vlANiUmcPB89+IaddUi/du85dfQ5iN0NZE+IK4g
 YPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724245045; x=1724849845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gd/SCxyYkI0efJQ+vnAG1pfl86SvWJjE5pQY9rON6c4=;
 b=p2gVU2iBndvoeD56W2uq4Unx3wBbe1RSKZ5R32OxEkRJDyv7WhJ3cNiddka34h0iz0
 3r5VcmKUFEG8LNiL0241kKoP7XV7LfHYw6amaO/+dxe3sLPZAJGVyp7PlEWBzc7cMrXU
 fWxvC7gHpe3wK/YQ7vYh+GMI4gZDHEdGUak22ACTFMKJ5duF++KIBSRV81ddaNgxEy0a
 BiZ8s4wMFiTQiX1h/zwitxh8fsPEZE6BqCdEGUCsyBeRWC4KlNyAK1jdawWPMF6x0Efr
 6NvS7IkCq/IHpTQE1VSW52gtn5IHMYYky1fzp19a4lP06kci4ozbJQ5D7I8GD1oZGKma
 4E9Q==
X-Gm-Message-State: AOJu0YyKWr3FjUYhYNbnWRQ/CmIGSjkuli5McR/VQFZlzEdsJEjQ1+JG
 Xum4/n9hurgIjsvdS5zl8d9d6NDOPRi8NUIonWk8zR4WUjywIUmU+ZrKiftiHUnL9fuElTqIexj
 dvWE=
X-Google-Smtp-Source: AGHT+IGqcV7qknfUlRwPuM7LqvpWUlgg/5xPKTsjzraOhH4jmI1Lr0iouysM93Lmhto55PIIPDX6TA==
X-Received: by 2002:a05:600c:4451:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-42abd25466fmr16936955e9.31.1724245045084; 
 Wed, 21 Aug 2024 05:57:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed91134sm25490105e9.4.2024.08.21.05.57.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 05:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Beraldo Leal <bleal@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 2/2] tests/functional: Convert mipsel Malta YAMON avocado test
Date: Wed, 21 Aug 2024 14:57:01 +0200
Message-ID: <20240821125701.63042-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821125701.63042-1-philmd@linaro.org>
References: <20240821125701.63042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Straight forward conversion using the Python standard zipfile
module instead of avocado.utils package. Update the SHA1 hashes
to SHA256 hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                             |  2 +-
 tests/avocado/machine_mips_malta.py     | 54 -------------------------
 tests/functional/meson.build            |  4 ++
 tests/functional/test_mips64el_malta.py |  3 ++
 tests/functional/test_mipsel_malta.py   | 46 +++++++++++++++++++++
 5 files changed, 54 insertions(+), 55 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a91017979..4b480135f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,7 +1368,7 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
-F: tests/avocado/machine_mips_malta.py
+F: tests/functional/test_mipsel_malta.py
 F: tests/functional/test_mips64el_malta.py
 
 Mipssim
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
deleted file mode 100644
index 05c64e18c4..0000000000
--- a/tests/avocado/machine_mips_malta.py
+++ /dev/null
@@ -1,54 +0,0 @@
-# Functional tests for the MIPS Malta board
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import interrupt_interactive_console_until_pattern
-from avocado_qemu import wait_for_console_pattern
-
-
-class MaltaMachine(QemuSystemTest):
-
-    def do_test_yamon(self):
-        rom_url = ('https://s3-eu-west-1.amazonaws.com/'
-                   'downloads-mips/mips-downloads/'
-                   'YAMON/yamon-bin-02.22.zip')
-        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
-        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
-
-        archive.extract(zip_path, self.workdir)
-        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', yamon_path)
-        self.vm.launch()
-
-        prompt =  'YAMON>'
-        pattern = 'YAMON ROM Monitor'
-        interrupt_interactive_console_until_pattern(self, pattern, prompt)
-        wait_for_console_pattern(self, prompt)
-        self.vm.shutdown()
-
-    def test_mipsel_malta_yamon(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
-
-    def test_mips64el_malta_yamon(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1823f88897..67f6e7257e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mipsel_thorough = [
+  'mipsel_malta',
+]
+
 tests_mips64el_quick = [
   'mips64el_fuloong2e',
 ]
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 05d2c5f85b..fd5aeb982e 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -107,5 +107,8 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
+from test_mipsel_malta import MaltaMachineYAMON
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
new file mode 100755
index 0000000000..5d2a7a5493
--- /dev/null
+++ b/tests/functional/test_mipsel_malta.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 32-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import wait_for_console_pattern
+from zipfile import ZipFile
+
+
+class MaltaMachineYAMON(QemuSystemTest):
+
+    ASSET_YAMON_ROM = Asset(
+        ('https://s3-eu-west-1.amazonaws.com/downloads-mips/mips-downloads/'
+         'YAMON/yamon-bin-02.22.zip'),
+        'eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab')
+
+    def test_mipsel_malta_yamon(self):
+        zip_path = self.ASSET_YAMON_ROM.fetch()
+        with ZipFile(zip_path, 'r') as zf:
+            zf.extractall(path=self.workdir)
+        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        self.vm.add_args('-bios', yamon_path)
+        self.vm.launch()
+
+        prompt =  'YAMON>'
+        pattern = 'YAMON ROM Monitor'
+        interrupt_interactive_console_until_pattern(self, pattern, prompt)
+        wait_for_console_pattern(self, prompt)
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


