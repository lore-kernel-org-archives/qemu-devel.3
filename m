Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB721C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispT-0001TY-2u; Tue, 27 Aug 2024 05:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispQ-0001SY-Q4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:32 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispO-00089m-DK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a86a37208b2so466434266b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752168; x=1725356968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ld9LWP58d7ahMlzIkedRlsqTQK3wS2q25nmh4L82PQg=;
 b=UuyQCY0RCZCCKh9CBjTE7D8xYxllp1bbiJf7zDMK39/xct646EReT/Ui7kSExgzdFv
 QmqG7o2lo/TuqtSEJ733voPJJiImon3YaohGiPzrB+6eujTVR8UtknuEuUiQRvkTQs0n
 W3TC90dFk+vgzJHTGSMOSBx6HXBQDyBBNd7ZhOdLO8ZaVoh9hjuLUArz3kJNGWqVes7Q
 LjhAOmtKoxE4yaYH4G6iA7ujqxM6yah0R0qvvzcjhGJlT+jBF6Rqxuw8uvebImqJ8rwX
 TizZhCV7rR525I9WYJnupWlSHDhxK0i8l9fAK5IX5l+J77fdSR4MN2hiNzyysUBkJHyk
 GulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752168; x=1725356968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ld9LWP58d7ahMlzIkedRlsqTQK3wS2q25nmh4L82PQg=;
 b=ZBfzuFTWZclc0aMg+NKyGtGtZnoFVTXayHFxBKFftwjLw3znv8FbAkifxElhB7IgF1
 or96pFMelYyJMFV6PcnuEBe2GFkExuczJeKXvDmnS0ACtpHEFO9egpbXaMawUEs0RnU3
 dEZt0aFc58TnWSzlAtNEa6fsz2V07q459qL/xrqO6+xlSalRQsJ9R3+CqyGOtSzUgSOE
 5wMPqAnZ2jT/yVhhpHHejPLazzVBrrx0qUsU8nPUo8rwqNj1g38SQQU4QwIu+VbvtMd3
 9bosp/WYfOGvPJuFpXHJQfzEephrcYvVCk/oCVOjUGGHnqkeYdWiKS5Z2ddfLkc2z+HT
 6tOw==
X-Gm-Message-State: AOJu0YwX5rJVyPLwpfsun0lvWC/h6qA5LicUF1HQiCfVAHYL+bo/Ua78
 KJ++KueRu0fbZUJ10vLyagz8gkKyaiOKQUUAdWo5LBjHmyz0GRliBIVO7WLoGqK53791AIslBGE
 K
X-Google-Smtp-Source: AGHT+IE0FWaf04ZzyH3i6VB7YXnIakHC0nPHDyZeSY9jcZS7mL5CE35bCuYcYJh78iH5BMGjiuhDkQ==
X-Received: by 2002:a17:907:1c0a:b0:a86:a90f:3025 with SMTP id
 a640c23a62f3a-a86a90f3de8mr951840766b.59.1724752168260; 
 Tue, 27 Aug 2024 02:49:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e582d43dsm87574266b.115.2024.08.27.02.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 3/7] tests/functional: Convert mips64el I6400 Malta avocado
 tests
Date: Tue, 27 Aug 2024 11:49:01 +0200
Message-ID: <20240827094905.80648-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
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

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                             |   1 +
 tests/avocado/machine_mips_malta.py     | 108 -----------------------
 tests/functional/meson.build            |   1 +
 tests/functional/test_mips64el_malta.py | 110 ++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 108 deletions(-)
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
index 0000000000..9c1da8f401
--- /dev/null
+++ b/tests/functional/test_mips64el_malta.py
@@ -0,0 +1,110 @@
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
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
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
+    ASSET_KERNEL_4_7_0 = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/raw/a5966ca4b5/'
+         'mips/malta/mips64el/vmlinux-4.7.0-rc1.I6400.gz'),
+        '1f64efc59968a3c328672e6b10213fe574bb2308d9d2ed44e75e40be59e9fbc2')
+
+    ASSET_TUXLOGO = Asset(
+        ('https://github.com/torvalds/linux/raw/v2.6.12/'
+         'drivers/video/logo/logo_linux_vga16.ppm'),
+        'b762f0d91ec018887ad1b334543c2fdf9be9fdfc87672b409211efaa3ea0ef79')
+
+    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
+        """
+        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
+        """
+        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+
+        kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
+        kernel_path = self.workdir + "vmlinux"
+        gzip_uncompress(kernel_path_gz, kernel_path)
+
+        tuxlogo_path = self.ASSET_TUXLOGO.fetch()
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE +
+                               'clocksource=GIC console=tty0 console=ttyS0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-cpu', 'I6400',
+                         '-smp', '%u' % cpu_cores_count,
+                         '-vga', 'std',
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        linux_kernel_wait_for_pattern(self, framebuffer_ready)
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


