Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB086D3F072
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6XK-0004wr-Ba; Wed, 28 Jan 2026 09:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl6XI-0004vb-GK
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:28:48 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl6XG-0007gU-Ug
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:28:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D62F5BD14;
 Wed, 28 Jan 2026 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769610516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDTtHa40j/P3o6S0ju27l96SaA0nACs2eNXxhQVa6A4=;
 b=QtDrTW/FkeSGo6Se11srPqRjRo2cjGcq84sYR4Aj3RQddNweYVXC3djtn9pUI3/W/siX6x
 LM7YRhiXs9Z+zObE9JKL0/tdhSY+DUfVK4DOwjKMnM48QVKqJ0e24JC9/z2cfoOLib2RtQ
 mkeQeM0xWVuWbe0w4UNXp+u3Ckdgm8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769610516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDTtHa40j/P3o6S0ju27l96SaA0nACs2eNXxhQVa6A4=;
 b=ZqmZn3vLuz9fgGGk52h4hdpqp2VuVtZGYbjv2NpDQXWqsBYuHgvvqvXwv9eYoljDFRrgB2
 VPCOmhvh2VCt72Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769610516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDTtHa40j/P3o6S0ju27l96SaA0nACs2eNXxhQVa6A4=;
 b=QtDrTW/FkeSGo6Se11srPqRjRo2cjGcq84sYR4Aj3RQddNweYVXC3djtn9pUI3/W/siX6x
 LM7YRhiXs9Z+zObE9JKL0/tdhSY+DUfVK4DOwjKMnM48QVKqJ0e24JC9/z2cfoOLib2RtQ
 mkeQeM0xWVuWbe0w4UNXp+u3Ckdgm8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769610516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDTtHa40j/P3o6S0ju27l96SaA0nACs2eNXxhQVa6A4=;
 b=ZqmZn3vLuz9fgGGk52h4hdpqp2VuVtZGYbjv2NpDQXWqsBYuHgvvqvXwv9eYoljDFRrgB2
 VPCOmhvh2VCt72Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F45C3EA61;
 Wed, 28 Jan 2026 14:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFJ3OBIdemlFfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 14:28:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/3] tests/functional/migration: Accept vm objects in
 do_migrate
Date: Wed, 28 Jan 2026 11:28:28 -0300
Message-ID: <20260128142829.25326-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128142829.25326-1-farosas@suse.de>
References: <20260128142829.25326-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Allow MigrationTest.do_migrate() to receive objects for virtual
machines already created. This will allow MigrationTest to provide the
migration functionality for tests that are defined in a separate
module and require extra setup (e.g. arch-specific) to the virtual
machines before migration.

The next patches will instantiate MigrationTest from another test
class.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 0aa873edba..ac6feeeefb 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -40,15 +40,22 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
-    def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
-        dest_vm.add_args('-nodefaults')
-        dest_vm.launch()
+    def do_migrate(self, dest_uri, src_uri=None, source_vm=None, dest_vm=None):
+        if dest_vm:
+            dest_vm.qmp('migrate-incoming', uri=dest_uri)
+        else:
+            dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
+            dest_vm.add_args('-nodefaults')
+            dest_vm.launch()
+
+        if not source_vm:
+            source_vm = self.get_vm(name="source-qemu")
+            source_vm.add_args('-nodefaults')
+            source_vm.launch()
+
         if src_uri is None:
             src_uri = dest_uri
-        source_vm = self.get_vm(name="source-qemu")
-        source_vm.add_args('-nodefaults')
-        source_vm.launch()
+
         source_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(source_vm, dest_vm)
 
-- 
2.51.0


