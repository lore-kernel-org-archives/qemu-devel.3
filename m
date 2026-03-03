Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF2EC1449
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQ30-0003OI-59; Tue, 03 Mar 2026 08:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ2x-0003Nj-4t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:23 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ2v-0001Nv-JQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53E6F5BE0E;
 Tue,  3 Mar 2026 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=xbPb3X3R11coKa1QE13cjLmCh/73sOuf4BXlERScjIssQjilgqmReQxBBJZ0Z8+SWKz0bN
 KsWUYqbBA0yVpm5Qx4ywIqGM4zGGZeTHqZuF7VYQwHUdtHr7j/iohnZR3rzg4+5IC6JzYY
 TeQjwA+PGxjvWVEnVoBZLnE8RtZVZrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=74/Tb/TK+7hK/gilL/4cXmy9nsNU5Y8u01NsTd9LDmJCCBcl2MdAci0Flx1Rm/b9mHvW+g
 pfLvQlV29F/e8TDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=xbPb3X3R11coKa1QE13cjLmCh/73sOuf4BXlERScjIssQjilgqmReQxBBJZ0Z8+SWKz0bN
 KsWUYqbBA0yVpm5Qx4ywIqGM4zGGZeTHqZuF7VYQwHUdtHr7j/iohnZR3rzg4+5IC6JzYY
 TeQjwA+PGxjvWVEnVoBZLnE8RtZVZrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK3MqBz7nWHDbJwoF86o05bOuAWFxATe2udVQsxhLeo=;
 b=74/Tb/TK+7hK/gilL/4cXmy9nsNU5Y8u01NsTd9LDmJCCBcl2MdAci0Flx1Rm/b9mHvW+g
 pfLvQlV29F/e8TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1F953EA69;
 Tue,  3 Mar 2026 13:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BhnGZvlpmlXYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 13:43:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com
Subject: [PATCH v3 2/5] tests/functional/migration: Add migrate_vms
Date: Tue,  3 Mar 2026 10:43:45 -0300
Message-ID: <20260303134348.8890-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303134348.8890-1-farosas@suse.de>
References: <20260303134348.8890-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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


