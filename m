Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D0D74ED8
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHzA-0000iI-TT; Fri, 23 Jan 2026 09:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHyp-0000GL-C4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHym-0003fK-QR
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41E8A33813;
 Fri, 23 Jan 2026 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuqbPH569qjHJCkNk6NglGi2HTTW+35tRNlJ1R5Lm2o=;
 b=xN7m7ngdFpM1Th2WnE/AfsL9DmfRmMGg9U2akuqGqf1au8dp6ucLWQ4Raqd15lYGQu4SXp
 LfHVvqHhkdQ6EsSFMUGs2Pn5S6tm8ZxCLzbAtU2W3N7xzaxkoBS8BhM/yQtimC0TRGR6lY
 4cFWmp0onCq7q2wmE3ucCPJaQ80MNL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuqbPH569qjHJCkNk6NglGi2HTTW+35tRNlJ1R5Lm2o=;
 b=Pfile7aQcrDlRtgBfB+DW6TgFU6j8Df0yREjYspL7poVKH+QoFE4suqGSDGkcUhU/ZwJgn
 pkK8zQOP4UoQzpAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xN7m7ngd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pfile7aQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuqbPH569qjHJCkNk6NglGi2HTTW+35tRNlJ1R5Lm2o=;
 b=xN7m7ngdFpM1Th2WnE/AfsL9DmfRmMGg9U2akuqGqf1au8dp6ucLWQ4Raqd15lYGQu4SXp
 LfHVvqHhkdQ6EsSFMUGs2Pn5S6tm8ZxCLzbAtU2W3N7xzaxkoBS8BhM/yQtimC0TRGR6lY
 4cFWmp0onCq7q2wmE3ucCPJaQ80MNL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuqbPH569qjHJCkNk6NglGi2HTTW+35tRNlJ1R5Lm2o=;
 b=Pfile7aQcrDlRtgBfB+DW6TgFU6j8Df0yREjYspL7poVKH+QoFE4suqGSDGkcUhU/ZwJgn
 pkK8zQOP4UoQzpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636831395E;
 Fri, 23 Jan 2026 14:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJxjCeyCc2m8HAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 14:17:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, ppandit@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4 07/25] migration: Free the error earlier in the resume case
Date: Fri, 23 Jan 2026 11:16:37 -0300
Message-ID: <20260123141656.6765-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123141656.6765-1-farosas@suse.de>
References: <20260123141656.6765-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,fedoraproject.org:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 41E8A33813
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 16085eb8d6..913e2b9921 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1809,8 +1809,8 @@ int migrate_init(MigrationState *s, Error **errp)
     s->setup_time = 0;
     s->start_postcopy = false;
     s->migration_thread_running = false;
-    error_free(s->error);
-    s->error = NULL;
+
+    migrate_error_free(s);
 
     if (should_send_vmdesc()) {
         s->vmdesc = json_writer_new(false);
@@ -2085,6 +2085,13 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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
@@ -4013,13 +4020,6 @@ void migration_connect(MigrationState *s, Error *error_in)
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


