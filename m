Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B2C5472C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 22:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihw8-0001dv-QA; Mon, 26 Aug 2024 18:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihw6-0001Z3-GT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:42 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvz-0000o3-6A
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:40 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d5c7f24372so3816734eaf.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724710293; x=1725315093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxkZyPjrQIekWw74uypp5hQxZ1PkXPvvySJAc4LQR1A=;
 b=GQfaI748s3ekty/UCsR/f0GdOgkHd6nL8/hcAJPmVjVV1IXBFMvITy51HfqgOVXMM+
 jKIDwJ6OsKvwLWHe/DdwqY33PY4N4N3sOT7yNRPcAameKCWmfYRA9CDo2p4OrLAlL+7B
 qdoX7bhRpem7aBoyb/+MtkMdPf1QthKkXd2/FZMEa9+gJQVyDXC/jEfsX33zJ88YUlJm
 +hjhW3JNxLGms3V7AGlA6r8BSexgyfv5PIeglVgSK+qqEhCkh+H3+Wpl8FRSgDnGzsCq
 ye6H4C3hJLcaPgJJ9FLKU/5+UDKw/cWi0TShncJQMI2ezdBk3rQ4sdpgGAEkhvz/9qnd
 KSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724710293; x=1725315093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxkZyPjrQIekWw74uypp5hQxZ1PkXPvvySJAc4LQR1A=;
 b=tH1BsApYSnAZBdctErSlhok4z2yEBI9TaUEMUyqnJRjN0diYDgfiNCcdtDipeC0Oe6
 NFFzvogOfJW8jxc0Urd/UrbUMj2CJRAg21EfFZmpCKxDtmFNO1PZOCIGGpiuUOyn/sZa
 y5rDpYqSyfRVvA3Cwg5PGinsS5AwaHzL++OrdLllhVW8DR+BH3Aug4WI86TPfc2NgLre
 QPsaIGtASrCv9n/XVbmGK7rMh1RxNyWcxO7ZQV9bLodSHr5SIxOWIDb8juKNsPDOcSHL
 1VEOn4G7P/hjfombIqMPU+A3NpHhMmVyt+VCzh7s1MkadlDs75Yaytz4ErTC+vs0cIiK
 /8mw==
X-Gm-Message-State: AOJu0YzKkjIcoMPwR86jf2C9VPjyojOSJgl/7aWqqYSaLgAT+1F5EpL1
 hq+1BDZdiOwytgIEAdji+4+XGNa5LY6XCrZaV0/tcJ0oF9aUs+a4CroUlAuGqCrRpBRo+3pawh+
 S
X-Google-Smtp-Source: AGHT+IFeeTOXc4YgEyuxjJzg+b2WhTWCHKXtDLeHqAwUPP+rkm5bjNKbgkexno4jzSFSetME3uHN6w==
X-Received: by 2002:a05:6358:4285:b0:1b1:a961:7977 with SMTP id
 e5c5f4694b2df-1b5ec0e3d12mr168334955d.29.1724710293499; 
 Mon, 26 Aug 2024 15:11:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162db1e9asm50538536d6.80.2024.08.26.15.11.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Aug 2024 15:11:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] tests/functional: Convert Aarch64 Raspi4 avocado tests
Date: Tue, 27 Aug 2024 00:10:58 +0200
Message-ID: <20240826221058.75126-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826221058.75126-1-philmd@linaro.org>
References: <20240826221058.75126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 MAINTAINERS                             |   1 +
 tests/avocado/boot_linux_console.py     |  97 ----------------------
 tests/functional/meson.build            |   1 +
 tests/functional/test_aarch64_raspi4.py | 106 ++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100755 tests/functional/test_aarch64_raspi4.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce41df6d8..75816b0606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -912,6 +912,7 @@ F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
 F: tests/functional/test_arm_raspi2.py
 F: tests/functional/test_aarch64_raspi3.py
+F: tests/functional/test_aarch64_raspi4.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index cb7301a456..3efb7f652a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -203,103 +203,6 @@ def test_arm_emcraft_sf2(self):
         exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
             '3 packets transmitted, 3 packets received, 0% packet loss')
 
-    def test_arm_raspi4(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:raspi4b
-        :avocado: tags=device:pl011
-        :avocado: tags=accel:tcg
-        :avocado: tags=rpi4b
-
-        The kernel can be rebuilt using the kernel source referenced
-        and following the instructions on the on:
-        https://www.raspberrypi.org/documentation/linux/kernel/building.md
-        """
-
-        deb_url = ('http://archive.raspberrypi.org/debian/'
-            'pool/main/r/raspberrypi-firmware/'
-            'raspberrypi-kernel_1.20230106-1_arm64.deb')
-        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'earlycon=pl011,mmio32,0xfe201000 ' +
-                               'console=ttyAMA0,115200 ' +
-                               'root=/dev/mmcblk1p2 rootwait ' +
-                               'dwc_otg.fiq_fsm_enable=0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-append', kernel_command_line)
-        # When PCI is supported we can add a USB controller:
-        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
-        #                '-device', 'usb-kbd,bus=xhci.0',
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-        # When USB is enabled we can look for this
-        # console_pattern = 'Product: QEMU USB Keyboard'
-        # self.wait_for_console_pattern(console_pattern)
-        console_pattern = 'Waiting for root device'
-        self.wait_for_console_pattern(console_pattern)
-
-
-    def test_arm_raspi4_initrd(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:raspi4b
-        :avocado: tags=device:pl011
-        :avocado: tags=accel:tcg
-        :avocado: tags=rpi4b
-
-        The kernel can be rebuilt using the kernel source referenced
-        and following the instructions on the on:
-        https://www.raspberrypi.org/documentation/linux/kernel/building.md
-        """
-        deb_url = ('http://archive.raspberrypi.org/debian/'
-            'pool/main/r/raspberrypi-firmware/'
-            'raspberrypi-kernel_1.20230106-1_arm64.deb')
-        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
-
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '86b2be1384d41c8c388e63078a847f1e1c4cb1de/rootfs/'
-                      'arm64/rootfs.cpio.gz')
-        initrd_hash = 'f3d4f9fa92a49aa542f1b44d34be77bbf8ca5b9d'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'earlycon=pl011,mmio32,0xfe201000 ' +
-                               'console=ttyAMA0,115200 ' +
-                               'panic=-1 noreboot ' +
-                               'dwc_otg.fiq_fsm_enable=0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        # When PCI is supported we can add a USB controller:
-        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
-        #                '-device', 'usb-kbd,bus=xhci.0',
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'BCM2835')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'cprman@7e101000')
-        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
-        # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
-        # Wait for VM to shut down gracefully
-        #self.vm.wait()
-
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3fab8e0d0c..a03a4b9156 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -28,6 +28,7 @@ tests_generic = [
 
 tests_aarch64_thorough = [
   'aarch64_raspi3',
+  'aarch64_raspi4',
 ]
 
 tests_arm_thorough = [
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
new file mode 100755
index 0000000000..62178416fd
--- /dev/null
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -0,0 +1,106 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Raspberry Pi machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import extract_from_deb
+from qemu_test.utils import gzip_uncompress
+
+
+class Aarch64Raspi4Machine(QemuSystemTest):
+
+    """
+    The kernel can be rebuilt using the kernel source referenced
+    and following the instructions on the on:
+    https://www.raspberrypi.org/documentation/linux/kernel/building.md
+    """
+    ASSET_KERNEL_20190215 = Asset(
+        ('http://archive.raspberrypi.org/debian/'
+         'pool/main/r/raspberrypi-firmware/'
+         'raspberrypi-kernel_1.20230106-1_arm64.deb'),
+        '56d5713c8f6eee8a0d3f0e73600ec11391144fef318b08943e9abd94c0a9baf7')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '86b2be1384d41c8c388e63078a847f1e1c4cb1de/rootfs/'
+         'arm64/rootfs.cpio.gz'),
+        '7c0b16d1853772f6f4c3ca63e789b3b9ff4936efac9c8a01fb0c98c05c7a7648')
+
+    def test_arm_raspi4(self):
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/kernel8.img')
+        dtb_path = extract_from_deb(deb_path, self.workdir,
+                                    '/boot/bcm2711-rpi-4-b.dtb')
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'root=/dev/mmcblk1p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        # When PCI is supported we can add a USB controller:
+        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+        #                '-device', 'usb-kbd,bus=xhci.0',
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        wait_for_console_pattern(self, console_pattern)
+        # When USB is enabled we can look for this
+        # console_pattern = 'Product: QEMU USB Keyboard'
+        # self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Waiting for root device'
+        wait_for_console_pattern(self, console_pattern)
+
+
+    def atest_arm_raspi4_initrd(self):
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/kernel8.img')
+        dtb_path = extract_from_deb(deb_path, self.workdir,
+                                    '/boot/bcm2711-rpi-4-b.dtb')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        # When PCI is supported we can add a USB controller:
+        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+        #                '-device', 'usb-kbd,bus=xhci.0',
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BCM2835')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'cprman@7e101000')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+        # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
+        # Wait for VM to shut down gracefully
+        #self.vm.wait()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


