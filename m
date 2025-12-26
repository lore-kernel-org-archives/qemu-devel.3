Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD22E8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFE8-0001JO-Ig; Fri, 26 Dec 2025 16:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFE5-0001IP-1c
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:57 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFE3-0003iP-Cl
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B89475BCC4;
 Fri, 26 Dec 2025 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOcAqkAuhAmuQs4Pc4hz0xfBFtyvIAn0tePpQ1zREGg=;
 b=U+o5DfkNhi86okuiuv9CaefVBbXwb0UKmX4Fqs9EOVm5etpqbR0n5jdDoZXaraiAs5hPo/
 aJF+6Kl8JCfeLZJZU5xZXY2/QWC4mCKQXgDoIGeFHolT2wvVXGH33IFScQmj4dJkT1BXQB
 x2degfJfURhNOEDy9glNy4zIDpsV9Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOcAqkAuhAmuQs4Pc4hz0xfBFtyvIAn0tePpQ1zREGg=;
 b=j9Q4lugJpfLk0zP9KxvMQ/IhUAokGtdK2pvHP9JEO7kZn1wotoN+wpixEXVOX6XhOqotAf
 Py7BsuQTR556v+Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CU5QfUiY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gd601Ffq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOcAqkAuhAmuQs4Pc4hz0xfBFtyvIAn0tePpQ1zREGg=;
 b=CU5QfUiY5OxsAgyI6RQaM3gdS7gynqJrY4G63X9aZQ1175QIRgnZefserT0Rk96IxzEVT2
 80uTDFv5otE5EnNUwBocXjhVrW0823ukyqjFZCUuaoVro0ZK3UoaiMDtP7n07G9L6OOGhD
 fcKUThWM/oPWNNtiYBMrSHoBRwzRA1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOcAqkAuhAmuQs4Pc4hz0xfBFtyvIAn0tePpQ1zREGg=;
 b=gd601FfqPZN4fgqiRa6ebA2WXt4grBiyvZOzZk+6y/fgkrPwjPH+CbTU0cPO0LL/2iZX+e
 6gKlkzPs5VcywVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD7163EA66;
 Fri, 26 Dec 2025 21:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JW1Gu77TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 06/25] migration: Move postcopy_try_recover into
 migration_incoming_process
Date: Fri, 26 Dec 2025 18:19:08 -0300
Message-ID: <20251226211930.27565-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B89475BCC4
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

The postcopy_try_recover() call doesn't need to be duplicated, move it
into migration_incoming_process().

This removes code from migration_fd_process_incoming() so it can be
removed in the near future.

(the diff is a bit strange because migration_incoming_process() was
moved after postcopy_try_recover())

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 974313944c..f2933f7789 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -947,12 +947,6 @@ static void migration_incoming_setup(QEMUFile *f)
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
@@ -986,12 +980,19 @@ static bool postcopy_try_recover(void)
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


