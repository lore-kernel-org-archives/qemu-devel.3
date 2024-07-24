Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20424C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgBh-0003G6-KL; Wed, 24 Jul 2024 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgBS-0002gL-8i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgBP-0005qn-QF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17UMQK5kf3N6bpcwBCqkiO/abnN+i7/ZXXlyCB1AGEQ=;
 b=gyp/A3j8PT9IKO2AqbdjfH9Ht2wqWxWtaoqSsDzjBJ9t/EyvRmRwLdPLHTuNUtChUnfZbi
 a91+FIzZbR1tf80Ty/HDCSPx4mQmVGl7KSKRvJUILVrteDLCpDQDSQtNLXl9QtxndtlECw
 BEdLpUe1lyTbcX1ynWTdD6nRf/8FLrs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-fMhF-bhCPPOqhTlkCIFsqw-1; Wed,
 24 Jul 2024 13:53:41 -0400
X-MC-Unique: fMhF-bhCPPOqhTlkCIFsqw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 258D81956095; Wed, 24 Jul 2024 17:53:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39C3F1955D42; Wed, 24 Jul 2024 17:53:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 08/23] tests/functional: Convert some tests that download
 files via fetch_asset()
Date: Wed, 24 Jul 2024 19:52:26 +0200
Message-ID: <20240724175248.1389201-9-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that we've got a working fetch_asset() function, we can convert
some Avocado tests that use this function for downloading their
required files.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 12 +++----
 tests/functional/meson.build                  | 22 +++++++++++++
 .../test_arm_n8x0.py}                         | 25 +++++++--------
 .../test_avr_mega2560.py}                     | 11 ++++---
 .../test_loongarch64_virt.py}                 | 16 ++++++----
 .../test_mips64el_loongson3v.py}              | 26 +++++++--------
 .../test_netdev_ethtool.py}                   | 32 ++++++-------------
 .../ppc_405.py => functional/test_ppc_405.py} | 19 ++++++-----
 8 files changed, 86 insertions(+), 77 deletions(-)
 rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (89%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_mips_loongson3v.py => functional/test_mips64el_loongson3v.py} (55%)
 mode change 100644 => 100755
 rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (81%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (73%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index dd01288992..d69de11cfc 100644
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
@@ -265,7 +265,7 @@ M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/tcg/loongarch64/
-F: tests/avocado/machine_loongarch.py
+F: tests/functional/test_loongarch64_virt.py
 
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
@@ -884,7 +884,7 @@ F: include/hw/display/blizzard.h
 F: include/hw/input/lm832x.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
-F: tests/avocado/machine_arm_n8x0.py
+F: tests/functional/test_arm_n8x0.py
 F: docs/system/arm/nseries.rst
 
 Palm
@@ -1393,7 +1393,7 @@ F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
 F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
-F: tests/avocado/machine_mips_loongson3v.py
+F: tests/functional/test_mips64el_loongson3v.py
 
 Boston
 M: Paul Burton <paulburton@kernel.org>
@@ -1419,7 +1419,7 @@ PowerPC Machines
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc405*
-F: tests/avocado/ppc_405.py
+F: tests/functional/test_ppc_405.py
 
 Bamboo
 L: qemu-ppc@nongnu.org
@@ -2486,7 +2486,7 @@ R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 S: Maintained
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
-F: tests/avocado/netdev-ethtool.py
+F: tests/functional/test_netdev_ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8a8fa0ab99..7eb5dbfe31 100644
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
 
 foreach speed : ['quick', 'thorough']
diff --git a/tests/avocado/machine_arm_n8x0.py b/tests/functional/test_arm_n8x0.py
old mode 100644
new mode 100755
similarity index 71%
rename from tests/avocado/machine_arm_n8x0.py
rename to tests/functional/test_arm_n8x0.py
index 12e9a6803b..d451c80a73
--- a/tests/avocado/machine_arm_n8x0.py
+++ b/tests/functional/test_arm_n8x0.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -10,9 +12,9 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
 
 class N8x0Machine(QemuSystemTest):
     """Boots the Linux kernel and checks that the console is operational"""
@@ -32,18 +34,15 @@ def __do_test_n8x0(self):
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
similarity index 90%
rename from tests/avocado/machine_avr6.py
rename to tests/functional/test_avr_mega2560.py
index 5485db79c6..b9b89367c6
--- a/tests/avocado/machine_avr6.py
+++ b/tests/functional/test_avr_mega2560.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # QEMU AVR integration tests
 #
@@ -19,16 +20,12 @@
 
 import time
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 class AVR6Machine(QemuSystemTest):
     timeout = 5
 
     def test_freertos(self):
-        """
-        :avocado: tags=arch:avr
-        :avocado: tags=machine:arduino-mega-2560-v3
-        """
         """
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
@@ -39,6 +36,7 @@ def test_freertos(self):
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
+        self.set_machine('arduino-mega-2560-v3')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
@@ -48,3 +46,6 @@ def test_freertos(self):
 
         self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
                 self.vm.get_log())
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/machine_loongarch.py b/tests/functional/test_loongarch64_virt.py
old mode 100644
new mode 100755
similarity index 89%
rename from tests/avocado/machine_loongarch.py
rename to tests/functional/test_loongarch64_virt.py
index 8de308f2d6..3dc8bb3516
--- a/tests/avocado/machine_loongarch.py
+++ b/tests/functional/test_loongarch64_virt.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # LoongArch virt test.
@@ -5,9 +7,9 @@
 # Copyright (c) 2023 Loongson Technology Corporation Limited
 #
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 
 class LoongArchMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -21,10 +23,7 @@ def wait_for_console_pattern(self, success_message, vm=None):
 
     def test_loongarch64_devices(self):
 
-        """
-        :avocado: tags=arch:loongarch64
-        :avocado: tags=machine:virt
-        """
+        self.set_machine('virt')
 
         kernel_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
                       'releases/download/2024-05-30/vmlinuz.efi')
@@ -56,3 +55,6 @@ def test_loongarch64_devices(self):
         self.wait_for_console_pattern('Run /sbin/init as init process')
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                           'processor		: 3')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/machine_mips_loongson3v.py b/tests/functional/test_mips64el_loongson3v.py
old mode 100644
new mode 100755
similarity index 55%
rename from tests/avocado/machine_mips_loongson3v.py
rename to tests/functional/test_mips64el_loongson3v.py
index 5194cf18c9..f8d40b48a9
--- a/tests/avocado/machine_mips_loongson3v.py
+++ b/tests/functional/test_mips64el_loongson3v.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional tests for the Generic Loongson-3 Platform.
 #
 # Copyright (c) 2021 Jiaxun Yang <jiaxun.yang@flygoat.com>
@@ -10,30 +12,26 @@
 import os
 import time
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
 
 class MipsLoongson3v(QemuSystemTest):
     timeout = 60
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_pmon_serial_console(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=endian:little
-        :avocado: tags=machine:loongson3-virt
-        :avocado: tags=cpu:Loongson-3A1000
-        :avocado: tags=device:liointc
-        :avocado: tags=device:goldfish_rtc
-        """
+        self.set_machine('loongson3-virt')
 
-        pmon_hash = '7c8b45dd81ccfc55ff28f5aa267a41c3'
+        pmon_hash = 'fcdf6bb2cb7885a4a62f31fcb0d5e368bac7b6cea28f40c6dfa678af22fea20a'
         pmon_path = self.fetch_asset('https://github.com/loongson-community/pmon/'
                                     'releases/download/20210112/pmon-3avirt.bin',
-                                     asset_hash=pmon_hash, algorithm='md5')
+                                     asset_hash=pmon_hash)
 
         self.vm.set_console()
         self.vm.add_args('-bios', pmon_path)
         self.vm.launch()
         wait_for_console_pattern(self, 'CPU GODSON3 BogoMIPS:')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/netdev-ethtool.py b/tests/functional/test_netdev_ethtool.py
old mode 100644
new mode 100755
similarity index 81%
rename from tests/avocado/netdev-ethtool.py
rename to tests/functional/test_netdev_ethtool.py
index 5f33288f81..341c087e36
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/functional/test_netdev_ethtool.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # ethtool tests for emulated network devices
 #
 # This test leverages ethtool's --test sequence to validate network
@@ -5,15 +7,11 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-late
 
-from avocado import skip
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skip
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
 
 class NetDevEthtool(QemuSystemTest):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:q35
-    """
 
     # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
     timeout = 45
@@ -25,11 +23,10 @@ def get_asset(self, name, sha1):
                     'kE4nCFLdQcoBF9t/download?'
                     'path=%2Fnetdev-ethtool&files=' )
         url = base_url + name
-        # use explicit name rather than failing to neatly parse the
-        # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+        return self.fetch_asset(url, asset_hash=sha1)
 
     def common_test_code(self, netdev, extra_args=None):
+        self.set_machine('q35')
 
         # This custom kernel has drivers for all the supported network
         # devices we can emulate in QEMU
@@ -68,15 +65,9 @@ def common_test_code(self, netdev, extra_args=None):
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
@@ -88,14 +79,11 @@ def test_igb_nomsi(self):
 
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
similarity index 73%
rename from tests/avocado/ppc_405.py
rename to tests/functional/test_ppc_405.py
index 4e7e01aa76..f2368ada80
--- a/tests/avocado/ppc_405.py
+++ b/tests/functional/test_ppc_405.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that the U-Boot firmware boots on ppc 405 machines and check the console
 #
 # Copyright (c) 2021 Red Hat, Inc.
@@ -5,10 +7,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class Ppc405Machine(QemuSystemTest):
 
@@ -26,11 +27,9 @@ def do_test_ppc405(self):
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
2.45.2


