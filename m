Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65E6E7718C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxJ-0006oh-4f; Wed, 18 Dec 2024 06:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxH-0006oD-OX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxD-0005rX-O9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Op129QwDfpUe2U3Z/7I2/VHCnnUlGYZGS1dXlWsAWBg=;
 b=gHCq1NYkvD7pUTSLsx+8hXX9fxVJizHmfXWGARHoaf33JgkfyEj9/7R/aSzGm53f+Hj/2t
 1aLWtOe7tPnIG4ssfRhS5tRCczfqE5+9w0hR45z+Z9hrHmg8KiVozU2D46ttvQNiFx/00/
 ojzoigvOu+iq2Mh+Ipzi1r1gdldYFYU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-ZsEG12k3NBq4mCLLMF6XvQ-1; Wed,
 18 Dec 2024 06:10:57 -0500
X-MC-Unique: ZsEG12k3NBq4mCLLMF6XvQ-1
X-Mimecast-MFC-AGG-ID: ZsEG12k3NBq4mCLLMF6XvQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78F3719357B0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEBD81955F3C; Wed, 18 Dec 2024 11:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 23/38] tests/functional: convert tests to new archive_extract
 helper
Date: Wed, 18 Dec 2024 12:09:43 +0100
Message-ID: <20241218110958.226932-24-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel P. Berrangé <berrange@redhat.com>

Replace use of utils.archive_extract and extract_from_deb with the
new archive_extract helper.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-24-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/linuxkernel.py     | 19 ----------
 tests/functional/test_aarch64_aspeed.py       |  5 ++-
 tests/functional/test_aarch64_raspi3.py       |  8 +----
 tests/functional/test_aarch64_raspi4.py       | 14 ++++----
 tests/functional/test_acpi_bits.py            | 15 ++------
 tests/functional/test_arm_aspeed_ast1030.py   | 16 +++------
 tests/functional/test_arm_aspeed_ast2500.py   |  6 ++--
 tests/functional/test_arm_aspeed_ast2600.py   |  5 +--
 tests/functional/test_arm_aspeed_rainier.py   | 11 +++---
 tests/functional/test_arm_bflt.py             |  3 +-
 tests/functional/test_arm_bpim2u.py           | 26 +++++++-------
 tests/functional/test_arm_canona1100.py       | 11 +++---
 tests/functional/test_arm_cubieboard.py       | 20 +++++------
 tests/functional/test_arm_orangepi.py         | 35 +++++++++----------
 tests/functional/test_arm_raspi2.py           | 14 ++++----
 tests/functional/test_arm_smdkc210.py         |  9 +++--
 tests/functional/test_arm_vexpress.py         |  5 ++-
 tests/functional/test_m68k_mcf5208evb.py      |  5 ++-
 tests/functional/test_m68k_q800.py            |  5 ++-
 .../functional/test_microblaze_s3adsp1800.py  |  5 ++-
 .../test_microblazeel_s3adsp1800.py           |  5 ++-
 tests/functional/test_mips64el_fuloong2e.py   |  6 ++--
 tests/functional/test_mips64el_malta.py       |  6 ++--
 tests/functional/test_mips_malta.py           | 12 +++----
 tests/functional/test_mipsel_malta.py         |  5 +--
 tests/functional/test_or1k_sim.py             |  5 ++-
 tests/functional/test_ppc64_e500.py           |  5 ++-
 tests/functional/test_ppc_amiga.py            |  6 ++--
 tests/functional/test_ppc_bamboo.py           |  5 ++-
 tests/functional/test_ppc_mac.py              |  6 ++--
 tests/functional/test_ppc_mpc8544ds.py        |  8 ++---
 tests/functional/test_ppc_virtex_ml507.py     |  5 ++-
 tests/functional/test_sh4_r2d.py              |  5 ++-
 tests/functional/test_sh4eb_r2d.py            |  5 ++-
 tests/functional/test_sparc64_sun4u.py        |  8 ++---
 tests/functional/test_sparc_sun4m.py          |  5 ++-
 tests/functional/test_xtensa_lx60.py          |  5 ++-
 37 files changed, 134 insertions(+), 205 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 8f2810f3af..2c9598102d 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -3,11 +3,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
-
 from .testcase import QemuSystemTest
 from .cmd import wait_for_console_pattern
-from .archive import deb_extract
 
 
 class LinuxKernelTest(QemuSystemTest):
@@ -29,19 +26,3 @@ def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
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
-        deb_extract(deb_path, self.workdir, member="." + path)
-        # Return complete path to extracted file.  Because callers to
-        # extract_from_deb() specify 'path' with a leading slash, it is
-        # necessary to use os.path.relpath() as otherwise scratch_file()
-        # interprets it as an absolute path and drops the required prefix
-        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))
-
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index 8ba2c67248..141d863859 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -11,7 +11,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import archive_extract
+
 
 class AST2x00MachineSDK(QemuSystemTest):
 
@@ -34,8 +34,7 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
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
index 2cda03f86f..3918e35e82 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -30,9 +30,10 @@ class Aarch64Raspi4Machine(LinuxKernelTest):
         '7c0b16d1853772f6f4c3ca63e789b3b9ff4936efac9c8a01fb0c98c05c7a7648')
 
     def test_arm_raspi4(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2711-rpi-4-b.dtb')
 
         self.set_machine('raspi4b')
         self.vm.set_console()
@@ -58,9 +59,10 @@ def test_arm_raspi4(self):
 
 
     def test_arm_raspi4_initrd(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2711-rpi-4-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 3b99ecf3a4..20da435687 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -35,8 +35,6 @@
 import re
 import shutil
 import subprocess
-import tarfile
-import zipfile
 
 from typing import (
     List,
@@ -260,19 +258,12 @@ def setUp(self): # pylint: disable=arguments-differ
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
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/test_arm_aspeed_ast1030.py
index 01b13c5591..d45d9f7c1c 100755
--- a/tests/functional/test_arm_aspeed_ast1030.py
+++ b/tests/functional/test_arm_aspeed_ast1030.py
@@ -8,7 +8,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from zipfile import ZipFile
+
 
 class AST1030Machine(LinuxKernelTest):
 
@@ -20,12 +20,9 @@ class AST1030Machine(LinuxKernelTest):
     def test_ast1030_zephyros_1_04(self):
         self.set_machine('ast1030-evb')
 
-        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
-
         kernel_name = "ast1030-evb-demo/zephyr.elf"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = self.scratch_file(kernel_name)
+        kernel_file = self.archive_extract(
+            self.ASSET_ZEPHYR_1_04, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -42,12 +39,9 @@ def test_ast1030_zephyros_1_04(self):
     def test_ast1030_zephyros_1_07(self):
         self.set_machine('ast1030-evb')
 
-        zip_file = self.ASSET_ZEPHYR_1_07.fetch()
-
         kernel_name = "ast1030-evb-demo/zephyr.bin"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = self.scratch_file(kernel_name)
+        kernel_file = self.archive_extract(
+            self.ASSET_ZEPHYR_1_07, member=kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
index 8c5593cdc8..743fc46eb2 100755
--- a/tests/functional/test_arm_aspeed_ast2500.py
+++ b/tests/functional/test_arm_aspeed_ast2500.py
@@ -7,7 +7,7 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import archive_extract
+
 
 class AST2500Machine(AspeedTest):
 
@@ -45,9 +45,7 @@ def test_arm_ast2500_evb_buildroot(self):
     def test_arm_ast2500_evb_sdk(self):
         self.set_machine('ast2500-evb')
 
-        image_path = self.ASSET_SDK_V806_AST2500.fetch()
-
-        archive_extract(image_path, self.workdir)
+        self.archive_extract(self.ASSET_SDK_V806_AST2500)
 
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2500-default", "image-bmc"))
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
index 25948c1c34..21640123ee 100755
--- a/tests/functional/test_arm_aspeed_ast2600.py
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -12,7 +12,6 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
-from qemu_test.utils import archive_extract
 
 
 class AST2600Machine(AspeedTest):
@@ -105,9 +104,7 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
 
-        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
-
-        archive_extract(image_path, self.workdir)
+        self.archive_extract(self.ASSET_SDK_V806_AST2600_A2)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/functional/test_arm_aspeed_rainier.py
index b856aea6db..602d6194ac 100755
--- a/tests/functional/test_arm_aspeed_rainier.py
+++ b/tests/functional/test_arm_aspeed_rainier.py
@@ -43,11 +43,12 @@ def test_arm_aspeed_emmc_boot(self):
     def test_arm_debian_kernel_boot(self):
         self.set_machine('rainier-bmc')
 
-        deb_path = self.ASSET_DEBIAN_LINUX_ARMHF_DEB.fetch()
-
-        kernel_path = self.extract_from_deb(deb_path, '/boot/vmlinuz-5.17.0-2-armmp')
-        dtb_path = self.extract_from_deb(deb_path,
-                '/usr/lib/linux-image-5.17.0-2-armmp/aspeed-bmc-ibm-rainier.dtb')
+        kernel_path = self.archive_extract(
+            self.ASSET_DEBIAN_LINUX_ARMHF_DEB,
+            member='boot/vmlinuz-5.17.0-2-armmp')
+        dtb_path = self.archive_extract(
+            self.ASSET_DEBIAN_LINUX_ARMHF_DEB,
+            member='usr/lib/linux-image-5.17.0-2-armmp/aspeed-bmc-ibm-rainier.dtb')
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
index 88ef7b1edc..f273fc8354 100755
--- a/tests/functional/test_arm_bflt.py
+++ b/tests/functional/test_arm_bflt.py
@@ -10,7 +10,6 @@
 
 from qemu_test import QemuUserTest, Asset
 from qemu_test import skipIfMissingCommands, skipUntrustedTest
-from qemu_test.utils import cpio_extract
 
 
 class LoadBFLT(QemuUserTest):
@@ -27,7 +26,7 @@ def test_stm32(self):
         busybox_path = self.scratch_file("bin", "busybox")
 
         with bz2.open(rootfs_path_bz2, 'rb') as cpio_handle:
-            cpio_extract(cpio_handle, self.workdir)
+            self.archive_extract(cpio_handle, format="cpio")
 
         res = self.run_cmd(busybox_path)
         ver = 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) multi-call binary.'
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 2af6d9a18d..91c56b0930 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -39,12 +39,11 @@ class BananaPiMachine(LinuxKernelTest):
 
     def test_arm_bpim2u(self):
         self.set_machine('bpim2u')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
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
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
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
-        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
         rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
index b4e3633422..21a1a596a0 100755
--- a/tests/functional/test_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -12,7 +12,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract
+
 
 class CanonA1100Machine(QemuSystemTest):
     """Boots the barebox firmware and checks that the console is operational"""
@@ -26,13 +26,10 @@ class CanonA1100Machine(QemuSystemTest):
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
 
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index d81c333d0c..32db303253 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -38,11 +38,11 @@ class CubieboardMachine(LinuxKernelTest):
 
     def test_arm_cubieboard_initrd(self):
         self.set_machine('cubieboard')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+                    'sun4i-a10-cubieboard.dtb')
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
@@ -71,11 +71,11 @@ def test_arm_cubieboard_initrd(self):
 
     def test_arm_cubieboard_sata(self):
         self.set_machine('cubieboard')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+                    'sun4i-a10-cubieboard.dtb')
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
         rootfs_path_gz = self.ASSET_SATA_ROOTFS.fetch()
         rootfs_path = self.scratch_file('rootfs.cpio')
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index bea67cfb6a..aa2d9d19a4 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -50,11 +50,11 @@ class BananaPiMachine(LinuxKernelTest):
 
     def test_arm_orangepi(self):
         self.set_machine('orangepi-pc')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+                    'sun8i-h3-orangepi-pc.dtb')
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -71,11 +71,11 @@ def test_arm_orangepi(self):
 
     def test_arm_orangepi_initrd(self):
         self.set_machine('orangepi-pc')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+                    'sun8i-h3-orangepi-pc.dtb')
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
@@ -107,11 +107,11 @@ def test_arm_orangepi_initrd(self):
     def test_arm_orangepi_sd(self):
         self.set_machine('orangepi-pc')
         self.require_netdev('user')
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+                    'sun8i-h3-orangepi-pc.dtb')
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
         rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
@@ -189,13 +189,12 @@ def test_arm_orangepi_armbian(self):
     def test_arm_orangepi_uboot_netbsd9(self):
         self.set_machine('orangepi-pc')
         # This test download a 304MB compressed image and expand it to 2GB
-        deb_path = self.ASSET_UBOOT.fetch()
         # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
         # program loader (SPL). We will then set the path to the more specific
         # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
         # before to boot NetBSD.
-        uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
-        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+        uboot_path = 'usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
+        uboot_path = self.archive_extract(self.ASSET_UBOOT, member=uboot_path)
         image_path_gz = self.ASSET_NETBSD.fetch()
         image_path = self.scratch_file('armv7.img')
         gzip_uncompress(image_path_gz, image_path)
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index 075f6b3301..5e38d1a937 100755
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
+                                           member='boot/kernel7.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2709-rpi-2-b.dtb')
 
         self.set_machine('raspi2b')
         self.vm.set_console()
@@ -59,9 +60,10 @@ def test_arm_raspi2_uart0(self):
         self.do_test_arm_raspi2(0)
 
     def test_arm_raspi2_initrd(self):
-        deb_path = self.ASSET_KERNEL_20190215.fetch()
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel7.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2709-rpi-2-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
index c6c8f9a5f4..f4e86f7e2b 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -25,11 +25,10 @@ class Smdkc210Machine(LinuxKernelTest):
     def test_arm_exynos4210_initrd(self):
         self.set_machine('smdkc210')
 
-        deb_path = self.ASSET_DEB.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.19.0-6-armmp')
-        dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        kernel_path = self.archive_extract(self.ASSET_DEB,
+                                           member='boot/vmlinuz-4.19.0-6-armmp')
+        dtb_path = 'usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
+        dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
         initrd_path_gz = self.ASSET_ROOTFS.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
index b1ac63ac36..6b11552894 100755
--- a/tests/functional/test_arm_vexpress.py
+++ b/tests/functional/test_arm_vexpress.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class VExpressTest(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class VExpressTest(LinuxKernelTest):
 
     def test_arm_vexpressa9(self):
         self.set_machine('vexpress-a9')
-        file_path = self.ASSET_DAY16.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY16)
         self.launch_kernel(self.scratch_file('day16', 'winter.zImage'),
                            dtb=self.scratch_file('day16',
                                                  'vexpress-v2p-ca9.dtb'),
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
index 449248c3e8..c7d1998933 100755
--- a/tests/functional/test_m68k_mcf5208evb.py
+++ b/tests/functional/test_m68k_mcf5208evb.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class Mcf5208EvbTest(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class Mcf5208EvbTest(LinuxKernelTest):
 
     def test_m68k_mcf5208evb(self):
         self.set_machine('mcf5208evb')
-        file_path = self.ASSET_DAY07.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY07)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day07', 'sanity-clause.elf'))
diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/test_m68k_q800.py
index 3b17244b98..400b7aeb5d 100755
--- a/tests/functional/test_m68k_q800.py
+++ b/tests/functional/test_m68k_q800.py
@@ -18,9 +18,8 @@ class Q800MachineTest(LinuxKernelTest):
     def test_m68k_q800(self):
         self.set_machine('q800')
 
-        deb_path = self.ASSET_KERNEL.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.3.0-1-m68k')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL,
+                                           member='boot/vmlinux-5.3.0-1-m68k')
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 61c4d6bbf8..2c4464bd05 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -9,7 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract
+
 
 class MicroblazeMachine(QemuSystemTest):
 
@@ -22,8 +22,7 @@ class MicroblazeMachine(QemuSystemTest):
 
     def test_microblaze_s3adsp1800(self):
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_IMAGE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 926c885f63..c382afe6bf 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -11,7 +11,7 @@
 from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract
+
 
 class MicroblazeelMachine(QemuSystemTest):
 
@@ -24,8 +24,7 @@ class MicroblazeelMachine(QemuSystemTest):
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
index 531d16d8f6..35e500b022 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -26,9 +26,9 @@ class MipsFuloong2e(LinuxKernelTest):
         '2a70f15b397f4ced632b0c15cb22660394190644146d804d60a4796eefbe1f50')
 
     def test_linux_kernel_3_16(self):
-        deb_path = self.ASSET_KERNEL.fetch()
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-3.16.0-6-loongson-2e')
+        kernel_path = self.archive_extract(
+            self.ASSET_KERNEL,
+            member='boot/vmlinux-3.16.0-6-loongson-2e')
 
         self.set_machine('fuloong2e')
         self.vm.set_console()
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index ea362cf335..39fafb8bf1 100755
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
+            member='boot/vmlinux-2.6.32-5-5kc-malta')
 
         self.set_machine('malta')
         self.vm.set_console()
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index a6d80d0012..6ab6c0832a 100755
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
+            member='boot/vmlinux-2.6.32-5-4kc-malta')
 
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
+            member='boot/vmlinux-4.5.0-2-4kc-malta')
         initrd_path_gz = self.ASSET_INITRD.fetch()
         initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index 77671e0081..1f44881c78 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -13,7 +13,6 @@
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
 from qemu_test.utils import lzma_uncompress
-from zipfile import ZipFile
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -73,9 +72,7 @@ class MaltaMachineYAMON(QemuSystemTest):
 
     def test_mipsel_malta_yamon(self):
         yamon_bin = 'yamon-02.22.bin'
-        zip_path = self.ASSET_YAMON_ROM.fetch()
-        with ZipFile(zip_path, 'r') as zf:
-            zf.extract(yamon_bin, path=self.workdir)
+        self.archive_extract(self.ASSET_YAMON_ROM)
         yamon_path = self.scratch_file(yamon_bin)
 
         self.set_machine('malta')
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
index a5b2b5b1e5..f9f0b690a0 100755
--- a/tests/functional/test_or1k_sim.py
+++ b/tests/functional/test_or1k_sim.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class OpenRISC1kSimTest(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class OpenRISC1kSimTest(LinuxKernelTest):
 
     def test_or1k_sim(self):
         self.set_machine('or1k-sim')
-        file_path = self.ASSET_DAY20.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY20)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day20', 'vmlinux'))
         self.vm.launch()
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index bf4a6af9d4..b92fe0b0e7 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -5,7 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class E500Test(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class E500Test(LinuxKernelTest):
     def test_ppc64_e500(self):
         self.set_machine('ppce500')
         self.cpu = 'e5500'
-        file_path = self.ASSET_DAY19.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY19)
         self.launch_kernel(self.scratch_file('day19', 'uImage'),
                            wait_for='QEMU advent calendar')
 
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
index 9ed23a1f0f..8600e2e963 100755
--- a/tests/functional/test_ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -11,7 +11,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from zipfile import ZipFile
+
 
 class AmigaOneMachine(QemuSystemTest):
 
@@ -26,9 +26,7 @@ def test_ppc_amigaone(self):
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
index 1ae2f47bcc..fddcc24d0d 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -7,11 +7,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 
+
 class BambooMachine(QemuSystemTest):
 
     timeout = 90
@@ -25,8 +25,7 @@ def test_ppc_bamboo(self):
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
index 10812824bd..9e4bc1a52c 100755
--- a/tests/functional/test_ppc_mac.py
+++ b/tests/functional/test_ppc_mac.py
@@ -5,7 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class MacTest(LinuxKernelTest):
 
@@ -19,9 +19,7 @@ def do_day15_test(self):
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
index 87b5d4d12b..0715410d7a 100755
--- a/tests/functional/test_ppc_mpc8544ds.py
+++ b/tests/functional/test_ppc_mpc8544ds.py
@@ -7,10 +7,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
+
 class Mpc8544dsMachine(QemuSystemTest):
 
     timeout = 90
@@ -25,10 +25,10 @@ class Mpc8544dsMachine(QemuSystemTest):
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
index f297651e64..8fe43549b7 100755
--- a/tests/functional/test_ppc_virtex_ml507.py
+++ b/tests/functional/test_ppc_virtex_ml507.py
@@ -7,10 +7,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test.utils import archive_extract
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
+
 class VirtexMl507Machine(QemuSystemTest):
 
     timeout = 90
@@ -25,8 +25,7 @@ class VirtexMl507Machine(QemuSystemTest):
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
index c8954c93eb..473093bbe1 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -6,7 +6,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
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
                            initrd=self.scratch_file('sh4eb',
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
index e7f6db0f24..27ac289659 100755
--- a/tests/functional/test_sparc64_sun4u.py
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -12,7 +12,6 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract
 
 
 class Sun4uMachine(QemuSystemTest):
@@ -27,11 +26,10 @@ class Sun4uMachine(QemuSystemTest):
 
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
index 619c03d36a..7cd28ebdd1 100755
--- a/tests/functional/test_sparc_sun4m.py
+++ b/tests/functional/test_sparc_sun4m.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class Sun4mTest(LinuxKernelTest):
 
@@ -16,8 +16,7 @@ class Sun4mTest(LinuxKernelTest):
 
     def test_sparc_ss20(self):
         self.set_machine('SS-20')
-        file_path = self.ASSET_DAY11.fetch()
-        archive_extract(file_path, self.workdir)
+        self.archive_extract(self.ASSET_DAY11)
         self.launch_kernel(self.scratch_file('day11', 'zImage.elf'),
                            wait_for='QEMU advent calendar')
 
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
index 5048e4c69e..147c920899 100755
--- a/tests/functional/test_xtensa_lx60.py
+++ b/tests/functional/test_xtensa_lx60.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class XTensaLX60Test(LinuxKernelTest):
 
@@ -17,8 +17,7 @@ class XTensaLX60Test(LinuxKernelTest):
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
2.47.1


