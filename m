Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E479BC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHM-0000us-AN; Tue, 30 Jul 2024 13:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHL-0000sL-Ka
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHH-0002Rs-UX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fQ/u5iyx5kV1+IvuNFjdKflkGZHLviKXwvMdc1tOps=;
 b=N3enCbnRlzMGkNluVY1ep9BkEFrCXQr+r+s0t+BOQmhLRFP0qDkiGKo4cE7wO1kr3xgJmz
 RAGzBRnrEp7W5qoCz44BviyjKcFSac/0jHsXmquJqej7uyLZ/S1KET6UJWr6trALdpI2Na
 52y1KBXGGer5+5pu/JR4eCBTksFV4lo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-1yxNJYCfOk616S5cCdseYw-1; Tue,
 30 Jul 2024 13:04:43 -0400
X-MC-Unique: 1yxNJYCfOk616S5cCdseYw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 279AE19560A2; Tue, 30 Jul 2024 17:04:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B3CD300018D; Tue, 30 Jul 2024 17:04:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 12/24] tests/functional: Convert some avocado tests that
 needed avocado.utils.archive
Date: Tue, 30 Jul 2024 18:03:32 +0100
Message-ID: <20240730170347.4103919-13-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

Instead of using the "archive" module from avocado.utils, switch
these tests to use the new wrapper function that is based on the
"tarfile" module instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  6 +--
 tests/avocado/machine_sparc64_sun4u.py        | 36 -----------------
 tests/functional/meson.build                  |  6 +++
 .../test_arm_canona1100.py}                   | 30 ++++++++------
 .../test_ppc_bamboo.py}                       | 32 +++++++--------
 tests/functional/test_sparc64_sun4u.py        | 40 +++++++++++++++++++
 6 files changed, 82 insertions(+), 68 deletions(-)
 delete mode 100644 tests/avocado/machine_sparc64_sun4u.py
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (52%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py} (60%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_sparc64_sun4u.py

diff --git a/MAINTAINERS b/MAINTAINERS
index c2b4352edd..ff952d683b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -731,7 +731,7 @@ S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
-F: tests/avocado/machine_arm_canona1100.py
+F: tests/functional/test_arm_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
@@ -1426,7 +1426,7 @@ L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
 F: hw/pci-host/ppc4xx_pci.c
-F: tests/avocado/ppc_bamboo.py
+F: tests/functional/test_ppc_bamboo.py
 
 e500
 L: qemu-ppc@nongnu.org
@@ -1712,7 +1712,7 @@ F: include/hw/pci-host/sabre.h
 F: hw/pci-bridge/simba.c
 F: include/hw/pci-bridge/simba.h
 F: pc-bios/openbios-sparc64
-F: tests/avocado/machine_sparc64_sun4u.py
+F: tests/functional/test_sparc64_sun4u.py
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
diff --git a/tests/avocado/machine_sparc64_sun4u.py b/tests/avocado/machine_sparc64_sun4u.py
deleted file mode 100644
index d333c0ae91..0000000000
--- a/tests/avocado/machine_sparc64_sun4u.py
+++ /dev/null
@@ -1,36 +0,0 @@
-# Functional test that boots a Linux kernel and checks the console
-#
-# Copyright (c) 2020 Red Hat, Inc.
-#
-# Author:
-#  Thomas Huth <thuth@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-import os
-
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
-from boot_linux_console import LinuxKernelTest
-
-class Sun4uMachine(LinuxKernelTest):
-    """Boots the Linux kernel and checks that the console is operational"""
-
-    timeout = 90
-
-    def test_sparc64_sun4u(self):
-        """
-        :avocado: tags=arch:sparc64
-        :avocado: tags=machine:sun4u
-        """
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day23.tar.xz')
-        tar_hash = '142db83cd974ffadc4f75c8a5cad5bcc5722c240'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day23/vmlinux',
-                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
-        self.vm.launch()
-        wait_for_console_pattern(self, 'Starting logging: OK')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 32c7cc2d3c..91bf80f0f4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -21,6 +21,7 @@ tests_generic = [
 ]
 
 tests_arm_thorough = [
+  'arm_canona1100',
   'arm_n8x0',
 ]
 
@@ -42,6 +43,11 @@ tests_ppc_quick = [
 
 tests_ppc_thorough = [
   'ppc_405',
+  'ppc_bamboo',
+]
+
+tests_sparc64_thorough = [
+  'sparc64_sun4u',
 ]
 
 tests_x86_64_quick = [
diff --git a/tests/avocado/machine_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
old mode 100644
new mode 100755
similarity index 52%
rename from tests/avocado/machine_arm_canona1100.py
rename to tests/functional/test_arm_canona1100.py
index a42d8b0f2b..57cecbbb36
--- a/tests/avocado/machine_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots the canon-a1100 machine with firmware
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -8,28 +10,30 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
 
 class CanonA1100Machine(QemuSystemTest):
     """Boots the barebox firmware and checks that the console is operational"""
 
     timeout = 90
 
+    ASSET_BIOS = Asset(('https://qemu-advcal.gitlab.io'
+                        '/qac-best-of-multiarch/download/day18.tar.xz'),
+                       '068b5fc4242b29381acee94713509f8a876e9db6')
+
     def test_arm_canona1100(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:canon-a1100
-        :avocado: tags=device:pflash_cfi02
-        """
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day18.tar.xz')
-        tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        self.set_machine('canon-a1100')
+
+        file_path = self.ASSET_BIOS.fetch()
+        archive_extract(file_path, dest_dir=self.workdir,
+                        member="day18/barebox.canon-a1100.bin")
         self.vm.set_console()
         self.vm.add_args('-bios',
                          self.workdir + '/day18/barebox.canon-a1100.bin')
         self.vm.launch()
         wait_for_console_pattern(self, 'running /env/bin/init')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
old mode 100644
new mode 100755
similarity index 60%
rename from tests/avocado/ppc_bamboo.py
rename to tests/functional/test_ppc_bamboo.py
index a81be3d608..8a1f7eca4d
--- a/tests/avocado/ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on the ppc bamboo board and check the console
 #
 # Copyright (c) 2021 Red Hat
@@ -5,30 +7,25 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class BambooMachine(QemuSystemTest):
 
     timeout = 90
 
+    ASSET_IMAGE = Asset(('http://landley.net/aboriginal/downloads/binaries/'
+                         'system-image-powerpc-440fp.tar.gz'),
+                        '53e5f16414b195b82d2c70272f81c2eedb39bad9')
+
     def test_ppc_bamboo(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:bamboo
-        :avocado: tags=cpu:440epb
-        :avocado: tags=device:rtl8139
-        :avocado: tags=accel:tcg
-        """
+        self.set_machine('bamboo')
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        tar_url = ('http://landley.net/aboriginal/downloads/binaries/'
-                   'system-image-powerpc-440fp.tar.gz')
-        tar_hash = '53e5f16414b195b82d2c70272f81c2eedb39bad9'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        file_path = self.ASSET_IMAGE.fetch()
+        archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir +
                                    '/system-image-powerpc-440fp/linux',
@@ -40,3 +37,6 @@ def test_ppc_bamboo(self):
         exec_command_and_wait_for_pattern(self, 'ping 10.0.2.2',
                                           '10.0.2.2 is alive!')
         exec_command_and_wait_for_pattern(self, 'halt', 'System Halted')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
new file mode 100755
index 0000000000..3ac18aebd1
--- /dev/null
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+
+class Sun4uMachine(QemuSystemTest):
+    """Boots the Linux kernel and checks that the console is operational"""
+
+    timeout = 90
+
+    ASSET_IMAGE = Asset(('https://qemu-advcal.gitlab.io'
+                         '/qac-best-of-multiarch/download/day23.tar.xz'),
+                        '142db83cd974ffadc4f75c8a5cad5bcc5722c240')
+
+    def test_sparc64_sun4u(self):
+        self.set_machine('sun4u')
+        file_path = self.ASSET_IMAGE.fetch()
+        kernel_name = 'day23/vmlinux'
+        archive_extract(file_path, self.workdir, kernel_name)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', os.path.join(self.workdir, kernel_name),
+                         '-append', 'printk.time=0')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Starting logging: OK')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


