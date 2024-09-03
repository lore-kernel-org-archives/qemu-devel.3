Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CFDCD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 05:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slLrO-0007MY-I3; Tue, 03 Sep 2024 01:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slLrN-0007M1-1e
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 01:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slLrK-0005K0-QY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 01:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725340420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4lvrbhW6l3S8CRXACEVOg8ySqpQMRl+NcveP0sohw4=;
 b=TUUWUF7NnHfU96nvO4KqjMVp1+eT9asIpcodWFEWYqJmaGRYXb5ZtH8Ni3LoKpb5FqKifO
 Dv6iuVVs8zEjVtCYVbMZU7JHeEu1AykaPl4tvVu66ITTYgVhJ0AsJ40v+GxQlqcGPeYHpH
 L9PTY2bBv8JcfIZXyEOTf9HP4VnZ9Us=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-w7svKeDvOYqHMY3CN8CXgw-1; Tue,
 03 Sep 2024 01:13:38 -0400
X-MC-Unique: w7svKeDvOYqHMY3CN8CXgw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD4A6195608A; Tue,  3 Sep 2024 05:13:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 908D61956048; Tue,  3 Sep 2024 05:13:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] tests/functional: Convert the multiprocess avocado test into
 a standalone test
Date: Tue,  3 Sep 2024 07:13:33 +0200
Message-ID: <20240903051333.102494-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This test handles both, aarch64 and x86_64, with the same test code
(apart from some initial setup), so don't split this file by target
but add a check for self.arch in the main test function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based-on: 20240830133841.142644-1-thuth@redhat.com

 tests/avocado/avocado_qemu/__init__.py        | 10 ---
 tests/functional/meson.build                  |  2 +
 .../test_multiprocess.py}                     | 90 +++++++++----------
 3 files changed, 46 insertions(+), 56 deletions(-)
 rename tests/{avocado/multiprocess.py => functional/test_multiprocess.py} (48%)
 mode change 100644 => 100755

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 0e4ecea7a0..93c3460242 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -307,16 +307,6 @@ def require_netdev(self, netdevname):
         if netdevhelp.find('\n' + netdevname + '\n') < 0:
             self.cancel('no support for user networking')
 
-    def require_multiprocess(self):
-        """
-        Test for the presence of the x-pci-proxy-dev which is required
-        to support multiprocess.
-        """
-        devhelp = run_cmd([self.qemu_bin,
-                           '-M', 'none', '-device', 'help'])[0];
-        if devhelp.find('x-pci-proxy-dev') < 0:
-            self.cancel('no support for multiprocess device emulation')
-
     def _new_vm(self, name, *args):
         self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
         vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 6b00d240dd..34c6b3d4c0 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -37,6 +37,7 @@ tests_generic_bsduser = [
 tests_aarch64_system_thorough = [
   'aarch64_sbsaref',
   'aarch64_virt',
+  'multiprocess',
 ]
 
 tests_arm_system_thorough = [
@@ -129,6 +130,7 @@ tests_x86_64_system_quick = [
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'linux_initrd',
+  'multiprocess',
   'netdev_ethtool',
   'virtio_gpu',
 ]
diff --git a/tests/avocado/multiprocess.py b/tests/functional/test_multiprocess.py
old mode 100644
new mode 100755
similarity index 48%
rename from tests/avocado/multiprocess.py
rename to tests/functional/test_multiprocess.py
index ee7490ae08..a5dc1b12a3
--- a/tests/avocado/multiprocess.py
+++ b/tests/functional/test_multiprocess.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test for multiprocess qemu
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
@@ -7,22 +9,38 @@
 import os
 import socket
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
 
 class Multiprocess(QemuSystemTest):
-    """
-    :avocado: tags=multiprocess
-    """
+
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    def do_test(self, kernel_url, kernel_hash, initrd_url, initrd_hash,
+    ASSET_KERNEL_X86 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+         '/releases/31/Everything/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD_X86 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+         '/releases/31/Everything/x86_64/os/images/pxeboot/initrd.img'),
+        '3b6cb5c91a14c42e2f61520f1689264d865e772a1f0069e660a800d31dd61fb9')
+
+    ASSET_KERNEL_AARCH64 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+         '/releases/31/Everything/aarch64/os/images/pxeboot/vmlinuz'),
+        '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
+
+    ASSET_INITRD_AARCH64 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+         '/releases/31/Everything/aarch64/os/images/pxeboot/initrd.img'),
+        '9fd230cab10b1dafea41cf00150e6669d37051fad133bd618d2130284e16d526')
+
+    def do_test(self, kernel_asset, initrd_asset,
                 kernel_command_line, machine_type):
         """Main test method"""
         self.require_accelerator('kvm')
-        self.require_multiprocess()
+        self.require_device('x-pci-proxy-dev')
 
         # Create socketpair to connect proxy and remote processes
         proxy_sock, remote_sock = socket.socketpair(socket.AF_UNIX,
@@ -30,8 +48,8 @@ def do_test(self, kernel_url, kernel_hash, initrd_url, initrd_hash,
         os.set_inheritable(proxy_sock.fileno(), True)
         os.set_inheritable(remote_sock.fileno(), True)
 
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        kernel_path = kernel_asset.fetch()
+        initrd_path = initrd_asset.fetch()
 
         # Create remote process
         remote_vm = self.get_vm()
@@ -65,38 +83,18 @@ def do_test(self, kernel_url, kernel_hash, initrd_url, initrd_hash,
                                           'cat /sys/bus/pci/devices/*/uevent',
                                           'PCI_ID=1000:0012')
 
-    def test_multiprocess_x86_64(self):
-        """
-        :avocado: tags=arch:x86_64
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/31/Everything/x86_64/os/images'
-                      '/pxeboot/vmlinuz')
-        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
-        initrd_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/31/Everything/x86_64/os/images'
-                      '/pxeboot/initrd.img')
-        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 rdinit=/bin/bash')
-        machine_type = 'pc'
-        self.do_test(kernel_url, kernel_hash, initrd_url, initrd_hash,
-                     kernel_command_line, machine_type)
-
-    def test_multiprocess_aarch64(self):
-        """
-        :avocado: tags=arch:aarch64
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/31/Everything/aarch64/os/images'
-                      '/pxeboot/vmlinuz')
-        kernel_hash = '3505f2751e2833c681de78cee8dda1e49cabd2e8'
-        initrd_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/31/Everything/aarch64/os/images'
-                      '/pxeboot/initrd.img')
-        initrd_hash = '519a1962daf17d67fc3a9c89d45affcb399607db'
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'rdinit=/bin/bash console=ttyAMA0')
-        machine_type = 'virt,gic-version=3'
-        self.do_test(kernel_url, kernel_hash, initrd_url, initrd_hash,
-                     kernel_command_line, machine_type)
+    def test_multiprocess(self):
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        if self.arch == 'x86_64':
+            kernel_command_line += 'console=ttyS0 rdinit=/bin/bash'
+            self.do_test(self.ASSET_KERNEL_X86, self.ASSET_INITRD_X86,
+                         kernel_command_line, 'pc')
+        elif self.arch == 'aarch64':
+            kernel_command_line += 'rdinit=/bin/bash console=ttyAMA0'
+            self.do_test(self.ASSET_KERNEL_AARCH64, self.ASSET_INITRD_AARCH64,
+                         kernel_command_line, 'virt,gic-version=3')
+        else:
+            assert False
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


