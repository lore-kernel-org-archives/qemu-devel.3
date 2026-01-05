Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95642C79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpwp-0000vp-Gz; Mon, 05 Jan 2026 14:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpw3-00081C-0V
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpw0-0005cV-LY
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B17025BCC1;
 Mon,  5 Jan 2026 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTBQAjwuG9jBa81jGA/8m76UIROtEgrPinh8cNGJ0T0=;
 b=MnUNIDPtOXiyK/VemGEptpK6RApiCn3ShWEacO8SOKE1vsdO2fjL8x2ja46A8T2bUo2V0f
 dSxomoXksZSU1W8vxFWWRasdWT9fCOyZ7K5rZeoRzrfHLJzG2akwPNBL771WYtll+iC/l/
 n6ZyF+DCucc04/BWDupB+NxhsDwwVls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTBQAjwuG9jBa81jGA/8m76UIROtEgrPinh8cNGJ0T0=;
 b=C7/hQktGqcxqOdlU6aez+D1BGlTveFR49uxo0++y4e+lv1456R6TwvpXT3Z6//i/vg16Vn
 NDjnEvY4J37NtwDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTBQAjwuG9jBa81jGA/8m76UIROtEgrPinh8cNGJ0T0=;
 b=MnUNIDPtOXiyK/VemGEptpK6RApiCn3ShWEacO8SOKE1vsdO2fjL8x2ja46A8T2bUo2V0f
 dSxomoXksZSU1W8vxFWWRasdWT9fCOyZ7K5rZeoRzrfHLJzG2akwPNBL771WYtll+iC/l/
 n6ZyF+DCucc04/BWDupB+NxhsDwwVls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTBQAjwuG9jBa81jGA/8m76UIROtEgrPinh8cNGJ0T0=;
 b=C7/hQktGqcxqOdlU6aez+D1BGlTveFR49uxo0++y4e+lv1456R6TwvpXT3Z6//i/vg16Vn
 NDjnEvY4J37NtwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB683EA63;
 Mon,  5 Jan 2026 19:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iMNxC/cLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 24/25] migration: Remove qmp_migrate_finish
Date: Mon,  5 Jan 2026 16:06:41 -0300
Message-ID: <20260105190644.14072-25-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.987];
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

After cleanups, the qmp_migrate_finish function is now just a call to
migration_connect_outgoing(). Remove qmp_migrate_finish() and rename
the qmp_migrate_finish_cb callback.

This also allows the cleanup at qmp_migrate_finish() to move to the
top level along with everyting else.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a9d5f5880d..2991e01d65 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1997,15 +1997,18 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
     return true;
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
-
-static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
-                                      GIOCondition cond,
-                                      void *opaque)
+static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
+                                              GIOCondition cond, void *opaque)
 {
-    MigrationAddress *addr = opaque;
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+
+    migration_connect_outgoing(s, opaque, &local_err);
+
+    if (local_err) {
+        migration_connect_error_propagate(s, local_err);
+    }
 
-    qmp_migrate_finish(addr, NULL);
     return G_SOURCE_REMOVE;
 }
 
@@ -2059,10 +2062,11 @@ void qmp_migrate(const char *uri, bool has_channels,
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
-        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
+        cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
+                                   main_ch->addr);
 
     } else {
-        qmp_migrate_finish(main_ch->addr, errp);
+        migration_connect_outgoing(s, main_ch->addr, &local_err);
     }
 
 out:
@@ -2072,19 +2076,6 @@ out:
     }
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
-
-    migration_connect_outgoing(s, addr, &local_err);
-
-    if (local_err) {
-        migration_connect_error_propagate(s, error_copy(local_err));
-        error_propagate(errp, local_err);
-    }
-}
-
 void qmp_migrate_cancel(Error **errp)
 {
     /*
-- 
2.51.0


