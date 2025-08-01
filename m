Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD79C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsT0-0007Wj-4V; Fri, 01 Aug 2025 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrRS-0000gP-Tw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrRP-0002bo-ES
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2PPIqaARayPULG75VltuiTlFhnXiX7YEcOqTi5HXsE=;
 b=i57n5yrboeo5qutMZzkp35sNptKhKu//6X/oXXMAkouagewiPAdY79eQQpPyNkH+b6POvl
 yBh1Cf23WNkInKb7w6jbl8rqRcwDABIrhWBZnkXxS0HRBPTTTVQ4kUUTmDqZjCEMXeHRG7
 20200Pyf02mLf3YidI5XieO9IxOfNKw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-gv5Ni3mUM52Kp2ff4ph5zg-1; Fri,
 01 Aug 2025 11:13:01 -0400
X-MC-Unique: gv5Ni3mUM52Kp2ff4ph5zg-1
X-Mimecast-MFC-AGG-ID: gv5Ni3mUM52Kp2ff4ph5zg_1754061180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3991E19773EB; Fri,  1 Aug 2025 15:13:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BBC81800B4F; Fri,  1 Aug 2025 15:12:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/24] tests/functional: Rework the migration test to have
 target-specific files
Date: Fri,  1 Aug 2025 17:12:26 +0200
Message-ID: <20250801151251.751368-2-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
The migration test does not fit quite into this scheme, since it works
for multiple targets, but not all. Rework the test to have a common
test class, and target specific files with a target specific class, so
that this will fit better into the new scheme.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  | 22 ++++++------
 .../{test_migration.py => migration.py}       | 35 +++++--------------
 tests/functional/test_aarch64_migration.py    | 26 ++++++++++++++
 tests/functional/test_alpha_migration.py      | 26 ++++++++++++++
 tests/functional/test_arm_migration.py        | 26 ++++++++++++++
 tests/functional/test_i386_migration.py       | 26 ++++++++++++++
 tests/functional/test_ppc64_migration.py      | 26 ++++++++++++++
 tests/functional/test_ppc_migration.py        | 26 ++++++++++++++
 tests/functional/test_riscv32_migration.py    | 26 ++++++++++++++
 tests/functional/test_riscv64_migration.py    | 26 ++++++++++++++
 tests/functional/test_sparc64_migration.py    | 26 ++++++++++++++
 tests/functional/test_sparc_migration.py      | 26 ++++++++++++++
 tests/functional/test_x86_64_migration.py     | 26 ++++++++++++++
 14 files changed, 306 insertions(+), 39 deletions(-)
 rename tests/functional/{test_migration.py => migration.py} (74%)
 mode change 100755 => 100644
 create mode 100755 tests/functional/test_aarch64_migration.py
 create mode 100755 tests/functional/test_alpha_migration.py
 create mode 100755 tests/functional/test_arm_migration.py
 create mode 100755 tests/functional/test_i386_migration.py
 create mode 100755 tests/functional/test_ppc64_migration.py
 create mode 100755 tests/functional/test_ppc_migration.py
 create mode 100755 tests/functional/test_riscv32_migration.py
 create mode 100755 tests/functional/test_riscv64_migration.py
 create mode 100755 tests/functional/test_sparc64_migration.py
 create mode 100755 tests/functional/test_sparc_migration.py
 create mode 100755 tests/functional/test_x86_64_migration.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 069d77f2f80..97f491b083c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3595,7 +3595,7 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
-F: tests/functional/test_migration.py
+F: tests/functional/*migration.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ecf965adc6c..5fb13928b9e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -80,7 +80,7 @@ tests_generic_bsduser = [
 ]
 
 tests_aarch64_system_quick = [
-  'migration',
+  'aarch64_migration',
 ]
 
 tests_aarch64_system_thorough = [
@@ -110,7 +110,7 @@ tests_aarch64_system_thorough = [
 ]
 
 tests_alpha_system_quick = [
-  'migration',
+  'alpha_migration',
 ]
 
 tests_alpha_system_thorough = [
@@ -119,7 +119,7 @@ tests_alpha_system_thorough = [
 ]
 
 tests_arm_system_quick = [
-  'migration',
+  'arm_migration',
 ]
 
 tests_arm_system_thorough = [
@@ -168,7 +168,7 @@ tests_hppa_system_quick = [
 ]
 
 tests_i386_system_quick = [
-  'migration',
+  'i386_migration',
 ]
 
 tests_i386_system_thorough = [
@@ -228,7 +228,7 @@ tests_or1k_system_thorough = [
 ]
 
 tests_ppc_system_quick = [
-  'migration',
+  'ppc_migration',
   'ppc_74xx',
 ]
 
@@ -245,7 +245,7 @@ tests_ppc_system_thorough = [
 ]
 
 tests_ppc64_system_quick = [
-  'migration',
+  'ppc64_migration',
 ]
 
 tests_ppc64_system_thorough = [
@@ -260,7 +260,7 @@ tests_ppc64_system_thorough = [
 ]
 
 tests_riscv32_system_quick = [
-  'migration',
+  'riscv32_migration',
   'riscv_opensbi',
 ]
 
@@ -269,7 +269,7 @@ tests_riscv32_system_thorough = [
 ]
 
 tests_riscv64_system_quick = [
-  'migration',
+  'riscv64_migration',
   'riscv_opensbi',
 ]
 
@@ -299,7 +299,7 @@ tests_sh4eb_system_thorough = [
 ]
 
 tests_sparc_system_quick = [
-  'migration',
+  'sparc_migration',
 ]
 
 tests_sparc_system_thorough = [
@@ -308,7 +308,7 @@ tests_sparc_system_thorough = [
 ]
 
 tests_sparc64_system_quick = [
-  'migration',
+  'sparc64_migration',
 ]
 
 tests_sparc64_system_thorough = [
@@ -319,7 +319,7 @@ tests_sparc64_system_thorough = [
 tests_x86_64_system_quick = [
   'cpu_queries',
   'mem_addr_space',
-  'migration',
+  'x86_64_migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
diff --git a/tests/functional/test_migration.py b/tests/functional/migration.py
old mode 100755
new mode 100644
similarity index 74%
rename from tests/functional/test_migration.py
rename to tests/functional/migration.py
index c4393c35434..07395544832
--- a/tests/functional/test_migration.py
+++ b/tests/functional/migration.py
@@ -1,6 +1,6 @@
-#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Migration test
+# Migration test base class
 #
 # Copyright (c) 2019 Red Hat, Inc.
 #
@@ -14,7 +14,7 @@
 import tempfile
 import time
 
-from qemu_test import QemuSystemTest, skipIfMissingCommands
+from qemu_test import QemuSystemTest, which
 from qemu_test.ports import Ports
 
 
@@ -41,24 +41,7 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
-    def select_machine(self):
-        target_machine = {
-            'aarch64': 'quanta-gsj',
-            'alpha': 'clipper',
-            'arm': 'npcm750-evb',
-            'i386': 'isapc',
-            'ppc': 'sam460ex',
-            'ppc64': 'mac99',
-            'riscv32': 'spike',
-            'riscv64': 'virt',
-            'sparc': 'SS-4',
-            'sparc64': 'sun4u',
-            'x86_64': 'microvm',
-        }
-        self.set_machine(target_machine[self.arch])
-
     def do_migrate(self, dest_uri, src_uri=None):
-        self.select_machine()
         dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
         dest_vm.add_args('-nodefaults')
         dest_vm.launch()
@@ -76,23 +59,21 @@ def _get_free_port(self, ports):
             self.skipTest('Failed to find a free port')
         return port
 
-    def test_migration_with_tcp_localhost(self):
+    def migration_with_tcp_localhost(self):
         with Ports() as ports:
             dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
             self.do_migrate(dest_uri)
 
-    def test_migration_with_unix(self):
+    def migration_with_unix(self):
         with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
             dest_uri = 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
 
-    @skipIfMissingCommands('ncat')
-    def test_migration_with_exec(self):
+    def migration_with_exec(self):
+        if not which('ncat'):
+            self.skipTest('ncat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dest_uri = 'exec:ncat -l localhost %u' % free_port
             src_uri = 'exec:ncat localhost %u' % free_port
             self.do_migrate(dest_uri, src_uri)
-
-if __name__ == '__main__':
-    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_migration.py b/tests/functional/test_aarch64_migration.py
new file mode 100755
index 00000000000..70267e756d9
--- /dev/null
+++ b/tests/functional/test_aarch64_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# aarch64 migration test
+
+from migration import MigrationTest
+
+
+class Aarch64MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('quanta-gsj')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('quanta-gsj')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('quanta-gsj')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_alpha_migration.py b/tests/functional/test_alpha_migration.py
new file mode 100755
index 00000000000..f11b523ec9e
--- /dev/null
+++ b/tests/functional/test_alpha_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Alpha migration test
+
+from migration import MigrationTest
+
+
+class AlphaMigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('clipper')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('clipper')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('clipper')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_arm_migration.py b/tests/functional/test_arm_migration.py
new file mode 100755
index 00000000000..0aa89f4f61a
--- /dev/null
+++ b/tests/functional/test_arm_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# arm migration test
+
+from migration import MigrationTest
+
+
+class ArmMigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('npcm750-evb')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('npcm750-evb')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('npcm750-evb')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_i386_migration.py b/tests/functional/test_i386_migration.py
new file mode 100755
index 00000000000..a57f3164044
--- /dev/null
+++ b/tests/functional/test_i386_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# i386 migration test
+
+from migration import MigrationTest
+
+
+class I386MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('isapc')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('isapc')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('isapc')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_ppc64_migration.py b/tests/functional/test_ppc64_migration.py
new file mode 100755
index 00000000000..5dfdaaf709a
--- /dev/null
+++ b/tests/functional/test_ppc64_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# ppc migration test
+
+from migration import MigrationTest
+
+
+class PpcMigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('mac99')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('mac99')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('mac99')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_ppc_migration.py b/tests/functional/test_ppc_migration.py
new file mode 100755
index 00000000000..a8692826d35
--- /dev/null
+++ b/tests/functional/test_ppc_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# ppc migration test
+
+from migration import MigrationTest
+
+
+class PpcMigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('sam460ex')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('sam460ex')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('sam460ex')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_riscv32_migration.py b/tests/functional/test_riscv32_migration.py
new file mode 100755
index 00000000000..30acbbe69f9
--- /dev/null
+++ b/tests/functional/test_riscv32_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# riscv32 migration test
+
+from migration import MigrationTest
+
+
+class Rv32MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('spike')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('virt')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('spike')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_riscv64_migration.py b/tests/functional/test_riscv64_migration.py
new file mode 100755
index 00000000000..2d613a29ec4
--- /dev/null
+++ b/tests/functional/test_riscv64_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# riscv64 migration test
+
+from migration import MigrationTest
+
+
+class Rv64MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('virt')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('spike')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('virt')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_sparc64_migration.py b/tests/functional/test_sparc64_migration.py
new file mode 100755
index 00000000000..a8a6c73c354
--- /dev/null
+++ b/tests/functional/test_sparc64_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Sparc64 migration test
+
+from migration import MigrationTest
+
+
+class Sparc64MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('sun4u')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('sun4u')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('sun4u')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_sparc_migration.py b/tests/functional/test_sparc_migration.py
new file mode 100755
index 00000000000..dd6d5783b11
--- /dev/null
+++ b/tests/functional/test_sparc_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Sparc migration test
+
+from migration import MigrationTest
+
+
+class SparcMigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('SS-4')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('SS-5')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('SS-4')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
diff --git a/tests/functional/test_x86_64_migration.py b/tests/functional/test_x86_64_migration.py
new file mode 100755
index 00000000000..f3a517ae1f6
--- /dev/null
+++ b/tests/functional/test_x86_64_migration.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# x86_64 migration test
+
+from migration import MigrationTest
+
+
+class X8664MigrationTest(MigrationTest):
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('microvm')
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('microvm')
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('microvm')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
-- 
2.50.1


