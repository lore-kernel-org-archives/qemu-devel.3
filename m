Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798EFECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08a-00050O-23; Tue, 10 Sep 2024 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08W-0004XP-0g
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08N-0005Bv-Ne
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVaaTJLyg1RTdI2f1wGKW2XRJiJ9kTbEGsOe2P0JmTg=;
 b=XvzRfRGF5oOqVhLIhWkLpvHLb17nbeKRaJCZ5p8u7/Ob0h+uMrLUDyKgKASzknedEdjGZ/
 ntFWEZjlPtoGlJxXnIxK1MJBlNzJTG+cBtQVIsw6EWjpTxNIc/X5QbfZu016dahacCZugU
 YQS+DrNakz9R9t1RmP1sH15NVw7XdB4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-iZPSThNEPEe1-aIs8CG02w-1; Tue,
 10 Sep 2024 08:38:10 -0400
X-MC-Unique: iZPSThNEPEe1-aIs8CG02w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56BBB1954233; Tue, 10 Sep 2024 12:38:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C474B19560AB; Tue, 10 Sep 2024 12:38:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/22] tests/functional: Convert Aarch64 Raspi4 avocado tests
Date: Tue, 10 Sep 2024 14:37:18 +0200
Message-ID: <20240910123726.182975-18-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240826221058.75126-5-philmd@linaro.org>
[thuth: Use LinuxKernelTest class]
Message-ID: <20240906180549.792832-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |  1 +
 tests/avocado/boot_linux_console.py     | 97 ------------------------
 tests/functional/meson.build            |  1 +
 tests/functional/test_aarch64_raspi4.py | 99 +++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 97 deletions(-)
 create mode 100755 tests/functional/test_aarch64_raspi4.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 828c469478..c59f7b2538 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -913,6 +913,7 @@ F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
 F: tests/functional/test_arm_raspi2.py
 F: tests/functional/test_aarch64_raspi3.py
+F: tests/functional/test_aarch64_raspi4.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index e4caf34379..a8eac44d9f 100644
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
index 35eebbe9b9..a79083b0f9 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -36,6 +36,7 @@ tests_generic_bsduser = [
 
 tests_aarch64_system_thorough = [
   'aarch64_raspi3',
+  'aarch64_raspi4',
   'aarch64_sbsaref',
   'aarch64_virt',
 ]
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
new file mode 100755
index 0000000000..e5c9f77479
--- /dev/null
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Raspberry Pi machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import gzip_uncompress
+
+
+class Aarch64Raspi4Machine(LinuxKernelTest):
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
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
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
+        self.wait_for_console_pattern(console_pattern)
+        # When USB is enabled we can look for this
+        # console_pattern = 'Product: QEMU USB Keyboard'
+        # self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Waiting for root device'
+        self.wait_for_console_pattern(console_pattern)
+
+
+    def test_arm_raspi4_initrd(self):
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
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
+        self.wait_for_console_pattern('Boot successful.')
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
+    LinuxKernelTest.main()
-- 
2.46.0


