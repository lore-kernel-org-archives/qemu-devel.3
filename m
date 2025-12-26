Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E243E8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFE0-0001H8-Gz; Fri, 26 Dec 2025 16:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFDt-0001F6-Rm
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:48 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFDs-0003ZQ-CA
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:45 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFAA95BCCB;
 Fri, 26 Dec 2025 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4V5ewCNgJujiDbPtywT+kgNqorZmKMkIaCdHu6ewMs4=;
 b=z08urxJ57XAViVGEWOIGzSOnSn19v/BZ2tW18pDch9gPUTwN11p1sETSzIqZ4AC8j+TGLc
 yXwssbHwWgWXsxulXA0HgJDvs1a6iLLL6sDWp0KlcJypvUGo5+mX4amvh4Z5jilAemBgQD
 thdL2E1j4FhjF9ReI5nkplLHgG+a2b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4V5ewCNgJujiDbPtywT+kgNqorZmKMkIaCdHu6ewMs4=;
 b=unXtKC5i/B+3daFDEPQ4coSvmbocv8sONgPnA4NjaGw08LmL55Gw1+qJBdD721gqx/gTgz
 yZnuLnCFVjwVFyAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4V5ewCNgJujiDbPtywT+kgNqorZmKMkIaCdHu6ewMs4=;
 b=z08urxJ57XAViVGEWOIGzSOnSn19v/BZ2tW18pDch9gPUTwN11p1sETSzIqZ4AC8j+TGLc
 yXwssbHwWgWXsxulXA0HgJDvs1a6iLLL6sDWp0KlcJypvUGo5+mX4amvh4Z5jilAemBgQD
 thdL2E1j4FhjF9ReI5nkplLHgG+a2b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4V5ewCNgJujiDbPtywT+kgNqorZmKMkIaCdHu6ewMs4=;
 b=unXtKC5i/B+3daFDEPQ4coSvmbocv8sONgPnA4NjaGw08LmL55Gw1+qJBdD721gqx/gTgz
 yZnuLnCFVjwVFyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C743D3EA63;
 Fri, 26 Dec 2025 21:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMiYIen7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 03/25] migration/tls: Remove unused parameter
Date: Fri, 26 Dec 2025 18:19:05 -0300
Message-ID: <20251226211930.27565-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.982];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

MigrationState is not used at migration_tls_channel_process_incoming().

The last usage was removed by commit 3f461a0c0b ("migration: Drop
unused parameter for migration_tls_get_creds()")

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 3 +--
 migration/tls.c     | 4 +---
 migration/tls.h     | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 4768c71455..b4ab676048 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -32,7 +32,6 @@
  */
 void migration_channel_process_incoming(QIOChannel *ioc)
 {
-    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
 
@@ -40,7 +39,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        migration_tls_channel_process_incoming(s, ioc, &local_err);
+        migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
         migration_ioc_register_yank(ioc);
         migration_ioc_process_incoming(ioc, &local_err);
diff --git a/migration/tls.c b/migration/tls.c
index 56b5d1cc90..1df31bdcbb 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -71,9 +71,7 @@ static void migration_tls_incoming_handshake(QIOTask *task,
     object_unref(OBJECT(ioc));
 }
 
-void migration_tls_channel_process_incoming(MigrationState *s,
-                                            QIOChannel *ioc,
-                                            Error **errp)
+void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp)
 {
     QCryptoTLSCreds *creds;
     QIOChannelTLS *tioc;
diff --git a/migration/tls.h b/migration/tls.h
index 58b25e1228..7607cfe803 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -24,9 +24,7 @@
 #include "io/channel.h"
 #include "io/channel-tls.h"
 
-void migration_tls_channel_process_incoming(MigrationState *s,
-                                            QIOChannel *ioc,
-                                            Error **errp);
+void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            const char *hostname,
-- 
2.51.0


