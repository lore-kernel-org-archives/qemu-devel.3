Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C42CEC1449
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQ2v-0003NK-O8; Tue, 03 Mar 2026 08:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ2r-0003Mm-LX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ2p-0001NQ-Gx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 234143F1F6;
 Tue,  3 Mar 2026 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mxjeLUJszQMmJ1r35bQr9hxExQvM5gWxQasZu3M05Es=;
 b=xUAh6JksFPIk7zzpdXwz5JzZT+RzLtpoIY28kfEY9RxZpiJVnwlmW1Wrpjh2ysjwitlvYO
 4kr1HF4z6n5qpjXOsr2LOyeBxcQNDexoVdhLLhKTmwn824QUX8dTmvZCegYOTMSAdTP2R1
 m10mW2UsNvWO2DVVpmBFv+2pRVNrfKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mxjeLUJszQMmJ1r35bQr9hxExQvM5gWxQasZu3M05Es=;
 b=aVPMlMFg/hc2W1r8lPYWWYshVbUYFcsu5byZqG++SbJ9MJ1DMzv1V8InQdhCUtCEZw8AOY
 O8/zNr6n+/p37dAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mxjeLUJszQMmJ1r35bQr9hxExQvM5gWxQasZu3M05Es=;
 b=xUAh6JksFPIk7zzpdXwz5JzZT+RzLtpoIY28kfEY9RxZpiJVnwlmW1Wrpjh2ysjwitlvYO
 4kr1HF4z6n5qpjXOsr2LOyeBxcQNDexoVdhLLhKTmwn824QUX8dTmvZCegYOTMSAdTP2R1
 m10mW2UsNvWO2DVVpmBFv+2pRVNrfKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mxjeLUJszQMmJ1r35bQr9hxExQvM5gWxQasZu3M05Es=;
 b=aVPMlMFg/hc2W1r8lPYWWYshVbUYFcsu5byZqG++SbJ9MJ1DMzv1V8InQdhCUtCEZw8AOY
 O8/zNr6n+/p37dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F26D83EA69;
 Tue,  3 Mar 2026 13:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6OkZLZ/lpmlXYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 13:43:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v3 4/5] tests/functional/ppc64/pseries: Inherit from
 MigrationTest
Date: Tue,  3 Mar 2026 10:43:47 -0300
Message-ID: <20260303134348.8890-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303134348.8890-1-farosas@suse.de>
References: <20260303134348.8890-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Make the PseriesMachine class inherit from MigrationTest so the next
patch can access migration routines without needing to instantiate a
MigrationTest object. This is just for cleanliness of the code.

Note that creating a separate class for migration wouldn't work quite
well because the class attributes of PseriesMachine would then have to
be exposed to that class somehow.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/ppc64/test_pseries.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index b45763c305..ce39e16a22 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -11,7 +11,7 @@
 from qemu_test import wait_for_console_pattern
 from test_migration import PpcMigrationTest
 
-class PseriesMachine(QemuSystemTest):
+class PseriesMachine(MigrationTest):
 
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
@@ -116,11 +116,11 @@ def test_ppc64_linux_migration(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message,
                                  vm=source_vm)
 
-        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
+        self.do_migrate_ppc64_linux(source_vm, dest_vm);
 
         # ensure the boot proceeds after migration
         wait_for_console_pattern(self, self.good_message, self.panic_message,
                                  vm=dest_vm)
 
 if __name__ == '__main__':
-    QemuSystemTest.main()
+    MigrationTest.main()
-- 
2.51.0


