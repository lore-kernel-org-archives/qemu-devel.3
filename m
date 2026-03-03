Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA35E67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTd6-0001G1-Sx; Tue, 03 Mar 2026 12:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTd5-0001FT-25
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:55 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTd3-00060Y-D8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD245BE36;
 Tue,  3 Mar 2026 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gCVtxbnn4iRgePjKTQ1hJ/mu2MP3mYjXwHWt4TlNvw=;
 b=m1Ae1jmDtYpxKbi66MLLo7vyr3y4a0VKmdAr+IhcZgZ8s/RUl+tq9JS2uRPUdPTrzZIp+r
 M7MHFm5pI/0trnkETxZ/sRScS9k2QEalLKXYcy/wfBD1lk3L0d3a+HcH3DhiGI54hS48qs
 f5AmnmbhZyNspqDVH8B+xntCoj6kRMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gCVtxbnn4iRgePjKTQ1hJ/mu2MP3mYjXwHWt4TlNvw=;
 b=yOrt2qKaPHLJFIFFuXD51fFcwxVc2O8r5Gks6FEQm3p9/e9PU9yo/9rZWxPN8eMZ/tVu0W
 8xm3XwfZWBhJgjAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gCVtxbnn4iRgePjKTQ1hJ/mu2MP3mYjXwHWt4TlNvw=;
 b=m1Ae1jmDtYpxKbi66MLLo7vyr3y4a0VKmdAr+IhcZgZ8s/RUl+tq9JS2uRPUdPTrzZIp+r
 M7MHFm5pI/0trnkETxZ/sRScS9k2QEalLKXYcy/wfBD1lk3L0d3a+HcH3DhiGI54hS48qs
 f5AmnmbhZyNspqDVH8B+xntCoj6kRMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gCVtxbnn4iRgePjKTQ1hJ/mu2MP3mYjXwHWt4TlNvw=;
 b=yOrt2qKaPHLJFIFFuXD51fFcwxVc2O8r5Gks6FEQm3p9/e9PU9yo/9rZWxPN8eMZ/tVu0W
 8xm3XwfZWBhJgjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEEC3EA69;
 Tue,  3 Mar 2026 17:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBxOAGwbp2n+VAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 17:33:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 4/4] tests/functional/ppc64/pseries: Remove custom
 migration routine
Date: Tue,  3 Mar 2026 14:33:20 -0300
Message-ID: <20260303173320.10942-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303173320.10942-1-farosas@suse.de>
References: <20260303173320.10942-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 tests/functional/migration.py            |  5 +++++
 tests/functional/ppc64/test_migration.py | 11 -----------
 tests/functional/ppc64/test_pseries.py   | 10 +++++-----
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 49347a30bb..e995328e83 100644
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
index a3b819680b..7d49ee175b 100755
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
index b45763c305..b28292233d 100755
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
+        self.migration_with_tcp_localhost_vms(dest_vm, source_vm);
 
         # ensure the boot proceeds after migration
         wait_for_console_pattern(self, self.good_message, self.panic_message,
                                  vm=dest_vm)
 
 if __name__ == '__main__':
-    QemuSystemTest.main()
+    MigrationTest.main()
-- 
2.51.0


