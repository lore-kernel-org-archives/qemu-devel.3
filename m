Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166C2EDA6BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTct-0001EO-W1; Tue, 03 Mar 2026 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTcs-0001E9-L4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTcr-0005zJ-2z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8EF225BE1F;
 Tue,  3 Mar 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WcV0PqlqfUEbE/2ZP05IU9XqI8F/KE5MB+/YpgS/hg=;
 b=rlqL/hUHmsJ/SYTtI1KgXx8rU2fp9jlrs+yXzbMMhcCcH4vDWNkWLwFIMwfmSjQ0+WA9op
 wU/HDziy42EkQsKlwB3qRkty4GpoFzuumBaBS1eG6qkuRCCLOz1wW9Bx5FcZRS6s3srLBY
 rlw0TWJLvFIuO6kAdNHOYW4eHXyG2bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WcV0PqlqfUEbE/2ZP05IU9XqI8F/KE5MB+/YpgS/hg=;
 b=IXA5veBcLELuVeyVLyx6ox9jGu5o+0moVhesEydvZSZtIuSsMM5zuCg9Fh/e5zDAVdYFwq
 89l3qtfZQJTS4jCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rlqL/hUH";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IXA5veBc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WcV0PqlqfUEbE/2ZP05IU9XqI8F/KE5MB+/YpgS/hg=;
 b=rlqL/hUHmsJ/SYTtI1KgXx8rU2fp9jlrs+yXzbMMhcCcH4vDWNkWLwFIMwfmSjQ0+WA9op
 wU/HDziy42EkQsKlwB3qRkty4GpoFzuumBaBS1eG6qkuRCCLOz1wW9Bx5FcZRS6s3srLBY
 rlw0TWJLvFIuO6kAdNHOYW4eHXyG2bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WcV0PqlqfUEbE/2ZP05IU9XqI8F/KE5MB+/YpgS/hg=;
 b=IXA5veBcLELuVeyVLyx6ox9jGu5o+0moVhesEydvZSZtIuSsMM5zuCg9Fh/e5zDAVdYFwq
 89l3qtfZQJTS4jCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEC193EA69;
 Tue,  3 Mar 2026 17:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SCZVKGcbp2n+VAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 17:33:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com
Subject: [PATCH v4 2/4] tests/functional/migration: Add migrate_vms
Date: Tue,  3 Mar 2026 14:33:18 -0300
Message-ID: <20260303173320.10942-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303173320.10942-1-farosas@suse.de>
References: <20260303173320.10942-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Queue-Id: 8EF225BE1F
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

Add a migration helper to MigrationTest that uses the migrate-incoming
QMP commmand and takes the already instantiated VMs. The -incoming
'defer' command line option is preferred way instead of the -incoming
URI syntax that's currently used.

Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 0aa873edba..3362e5c743 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -40,6 +40,11 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
+    def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
+        dst_vm.qmp('migrate-incoming', uri=dst_uri)
+        src_vm.qmp('migrate', uri=src_uri)
+        self.assert_migration(src_vm, dst_vm)
+
     def do_migrate(self, dest_uri, src_uri=None):
         dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
         dest_vm.add_args('-nodefaults')
-- 
2.51.0


