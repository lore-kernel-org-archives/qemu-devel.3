Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED568C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg69i-00062c-4i; Thu, 06 Feb 2025 12:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69f-00061i-2F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:11 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69c-0001J9-Vx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A750A1F38D;
 Thu,  6 Feb 2025 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1x9zDgucQe3JQlPJ+Pwdg7uNZ7hc3RIFAk3es8NNuE=;
 b=oLoB1ceMhzDZf0CsaB2UJtEkeq3QGErpaWYBqy9awPRUcJYcQ315dS1qGzNfUnkVvKaqpc
 okeq5EbII63wTB6KjaxoJejCQW8DyOk+IY0So2eGKSua/fvKAk17bnaAv3QzU/D5Pz504k
 JTpaLRpmU9+N+OoTJBNycKMYw+IL5XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1x9zDgucQe3JQlPJ+Pwdg7uNZ7hc3RIFAk3es8NNuE=;
 b=9ICaWw3/NqB1IAq92ZiD1TGyXnL2gnLioqDXrSAtDQTWE7voi3/uvY1sweTE3lH2rvy5cf
 eTnQEJp/o9O/2CDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1x9zDgucQe3JQlPJ+Pwdg7uNZ7hc3RIFAk3es8NNuE=;
 b=oLoB1ceMhzDZf0CsaB2UJtEkeq3QGErpaWYBqy9awPRUcJYcQ315dS1qGzNfUnkVvKaqpc
 okeq5EbII63wTB6KjaxoJejCQW8DyOk+IY0So2eGKSua/fvKAk17bnaAv3QzU/D5Pz504k
 JTpaLRpmU9+N+OoTJBNycKMYw+IL5XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1x9zDgucQe3JQlPJ+Pwdg7uNZ7hc3RIFAk3es8NNuE=;
 b=9ICaWw3/NqB1IAq92ZiD1TGyXnL2gnLioqDXrSAtDQTWE7voi3/uvY1sweTE3lH2rvy5cf
 eTnQEJp/o9O/2CDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0720913697;
 Thu,  6 Feb 2025 17:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CkdLWn4pGeVZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 17:59:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 3/4] migration/multifd: Terminate the TLS connection
Date: Thu,  6 Feb 2025 14:58:23 -0300
Message-Id: <20250206175824.22664-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250206175824.22664-1-farosas@suse.de>
References: <20250206175824.22664-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The multifd recv side has been getting a TLS error of
GNUTLS_E_PREMATURE_TERMINATION at the end of migration when the send
side closes the sockets without ending the TLS session. This has been
masked by the code not checking the migration error after loadvm.

Start ending the TLS session at multifd_send_shutdown() so the recv
side always sees a clean termination (EOF) and we can start to
differentiate that from an actual premature termination that might
possibly happen in the middle of the migration.

There's nothing to be done if a previous migration error has already
broken the connection, so add a comment explaining it and ignore any
errors coming from gnutls_bye().

This doesn't break compat with older recv-side QEMUs because EOF has
always caused the recv thread to exit cleanly.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 34 +++++++++++++++++++++++++++++++++-
 migration/tls.c     |  5 +++++
 migration/tls.h     |  2 +-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ab73d6d984..b57cad3bb1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -490,6 +490,32 @@ void multifd_send_shutdown(void)
         return;
     }
 
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        /* thread_created implies the TLS handshake has succeeded */
+        if (p->tls_thread_created && p->thread_created) {
+            Error *local_err = NULL;
+            /*
+             * The destination expects the TLS session to always be
+             * properly terminated. This helps to detect a premature
+             * termination in the middle of the stream.  Note that
+             * older QEMUs always break the connection on the source
+             * and the destination always sees
+             * GNUTLS_E_PREMATURE_TERMINATION.
+             */
+            migration_tls_channel_end(p->c, &local_err);
+
+            if (local_err) {
+                /*
+                 * The above can fail with broken pipe due to a
+                 * previous migration error, ignore the error.
+                 */
+                assert(migration_has_failed(migrate_get_current()));
+            }
+        }
+    }
+
     multifd_send_terminate_threads();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -1141,7 +1167,13 @@ static void *multifd_recv_thread(void *opaque)
 
             ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);
-            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
+            if (!ret) {
+                /* EOF */
+                assert(!local_err);
+                break;
+            }
+
+            if (ret == -1) {
                 break;
             }
 
diff --git a/migration/tls.c b/migration/tls.c
index fa03d9136c..5cbf952383 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -156,6 +156,11 @@ void migration_tls_channel_connect(MigrationState *s,
                               NULL);
 }
 
+void migration_tls_channel_end(QIOChannel *ioc, Error **errp)
+{
+    qio_channel_tls_bye(QIO_CHANNEL_TLS(ioc), errp);
+}
+
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
 {
     if (!migrate_tls()) {
diff --git a/migration/tls.h b/migration/tls.h
index 5797d153cb..58b25e1228 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -36,7 +36,7 @@ void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
                                    const char *hostname,
                                    Error **errp);
-
+void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
 /* Whether the QIO channel requires further TLS handshake? */
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
 
-- 
2.35.3


