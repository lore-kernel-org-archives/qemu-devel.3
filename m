Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACC6C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsT2-0007x0-DG; Fri, 01 Aug 2025 12:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrRa-0000k4-Eu
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrRY-0002dl-5X
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibm3kgce5FekFo1WNXT0w96YzFVkoA7AKH6q7v2gODw=;
 b=RkSt+gzG5Qaz6FfSkzKxm5BHNsoyk1XeUcvvdrN7yn+ZhHN+SNzIgqWwP1jSiJFzM7xlrp
 0IVCZNahfFbZoIBmVt20xcGdABE/naBr7s7qFV9eWJ80SSJpoUhKLPKiwnZeV3iTATU+P3
 tynk1jNP3rQJXV5aSELfOb5NKUACE0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-ZqZZOCIlNQevAPSmKt52Jw-1; Fri,
 01 Aug 2025 11:13:06 -0400
X-MC-Unique: ZqZZOCIlNQevAPSmKt52Jw-1
X-Mimecast-MFC-AGG-ID: ZqZZOCIlNQevAPSmKt52Jw_1754061185
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30286195608F; Fri,  1 Aug 2025 15:13:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E54171800B4F; Fri,  1 Aug 2025 15:13:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/24] tests/functional: Rework the multiprocess test to have
 target-specific files
Date: Fri,  1 Aug 2025 17:12:27 +0200
Message-ID: <20250801151251.751368-3-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We are going to move the tests for each target into separate subdirectories.
The multiprocess test currently contains code for both, x86 and aarch64,
so it does not quite fit into this scheme. Rework the test to have a common
test class, and target specific files with a target specific class, so
that this will fit better into the new scheme.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  4 +-
 .../{test_multiprocess.py => multiprocess.py} | 40 +------------------
 tests/functional/test_aarch64_multiprocess.py | 31 ++++++++++++++
 tests/functional/test_x86_64_multiprocess.py  | 31 ++++++++++++++
 5 files changed, 67 insertions(+), 41 deletions(-)
 rename tests/functional/{test_multiprocess.py => multiprocess.py} (58%)
 mode change 100755 => 100644
 create mode 100755 tests/functional/test_aarch64_multiprocess.py
 create mode 100755 tests/functional/test_x86_64_multiprocess.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f491b083c..f2164c2b155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4284,7 +4284,7 @@ F: hw/remote/vfio-user-obj.c
 F: include/hw/remote/vfio-user-obj.h
 F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
-F: tests/functional/test_multiprocess.py
+F: tests/functional/*multiprocess.py
 
 VFIO-USER:
 M: John Levon <john.levon@nutanix.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 5fb13928b9e..19ea85a6361 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -90,6 +90,7 @@ tests_aarch64_system_thorough = [
   'aarch64_hotplug_pci',
   'aarch64_imx8mp_evk',
   'aarch64_kvm',
+  'aarch64_multiprocess',
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_replay',
@@ -106,7 +107,6 @@ tests_aarch64_system_thorough = [
   'aarch64_virt_gpu',
   'aarch64_xen',
   'aarch64_xlnx_versal',
-  'multiprocess',
 ]
 
 tests_alpha_system_quick = [
@@ -331,7 +331,7 @@ tests_x86_64_system_thorough = [
   'acpi_bits',
   'intel_iommu',
   'linux_initrd',
-  'multiprocess',
+  'x86_64_multiprocess',
   'netdev_ethtool',
   'virtio_balloon',
   'virtio_gpu',
diff --git a/tests/functional/test_multiprocess.py b/tests/functional/multiprocess.py
old mode 100755
new mode 100644
similarity index 58%
rename from tests/functional/test_multiprocess.py
rename to tests/functional/multiprocess.py
index 92d5207b0eb..6a06c1eda19
--- a/tests/functional/test_multiprocess.py
+++ b/tests/functional/multiprocess.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Test for multiprocess qemu
 #
@@ -9,33 +9,13 @@
 import os
 import socket
 
-from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+from qemu_test import QemuSystemTest, wait_for_console_pattern
 from qemu_test import exec_command, exec_command_and_wait_for_pattern
 
 class Multiprocess(QemuSystemTest):
 
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    ASSET_KERNEL_X86 = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-         '/releases/31/Everything/x86_64/os/images/pxeboot/vmlinuz'),
-        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
-
-    ASSET_INITRD_X86 = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-         '/releases/31/Everything/x86_64/os/images/pxeboot/initrd.img'),
-        '3b6cb5c91a14c42e2f61520f1689264d865e772a1f0069e660a800d31dd61fb9')
-
-    ASSET_KERNEL_AARCH64 = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-         '/releases/31/Everything/aarch64/os/images/pxeboot/vmlinuz'),
-        '3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527')
-
-    ASSET_INITRD_AARCH64 = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-         '/releases/31/Everything/aarch64/os/images/pxeboot/initrd.img'),
-        '9fd230cab10b1dafea41cf00150e6669d37051fad133bd618d2130284e16d526')
-
     def do_test(self, kernel_asset, initrd_asset,
                 kernel_command_line, machine_type):
         """Main test method"""
@@ -85,19 +65,3 @@ def do_test(self, kernel_asset, initrd_asset,
 
         proxy_sock.close()
         remote_sock.close()
-
-    def test_multiprocess(self):
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
-        if self.arch == 'x86_64':
-            kernel_command_line += 'console=ttyS0 rdinit=/bin/bash'
-            self.do_test(self.ASSET_KERNEL_X86, self.ASSET_INITRD_X86,
-                         kernel_command_line, 'pc')
-        elif self.arch == 'aarch64':
-            kernel_command_line += 'rdinit=/bin/bash console=ttyAMA0'
-            self.do_test(self.ASSET_KERNEL_AARCH64, self.ASSET_INITRD_AARCH64,
-                         kernel_command_line, 'virt,gic-version=3')
-        else:
-            assert False
-
-if __name__ == '__main__':
-    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_multiprocess.py b/tests/functional/test_aarch64_multiprocess.py
new file mode 100755
index 00000000000..1c6e45ecb67
--- /dev/null
+++ b/tests/functional/test_aarch64_multiprocess.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test for multiprocess qemu on aarch64
+
+from multiprocess import Multiprocess
+from qemu_test import Asset
+
+
+class Aarch64Multiprocess(Multiprocess):
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
+    def test_multiprocess(self):
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'rdinit=/bin/bash console=ttyAMA0')
+        self.do_test(self.ASSET_KERNEL_AARCH64, self.ASSET_INITRD_AARCH64,
+                     kernel_command_line, 'virt,gic-version=3')
+
+
+if __name__ == '__main__':
+    Multiprocess.main()
diff --git a/tests/functional/test_x86_64_multiprocess.py b/tests/functional/test_x86_64_multiprocess.py
new file mode 100755
index 00000000000..756629dd446
--- /dev/null
+++ b/tests/functional/test_x86_64_multiprocess.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test for multiprocess qemu on x86
+
+from multiprocess import Multiprocess
+from qemu_test import Asset
+
+
+class X86Multiprocess(Multiprocess):
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
+    def test_multiprocess(self):
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 rdinit=/bin/bash')
+        self.do_test(self.ASSET_KERNEL_X86, self.ASSET_INITRD_X86,
+                     kernel_command_line, 'pc')
+
+
+if __name__ == '__main__':
+    Multiprocess.main()
-- 
2.50.1


