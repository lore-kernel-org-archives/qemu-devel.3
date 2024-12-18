Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EBAE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrx5-0006YQ-1k; Wed, 18 Dec 2024 06:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx2-0006XY-TD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrws-0005Jz-ES
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkBxR5zjBRxjgSghr9IpXFB9hzCSLYKn0hJZLGrhbKc=;
 b=Zn93fOFkHeiguhwrWirAgOPhsaQYv/s5uPrvC9VDImVY6K53+FaGls3PoxJTYMR4oH/xQM
 U2aYk+yO0UzCbr12bX+4Xt1Mk9dR2uPeUutM7jDq3vtFKJkHBnTVRfhZOZ/imlGA5qRQMb
 JtrP4a93yqAzRnFxWotlrtdc0ojTAFo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-Mlo0uW_mMrqE0USnsGUohA-1; Wed,
 18 Dec 2024 06:10:35 -0500
X-MC-Unique: Mlo0uW_mMrqE0USnsGUohA-1
X-Mimecast-MFC-AGG-ID: Mlo0uW_mMrqE0USnsGUohA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB70B1955F28
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 585DA19560AD; Wed, 18 Dec 2024 11:10:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 14/38] tests/functional: switch over to using
 self.scratch_file()
Date: Wed, 18 Dec 2024 12:09:34 +0100
Message-ID: <20241218110958.226932-15-thuth@redhat.com>
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

Replace any instances of

  os.path.join(self.workdir, ".../...")
  self.workdir + "/.../..."

with

  self.scratch_file("...", "...")

which is more compact and portable

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-15-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/linuxkernel.py     |  7 ++-
 tests/functional/qemu_test/tuxruntest.py      |  2 +-
 tests/functional/test_aarch64_aspeed.py       | 17 ++++---
 tests/functional/test_aarch64_raspi3.py       |  3 +-
 tests/functional/test_aarch64_raspi4.py       |  4 +-
 tests/functional/test_aarch64_sbsaref.py      |  6 +--
 tests/functional/test_aarch64_virt.py         |  3 +-
 tests/functional/test_acpi_bits.py            | 49 +++++++++----------
 tests/functional/test_alpha_clipper.py        |  4 +-
 tests/functional/test_arm_aspeed_ast1030.py   |  6 +--
 tests/functional/test_arm_aspeed_ast2500.py   |  2 +-
 tests/functional/test_arm_aspeed_ast2600.py   |  2 +-
 tests/functional/test_arm_bflt.py             |  3 +-
 tests/functional/test_arm_bpim2u.py           |  6 +--
 tests/functional/test_arm_canona1100.py       |  3 +-
 tests/functional/test_arm_cubieboard.py       |  6 +--
 tests/functional/test_arm_emcraft_sf2.py      |  2 +-
 tests/functional/test_arm_integratorcp.py     |  3 +-
 tests/functional/test_arm_orangepi.py         |  8 +--
 tests/functional/test_arm_raspi2.py           |  4 +-
 tests/functional/test_arm_smdkc210.py         |  2 +-
 tests/functional/test_arm_vexpress.py         |  5 +-
 tests/functional/test_m68k_mcf5208evb.py      |  3 +-
 tests/functional/test_m68k_nextcube.py        |  5 +-
 .../functional/test_microblaze_s3adsp1800.py  |  3 +-
 .../test_microblazeel_s3adsp1800.py           |  5 +-
 tests/functional/test_mips64el_malta.py       |  6 +--
 tests/functional/test_mips_malta.py           |  4 +-
 tests/functional/test_mipsel_malta.py         |  6 +--
 tests/functional/test_or1k_sim.py             |  2 +-
 tests/functional/test_ppc64_e500.py           |  2 +-
 tests/functional/test_ppc64_hv.py             | 12 +----
 tests/functional/test_ppc_amiga.py            | 12 +++--
 tests/functional/test_ppc_bamboo.py           | 10 ++--
 tests/functional/test_ppc_mac.py              |  2 +-
 tests/functional/test_ppc_mpc8544ds.py        |  2 +-
 tests/functional/test_ppc_virtex_ml507.py     |  5 +-
 tests/functional/test_rx_gdbsim.py            |  4 +-
 tests/functional/test_s390x_ccw_virtio.py     |  2 +-
 tests/functional/test_s390x_topology.py       |  4 +-
 tests/functional/test_sh4_r2d.py              |  3 +-
 tests/functional/test_sh4eb_r2d.py            |  8 +--
 tests/functional/test_sparc64_sun4u.py        |  5 +-
 tests/functional/test_sparc_sun4m.py          |  2 +-
 tests/functional/test_xtensa_lx60.py          |  3 +-
 45 files changed, 118 insertions(+), 139 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2b5b9a5fda..2e4f4e35fd 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -46,8 +46,7 @@ def extract_from_deb(self, deb_path, path):
         os.chdir(cwd)
         # Return complete path to extracted file.  Because callers to
         # extract_from_deb() specify 'path' with a leading slash, it is
-        # necessary to use os.path.relpath() as otherwise os.path.join()
-        # interprets it as an absolute path and drops the self.workdir part.
-        return os.path.normpath(os.path.join(self.workdir,
-                                             os.path.relpath(path, '/')))
+        # necessary to use os.path.relpath() as otherwise scratch_file()
+        # interprets it as an absolute path and drops the required prefix
+        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))
 
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 2e5c6d110c..0b1bb8f0ed 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -74,7 +74,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
         kernel_image =  kernel_asset.fetch()
         disk_image_zst = rootfs_asset.fetch()
 
-        disk_image = self.workdir + "/rootfs.ext4"
+        disk_image = self.scratch_file("rootfs.ext4")
 
         run_cmd(['zstd', "-f", "-d", disk_image_zst,
                  "-o", disk_image])
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index e196f88537..8ba2c67248 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -38,26 +38,28 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
         archive_extract(image_path, self.workdir)
 
         num_cpu = 4
-        image_dir = self.workdir + '/ast2700-default/'
-        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
+        uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
+                                                       'u-boot-nodtb.bin'))
         uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
 
         load_images_list = [
             {
                 'addr': '0x400000000',
-                'file': image_dir + 'u-boot-nodtb.bin'
+                'file': self.scratch_file('ast2700-default',
+                                          'u-boot-nodtb.bin')
             },
             {
                 'addr': str(uboot_dtb_load_addr),
-                'file': image_dir + 'u-boot.dtb'
+                'file': self.scratch_file('ast2700-default', 'u-boot.dtb')
             },
             {
                 'addr': '0x430000000',
-                'file': image_dir + 'bl31.bin'
+                'file': self.scratch_file('ast2700-default', 'bl31.bin')
             },
             {
                 'addr': '0x430080000',
-                'file': image_dir + 'optee/tee-raw.bin'
+                'file': self.scratch_file('ast2700-default', 'optee',
+                                          'tee-raw.bin')
             }
         ]
 
@@ -74,7 +76,8 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
         self.vm.add_args('-smp', str(num_cpu))
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
-        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
+        self.do_test_aarch64_aspeed_sdk_start(
+            self.scratch_file('ast2700-default', 'image-bmc'))
 
         wait_for_console_pattern(self, 'ast2700-default login:')
 
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
index 369f95a3d9..98ed6f9d56 100755
--- a/tests/functional/test_aarch64_raspi3.py
+++ b/tests/functional/test_aarch64_raspi3.py
@@ -7,7 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
 from zipfile import ZipFile
 
 from qemu_test import LinuxKernelTest, Asset
@@ -26,7 +25,7 @@ def test_aarch64_raspi3_atf(self):
 
         with ZipFile(zip_path, 'r') as zf:
                      zf.extract(efi_name, path=self.workdir)
-        efi_fd = os.path.join(self.workdir, efi_name)
+        efi_fd = self.scratch_file(efi_name)
 
         self.set_machine('raspi3b')
         self.vm.set_console(console_index=1)
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index e5c9f77479..2cda03f86f 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -5,8 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.utils import gzip_uncompress
@@ -64,7 +62,7 @@ def test_arm_raspi4_initrd(self):
         kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
         dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.set_machine('raspi4b')
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 6db08da522..533ca64407 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -8,8 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
@@ -32,12 +30,12 @@ def fetch_firmware(test):
 
     # Secure BootRom (TF-A code)
     fs0_xz_path = Aarch64SbsarefMachine.ASSET_FLASH0.fetch()
-    fs0_path = os.path.join(test.workdir, "SBSA_FLASH0.fd")
+    fs0_path = test.scratch_file("SBSA_FLASH0.fd")
     lzma_uncompress(fs0_xz_path, fs0_path)
 
     # Non-secure rom (UEFI and EFI variables)
     fs1_xz_path = Aarch64SbsarefMachine.ASSET_FLASH1.fetch()
-    fs1_path = os.path.join(test.workdir, "SBSA_FLASH1.fd")
+    fs1_path = test.scratch_file("SBSA_FLASH1.fd")
     lzma_uncompress(fs1_xz_path, fs1_path)
 
     for path in [fs0_path, fs1_path]:
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 5bc461b482..cc49f8963d 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -11,7 +11,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import time
-import os
 import logging
 
 from qemu_test import QemuSystemTest, Asset
@@ -95,7 +94,7 @@ def common_aarch64_virt(self, machine):
 
         # Also add a scratch block device
         logger.info('creating scratch qcow2 image')
-        image_path = os.path.join(self.workdir, 'scratch.qcow2')
+        image_path = self.scratch_file('scratch.qcow2')
         qemu_img = get_qemu_img(self)
         run_cmd([qemu_img, 'create', '-f', 'qcow2', image_path, '8M'])
 
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 59d0383563..3b99ecf3a4 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -135,9 +135,9 @@ def copy_bits_config(self):
         bits_config_file = self.data_file('acpi-bits',
                                           'bits-config',
                                           'bits-cfg.txt')
-        target_config_dir = os.path.join(self.workdir,
-                                         'bits-%d' %self.BITS_INTERNAL_VER,
-                                         'boot')
+        target_config_dir = self.scratch_file('bits-%d' %
+                                              self.BITS_INTERNAL_VER,
+                                              'boot')
         self.assertTrue(os.path.exists(bits_config_file))
         self.assertTrue(os.path.exists(target_config_dir))
         shutil.copy2(bits_config_file, target_config_dir)
@@ -148,9 +148,8 @@ def copy_test_scripts(self):
         """copies the python test scripts into bits. """
 
         bits_test_dir = self.data_file('acpi-bits', 'bits-tests')
-        target_test_dir = os.path.join(self.workdir,
-                                       'bits-%d' %self.BITS_INTERNAL_VER,
-                                       'boot', 'python')
+        target_test_dir = self.scratch_file('bits-%d' % self.BITS_INTERNAL_VER,
+                                            'boot', 'python')
 
         self.assertTrue(os.path.exists(bits_test_dir))
         self.assertTrue(os.path.exists(target_test_dir))
@@ -187,8 +186,8 @@ def fix_mkrescue(self, mkrescue):
             the directory where we have extracted our pre-built bits grub
             tarball.
         """
-        grub_x86_64_mods = os.path.join(self.workdir, 'grub-inst-x86_64-efi')
-        grub_i386_mods = os.path.join(self.workdir, 'grub-inst')
+        grub_x86_64_mods = self.scratch_file('grub-inst-x86_64-efi')
+        grub_i386_mods = self.scratch_file('grub-inst')
 
         self.assertTrue(os.path.exists(grub_x86_64_mods))
         self.assertTrue(os.path.exists(grub_i386_mods))
@@ -209,13 +208,11 @@ def generate_bits_iso(self):
         """ Uses grub-mkrescue to generate a fresh bits iso with the python
             test scripts
         """
-        bits_dir = os.path.join(self.workdir,
-                                'bits-%d' %self.BITS_INTERNAL_VER)
-        iso_file = os.path.join(self.workdir,
-                                'bits-%d.iso' %self.BITS_INTERNAL_VER)
-        mkrescue_script = os.path.join(self.workdir,
-                                       'grub-inst-x86_64-efi', 'bin',
-                                       'grub-mkrescue')
+        bits_dir = self.scratch_file('bits-%d' % self.BITS_INTERNAL_VER)
+        iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
+        mkrescue_script = self.scratch_file('grub-inst-x86_64-efi',
+                                            'bin',
+                                            'grub-mkrescue')
 
         self.assertTrue(os.access(mkrescue_script,
                                   os.R_OK | os.W_OK | os.X_OK))
@@ -250,17 +247,18 @@ def setUp(self): # pylint: disable=arguments-differ
         super().setUp()
         self.logger = self.log
 
-        prebuiltDir = os.path.join(self.workdir, 'prebuilt')
+        prebuiltDir = self.scratch_file('prebuilt')
         if not os.path.isdir(prebuiltDir):
             os.mkdir(prebuiltDir, mode=0o775)
 
-        bits_zip_file = os.path.join(prebuiltDir, 'bits-%d-%s.zip'
-                                     %(self.BITS_INTERNAL_VER,
-                                       self.BITS_COMMIT_HASH))
-        grub_tar_file = os.path.join(prebuiltDir,
-                                     'bits-%d-%s-grub.tar.gz'
-                                     %(self.BITS_INTERNAL_VER,
-                                       self.BITS_COMMIT_HASH))
+        bits_zip_file = self.scratch_file('prebuilt',
+                                          'bits-%d-%s.zip'
+                                          %(self.BITS_INTERNAL_VER,
+                                            self.BITS_COMMIT_HASH))
+        grub_tar_file = self.scratch_file('prebuilt',
+                                          'bits-%d-%s-grub.tar.gz'
+                                          %(self.BITS_INTERNAL_VER,
+                                            self.BITS_COMMIT_HASH))
 
         bitsLocalArtLoc = self.ASSET_BITS.fetch()
         self.logger.info("downloaded bits artifacts to %s", bitsLocalArtLoc)
@@ -284,7 +282,7 @@ def parse_log(self):
         """parse the log generated by running bits tests and
            check for failures.
         """
-        debugconf = os.path.join(self.workdir, self._debugcon_log)
+        debugconf = self.scratch_file(self._debugcon_log)
         log = ""
         with open(debugconf, 'r', encoding='utf-8') as filehandle:
             log = filehandle.read()
@@ -316,8 +314,7 @@ def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
         self.set_machine('pc')
-        iso_file = os.path.join(self.workdir,
-                                'bits-%d.iso' %self.BITS_INTERNAL_VER)
+        iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
 
diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/test_alpha_clipper.py
index c1fbf0e395..72cd7b57e6 100755
--- a/tests/functional/test_alpha_clipper.py
+++ b/tests/functional/test_alpha_clipper.py
@@ -5,8 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test.utils import gzip_uncompress
 
@@ -22,7 +20,7 @@ def test_alpha_clipper(self):
         self.set_machine('clipper')
         kernel_path = self.ASSET_KERNEL.fetch()
 
-        uncompressed_kernel = os.path.join(self.workdir, 'vmlinux')
+        uncompressed_kernel = self.scratch_file('vmlinux')
         gzip_uncompress(kernel_path, uncompressed_kernel)
 
         self.vm.set_console()
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/test_arm_aspeed_ast1030.py
index 380a76ec01..01b13c5591 100755
--- a/tests/functional/test_arm_aspeed_ast1030.py
+++ b/tests/functional/test_arm_aspeed_ast1030.py
@@ -6,8 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from zipfile import ZipFile
@@ -27,7 +25,7 @@ def test_ast1030_zephyros_1_04(self):
         kernel_name = "ast1030-evb-demo/zephyr.elf"
         with ZipFile(zip_file, 'r') as zf:
                      zf.extract(kernel_name, path=self.workdir)
-        kernel_file = os.path.join(self.workdir, kernel_name)
+        kernel_file = self.scratch_file(kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
@@ -49,7 +47,7 @@ def test_ast1030_zephyros_1_07(self):
         kernel_name = "ast1030-evb-demo/zephyr.bin"
         with ZipFile(zip_file, 'r') as zf:
                      zf.extract(kernel_name, path=self.workdir)
-        kernel_file = os.path.join(self.workdir, kernel_name)
+        kernel_file = self.scratch_file(kernel_name)
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_file, '-nographic')
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
index 79baf37537..8c5593cdc8 100755
--- a/tests/functional/test_arm_aspeed_ast2500.py
+++ b/tests/functional/test_arm_aspeed_ast2500.py
@@ -50,7 +50,7 @@ def test_arm_ast2500_evb_sdk(self):
         archive_extract(image_path, self.workdir)
 
         self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2500-default/image-bmc')
+            self.scratch_file("ast2500-default", "image-bmc"))
 
         self.wait_for_console_pattern('ast2500-default login:')
 
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
index 9c749f96b4..25948c1c34 100755
--- a/tests/functional/test_arm_aspeed_ast2600.py
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -114,7 +114,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.vm.add_args('-device',
             'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
         self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2600-a2/image-bmc')
+            self.scratch_file("ast2600-a2", "image-bmc"))
 
         self.wait_for_console_pattern('ast2600-a2 login:')
 
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
index 9095b08539..88ef7b1edc 100755
--- a/tests/functional/test_arm_bflt.py
+++ b/tests/functional/test_arm_bflt.py
@@ -6,7 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
 import bz2
 
 from qemu_test import QemuUserTest, Asset
@@ -25,7 +24,7 @@ class LoadBFLT(QemuUserTest):
     def test_stm32(self):
         # See https://elinux.org/STM32#User_Space
         rootfs_path_bz2 = self.ASSET_ROOTFS.fetch()
-        busybox_path = os.path.join(self.workdir, "bin/busybox")
+        busybox_path = self.scratch_file("bin", "busybox")
 
         with bz2.open(rootfs_path_bz2, 'rb') as cpio_handle:
             cpio_extract(cpio_handle, self.workdir)
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index fcd111f59d..2af6d9a18d 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -68,7 +68,7 @@ def test_arm_bpim2u_initrd(self):
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.vm.set_console()
@@ -106,7 +106,7 @@ def test_arm_bpim2u_gmac(self):
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
-        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
         image_pow2ceil_expand(rootfs_path)
 
@@ -150,7 +150,7 @@ def test_arm_bpim2u_openwrt_22_03_3(self):
         # This test download a 8.9 MiB compressed image and expand it
         # to 127 MiB.
         image_path_gz = self.ASSET_SD_IMAGE.fetch()
-        image_path = os.path.join(self.workdir, 'sdcard.img')
+        image_path = self.scratch_file('sdcard.img')
         gzip_uncompress(image_path_gz, image_path)
         image_pow2ceil_expand(image_path)
 
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
index 65f1228296..b4e3633422 100755
--- a/tests/functional/test_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -31,7 +31,8 @@ def test_arm_canona1100(self):
                         member="day18/barebox.canon-a1100.bin")
         self.vm.set_console()
         self.vm.add_args('-bios',
-                         self.workdir + '/day18/barebox.canon-a1100.bin')
+                         self.scratch_file('day18',
+                                           'barebox.canon-a1100.bin'))
         self.vm.launch()
         wait_for_console_pattern(self, 'running /env/bin/init')
 
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index fdbd52a33c..d81c333d0c 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -44,7 +44,7 @@ def test_arm_cubieboard_initrd(self):
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.vm.set_console()
@@ -78,7 +78,7 @@ def test_arm_cubieboard_sata(self):
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
         rootfs_path_gz = self.ASSET_SATA_ROOTFS.fetch()
-        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        rootfs_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(rootfs_path_gz, rootfs_path)
 
         self.vm.set_console()
@@ -112,7 +112,7 @@ def test_arm_cubieboard_openwrt_22_03_2(self):
         # to 126 MiB.
         self.set_machine('cubieboard')
         image_path_gz = self.ASSET_OPENWRT.fetch()
-        image_path = os.path.join(self.workdir, 'sdcard.img')
+        image_path = self.scratch_file('sdcard.img')
         gzip_uncompress(image_path_gz, image_path)
         image_pow2ceil_expand(image_path)
 
diff --git a/tests/functional/test_arm_emcraft_sf2.py b/tests/functional/test_arm_emcraft_sf2.py
index ada4dfd82e..f9f3f069e2 100755
--- a/tests/functional/test_arm_emcraft_sf2.py
+++ b/tests/functional/test_arm_emcraft_sf2.py
@@ -28,7 +28,7 @@ def test_arm_emcraft_sf2(self):
 
         uboot_path = self.ASSET_UBOOT.fetch()
         spi_path = self.ASSET_SPI.fetch()
-        spi_path_rw = os.path.join(self.workdir, 'spi.bin')
+        spi_path_rw = self.scratch_file('spi.bin')
         shutil.copy(spi_path, spi_path_rw)
         os.chmod(spi_path_rw, 0o600)
 
diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
index 54fa366ad4..a85b339d77 100755
--- a/tests/functional/test_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -12,7 +12,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
 import logging
 
 from qemu_test import QemuSystemTest, Asset
@@ -67,7 +66,7 @@ def test_framebuffer_tux_logo(self):
         import numpy as np
         import cv2
 
-        screendump_path = os.path.join(self.workdir, "screendump.pbm")
+        screendump_path = self.scratch_file("screendump.pbm")
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
 
         self.boot_integratorcp()
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index b113adfe61..bea67cfb6a 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -77,7 +77,7 @@ def test_arm_orangepi_initrd(self):
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.vm.set_console()
@@ -113,7 +113,7 @@ def test_arm_orangepi_sd(self):
         dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_path_xz = self.ASSET_ROOTFS.fetch()
-        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        rootfs_path = self.scratch_file('rootfs.cpio')
         lzma_uncompress(rootfs_path_xz, rootfs_path)
         image_pow2ceil_expand(rootfs_path)
 
@@ -156,7 +156,7 @@ def test_arm_orangepi_armbian(self):
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
         # As we expand it to 2 GiB we are safe.
         image_path_xz = self.ASSET_ARMBIAN.fetch()
-        image_path = os.path.join(self.workdir, 'armbian.img')
+        image_path = self.scratch_file('armbian.img')
         lzma_uncompress(image_path_xz, image_path)
         image_pow2ceil_expand(image_path)
 
@@ -197,7 +197,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
         uboot_path = self.extract_from_deb(deb_path, uboot_path)
         image_path_gz = self.ASSET_NETBSD.fetch()
-        image_path = os.path.join(self.workdir, 'armv7.img')
+        image_path = self.scratch_file('armv7.img')
         gzip_uncompress(image_path_gz, image_path)
         image_pow2ceil_expand(image_path)
         image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index 3bf079dc4d..075f6b3301 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -7,8 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.utils import gzip_uncompress
@@ -65,7 +63,7 @@ def test_arm_raspi2_initrd(self):
         kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
         dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.set_machine('raspi2b')
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
index b3b39b069d..c6c8f9a5f4 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -32,7 +32,7 @@ def test_arm_exynos4210_initrd(self):
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
         initrd_path_gz = self.ASSET_ROOTFS.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
index 6bd6290030..b1ac63ac36 100755
--- a/tests/functional/test_arm_vexpress.py
+++ b/tests/functional/test_arm_vexpress.py
@@ -18,8 +18,9 @@ def test_arm_vexpressa9(self):
         self.set_machine('vexpress-a9')
         file_path = self.ASSET_DAY16.fetch()
         archive_extract(file_path, self.workdir)
-        self.launch_kernel(self.workdir + '/day16/winter.zImage',
-                           dtb=self.workdir + '/day16/vexpress-v2p-ca9.dtb',
+        self.launch_kernel(self.scratch_file('day16', 'winter.zImage'),
+                           dtb=self.scratch_file('day16',
+                                                 'vexpress-v2p-ca9.dtb'),
                            wait_for='QEMU advent calendar')
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
index fb178fde1c..449248c3e8 100755
--- a/tests/functional/test_m68k_mcf5208evb.py
+++ b/tests/functional/test_m68k_mcf5208evb.py
@@ -19,7 +19,8 @@ def test_m68k_mcf5208evb(self):
         file_path = self.ASSET_DAY07.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day07/sanity-clause.elf')
+        self.vm.add_args('-kernel',
+                         self.scratch_file('day07', 'sanity-clause.elf'))
         self.vm.launch()
         self.wait_for_console_pattern('QEMU advent calendar')
 
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index 25a17d4794..ff773a7994 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
 import time
 
 from qemu_test import QemuSystemTest, Asset
@@ -39,7 +38,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
         self.set_machine('next-cube')
-        screenshot_path = os.path.join(self.workdir, "dump.ppm")
+        screenshot_path = self.scratch_file("dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         from PIL import Image
@@ -50,7 +49,7 @@ def test_bootrom_framebuffer_size(self):
     @skipIfMissingCommands('tesseract')
     def test_bootrom_framebuffer_ocr_with_tesseract(self):
         self.set_machine('next-cube')
-        screenshot_path = os.path.join(self.workdir, "dump.ppm")
+        screenshot_path = self.scratch_file("dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
         lines = tesseract_ocr(screenshot_path)
         text = '\n'.join(lines)
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index d452a0271c..61c4d6bbf8 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -25,7 +25,8 @@ def test_microblaze_s3adsp1800(self):
         file_path = self.ASSET_IMAGE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
+        self.vm.add_args('-kernel',
+                         self.scratch_file('day17', 'ballerina.bin'))
         self.vm.launch()
         wait_for_console_pattern(self, 'This architecture does not have '
                                        'kernel memory protection')
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index faa3927f2e..926c885f63 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -27,8 +27,9 @@ def test_microblazeel_s3adsp1800(self):
         file_path = self.ASSET_IMAGE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
-        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
+        tftproot = self.scratch_file('day13')
+        self.vm.add_args('-nic', f'user,tftp={tftproot}')
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
         time.sleep(0.1)
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 52283e2dbd..ea362cf335 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -68,7 +68,7 @@ def test_mips64el_malta(self):
     def test_mips64el_malta_5KEc_cpio(self):
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
         initrd_path_gz = self.ASSET_CPIO_R1.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.set_machine('malta')
@@ -117,10 +117,10 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         import numpy as np
         import cv2
 
-        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+        screendump_path = self.scratch_file('screendump.pbm')
 
         kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
-        kernel_path = self.workdir + "/vmlinux"
+        kernel_path = self.scratch_file("vmlinux")
         gzip_uncompress(kernel_path_gz, kernel_path)
 
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index a012081382..a6d80d0012 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -6,8 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.utils import gzip_uncompress
@@ -52,7 +50,7 @@ def test_mips_malta_cpio(self):
         kernel_path = self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-4.5.0-2-4kc-malta')
         initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        initrd_path = self.scratch_file('rootfs.cpio')
         gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.set_machine('malta')
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index b8dfddd856..77671e0081 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -9,8 +9,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
@@ -37,7 +35,7 @@ class MaltaMachineConsole(LinuxKernelTest):
         'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
 
     def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = os.path.join(self.workdir, 'kernel')
+        kernel_path = self.scratch_file('kernel')
         lzma_uncompress(kernel_path_xz, kernel_path)
 
         self.set_machine('malta')
@@ -78,7 +76,7 @@ def test_mipsel_malta_yamon(self):
         zip_path = self.ASSET_YAMON_ROM.fetch()
         with ZipFile(zip_path, 'r') as zf:
             zf.extract(yamon_bin, path=self.workdir)
-        yamon_path = os.path.join(self.workdir, yamon_bin)
+        yamon_path = self.scratch_file(yamon_bin)
 
         self.set_machine('malta')
         self.vm.set_console()
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
index 5b68b6b628..a5b2b5b1e5 100755
--- a/tests/functional/test_or1k_sim.py
+++ b/tests/functional/test_or1k_sim.py
@@ -19,7 +19,7 @@ def test_or1k_sim(self):
         file_path = self.ASSET_DAY20.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day20/vmlinux')
+        self.vm.add_args('-kernel', self.scratch_file('day20', 'vmlinux'))
         self.vm.launch()
         self.wait_for_console_pattern('QEMU advent calendar')
 
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index f1af92373e..bf4a6af9d4 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -18,7 +18,7 @@ def test_ppc64_e500(self):
         self.cpu = 'e5500'
         file_path = self.ASSET_DAY19.fetch()
         archive_extract(file_path, self.workdir)
-        self.launch_kernel(self.workdir + '/day19/uImage',
+        self.launch_kernel(self.scratch_file('day19', 'uImage'),
                            wait_for='QEMU advent calendar')
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 88f0f99f24..037dfdf87e 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -46,23 +46,15 @@ def extract_from_iso(self, iso, path):
         :param path: path within the iso file of the file to be extracted
         :returns: path of the extracted file
         """
-        filename = os.path.basename(path)
-
-        cwd = os.getcwd()
-        os.chdir(self.workdir)
+        filename = self.scratch_file(os.path.basename(path))
 
         cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
         subprocess.run(cmd.split(),
                        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
         os.chmod(filename, 0o600)
-        os.chdir(cwd)
 
-        # Return complete path to extracted file.  Because callers to
-        # extract_from_iso() specify 'path' with a leading slash, it is
-        # necessary to use os.path.relpath() as otherwise os.path.join()
-        # interprets it as an absolute path and drops the self.workdir part.
-        return os.path.normpath(os.path.join(self.workdir, filename))
+        return filename
 
     def setUp(self):
         super().setUp()
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
index f5faa0f0b3..9ed23a1f0f 100755
--- a/tests/functional/test_ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -29,13 +29,15 @@ def test_ppc_amigaone(self):
         zip_file = self.ASSET_IMAGE.fetch()
         with ZipFile(zip_file, 'r') as zf:
             zf.extractall(path=self.workdir)
-        bios_fh = open(self.workdir + "/u-boot-amigaone.bin", "wb")
-        subprocess.run(['tail', '-c', '524288',
-                        self.workdir + "/floppy_edition/updater.image"],
-                        stdout=bios_fh)
+        bios = self.scratch_file("u-boot-amigaone.bin")
+        with open(bios, "wb") as bios_fh:
+            subprocess.run(['tail', '-c', '524288',
+                            self.scratch_file("floppy_edition",
+                                              "updater.image")],
+                           stdout=bios_fh)
 
         self.vm.set_console()
-        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
+        self.vm.add_args('-bios', bios)
         self.vm.launch()
         wait_for_console_pattern(self, 'FLASH:')
 
diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
index e72cbdee12..1ae2f47bcc 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -28,10 +28,12 @@ def test_ppc_bamboo(self):
         file_path = self.ASSET_IMAGE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir +
-                                   '/system-image-powerpc-440fp/linux',
-                         '-initrd', self.workdir +
-                                   '/system-image-powerpc-440fp/rootfs.cpio.gz',
+        self.vm.add_args('-kernel',
+                         self.scratch_file('system-image-powerpc-440fp',
+                                           'linux'),
+                         '-initrd',
+                         self.scratch_file('system-image-powerpc-440fp',
+                                           'rootfs.cpio.gz'),
                          '-nic', 'user,model=rtl8139,restrict=on')
         self.vm.launch()
         wait_for_console_pattern(self, 'Type exit when done')
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
index 3f45e37a45..10812824bd 100755
--- a/tests/functional/test_ppc_mac.py
+++ b/tests/functional/test_ppc_mac.py
@@ -23,7 +23,7 @@ def do_day15_test(self):
         file_path = self.ASSET_DAY15.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.add_args('-M', 'graphics=off')
-        self.launch_kernel(self.workdir + '/day15/invaders.elf',
+        self.launch_kernel(self.scratch_file('day15', 'invaders.elf'),
                            wait_for='QEMU advent calendar')
 
     def test_ppc_g3beige(self):
diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/test_ppc_mpc8544ds.py
index 2b3f0894ae..87b5d4d12b 100755
--- a/tests/functional/test_ppc_mpc8544ds.py
+++ b/tests/functional/test_ppc_mpc8544ds.py
@@ -28,7 +28,7 @@ def test_ppc_mpc8544ds(self):
         file_path = self.ASSET_IMAGE.fetch()
         archive_extract(file_path, self.workdir, member='creek/creek.bin')
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/creek/creek.bin')
+        self.vm.add_args('-kernel', self.scratch_file('creek', 'creek.bin'))
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU advent calendar 2020',
                                  self.panic_message)
diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional/test_ppc_virtex_ml507.py
index ffa9a0633e..f297651e64 100755
--- a/tests/functional/test_ppc_virtex_ml507.py
+++ b/tests/functional/test_ppc_virtex_ml507.py
@@ -28,8 +28,9 @@ def test_ppc_virtex_ml507(self):
         file_path = self.ASSET_IMAGE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/hippo/hippo.linux',
-                         '-dtb', self.workdir + '/hippo/virtex440-ml507.dtb',
+        self.vm.add_args('-kernel', self.scratch_file('hippo', 'hippo.linux'),
+                         '-dtb', self.scratch_file('hippo',
+                                                   'virtex440-ml507.dtb'),
                          '-m', '512')
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU advent calendar 2020',
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index f7621d999d..b0adb38a45 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -10,8 +10,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
-
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern, skipFlakyTest
@@ -40,7 +38,7 @@ def test_uboot(self):
         self.set_machine('gdbsim-r5f562n8')
 
         uboot_path_gz = self.ASSET_UBOOT.fetch()
-        uboot_path = os.path.join(self.workdir, 'u-boot.bin')
+        uboot_path = self.scratch_file('u-boot.bin')
         gzip_uncompress(uboot_path_gz, uboot_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
index f7acd90a89..e5884a4dd0 100755
--- a/tests/functional/test_s390x_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -175,7 +175,7 @@ def test_s390x_fedora(self):
         kernel_path = self.ASSET_F31_KERNEL.fetch()
 
         initrd_path_xz = self.ASSET_F31_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
+        initrd_path = self.scratch_file('initrd-raw.img')
         lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
index c54c7a8177..82acff4e55 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -10,8 +10,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
-
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
@@ -89,7 +87,7 @@ def kernel_init(self):
         self.require_accelerator("kvm")
         kernel_path = self.ASSET_F35_KERNEL.fetch()
         initrd_path_xz = self.ASSET_F35_INITRD.fetch()
-        initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
+        initrd_path = self.scratch_file('initrd-raw.img')
         lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
index e2fcde2d6b..dca4601392 100755
--- a/tests/functional/test_sh4_r2d.py
+++ b/tests/functional/test_sh4_r2d.py
@@ -22,7 +22,8 @@ def test_r2d(self):
         file_path = self.ASSET_DAY09.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.add_args('-append', 'console=ttySC1')
-        self.launch_kernel(self.workdir + '/day09/zImage', console_index=1,
+        self.launch_kernel(self.scratch_file('day09', 'zImage'),
+                           console_index=1,
                            wait_for='QEMU advent calendar')
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
index cd46007942..b8dadabf3c 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -4,7 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
 import shutil
 
 from qemu_test import LinuxKernelTest, Asset
@@ -22,11 +21,12 @@ def test_sh4eb_r2d(self):
         file_path = self.ASSET_TGZ.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.add_args('-append', 'console=ttySC1 noiotrap')
-        self.launch_kernel(os.path.join(self.workdir, 'sh4eb/linux-kernel'),
-                           initrd=os.path.join(self.workdir, 'sh4eb/initramfs.cpio.gz'),
+        self.launch_kernel(self.scratch_file('sh4eb', 'linux-kernel'),
+                           initrd=self.scratch_file('sh4eb',
+                                                    'initramfs.cpio.gz'),
                            console_index=1, wait_for='Type exit when done')
         exec_command_and_wait_for_pattern(self, 'exit', 'Restarting system')
-        shutil.rmtree(os.path.join(self.workdir, 'sh4eb'))
+        shutil.rmtree(self.scratch_file('sh4eb'))
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
index 32e245f4ad..e7f6db0f24 100755
--- a/tests/functional/test_sparc64_sun4u.py
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -10,12 +10,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import os
-
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test.utils import archive_extract
 
+
 class Sun4uMachine(QemuSystemTest):
     """Boots the Linux kernel and checks that the console is operational"""
 
@@ -32,7 +31,7 @@ def test_sparc64_sun4u(self):
         kernel_name = 'day23/vmlinux'
         archive_extract(file_path, self.workdir, kernel_name)
         self.vm.set_console()
-        self.vm.add_args('-kernel', os.path.join(self.workdir, kernel_name),
+        self.vm.add_args('-kernel', self.scratch_file(kernel_name),
                          '-append', 'printk.time=0')
         self.vm.launch()
         wait_for_console_pattern(self, 'Starting logging: OK')
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
index 573f85222a..619c03d36a 100755
--- a/tests/functional/test_sparc_sun4m.py
+++ b/tests/functional/test_sparc_sun4m.py
@@ -18,7 +18,7 @@ def test_sparc_ss20(self):
         self.set_machine('SS-20')
         file_path = self.ASSET_DAY11.fetch()
         archive_extract(file_path, self.workdir)
-        self.launch_kernel(self.workdir + '/day11/zImage.elf',
+        self.launch_kernel(self.scratch_file('day11', 'zImage.elf'),
                            wait_for='QEMU advent calendar')
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
index d4ad92dc6c..5048e4c69e 100755
--- a/tests/functional/test_xtensa_lx60.py
+++ b/tests/functional/test_xtensa_lx60.py
@@ -19,7 +19,8 @@ def test_xtensa_lx60(self):
         self.cpu = 'dc233c'
         file_path = self.ASSET_DAY02.fetch()
         archive_extract(file_path, self.workdir)
-        self.launch_kernel(self.workdir + '/day02/santas-sleigh-ride.elf',
+        self.launch_kernel(self.scratch_file('day02',
+                                             'santas-sleigh-ride.elf'),
                            wait_for='QEMU advent calendar')
 
 if __name__ == '__main__':
-- 
2.47.1


