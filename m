Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EDCD1A613
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoA-0003qN-AI; Fri, 09 Jan 2026 07:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnt-0003YH-E2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnr-0007Ja-Nn
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B25A33808;
 Fri,  9 Jan 2026 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g2z5WvcN+x0DrLLM0CsHxCOuixvhNc2LRVtbIoPM+Q=;
 b=rI1h8r3RjMUuvaf31cs2m3CryiestgVA67wEeX2mU9ReGI33FnRZjgcJyXMOogIrEnCWRI
 5VCssG7SleJrCBUBPct8FzUEmibRVqZ0greMFdkpLSdomxzUHtNFo/79gOkK0Z90+X36tt
 wGLdrSoY7HCjdttXcgZgnGJkXXyfRdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g2z5WvcN+x0DrLLM0CsHxCOuixvhNc2LRVtbIoPM+Q=;
 b=AxqZ/j+72CEQQi/Q6i+H8ZQC/tzTRrZY0wL7gIGEF8sZnX2o/kofKXcsZlJF99e4f0DxUa
 OKV3W6zwv9/BsBAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rI1h8r3R;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AxqZ/j+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g2z5WvcN+x0DrLLM0CsHxCOuixvhNc2LRVtbIoPM+Q=;
 b=rI1h8r3RjMUuvaf31cs2m3CryiestgVA67wEeX2mU9ReGI33FnRZjgcJyXMOogIrEnCWRI
 5VCssG7SleJrCBUBPct8FzUEmibRVqZ0greMFdkpLSdomxzUHtNFo/79gOkK0Z90+X36tt
 wGLdrSoY7HCjdttXcgZgnGJkXXyfRdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g2z5WvcN+x0DrLLM0CsHxCOuixvhNc2LRVtbIoPM+Q=;
 b=AxqZ/j+72CEQQi/Q6i+H8ZQC/tzTRrZY0wL7gIGEF8sZnX2o/kofKXcsZlJF99e4f0DxUa
 OKV3W6zwv9/BsBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40A2B3EA63;
 Fri,  9 Jan 2026 12:41:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kJLPOmP3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 11/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
Date: Fri,  9 Jan 2026 09:40:27 -0300
Message-ID: <20260109124043.25019-12-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8B25A33808
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

Whenever an error occurs between migrate_init() and the start of
migration_thread, do cleanup immediately after.

This allows the special casing for resume to be removed from
migration_connect(), that check is now done at
migration_connect_error_propagate() which already had a case for
resume.

The cleanup at qmp_migrate_finish_cb can also be removed because it
will always be reached wither via the error path at
qmp_migrate_finish->migration_connect_error_propagate or via the
migrate_cleanup_bh.

The yank_unregister_instance at qmp_migrate() is now replaced by the
one at migration_cleanup().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 164cb26c48..d57cc2dc3b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1576,15 +1576,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next = MIGRATION_STATUS_NONE;
+    bool resume = false;
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
         next = MIGRATION_STATUS_FAILED;
         break;
 
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+        resume = true;
+        break;
+
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
         next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        resume = true;
         break;
 
     case MIGRATION_STATUS_CANCELLING:
@@ -1609,6 +1615,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     }
 
     migrate_error_propagate(s, error);
+
+    if (!resume) {
+        migration_cleanup(s);
+    }
 }
 
 void migration_cancel(void)
@@ -2211,9 +2221,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
 
     qmp_migrate_finish(addr, NULL);
-
-    cpr_state_close();
-    migrate_hup_delete(migrate_get_current());
     qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
@@ -2222,7 +2229,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
-    Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
@@ -2279,6 +2285,13 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * The migrate_prepare() above calls migrate_init(). From this
+     * point on, until the end of migration, make sure any failures
+     * eventually result in a call to migration_cleanup().
+     */
+    Error *local_err = NULL;
+
     if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
@@ -2303,7 +2316,6 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
@@ -4026,9 +4038,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (!resume) {
-            migration_cleanup(s);
-        }
         if (s->error) {
             error_report_err(error_copy(s->error));
         }
@@ -4107,7 +4116,6 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migration_connect_error_propagate(s, local_err);
-    migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
     }
-- 
2.51.0


