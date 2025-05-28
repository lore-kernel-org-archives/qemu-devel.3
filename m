Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155F2C5B543
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFZ8-00072i-Co; Wed, 28 May 2025 08:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKFY0-0006uk-SM
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKFXu-0002kf-B2
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748433966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6i7N1qen80LATr5qZwEDcNGIzwEXEPF8/H1sAgto9Q=;
 b=OqSMZnLsn8KA+UxKj2K6RymreV/QmOl2gQ0UBOomOgIOk/ReTO61RgbZNQv+V6AgEdAS61
 F89KGnu7yid+yE4v4ycFOOkz5Gu2TBcjYU1UPnh+c8esTlgOHQo0IwO7fZ7ZuJmWSjbMNO
 vd9JNpfXoAQvYso9iw1oFhNkDINekNA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-3KcPhWWqOTuZICkVecByUA-1; Wed,
 28 May 2025 07:59:33 -0400
X-MC-Unique: 3KcPhWWqOTuZICkVecByUA-1
X-Mimecast-MFC-AGG-ID: 3KcPhWWqOTuZICkVecByUA_1748433572
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC8D818002A5; Wed, 28 May 2025 11:59:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CFAC180049D; Wed, 28 May 2025 11:59:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 3/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Date: Wed, 28 May 2025 13:59:13 +0200
Message-ID: <20250528115914.330994-4-thuth@redhat.com>
In-Reply-To: <20250528115914.330994-1-thuth@redhat.com>
References: <20250528115914.330994-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We've got this nice vmstate-static-checker.py script that can help
to detect screw-ups in the migration states. Unfortunately, it's
currently only run manually, which can be cumbersome. Let's run it
from a functional test automatically so that we get at least a
basic coverage here. Since the test can fail when the checker script
detects a false positive, mark the test with a skipFlakyTest decorator
for now, so that it is only run when the user also set the
QEMU_TEST_FLAKY_TESTS environment variable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                      |  1 +
 tests/functional/meson.build     | 13 ++++++-
 tests/functional/test_vmstate.py | 66 ++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_vmstate.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 55735de4e4e..e92c60f891d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3548,6 +3548,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/data/vmstate-static-checker/
 F: tests/functional/test_migration.py
+F: tests/functional/test_vmstate.py
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
 F: docs/devel/migration/
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe8..81fc26ca3d5 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -78,6 +78,7 @@ tests_generic_bsduser = [
 
 tests_aarch64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_aarch64_system_thorough = [
@@ -168,6 +169,10 @@ tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
 
+tests_m68k_system_quick = [
+  'vmstate',
+]
+
 tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
@@ -234,6 +239,7 @@ tests_ppc_system_thorough = [
 
 tests_ppc64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_ppc64_system_thorough = [
@@ -269,6 +275,10 @@ tests_rx_system_thorough = [
   'rx_gdbsim',
 ]
 
+tests_s390x_system_quick = [
+  'vmstate',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_replay',
@@ -309,8 +319,9 @@ tests_x86_64_system_quick = [
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
-  'x86_cpu_model_versions',
+  'vmstate',
   'vnc',
+  'x86_cpu_model_versions',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
new file mode 100755
index 00000000000..212d854d17c
--- /dev/null
+++ b/tests/functional/test_vmstate.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This test runs the vmstate-static-checker script with the current QEMU
+
+import subprocess
+
+from qemu_test import QemuSystemTest, skipFlakyTest
+
+
+@skipFlakyTest("vmstate-static-checker can produce false positives")
+class VmStateTest(QemuSystemTest):
+
+    def run_vmstate_checker(self, src_json, dst_json):
+        checkerscript = self.data_file('..', '..', 'scripts',
+                                       'vmstate-static-checker.py')
+        return subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
+                              stdout=subprocess.PIPE,
+                              stderr=subprocess.STDOUT,
+                              text=True)
+
+    def test_vmstate_7_2(self):
+        target_machine = {
+            'aarch64': 'virt-7.2',
+            'm68k': 'virt-7.2',
+            'ppc64': 'pseries-7.2',
+            's390x': 's390-ccw-virtio-7.2',
+            'x86_64': 'pc-q35-7.2',
+        }
+        self.set_machine(target_machine[self.arch])
+
+        # Run QEMU to get the current vmstate json file:
+        dst_json = self.scratch_file('dest.json')
+        self.log.info('Dumping vmstate from ' + self.qemu_bin)
+        cp = subprocess.run([self.qemu_bin, '-nodefaults',
+                             '-M', target_machine[self.arch],
+                             '-dump-vmstate', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True)
+        if cp.returncode != 0:
+            self.fail('Running QEMU failed:\n' + cp.stdout)
+        if cp.stdout:
+            self.log.info('QEMU output: ' + cp.stdout)
+
+        # Check whether the old vmstate json file is still compatible:
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  self.arch,
+                                  target_machine[self.arch] + '.json')
+        self.log.info('Comparing vmstate with ' + src_json)
+        cp = self.run_vmstate_checker(src_json, dst_json)
+        if cp.returncode != 0:
+            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout +
+                      '\nThis either means that there is a migration bug '
+                      'that needs to be fixed, or\nvmstate-static-checker.py '
+                      'needs to be improved (e.g. extend the changed_names\n'
+                      'in case a field has been renamed), or drop the '
+                      'problematic field from\n' + src_json +
+                      '\nin case the script cannot be fixed easily.')
+        if cp.stdout:
+            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


