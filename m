Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4830D2AB08
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5iTX-0007bn-DT; Tue, 29 Oct 2024 05:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5iTG-0007Un-PM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5iTC-00041f-J3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730193896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kq8VGu24n1+lkwaAdGGCBNQKC7V9a4Y5jMF37lx7Vo8=;
 b=W6zHTiFSfRCgDC8AVj++amiDJy1pf6qA8sgg9rZ5Ci+7l/xk6vp2Bwhb+MJ2epzz3gb4IU
 pQX5mJY6JzOA5DI8wGH4CFQ3J8w2xaECY1NhzHYxU23S3aeEWwNSWJS2hDM9GRN4dDnCSE
 7QlVf8SzMsMZFoEi1rJ6ShCxe3cS81E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-8NQQTzqpNQeL6IvmLlqXjA-1; Tue,
 29 Oct 2024 05:24:52 -0400
X-MC-Unique: 8NQQTzqpNQeL6IvmLlqXjA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 530D319560B7; Tue, 29 Oct 2024 09:24:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.191])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 297E01956054; Tue, 29 Oct 2024 09:24:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/2] tests/functional: Convert BananaPi tests to the
 functional framework
Date: Tue, 29 Oct 2024 10:24:39 +0100
Message-ID: <20241029092440.25021-2-thuth@redhat.com>
In-Reply-To: <20241029092440.25021-1-thuth@redhat.com>
References: <20241029092440.25021-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move the BananaPi tests from tests/avocado/boot_linux_console.py into
a new file dedicated for Banana Pi tests in the functional framework.
Update the hash sums of the assets to sha256 along the way and fix the
broken link for the buildroot image from storage.kernelci.org.

(Note: The test_arm_bpim2u_openwrt_22_03_3 test is currently broken
due to a regression in commit 4c2c047469 ("target/arm: Fix usage of MMU
indexes when EL3 is AArch32") - it works if that commit gets reverted)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py | 176 ------------------------
 tests/functional/meson.build        |   2 +
 tests/functional/qemu_test/utils.py |  21 +++
 tests/functional/test_arm_bpim2u.py | 206 ++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 176 deletions(-)
 create mode 100755 tests/functional/test_arm_bpim2u.py

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 23d1b3587b..d05abf0d1a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -471,182 +471,6 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
 
-    def test_arm_bpim2u(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=accel:tcg
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
-                    'sun8i-r40-bananapi-m2-ultra.dtb')
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
-    def test_arm_bpim2u_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:bpim2u
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
-                    'sun8i-r40-bananapi-m2-ultra.dtb')
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
-    def test_arm_bpim2u_gmac(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:bpim2u
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
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
-                    'sun8i-r40-bananapi-m2-ultra.dtb')
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
-                               'root=b300 rootwait rw '
-                               'panic=-1 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
-                         '-net', 'nic,model=gmac,netdev=host_gmac',
-                         '-netdev', 'user,id=host_gmac',
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        shell_ready = "/bin/sh: can't access tty; job control turned off"
-        self.wait_for_console_pattern(shell_ready)
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun8i Family')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
-                                                'mmcblk')
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
-    def test_arm_bpim2u_openwrt_22_03_3(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=device:sd
-        """
-
-        # This test download a 8.9 MiB compressed image and expand it
-        # to 127 MiB.
-        image_url = ('https://downloads.openwrt.org/releases/22.03.3/targets/'
-                     'sunxi/cortexa7/openwrt-22.03.3-sunxi-cortexa7-'
-                     'sinovoip_bananapi-m2-ultra-ext4-sdcard.img.gz')
-        image_hash = ('5b41b4e11423e562c6011640f9a7cd3b'
-                      'dd0a3d42b83430f7caa70a432e6cd82c')
-        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash,
-                                         algorithm='sha256')
-        image_path = archive.extract(image_path_gz, self.workdir)
-        image_pow2ceil_expand(image_path)
-
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
-                         '-nic', 'user',
-                         '-no-reboot')
-        self.vm.launch()
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'usbcore.nousb '
-                               'noreboot')
-
-        self.wait_for_console_pattern('U-Boot SPL')
-
-        interrupt_interactive_console_until_pattern(
-                self, 'Hit any key to stop autoboot:', '=>')
-        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
-                                                kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
-
-        self.wait_for_console_pattern(
-            'Please press Enter to activate this console.')
-
-        exec_command_and_wait_for_pattern(self, ' ', 'root@')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun8i Family')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'system-control@1c00000')
-
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d642c11516..0a6880b610 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,7 @@ test_timeouts = {
   'aarch64_sbsaref' : 600,
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
+  'arm_bpim2u' : 360,
   'arm_raspi2' : 120,
   'arm_tuxrun' : 120,
   'mips_malta' : 120,
@@ -52,6 +53,7 @@ tests_alpha_system_thorough = [
 ]
 
 tests_arm_system_thorough = [
+  'arm_bpim2u',
   'arm_canona1100',
   'arm_integratorcp',
   'arm_raspi2',
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 2a1cb60d38..1bf1c410d5 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -15,6 +15,27 @@
 import subprocess
 import tarfile
 
+"""
+Round up to next power of 2
+"""
+def pow2ceil(x):
+    return 1 if x == 0 else 2**(x - 1).bit_length()
+
+def file_truncate(path, size):
+    if size != os.path.getsize(path):
+        with open(path, 'ab+') as fd:
+            fd.truncate(size)
+
+"""
+Expand file size to next power of 2
+"""
+def image_pow2ceil_expand(path):
+        size = os.path.getsize(path)
+        size_aligned = pow2ceil(size)
+        if size != size_aligned:
+            with open(path, 'ab+') as fd:
+                fd.truncate(size_aligned)
+
 def archive_extract(archive, dest_dir, member=None):
     with tarfile.open(archive) as tf:
         if hasattr(tarfile, 'data_filter'):
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
new file mode 100755
index 0000000000..2f9fa145e3
--- /dev/null
+++ b/tests/functional/test_arm_bpim2u.py
@@ -0,0 +1,206 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Banana Pi machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
+from qemu_test import Asset, interrupt_interactive_console_until_pattern
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
+    ASSET_SD_IMAGE = Asset(
+        ('https://downloads.openwrt.org/releases/22.03.3/targets/sunxi/cortexa7/'
+         'openwrt-22.03.3-sunxi-cortexa7-sinovoip_bananapi-m2-ultra-ext4-sdcard.img.gz'),
+        '5b41b4e11423e562c6011640f9a7cd3bdd0a3d42b83430f7caa70a432e6cd82c')
+
+    def test_arm_bpim2u(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=accel:tcg
+        """
+        self.set_machine('bpim2u')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
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
+    def test_arm_bpim2u_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=accel:tcg
+        :avocado: tags=machine:bpim2u
+        """
+        self.set_machine('bpim2u')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
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
+    def test_arm_bpim2u_gmac(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=device:sd
+        """
+        self.set_machine('bpim2u')
+        self.require_netdev('user')
+
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        rootfs_path_xz = self.ASSET_ROOTFS.fetch()
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'root=b300 rootwait rw '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
+                         '-net', 'nic,model=gmac,netdev=host_gmac',
+                         '-netdev', 'user,id=host_gmac',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        shell_ready = "/bin/sh: can't access tty; job control turned off"
+        self.wait_for_console_pattern(shell_ready)
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'mmcblk')
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
+    def test_arm_bpim2u_openwrt_22_03_3(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=device:sd
+        """
+        self.set_machine('bpim2u')
+        # This test download a 8.9 MiB compressed image and expand it
+        # to 127 MiB.
+        image_path_gz = self.ASSET_SD_IMAGE.fetch()
+        image_path = os.path.join(self.workdir, 'sdcard.img')
+        gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'usbcore.nousb '
+                               'noreboot')
+
+        self.wait_for_console_pattern('U-Boot SPL')
+
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', '=>')
+        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
+                                                kernel_command_line + "'", '=>')
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+
+        self.wait_for_console_pattern(
+            'Please press Enter to activate this console.')
+
+        exec_command_and_wait_for_pattern(self, ' ', 'root@')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        os.remove(image_path)
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.0


