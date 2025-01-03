Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7791E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTcL7-0006iC-HJ; Fri, 03 Jan 2025 02:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTcL4-0006hh-Bm
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 02:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTcL2-0004Yj-Ch
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 02:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735890198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RkJ/ZGq5VsZXTybfL8qsCjEPpazv8Z7wPf9S/sciRA8=;
 b=P9Mu/j8EyT7h1pKywJ7B3FwV+9sMqHG6+eHnIrVOSMPahcgjOsUdAtiCDkzosYSNM8n06Z
 5yytevHcq+WoAgxvUfzTQTtY3uaGVaQyLyHuT1Ts+bLl+NZd0ZVrMSIxuT63SOqNq3BRrG
 W3CzAMSIjUyqyXp620xby3lFSgE+MR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-1IchaT-hPruBquzH9I1veA-1; Fri,
 03 Jan 2025 02:43:14 -0500
X-MC-Unique: 1IchaT-hPruBquzH9I1veA-1
X-Mimecast-MFC-AGG-ID: 1IchaT-hPruBquzH9I1veA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F2471956088; Fri,  3 Jan 2025 07:43:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.153])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B8B319560A2; Fri,  3 Jan 2025 07:43:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3] tests/functional: Convert the migration avocado test
Date: Fri,  3 Jan 2025 08:43:08 +0100
Message-ID: <20250103074308.463860-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

Now that we've got a find_free_port() function in the functional
test framework, we can convert the migration test, too.
While the original avocado test was only meant to run on aarch64,
ppc64 and x86, we can turn this into a more generic test by now
and run it on all architectures that have a machine which ships
with a working firmware. To avoid overlapping with the migration
qtest, we now also test migration on machines that are not covered
by the migration qtest yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Migrate machines that are not covered by the qtest yet

 MAINTAINERS                                   |   1 +
 tests/functional/meson.build                  |  32 +++++
 .../test_migration.py}                        | 135 +++++++-----------
 3 files changed, 83 insertions(+), 85 deletions(-)
 rename tests/{avocado/migration.py => functional/test_migration.py} (41%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c9d5dbc73..045eb206bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3449,6 +3449,7 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
+F: tests/functional/test_migration.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 781bd7eae6..7974814d6b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -57,6 +57,10 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
+tests_aarch64_system_quick = [
+  'migration',
+]
+
 tests_aarch64_system_thorough = [
   'aarch64_aspeed',
   'aarch64_raspi3',
@@ -70,10 +74,18 @@ tests_aarch64_system_thorough = [
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
@@ -105,6 +117,10 @@ tests_avr_system_thorough = [
   'avr_mega2560',
 ]
 
+tests_i386_system_quick = [
+  'migration',
+]
+
 tests_i386_system_thorough = [
   'i386_tuxrun',
 ]
@@ -153,6 +169,7 @@ tests_or1k_system_thorough = [
 ]
 
 tests_ppc_system_quick = [
+  'migration',
   'ppc_74xx',
 ]
 
@@ -167,6 +184,10 @@ tests_ppc_system_thorough = [
   'ppc_virtex_ml507',
 ]
 
+tests_ppc64_system_quick = [
+  'migration',
+]
+
 tests_ppc64_system_thorough = [
   'ppc64_e500',
   'ppc64_hv',
@@ -176,6 +197,7 @@ tests_ppc64_system_thorough = [
 ]
 
 tests_riscv32_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -184,6 +206,7 @@ tests_riscv32_system_thorough = [
 ]
 
 tests_riscv64_system_quick = [
+  'migration',
   'riscv_opensbi',
 ]
 
@@ -210,10 +233,18 @@ tests_sh4eb_system_thorough = [
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
@@ -222,6 +253,7 @@ tests_sparc64_system_thorough = [
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
index be6234b3c2..44804113cf
--- a/tests/avocado/migration.py
+++ b/tests/functional/test_migration.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Migration test
 #
 # Copyright (c) 2019 Red Hat, Inc.
@@ -12,19 +14,12 @@
 
 import tempfile
 import os
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
 
@@ -33,103 +28,73 @@ def migration_finished(vm):
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
     def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri)
+        self.select_machine()
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
+    @skipIfMissingCommands('nc')
     def test_migration_with_exec(self):
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


