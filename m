Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D2C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidUw-0005z0-S9; Thu, 13 Feb 2025 12:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUv-0005xs-Sn
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:37 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUu-000664-03
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC09225C3;
 Thu, 13 Feb 2025 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zckjB4l/Z4WIL8O0oEwzIzDwYk54JmORz7UdIZltekk=;
 b=sKK1uGtuM0jA5foYPsYycMpSk90/aZkeSl977ztBuqgWLksFjK/xQvu66e/R74AYEa4jrX
 6nKpY5w2rdp5do09ePXLbYUA3SWTwbJtMOgW1CaTwcHL3iTCO50ZBX0RDUDla3Zdh8NHBZ
 nwXemK47ia0MpgO+gbE1xpHyME67ceY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zckjB4l/Z4WIL8O0oEwzIzDwYk54JmORz7UdIZltekk=;
 b=fPIwdT/xV7RoOUnOIUQ0Z2d+JozoPgTideFc3H1qyXh58uQCxGUqEw2OeGIMsWZdOfbfRc
 MSh3GXrCuQaGpCBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sKK1uGtu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fPIwdT/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zckjB4l/Z4WIL8O0oEwzIzDwYk54JmORz7UdIZltekk=;
 b=sKK1uGtuM0jA5foYPsYycMpSk90/aZkeSl977ztBuqgWLksFjK/xQvu66e/R74AYEa4jrX
 6nKpY5w2rdp5do09ePXLbYUA3SWTwbJtMOgW1CaTwcHL3iTCO50ZBX0RDUDla3Zdh8NHBZ
 nwXemK47ia0MpgO+gbE1xpHyME67ceY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zckjB4l/Z4WIL8O0oEwzIzDwYk54JmORz7UdIZltekk=;
 b=fPIwdT/xV7RoOUnOIUQ0Z2d+JozoPgTideFc3H1qyXh58uQCxGUqEw2OeGIMsWZdOfbfRc
 MSh3GXrCuQaGpCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A6A013874;
 Thu, 13 Feb 2025 17:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCZkNgMzrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/9] migration: Set migration error outside of
 migrate_cancel
Date: Thu, 13 Feb 2025 14:59:19 -0300
Message-Id: <20250213175927.19642-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250213175927.19642-1-farosas@suse.de>
References: <20250213175927.19642-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DC09225C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URG_BIZ=0.573 autolearn=no autolearn_force=no
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

There's no point passing the error into migration cancel only for it
to call migrate_set_error().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 7 ++-----
 migration/migration.h | 2 +-
 migration/ram.c       | 4 +++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 396928513a..7728f52aef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -342,11 +342,8 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
     qemu_bh_schedule(bh);
 }
 
-void migration_cancel(const Error *error)
+void migration_cancel()
 {
-    if (error) {
-        migrate_set_error(current_migration, error);
-    }
     if (migrate_dirty_limit()) {
         qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
     }
@@ -365,7 +362,7 @@ void migration_shutdown(void)
      * Cancel the current migration - that will (eventually)
      * stop the migration using this structure
      */
-    migration_cancel(NULL);
+    migration_cancel();
     object_unref(OBJECT(current_migration));
 
     /*
diff --git a/migration/migration.h b/migration/migration.h
index eaebcc2042..3547420c52 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -530,7 +530,7 @@ void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
 void migration_bh_schedule(QEMUBHFunc *cb, void *opaque);
-void migration_cancel(const Error *error);
+void migration_cancel(void);
 
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
diff --git a/migration/ram.c b/migration/ram.c
index 6f460fd22d..589b6505eb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4465,8 +4465,10 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
          * Abort and indicate a proper reason.
          */
         error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
-        migration_cancel(err);
+        migrate_set_error(migrate_get_current(), err);
         error_free(err);
+
+        migration_cancel();
     }
 
     switch (ps) {
-- 
2.35.3


