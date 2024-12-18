Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C68AE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwn-0006UE-A6; Wed, 18 Dec 2024 06:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwi-0006Sq-8V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwe-00058M-UC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSeGzZ3p8XKhO3ddLIcvBrnVtA4IxIIzvBx7nlYIjew=;
 b=eBL3Ll6VsS/dItitNZbQGCoJE6Sdh1JJJ8msKXxMutQSiAV8NOLeufyONSlnpoAFCGXrz7
 Wbo3YhwN+hQmQT6OhERRVC0k5tCrMPhQI+h4sLA+ZfQZZu8OHjPLe671yJuBdcIAzIpsJ7
 vay1jCyQtq0AFTa+sJ7M9/2fR8G/Wp8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-8XiVBx1aOw-0OBEWFx-tVA-1; Wed,
 18 Dec 2024 06:10:22 -0500
X-MC-Unique: 8XiVBx1aOw-0OBEWFx-tVA-1
X-Mimecast-MFC-AGG-ID: 8XiVBx1aOw-0OBEWFx-tVA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06EC619560A1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DF7819560AD; Wed, 18 Dec 2024 11:10:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 08/38] tests/functional: switch to new test skip decorators
Date: Wed, 18 Dec 2024 12:09:28 +0100
Message-ID: <20241218110958.226932-9-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

This ensures consistency of behaviour across all the tests, and requires
that we provide gitlab bug links when marking a test to be skipped due
to unreliability.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-9-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_acpi_bits.py           | 25 +++--------------
 tests/functional/test_arm_aspeed_ast2600.py  |  7 +++--
 tests/functional/test_arm_bflt.py            |  7 +++--
 tests/functional/test_arm_bpim2u.py          |  5 ++--
 tests/functional/test_arm_cubieboard.py      |  5 ++--
 tests/functional/test_arm_integratorcp.py    | 25 +++++------------
 tests/functional/test_arm_orangepi.py        |  8 +++---
 tests/functional/test_linux_initrd.py        |  7 +++--
 tests/functional/test_m68k_nextcube.py       | 15 +++--------
 tests/functional/test_mips64el_fuloong2e.py  |  4 +--
 tests/functional/test_mips64el_loongson3v.py |  8 +++---
 tests/functional/test_mips64el_malta.py      | 28 +++++++-------------
 tests/functional/test_ppc64_hv.py            | 18 +++----------
 tests/functional/test_ppc_40p.py             |  7 ++---
 tests/functional/test_rx_gdbsim.py           |  6 ++---
 tests/functional/test_sh4_r2d.py             |  8 +++---
 16 files changed, 61 insertions(+), 122 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 1e6d082ecb..8763ea0822 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -32,7 +32,6 @@
 """
 
 import os
-import platform
 import re
 import shutil
 import subprocess
@@ -46,28 +45,13 @@
     Sequence,
 )
 from qemu.machine import QEMUMachine
-from unittest import skipIf
-from qemu_test import QemuSystemTest, Asset, which
+from qemu_test import (QemuSystemTest, Asset, skipIfMissingCommands,
+                       skipIfNotMachine)
 
-deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
-supported_platforms = ['x86_64'] # supported test platforms.
 
 # default timeout of 120 secs is sometimes not enough for bits test.
 BITS_TIMEOUT = 200
 
-def missing_deps():
-    """ returns True if any of the test dependent tools are absent.
-    """
-    for dep in deps:
-        if which(dep) is None:
-            return True
-    return False
-
-def supported_platform():
-    """ checks if the test is running on a supported platform.
-    """
-    return platform.machine() in supported_platforms
-
 class QEMUBitsMachine(QEMUMachine): # pylint: disable=too-few-public-methods
     """
     A QEMU VM, with isa-debugcon enabled and bits iso passed
@@ -110,9 +94,8 @@ def base_args(self):
         """return the base argument to QEMU binary"""
         return self._base_args
 
-@skipIf(not supported_platform() or missing_deps(),
-        'unsupported platform or dependencies (%s) not installed' \
-        % ','.join(deps))
+@skipIfMissingCommands("xorriso", "mformat")
+@skipIfNotMachine("x86_64")
 class AcpiBitsTest(QemuSystemTest): #pylint: disable=too-many-instance-attributes
     """
     ACPI and SMBIOS tests using biosbits.
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
index 74d025e0fc..9c749f96b4 100755
--- a/tests/functional/test_arm_aspeed_ast2600.py
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -11,10 +11,9 @@
 
 from qemu_test import Asset
 from aspeed import AspeedTest
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import has_cmd
+from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
 from qemu_test.utils import archive_extract
-from unittest import skipUnless
+
 
 class AST2600Machine(AspeedTest):
 
@@ -68,7 +67,7 @@ def test_arm_ast2600_evb_buildroot(self):
          'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
         'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
 
-    @skipUnless(*has_cmd('swtpm'))
+    @skipIfMissingCommands('swtpm')
     def test_arm_ast2600_evb_buildroot_tpm(self):
         self.set_machine('ast2600-evb')
 
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
index 281925d11a..9095b08539 100755
--- a/tests/functional/test_arm_bflt.py
+++ b/tests/functional/test_arm_bflt.py
@@ -10,9 +10,8 @@
 import bz2
 
 from qemu_test import QemuUserTest, Asset
-from qemu_test import has_cmd
+from qemu_test import skipIfMissingCommands, skipUntrustedTest
 from qemu_test.utils import cpio_extract
-from unittest import skipUnless
 
 
 class LoadBFLT(QemuUserTest):
@@ -21,8 +20,8 @@ class LoadBFLT(QemuUserTest):
         ('https://elinux.org/images/5/51/Stm32_mini_rootfs.cpio.bz2'),
          'eefb788e4980c9e8d6c9d60ce7d15d4da6bf4fbc6a80f487673824600d5ba9cc')
 
-    @skipUnless(*has_cmd('cpio'))
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipIfMissingCommands('cpio')
+    @skipUntrustedTest()
     def test_stm32(self):
         # See https://elinux.org/STM32#User_Space
         rootfs_path_bz2 = self.ASSET_ROOTFS.fetch()
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index c9cf43c147..fcd111f59d 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -9,9 +9,10 @@
 
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
+from qemu_test import skipBigDataTest
 from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
-from unittest import skipUnless
+
 
 class BananaPiMachine(LinuxKernelTest):
 
@@ -143,7 +144,7 @@ def test_arm_bpim2u_gmac(self):
         os.remove(dtb_path)
         os.remove(rootfs_path)
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipBigDataTest()
     def test_arm_bpim2u_openwrt_22_03_3(self):
         self.set_machine('bpim2u')
         # This test download a 8.9 MiB compressed image and expand it
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index 9e42b72060..fdbd52a33c 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -8,8 +8,9 @@
 
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import skipBigDataTest
 from qemu_test.utils import gzip_uncompress, image_pow2ceil_expand
-from unittest import skipUnless
+
 
 class CubieboardMachine(LinuxKernelTest):
 
@@ -105,7 +106,7 @@ def test_arm_cubieboard_sata(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipBigDataTest()
     def test_arm_cubieboard_openwrt_22_03_2(self):
         # This test download a 7.5 MiB compressed image and expand it
         # to 126 MiB.
diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
index 0fe083f661..54fa366ad4 100755
--- a/tests/functional/test_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -17,20 +17,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from unittest import skipUnless
-
-
-NUMPY_AVAILABLE = True
-try:
-    import numpy as np
-except ImportError:
-    NUMPY_AVAILABLE = False
-
-CV2_AVAILABLE = True
-try:
-    import cv2
-except ImportError:
-    CV2_AVAILABLE = False
+from qemu_test import skipIfMissingImports, skipUntrustedTest
 
 
 class IntegratorMachine(QemuSystemTest):
@@ -63,7 +50,7 @@ def boot_integratorcp(self):
                          '-append', 'printk.time=0 console=ttyAMA0')
         self.vm.launch()
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     def test_integratorcp_console(self):
         """
         Boots the Linux kernel and checks that the console is operational
@@ -71,13 +58,15 @@ def test_integratorcp_console(self):
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
 
-    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipIfMissingImports("numpy", "cv2")
+    @skipUntrustedTest()
     def test_framebuffer_tux_logo(self):
         """
         Boot Linux and verify the Tux logo is displayed on the framebuffer.
         """
+        import numpy as np
+        import cv2
+
         screendump_path = os.path.join(self.workdir, "screendump.pbm")
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
 
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index a872305e93..b113adfe61 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -10,10 +10,10 @@
 
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, skipBigDataTest
 from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
-from unittest import skipUnless
+
 
 class BananaPiMachine(LinuxKernelTest):
 
@@ -149,7 +149,7 @@ def test_arm_orangepi_sd(self):
         os.remove(dtb_path)
         os.remove(rootfs_path)
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipBigDataTest()
     def test_arm_orangepi_armbian(self):
         self.set_machine('orangepi-pc')
         # This test download a 275 MiB compressed image and expand it
@@ -185,7 +185,7 @@ def test_arm_orangepi_armbian(self):
                                       'to <orangepipc>')
         self.wait_for_console_pattern('Starting Load Kernel Modules...')
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipBigDataTest()
     def test_arm_orangepi_uboot_netbsd9(self):
         self.set_machine('orangepi-pc')
         # This test download a 304MB compressed image and expand it to 2GB
diff --git a/tests/functional/test_linux_initrd.py b/tests/functional/test_linux_initrd.py
index c71a59d4c9..2207f83fbf 100755
--- a/tests/functional/test_linux_initrd.py
+++ b/tests/functional/test_linux_initrd.py
@@ -10,12 +10,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
 import logging
 import tempfile
 
-from qemu_test import QemuSystemTest, Asset
-from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset, skipFlakyTest
 
 
 class LinuxInitrd(QemuSystemTest):
@@ -60,7 +58,8 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
                 max_size + 1)
             self.assertRegex(self.vm.get_log(), expected_msg)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    # XXX file tracking bug
+    @skipFlakyTest(bug_url=None)
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
         QEMU has supported up to 4 GiB initrd for recent kernel
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index e6e8d4fd3f..25a17d4794 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -11,17 +11,9 @@
 import time
 
 from qemu_test import QemuSystemTest, Asset
-from unittest import skipUnless
-
-from qemu_test import has_cmd
+from qemu_test import skipIfMissingImports, skipIfMissingCommands
 from qemu_test.tesseract import tesseract_ocr
 
-PIL_AVAILABLE = True
-try:
-    from PIL import Image
-except ImportError:
-    PIL_AVAILABLE = False
-
 
 class NextCubeMachine(QemuSystemTest):
 
@@ -44,17 +36,18 @@ def check_bootrom_framebuffer(self, screenshot_path):
         self.vm.cmd('human-monitor-command',
                     command_line='screendump %s' % screenshot_path)
 
-    @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
+    @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
         self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
+        from PIL import Image
         width, height = Image.open(screenshot_path).size
         self.assertEqual(width, 1120)
         self.assertEqual(height, 832)
 
-    @skipUnless(*has_cmd('tesseract'))
+    @skipIfMissingCommands('tesseract')
     def test_bootrom_framebuffer_ocr_with_tesseract(self):
         self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
index a32d5f9d08..531d16d8f6 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -13,7 +13,7 @@
 import subprocess
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, skipUntrustedTest
 from unittest import skipUnless
 
 class MipsFuloong2e(LinuxKernelTest):
@@ -39,7 +39,7 @@ def test_linux_kernel_3_16(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
     def test_linux_kernel_2_6_27_isa_serial(self):
         # Recovery system for the Yeeloong laptop
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/test_mips64el_loongson3v.py
index e57ec5499e..f85371e50c 100755
--- a/tests/functional/test_mips64el_loongson3v.py
+++ b/tests/functional/test_mips64el_loongson3v.py
@@ -9,11 +9,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
-from unittest import skipUnless
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, skipUntrustedTest
+
 
 class MipsLoongson3v(QemuSystemTest):
     timeout = 60
@@ -23,7 +21,7 @@ class MipsLoongson3v(QemuSystemTest):
          'releases/download/20210112/pmon-3avirt.bin'),
         'fcdf6bb2cb7885a4a62f31fcb0d5e368bac7b6cea28f40c6dfa678af22fea20a')
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     def test_pmon_serial_console(self):
         self.set_machine('loongson3-virt')
 
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 6d1195d362..52283e2dbd 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -14,20 +14,8 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
 from qemu_test.utils import gzip_uncompress
-from unittest import skipUnless
-
-NUMPY_AVAILABLE = True
-try:
-    import numpy as np
-except ImportError:
-    NUMPY_AVAILABLE = False
-
-CV2_AVAILABLE = True
-try:
-    import cv2
-except ImportError:
-    CV2_AVAILABLE = False
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -76,7 +64,7 @@ def test_mips64el_malta(self):
          'rootfs.mipsel64r1.cpio.gz'),
         '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     def test_mips64el_malta_5KEc_cpio(self):
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
         initrd_path_gz = self.ASSET_CPIO_R1.fetch()
@@ -106,8 +94,7 @@ def test_mips64el_malta_5KEc_cpio(self):
         self.vm.wait()
 
 
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+@skipIfMissingImports('numpy', 'cv2')
 class MaltaMachineFramebuffer(LinuxKernelTest):
 
     timeout = 30
@@ -126,6 +113,10 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         """
         Boot Linux kernel and check Tux logo is displayed on the framebuffer.
         """
+
+        import numpy as np
+        import cv2
+
         screendump_path = os.path.join(self.workdir, 'screendump.pbm')
 
         kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
@@ -171,11 +162,12 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
     def test_mips_malta_i6400_framebuffer_logo_1core(self):
         self.do_test_i6400_framebuffer_logo(1)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    # XXX file tracking bug
+    @skipFlakyTest(bug_url=None)
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         self.do_test_i6400_framebuffer_logo(7)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    @skipFlakyTest(bug_url=None)
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 7c6f8234f5..88f0f99f24 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -9,24 +9,14 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from unittest import skipIf, skipUnless
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern, exec_command, which
+from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import skipIfMissingCommands, skipBigDataTest
 import os
 import time
 import subprocess
 from datetime import datetime
 
-deps = ["xorriso"] # dependent tools needed in the test setup/box.
-
-def missing_deps():
-    """ returns True if any of the test dependent tools are absent.
-    """
-    for dep in deps:
-        if which(dep) is None:
-            return True
-    return False
-
 # Alpine is a light weight distro that supports QEMU. These tests boot
 # that on the machine then run a QEMU guest inside it in KVM mode,
 # that runs the same Alpine distro image.
@@ -34,8 +24,8 @@ def missing_deps():
 # large download, but it may be more polite to create qcow2 image with
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
-@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
+@skipIfMissingCommands("xorriso")
+@skipBigDataTest()
 class HypervisorTest(QemuSystemTest):
 
     timeout = 1000
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index 67bcdae53a..7a74e0cca7 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -7,11 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import os
-
-from unittest import skipUnless
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, skipUntrustedTest
 
 
 class IbmPrep40pMachine(QemuSystemTest):
@@ -37,7 +34,7 @@ class IbmPrep40pMachine(QemuSystemTest):
     # All rights reserved.
     # U.S. Government Users Restricted Rights - Use, duplication or disclosure
     # restricted by GSA ADP Schedule Contract with IBM Corp.
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     def test_factory_firmware_and_netbsd(self):
         self.set_machine('40p')
         self.require_accelerator("tcg")
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index 5687f756bb..f7621d999d 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -12,10 +12,9 @@
 
 import os
 
-from unittest import skipUnless
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, skipFlakyTest
 from qemu_test.utils import gzip_uncompress
 
 
@@ -52,9 +51,10 @@ def test_uboot(self):
         wait_for_console_pattern(self, uboot_version)
         gcc_version = 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (experimental)'
         # FIXME limit baudrate on chardev, else we type too fast
+        #  https://gitlab.com/qemu-project/qemu/-/issues/2691
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    @skipFlakyTest(bug_url="https://gitlab.com/qemu-project/qemu/-/issues/2691")
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
index c3cfff79ad..e2fcde2d6b 100755
--- a/tests/functional/test_sh4_r2d.py
+++ b/tests/functional/test_sh4_r2d.py
@@ -4,11 +4,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
-from qemu_test import LinuxKernelTest, Asset
+from qemu_test import LinuxKernelTest, Asset, skipFlakyTest
 from qemu_test.utils import archive_extract
-from unittest import skipUnless
 
 class R2dTest(LinuxKernelTest):
 
@@ -18,7 +15,8 @@ class R2dTest(LinuxKernelTest):
 
     # This test has a 6-10% failure rate on various hosts that look
     # like issues with a buggy kernel.
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
+    # XXX file tracking bug
+    @skipFlakyTest(bug_url=None)
     def test_r2d(self):
         self.set_machine('r2d')
         file_path = self.ASSET_DAY09.fetch()
-- 
2.47.1


