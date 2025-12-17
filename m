Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B4D65C7D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 16:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVufp-0004RI-2L; Wed, 17 Dec 2025 11:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVufG-0004GT-Qx
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:46:17 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVufE-0007Ao-Qj
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:46:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97BEE33694;
 Wed, 17 Dec 2025 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOdX227QL3oWFhXpMwmHJU3UZWXXFN5ORNQ7qNLZu5c=;
 b=iKZdoyM+yLZAEGz/y+SpK74B7C9EJe1uupxk5j6+zkgIE9FFr+KGYxGMUdpsxskgm6kYYP
 fmZw2e3gxO0P3ZJWWOq06pp+BYMUc3LTs96BTlOqUIt4SRdzV1f0w5LQb9Xm7UCzU1OLfx
 x/YfgiF18/TUYPzMiSCRi2dtOgoBB6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOdX227QL3oWFhXpMwmHJU3UZWXXFN5ORNQ7qNLZu5c=;
 b=LPjVNoGLn+0qSvgdgtMGOy5XKa0z+v1IwJGiItg9IEUOj6wWjGhx67E4I1h2FpRyiv9oIw
 W33g0KBjL8tQxhDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iKZdoyM+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LPjVNoGL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOdX227QL3oWFhXpMwmHJU3UZWXXFN5ORNQ7qNLZu5c=;
 b=iKZdoyM+yLZAEGz/y+SpK74B7C9EJe1uupxk5j6+zkgIE9FFr+KGYxGMUdpsxskgm6kYYP
 fmZw2e3gxO0P3ZJWWOq06pp+BYMUc3LTs96BTlOqUIt4SRdzV1f0w5LQb9Xm7UCzU1OLfx
 x/YfgiF18/TUYPzMiSCRi2dtOgoBB6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOdX227QL3oWFhXpMwmHJU3UZWXXFN5ORNQ7qNLZu5c=;
 b=LPjVNoGLn+0qSvgdgtMGOy5XKa0z+v1IwJGiItg9IEUOj6wWjGhx67E4I1h2FpRyiv9oIw
 W33g0KBjL8tQxhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB60A3EA63;
 Wed, 17 Dec 2025 16:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mNPQIkTeQmlyDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Dec 2025 16:45:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/functional: Add a OS level migration test for
 pseries
Date: Wed, 17 Dec 2025 13:45:48 -0300
Message-ID: <20251217164549.4311-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217164549.4311-1-farosas@suse.de>
References: <20251217164549.4311-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 97BEE33694
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.ibm.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There's currently no OS level test for ppc64le. Add one such test by
reusing the boot level tests that are already present.

The test boots the source machine, waits for it to reach a mid-boot
message, migrates and checks that the destination has reached the
final boot message (VFS error due to no disk).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/ppc64/test_migration.py | 12 ++++++++
 tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index 5dfdaaf709..a3b819680b 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -4,6 +4,7 @@
 #
 # ppc migration test
 
+from qemu_test.ports import Ports
 from migration import MigrationTest
 
 
@@ -21,6 +22,17 @@ def test_migration_with_exec(self):
         self.set_machine('mac99')
         self.migration_with_exec()
 
+    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            if port is None:
+                self.skipTest('Failed to find a free port')
+            uri = 'tcp:localhost:%u' % port
+
+            dest_vm.qmp('migrate-incoming', uri=uri)
+            source_vm.qmp('migrate', uri=uri)
+            self.assert_migration(source_vm, dest_vm)
+
 
 if __name__ == '__main__':
     MigrationTest.main()
diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index 7840c4e3ff..e15a8956a5 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -9,6 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
+from test_migration import PpcMigrationTest
 
 class PseriesMachine(QemuSystemTest):
 
@@ -87,5 +88,39 @@ def test_ppc64_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_ppc64_linux_migration(self):
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+
+        self.set_machine('pseries')
+
+        dest_vm = self.get_vm(name="dest-qemu")
+        dest_vm.add_args('-incoming', 'defer')
+        dest_vm.add_args('-smp', '4')
+        dest_vm.add_args('-nodefaults')
+        dest_vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        dest_vm.set_console()
+        dest_vm.launch()
+
+        source_vm = self.get_vm(name="source-qemu")
+        source_vm.add_args('-smp', '4')
+        source_vm.add_args('-nodefaults')
+        source_vm.add_args('-kernel', kernel_path,
+                           '-append', kernel_command_line)
+        source_vm.set_console()
+        source_vm.launch()
+
+        # ensure the boot has reached Linux
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message,
+                                 vm=source_vm)
+
+        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
+
+        # ensure the boot proceeds after migration
+        wait_for_console_pattern(self, self.good_message, self.panic_message,
+                                 vm=dest_vm)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


