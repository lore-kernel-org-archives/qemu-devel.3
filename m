Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5FFE9D41E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngbl-0003tQ-4o; Wed, 04 Feb 2026 12:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngbb-0003qC-Rs
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:57 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngba-0003HJ-C2
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D85465BD01;
 Wed,  4 Feb 2026 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=TmMlVoWO5I0GKuk3UaNqAsCB8RY0HN6H0487kGaXkhACG4ga8RvscUTSIge+3zo0C49WPD
 CwlsEubPrRrkxiZB7NJj6JO2tihCA2EAb3UykNKNMnmYyYtJRLX/kOroT48dFcVexrQqBF
 KUe1YioEJ4luZ5azvtdy7pMktI4Ny8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=/Ngmqjv8vxqIZi5U+GeGptnjbsAppaxPtQ9Uw2V+/SVl7h9d1KAhAf4eMWeBMhFgf0lo3y
 KJ8vzoVUBiUpTADg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RwRrrk8J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HBA2987K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=RwRrrk8JU19e7L3WgSXaJeVonvE7bOB7gqGZhKB7WOWcJRPh3N2+jt/cQw1DexTBS4xj6/
 sZv8dRnkI6kpxiz8SPOVgXInZWD6u9THrGoGQX4MhaqJryvoswq+latfCGv2B5sfgpG1fy
 HAkXrxTWfF/zf7QqLGB62l2XHBi2vSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=HBA2987KeTMMYbbMAZ/9NK3odluVkCCP/rCHE5JJJ0SrdHD168jS+JdP50KI1dH5gbIo8C
 I5wfWZjUC0QoFZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D5A3EA64;
 Wed,  4 Feb 2026 17:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GFmOBZuAg2nQNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Feb 2026 17:23:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 2/4] tests/functional/migration: Add migrate_vms
Date: Wed,  4 Feb 2026 14:23:30 -0300
Message-ID: <20260204172332.21367-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204172332.21367-1-farosas@suse.de>
References: <20260204172332.21367-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D85465BD01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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


