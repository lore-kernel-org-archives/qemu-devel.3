Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5949C79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpvp-0007vH-NP; Mon, 05 Jan 2026 14:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvD-0007he-HE
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvA-00059u-Qp
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A291C33750;
 Mon,  5 Jan 2026 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=DwEYoFiCGemuRy10jF77UKBvd62hWJMoq6amhNsHGAT8ezL0Z25XDFVjK80dxzRXuNQpCr
 Z3MTEYfKJ4em0vy2FYO9QAsposp7HPjWlxS8Q/Xmez7J5yEx+88o17ilNmMuAU5PjrNgoS
 tNAfQko/Z/WIKet4oc9U4yQqAasyp3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=5bggc2pMMJkLPrZ4IHl/RAdQ2Z+lBst3rCiOM3LH3olMBuR8ra1CYdgKQ2UjocqgyHYdmx
 hcYQyVvy2ijl2eCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DwEYoFiC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5bggc2pM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=DwEYoFiCGemuRy10jF77UKBvd62hWJMoq6amhNsHGAT8ezL0Z25XDFVjK80dxzRXuNQpCr
 Z3MTEYfKJ4em0vy2FYO9QAsposp7HPjWlxS8Q/Xmez7J5yEx+88o17ilNmMuAU5PjrNgoS
 tNAfQko/Z/WIKet4oc9U4yQqAasyp3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=5bggc2pMMJkLPrZ4IHl/RAdQ2Z+lBst3rCiOM3LH3olMBuR8ra1CYdgKQ2UjocqgyHYdmx
 hcYQyVvy2ijl2eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C19613964;
 Mon,  5 Jan 2026 19:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qPmNB9ELXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:06:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 05/25] migration: Move postcopy_try_recover into
 migration_incoming_process
Date: Mon,  5 Jan 2026 16:06:22 -0300
Message-ID: <20260105190644.14072-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A291C33750
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

The postcopy_try_recover() call doesn't need to be duplicated, move it
into migration_incoming_process().

This removes code from migration_fd_process_incoming() so it can be
removed in the near future.

(the diff is a bit strange because migration_incoming_process() was
moved after postcopy_try_recover())

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c45393f40e..4af5baad59 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -943,12 +943,6 @@ static void migration_incoming_setup(QEMUFile *f)
     qemu_file_set_blocking(f, false, &error_abort);
 }
 
-void migration_incoming_process(void)
-{
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
-    qemu_coroutine_enter(co);
-}
-
 /* Returns true if recovered from a paused migration, otherwise false */
 static bool postcopy_try_recover(void)
 {
@@ -982,12 +976,19 @@ static bool postcopy_try_recover(void)
     return false;
 }
 
+void migration_incoming_process(void)
+{
+    if (postcopy_try_recover()) {
+        return;
+    }
+
+    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
+    qemu_coroutine_enter(co);
+}
+
 void migration_fd_process_incoming(QEMUFile *f)
 {
     migration_incoming_setup(f);
-    if (postcopy_try_recover()) {
-        return;
-    }
     migration_incoming_process();
 }
 
@@ -1087,10 +1088,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     }
 
     if (migration_has_main_and_multifd_channels()) {
-        /* If it's a recovery, we're done */
-        if (postcopy_try_recover()) {
-            return;
-        }
         migration_incoming_process();
     }
 }
-- 
2.51.0


