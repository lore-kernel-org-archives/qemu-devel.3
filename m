Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8ECE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbi-0007t8-QL; Wed, 11 Dec 2024 04:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbH-0006Tm-9G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbF-0007vZ-9y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLvuMSXmynoXQiMUAJGztH8z6INfuc/5JWCSnxgyz7I=;
 b=iN2K2Ys/IC5uWz5bCVRzsfHRXCq8dVB9lFXr7oteXMp1PUUa/B9mVPA1e4UMJbCfAZwJLP
 +yRoAGPwlhEmXOVGX7uy8hl0chOnzLvBzTADlJbjlFP64tYS18BMrN73Pzu/sf4wNf6mHG
 xflnUEjqDj5x7TzupnTBzJ18bcT9MIA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-2LmzP-WvMFWeN-Qhq9v4pg-1; Wed,
 11 Dec 2024 04:01:35 -0500
X-MC-Unique: 2LmzP-WvMFWeN-Qhq9v4pg-1
X-Mimecast-MFC-AGG-ID: 2LmzP-WvMFWeN-Qhq9v4pg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE071955DC8; Wed, 11 Dec 2024 09:01:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09AC41956089; Wed, 11 Dec 2024 09:01:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 22/26] tests/functional: Convert the emcraft_sf2 avocado test
Date: Wed, 11 Dec 2024 10:00:06 +0100
Message-ID: <20241211090014.619351-23-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

A pretty straight-forward conversion of the emcraft_sf2 boot
test to the functional framework.

This was the last test that used file_truncate() in
boot_linux_console.py, so we can remove that function from that
file now, too.

Message-ID: <20241206102358.1186644-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                              |  1 +
 tests/avocado/boot_linux_console.py      | 44 --------------------
 tests/functional/meson.build             |  1 +
 tests/functional/test_arm_emcraft_sf2.py | 52 ++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 44 deletions(-)
 create mode 100755 tests/functional/test_arm_emcraft_sf2.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 86cac83221..435a87b146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-som.c
 F: docs/system/arm/emcraft-sf2.rst
+F: tests/functional/test_arm_emcraft_sf2.py
 
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 44ee50c469..5d5795e41b 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -30,11 +30,6 @@
 def pow2ceil(x):
     return 1 if x == 0 else 2**(x - 1).bit_length()
 
-def file_truncate(path, size):
-    if size != os.path.getsize(path):
-        with open(path, 'ab+') as fd:
-            fd.truncate(size)
-
 """
 Expand file size to next power of 2
 """
@@ -137,45 +132,6 @@ def test_arm_virt(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_arm_emcraft_sf2(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:emcraft-sf2
-        :avocado: tags=endian:little
-        :avocado: tags=u-boot
-        :avocado: tags=accel:tcg
-        """
-        self.require_netdev('user')
-
-        uboot_url = ('https://raw.githubusercontent.com/'
-                     'Subbaraya-Sundeep/qemu-test-binaries/'
-                     'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot')
-        uboot_hash = 'cbb8cbab970f594bf6523b9855be209c08374ae2'
-        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
-        spi_url = ('https://raw.githubusercontent.com/'
-                   'Subbaraya-Sundeep/qemu-test-binaries/'
-                   'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
-        spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
-        spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
-        spi_path_rw = os.path.join(self.workdir, os.path.basename(spi_path))
-        shutil.copy(spi_path, spi_path_rw)
-
-        file_truncate(spi_path_rw, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
-        self.vm.add_args('-kernel', uboot_path,
-                         '-append', kernel_command_line,
-                         '-drive', 'file=' + spi_path_rw + ',if=mtd,format=raw',
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Enter \'help\' for a list')
-
-        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 10.0.2.15',
-                                                 'eth0: link becomes ready')
-        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
-            '3 packets transmitted, 3 packets received, 0% packet loss')
-
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 6e22d8f4f0..af38494e14 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -71,6 +71,7 @@ tests_arm_system_thorough = [
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
+  'arm_emcraft_sf2',
   'arm_integratorcp',
   'arm_orangepi',
   'arm_raspi2',
diff --git a/tests/functional/test_arm_emcraft_sf2.py b/tests/functional/test_arm_emcraft_sf2.py
new file mode 100755
index 0000000000..ada4dfd82e
--- /dev/null
+++ b/tests/functional/test_arm_emcraft_sf2.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test.utils import file_truncate
+
+class EmcraftSf2Machine(LinuxKernelTest):
+
+    ASSET_UBOOT = Asset(
+        ('https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binaries/'
+         'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot'),
+        '5c6a15103375db11b21f2236473679a9dbbed6d89652bfcdd501c263d68ab725')
+
+    ASSET_SPI = Asset(
+        ('https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binaries/'
+         'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin'),
+        'cd9bdd2c4cb55a59c3adb6bcf74881667c4500dde0570a43aa3be2b17eecfdb6')
+
+    def test_arm_emcraft_sf2(self):
+        self.set_machine('emcraft-sf2')
+        self.require_netdev('user')
+
+        uboot_path = self.ASSET_UBOOT.fetch()
+        spi_path = self.ASSET_SPI.fetch()
+        spi_path_rw = os.path.join(self.workdir, 'spi.bin')
+        shutil.copy(spi_path, spi_path_rw)
+        os.chmod(spi_path_rw, 0o600)
+
+        file_truncate(spi_path_rw, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-kernel', uboot_path,
+                         '-append', kernel_command_line,
+                         '-drive', 'file=' + spi_path_rw + ',if=mtd,format=raw',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Enter \'help\' for a list')
+
+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 10.0.2.15',
+                                                 'eth0: link becomes ready')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


