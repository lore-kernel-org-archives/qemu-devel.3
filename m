Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D02CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUzN-00087c-1o; Tue, 19 Aug 2025 18:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzL-00086G-Ss
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzK-00085D-7F
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A8D71F76B;
 Tue, 19 Aug 2025 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Q+vHJrkoIS5nodu487oIR3vGFuAoT1ZNVE6THVqGA=;
 b=gIRCsKMpxIGeL9LLrZIoUHzjUnJLDX0KNEwpG4hx9iny8gDxQjrlsQstt9pVAikTFF+WEF
 sPD268Vsr5L+YPS2BUFFlK8ODmvMdSDASdjUl9Ku5WJXPHLgtbtiYUF3vq+jfup1xC/f2E
 SqExgmLisK/Zjx+ntS2gnkUE0YgReUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Q+vHJrkoIS5nodu487oIR3vGFuAoT1ZNVE6THVqGA=;
 b=vzqL3KjzeA08k68zr8lVWgT+7ncHgYXsW6gkQM9l+0j75oQ3D9/tYSLLu/nJJTePyoIzto
 aBDQEr9DBq79DSDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Q+vHJrkoIS5nodu487oIR3vGFuAoT1ZNVE6THVqGA=;
 b=gIRCsKMpxIGeL9LLrZIoUHzjUnJLDX0KNEwpG4hx9iny8gDxQjrlsQstt9pVAikTFF+WEF
 sPD268Vsr5L+YPS2BUFFlK8ODmvMdSDASdjUl9Ku5WJXPHLgtbtiYUF3vq+jfup1xC/f2E
 SqExgmLisK/Zjx+ntS2gnkUE0YgReUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Q+vHJrkoIS5nodu487oIR3vGFuAoT1ZNVE6THVqGA=;
 b=vzqL3KjzeA08k68zr8lVWgT+7ncHgYXsW6gkQM9l+0j75oQ3D9/tYSLLu/nJJTePyoIzto
 aBDQEr9DBq79DSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD8AB139B3;
 Tue, 19 Aug 2025 22:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yP1YBBn9pGh+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 22:39:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Fabian Vogt <fvogt@suse.de>, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH 3/4] tests/functional: Add a OS level migration test for
 pseries
Date: Tue, 19 Aug 2025 19:39:04 -0300
Message-Id: <20250819223905.2247-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819223905.2247-1-farosas@suse.de>
References: <20250819223905.2247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de,linux.ibm.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
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

There's currently no OS level test for ppc64le. Add one such test by
reusing the boot level tests that are already present.

The test boots the source machine, waits for it to reach a mid-boot
message, migrates and checks that the destination has reached the
final boot message (VFS error due to no disk).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/test_ppc64_pseries.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
index 67057934e8..7a7e0fe8ae 100755
--- a/tests/functional/test_ppc64_pseries.py
+++ b/tests/functional/test_ppc64_pseries.py
@@ -9,6 +9,8 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test.migration import Migration
+from qemu_test.ports import Ports
 
 class pseriesMachine(QemuSystemTest):
 
@@ -87,5 +89,44 @@ def test_ppc64_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_ppc64_linux_migration(self):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            if port is None:
+                self.skipTest('Failed to find a free port')
+        uri = 'tcp:localhost:%u' % port
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+
+        self.set_machine('pseries')
+
+        dest_vm = self.get_vm('-incoming', uri, name="dest-qemu")
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
+        Migration().migrate(self, source_vm, dest_vm, uri, self.timeout)
+
+        # ensure the boot proceeds after migration
+        wait_for_console_pattern(self, self.good_message, self.panic_message,
+                                 vm=dest_vm)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.35.3


