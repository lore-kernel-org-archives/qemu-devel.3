Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4740EECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08i-0006LD-QH; Tue, 10 Sep 2024 08:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08g-00063E-7c
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08Y-0005DC-UN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYI+9/ae6UALXw/L/jFSJ+sER/OsDhTgB9LPNW5DXsM=;
 b=NUXtjDtFmtMSHKGXLgmWk50k7p/EAgrCxCbDdJ1Lj62viZFdQ0+XAyYyFLC/eEPe/niZEQ
 CtUbb8VTrzC5prG7XI8EB64l+5m6/WixWDXizw/B8AxZ6v6GX4ddcXbp3a5s01sdD7LhBC
 +cLHUyTOIc3pmB7FRDAshTBeGhyQpiA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-7TBn1NF9Nf6DjAfr_CBoLQ-1; Tue,
 10 Sep 2024 08:38:21 -0400
X-MC-Unique: 7TBn1NF9Nf6DjAfr_CBoLQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1839619367BC; Tue, 10 Sep 2024 12:38:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06C8919560AB; Tue, 10 Sep 2024 12:38:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/22] tests/functional: Convert the multiprocess avocado test
 into a standalone test
Date: Tue, 10 Sep 2024 14:37:22 +0200
Message-ID: <20240910123726.182975-22-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This test handles both, aarch64 and x86_64, with the same test code
(apart from some initial setup), so don't split this file by target
but add a check for self.arch in the main test function.

Message-ID: <20240903051333.102494-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/avocado_qemu/__init__.py |  10 ---
 tests/avocado/multiprocess.py          | 102 -------------------------
 tests/functional/meson.build           |   2 +
 tests/functional/test_multiprocess.py  | 100 ++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 112 deletions(-)
 delete mode 100644 tests/avocado/multiprocess.py
 create mode 100755 tests/functional/test_multiprocess.py

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
diff --git a/tests/avocado/multiprocess.py b/tests/avocado/multiprocess.py
deleted file mode 100644
index ee7490ae08..0000000000
--- a/tests/avocado/multiprocess.py
+++ /dev/null
@@ -1,102 +0,0 @@
-# Test for multiprocess qemu
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-
-import os
-import socket
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command
-from avocado_qemu import exec_command_and_wait_for_pattern
-
-class Multiprocess(QemuSystemTest):
-    """
-    :avocado: tags=multiprocess
-    """
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-
-    def do_test(self, kernel_url, kernel_hash, initrd_url, initrd_hash,
-                kernel_command_line, machine_type):
-        """Main test method"""
-        self.require_accelerator('kvm')
-        self.require_multiprocess()
-
-        # Create socketpair to connect proxy and remote processes
-        proxy_sock, remote_sock = socket.socketpair(socket.AF_UNIX,
-                                                    socket.SOCK_STREAM)
-        os.set_inheritable(proxy_sock.fileno(), True)
-        os.set_inheritable(remote_sock.fileno(), True)
-
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-
-        # Create remote process
-        remote_vm = self.get_vm()
-        remote_vm.add_args('-machine', 'x-remote')
-        remote_vm.add_args('-nodefaults')
-        remote_vm.add_args('-device', 'lsi53c895a,id=lsi1')
-        remote_vm.add_args('-object', 'x-remote-object,id=robj1,'
-                           'devid=lsi1,fd='+str(remote_sock.fileno()))
-        remote_vm.launch()
-
-        # Create proxy process
-        self.vm.set_console()
-        self.vm.add_args('-machine', machine_type)
-        self.vm.add_args('-accel', 'kvm')
-        self.vm.add_args('-cpu', 'host')
-        self.vm.add_args('-object',
-                         'memory-backend-memfd,id=sysmem-file,size=2G')
-        self.vm.add_args('--numa', 'node,memdev=sysmem-file')
-        self.vm.add_args('-m', '2048')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line)
-        self.vm.add_args('-device',
-                         'x-pci-proxy-dev,'
-                         'id=lsi1,fd='+str(proxy_sock.fileno()))
-        self.vm.launch()
-        wait_for_console_pattern(self, 'as init process',
-                                 'Kernel panic - not syncing')
-        exec_command(self, 'mount -t sysfs sysfs /sys')
-        exec_command_and_wait_for_pattern(self,
-                                          'cat /sys/bus/pci/devices/*/uevent',
-                                          'PCI_ID=1000:0012')
-
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
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 68a7570119..975e609073 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -39,6 +39,7 @@ tests_aarch64_system_thorough = [
   'aarch64_raspi4',
   'aarch64_sbsaref',
   'aarch64_virt',
+  'multiprocess',
 ]
 
 tests_alpha_system_thorough = [
@@ -141,6 +142,7 @@ tests_x86_64_system_quick = [
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'linux_initrd',
+  'multiprocess',
   'netdev_ethtool',
   'virtio_gpu',
 ]
diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
new file mode 100755
index 0000000000..751cf10e63
--- /dev/null
+++ b/tests/functional/test_multiprocess.py
@@ -0,0 +1,100 @@
+#!/usr/bin/env python3
+#
+# Test for multiprocess qemu
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+
+import os
+import socket
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+
+class Multiprocess(QemuSystemTest):
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
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
+        '3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527')
+
+    ASSET_INITRD_AARCH64 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+         '/releases/31/Everything/aarch64/os/images/pxeboot/initrd.img'),
+        '9fd230cab10b1dafea41cf00150e6669d37051fad133bd618d2130284e16d526')
+
+    def do_test(self, kernel_asset, initrd_asset,
+                kernel_command_line, machine_type):
+        """Main test method"""
+        self.require_accelerator('kvm')
+        self.require_device('x-pci-proxy-dev')
+
+        # Create socketpair to connect proxy and remote processes
+        proxy_sock, remote_sock = socket.socketpair(socket.AF_UNIX,
+                                                    socket.SOCK_STREAM)
+        os.set_inheritable(proxy_sock.fileno(), True)
+        os.set_inheritable(remote_sock.fileno(), True)
+
+        kernel_path = kernel_asset.fetch()
+        initrd_path = initrd_asset.fetch()
+
+        # Create remote process
+        remote_vm = self.get_vm()
+        remote_vm.add_args('-machine', 'x-remote')
+        remote_vm.add_args('-nodefaults')
+        remote_vm.add_args('-device', 'lsi53c895a,id=lsi1')
+        remote_vm.add_args('-object', 'x-remote-object,id=robj1,'
+                           'devid=lsi1,fd='+str(remote_sock.fileno()))
+        remote_vm.launch()
+
+        # Create proxy process
+        self.vm.set_console()
+        self.vm.add_args('-machine', machine_type)
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-cpu', 'host')
+        self.vm.add_args('-object',
+                         'memory-backend-memfd,id=sysmem-file,size=2G')
+        self.vm.add_args('--numa', 'node,memdev=sysmem-file')
+        self.vm.add_args('-m', '2048')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args('-device',
+                         'x-pci-proxy-dev,'
+                         'id=lsi1,fd='+str(proxy_sock.fileno()))
+        self.vm.launch()
+        wait_for_console_pattern(self, 'as init process',
+                                 'Kernel panic - not syncing')
+        exec_command(self, 'mount -t sysfs sysfs /sys')
+        exec_command_and_wait_for_pattern(self,
+                                          'cat /sys/bus/pci/devices/*/uevent',
+                                          'PCI_ID=1000:0012')
+
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


