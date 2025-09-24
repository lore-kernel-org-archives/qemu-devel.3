Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F1CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JB5-0002WY-Bd; Wed, 24 Sep 2025 02:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAz-0002VA-TF
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAn-0006ij-8c
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cra9zw9E61ZQuqs9X2i6vWMUzXd/zJoGyGD5QZWITZ8=;
 b=YIFs08BevjGGJeT6rTS2Jti8t9k1h3gQkKswdGdT8uIfeOpJ/MIlBLjCE7boSvzMWYn3Nt
 Foy5l/U4K7ivpXpknwCPOW41zSbTpD1pm9EzNHU7vSAR/UGq1lNwBR/0lcg69AakwqKigK
 lx3Y1SbeJyCTIwvbiRPR7fBeVBEg5kY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-iadS3DW7P-6bDcC1T5E9Wg-1; Wed,
 24 Sep 2025 02:40:10 -0400
X-MC-Unique: iadS3DW7P-6bDcC1T5E9Wg-1
X-Mimecast-MFC-AGG-ID: iadS3DW7P-6bDcC1T5E9Wg_1758696010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8C7118004D4; Wed, 24 Sep 2025 06:40:09 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9C9C1955F19; Wed, 24 Sep 2025 06:40:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/12] tests/functional: Use vmstate-static-checker.py to test
 data from v7.2
Date: Wed, 24 Sep 2025 08:39:50 +0200
Message-ID: <20250924063956.519792-7-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We've got this nice vmstate-static-checker.py script that can help to
detect screw-ups in the migration states. Unfortunately, it's currently
only run manually, which can be cumbersome. Let's run it from a functional
test automatically with the reference data from QEMU 7.2, so that we get
at least a basic coverage here. Since the test can fail when the checker
script detects a false positive, mark the test with a skipFlakyTest
decorator for now, so that it is only run when the user also set the
QEMU_TEST_FLAKY_TESTS environment variable.

Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250912100755.316518-5-thuth@redhat.com>
---
 MAINTAINERS                              |  1 +
 tests/functional/aarch64/meson.build     |  1 +
 tests/functional/generic/test_vmstate.py | 67 ++++++++++++++++++++++++
 tests/functional/m68k/meson.build        |  4 ++
 tests/functional/ppc64/meson.build       |  1 +
 tests/functional/s390x/meson.build       |  4 ++
 tests/functional/x86_64/meson.build      |  3 +-
 7 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/generic/test_vmstate.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 24c061aff35..3d1f88a4bbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3613,6 +3613,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/functional/migration.py
 F: tests/functional/*/*migration.py
+F: tests/functional/generic/test_vmstate.py
 F: tests/functional/x86_64/test_bad_vmstate.py
 F: tests/data/vmstate-static-checker/
 F: tests/qtest/migration/
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 04846c6eb18..5ad52f93e1d 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -19,6 +19,7 @@ test_aarch64_timeouts = {
 
 tests_aarch64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_aarch64_system_thorough = [
diff --git a/tests/functional/generic/test_vmstate.py b/tests/functional/generic/test_vmstate.py
new file mode 100755
index 00000000000..387ff542426
--- /dev/null
+++ b/tests/functional/generic/test_vmstate.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+'''This test runs the vmstate-static-checker script with the current QEMU'''
+
+import subprocess
+
+from qemu_test import QemuSystemTest, skipFlakyTest
+
+
+@skipFlakyTest("vmstate-static-checker can produce false positives")
+class VmStateTest(QemuSystemTest):
+    '''
+    This test helps to check whether there are problems between old
+    reference data and the current QEMU
+    '''
+
+    def test_vmstate_7_2(self):
+        '''Check reference data from QEMU v7.2'''
+
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
+        self.log.info('Dumping vmstate from %s', self.qemu_bin)
+        cp = subprocess.run([self.qemu_bin, '-nodefaults',
+                             '-M', target_machine[self.arch],
+                             '-dump-vmstate', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True, check=True)
+        if cp.stdout:
+            self.log.info('QEMU output: %s', cp.stdout)
+
+        # Check whether the old vmstate json file is still compatible:
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  self.arch,
+                                  target_machine[self.arch] + '.json')
+        self.log.info('Comparing vmstate with %s', src_json)
+        checkerscript = self.data_file('..', '..', 'scripts',
+                                       'vmstate-static-checker.py')
+        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True, check=False)
+        if cp.returncode != 0:
+            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout +
+                      '\nThis either means that there is a migration bug '
+                      'that needs to be fixed, or\nvmstate-static-checker.py '
+                      'needs to be improved (e.g. extend the changed_names\n'
+                      'in case a field has been renamed), or drop the '
+                      'problematic field from\n' + src_json +
+                      '\nin case the script cannot be fixed easily.')
+        if cp.stdout:
+            self.log.warning('vmstate-static-checker output: %s', cp.stdout)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/meson.build
index e29044a6d73..679faaf86d6 100644
--- a/tests/functional/m68k/meson.build
+++ b/tests/functional/m68k/meson.build
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+tests_m68k_system_quick = [
+  'vmstate',
+]
+
 tests_m68k_system_thorough = [
   'mcf5208evb',
   'nextcube',
diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index 842fe0fc715..1fa0a70f7ed 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -11,6 +11,7 @@ test_ppc64_timeouts = {
 
 tests_ppc64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_ppc64_system_thorough = [
diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index 030b116039c..70cd36e2913 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -4,6 +4,10 @@ test_s390x_timeouts = {
   'ccw_virtio' : 420,
 }
 
+tests_s390x_system_quick = [
+  'vmstate',
+]
+
 tests_s390x_system_thorough = [
   'ccw_virtio',
   'pxelinux',
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index ef12ac43b37..967426c30c3 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -14,10 +14,11 @@ tests_x86_64_system_quick = [
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
+  'memlock',
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
-  'memlock',
+  'vmstate',
 ]
 
 tests_x86_64_system_thorough = [
-- 
2.51.0


