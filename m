Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E577D74ED3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHyv-0000LH-5n; Fri, 23 Jan 2026 09:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHyW-0008TC-5L
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHyU-0003dO-Hf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91E625BCCF;
 Fri, 23 Jan 2026 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTBNi7O7VSbyPdSafD8vgsPIwsj4ueKe6JefrgHMCvM=;
 b=FJKCxeFz8TrutLKQ3+u7e9lbeLQD20t56EAnC/bSjBCMFerpPpqURatBGB04A80RFTqhsV
 CCfPUi6eDHUrS6K0vBFO34JMu7wAcAoJglhuJolpI5E/Q/t6rSVoqt5Cv9uLO0DMBSyV9i
 VH7CDvKhX+oSEiHSTI9swmqR0QcOlbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTBNi7O7VSbyPdSafD8vgsPIwsj4ueKe6JefrgHMCvM=;
 b=f+NDLhC7rBJfvoqAJRPSomUZloUoXr4Rv9pWyusnr5GBKMXPY9JO4jtYFCD8jMo51nOKVt
 mG/iG6ZiQd1aM+BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FJKCxeFz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f+NDLhC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTBNi7O7VSbyPdSafD8vgsPIwsj4ueKe6JefrgHMCvM=;
 b=FJKCxeFz8TrutLKQ3+u7e9lbeLQD20t56EAnC/bSjBCMFerpPpqURatBGB04A80RFTqhsV
 CCfPUi6eDHUrS6K0vBFO34JMu7wAcAoJglhuJolpI5E/Q/t6rSVoqt5Cv9uLO0DMBSyV9i
 VH7CDvKhX+oSEiHSTI9swmqR0QcOlbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTBNi7O7VSbyPdSafD8vgsPIwsj4ueKe6JefrgHMCvM=;
 b=f+NDLhC7rBJfvoqAJRPSomUZloUoXr4Rv9pWyusnr5GBKMXPY9JO4jtYFCD8jMo51nOKVt
 mG/iG6ZiQd1aM+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60361395E;
 Fri, 23 Jan 2026 14:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KCJhHe6Cc2m8HAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 14:17:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, ppandit@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4 08/25] migration: Move error reporting out of
 migration_cleanup
Date: Fri, 23 Jan 2026 11:16:38 -0300
Message-ID: <20260123141656.6765-9-farosas@suse.de>
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
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fedoraproject.org:email,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 91E625BCCF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

In the next patches migration_cleanup() will be used in qmp_migrate(),
which currently does not show an error message. Move the error
reporting out of migration_cleanup() to avoid duplicate messages.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 913e2b9921..1bb59b8305 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1528,10 +1528,6 @@ static void migration_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
-    if (s->error) {
-        /* It is used on info migrate.  We can't free it */
-        error_report_err(error_copy(s->error));
-    }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(type, NULL);
@@ -1540,7 +1536,12 @@ static void migration_cleanup(MigrationState *s)
 
 static void migration_cleanup_bh(void *opaque)
 {
-    migration_cleanup(opaque);
+    MigrationState *s = opaque;
+
+    migration_cleanup(s);
+    if (s->error) {
+        error_report_err(error_copy(s->error));
+    }
 }
 
 /*
@@ -4023,18 +4024,12 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (resume) {
-            /*
-             * Don't do cleanup for resume if channel is invalid, but only dump
-             * the error.  We wait for another channel connect from the user.
-             * The error_report still gives HMP user a hint on what failed.
-             * It's normally done in migration_cleanup(), but call it here
-             * explicitly.
-             */
-            error_report_err(error_copy(s->error));
-        } else {
+        if (!resume) {
             migration_cleanup(s);
         }
+        if (s->error) {
+            error_report_err(error_copy(s->error));
+        }
         return;
     }
 
@@ -4113,8 +4108,10 @@ fail:
     if (s->state != MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     }
-    error_report_err(local_err);
     migration_cleanup(s);
+    if (s->error) {
+        error_report_err(error_copy(s->error));
+    }
 }
 
 static void migration_class_init(ObjectClass *klass, const void *data)
-- 
2.51.0


