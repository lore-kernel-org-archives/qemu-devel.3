Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0942EE6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdM0-0007sG-RI; Fri, 06 Sep 2024 14:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLs-0007mc-T6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLp-00053k-7d
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJFPCkxrD+z5N65/ptgFBeTPAhl4mePKt83XXH9BjWs=;
 b=e+8ZRAuVWKhlyl58FbgZrmLK2jwzqmd/Da9O7m3rrGa9Yc6IyskK/+NWVlmJgnn8+GnB6q
 IEe9iO0QdAH6gdfgkek0stNgA8CyUXO3eTX0MltgLx11/lKUa0JBRZviZgW3o675/+OZ0x
 tEUSXBO2FFyung/8TrYdsLgv+GSbc2w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-9FEVv0EgOjSlWXxWhWoAHQ-1; Fri,
 06 Sep 2024 14:06:24 -0400
X-MC-Unique: 9FEVv0EgOjSlWXxWhWoAHQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47BD41953948; Fri,  6 Sep 2024 18:06:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E4F119560AA; Fri,  6 Sep 2024 18:06:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 09/14] tests/functional: Convert ARM Raspi2 avocado tests
Date: Fri,  6 Sep 2024 20:05:44 +0200
Message-ID: <20240906180549.792832-10-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Message-ID: <20240826221058.75126-3-philmd@linaro.org>
[thuth: Use LinuxKernelTest class]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 85 --------------------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_arm_raspi2.py | 95 +++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 85 deletions(-)
 create mode 100755 tests/functional/test_arm_raspi2.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 95bc834fdb..eaf71bb976 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -911,6 +911,7 @@ F: hw/*/bcm283*
 F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
+F: tests/functional/test_arm_raspi2.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index e3e4576099..827a286429 100644
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
index eb2de2a8fd..ff3fe7981e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -42,6 +42,7 @@ tests_aarch64_system_thorough = [
 tests_arm_system_thorough = [
   'arm_canona1100',
   'arm_integratorcp',
+  'arm_raspi2',
 ]
 
 tests_arm_linuxuser_thorough = [
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
new file mode 100755
index 0000000000..3bf079dc4d
--- /dev/null
+++ b/tests/functional/test_arm_raspi2.py
@@ -0,0 +1,95 @@
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
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import gzip_uncompress
+
+
+class ArmRaspi2Machine(LinuxKernelTest):
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
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+
+        self.set_machine('raspi2b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
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
+        self.wait_for_console_pattern(console_pattern)
+        self.wait_for_console_pattern('Product: QEMU USB Keyboard')
+
+    def test_arm_raspi2_uart0(self):
+        self.do_test_arm_raspi2(0)
+
+    def test_arm_raspi2_initrd(self):
+        deb_path = self.ASSET_KERNEL_20190215.fetch()
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('raspi2b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,0x3f201000 console=ttyAMA0 '
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
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
+    LinuxKernelTest.main()
-- 
2.46.0


