Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AFDC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglTj-0003I8-8U; Wed, 21 Aug 2024 09:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTh-0003Al-CW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTe-000643-UW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so4631005e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247253; x=1724852053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7/Y7/lBLXE9FyePaqxwotN83mnpsX2vN2kMgbhA74k=;
 b=GImgtMHa8fKAZN4PkD5/8S35gFunOrPxCzCwTmiUS+FVQrd0gNhMwmimZ/k/17uRo0
 9dy2+cLq+4Wc5iXycbKf6whov37WYSnIeUcSfDkuJXd2Q1nCxCAQcqKm5oV+NSYyH37F
 BMl6UB/TeRNU61D+wTTdU0bEMCAu1454GMVUwtmEFNtb8OLJJqtusnz8dUw4GxxkeC4c
 dQc0yHQM4/orcuxxu4YOhF7vyKSkukzB3OmGqA/ZKIiCofwVI1dXGrZpFBdTfbf0yHKE
 Y+1YJ8IjlA/tVvq2VUw07EMl8/etNK5JttQmGQXoeE6MAJxPomkXh2CwP1h+JSJOT6O0
 VcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247253; x=1724852053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7/Y7/lBLXE9FyePaqxwotN83mnpsX2vN2kMgbhA74k=;
 b=IevfAh361EiLD4lH8UwwEtTKAey4fz0NzaxJQgHAgnUzdMCSN/WHpyM4UZ49xrImKQ
 yNmWObCMtrdXhXKXetLP4hyeLG86T0QnLB30T94p75s41c5OxT3mxFdWAMCze4bQCMPF
 2KBFEsfR9fmhQVHXO4QziBuGHgxybpruuZP4z2qaB5egcL78wxLiu7NwVlbCx3Bnnzdi
 YDuZ05dzRtELIZWuTAtj4kiFd0CEbQPTDlkhCw9w8n2UmD6sEsOj+6lcKl9UB4MTAe6T
 vVrVLzxtYcnAQBtNH80YofV+cMeLzf/bHH/qZRu0o9P35pe2xCgbhQR9cA86PJrLwuDS
 J/OQ==
X-Gm-Message-State: AOJu0YxasJiZHVk9m/r1cWLmzMAAVfBhltbuPWTbAKYtqD9Jx5tEqQ8H
 ptsJAlHEz3lqOQJFk9iM0s9EmkPQoolLGRuFBORvQVJk2xTMahTJL25aH8PwNTmF9nAE2tZMiOd
 04us=
X-Google-Smtp-Source: AGHT+IG/h4I916NW+SQ5MMaztH5a4o9H6iMt2ZdJHvf00mKhCFUGX62J7jz2irbYNtlkFkyri0+p5A==
X-Received: by 2002:a05:600c:4749:b0:42a:a749:e6 with SMTP id
 5b1f17b1804b1-42abe667051mr14807115e9.10.1724247252546; 
 Wed, 21 Aug 2024 06:34:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37195c57d48sm13628794f8f.53.2024.08.21.06.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 06:34:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 2/3] tests/functional: Convert mips64el Malta I6400 avocado
 tests
Date: Wed, 21 Aug 2024 15:33:52 +0200
Message-ID: <20240821133353.65903-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821133353.65903-1-philmd@linaro.org>
References: <20240821133353.65903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                             |   1 +
 tests/avocado/machine_mips_malta.py     | 108 -----------------------
 tests/functional/meson.build            |   1 +
 tests/functional/test_mips64el_malta.py | 111 ++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 108 deletions(-)
 create mode 100755 tests/functional/test_mips64el_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fbb5d42e..3a91017979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1369,6 +1369,7 @@ F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
 F: tests/avocado/machine_mips_malta.py
+F: tests/functional/test_mips64el_malta.py
 
 Mipssim
 R: Aleksandar Rikalo <arikalo@gmail.com>
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 07a80633b5..05c64e18c4 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -8,121 +8,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import gzip
-import logging
 
-from avocado import skipUnless
-from avocado import skipUnless
 from avocado.utils import archive
 from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 
 
-NUMPY_AVAILABLE = True
-try:
-    import numpy as np
-except ImportError:
-    NUMPY_AVAILABLE = False
-
-CV2_AVAILABLE = True
-try:
-    import cv2
-except ImportError:
-    CV2_AVAILABLE = False
-
-
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
-class MaltaMachineFramebuffer(QemuSystemTest):
-
-    timeout = 30
-
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-
-    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
-        """
-        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
-        """
-        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
-
-        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
-                      'a5966ca4b5/mips/malta/mips64el/'
-                      'vmlinux-4.7.0-rc1.I6400.gz')
-        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
-        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        kernel_path = self.workdir + "vmlinux"
-        archive.gzip_uncompress(kernel_path_gz, kernel_path)
-
-        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
-                       'drivers/video/logo/logo_linux_vga16.ppm')
-        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
-        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'clocksource=GIC console=tty0 console=ttyS0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-smp', '%u' % cpu_cores_count,
-                         '-vga', 'std',
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        framebuffer_ready = 'Console: switching to colour frame buffer device'
-        wait_for_console_pattern(self, framebuffer_ready,
-                                 failure_message='Kernel panic - not syncing')
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
-        logger = logging.getLogger('framebuffer')
-
-        match_threshold = 0.95
-        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
-        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
-        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
-                                   cv2.TM_CCOEFF_NORMED)
-        loc = np.where(result >= match_threshold)
-        tuxlogo_count = 0
-        h, w = tuxlogo_bgr.shape[:2]
-        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
-        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
-            logger.debug('found Tux at position (x, y) = %s', pt)
-            cv2.rectangle(screendump_bgr, pt,
-                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
-        if debug_png:
-            cv2.imwrite(debug_png, screendump_bgr)
-        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
-
-    def test_mips_malta_i6400_framebuffer_logo_1core(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        """
-        self.do_test_i6400_framebuffer_logo(1)
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        :avocado: tags=mips:smp
-        :avocado: tags=flaky
-        """
-        self.do_test_i6400_framebuffer_logo(7)
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        :avocado: tags=mips:smp
-        :avocado: tags=flaky
-        """
-        self.do_test_i6400_framebuffer_logo(8)
-
 class MaltaMachine(QemuSystemTest):
 
     def do_test_yamon(self):
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8d28313a65..a82dbd43bb 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -57,6 +57,7 @@ tests_mips64el_quick = [
 
 tests_mips64el_thorough = [
   'mips64el_loongson3v',
+  'mips64el_malta',
 ]
 
 tests_ppc_quick = [
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
new file mode 100755
index 0000000000..05d2c5f85b
--- /dev/null
+++ b/tests/functional/test_mips64el_malta.py
@@ -0,0 +1,111 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 64-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import logging
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import gzip_uncompress
+from unittest import skipUnless
+
+NUMPY_AVAILABLE = True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE = False
+
+CV2_AVAILABLE = True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE = False
+
+
+@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+class MaltaMachineFramebuffer(QemuSystemTest):
+
+    timeout = 30
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/raw/a5966ca4b5/'
+         'mips/malta/mips64el/vmlinux-4.7.0-rc1.I6400.gz'),
+        '1f64efc59968a3c328672e6b10213fe574bb2308d9d2ed44e75e40be59e9fbc2')
+
+    ASSET_TUXLOGO = Asset(
+        ('https://github.com/torvalds/linux/raw/v2.6.12/'
+         'drivers/video/logo/logo_linux_vga16.ppm'),
+        'b762f0d91ec018887ad1b334543c2fdf9be9fdfc87672b409211efaa3ea0ef79')
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
+        """
+        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
+        """
+        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+
+        kernel_path_gz = self.ASSET_KERNEL.fetch()
+        kernel_path = self.workdir + "vmlinux"
+        gzip_uncompress(kernel_path_gz, kernel_path)
+
+        tuxlogo_path = self.ASSET_TUXLOGO.fetch()
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'clocksource=GIC console=tty0 console=ttyS0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-cpu', 'I6400',
+                         '-smp', '%u' % cpu_cores_count,
+                         '-vga', 'std',
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        wait_for_console_pattern(self, framebuffer_ready,
+                                 failure_message='Kernel panic - not syncing')
+        self.vm.cmd('human-monitor-command', command_line='stop')
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        match_threshold = 0.95
+        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
+        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
+        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        tuxlogo_count = 0
+        h, w = tuxlogo_bgr.shape[:2]
+        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found Tux at position (x, y) = %s', pt)
+            cv2.rectangle(screendump_bgr, pt,
+                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
+        if debug_png:
+            cv2.imwrite(debug_png, screendump_bgr)
+        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
+
+    def test_mips_malta_i6400_framebuffer_logo_1core(self):
+        self.do_test_i6400_framebuffer_logo(1)
+
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
+        self.do_test_i6400_framebuffer_logo(7)
+
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
+        self.do_test_i6400_framebuffer_logo(8)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


