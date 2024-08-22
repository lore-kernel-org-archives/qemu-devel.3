Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE0CC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5an-0002ZV-JH; Thu, 22 Aug 2024 07:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5ae-0002YI-GE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:02:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5aY-0004Bo-Sl
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:02:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so4427705e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724324564; x=1724929364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ekVmEMWWyS4pVL0hWTOxtB5Sws3gNTkEYcun8LN2+58=;
 b=lWXjb+WmCSkSwnVUPmgA7563N0oT69vmN76+j6iKqvbIDnB+KXbKy31d6OKOizrB2Y
 9cAr8lY0ASy1HaW/YbzkTyvSskOx3HXKUmmQhQq/kGcAr4qZKbNAPsvWq57aY+jy4S6G
 RnBLARdl1A8Mm+G8FzQxx0ZHHt5MYsolDEOF4Lj8+4rm2dp/rqR7lEcSnzZ3f48ZvgYo
 QiS3r6CU5I2R8lUZjhD2D+v9K33jYMbSPieHyYgmYfh7HMm+u/uBWyDb+TSEFjMy467P
 qCZv+K7hwGxmJjmyToi1QN+horwhQG9jiTr2/vco8hM747A+9yLUtF7tXVZfLvHF53Xf
 /kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724324564; x=1724929364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekVmEMWWyS4pVL0hWTOxtB5Sws3gNTkEYcun8LN2+58=;
 b=rs3x+Hq9LscrU2n+HwabvSb71Ew/sA3TGOSxDM/JdJLR77HayxpvAQwgCr5h8Grie3
 g4ry/Pm1Oe5BnwYKLie3GhT/n2ZM+Q012z6RPgpLX0KxmRP95JKXZFxubBrmyJ+2vR01
 FnmftccYtpluiYWduoOkNhTb0VDWwFqw+A+5a0UtrPOFcX80ryDnY9g0yq7gbMQN7XSq
 KZrT9t08FVkgc1cb10Dc+Ad43Y6LvCVc0dSWAAsdXf3RBxfeK4epePyJfBY3FtTsQ4RB
 A14y9clVESRRFQ0G3T9O3QeNE0LeRkYhD4OI/wwqtIv2oNmhZjtakEhNh26Akc3MDt4F
 JkOA==
X-Gm-Message-State: AOJu0YwTjAT1y1/XHcIMOraiBvaBr2IIx73d68n66MOxMrGgnYCTUVGb
 rqSji9Q3hmuWu5oDMTRWdalZ4XcMS3ZV1ynyU5ZZMorH5N6Vxh5l/cnPIJX9TmOp3GMWq9PSupP
 l
X-Google-Smtp-Source: AGHT+IF6k8D38esvOi2JNdmmiR6o+AB36khJhrhvO+huKR1SxID1OIZ7yY9NrnOhT5ocpOxXY6BPbw==
X-Received: by 2002:a05:600c:314f:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-42abf050d6fmr32182945e9.13.1724324563620; 
 Thu, 22 Aug 2024 04:02:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730826b4b5sm1377786f8f.115.2024.08.22.04.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 04:02:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Convert ARM Integrator/CP avocado tests
Date: Thu, 22 Aug 2024 13:02:38 +0200
Message-ID: <20240822110238.82312-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

  $ QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 make check-functional-arm
  ...
  6/6 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_integratorcp   OK   3.90s   2 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240821082748.65853-1-thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  1 +
 .../test_arm_integratorcp.py}                 | 56 ++++++++++---------
 3 files changed, 33 insertions(+), 26 deletions(-)
 rename tests/{avocado/machine_arm_integratorcp.py => functional/test_arm_integratorcp.py} (63%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b480135f6..91e5b061bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -785,7 +785,7 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
-F: tests/avocado/machine_arm_integratorcp.py
+F: tests/functional/test_arm_integratorcp.py
 F: docs/system/arm/integratorcp.rst
 
 MCIMX6UL EVK / i.MX6ul
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f8e482a87c..f1fce045fc 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -28,6 +28,7 @@ tests_generic = [
 
 tests_arm_thorough = [
   'arm_canona1100',
+  'arm_integratorcp',
   'arm_n8x0',
 ]
 
diff --git a/tests/avocado/machine_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
old mode 100644
new mode 100755
similarity index 63%
rename from tests/avocado/machine_arm_integratorcp.py
rename to tests/functional/test_arm_integratorcp.py
index 87f5cf3953..0fe083f661
--- a/tests/avocado/machine_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -7,13 +9,15 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
 import logging
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from unittest import skipUnless
 
 
 NUMPY_AVAILABLE = True
@@ -33,50 +37,49 @@ class IntegratorMachine(QemuSystemTest):
 
     timeout = 90
 
+    ASSET_KERNEL = Asset(
+        ('https://github.com/zayac/qemu-arm/raw/master/'
+         'arm-test/kernel/zImage.integrator'),
+        '26e7c7e8f943de785d95bd3c74d66451604a9b6a7a3d25dceb279e7548fd8e78')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/zayac/qemu-arm/raw/master/'
+         'arm-test/kernel/arm_root.img'),
+        'e187c27fb342ad148c7f33475fbed124933e0b3f4be8c74bc4f3426a4793373a')
+
+    ASSET_TUXLOGO = Asset(
+        ('https://github.com/torvalds/linux/raw/v2.6.12/'
+         'drivers/video/logo/logo_linux_vga16.ppm'),
+        'b762f0d91ec018887ad1b334543c2fdf9be9fdfc87672b409211efaa3ea0ef79')
+
     def boot_integratorcp(self):
-        kernel_url = ('https://github.com/zayac/qemu-arm/raw/master/'
-                      'arm-test/kernel/zImage.integrator')
-        kernel_hash = '0d7adba893c503267c946a3cbdc63b4b54f25468'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        initrd_url = ('https://github.com/zayac/qemu-arm/raw/master/'
-                      'arm-test/kernel/arm_root.img')
-        initrd_hash = 'b51e4154285bf784e017a37586428332d8c7bd8b'
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
 
+        self.set_machine('integratorcp')
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
                          '-initrd', initrd_path,
                          '-append', 'printk.time=0 console=ttyAMA0')
         self.vm.launch()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_integratorcp_console(self):
         """
         Boots the Linux kernel and checks that the console is operational
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:integratorcp
-        :avocado: tags=device:pl011
         """
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
 
     @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
     @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_framebuffer_tux_logo(self):
         """
         Boot Linux and verify the Tux logo is displayed on the framebuffer.
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:integratorcp
-        :avocado: tags=device:pl110
-        :avocado: tags=device:framebuffer
         """
         screendump_path = os.path.join(self.workdir, "screendump.pbm")
-        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
-                       'drivers/video/logo/logo_linux_vga16.ppm')
-        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
-        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
+        tuxlogo_path = self.ASSET_TUXLOGO.fetch()
 
         self.boot_integratorcp()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
@@ -97,3 +100,6 @@ def test_framebuffer_tux_logo(self):
         for tux_count, pt in enumerate(zip(*loc[::-1]), start=1):
             logger.debug('found Tux at position [x, y] = %s', pt)
         self.assertGreaterEqual(tux_count, cpu_count)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


