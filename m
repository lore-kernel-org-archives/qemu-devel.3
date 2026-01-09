Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F51D1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBnl-0003Oo-TM; Fri, 09 Jan 2026 07:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBni-0003N7-L8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:10 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnh-0007Ft-7O
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 277F0337E0;
 Fri,  9 Jan 2026 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFinIpEiQX2ucufqSxxH6/ojsKQaF480Lvpp4gBS564=;
 b=hXNzHYXfLT1PcWt5gCkgZZv2Ih4jPWMw0El0R+YaRP5NseRJi4IszAqXtEtK5SqZyyymOW
 +YRMHh51JDT0JSolxaWHJjSM7SE/g9O3/k+4F9inO5WzV/5/gSpbE/jXOH+yL3HeluyBxJ
 kTWqf1M8RSKBRQ3pcCJdbtsyf7eEoCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFinIpEiQX2ucufqSxxH6/ojsKQaF480Lvpp4gBS564=;
 b=t9yhvEoEf0I9FqluPdUxpi63OjmqK/Chm7JLl2s3VufRs0dwgkG2Z6uzXhCaMgFgrFk7Yy
 BFkyafgBnuiOQyCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hXNzHYXf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t9yhvEoE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFinIpEiQX2ucufqSxxH6/ojsKQaF480Lvpp4gBS564=;
 b=hXNzHYXfLT1PcWt5gCkgZZv2Ih4jPWMw0El0R+YaRP5NseRJi4IszAqXtEtK5SqZyyymOW
 +YRMHh51JDT0JSolxaWHJjSM7SE/g9O3/k+4F9inO5WzV/5/gSpbE/jXOH+yL3HeluyBxJ
 kTWqf1M8RSKBRQ3pcCJdbtsyf7eEoCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFinIpEiQX2ucufqSxxH6/ojsKQaF480Lvpp4gBS564=;
 b=t9yhvEoEf0I9FqluPdUxpi63OjmqK/Chm7JLl2s3VufRs0dwgkG2Z6uzXhCaMgFgrFk7Yy
 BFkyafgBnuiOQyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE1FB3EA65;
 Fri,  9 Jan 2026 12:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WPbFIlz3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 07/25] migration: Free the error earlier in the resume case
Date: Fri,  9 Jan 2026 09:40:23 -0300
Message-ID: <20260109124043.25019-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 277F0337E0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Freeing the error at migration_connect() is redundant in the normal
migration case. The freeing already happened at migrate_init():

qmp_migrate()
-> migrate_prepare()
   -> migrate_init()
-> qmp_migrate_finish()
   -> *_start_outgoing_migration()
   -> migration_channel_connect()
      -> migration_connect()

For the resume case, migrate_prepare() returns early and doesn't reach
migrate_init(). Move the extra migrate_error_free() call to
migrate_prepare() along with the resume check.

Also change migrate_init() to use migrate_error_free(), so it's easier
to see where are the places the error gets freed.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 388e0be5a2..9204029c88 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1811,8 +1811,8 @@ int migrate_init(MigrationState *s, Error **errp)
     s->setup_time = 0;
     s->start_postcopy = false;
     s->migration_thread_running = false;
-    error_free(s->error);
-    s->error = NULL;
+
+    migrate_error_free(s);
 
     if (should_send_vmdesc()) {
         s->vmdesc = json_writer_new(false);
@@ -2087,6 +2087,13 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
                           MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
 
+        /*
+         * If there's a previous error, free it and prepare for
+         * another one. For the non-resume case, this happens at
+         * migrate_init() below.
+         */
+        migrate_error_free(s);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -4015,13 +4022,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    /*
-     * If there's a previous error, free it and prepare for another one.
-     * Meanwhile if migration completes successfully, there won't have an error
-     * dumped when calling migration_cleanup().
-     */
-    migrate_error_free(s);
-
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-- 
2.51.0


