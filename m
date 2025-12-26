Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9723AE8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFES-0001Ri-GV; Fri, 26 Dec 2025 16:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEL-0001R7-Ko
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:14 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEK-00045c-4j
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 110225BCE4;
 Fri, 26 Dec 2025 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6feVrZedvuia2CRgWiWkzfS/88hHiX+QYNAlOrNJFI=;
 b=wPatnqmYU5wCBdvbTaAHQNPJDLryktjV1tYFLzgZoETG36uHh8lBKKfmPMWn3ZwbVJDT9P
 9KMplYG6XZih68j4+v5EJQSxdi1c+IMBfNv2iJ5E5JwI5aMjxY8p+xn+fxZjr2X9oKnWCy
 9YxTJlmgxTpMRC8ZgOqV6Tdcle+mhEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6feVrZedvuia2CRgWiWkzfS/88hHiX+QYNAlOrNJFI=;
 b=kZ8R3u0mEdU35Dnaj7MPyrmJhJXGADghGUn0o6kha66jMinfbCM1JFVfuAEv+kywwwYv5E
 vk6wgrVEO7fE2jDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wPatnqmY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kZ8R3u0m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6feVrZedvuia2CRgWiWkzfS/88hHiX+QYNAlOrNJFI=;
 b=wPatnqmYU5wCBdvbTaAHQNPJDLryktjV1tYFLzgZoETG36uHh8lBKKfmPMWn3ZwbVJDT9P
 9KMplYG6XZih68j4+v5EJQSxdi1c+IMBfNv2iJ5E5JwI5aMjxY8p+xn+fxZjr2X9oKnWCy
 9YxTJlmgxTpMRC8ZgOqV6Tdcle+mhEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6feVrZedvuia2CRgWiWkzfS/88hHiX+QYNAlOrNJFI=;
 b=kZ8R3u0mEdU35Dnaj7MPyrmJhJXGADghGUn0o6kha66jMinfbCM1JFVfuAEv+kywwwYv5E
 vk6wgrVEO7fE2jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 071AD3EA65;
 Fri, 26 Dec 2025 21:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MAIOLvT7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 10/25] migration: Expand migration_connect_error_propagate
 to cover cancelling
Date: Fri, 26 Dec 2025 18:19:12 -0300
Message-ID: <20251226211930.27565-11-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 110225BCE4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Cover the CANCELLING state in migration_connect_error_propagate() and
use it to funnel errors from migrate_prepare() until the end of
migration_connect().

(add some line breaks for legibility)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 83854d084a..e1c00867ab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1575,18 +1575,25 @@ static void migrate_error_free(MigrationState *s)
 static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
-    MigrationStatus next;
-
-    assert(s->to_dst_file == NULL);
+    MigrationStatus next = MIGRATION_STATUS_NONE;
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
         next = MIGRATION_STATUS_FAILED;
         break;
+
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
         next = MIGRATION_STATUS_POSTCOPY_PAUSED;
         break;
+
+    case MIGRATION_STATUS_CANCELLING:
+        /*
+         * Don't move out of CANCELLING, the only valid transition is to
+         * CANCELLED, at migration_cleanup().
+         */
+        break;
+
     default:
         /*
          * This really shouldn't happen. Just be careful to not crash a VM
@@ -1597,7 +1604,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
         return;
     }
 
-    migrate_set_state(&s->state, current, next);
+    if (next) {
+        migrate_set_state(&s->state, current, next);
+    }
+
     migrate_error_propagate(s, error);
 }
 
@@ -4107,11 +4117,7 @@ void migration_connect(MigrationState *s, Error *error_in)
     return;
 
 fail:
-    migrate_error_propagate(s, error_copy(local_err));
-    if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-    }
-    error_report_err(local_err);
+    migration_connect_error_propagate(s, local_err);
     migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
-- 
2.51.0


