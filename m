Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B74D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZJ7-0007Ub-OU; Thu, 31 Oct 2024 13:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIU-00071s-IU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIQ-0006di-0y
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730396959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toCoks5Jtlhp+Gfl4YsiMY1M+Z5LTyBfUsOOZFZF6dM=;
 b=FQGVDAmfLsRBG9MJWK60EfHWWgX+r67qipaJiRz8gzzi21eKA6UX/1WDckt3Zcu13BE1qb
 yFBipHpBrZOclAJ0DpBLJ1BwXh+3JEFOhqKkqBhp/kKIzmFz6zJpVHyytvsBO4KEy4OQoJ
 0WxJe0kVsNsklB4pD9cj/HLhO5IXZ64=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-4voK5_tzMjOc-XLNgPbM5A-1; Thu,
 31 Oct 2024 13:49:16 -0400
X-MC-Unique: 4voK5_tzMjOc-XLNgPbM5A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E066195608C; Thu, 31 Oct 2024 17:49:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD4B0300018D; Thu, 31 Oct 2024 17:49:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/14] tests/functional: Convert the OrangePi tests to the
 functional framework
Date: Thu, 31 Oct 2024 18:48:31 +0100
Message-ID: <20241031174832.6574-14-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-1-thuth@redhat.com>
References: <20241031174832.6574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the OrangePi tests from tests/avocado/boot_linux_console.py into
a new file dedicated for OrangePi tests in the functional framework
and update the hash sums of the assets to sha256 along the way.
For the buildroot image and the Armbian image, we've got to switch to
a newer version since the old images have been removed from the server,
and the NetBSD image has been moved to the archive, so we need to update
this URL as well.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241029092440.25021-3-thuth@redhat.com>
---
 MAINTAINERS                           |   1 +
 tests/avocado/boot_linux_console.py   | 235 ----------------------
 tests/functional/meson.build          |   2 +
 tests/functional/test_arm_orangepi.py | 270 ++++++++++++++++++++++++++
 4 files changed, 273 insertions(+), 235 deletions(-)
 create mode 100755 tests/functional/test_arm_orangepi.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 6fa4d89ca1..5837e4bf74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -640,6 +640,7 @@ F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
 F: hw/arm/orangepi.c
 F: docs/system/arm/orangepi.rst
+F: tests/functional/test_arm_orangepi.py
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index d05abf0d1a..12e24bb05a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -471,241 +471,6 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
 
-    def test_arm_orangepi(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=accel:tcg
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200n8 '
-                               'earlycon=uart,mmio32,0x1c28000')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_arm_orangepi_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
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
-                               'console=ttyS0,115200 '
-                               'panic=-1 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun8i Family')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'system-control@1c00000')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
-    def test_arm_orangepi_sd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
-        self.require_netdev('user')
-
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-        rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
-                      'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
-        rootfs_hash = 'fae32f337c7b87547b10f42599acf109da8b6d9a'
-        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
-        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
-        image_pow2ceil_expand(rootfs_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200 '
-                               'root=/dev/mmcblk0 rootwait rw '
-                               'panic=-1 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        shell_ready = "/bin/sh: can't access tty; job control turned off"
-        self.wait_for_console_pattern(shell_ready)
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun8i Family')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
-                                                'mmcblk0')
-        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
-                                                 'eth0: Link is Up')
-        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
-            'udhcpc: lease of 10.0.2.15 obtained')
-        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
-            '3 packets transmitted, 3 packets received, 0% packet loss')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-    def test_arm_orangepi_bionic_20_08(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
-
-        # This test download a 275 MiB compressed image and expand it
-        # to 1036 MiB, but the underlying filesystem is 1552 MiB...
-        # As we expand it to 2 GiB we are safe.
-
-        image_url = ('https://archive.armbian.com/orangepipc/archive/'
-                     'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
-        image_hash = ('b4d6775f5673486329e45a0586bf06b6'
-                      'dbe792199fd182ac6b9c7bb6c7d3e6dd')
-        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
-                                         algorithm='sha256')
-        image_path = archive.extract(image_path_xz, self.workdir)
-        image_pow2ceil_expand(image_path)
-
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
-                         '-nic', 'user',
-                         '-no-reboot')
-        self.vm.launch()
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200 '
-                               'loglevel=7 '
-                               'nosmp '
-                               'systemd.default_timeout_start_sec=9000 '
-                               'systemd.mask=armbian-zram-config.service '
-                               'systemd.mask=armbian-ramlog.service')
-
-        self.wait_for_console_pattern('U-Boot SPL')
-        self.wait_for_console_pattern('Autoboot in ')
-        exec_command_and_wait_for_pattern(self, ' ', '=>')
-        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
-                                                kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
-
-        self.wait_for_console_pattern('systemd[1]: Set hostname ' +
-                                      'to <orangepipc>')
-        self.wait_for_console_pattern('Starting Load Kernel Modules...')
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-    def test_arm_orangepi_uboot_netbsd9(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        :avocado: tags=os:netbsd
-        """
-        # This test download a 304MB compressed image and expand it to 2GB
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20200108T145233Z/pool/main/u/u-boot/'
-                   'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
-        deb_hash = 'f67f404a80753ca3d1258f13e38f2b060e13db99'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
-        # program loader (SPL). We will then set the path to the more specific
-        # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
-        # before to boot NetBSD.
-        uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
-        uboot_path = self.extract_from_deb(deb_path, uboot_path)
-        image_url = ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/'
-                     'evbarm-earmv7hf/binary/gzimg/armv7.img.gz')
-        image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
-        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
-        image_path = os.path.join(self.workdir, 'armv7.img')
-        archive.gzip_uncompress(image_path_gz, image_path)
-        image_pow2ceil_expand(image_path)
-        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
-
-        # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
-        with open(uboot_path, 'rb') as f_in:
-            with open(image_path, 'r+b') as f_out:
-                f_out.seek(8 * 1024)
-                shutil.copyfileobj(f_in, f_out)
-
-        self.vm.set_console()
-        self.vm.add_args('-nic', 'user',
-                         '-drive', image_drive_args,
-                         '-global', 'allwinner-rtc.base-year=2000',
-                         '-no-reboot')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'U-Boot 2020.01+dfsg-1')
-        interrupt_interactive_console_until_pattern(self,
-                                       'Hit any key to stop autoboot:',
-                                       'switch to partitions #0, OK')
-
-        exec_command_and_wait_for_pattern(self, '', '=>')
-        cmd = 'setenv bootargs root=ld0a'
-        exec_command_and_wait_for_pattern(self, cmd, '=>')
-        cmd = 'setenv kernel netbsd-GENERIC.ub'
-        exec_command_and_wait_for_pattern(self, cmd, '=>')
-        cmd = 'setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb'
-        exec_command_and_wait_for_pattern(self, cmd, '=>')
-        cmd = ("setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; "
-               "fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; "
-               "fdt addr ${fdt_addr_r}; "
-               "bootm ${kernel_addr_r} - ${fdt_addr_r}'")
-        exec_command_and_wait_for_pattern(self, cmd, '=>')
-
-        exec_command_and_wait_for_pattern(self, 'boot',
-                                          'Booting kernel from Legacy Image')
-        wait_for_console_pattern(self, 'Starting kernel ...')
-        wait_for_console_pattern(self, 'NetBSD 9.0 (GENERIC)')
-        # Wait for user-space
-        wait_for_console_pattern(self, 'Starting root file system check')
-
     def test_arm_ast2600_debian(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e7cac3aeee..1336d941ea 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -17,6 +17,7 @@ test_timeouts = {
   'acpi_bits' : 240,
   'arm_aspeed' : 600,
   'arm_bpim2u' : 360,
+  'arm_orangepi' : 540,
   'arm_raspi2' : 120,
   'arm_tuxrun' : 120,
   'mips_malta' : 120,
@@ -58,6 +59,7 @@ tests_arm_system_thorough = [
   'arm_bpim2u',
   'arm_canona1100',
   'arm_integratorcp',
+  'arm_orangepi',
   'arm_raspi2',
   'arm_vexpress',
   'arm_tuxrun',
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
new file mode 100755
index 0000000000..d2ed5fcc82
--- /dev/null
+++ b/tests/functional/test_arm_orangepi.py
@@ -0,0 +1,270 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on an Orange Pi machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
+from qemu_test import Asset, interrupt_interactive_console_until_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract, gzip_uncompress, lzma_uncompress
+from qemu_test.utils import image_pow2ceil_expand
+from unittest import skipUnless
+
+class BananaPiMachine(LinuxKernelTest):
+
+    ASSET_DEB = Asset(
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
+         'linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
+        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+         'arm/rootfs-armv7a.cpio.gz'),
+        '2c8dbdb16ea7af2dfbcbea96044dde639fb07d09fd3c4fb31f2027ef71e55ddd')
+
+    ASSET_ROOTFS = Asset(
+        ('http://storage.kernelci.org/images/rootfs/buildroot/'
+         'buildroot-baseline/20230703.0/armel/rootfs.ext2.xz'),
+        '42b44a12965ac0afe9a88378527fb698a7dc76af50495efc2361ee1595b4e5c6')
+
+    ASSET_ARMBIAN = Asset(
+        ('https://k-space.ee.armbian.com/archive/orangepipc/archive/'
+         'Armbian_23.8.1_Orangepipc_jammy_current_6.1.47.img.xz'),
+        'b386dff6552513b5f164ea00f94814a6b0f1da9fb90b83725e949cf797e11afb')
+
+    ASSET_UBOOT = Asset(
+        ('http://snapshot.debian.org/archive/debian/20200108T145233Z/pool/'
+         'main/u/u-boot/u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb'),
+        '9223d94dc283ab54df41ce9d6f69025a5b47fece29fb67a714e23aa0cdf3bdfa')
+
+    ASSET_NETBSD = Asset(
+        ('https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/'
+         'evbarm-earmv7hf/binary/gzimg/armv7.img.gz'),
+        '20d3e07dc057e15c12452620e90ecab2047f0f7940d9cba8182ebc795927177f')
+
+    def test_arm_orangepi(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=accel:tcg
+        """
+        self.set_machine('orangepi-pc')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart,mmio32,0x1c28000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+        os.remove(kernel_path)
+        os.remove(dtb_path)
+
+    def test_arm_orangepi_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=accel:tcg
+        :avocado: tags=machine:orangepi-pc
+        """
+        self.set_machine('orangepi-pc')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+        os.remove(kernel_path)
+        os.remove(dtb_path)
+        os.remove(initrd_path)
+
+    def test_arm_orangepi_sd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=accel:tcg
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
+        """
+        self.set_machine('orangepi-pc')
+        self.require_netdev('user')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        rootfs_path_xz = self.ASSET_ROOTFS.fetch()
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'root=/dev/mmcblk0 rootwait rw '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        shell_ready = "/bin/sh: can't access tty; job control turned off"
+        self.wait_for_console_pattern(shell_ready)
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'mmcblk0')
+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
+                                                 'eth0: Link is Up')
+        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
+            'udhcpc: lease of 10.0.2.15 obtained')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+        os.remove(kernel_path)
+        os.remove(dtb_path)
+        os.remove(rootfs_path)
+
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_orangepi_armbian(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
+        """
+        self.set_machine('orangepi-pc')
+        # This test download a 275 MiB compressed image and expand it
+        # to 1036 MiB, but the underlying filesystem is 1552 MiB...
+        # As we expand it to 2 GiB we are safe.
+        image_path_xz = self.ASSET_ARMBIAN.fetch()
+        image_path = os.path.join(self.workdir, 'armbian.img')
+        lzma_uncompress(image_path_xz, image_path)
+        image_pow2ceil_expand(image_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'loglevel=7 '
+                               'nosmp '
+                               'systemd.default_timeout_start_sec=9000 '
+                               'systemd.mask=armbian-zram-config.service '
+                               'systemd.mask=armbian-ramlog.service')
+
+        self.wait_for_console_pattern('U-Boot SPL')
+        self.wait_for_console_pattern('Autoboot in ')
+        exec_command_and_wait_for_pattern(self, ' ', '=>')
+        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
+                                                kernel_command_line + "'", '=>')
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+
+        self.wait_for_console_pattern('systemd[1]: Hostname set ' +
+                                      'to <orangepipc>')
+        self.wait_for_console_pattern('Starting Load Kernel Modules...')
+
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_orangepi_uboot_netbsd9(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
+        :avocado: tags=os:netbsd
+        """
+        self.set_machine('orangepi-pc')
+        # This test download a 304MB compressed image and expand it to 2GB
+        deb_path = self.ASSET_UBOOT.fetch()
+        # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
+        # program loader (SPL). We will then set the path to the more specific
+        # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
+        # before to boot NetBSD.
+        uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+        image_path_gz = self.ASSET_NETBSD.fetch()
+        image_path = os.path.join(self.workdir, 'armv7.img')
+        gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
+
+        # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
+        with open(uboot_path, 'rb') as f_in:
+            with open(image_path, 'r+b') as f_out:
+                f_out.seek(8 * 1024)
+                shutil.copyfileobj(f_in, f_out)
+
+        self.vm.set_console()
+        self.vm.add_args('-nic', 'user',
+                         '-drive', image_drive_args,
+                         '-global', 'allwinner-rtc.base-year=2000',
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'U-Boot 2020.01+dfsg-1')
+        interrupt_interactive_console_until_pattern(self,
+                                       'Hit any key to stop autoboot:',
+                                       'switch to partitions #0, OK')
+
+        exec_command_and_wait_for_pattern(self, '', '=>')
+        cmd = 'setenv bootargs root=ld0a'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = 'setenv kernel netbsd-GENERIC.ub'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = 'setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = ("setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; "
+               "fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; "
+               "fdt addr ${fdt_addr_r}; "
+               "bootm ${kernel_addr_r} - ${fdt_addr_r}'")
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+
+        exec_command_and_wait_for_pattern(self, 'boot',
+                                          'Booting kernel from Legacy Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+        wait_for_console_pattern(self, 'NetBSD 9.0 (GENERIC)')
+        # Wait for user-space
+        wait_for_console_pattern(self, 'Starting root file system check')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.0


