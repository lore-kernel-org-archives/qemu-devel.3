Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928D4E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxu-0000GU-Ap; Wed, 18 Dec 2024 06:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxi-00084d-V1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxg-0005wO-TZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEtvWaUYF14WlqP1L8Eh4AUvZrz0DIV0ksvKiy/5LMQ=;
 b=GNktCVUMo2AQPn9SfqfNv1Ebz6tDxZPZC1YcqWWiuhHNMfKCjhdAqaBhboF/Im6cYANhWE
 GqKCSfcckWLdkFIZxcL9vnbvzP4hykVStEMaCi2R2Xy9Hgv0CLtWWZ0OXWUQ0MfOwR6cX6
 Cd7OqgM/l7QrFgWDNomMZ+vyXtP02n8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619--my4HRe5Na2fnDmIskWrnw-1; Wed,
 18 Dec 2024 06:11:25 -0500
X-MC-Unique: -my4HRe5Na2fnDmIskWrnw-1
X-Mimecast-MFC-AGG-ID: -my4HRe5Na2fnDmIskWrnw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 147431958B3D
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A49D195606B; Wed, 18 Dec 2024 11:11:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 33/38] tests/functional: Convert the quanta-gsj avocado test
Date: Wed, 18 Dec 2024 12:09:53 +0100
Message-ID: <20241218110958.226932-34-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Straight forward conversion, basically just the hashsums needed
to be updated to sha256 now.

Message-ID: <20241206102358.1186644-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |  1 +
 tests/avocado/boot_linux_console.py     | 86 ----------------------
 tests/functional/meson.build            |  2 +
 tests/functional/test_arm_quanta_gsj.py | 94 +++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 86 deletions(-)
 create mode 100755 tests/functional/test_arm_quanta_gsj.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 54201da578..1e2f71e3b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -872,6 +872,7 @@ F: tests/qtest/adm1266-test.c
 F: pc-bios/npcm7xx_bootrom.bin
 F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
+F: tests/functional/test_arm_quanta_gsj.py
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 268b40ca31..4bd1465ba3 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -115,89 +115,3 @@ def test_arm_virt(self):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
-
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_arm_quanta_gsj(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:quanta-gsj
-        :avocado: tags=accel:tcg
-        """
-        # 25 MiB compressed, 32 MiB uncompressed.
-        image_url = (
-                'https://github.com/hskinnemoen/openbmc/releases/download/'
-                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
-        image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'
-        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
-        image_name = 'obmc.mtd'
-        image_path = os.path.join(self.workdir, image_name)
-        archive.gzip_uncompress(image_path_gz, image_path)
-
-        self.vm.set_console()
-        drive_args = 'file=' + image_path + ',if=mtd,bus=0,unit=0'
-        self.vm.add_args('-drive', drive_args)
-        self.vm.launch()
-
-        # Disable drivers and services that stall for a long time during boot,
-        # to avoid running past the 90-second timeout. These may be removed
-        # as the corresponding device support is added.
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + (
-                'console=${console} '
-                'mem=${mem} '
-                'initcall_blacklist=npcm_i2c_bus_driver_init '
-                'systemd.mask=systemd-random-seed.service '
-                'systemd.mask=dropbearkey.service '
-        )
-
-        self.wait_for_console_pattern('> BootBlock by Nuvoton')
-        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
-        self.wait_for_console_pattern('>Skip DDR init.')
-        self.wait_for_console_pattern('U-Boot ')
-        interrupt_interactive_console_until_pattern(
-                self, 'Hit any key to stop autoboot:', 'U-Boot>')
-        exec_command_and_wait_for_pattern(
-                self, "setenv bootargs ${bootargs} " + kernel_command_line,
-                'U-Boot>')
-        exec_command_and_wait_for_pattern(
-                self, 'run romboot', 'Booting Kernel from flash')
-        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
-        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
-        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
-        self.wait_for_console_pattern('gsj login:')
-
-    def test_arm_quanta_gsj_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:quanta-gsj
-        :avocado: tags=accel:tcg
-        """
-        initrd_url = (
-                'https://github.com/hskinnemoen/openbmc/releases/download/'
-                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz')
-        initrd_hash = '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        kernel_url = (
-                'https://github.com/hskinnemoen/openbmc/releases/download/'
-                '20200711-gsj-qemu-0/uImage-gsj.bin')
-        kernel_hash = 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        dtb_url = (
-                'https://github.com/hskinnemoen/openbmc/releases/download/'
-                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
-        dtb_hash = '18315f7006d7b688d8312d5c727eecd819aa36a4'
-        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200n8 '
-                               'earlycon=uart8250,mmio32,0xf0001000')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-initrd', initrd_path,
-                         '-dtb', dtb_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-
-        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
-        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
-        self.wait_for_console_pattern(
-                'Give root password for system maintenance')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1bc5ba5229..f0326788f0 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -27,6 +27,7 @@ test_timeouts = {
   'arm_collie' : 180,
   'arm_cubieboard' : 360,
   'arm_orangepi' : 540,
+  'arm_quanta_gsj' : 240,
   'arm_raspi2' : 120,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
@@ -85,6 +86,7 @@ tests_arm_system_thorough = [
   'arm_emcraft_sf2',
   'arm_integratorcp',
   'arm_orangepi',
+  'arm_quanta_gsj',
   'arm_raspi2',
   'arm_smdkc210',
   'arm_sx1',
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/test_arm_quanta_gsj.py
new file mode 100755
index 0000000000..7aa5209bea
--- /dev/null
+++ b/tests/functional/test_arm_quanta_gsj.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from unittest import skipUnless
+
+class EmcraftSf2Machine(LinuxKernelTest):
+
+    ASSET_IMAGE = Asset(
+        ('https://github.com/hskinnemoen/openbmc/releases/download/'
+         '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz'),
+        'eccd4e375cde53034c84aece5c511932cacf838d9fd3f63da368a511757da72b')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/hskinnemoen/openbmc/releases/download/'
+         '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz'),
+        '37b05009fc54db1434beac12bd7ff99a2e751a2f032ee18d9042f991dd0cdeaa')
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/hskinnemoen/openbmc/releases/download/'
+         '20200711-gsj-qemu-0/uImage-gsj.bin'),
+        'ce6d6b37bff46c74fc7b1e90da10a431cc37a62cdb35ec199fa73473d0790110')
+
+    ASSET_DTB = Asset(
+        ('https://github.com/hskinnemoen/openbmc/releases/download/'
+         '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb'),
+        '3249b2da787d4b9ad4e61f315b160abfceb87b5e1895a7ce898ce7f40c8d4045')
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_arm_quanta_gsj(self):
+        self.set_machine('quanta-gsj')
+        image_path = self.uncompress(ASSET_IMAGE, 'obmc.mtd', format='gz')
+
+        self.vm.set_console()
+        drive_args = 'file=' + image_path + ',if=mtd,bus=0,unit=0'
+        self.vm.add_args('-drive', drive_args)
+        self.vm.launch()
+
+        # Disable drivers and services that stall for a long time during boot,
+        # to avoid running past the 90-second timeout. These may be removed
+        # as the corresponding device support is added.
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + (
+                'console=${console} '
+                'mem=${mem} '
+                'initcall_blacklist=npcm_i2c_bus_driver_init '
+                'systemd.mask=systemd-random-seed.service '
+                'systemd.mask=dropbearkey.service '
+        )
+
+        self.wait_for_console_pattern('> BootBlock by Nuvoton')
+        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
+        self.wait_for_console_pattern('>Skip DDR init.')
+        self.wait_for_console_pattern('U-Boot ')
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', 'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, "setenv bootargs ${bootargs} " + kernel_command_line,
+                'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, 'run romboot', 'Booting Kernel from flash')
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
+        self.wait_for_console_pattern('gsj login:')
+
+    def test_arm_quanta_gsj_initrd(self):
+        self.set_machine('quanta-gsj')
+        initrd_path = self.ASSET_INITRD.fetch()
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart8250,mmio32,0xf0001000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern(
+                'Give root password for system maintenance')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


