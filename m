Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjfv-0006eI-P9; Wed, 04 Dec 2024 02:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfg-0006Ye-A9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfb-0005I5-HW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733296773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ge4TGd+pIUVhg9BTGjgOHWXEMpXP8I6MCMpCMX9GCEg=;
 b=cGNqlmCkfBcDFJ5xhZWFvWe28Hv3Ww3aFXFvFS/H9s5o7EuSJ5w4h42vkQDMoU9WOx61CL
 99PmXe7kpe11Y3k0nvXn3BLlw/JzQgnFkTVNrpJdDZ8IOysxBZS49MlqYLD5iJtbUZtILA
 xF0c8xLYVqE/WEghzvheRrKkkW8Ptec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-KKUHrXcQM4OY_ZS2cWfsnA-1; Wed,
 04 Dec 2024 02:19:30 -0500
X-MC-Unique: KKUHrXcQM4OY_ZS2cWfsnA-1
X-Mimecast-MFC-AGG-ID: KKUHrXcQM4OY_ZS2cWfsnA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54D291956058; Wed,  4 Dec 2024 07:19:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1C621956054; Wed,  4 Dec 2024 07:19:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] tests/functional: Convert the migration avocado test
Date: Wed,  4 Dec 2024 08:19:11 +0100
Message-ID: <20241204071911.664057-6-thuth@redhat.com>
In-Reply-To: <20241204071911.664057-1-thuth@redhat.com>
References: <20241204071911.664057-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that we've got a find_free_port() function in the functional
test framework, we can convert the migration test, too.
While the original avocado test was only meant to run on aarch64,
ppc64 and x86, we can turn this into a more generic test by now
and run it on all architectures that have a default machine that
ships with a working firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/migration.py         | 135 -----------------------------
 tests/functional/meson.build       |  19 ++++
 tests/functional/test_migration.py |  83 ++++++++++++++++++
 3 files changed, 102 insertions(+), 135 deletions(-)
 delete mode 100644 tests/avocado/migration.py
 create mode 100755 tests/functional/test_migration.py

diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
deleted file mode 100644
index be6234b3c2..0000000000
--- a/tests/avocado/migration.py
+++ /dev/null
@@ -1,135 +0,0 @@
-# Migration test
-#
-# Copyright (c) 2019 Red Hat, Inc.
-#
-# Authors:
-#  Cleber Rosa <crosa@redhat.com>
-#  Caio Carrara <ccarrara@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-
-import tempfile
-import os
-
-from avocado_qemu import QemuSystemTest
-from avocado import skipUnless
-
-from avocado.utils.network import ports
-from avocado.utils import wait
-from avocado.utils.path import find_command
-
-
-class MigrationTest(QemuSystemTest):
-    """
-    :avocado: tags=migration
-    """
-
-    timeout = 10
-
-    @staticmethod
-    def migration_finished(vm):
-        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
-
-    def assert_migration(self, src_vm, dst_vm):
-        wait.wait_for(self.migration_finished,
-                      timeout=self.timeout,
-                      step=0.1,
-                      args=(src_vm,))
-        wait.wait_for(self.migration_finished,
-                      timeout=self.timeout,
-                      step=0.1,
-                      args=(dst_vm,))
-        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
-        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
-
-    def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri)
-        dest_vm.add_args('-nodefaults')
-        dest_vm.launch()
-        if src_uri is None:
-            src_uri = dest_uri
-        source_vm = self.get_vm()
-        source_vm.add_args('-nodefaults')
-        source_vm.launch()
-        source_vm.qmp('migrate', uri=src_uri)
-        self.assert_migration(source_vm, dest_vm)
-
-    def _get_free_port(self):
-        port = ports.find_free_port()
-        if port is None:
-            self.cancel('Failed to find a free port')
-        return port
-
-    def migration_with_tcp_localhost(self):
-        dest_uri = 'tcp:localhost:%u' % self._get_free_port()
-        self.do_migrate(dest_uri)
-
-    def migration_with_unix(self):
-        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
-            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
-            self.do_migrate(dest_uri)
-
-    @skipUnless(find_command('nc', default=False), "'nc' command not found")
-    def migration_with_exec(self):
-        """The test works for both netcat-traditional and netcat-openbsd packages."""
-        free_port = self._get_free_port()
-        dest_uri = 'exec:nc -l localhost %u' % free_port
-        src_uri = 'exec:nc localhost %u' % free_port
-        self.do_migrate(dest_uri, src_uri)
-
-
-@skipUnless('aarch64' in os.uname()[4], "host != target")
-class Aarch64(MigrationTest):
-    """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    :avocado: tags=cpu:max
-    """
-
-    def test_migration_with_tcp_localhost(self):
-        self.migration_with_tcp_localhost()
-
-    def test_migration_with_unix(self):
-        self.migration_with_unix()
-
-    def test_migration_with_exec(self):
-        self.migration_with_exec()
-
-
-@skipUnless('x86_64' in os.uname()[4], "host != target")
-class X86_64(MigrationTest):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:pc
-    :avocado: tags=cpu:qemu64
-    """
-
-    def test_migration_with_tcp_localhost(self):
-        self.migration_with_tcp_localhost()
-
-    def test_migration_with_unix(self):
-        self.migration_with_unix()
-
-    def test_migration_with_exec(self):
-        self.migration_with_exec()
-
-
-@skipUnless('ppc64le' in os.uname()[4], "host != target")
-class PPC64(MigrationTest):
-    """
-    :avocado: tags=arch:ppc64
-    :avocado: tags=machine:pseries
-    """
-
-    def test_migration_with_tcp_localhost(self):
-        self.migration_with_tcp_localhost()
-
-    def test_migration_with_unix(self):
-        self.migration_with_unix()
-
-    def test_migration_with_exec(self):
-        self.migration_with_exec()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3d29b8245a..0558d0aa4e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -61,6 +61,10 @@ tests_aarch64_system_thorough = [
   'multiprocess',
 ]
 
+tests_alpha_system_quick = [
+  'migration',
+]
+
 tests_alpha_system_thorough = [
   'alpha_clipper',
 ]
@@ -148,6 +152,10 @@ tests_ppc_system_thorough = [
   'ppc_virtex_ml507',
 ]
 
+tests_ppc64_system_quick = [
+  'migration',
+]
+
 tests_ppc64_system_thorough = [
   'ppc64_e500',
   'ppc64_hv',
@@ -157,6 +165,7 @@ tests_ppc64_system_thorough = [
 ]
 
 tests_riscv32_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -165,6 +174,7 @@ tests_riscv32_system_thorough = [
 ]
 
 tests_riscv64_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -191,10 +201,18 @@ tests_sh4eb_system_thorough = [
   'sh4eb_r2d',
 ]
 
+tests_sparc_system_quick = [
+  'migration',
+]
+
 tests_sparc_system_thorough = [
   'sparc_sun4m',
 ]
 
+tests_sparc64_system_quick = [
+  'migration',
+]
+
 tests_sparc64_system_thorough = [
   'sparc64_sun4u',
   'sparc64_tuxrun',
@@ -203,6 +221,7 @@ tests_sparc64_system_thorough = [
 tests_x86_64_system_quick = [
   'cpu_queries',
   'mem_addr_space',
+  'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
new file mode 100755
index 0000000000..9c78444f80
--- /dev/null
+++ b/tests/functional/test_migration.py
@@ -0,0 +1,83 @@
+#!/usr/bin/env python3
+#
+# Migration test
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Authors:
+#  Cleber Rosa <crosa@redhat.com>
+#  Caio Carrara <ccarrara@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import tempfile
+import time
+
+from qemu_test import QemuSystemTest, has_cmd
+from qemu_test.ports import Ports
+from unittest import skipUnless
+
+class MigrationTest(QemuSystemTest):
+
+    timeout = 10
+
+    @staticmethod
+    def migration_finished(vm):
+        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
+
+    def assert_migration(self, src_vm, dst_vm):
+
+        end = time.monotonic() + self.timeout
+        while time.monotonic() < end and not self.migration_finished(src_vm):
+           time.sleep(0.1)
+
+        end = time.monotonic() + self.timeout
+        while time.monotonic() < end and not self.migration_finished(dst_vm):
+           time.sleep(0.1)
+
+        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
+        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
+        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
+        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
+
+    def do_migrate(self, dest_uri, src_uri=None):
+        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
+        dest_vm.add_args('-nodefaults')
+        dest_vm.launch()
+        if src_uri is None:
+            src_uri = dest_uri
+        source_vm = self.get_vm(name="source-qemu")
+        source_vm.add_args('-nodefaults')
+        source_vm.launch()
+        source_vm.qmp('migrate', uri=src_uri)
+        self.assert_migration(source_vm, dest_vm)
+
+    def _get_free_port(self, ports):
+        port = ports.find_free_port()
+        if port is None:
+            self.skipTest('Failed to find a free port')
+        return port
+
+    def test_migration_with_tcp_localhost(self):
+        with Ports() as ports:
+            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.do_migrate(dest_uri)
+
+    def test_migration_with_unix(self):
+        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
+            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
+            self.do_migrate(dest_uri)
+
+    @skipUnless(*has_cmd('nc'))
+    def test_migration_with_exec(self):
+        """The test works for both netcat-traditional and netcat-openbsd packages."""
+        with Ports() as ports:
+            free_port = self._get_free_port(ports)
+            dest_uri = 'exec:nc -l localhost %u' % free_port
+            src_uri = 'exec:nc localhost %u' % free_port
+            self.do_migrate(dest_uri, src_uri)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.0


