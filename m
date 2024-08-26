Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496E8C5472C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 22:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihvq-00017s-Dq; Mon, 26 Aug 2024 18:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvn-0000w5-CZ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:23 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvk-0000n9-VQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:23 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a7d7ec7395so79874485a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724710278; x=1725315078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M2cEI0ZxrImGj+myUthr78dS5dgAOhCAVweFn3WwQM=;
 b=Z9yICaATLktuDI/oKZSVvp9fO4a7sE38J471AG6oX1HV6g1OPw0phE7/fcAUR+g9pn
 qpK2zoE/zsvxuiGQ7MEnHgUsEb424zT6y1zDmMR41bSL3F+U76pVTGxYefdcsAWAxF5e
 rTebM8eFnSn5YpDJVKVawOWYV2SJC3ajmC+tGEbJclDCZn6c2tB1b+0azIW9I18jv7rk
 tnKOSOIJ/l2P9nElGkbhDP10z1dC6lX2Fxz7N4aEyIZSe6h/4yIpc8FEFGWI7F35UEWF
 SqbQScz5al9Fm2VHTeru9UPHJo8rnN0qrEdXrEVcwqQwXUqG8AHAep1SeNSgvH60aTwd
 FbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724710278; x=1725315078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0M2cEI0ZxrImGj+myUthr78dS5dgAOhCAVweFn3WwQM=;
 b=sghHk/jmluIgJcWOlk2+0MfTaONYh3IWZDFu8SZZ22PCsV1RSpX9Y5XAf3WBCjm05Y
 2pYhmo9OxzD584dFhnBDonuoGfDq6GOnxmp6pnGJaLIcsgqK0fwPsUmJwVxJiOkc77XO
 x8Ot4R8pda3BsugUcpjg80ZtsbWgWr7PE8pzTdTIOpOZXp2F0cVlcTAmIIC37zJw4oD9
 SBVBQ0Dkgoi0fEXeB+9SZ/0qeAvZOI3DXJFD7hEt3DJ30pl63gbSwlcrrtjR5NNpoate
 /q2b2OHxvPydIR5KO/ZF98JY7VyfevVnjHQXU66pQw5zYtSnxhrQa+REvPWyXzm+EE4V
 r8iw==
X-Gm-Message-State: AOJu0YwmjCEWjP0jWakDIarxxSUWTXGnqWzPf7LJO+xepmUADKJ2UUp/
 zOR0NLlVhjs7zafN8Z4j0hib2klMQmkYMseatHAV9agOwOxu9esnmKmxBNnsc9e1dOWEEzukuNU
 b
X-Google-Smtp-Source: AGHT+IHRqn9+UUt7AFOsszyoeSDvWo3hGM/hbqzCRDOTEhCqq0WMDtXsWfc/lSmc90RlsC0Bsjy1VA==
X-Received: by 2002:a05:620a:31a7:b0:79f:d55:24dd with SMTP id
 af79cd13be357-7a6897b7ad1mr1387471685a.57.1724710278202; 
 Mon, 26 Aug 2024 15:11:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f361318sm489319185a.57.2024.08.26.15.11.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Aug 2024 15:11:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] tests/functional: Convert ARM Raspi2 avocado tests
Date: Tue, 27 Aug 2024 00:10:56 +0200
Message-ID: <20240826221058.75126-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826221058.75126-1-philmd@linaro.org>
References: <20240826221058.75126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x730.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         |   1 +
 tests/avocado/boot_linux_console.py |  85 -----------------------
 tests/functional/meson.build        |   1 +
 tests/functional/test_arm_raspi2.py | 103 ++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 85 deletions(-)
 create mode 100755 tests/functional/test_arm_raspi2.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e2e62afcdc..e2bbf1a994 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,6 +910,7 @@ F: hw/*/bcm283*
 F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
+F: tests/functional/test_arm_raspi2.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 370beb795a..226b92d057 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -203,91 +203,6 @@ def test_arm_emcraft_sf2(self):
         exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
             '3 packets transmitted, 3 packets received, 0% packet loss')
 
-    def do_test_arm_raspi2(self, uart_id):
-        """
-        :avocado: tags=accel:tcg
-
-        The kernel can be rebuilt using the kernel source referenced
-        and following the instructions on the on:
-        https://www.raspberrypi.org/documentation/linux/kernel/building.md
-        """
-        serial_kernel_cmdline = {
-            0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
-        }
-        deb_url = ('http://archive.raspberrypi.org/debian/'
-                   'pool/main/r/raspberrypi-firmware/'
-                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
-        deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id] +
-                               ' root=/dev/mmcblk0p2 rootwait ' +
-                               'dwc_otg.fiq_fsm_enable=0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-append', kernel_command_line,
-                         '-device', 'usb-kbd')
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-        console_pattern = 'Product: QEMU USB Keyboard'
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_arm_raspi2_uart0(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:raspi2b
-        :avocado: tags=device:pl011
-        :avocado: tags=accel:tcg
-        """
-        self.do_test_arm_raspi2(0)
-
-    def test_arm_raspi2_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:raspi2b
-        """
-        deb_url = ('http://archive.raspberrypi.org/debian/'
-                   'pool/main/r/raspberrypi-firmware/'
-                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
-        deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
-
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-                      'arm/rootfs-armv7a.cpio.gz')
-        initrd_hash = '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'earlycon=pl011,0x3f201000 console=ttyAMA0 '
-                               'panic=-1 noreboot ' +
-                               'dwc_otg.fiq_fsm_enable=0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'BCM2835')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                '/soc/cprman@7e101000')
-        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     def test_arm_raspi4(self):
         """
         :avocado: tags=arch:aarch64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 175e88bb87..ec77835199 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -29,6 +29,7 @@ tests_generic = [
 tests_arm_thorough = [
   'arm_canona1100',
   'arm_n8x0',
+  'arm_raspi2',
 ]
 
 tests_avr_thorough = [
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
new file mode 100755
index 0000000000..7a8f86edee
--- /dev/null
+++ b/tests/functional/test_arm_raspi2.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Raspberry Pi machine
+# and checks the console
+#
+# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import extract_from_deb
+from qemu_test.utils import gzip_uncompress
+
+
+class ArmRaspi2Machine(QemuSystemTest):
+
+    ASSET_KERNEL_20190215 = Asset(
+        ('http://archive.raspberrypi.org/debian/'
+         'pool/main/r/raspberrypi-firmware/'
+         'raspberrypi-kernel_1.20190215-1_armhf.deb'),
+        '9f1759f7228113da24f5ee2aa6312946ec09a83e076aba9406c46ff776dfb291')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+         'arm/rootfs-armv7a.cpio.gz'),
+        '2c8dbdb16ea7af2dfbcbea96044dde639fb07d09fd3c4fb31f2027ef71e55ddd')
+
+    def do_test_arm_raspi2(self, uart_id):
+        """
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+        serial_kernel_cmdline = {
+            0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+        }
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/kernel7.img')
+        dtb_path = extract_from_deb(deb_path, self.workdir,
+                                    '/boot/bcm2709-rpi-2-b.dtb')
+
+        self.set_machine('raspi2b')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE +
+                               serial_kernel_cmdline[uart_id] +
+                               ' root=/dev/mmcblk0p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         '-device', 'usb-kbd')
+        self.vm.launch()
+
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        linux_kernel_wait_for_pattern(self, console_pattern)
+        linux_kernel_wait_for_pattern(self, 'Product: QEMU USB Keyboard')
+
+    def test_arm_raspi2_uart0(self):
+        self.do_test_arm_raspi2(0)
+
+    def test_arm_raspi2_initrd(self):
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/kernel7.img')
+        dtb_path = extract_from_deb(deb_path, self.workdir,
+                                    '/boot/bcm2709-rpi-2-b.dtb')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('raspi2b')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,0x3f201000 console=ttyAMA0 '
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BCM2835')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                '/soc/cprman@7e101000')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


