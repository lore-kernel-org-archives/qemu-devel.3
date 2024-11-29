Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA1D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rI-0004Xs-8L; Fri, 29 Nov 2024 12:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qx-000468-Jy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qv-00017L-5R
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPJ1jAMbeTUugoGsXmA99voHNxJYR4JASHnvPOAsrR8=;
 b=MVd9+HcmxlD0y12gwtYI6IIj/xayzlqCdTsaHtAY724kAZ89TAPgiMkuuGr+h+kBuio50j
 gaUo8sEBOidHy1/7kQfQ2yVVOIhdfeQdA2QKBY3j1ZgwQiv4Tksuy3vJcW2GLkkcx3QGvJ
 oPyzKLUqJjQmFD1lWjuq0o2sBFiyOJs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-u9mS1jwzNtOqsd-SIvzq0w-1; Fri,
 29 Nov 2024 12:32:23 -0500
X-MC-Unique: u9mS1jwzNtOqsd-SIvzq0w-1
X-Mimecast-MFC-AGG-ID: u9mS1jwzNtOqsd-SIvzq0w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37148195609F; Fri, 29 Nov 2024 17:32:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E65141955F41; Fri, 29 Nov 2024 17:32:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 22/22] tests/functional: convert tests to new uncompress helper
Date: Fri, 29 Nov 2024 17:31:20 +0000
Message-ID: <20241129173120.761728-23-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

Replace use of lzma_uncompress and gzip_uncompress with the
new uncompress helper.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py    |  2 +-
 tests/functional/test_aarch64_raspi4.py   |  5 +----
 tests/functional/test_aarch64_sbsaref.py  |  9 ++-------
 tests/functional/test_alpha_clipper.py    |  4 +---
 tests/functional/test_arm_bpim2u.py       | 15 ++++-----------
 tests/functional/test_arm_orangepi.py     | 19 +++++--------------
 tests/functional/test_arm_raspi2.py       |  5 +----
 tests/functional/test_mips64el_malta.py   |  9 ++-------
 tests/functional/test_mips_malta.py       |  5 +----
 tests/functional/test_mipsel_malta.py     | 15 +++++----------
 tests/functional/test_rx_gdbsim.py        |  5 +----
 tests/functional/test_s390x_ccw_virtio.py |  6 ++----
 tests/functional/test_s390x_topology.py   |  5 +----
 13 files changed, 27 insertions(+), 77 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 5c088a2442..b91a72cda0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -53,7 +53,7 @@ def uncompress(self, input_path, format=None):
         (name, ext) = os.path.splitext(input_path)
         output_path = self.scratch_file(os.path.basename(name))
 
-        utils_uncompress(input_path, output_path)
+        utils_uncompress(input_path, output_path, format)
 
         return output_path
 
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index 4f95a3a61a..8eca1c5fee 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -7,7 +7,6 @@
 
 from qemu_test import (LinuxKernelTest, Asset,
                        exec_command_and_wait_for_pattern)
-from qemu_test.utils import gzip_uncompress
 
 
 class Aarch64Raspi4Machine(LinuxKernelTest):
@@ -63,9 +62,7 @@ def test_arm_raspi4_initrd(self):
                                            member='/boot/kernel8.img')
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='/boot/bcm2711-rpi-4-b.dtb')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('raspi4b')
         self.vm.set_console()
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 4c173a0303..38de5f5ba9 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -10,7 +10,6 @@
 
 from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
                        interrupt_interactive_console_until_pattern)
-from qemu_test.utils import lzma_uncompress
 
 
 def fetch_firmware(test):
@@ -29,14 +28,10 @@ def fetch_firmware(test):
     """
 
     # Secure BootRom (TF-A code)
-    fs0_xz_path = Aarch64SbsarefMachine.ASSET_FLASH0.fetch()
-    fs0_path = test.scratch_file("SBSA_FLASH0.fd")
-    lzma_uncompress(fs0_xz_path, fs0_path)
+    fs0_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH0)
 
     # Non-secure rom (UEFI and EFI variables)
-    fs1_xz_path = Aarch64SbsarefMachine.ASSET_FLASH1.fetch()
-    fs1_path = test.scratch_file("SBSA_FLASH1.fd")
-    lzma_uncompress(fs1_xz_path, fs1_path)
+    fs1_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH1)
 
     for path in [fs0_path, fs1_path]:
         with open(path, "ab+") as fd:
diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/test_alpha_clipper.py
index 72cd7b57e6..c5d7181953 100755
--- a/tests/functional/test_alpha_clipper.py
+++ b/tests/functional/test_alpha_clipper.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import gzip_uncompress
 
 
 class AlphaClipperTest(LinuxKernelTest):
@@ -20,8 +19,7 @@ def test_alpha_clipper(self):
         self.set_machine('clipper')
         kernel_path = self.ASSET_KERNEL.fetch()
 
-        uncompressed_kernel = self.scratch_file('vmlinux')
-        gzip_uncompress(kernel_path, uncompressed_kernel)
+        uncompressed_kernel = self.uncompress(self.ASSET_KERNEL, format="gz")
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index fd30984e6b..50ecf7babb 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -10,8 +10,7 @@
 from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
                        Asset, interrupt_interactive_console_until_pattern,
                        skipBigDataTest)
-from qemu_test.utils import (gzip_uncompress, lzma_uncompress,
-                             image_pow2ceil_expand)
+from qemu_test.utils import (image_pow2ceil_expand)
 
 
 class BananaPiMachine(LinuxKernelTest):
@@ -65,9 +64,7 @@ def test_arm_bpim2u_initrd(self):
         dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -103,9 +100,7 @@ def test_arm_bpim2u_gmac(self):
         dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        rootfs_path_xz = self.ASSET_ROOTFS.fetch()
-        rootfs_path = self.scratch_file('rootfs.cpio')
-        lzma_uncompress(rootfs_path_xz, rootfs_path)
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
         image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
@@ -147,9 +142,7 @@ def test_arm_bpim2u_openwrt_22_03_3(self):
         self.set_machine('bpim2u')
         # This test download a 8.9 MiB compressed image and expand it
         # to 127 MiB.
-        image_path_gz = self.ASSET_SD_IMAGE.fetch()
-        image_path = self.scratch_file('sdcard.img')
-        gzip_uncompress(image_path_gz, image_path)
+        image_path = self.uncompress(self.ASSET_SD_IMAGE)
         image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index ff3b62e686..9c3aad4dbc 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -11,8 +11,7 @@
 from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
                        Asset, interrupt_interactive_console_until_pattern,
                        wait_for_console_pattern, skipBigDataTest)
-from qemu_test.utils import (gzip_uncompress, lzma_uncompress,
-                             image_pow2ceil_expand)
+from qemu_test.utils import image_pow2ceil_expand
 
 
 class BananaPiMachine(LinuxKernelTest):
@@ -74,9 +73,7 @@ def test_arm_orangepi_initrd(self):
             self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -109,9 +106,7 @@ def test_arm_orangepi_sd(self):
             self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        rootfs_path_xz = self.ASSET_ROOTFS.fetch()
-        rootfs_path = self.scratch_file('rootfs.cpio')
-        lzma_uncompress(rootfs_path_xz, rootfs_path)
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
         image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
@@ -152,9 +147,7 @@ def test_arm_orangepi_armbian(self):
         # This test download a 275 MiB compressed image and expand it
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
         # As we expand it to 2 GiB we are safe.
-        image_path_xz = self.ASSET_ARMBIAN.fetch()
-        image_path = self.scratch_file('armbian.img')
-        lzma_uncompress(image_path_xz, image_path)
+        iamge_path = self.uncompress(self.ASSET_ARMBIAN)
         image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
@@ -192,9 +185,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # before to boot NetBSD.
         uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
         uboot_path = self.archive_extract(self.ASSET_UBOOT, member=uboot_path)
-        image_path_gz = self.ASSET_NETBSD.fetch()
-        image_path = self.scratch_file('armv7.img')
-        gzip_uncompress(image_path_gz, image_path)
+        image_path = self.uncompress(self.ASSET_NETBSD)
         image_pow2ceil_expand(image_path)
         image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index 8724eee010..8c001568f8 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -9,7 +9,6 @@
 
 from qemu_test import (LinuxKernelTest, Asset,
                        exec_command_and_wait_for_pattern)
-from qemu_test.utils import gzip_uncompress
 
 
 class ArmRaspi2Machine(LinuxKernelTest):
@@ -64,9 +63,7 @@ def test_arm_raspi2_initrd(self):
                                            member='/boot/kernel7.img')
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='/boot/bcm2709-rpi-2-b.dtb')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('raspi2b')
         self.vm.set_console()
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index d4b3c1eeab..7f7da37c0f 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -15,7 +15,6 @@
 from qemu_test import (LinuxKernelTest, Asset,
                        exec_command_and_wait_for_pattern,
                        skipIfMissingImports, skipFlakyTest, skipUntrustedTest)
-from qemu_test.utils import gzip_uncompress
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -67,9 +66,7 @@ def test_mips64el_malta(self):
     @skipUntrustedTest()
     def test_mips64el_malta_5KEc_cpio(self):
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
-        initrd_path_gz = self.ASSET_CPIO_R1.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_CPIO_R1)
 
         self.set_machine('malta')
         self.vm.set_console()
@@ -119,9 +116,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
 
         screendump_path = self.scratch_file('screendump.pbm')
 
-        kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
-        kernel_path = self.scratch_file("vmlinux")
-        gzip_uncompress(kernel_path_gz, kernel_path)
+        kernel_path = self.uncompress(self.ASSET_KERNEL_4_7_0)
 
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
 
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index 65300b7ddf..3695a9e6a6 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -8,7 +8,6 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import gzip_uncompress
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -49,9 +48,7 @@ def test_mips_malta_cpio(self):
         kernel_path = self.archive_extract(
             self.ASSET_KERNEL_4_5_0,
             member='/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('malta')
         self.vm.set_console()
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index 90747ba2d0..aed41ac9b9 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -14,7 +14,6 @@
 from qemu_test import (QemuSystemTest, LinuxKernelTest, Asset,
                        interrupt_interactive_console_until_pattern,
                        wait_for_console_pattern)
-from qemu_test.utils import lzma_uncompress
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -35,9 +34,8 @@ class MaltaMachineConsole(LinuxKernelTest):
          'generic_nano32r6el_page64k_dbg.xz'),
         'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
 
-    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = self.scratch_file('kernel')
-        lzma_uncompress(kernel_path_xz, kernel_path)
+    def do_test_mips_malta32el_nanomips(self, kernel):
+        kernel_path = self.uncompress(kernel)
 
         self.set_machine('malta')
         self.vm.set_console()
@@ -53,16 +51,13 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         self.wait_for_console_pattern(console_pattern)
 
     def test_mips_malta32el_nanomips_4k(self):
-        kernel_path_xz = self.ASSET_KERNEL_4K.fetch()
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+        self.do_test_mips_malta32el_nanomips(self.ASSET_KERNEL_4K)
 
     def test_mips_malta32el_nanomips_16k_up(self):
-        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+        self.do_test_mips_malta32el_nanomips(self.ASSET_KERNEL_16K)
 
     def test_mips_malta32el_nanomips_64k_dbg(self):
-        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+        self.do_test_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)
 
 
 class MaltaMachineYAMON(QemuSystemTest):
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index b7d5d7d062..d0238a0fd5 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -13,7 +13,6 @@
 from qemu_test import (QemuSystemTest, Asset,
                        exec_command_and_wait_for_pattern,
                        wait_for_console_pattern, skipFlakyTest)
-from qemu_test.utils import gzip_uncompress
 
 
 class RxGdbSimMachine(QemuSystemTest):
@@ -37,9 +36,7 @@ def test_uboot(self):
         """
         self.set_machine('gdbsim-r5f562n8')
 
-        uboot_path_gz = self.ASSET_UBOOT.fetch()
-        uboot_path = self.scratch_file('u-boot.bin')
-        gzip_uncompress(uboot_path_gz, uboot_path)
+        uboot_path = self.uncompress(self.ASSET_UBOOT)
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
index e70fffa290..c24747d4a8 100755
--- a/tests/functional/test_s390x_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -17,7 +17,7 @@
 from qemu_test import (QemuSystemTest, Asset,
                        exec_command_and_wait_for_pattern,
                        wait_for_console_pattern)
-from qemu_test.utils import lzma_uncompress
+
 
 class S390CCWVirtioMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -174,9 +174,7 @@ def test_s390x_fedora(self):
 
         kernel_path = self.ASSET_F31_KERNEL.fetch()
 
-        initrd_path_xz = self.ASSET_F31_INITRD.fetch()
-        initrd_path = self.scratch_file('initrd-raw.img')
-        lzma_uncompress(initrd_path_xz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_F31_INITRD, format="xz")
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE + ' audit=0 '
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
index 64276e4f7e..aa6ddb8601 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -13,7 +13,6 @@
 from qemu_test import (QemuSystemTest, Asset, exec_command,
                        exec_command_and_wait_for_pattern,
                        wait_for_console_pattern)
-from qemu_test.utils import lzma_uncompress
 
 
 class S390CPUTopology(QemuSystemTest):
@@ -85,9 +84,7 @@ def kernel_init(self):
         """
         self.require_accelerator("kvm")
         kernel_path = self.ASSET_F35_KERNEL.fetch()
-        initrd_path_xz = self.ASSET_F35_INITRD.fetch()
-        initrd_path = self.scratch_file('initrd-raw.img')
-        lzma_uncompress(initrd_path_xz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_F35_INITRD, format="xz")
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
-- 
2.46.0


