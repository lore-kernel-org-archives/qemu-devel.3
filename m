Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDF8CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUzI-00084C-7w; Tue, 19 Aug 2025 18:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzG-00083u-CK
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzE-00084S-LS
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE7671F785;
 Tue, 19 Aug 2025 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qof2tviqk9/UtEZ8Cs0/3hHezkIEH6rDjKvvD3EJJlM=;
 b=LDS1Wp3akw76WKkVcOsAk0nSaBRnA2CTLuihJ6sstOoB44I3I21CSyxYk6NZ7Ctnp60z//
 MEEyQxAwHHHdCkLQp0P8SqOejjwByBzuVgsx7ub5Vo0KsV9VN8Ui71QMHcy7CHG8HGYBka
 NUI641Sx66J0LOBng67ViVmMqZxGk/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qof2tviqk9/UtEZ8Cs0/3hHezkIEH6rDjKvvD3EJJlM=;
 b=4I73zOc1lM3xymIZSEGKhWCSiSJkMW1giNtbayU2ZWoRZX2SHdLhT80rPw2JjtoJZajZxZ
 Abn7CXey3zLB8JCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qof2tviqk9/UtEZ8Cs0/3hHezkIEH6rDjKvvD3EJJlM=;
 b=LDS1Wp3akw76WKkVcOsAk0nSaBRnA2CTLuihJ6sstOoB44I3I21CSyxYk6NZ7Ctnp60z//
 MEEyQxAwHHHdCkLQp0P8SqOejjwByBzuVgsx7ub5Vo0KsV9VN8Ui71QMHcy7CHG8HGYBka
 NUI641Sx66J0LOBng67ViVmMqZxGk/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qof2tviqk9/UtEZ8Cs0/3hHezkIEH6rDjKvvD3EJJlM=;
 b=4I73zOc1lM3xymIZSEGKhWCSiSJkMW1giNtbayU2ZWoRZX2SHdLhT80rPw2JjtoJZajZxZ
 Abn7CXey3zLB8JCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6060139B3;
 Tue, 19 Aug 2025 22:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AK8IIBX9pGh+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 22:39:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Fabian Vogt <fvogt@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 2/4] tests/functional: Extract migration code into a new
 class
Date: Tue, 19 Aug 2025 19:39:03 -0300
Message-Id: <20250819223905.2247-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819223905.2247-1-farosas@suse.de>
References: <20250819223905.2247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de,linaro.org];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move some of the code from test_migration.py to a new class so it can
be reused to invoke migrations from other tests.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
I see this conflicts with Thomas' series, I'll update accordingly.
---
 tests/functional/qemu_test/migration.py | 40 +++++++++++++++++++++++++
 tests/functional/test_migration.py      | 24 ++-------------
 2 files changed, 43 insertions(+), 21 deletions(-)
 create mode 100644 tests/functional/qemu_test/migration.py

diff --git a/tests/functional/qemu_test/migration.py b/tests/functional/qemu_test/migration.py
new file mode 100644
index 0000000000..37988704e8
--- /dev/null
+++ b/tests/functional/qemu_test/migration.py
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+import time
+
+
+class Migration():
+
+    @staticmethod
+    def migration_finished(vm):
+        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
+
+    def assert_migration(self, test, src_vm, dst_vm, timeout):
+
+        end = time.monotonic() + timeout
+        while time.monotonic() < end and not self.migration_finished(src_vm):
+           time.sleep(0.1)
+
+        end = time.monotonic() + timeout
+        while time.monotonic() < end and not self.migration_finished(dst_vm):
+           time.sleep(0.1)
+
+        test.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
+        test.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
+        test.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
+        test.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
+
+    def migrate(self, test, source_vm, dest_vm, src_uri, timeout):
+        source_vm.qmp('migrate', uri=src_uri)
+        self.assert_migration(test, source_vm, dest_vm, timeout)
diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
index c4393c3543..1c75a98330 100755
--- a/tests/functional/test_migration.py
+++ b/tests/functional/test_migration.py
@@ -15,6 +15,7 @@
 import time
 
 from qemu_test import QemuSystemTest, skipIfMissingCommands
+from qemu_test.migration import Migration
 from qemu_test.ports import Ports
 
 
@@ -22,25 +23,6 @@ class MigrationTest(QemuSystemTest):
 
     timeout = 10
 
-    @staticmethod
-    def migration_finished(vm):
-        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
-
-    def assert_migration(self, src_vm, dst_vm):
-
-        end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(src_vm):
-           time.sleep(0.1)
-
-        end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(dst_vm):
-           time.sleep(0.1)
-
-        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
-        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
-
     def select_machine(self):
         target_machine = {
             'aarch64': 'quanta-gsj',
@@ -67,8 +49,8 @@ def do_migrate(self, dest_uri, src_uri=None):
         source_vm = self.get_vm(name="source-qemu")
         source_vm.add_args('-nodefaults')
         source_vm.launch()
-        source_vm.qmp('migrate', uri=src_uri)
-        self.assert_migration(source_vm, dest_vm)
+
+        Migration().migrate(self, source_vm, dest_vm, src_uri, self.timeout)
 
     def _get_free_port(self, ports):
         port = ports.find_free_port()
-- 
2.35.3


