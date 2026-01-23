Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B4D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFB-0003Lm-1a; Fri, 23 Jan 2026 14:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNF9-0003ES-E3
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNF7-0003ZP-Ew
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 809FB5BCD0;
 Fri, 23 Jan 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvA72mKs7LI4Q5bMl7UpS+Asxq3ud15Jc50hDQV9YHk=;
 b=QmNpn7QWS1q8AtSY1GWeNZXoJCVymae9IN30SXXFL8rlLjxk3RnhLpGgql471caz5cWyR5
 Bo2DXv7xDi2Kf+tqEwJMOmNPPyrrA5NFHNoSCvUVP5l5zCykcgS/gfjME5DHNkx0LnvILc
 71yv8Dpke1Kwn1cLv6QAlB7sY5q1Wis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvA72mKs7LI4Q5bMl7UpS+Asxq3ud15Jc50hDQV9YHk=;
 b=l9s8HvoETsqMMdGbgjR+VV9e0Qm+zMyHM0kD7Q2C5IdWVbtdiS/mGqpmuV3KnUBkp6zRa0
 xlA0DZ2/b3BHrmAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QmNpn7QW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l9s8HvoE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvA72mKs7LI4Q5bMl7UpS+Asxq3ud15Jc50hDQV9YHk=;
 b=QmNpn7QWS1q8AtSY1GWeNZXoJCVymae9IN30SXXFL8rlLjxk3RnhLpGgql471caz5cWyR5
 Bo2DXv7xDi2Kf+tqEwJMOmNPPyrrA5NFHNoSCvUVP5l5zCykcgS/gfjME5DHNkx0LnvILc
 71yv8Dpke1Kwn1cLv6QAlB7sY5q1Wis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvA72mKs7LI4Q5bMl7UpS+Asxq3ud15Jc50hDQV9YHk=;
 b=l9s8HvoETsqMMdGbgjR+VV9e0Qm+zMyHM0kD7Q2C5IdWVbtdiS/mGqpmuV3KnUBkp6zRa0
 xlA0DZ2/b3BHrmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB9C1395E;
 Fri, 23 Jan 2026 19:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6PTqN/TRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 19/36] migration: Move error reporting out of migration_cleanup
Date: Fri, 23 Jan 2026 16:53:34 -0300
Message-ID: <20260123195352.12850-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 809FB5BCD0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-9-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 93013608ef..000f113307 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1527,10 +1527,6 @@ static void migration_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
-    if (s->error) {
-        /* It is used on info migrate.  We can't free it */
-        error_report_err(error_copy(s->error));
-    }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(type, NULL);
@@ -1539,7 +1535,12 @@ static void migration_cleanup(MigrationState *s)
 
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
@@ -4017,18 +4018,12 @@ void migration_connect(MigrationState *s, Error *error_in)
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
 
@@ -4107,8 +4102,10 @@ fail:
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


