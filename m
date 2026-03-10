Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A242FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4p-000723-44; Tue, 10 Mar 2026 01:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4i-0006vy-GG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4g-0006Fn-AY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8111Z95vjiNS3KH7D0G5EqTmKVt2OguTKCPAtweNU4A=;
 b=dpvBVxp3+Ik6KS4x9t4NSVERelWJ7lLQ4+RJPXT9na1pDCeo0Z+yyFT3qrjY9UC2c5MJpN
 E7p+6fepiuqBI+FZob90V9qVeszrwa+GMjutEcvDWBXPUOMeX3fR/JttlzjpCek0c2XNzc
 cHRcfyQDZSviuNnDepZBVNoIrQkTl3g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-TA2DeI9UMe-EcdhVirfCwQ-1; Tue,
 10 Mar 2026 01:56:06 -0400
X-MC-Unique: TA2DeI9UMe-EcdhVirfCwQ-1
X-Mimecast-MFC-AGG-ID: TA2DeI9UMe-EcdhVirfCwQ_1773122165
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D69DF1955DE2; Tue, 10 Mar 2026 05:56:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 407561955D87; Tue, 10 Mar 2026 05:56:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PULL 08/25] tests/functional/ppc64/pseries: Remove custom migration
 routine
Date: Tue, 10 Mar 2026 06:55:13 +0100
Message-ID: <20260310055530.8893-9-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

Don't implement a custom migration routine at PpcMigrationTest and
instead reuse the generic one from MigrationTest.

This removes the dependency of PpcMigrationTest from
PseriesMachine. Having one test import another causes unittest code to
instantiate the imported test, resulting in the setup and teardown
methods being invoked for the imported test class, even if no test
from that class will be executed.

If run in parallel, the extra setup/teardown methods that result from
importing can race with the ones from the actual test being executed
and cause the following error:

File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
shutil.rmtree(self.workdir)
...
FileNotFoundError: [Errno 2] No such file or directory:
'<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'

The PseriesMachine class is changed to inherit from MigrationTest so
both the migration routines and the class attributes of PseriesMachine
can be accessed without the need to instantiate another object.

Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
Reported-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Aditya Gupta <adityag@linux.ibm.com>
Message-ID: <20260303173320.10942-5-farosas@suse.de>
[thuth: Remove superfluous ";" as suggested by Aditya]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/migration.py            |  5 +++++
 tests/functional/ppc64/test_migration.py | 11 -----------
 tests/functional/ppc64/test_pseries.py   | 10 +++++-----
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 49347a30bbf..e995328e833 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -65,6 +65,11 @@ def _get_free_port(self, ports):
             self.skipTest('Failed to find a free port')
         return port
 
+    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
+        with Ports() as ports:
+            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.migrate_vms(uri, uri, dst_vm, src_vm)
+
     def migration_with_tcp_localhost(self):
         with Ports() as ports:
             dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index a3b819680bc..7d49ee175bb 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -22,17 +22,6 @@ def test_migration_with_exec(self):
         self.set_machine('mac99')
         self.migration_with_exec()
 
-    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
-        with Ports() as ports:
-            port = ports.find_free_port()
-            if port is None:
-                self.skipTest('Failed to find a free port')
-            uri = 'tcp:localhost:%u' % port
-
-            dest_vm.qmp('migrate-incoming', uri=uri)
-            source_vm.qmp('migrate', uri=uri)
-            self.assert_migration(source_vm, dest_vm)
-
 
 if __name__ == '__main__':
     MigrationTest.main()
diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index b45763c3050..cb6d25dc816 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -7,11 +7,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import Asset
 from qemu_test import wait_for_console_pattern
-from test_migration import PpcMigrationTest
+from migration import MigrationTest
 
-class PseriesMachine(QemuSystemTest):
+class PseriesMachine(MigrationTest):
 
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
@@ -116,11 +116,11 @@ def test_ppc64_linux_migration(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message,
                                  vm=source_vm)
 
-        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
+        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
 
         # ensure the boot proceeds after migration
         wait_for_console_pattern(self, self.good_message, self.panic_message,
                                  vm=dest_vm)
 
 if __name__ == '__main__':
-    QemuSystemTest.main()
+    MigrationTest.main()
-- 
2.53.0


