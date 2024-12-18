Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE1BE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxZ-0007cO-UE; Wed, 18 Dec 2024 06:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxY-0007Yp-Bx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxP-0005tP-ES
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t+YxAvPWyQ8vncS6ajWns4Lr5w/SOnvw5S9MYfix3o=;
 b=SZ1QaJdXirEsjqk+TYSp8ZTlgsOz+H58Ez4hTuWthRjUKoaehMr0YkwFMMMZnLHayjjsmS
 FkvceTPU6ckfB11B4z6UnFSdbEXnXqVJoX/+jAcBTbchBYy6bKofTl5kKUV3NxmDN3CmMn
 4J6fTYNUVRyt7lPiRJNtGsiasMoNclw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-uO0QP49QP0C3O0YRXmXzjQ-1; Wed,
 18 Dec 2024 06:11:09 -0500
X-MC-Unique: uO0QP49QP0C3O0YRXmXzjQ-1
X-Mimecast-MFC-AGG-ID: uO0QP49QP0C3O0YRXmXzjQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E07F19560AF
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BE9119560AD; Wed, 18 Dec 2024 11:11:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 26/38] tests/functional: convert tests to new uncompress helper
Date: Wed, 18 Dec 2024 12:09:46 +0100
Message-ID: <20241218110958.226932-27-thuth@redhat.com>
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

Replace use of lzma_uncompress and gzip_uncompress with the
new uncompress helper.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-27-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_raspi4.py   |  5 +----
 tests/functional/test_aarch64_sbsaref.py  | 10 +++-------
 tests/functional/test_alpha_clipper.py    |  4 +---
 tests/functional/test_arm_bpim2u.py       | 13 +++----------
 tests/functional/test_arm_cubieboard.py   | 14 ++++----------
 tests/functional/test_arm_orangepi.py     | 17 ++++-------------
 tests/functional/test_arm_raspi2.py       |  5 +----
 tests/functional/test_arm_smdkc210.py     |  6 ++----
 tests/functional/test_mips64el_malta.py   |  9 ++-------
 tests/functional/test_mips_malta.py       |  5 +----
 tests/functional/test_mipsel_malta.py     | 15 +++++----------
 tests/functional/test_rx_gdbsim.py        |  5 +----
 tests/functional/test_s390x_ccw_virtio.py |  6 ++----
 tests/functional/test_s390x_topology.py   |  5 +----
 14 files changed, 31 insertions(+), 88 deletions(-)

diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index 3918e35e82..7a4302b0c5 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -7,7 +7,6 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import gzip_uncompress
 
 
 class Aarch64Raspi4Machine(LinuxKernelTest):
@@ -63,9 +62,7 @@ def test_arm_raspi4_initrd(self):
                                            member='boot/kernel8.img')
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='boot/bcm2711-rpi-4-b.dtb')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('raspi4b')
         self.vm.set_console()
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 533ca64407..2d756efdab 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -11,7 +11,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test.utils import lzma_uncompress
+
 
 def fetch_firmware(test):
     """
@@ -29,14 +29,10 @@ def fetch_firmware(test):
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
index 91c56b0930..12cd359746 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -10,7 +10,6 @@
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
 from qemu_test import skipBigDataTest
-from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
 
 
@@ -65,9 +64,7 @@ def test_arm_bpim2u_initrd(self):
         dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -103,9 +100,7 @@ def test_arm_bpim2u_gmac(self):
         dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
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
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index 32db303253..423db710e8 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -9,7 +9,7 @@
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import skipBigDataTest
-from qemu_test.utils import gzip_uncompress, image_pow2ceil_expand
+from qemu_test.utils import image_pow2ceil_expand
 
 
 class CubieboardMachine(LinuxKernelTest):
@@ -43,9 +43,7 @@ def test_arm_cubieboard_initrd(self):
         dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
                     'sun4i-a10-cubieboard.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -77,9 +75,7 @@ def test_arm_cubieboard_sata(self):
                     'sun4i-a10-cubieboard.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
-        rootfs_path_gz = self.ASSET_SATA_ROOTFS.fetch()
-        rootfs_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(rootfs_path_gz, rootfs_path)
+        rootfs_path = self.uncompress(self.ASSET_SATA_ROOTFS)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -111,9 +107,7 @@ def test_arm_cubieboard_openwrt_22_03_2(self):
         # This test download a 7.5 MiB compressed image and expand it
         # to 126 MiB.
         self.set_machine('cubieboard')
-        image_path_gz = self.ASSET_OPENWRT.fetch()
-        image_path = self.scratch_file('sdcard.img')
-        gzip_uncompress(image_path_gz, image_path)
+        image_path = self.uncompress(self.ASSET_OPENWRT)
         image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index aa2d9d19a4..18ee50216b 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -11,7 +11,6 @@
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern, skipBigDataTest
-from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
 
 
@@ -76,9 +75,7 @@ def test_arm_orangepi_initrd(self):
         dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
                     'sun8i-h3-orangepi-pc.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -112,9 +109,7 @@ def test_arm_orangepi_sd(self):
         dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
                     'sun8i-h3-orangepi-pc.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
-        rootfs_path_xz = self.ASSET_ROOTFS.fetch()
-        rootfs_path = self.scratch_file('rootfs.cpio')
-        lzma_uncompress(rootfs_path_xz, rootfs_path)
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
         image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
@@ -155,9 +150,7 @@ def test_arm_orangepi_armbian(self):
         # This test download a 275 MiB compressed image and expand it
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
         # As we expand it to 2 GiB we are safe.
-        image_path_xz = self.ASSET_ARMBIAN.fetch()
-        image_path = self.scratch_file('armbian.img')
-        lzma_uncompress(image_path_xz, image_path)
+        image_path = self.uncompress(self.ASSET_ARMBIAN)
         image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
@@ -195,9 +188,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # before to boot NetBSD.
         uboot_path = 'usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
         uboot_path = self.archive_extract(self.ASSET_UBOOT, member=uboot_path)
-        image_path_gz = self.ASSET_NETBSD.fetch()
-        image_path = self.scratch_file('armv7.img')
-        gzip_uncompress(image_path_gz, image_path)
+        image_path = self.uncompress(self.ASSET_NETBSD)
         image_pow2ceil_expand(image_path)
         image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index 5e38d1a937..d3c7aaa39b 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -9,7 +9,6 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test.utils import gzip_uncompress
 
 
 class ArmRaspi2Machine(LinuxKernelTest):
@@ -64,9 +63,7 @@ def test_arm_raspi2_initrd(self):
                                            member='boot/kernel7.img')
         dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                         member='boot/bcm2709-rpi-2-b.dtb')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('raspi2b')
         self.vm.set_console()
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
index f4e86f7e2b..0fda45c63a 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -7,7 +7,7 @@
 import os
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import gzip_uncompress
+
 
 class Smdkc210Machine(LinuxKernelTest):
 
@@ -30,9 +30,7 @@ def test_arm_exynos4210_initrd(self):
         dtb_path = 'usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
-        initrd_path_gz = self.ASSET_ROOTFS.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_ROOTFS)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 39fafb8bf1..a8da15a26b 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -15,7 +15,6 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
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
index 6ab6c0832a..3b15038d89 100755
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
             member='boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_path_gz = self.ASSET_INITRD.fetch()
-        initrd_path = self.scratch_file('rootfs.cpio')
-        gzip_uncompress(initrd_path_gz, initrd_path)
+        initrd_path = self.uncompress(self.ASSET_INITRD)
 
         self.set_machine('malta')
         self.vm.set_console()
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index 1f44881c78..fe9c3a172e 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -12,7 +12,6 @@
 from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import lzma_uncompress
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -33,9 +32,8 @@ class MaltaMachineConsole(LinuxKernelTest):
          'generic_nano32r6el_page64k_dbg.xz'),
         'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
 
-    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = self.scratch_file('kernel')
-        lzma_uncompress(kernel_path_xz, kernel_path)
+    def do_test_mips_malta32el_nanomips(self, kernel):
+        kernel_path = self.uncompress(kernel)
 
         self.set_machine('malta')
         self.vm.set_console()
@@ -51,16 +49,13 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
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
index b0adb38a45..20623aa51c 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -13,7 +13,6 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern, skipFlakyTest
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
index e5884a4dd0..453711aa0f 100755
--- a/tests/functional/test_s390x_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -17,7 +17,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
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
index 82acff4e55..eefd9729cb 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -14,7 +14,6 @@
 from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import lzma_uncompress
 
 
 class S390CPUTopology(QemuSystemTest):
@@ -86,9 +85,7 @@ def kernel_init(self):
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
2.47.1


