Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EABC5321D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggiH-0000o6-Ux; Wed, 21 Aug 2024 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggiD-0000cK-Qs
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggiB-0004Pm-5P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSpOEAUE9A80W0w+PYaUgR4aRE1pet7Rb89NqU41iY=;
 b=ApTNGye97WJ4MlBExh/aMNRtOnW2PrOUw1gXKk0cPYEMXP0t0dUv+V0lw+qY7af5HPQrb4
 HenNVYvi/L/6CeTv/I9kcBcv3YHRY5Vpy/3OMbiA6FdyGTQqXWkHogiflt1knpb7UD9qYY
 Xekxe0h07g0h3PZlnu2HEOzt5f4bK4A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-SDwgxu6AN6GIczk1N1ToMg-1; Wed,
 21 Aug 2024 04:28:53 -0400
X-MC-Unique: SDwgxu6AN6GIczk1N1ToMg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2EBA1954B0E; Wed, 21 Aug 2024 08:28:52 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 650811955F1B; Wed, 21 Aug 2024 08:28:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 16/35] tests/functional: Convert some tests that download
 files via fetch_asset()
Date: Wed, 21 Aug 2024 10:27:17 +0200
Message-ID: <20240821082748.65853-17-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now that we've got the Asset class with pre-caching, we can convert
some Avocado tests that use fetch_asset() for downloading their
required files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 12 ++---
 tests/avocado/machine_mips_loongson3v.py      | 39 --------------
 tests/functional/meson.build                  | 22 ++++++++
 .../test_arm_n8x0.py}                         | 36 ++++++-------
 .../test_avr_mega2560.py}                     | 22 ++++----
 .../test_loongarch64_virt.py}                 | 46 +++++++++--------
 tests/functional/test_mips64el_loongson3v.py  | 39 ++++++++++++++
 .../test_netdev_ethtool.py}                   | 51 +++++++------------
 .../ppc_405.py => functional/test_ppc_405.py} | 29 ++++++-----
 9 files changed, 156 insertions(+), 140 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_loongson3v.py
 rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (72%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (54%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_mips64el_loongson3v.py
 rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (66%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (53%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 4912f8d0da..6545662eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -222,7 +222,7 @@ S: Maintained
 F: docs/system/target-avr.rst
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
-F: tests/avocado/machine_avr6.py
+F: tests/functional/test_avr_mega2560.py
 
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
@@ -266,7 +266,7 @@ M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/tcg/loongarch64/
-F: tests/avocado/machine_loongarch.py
+F: tests/functional/test_loongarch64_virt.py
 
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
@@ -886,7 +886,7 @@ F: include/hw/display/blizzard.h
 F: include/hw/input/lm832x.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
-F: tests/avocado/machine_arm_n8x0.py
+F: tests/functional/test_arm_n8x0.py
 F: docs/system/arm/nseries.rst
 
 Palm
@@ -1397,7 +1397,7 @@ F: hw/mips/loongson3_virt.c
 F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
-F: tests/avocado/machine_mips_loongson3v.py
+F: tests/functional/test_mips64el_loongson3v.py
 
 Boston
 M: Paul Burton <paulburton@kernel.org>
@@ -1423,7 +1423,7 @@ PowerPC Machines
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc405*
-F: tests/avocado/ppc_405.py
+F: tests/functional/test_ppc_405.py
 
 Bamboo
 L: qemu-ppc@nongnu.org
@@ -2495,7 +2495,7 @@ R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 S: Maintained
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
-F: tests/avocado/netdev-ethtool.py
+F: tests/functional/test_netdev_ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
diff --git a/tests/avocado/machine_mips_loongson3v.py b/tests/avocado/machine_mips_loongson3v.py
deleted file mode 100644
index 5194cf18c9..0000000000
--- a/tests/avocado/machine_mips_loongson3v.py
+++ /dev/null
@@ -1,39 +0,0 @@
-# Functional tests for the Generic Loongson-3 Platform.
-#
-# Copyright (c) 2021 Jiaxun Yang <jiaxun.yang@flygoat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-import time
-
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-
-class MipsLoongson3v(QemuSystemTest):
-    timeout = 60
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_pmon_serial_console(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=endian:little
-        :avocado: tags=machine:loongson3-virt
-        :avocado: tags=cpu:Loongson-3A1000
-        :avocado: tags=device:liointc
-        :avocado: tags=device:goldfish_rtc
-        """
-
-        pmon_hash = '7c8b45dd81ccfc55ff28f5aa267a41c3'
-        pmon_path = self.fetch_asset('https://github.com/loongson-community/pmon/'
-                                    'releases/download/20210112/pmon-3avirt.bin',
-                                     asset_hash=pmon_hash, algorithm='md5')
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', pmon_path)
-        self.vm.launch()
-        wait_for_console_pattern(self, 'CPU GODSON3 BogoMIPS:')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cef74b82a9..32c7cc2d3c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'netdev_ethtool' : 180,
 }
 
 tests_generic = [
@@ -19,10 +20,30 @@ tests_generic = [
   'version',
 ]
 
+tests_arm_thorough = [
+  'arm_n8x0',
+]
+
+tests_avr_thorough = [
+  'avr_mega2560',
+]
+
+tests_loongarch64_thorough = [
+  'loongarch64_virt',
+]
+
+tests_mips64el_thorough = [
+  'mips64el_loongson3v',
+]
+
 tests_ppc_quick = [
   'ppc_74xx',
 ]
 
+tests_ppc_thorough = [
+  'ppc_405',
+]
+
 tests_x86_64_quick = [
   'cpu_queries',
   'mem_addr_space',
@@ -31,6 +52,7 @@ tests_x86_64_quick = [
 ]
 
 tests_x86_64_thorough = [
+  'netdev_ethtool',
 ]
 
 precache_all = []
diff --git a/tests/avocado/machine_arm_n8x0.py b/tests/functional/test_arm_n8x0.py
old mode 100644
new mode 100755
similarity index 51%
rename from tests/avocado/machine_arm_n8x0.py
rename to tests/functional/test_arm_n8x0.py
index 12e9a6803b..ffcf468fe8
--- a/tests/avocado/machine_arm_n8x0.py
+++ b/tests/functional/test_arm_n8x0.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -10,21 +12,22 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class N8x0Machine(QemuSystemTest):
     """Boots the Linux kernel and checks that the console is operational"""
 
     timeout = 90
 
+    ASSET_KERNEL = Asset(
+        ('http://stskeeps.subnetmask.net/meego-n8x0/'
+         'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0'),
+        '629f4616caacacd116d23d7572178f93691b0b918b25e28d7736c24f888d4292')
+
     def __do_test_n8x0(self):
-        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
-                      'meego-arm-n8x0-1.0.80.20100712.1431-'
-                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
-        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console(console_index=1)
         self.vm.add_args('-kernel', kernel_path,
@@ -32,18 +35,15 @@ def __do_test_n8x0(self):
         self.vm.launch()
         wait_for_console_pattern(self, 'TSC2005 driver initializing')
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_n800(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n800
-        """
+        self.set_machine('n800')
         self.__do_test_n8x0()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_n810(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n810
-        """
+        self.set_machine('n810')
         self.__do_test_n8x0()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/machine_avr6.py b/tests/functional/test_avr_mega2560.py
old mode 100644
new mode 100755
similarity index 72%
rename from tests/avocado/machine_avr6.py
rename to tests/functional/test_avr_mega2560.py
index 5485db79c6..8e47b4200b
--- a/tests/avocado/machine_avr6.py
+++ b/tests/functional/test_avr_mega2560.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # QEMU AVR integration tests
 #
@@ -19,26 +20,24 @@
 
 import time
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest, Asset
 
 class AVR6Machine(QemuSystemTest):
     timeout = 5
 
+    ASSET_ROM = Asset(('https://github.com/seharris/qemu-avr-tests'
+                       '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                       '/AVR_ATMega2560_GCC/demo.elf'),
+                      'ee4833bd65fc69e84a79ed1c608affddbd499a60e63acf87d9113618401904e4')
+
     def test_freertos(self):
-        """
-        :avocado: tags=arch:avr
-        :avocado: tags=machine:arduino-mega-2560-v3
-        """
         """
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
         """
-        rom_url = ('https://github.com/seharris/qemu-avr-tests'
-                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
-                   '/AVR_ATMega2560_GCC/demo.elf')
-        rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
-        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+        rom_path = self.ASSET_ROM.fetch()
 
+        self.set_machine('arduino-mega-2560-v3')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
@@ -48,3 +47,6 @@ def test_freertos(self):
 
         self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
                 self.vm.get_log())
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/machine_loongarch.py b/tests/functional/test_loongarch64_virt.py
old mode 100644
new mode 100755
similarity index 54%
rename from tests/avocado/machine_loongarch.py
rename to tests/functional/test_loongarch64_virt.py
index 8de308f2d6..2b8baa2c2a
--- a/tests/avocado/machine_loongarch.py
+++ b/tests/functional/test_loongarch64_virt.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # LoongArch virt test.
@@ -5,15 +7,28 @@
 # Copyright (c) 2023 Loongson Technology Corporation Limited
 #
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 
 class LoongArchMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     timeout = 120
 
+    ASSET_KERNEL = Asset(
+        ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
+         'releases/download/2024-05-30/vmlinuz.efi'),
+        '08b88a45f48a5fd92260bae895be4e5175be2397481a6f7821b9f39b2965b79e')
+    ASSET_INITRD = Asset(
+        ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
+         'releases/download/2024-05-30/ramdisk'),
+        '03d6fb6f8ee64ecac961120a0bdacf741f17b3bee2141f17fa01908c8baf176a')
+    ASSET_BIOS = Asset(
+        ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
+         'releases/download/2024-05-30/QEMU_EFI.fd'),
+        '937c1e7815e2340150c194a9f8f0474259038a3d7b8845ed62cc08163c46bea1')
+
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(self, success_message,
                                  failure_message='Kernel panic - not syncing',
@@ -21,25 +36,11 @@ def wait_for_console_pattern(self, success_message, vm=None):
 
     def test_loongarch64_devices(self):
 
-        """
-        :avocado: tags=arch:loongarch64
-        :avocado: tags=machine:virt
-        """
-
-        kernel_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                      'releases/download/2024-05-30/vmlinuz.efi')
-        kernel_hash = '951b485b16e3788b6db03a3e1793c067009e31a2'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.set_machine('virt')
 
-        initrd_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                      'releases/download/2024-05-30/ramdisk')
-        initrd_hash = 'c67658d9b2a447ce7db2f73ba3d373c9b2b90ab2'
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-
-        bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                    'releases/download/2024-05-30/QEMU_EFI.fd')
-        bios_hash = ('f4d0966b5117d4cd82327c050dd668741046be69')
-        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        bios_path = self.ASSET_BIOS.fetch()
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -56,3 +57,6 @@ def test_loongarch64_devices(self):
         self.wait_for_console_pattern('Run /sbin/init as init process')
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                           'processor		: 3')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/test_mips64el_loongson3v.py
new file mode 100755
index 0000000000..55d62928c7
--- /dev/null
+++ b/tests/functional/test_mips64el_loongson3v.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the Generic Loongson-3 Platform.
+#
+# Copyright (c) 2021 Jiaxun Yang <jiaxun.yang@flygoat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+
+from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class MipsLoongson3v(QemuSystemTest):
+    timeout = 60
+
+    ASSET_PMON = Asset(
+        ('https://github.com/loongson-community/pmon/'
+         'releases/download/20210112/pmon-3avirt.bin'),
+        'fcdf6bb2cb7885a4a62f31fcb0d5e368bac7b6cea28f40c6dfa678af22fea20a')
+
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_pmon_serial_console(self):
+        self.set_machine('loongson3-virt')
+
+        pmon_path = self.ASSET_PMON.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', pmon_path)
+        self.vm.launch()
+        wait_for_console_pattern(self, 'CPU GODSON3 BogoMIPS:')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/netdev-ethtool.py b/tests/functional/test_netdev_ethtool.py
old mode 100644
new mode 100755
similarity index 66%
rename from tests/avocado/netdev-ethtool.py
rename to tests/functional/test_netdev_ethtool.py
index 5f33288f81..d5b911c918
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/functional/test_netdev_ethtool.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # ethtool tests for emulated network devices
 #
 # This test leverages ethtool's --test sequence to validate network
@@ -5,39 +7,33 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-late
 
-from avocado import skip
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skip
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class NetDevEthtool(QemuSystemTest):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:q35
-    """
 
     # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
     timeout = 45
 
     # Fetch assets from the netdev-ethtool subdir of my shared test
     # images directory on fileserver.linaro.org.
-    def get_asset(self, name, sha1):
-        base_url = ('https://fileserver.linaro.org/s/'
-                    'kE4nCFLdQcoBF9t/download?'
-                    'path=%2Fnetdev-ethtool&files=' )
-        url = base_url + name
-        # use explicit name rather than failing to neatly parse the
-        # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+    ASSET_BASEURL = ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
+                     'download?path=%2Fnetdev-ethtool&files=')
+    ASSET_BZIMAGE = Asset(
+        ASSET_BASEURL + "bzImage",
+        "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
+    ASSET_ROOTFS = Asset(
+        ASSET_BASEURL + "rootfs.squashfs",
+        "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
 
     def common_test_code(self, netdev, extra_args=None):
+        self.set_machine('q35')
 
         # This custom kernel has drivers for all the supported network
         # devices we can emulate in QEMU
-        kernel = self.get_asset("bzImage",
-                                "33469d7802732d5815226166581442395cb289e2")
-
-        rootfs = self.get_asset("rootfs.squashfs",
-                                "9793cea7021414ae844bda51f558bd6565b50cdc")
+        kernel = self.ASSET_BZIMAGE.fetch()
+        rootfs = self.ASSET_ROOTFS.fetch()
 
         append = 'printk.time=0 console=ttyS0 '
         append += 'root=/dev/sr0 rootfstype=squashfs '
@@ -68,15 +64,9 @@ def common_test_code(self, netdev, extra_args=None):
         self.vm.kill()
 
     def test_igb(self):
-        """
-        :avocado: tags=device:igb
-        """
         self.common_test_code("igb")
 
     def test_igb_nomsi(self):
-        """
-        :avocado: tags=device:igb
-        """
         self.common_test_code("igb", "pci=nomsi")
 
     # It seems the other popular cards we model in QEMU currently fail
@@ -88,14 +78,11 @@ def test_igb_nomsi(self):
 
     @skip("Incomplete reg 0x00178 support")
     def test_e1000(self):
-        """
-        :avocado: tags=device:e1000
-        """
         self.common_test_code("e1000")
 
     @skip("Incomplete reg 0x00178 support")
     def test_i82550(self):
-        """
-        :avocado: tags=device:i82550
-        """
         self.common_test_code("i82550")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_405.py b/tests/functional/test_ppc_405.py
old mode 100644
new mode 100755
similarity index 53%
rename from tests/avocado/ppc_405.py
rename to tests/functional/test_ppc_405.py
index 4e7e01aa76..9851c03ee9
--- a/tests/avocado/ppc_405.py
+++ b/tests/functional/test_ppc_405.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that the U-Boot firmware boots on ppc 405 machines and check the console
 #
 # Copyright (c) 2021 Red Hat, Inc.
@@ -5,20 +7,21 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class Ppc405Machine(QemuSystemTest):
 
     timeout = 90
 
+    ASSET_UBOOT = Asset(
+        ('https://gitlab.com/huth/u-boot/-/raw/taihu-2021-10-09/'
+         'u-boot-taihu.bin'),
+        'a076bb6cdeaafa406330e51e074b66d8878d9036d67d4caa0137be03ee4c112c')
+
     def do_test_ppc405(self):
-        uboot_url = ('https://gitlab.com/huth/u-boot/-/raw/'
-                     'taihu-2021-10-09/u-boot-taihu.bin')
-        uboot_hash = ('3208940e908a5edc7c03eab072c60f0dcfadc2ab');
-        file_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
+        file_path = self.ASSET_UBOOT.fetch()
         self.vm.set_console(console_index=1)
         self.vm.add_args('-bios', file_path)
         self.vm.launch()
@@ -26,11 +29,9 @@ def do_test_ppc405(self):
         exec_command_and_wait_for_pattern(self, 'reset', 'AMCC PowerPC 405EP')
 
     def test_ppc_ref405ep(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:ref405ep
-        :avocado: tags=cpu:405ep
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
+        self.set_machine('ref405ep')
         self.do_test_ppc405()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


