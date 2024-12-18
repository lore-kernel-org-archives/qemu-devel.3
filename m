Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900DAE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNttp-0002Ku-OD; Wed, 18 Dec 2024 08:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttX-0002F6-2k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttO-0005St-KO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734527708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rjPuN3IFld4pUl6SnjEFUI6gXUHq4mMQ5h7w8p42HE=;
 b=N4RMihkzFhwVIaJtmAfloT87vvOmgCam+TjCBE3xnp/KhHkM09IDva6hkyfKY6U8wxpyP6
 EJyWEzRAE41ieG3wh4vXAJpmgIODasS6CGZED/QZ3NKumWotw0X+KOWaErZjzhcJ3LW1ya
 9KJhF5N5aGKKlDIYn1t3670EIukI8k8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-ZdyBwAPxM5S0QEwqJqhMAg-1; Wed,
 18 Dec 2024 08:15:05 -0500
X-MC-Unique: ZdyBwAPxM5S0QEwqJqhMAg-1
X-Mimecast-MFC-AGG-ID: ZdyBwAPxM5S0QEwqJqhMAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D0A51955F42; Wed, 18 Dec 2024 13:15:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2662E30044C1; Wed, 18 Dec 2024 13:15:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 5/5] tests/functional: Convert the migration avocado test
Date: Wed, 18 Dec 2024 14:14:39 +0100
Message-ID: <20241218131439.255841-6-thuth@redhat.com>
In-Reply-To: <20241218131439.255841-1-thuth@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Now that we've got a find_free_port() function in the functional
test framework, we can convert the migration test, too.
While the original avocado test was only meant to run on aarch64,
ppc64 and x86, we can turn this into a more generic test by now
and run it on all architectures that have a default machine that
ships with a working firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/meson.build                  |  19 +++
 .../test_migration.py}                        | 121 +++++-------------
 3 files changed, 54 insertions(+), 87 deletions(-)
 rename tests/{avocado/migration.py => functional/test_migration.py} (41%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 389b390de1..704648d57a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3429,6 +3429,7 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
+F: tests/functional/test_migration.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 781bd7eae6..8c3d1c26da 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -70,6 +70,10 @@ tests_aarch64_system_thorough = [
   'multiprocess',
 ]
 
+tests_alpha_system_quick = [
+  'migration',
+]
+
 tests_alpha_system_thorough = [
   'alpha_clipper',
 ]
@@ -167,6 +171,10 @@ tests_ppc_system_thorough = [
   'ppc_virtex_ml507',
 ]
 
+tests_ppc64_system_quick = [
+  'migration',
+]
+
 tests_ppc64_system_thorough = [
   'ppc64_e500',
   'ppc64_hv',
@@ -176,6 +184,7 @@ tests_ppc64_system_thorough = [
 ]
 
 tests_riscv32_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -184,6 +193,7 @@ tests_riscv32_system_thorough = [
 ]
 
 tests_riscv64_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -210,10 +220,18 @@ tests_sh4eb_system_thorough = [
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
@@ -222,6 +240,7 @@ tests_sparc64_system_thorough = [
 tests_x86_64_system_quick = [
   'cpu_queries',
   'mem_addr_space',
+  'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
diff --git a/tests/avocado/migration.py b/tests/functional/test_migration.py
old mode 100644
new mode 100755
similarity index 41%
rename from tests/avocado/migration.py
rename to tests/functional/test_migration.py
index be6234b3c2..5607d601eb
--- a/tests/avocado/migration.py
+++ b/tests/functional/test_migration.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Migration test
 #
 # Copyright (c) 2019 Red Hat, Inc.
@@ -9,22 +11,14 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-
-import tempfile
 import os
+import tempfile
+import time
 
-from avocado_qemu import QemuSystemTest
-from avocado import skipUnless
-
-from avocado.utils.network import ports
-from avocado.utils import wait
-from avocado.utils.path import find_command
-
+from qemu_test import QemuSystemTest, skipIfMissingCommands
+from qemu_test.ports import Ports
 
 class MigrationTest(QemuSystemTest):
-    """
-    :avocado: tags=migration
-    """
 
     timeout = 10
 
@@ -33,103 +27,56 @@ def migration_finished(vm):
         return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
 
     def assert_migration(self, src_vm, dst_vm):
-        wait.wait_for(self.migration_finished,
-                      timeout=self.timeout,
-                      step=0.1,
-                      args=(src_vm,))
-        wait.wait_for(self.migration_finished,
-                      timeout=self.timeout,
-                      step=0.1,
-                      args=(dst_vm,))
+
+        end = time.monotonic() + self.timeout
+        while time.monotonic() < end and not self.migration_finished(src_vm):
+           time.sleep(0.1)
+
+        end = time.monotonic() + self.timeout
+        while time.monotonic() < end and not self.migration_finished(dst_vm):
+           time.sleep(0.1)
+
         self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
     def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri)
+        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
         dest_vm.add_args('-nodefaults')
         dest_vm.launch()
         if src_uri is None:
             src_uri = dest_uri
-        source_vm = self.get_vm()
+        source_vm = self.get_vm(name="source-qemu")
         source_vm.add_args('-nodefaults')
         source_vm.launch()
         source_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(source_vm, dest_vm)
 
-    def _get_free_port(self):
+    def _get_free_port(self, ports):
         port = ports.find_free_port()
         if port is None:
-            self.cancel('Failed to find a free port')
+            self.skipTest('Failed to find a free port')
         return port
 
-    def migration_with_tcp_localhost(self):
-        dest_uri = 'tcp:localhost:%u' % self._get_free_port()
-        self.do_migrate(dest_uri)
+    def test_migration_with_tcp_localhost(self):
+        with Ports() as ports:
+            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.do_migrate(dest_uri)
 
-    def migration_with_unix(self):
+    def test_migration_with_unix(self):
         with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
             dest_uri = 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
 
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
+    @skipIfMissingCommands('nc')
     def test_migration_with_exec(self):
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
2.47.1


