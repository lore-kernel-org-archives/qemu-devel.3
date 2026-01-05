Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9831AC79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpvo-0007u6-OX; Mon, 05 Jan 2026 14:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvR-0007l0-4d
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvP-0005Ko-LD
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD40A33764;
 Mon,  5 Jan 2026 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbSLZ9QhwAjXPEa9qpVMFQF4TU/S+KhLumEOYL6so0E=;
 b=jaxRwYNoNjrPUlVAHooCPupvPsmKFk1GEVG9euyBr/KzqbwA6QAUld6e0yJonojB2KsCNA
 4/zpFJOPsGnu0vctPEkgYhw2OnQT/1lkyvcgKNU1JhW6PNmcWJoHOPh5KMbk4HHCTRPgLq
 0mFwRlNOMttNPduzow1ziL7jkbWQfbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbSLZ9QhwAjXPEa9qpVMFQF4TU/S+KhLumEOYL6so0E=;
 b=cvRTg2oqcw43Ax6MylFwowX8mfr9w3M1ZeLdWW1xskPArUgNjACcbZU4F0J6MiT+aWkyVp
 Ttr0+FHKo7WQdvAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbSLZ9QhwAjXPEa9qpVMFQF4TU/S+KhLumEOYL6so0E=;
 b=jaxRwYNoNjrPUlVAHooCPupvPsmKFk1GEVG9euyBr/KzqbwA6QAUld6e0yJonojB2KsCNA
 4/zpFJOPsGnu0vctPEkgYhw2OnQT/1lkyvcgKNU1JhW6PNmcWJoHOPh5KMbk4HHCTRPgLq
 0mFwRlNOMttNPduzow1ziL7jkbWQfbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbSLZ9QhwAjXPEa9qpVMFQF4TU/S+KhLumEOYL6so0E=;
 b=cvRTg2oqcw43Ax6MylFwowX8mfr9w3M1ZeLdWW1xskPArUgNjACcbZU4F0J6MiT+aWkyVp
 Ttr0+FHKo7WQdvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6564E13964;
 Mon,  5 Jan 2026 19:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OCe1CdcLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 08/25] migration: Move error reporting out of
 migration_cleanup
Date: Mon,  5 Jan 2026 16:06:25 -0300
Message-ID: <20260105190644.14072-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

In the next patches migration_cleanup() will be used in qmp_migrate(),
which currently does not show an error message. Move the error
reporting out of migration_cleanup() to avoid duplicated messages.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9204029c88..7bef787f00 100644
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
@@ -4025,18 +4026,12 @@ void migration_connect(MigrationState *s, Error *error_in)
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
 
@@ -4115,8 +4110,10 @@ fail:
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


