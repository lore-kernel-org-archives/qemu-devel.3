Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9053ED729ED
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rN-0004ji-S4; Fri, 29 Nov 2024 12:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qr-0003xX-LP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qn-00015k-Qm
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zo2Ev1h7XM8RNSSw5ZdsJlEx6lQdeBi9sJy/SAc7ROA=;
 b=LC3aGmt83hZdxlZgr5YgxRmOx+Oa2NiYn2w6EvORpXH3sM5VgddWfM4Iwj+/3hGoSGh59d
 dpjy3aWoj5/dIMTYwG1SR4HH0l4eAforvyPqPxufta4w9an0fi1lG3wHSKkenMPq8SgUDt
 jsca+KSumdidEq5OUgfsfvL2EYuDKRM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-LGcB97lJOyWWkjA7n18lpQ-1; Fri,
 29 Nov 2024 12:32:14 -0500
X-MC-Unique: LGcB97lJOyWWkjA7n18lpQ-1
X-Mimecast-MFC-AGG-ID: LGcB97lJOyWWkjA7n18lpQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F693195608A; Fri, 29 Nov 2024 17:32:13 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84D721955F2D; Fri, 29 Nov 2024 17:32:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 19/22] tests/functional: convert tests to new archive_extract
 helper
Date: Fri, 29 Nov 2024 17:31:17 +0000
Message-ID: <20241129173120.761728-20-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Replace use of utils.archive_extract and extract_from_deb with the
new archive_extract helper.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/linuxkernel.py     | 19 +-------------
 tests/functional/test_aarch64_aspeed.py       |  4 +--
 tests/functional/test_aarch64_raspi3.py       |  8 +-----
 tests/functional/test_aarch64_raspi4.py       | 14 +++++-----
 tests/functional/test_acpi_bits.py            | 15 +++--------
 tests/functional/test_arm_aspeed.py           | 26 +++++--------------
 tests/functional/test_arm_bflt.py             |  3 +--
 tests/functional/test_arm_bpim2u.py           | 22 +++++++---------
 tests/functional/test_arm_canona1100.py       | 10 +++----
 tests/functional/test_arm_collie.py           |  1 -
 tests/functional/test_arm_orangepi.py         | 26 ++++++++-----------
 tests/functional/test_arm_raspi2.py           | 14 +++++-----
 tests/functional/test_arm_sx1.py              |  1 -
 tests/functional/test_arm_vexpress.py         |  4 +--
 tests/functional/test_m68k_mcf5208evb.py      |  4 +--
 tests/functional/test_m68k_q800.py            |  5 ++--
 .../functional/test_microblaze_s3adsp1800.py  |  4 +--
 .../test_microblazeel_s3adsp1800.py           |  4 +--
 tests/functional/test_mips64el_fuloong2e.py   |  6 ++---
 tests/functional/test_mips64el_malta.py       |  6 ++---
 tests/functional/test_mips_malta.py           | 12 ++++-----
 tests/functional/test_mipsel_malta.py         |  5 +---
 tests/functional/test_or1k_sim.py             |  4 +--
 tests/functional/test_ppc64_e500.py           |  4 +--
 tests/functional/test_ppc_amiga.py            |  5 +---
 tests/functional/test_ppc_bamboo.py           |  4 +--
 tests/functional/test_ppc_mac.py              |  5 +---
 tests/functional/test_ppc_mpc8544ds.py        |  7 +++--
 tests/functional/test_ppc_virtex_ml507.py     |  4 +--
 tests/functional/test_sh4_r2d.py              |  5 ++--
 tests/functional/test_sh4eb_r2d.py            |  5 ++--
 tests/functional/test_sparc64_sun4u.py        |  8 +++---
 tests/functional/test_sparc_sun4m.py          |  4 +--
 tests/functional/test_xtensa_lx60.py          |  4 +--
 34 files changed, 90 insertions(+), 182 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index fb6a158d36..6a1bfdabba 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -7,7 +7,7 @@
 
 from .testcase import QemuSystemTest
 from .cmd import wait_for_console_pattern
-from .utils import deb_extract
+
 
 class LinuxKernelTest(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -28,20 +28,3 @@ def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
         self.vm.launch()
         if wait_for:
                 self.wait_for_console_pattern(wait_for)
-
-    def extract_from_deb(self, deb_path, path):
-        """
-        Extracts a file from a deb package into the test workdir
-
-        :param deb_path: path to the deb archive
-        :param path: path within the deb archive of the file to be extracted
-        :returns: path of the extracted file
-        """
-        relpath = os.path.relpath(path, '/')
-        deb_extract(deb_path, self.workdir, member="." + path)
-        # Return complete path to extracted file.  Because callers to
-        # extract_from_deb() specify 'path' with a leading slash, it is
-        # necessary to use 'relative_to()' to turn it into a relative
-        # path for joining to the scratch dir
-        return os.path.normpath(self.scratch_file(relpath))
-
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index c6c6b74acc..3c2f9bc978 100644
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -12,7 +12,6 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import archive_extract
 
 class AST2x00MachineSDK(QemuSystemTest):
 
@@ -35,8 +34,7 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
     def test_aarch64_ast2700_evb_sdk_v09_02(self):
         self.set_machine('ast2700-evb')
 
-        image_path = self.ASSET_SDK_V902_AST2700.fetch()
-        archive_extract(image_path, self.workdir)
+        self.archive_extract(self.ASSET_SDK_V902_AST2700)
 
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
index 98ed6f9d56..74f6630ed2 100755
--- a/tests/functional/test_aarch64_raspi3.py
+++ b/tests/functional/test_aarch64_raspi3.py
@@ -7,8 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from zipfile import ZipFile
-
 from qemu_test import LinuxKernelTest, Asset
 
 
@@ -21,11 +19,7 @@ class Aarch64Raspi3Machine(LinuxKernelTest):
 
     def test_aarch64_raspi3_atf(self):
         efi_name = 'RPI_EFI.fd'
-        zip_path = self.ASSET_RPI3_UEFI.fetch()
-
-        with ZipFile(zip_path, 'r') as zf:
-                     zf.extract(efi_name, path=self.workdir)
-        efi_fd = self.scratch_file(efi_name)
+        efi_fd = self.archive_extract(self.ASSET_RPI3_UEFI, member=efi_name)
 
         self.set_machine('raspi3b')
         self.vm.set_console(console_index=1)
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index 6d68411528..4f95a3a61a 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -30,9 +30,10 @@ class Aarch64Raspi4Machine(LinuxKernelTest):
         '7c0b16d1853772f6f4c3ca63e789b3b9ff4936efac9c8a01fb0c98c05c7a7648')
 
     def test_arm_raspi4(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='/boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='/boot/bcm2711-rpi-4-b.dtb')
 
         self.set_machine('raspi4b')
         self.vm.set_console()
@@ -58,9 +59,10 @@ def test_arm_raspi4(self):
 
 
     def test_arm_raspi4_initrd(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='/boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='/boot/bcm2711-rpi-4-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index a2872d2ddf..0649fba545 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -37,9 +37,7 @@
 import re
 import shutil
 import subprocess
-import tarfile
 import tempfile
-import zipfile
 
 from typing import (
     List,
@@ -262,19 +260,12 @@ def setUp(self): # pylint: disable=arguments-differ
                                           %(self.BITS_INTERNAL_VER,
                                             self.BITS_COMMIT_HASH))
 
-        bitsLocalArtLoc = self.ASSET_BITS.fetch()
-        self.logger.info("downloaded bits artifacts to %s", bitsLocalArtLoc)
-
         # extract the bits artifact in the temp working directory
-        with zipfile.ZipFile(bitsLocalArtLoc, 'r') as zref:
-            zref.extractall(prebuiltDir)
+        self.archive_extract(self.ASSET_BITS, sub_dir='prebuilt', format='zip')
 
         # extract the bits software in the temp working directory
-        with zipfile.ZipFile(bits_zip_file, 'r') as zref:
-            zref.extractall(self.workdir)
-
-        with tarfile.open(grub_tar_file, 'r', encoding='utf-8') as tarball:
-            tarball.extractall(self.workdir)
+        self.archive_extract(bits_zip_file)
+        self.archive_extract(grub_tar_file)
 
         self.copy_test_scripts()
         self.copy_bits_config()
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index ca223ac8f0..8e8fac9d7a 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -15,8 +15,6 @@
                        interrupt_interactive_console_until_pattern,
                        skipIfMissingCommands,
 )
-from qemu_test.utils import archive_extract
-from zipfile import ZipFile
 from unittest import skipUnless
 
 class AST1030Machine(LinuxKernelTest):
@@ -29,12 +27,8 @@ class AST1030Machine(LinuxKernelTest):
     def test_ast1030_zephyros_1_04(self):
         self.set_machine('ast1030-evb')
 
-        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
-
-        kernel_name = "ast1030-evb-demo/zephyr.elf"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = self.scratch_file(kernel_name)
+        kernel_file = self.archive_extract(
+            self.ASSET_ZEPHYR_1_04, member="ast1030-evb-demo/zephyr.elf")
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -51,12 +45,8 @@ def test_ast1030_zephyros_1_04(self):
     def test_ast1030_zephyros_1_07(self):
         self.set_machine('ast1030-evb')
 
-        zip_file = self.ASSET_ZEPHYR_1_07.fetch()
-
-        kernel_name = "ast1030-evb-demo/zephyr.bin"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = self.scratch_file(kernel_name)
+        kernel_file = self.archive_extract(
+            self.ASSET_ZEPHYR_1_07, member="ast1030-evb-demo/zephyr.bin")
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -270,9 +260,7 @@ def do_test_arm_aspeed_sdk_start(self, image):
     def test_arm_ast2500_evb_sdk(self):
         self.set_machine('ast2500-evb')
 
-        image_path = self.ASSET_SDK_V806_AST2500.fetch()
-
-        archive_extract(image_path, self.workdir)
+        self.archive_extract(self.ASSET_SDK_V806_AST2500)
 
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file('ast2500-default', 'image-bmc'))
@@ -286,9 +274,7 @@ def test_arm_ast2500_evb_sdk(self):
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
 
-        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
-
-        archive_extract(image_path, self.workdir)
+        self.archive_extract(self.ASSET_SDK_V806_AST2600_A2)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
index c73e0bfa8c..38d8c4b744 100755
--- a/tests/functional/test_arm_bflt.py
+++ b/tests/functional/test_arm_bflt.py
@@ -11,7 +11,6 @@
 from qemu_test import QemuUserTest, Asset, has_cmd
 from qemu_test import (QemuUserTest, Asset, skipIfMissingCommands,
                        skipUntrustedTest)
-from qemu_test.utils import cpio_extract
 
 
 class LoadBFLT(QemuUserTest):
@@ -28,7 +27,7 @@ def test_stm32(self):
         busybox_path = self.scratch_file("bin", "busybox")
 
         with bz2.open(rootfs_path_bz2, 'rb') as cpio_handle:
-            cpio_extract(cpio_handle, self.workdir)
+            self.archive_extract(cpio_handle, format="cpio")
 
         res = self.run_cmd(busybox_path)
         ver = 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) multi-call binary.'
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 69f6cdaf68..fd30984e6b 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -10,7 +10,7 @@
 from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
                        Asset, interrupt_interactive_console_until_pattern,
                        skipBigDataTest)
-from qemu_test.utils import (archive_extract, gzip_uncompress, lzma_uncompress,
+from qemu_test.utils import (gzip_uncompress, lzma_uncompress,
                              image_pow2ceil_expand)
 
 
@@ -39,12 +39,11 @@ class BananaPiMachine(LinuxKernelTest):
 
     def test_arm_bpim2u(self):
         self.set_machine('bpim2u')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -61,12 +60,11 @@ def test_arm_bpim2u(self):
 
     def test_arm_bpim2u_initrd(self):
         self.set_machine('bpim2u')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
@@ -100,11 +98,11 @@ def test_arm_bpim2u_gmac(self):
         self.require_netdev('user')
 
         deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
         rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
index cee6a23ed1..5cfb6a0ceb 100755
--- a/tests/functional/test_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -11,7 +11,6 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
-from qemu_test.utils import archive_extract
 
 class CanonA1100Machine(QemuSystemTest):
     """Boots the barebox firmware and checks that the console is operational"""
@@ -25,13 +24,10 @@ class CanonA1100Machine(QemuSystemTest):
     def test_arm_canona1100(self):
         self.set_machine('canon-a1100')
 
-        file_path = self.ASSET_BIOS.fetch()
-        archive_extract(file_path, dest_dir=self.workdir,
-                        member="day18/barebox.canon-a1100.bin")
+        bios = self.archive_extract(self.ASSET_BIOS,
+                                    member="day18/barebox.canon-a1100.bin")
         self.vm.set_console()
-        self.vm.add_args('-bios',
-                         self.scratch_file('day18',
-                                           'barebox.canon-a1100.bin'))
+        self.vm.add_args('-bios', bios)
         self.vm.launch()
         wait_for_console_pattern(self, 'running /env/bin/init')
 
diff --git a/tests/functional/test_arm_collie.py b/tests/functional/test_arm_collie.py
index 7e144a0a8f..78fe61dfdf 100755
--- a/tests/functional/test_arm_collie.py
+++ b/tests/functional/test_arm_collie.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class CollieTest(LinuxKernelTest):
 
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 7b5e7b6ae1..ff3b62e686 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -11,7 +11,7 @@
 from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
                        Asset, interrupt_interactive_console_until_pattern,
                        wait_for_console_pattern, skipBigDataTest)
-from qemu_test.utils import (archive_extract, gzip_uncompress, lzma_uncompress,
+from qemu_test.utils import (gzip_uncompress, lzma_uncompress,
                              image_pow2ceil_expand)
 
 
@@ -50,11 +50,10 @@ class BananaPiMachine(LinuxKernelTest):
 
     def test_arm_orangepi(self):
         self.set_machine('orangepi-pc')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -71,11 +70,10 @@ def test_arm_orangepi(self):
 
     def test_arm_orangepi_initrd(self):
         self.set_machine('orangepi-pc')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
@@ -107,11 +105,10 @@ def test_arm_orangepi_initrd(self):
     def test_arm_orangepi_sd(self):
         self.set_machine('orangepi-pc')
         self.require_netdev('user')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='/boot/vmlinuz-6.6.16-current-sunxi')
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
         rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
@@ -189,13 +186,12 @@ def test_arm_orangepi_armbian(self):
     def test_arm_orangepi_uboot_netbsd9(self):
         self.set_machine('orangepi-pc')
         # This test download a 304MB compressed image and expand it to 2GB
-        deb_path = self.ASSET_UBOOT.fetch()
         # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
         # program loader (SPL). We will then set the path to the more specific
         # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
         # before to boot NetBSD.
         uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
-        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+        uboot_path = self.archive_extract(self.ASSET_UBOOT, member=uboot_path)
         image_path_gz = self.ASSET_NETBSD.fetch()
         image_path = self.scratch_file('armv7.img')
         gzip_uncompress(image_path_gz, image_path)
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index c59dd6c066..8724eee010 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -35,9 +35,10 @@ def do_test_arm_raspi2(self, uart_id):
         serial_kernel_cmdline = {
             0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
         }
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='/boot/kernel7.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='/boot/bcm2709-rpi-2-b.dtb')
 
         self.set_machine('raspi2b')
         self.vm.set_console()
@@ -59,9 +60,10 @@ def test_arm_raspi2_uart0(self):
         self.do_test_arm_raspi2(0)
 
     def test_arm_raspi2_initrd(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='/boot/kernel7.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='/boot/bcm2709-rpi-2-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index 2292317946..aa08e6fb19 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -14,7 +14,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class SX1Test(LinuxKernelTest):
 
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
index b1ac63ac36..3861366325 100755
--- a/tests/functional/test_arm_vexpress.py
+++ b/tests/functional/test_arm_vexpress.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class VExpressTest(LinuxKernelTest):
 
@@ -16,8 +15,7 @@ class VExpressTest(LinuxKernelTest):
 
     def test_arm_vexpressa9(self):
         self.set_machine('vexpress-a9')
-        file_path = self.ASSET_DAY16.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY16)
         self.launch_kernel(self.scratch_file('day16', 'winter.zImage'),
                            dtb=self.scratch_file('day16',
                                                  'vexpress-v2p-ca9.dtb'),
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
index 449248c3e8..ae650ae4ca 100755
--- a/tests/functional/test_m68k_mcf5208evb.py
+++ b/tests/functional/test_m68k_mcf5208evb.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class Mcf5208EvbTest(LinuxKernelTest):
 
@@ -16,8 +15,7 @@ class Mcf5208EvbTest(LinuxKernelTest):
 
     def test_m68k_mcf5208evb(self):
         self.set_machine('mcf5208evb')
-        file_path = self.ASSET_DAY07.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY07)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day07', 'sanity-clause.elf'))
diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/test_m68k_q800.py
index 3b17244b98..c63f9b6935 100755
--- a/tests/functional/test_m68k_q800.py
+++ b/tests/functional/test_m68k_q800.py
@@ -18,9 +18,8 @@ class Q800MachineTest(LinuxKernelTest):
     def test_m68k_q800(self):
         self.set_machine('q800')
 
-        deb_path = self.ASSET_KERNEL.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.3.0-1-m68k')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL,
+                                           member='/boot/vmlinux-5.3.0-1-m68k')
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index aafc375d3c..56e5e082c8 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -9,7 +9,6 @@
 
 from qemu_test import (exec_command, exec_command_and_wait_for_pattern,
                        QemuSystemTest, Asset, wait_for_console_pattern)
-from qemu_test.utils import archive_extract
 
 class MicroblazeMachine(QemuSystemTest):
 
@@ -22,8 +21,7 @@ class MicroblazeMachine(QemuSystemTest):
 
     def test_microblaze_s3adsp1800(self):
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_IMAGE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 9ea9182f42..9cc516ebf3 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -10,7 +10,6 @@
 import time
 from qemu_test import (exec_command, exec_command_and_wait_for_pattern,
                        QemuSystemTest, Asset, wait_for_console_pattern)
-from qemu_test.utils import archive_extract
 
 class MicroblazeelMachine(QemuSystemTest):
 
@@ -23,8 +22,7 @@ class MicroblazeelMachine(QemuSystemTest):
     def test_microblazeel_s3adsp1800(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_IMAGE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
         tftproot = self.scratch_file('day13')
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
index 8d0ae8d1d5..920a7ec881 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -27,9 +27,9 @@ class MipsFuloong2e(LinuxKernelTest):
         '2a70f15b397f4ced632b0c15cb22660394190644146d804d60a4796eefbe1f50')
 
     def test_linux_kernel_3_16(self):
-        deb_path = self.ASSET_KERNEL.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-3.16.0-6-loongson-2e')
+        kernel_path = self.archive_extract(
+            self.ASSET_KERNEL,
+            member='/boot/vmlinux-3.16.0-6-loongson-2e')
 
         self.set_machine('fuloong2e')
         self.vm.set_console()
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index cc17f8af1f..d4b3c1eeab 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -39,9 +39,9 @@ def test_mips64el_malta(self):
         [2] https://kernel-team.pages.debian.net/kernel-handbook/
             ch-common-tasks.html#s-common-official
         """
-        deb_path = self.ASSET_KERNEL_2_63_2.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
+        kernel_path = self.archive_extract(
+            self.ASSET_KERNEL_2_63_2,
+            member='/boot/vmlinux-2.6.32-5-5kc-malta')
 
         self.set_machine('malta')
         self.vm.set_console()
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index a6d80d0012..65300b7ddf 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -20,9 +20,9 @@ class MaltaMachineConsole(LinuxKernelTest):
         '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
 
     def test_mips_malta(self):
-        deb_path = self.ASSET_KERNEL_2_63_2.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
+        kernel_path = self.archive_extract(
+            self.ASSET_KERNEL_2_63_2,
+            member='/boot/vmlinux-2.6.32-5-4kc-malta')
 
         self.set_machine('malta')
         self.vm.set_console()
@@ -46,9 +46,9 @@ def test_mips_malta(self):
         'dcfe3a7fe3200da3a00d176b95caaa086495eb158f2bff64afc67d7e1eb2cddc')
 
     def test_mips_malta_cpio(self):
-        deb_path = self.ASSET_KERNEL_4_5_0.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
+        kernel_path = self.archive_extract(
+            self.ASSET_KERNEL_4_5_0,
+            member='/boot/vmlinux-4.5.0-2-4kc-malta')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index c5bb4f73c8..90747ba2d0 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -15,7 +15,6 @@
                        interrupt_interactive_console_until_pattern,
                        wait_for_console_pattern)
 from qemu_test.utils import lzma_uncompress
-from zipfile import ZipFile
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -75,9 +74,7 @@ class MaltaMachineYAMON(QemuSystemTest):
 
     def test_mipsel_malta_yamon(self):
         yamon_bin = 'yamon-02.22.bin'
-        zip_path = self.ASSET_YAMON_ROM.fetch()
-        with ZipFile(zip_path, 'r') as zf:
-            zf.extract(yamon_bin, path=self.workdir)
+        self.archive_extract(self.ASSET_YAMON_ROM)
         yamon_path = self.scratch_file(yamon_bin)
 
         self.set_machine('malta')
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
index a5b2b5b1e5..49f2e3467e 100755
--- a/tests/functional/test_or1k_sim.py
+++ b/tests/functional/test_or1k_sim.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class OpenRISC1kSimTest(LinuxKernelTest):
 
@@ -16,8 +15,7 @@ class OpenRISC1kSimTest(LinuxKernelTest):
 
     def test_or1k_sim(self):
         self.set_machine('or1k-sim')
-        file_path = self.ASSET_DAY20.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY20)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day20', 'vmlinux'))
         self.vm.launch()
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index bf4a6af9d4..24295646e0 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -5,7 +5,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class E500Test(LinuxKernelTest):
 
@@ -16,8 +15,7 @@ class E500Test(LinuxKernelTest):
     def test_ppc64_e500(self):
         self.set_machine('ppce500')
         self.cpu = 'e5500'
-        file_path = self.ASSET_DAY19.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY19)
         self.launch_kernel(self.scratch_file('day19', 'uImage'),
                            wait_for='QEMU advent calendar')
 
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
index 3e1a666c45..8508697456 100755
--- a/tests/functional/test_ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -10,7 +10,6 @@
 import subprocess
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern, run_cmd
-from zipfile import ZipFile
 
 class AmigaOneMachine(QemuSystemTest):
 
@@ -25,9 +24,7 @@ def test_ppc_amigaone(self):
         self.require_accelerator("tcg")
         self.set_machine('amigaone')
         tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
-        zip_file = self.ASSET_IMAGE.fetch()
-        with ZipFile(zip_file, 'r') as zf:
-            zf.extractall(path=self.workdir)
+        self.archive_extract(self.ASSET_IMAGE, format="zip")
         bios = self.scratch_file("u-boot-amigaone.bin")
         with open(bios, "wb") as bios_fh:
             subprocess.run(['tail', '-c', '524288',
diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
index 7ec173cbcd..2890200b92 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
                        exec_command_and_wait_for_pattern)
 
@@ -25,8 +24,7 @@ def test_ppc_bamboo(self):
         self.set_machine('bamboo')
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_IMAGE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('system-image-powerpc-440fp',
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
index 10812824bd..e6b730c243 100755
--- a/tests/functional/test_ppc_mac.py
+++ b/tests/functional/test_ppc_mac.py
@@ -5,7 +5,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class MacTest(LinuxKernelTest):
 
@@ -19,9 +18,7 @@ def do_day15_test(self):
         # we're running kvm_hv or kvm_pr. For now let's disable this test
         # if we don't have TCG support.
         self.require_accelerator("tcg")
-
-        file_path = self.ASSET_DAY15.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY15)
         self.vm.add_args('-M', 'graphics=off')
         self.launch_kernel(self.scratch_file('day15', 'invaders.elf'),
                            wait_for='QEMU advent calendar')
diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/test_ppc_mpc8544ds.py
index 1089d5ff5b..8ca2257967 100755
--- a/tests/functional/test_ppc_mpc8544ds.py
+++ b/tests/functional/test_ppc_mpc8544ds.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class Mpc8544dsMachine(QemuSystemTest):
@@ -24,10 +23,10 @@ class Mpc8544dsMachine(QemuSystemTest):
     def test_ppc_mpc8544ds(self):
         self.require_accelerator("tcg")
         self.set_machine('mpc8544ds')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir, member='creek/creek.bin')
+        kernel_file = self.archive_extract(self.ASSET_IMAGE,
+                                           member='creek/creek.bin')
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.scratch_file('creek', 'creek.bin'))
+        self.vm.add_args('-kernel', kernel_file)
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU advent calendar 2020',
                                  self.panic_message)
diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional/test_ppc_virtex_ml507.py
index f39dfa5ae4..5f2a22c2c2 100755
--- a/tests/functional/test_ppc_virtex_ml507.py
+++ b/tests/functional/test_ppc_virtex_ml507.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class VirtexMl507Machine(QemuSystemTest):
@@ -24,8 +23,7 @@ class VirtexMl507Machine(QemuSystemTest):
     def test_ppc_virtex_ml507(self):
         self.require_accelerator("tcg")
         self.set_machine('virtex-ml507')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_IMAGE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('hippo', 'hippo.linux'),
                          '-dtb', self.scratch_file('hippo',
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
index dca4601392..03a648374c 100755
--- a/tests/functional/test_sh4_r2d.py
+++ b/tests/functional/test_sh4_r2d.py
@@ -5,7 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset, skipFlakyTest
-from qemu_test.utils import archive_extract
+
 
 class R2dTest(LinuxKernelTest):
 
@@ -19,8 +19,7 @@ class R2dTest(LinuxKernelTest):
     @skipFlakyTest(bug_url=None)
     def test_r2d(self):
         self.set_machine('r2d')
-        file_path = self.ASSET_DAY09.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY09)
         self.vm.add_args('-append', 'console=ttySC1')
         self.launch_kernel(self.scratch_file('day09', 'zImage'),
                            console_index=1,
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
index 38ee55cf4c..7087ab4c92 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -6,7 +6,7 @@
 
 from qemu_test import (LinuxKernelTest, Asset,
                        exec_command_and_wait_for_pattern)
-from qemu_test.utils import archive_extract
+
 
 class R2dEBTest(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class R2dEBTest(LinuxKernelTest):
 
     def test_sh4eb_r2d(self):
         self.set_machine('r2d')
-        file_path = self.ASSET_TGZ.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_TGZ)
         self.vm.add_args('-append', 'console=ttySC1 noiotrap')
         self.launch_kernel(self.scratch_file('sh4eb', 'linux-kernel'),
                            initrd=self.scratch_file('sh4eb', 'initramfs.cpio.gz'),
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
index 43617f1aaf..d1261639b4 100755
--- a/tests/functional/test_sparc64_sun4u.py
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -11,7 +11,6 @@
 # later. See the COPYING file in the top-level directory.
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
-from qemu_test.utils import archive_extract
 
 
 class Sun4uMachine(QemuSystemTest):
@@ -26,11 +25,10 @@ class Sun4uMachine(QemuSystemTest):
 
     def test_sparc64_sun4u(self):
         self.set_machine('sun4u')
-        file_path = self.ASSET_IMAGE.fetch()
-        kernel_name = 'day23/vmlinux'
-        archive_extract(file_path, self.workdir, kernel_name)
+        kernel_file = self.archive_extract(self.ASSET_IMAGE,
+                                           member='day23/vmlinux')
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.scratch_file(kernel_name),
+        self.vm.add_args('-kernel', kernel_file,
                          '-append', 'printk.time=0')
         self.vm.launch()
         wait_for_console_pattern(self, 'Starting logging: OK')
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
index 619c03d36a..468931f3ef 100755
--- a/tests/functional/test_sparc_sun4m.py
+++ b/tests/functional/test_sparc_sun4m.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class Sun4mTest(LinuxKernelTest):
 
@@ -16,8 +15,7 @@ class Sun4mTest(LinuxKernelTest):
 
     def test_sparc_ss20(self):
         self.set_machine('SS-20')
-        file_path = self.ASSET_DAY11.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY11)
         self.launch_kernel(self.scratch_file('day11', 'zImage.elf'),
                            wait_for='QEMU advent calendar')
 
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
index 5048e4c69e..ec59509a34 100755
--- a/tests/functional/test_xtensa_lx60.py
+++ b/tests/functional/test_xtensa_lx60.py
@@ -6,7 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
 
 class XTensaLX60Test(LinuxKernelTest):
 
@@ -17,8 +16,7 @@ class XTensaLX60Test(LinuxKernelTest):
     def test_xtensa_lx60(self):
         self.set_machine('lx60')
         self.cpu = 'dc233c'
-        file_path = self.ASSET_DAY02.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY02)
         self.launch_kernel(self.scratch_file('day02',
                                              'santas-sleigh-ride.elf'),
                            wait_for='QEMU advent calendar')
-- 
2.46.0


