Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E663DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUOn-0007Li-Cv; Thu, 30 Jan 2025 08:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOh-0007Jz-B7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOd-0008Sg-NR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpNs8UpkccpphS6i7/aJc2NZfzRInLdm+TCl99eqWFk=;
 b=EGQRSba0xVurndlbQLu7ooM/6A2izMIp8CZW2LVoRnit6cPUR3CDfbNS+vuxTVENga6lII
 WImSe5IXLX6r3rFi+DbzfG56XSUgdJD9jpNqP3yKuwUqm3dejRmy8qOrUzetheEzVvTN7o
 Ov0gU/lPPBBpP3Pq2Vzr6TpiBRcwbdA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-eR4jxEoAN6-5p3XBcWvLmg-1; Thu,
 30 Jan 2025 08:15:46 -0500
X-MC-Unique: eR4jxEoAN6-5p3XBcWvLmg-1
X-Mimecast-MFC-AGG-ID: eR4jxEoAN6-5p3XBcWvLmg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3522B1801F1D; Thu, 30 Jan 2025 13:15:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 967C430001BE; Thu, 30 Jan 2025 13:15:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/20] tests/functional: Convert the migration avocado test
Date: Thu, 30 Jan 2025 14:15:17 +0100
Message-ID: <20250130131535.91297-4-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Now that we've got a find_free_port() function in the functional
test framework, we can convert the migration test, too.
While the original avocado test was only meant to run on aarch64,
ppc64 and x86, we can turn this into a more generic test by now
and run it on all architectures that have a machine which ships
with a working firmware. To avoid overlapping with the migration
qtest, we now also test migration on machines that are not covered
by the migration qtest yet.

Acked-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250103074308.463860-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                        |   1 +
 tests/avocado/migration.py         | 135 -----------------------------
 tests/functional/meson.build       |  32 +++++++
 tests/functional/test_migration.py | 100 +++++++++++++++++++++
 4 files changed, 133 insertions(+), 135 deletions(-)
 delete mode 100644 tests/avocado/migration.py
 create mode 100755 tests/functional/test_migration.py

diff --git a/MAINTAINERS b/MAINTAINERS
index bb96a00db0..7b4d84bf5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3461,6 +3461,7 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
+F: tests/functional/test_migration.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
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
index b62f714220..3e11b725cb 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -59,6 +59,10 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
+tests_aarch64_system_quick = [
+  'migration',
+]
+
 tests_aarch64_system_thorough = [
   'aarch64_aspeed',
   'aarch64_raspi3',
@@ -74,10 +78,18 @@ tests_aarch64_system_thorough = [
   'multiprocess',
 ]
 
+tests_alpha_system_quick = [
+  'migration',
+]
+
 tests_alpha_system_thorough = [
   'alpha_clipper',
 ]
 
+tests_arm_system_quick = [
+  'migration',
+]
+
 tests_arm_system_thorough = [
   'arm_aspeed_ast1030',
   'arm_aspeed_palmetto',
@@ -114,6 +126,10 @@ tests_hppa_system_quick = [
   'hppa_seabios',
 ]
 
+tests_i386_system_quick = [
+  'migration',
+]
+
 tests_i386_system_thorough = [
   'i386_tuxrun',
 ]
@@ -163,6 +179,7 @@ tests_or1k_system_thorough = [
 ]
 
 tests_ppc_system_quick = [
+  'migration',
   'ppc_74xx',
 ]
 
@@ -177,6 +194,10 @@ tests_ppc_system_thorough = [
   'ppc_virtex_ml507',
 ]
 
+tests_ppc64_system_quick = [
+  'migration',
+]
+
 tests_ppc64_system_thorough = [
   'ppc64_e500',
   'ppc64_hv',
@@ -186,6 +207,7 @@ tests_ppc64_system_thorough = [
 ]
 
 tests_riscv32_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -194,6 +216,7 @@ tests_riscv32_system_thorough = [
 ]
 
 tests_riscv64_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -220,10 +243,18 @@ tests_sh4eb_system_thorough = [
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
@@ -232,6 +263,7 @@ tests_sparc64_system_thorough = [
 tests_x86_64_system_quick = [
   'cpu_queries',
   'mem_addr_space',
+  'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
new file mode 100755
index 0000000000..44804113cf
--- /dev/null
+++ b/tests/functional/test_migration.py
@@ -0,0 +1,100 @@
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
+
+import tempfile
+import os
+import time
+
+from qemu_test import QemuSystemTest, skipIfMissingCommands
+from qemu_test.ports import Ports
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
+    def select_machine(self):
+        target_machine = {
+            'aarch64': 'quanta-gsj',
+            'alpha': 'clipper',
+            'arm': 'npcm750-evb',
+            'i386': 'isapc',
+            'ppc': 'sam460ex',
+            'ppc64': 'mac99',
+            'riscv32': 'spike',
+            'riscv64': 'virt',
+            'sparc': 'SS-4',
+            'sparc64': 'sun4u',
+            'x86_64': 'microvm',
+        }
+        self.set_machine(target_machine[self.arch])
+
+    def do_migrate(self, dest_uri, src_uri=None):
+        self.select_machine()
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
+    @skipIfMissingCommands('nc')
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
2.48.1


