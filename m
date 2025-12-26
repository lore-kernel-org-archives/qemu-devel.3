Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D2E8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFFO-0004ch-03; Fri, 26 Dec 2025 16:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFFJ-0004CP-Bl
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:21:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFFH-0004My-Ba
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:21:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 548E15BCF1;
 Fri, 26 Dec 2025 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqj7eIxmqSfwi0x0PViGUESmvgBn7IsXqDeDDlZ4qaY=;
 b=aHDkKWrMA3ccDmI6OvcET8D95OzTPprA7rKPbJexpFw00DZtKE0Z/AsX80ShLHixg5Lin+
 p71troD8mjsT5GYTZdSl0tSOcwrfFCoKVEr0Zw3+nGsFWWgH0G61TUVPzb8GVDyI5rayNN
 6hxDatqEgcRhwDsygiPa0fs4pSz8Nb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqj7eIxmqSfwi0x0PViGUESmvgBn7IsXqDeDDlZ4qaY=;
 b=q3ZFK0LgRP8+ee9OVNx9kSWiJU0KVlsCsO+FG+qmeLid/XbOotbcxcM/YQ9WYfSkPMXo9e
 EVvuK30vwkdhK4Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mWENP+7S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nsT+HCZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqj7eIxmqSfwi0x0PViGUESmvgBn7IsXqDeDDlZ4qaY=;
 b=mWENP+7SYgYCxjbUdzFaLZGA97DfhRg9tprQuG1wXFXDVkkZXx7OzG7UftgPgWlrEQGouM
 3HXK+oKw/mk+a+pSe6y3cKPSiRQbdZHIVFDd1+/uDbpBB6szKKfoKv6cgpcB6FtPNnVYNy
 EEAVLf3sbEjydNRyVjgKkKfHEGdhZZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqj7eIxmqSfwi0x0PViGUESmvgBn7IsXqDeDDlZ4qaY=;
 b=nsT+HCZBEggNW0txJAN8UC7IDK9XRgG57VVkpq5ShkH9FVTUrQfi51kwA60xygQnSWxCde
 82O0PbZ6k6rT1zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B6C43EA63;
 Fri, 26 Dec 2025 21:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CBFhAw/8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 25/25] migration: Remove qmp_migrate_finish
Date: Fri, 26 Dec 2025 18:19:27 -0300
Message-ID: <20251226211930.27565-26-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 548E15BCF1
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

With recent cleanups, the qmp_migrate_finish() function has now become
just a call to migration_connect_outgoing(), which makes sense because
that's what the "second part of qmp_migrate" does. The
qmp_migrate_finish is (in retrospect) too confusing because it never
had a matching qmp_migrate_start. I think it's best to just remove
this function and call migration_connect_outgoing() directly.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 15d8459a81..228e322de1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1470,8 +1470,8 @@ void migration_cancel(void)
     }
 
     /*
-     * If qmp_migrate_finish has not been called, then there is no path that
-     * will complete the cancellation.  Do it now.
+     * If migration_connect_outgoing has not been called, then there
+     * is no path that will complete the cancellation.  Do it now.
      */
     if (setup && !s->to_dst_file) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -2002,8 +2002,6 @@ static bool migrate_prepare(bool resume, Error **errp)
     return true;
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
-
 static void migrate_hup_add(QIOChannel *ioc, GSourceFunc cb, void *opaque)
 {
     MigrationState *s = migrate_get_current();
@@ -2031,7 +2029,7 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
     Error *local_err = NULL;
 
-    qmp_migrate_finish(addr, &local_err);
+    migration_connect_outgoing(addr, &local_err);
 
     if (local_err) {
         migration_connect_error_propagate(local_err);
@@ -2086,18 +2084,19 @@ void qmp_migrate(const char *uri, bool has_channels,
      * For cpr-transfer, the target may not be listening yet on the migration
      * channel, because first it must finish cpr_load_state.  The target tells
      * us it is listening by closing the cpr-state socket.  Wait for that HUP
-     * event before connecting in qmp_migrate_finish.
+     * event before connecting in migration_connect_outgoing.
      *
      * The HUP could occur because the target fails while reading CPR state,
      * in which case the target will not listen for the incoming migration
-     * connection, so qmp_migrate_finish will fail to connect, and then recover.
+     * connection, so migration_connect_outgoing fail to connect, and
+     * then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
                         QAPI_CLONE(MigrationAddress, main_ch->addr));
 
     } else {
-        qmp_migrate_finish(main_ch->addr, &local_err);
+        migration_connect_outgoing(main_ch->addr, &local_err);
     }
 
 out:
@@ -2107,11 +2106,6 @@ out:
     }
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
-{
-    migration_connect_outgoing(addr, errp);
-}
-
 void qmp_migrate_cancel(Error **errp)
 {
     /*
-- 
2.51.0


