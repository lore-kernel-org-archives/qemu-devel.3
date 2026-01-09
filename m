Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D3CD1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBns-0003Wk-Lh; Fri, 09 Jan 2026 07:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnk-0003Ok-9P
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnh-0007Fz-VZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE9C95BE9E;
 Fri,  9 Jan 2026 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=j1kQ5RMr0YeYCZVWR3Kip33Z0X/V1b2opF6U+oqo//cQ6Yzc3Vyjs3B5vO5uS9XVZLS+fi
 sy7NA4wrKUMSUollq06EkJgeVVnv8qYioXiubsPlXjva8qto0DSBIYqZugA2K7LD2qAqXS
 XJ2+QhPjysZyJXTgkRhf/wNyDWRIyhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=0QQpLIacZ5A6ZKfv/i0vqX6ecchI5dPqO94KVISXGGvN4knNzBigIlrOAAjfGkTe65Kl8e
 Mq4kctburVBaXCCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=Oo0sr2+UUGwKZpAP1u8k2ykviBgK9gNyU8p55zhWAc5gA9ZSOAo6T+XaPYzNqOstvFW+1U
 OTSC07O/pqOrKWXRWkTAW6wm7VjUZZUGKriwpDER9DXDQ0yDuJktXru5eAGvAS77x/dFT/
 UB1Kben1ZttB8VvHfa98Igb7qmxlJw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVHzD7zmFjhne5W/RXbNpwoFhZs/1TzOjF6NKcxgmNE=;
 b=ykK3NtgTBHMOTOpP9pWrQ1a80h1BttGhaw23MkdhPy/ii3ywXjKXGFp6gH5Wzr41irInBc
 KlAg7lkK9rB1kyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F973EA63;
 Fri,  9 Jan 2026 12:40:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yE7pCVj3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:40:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 05/25] migration: Move postcopy_try_recover into
 migration_incoming_process
Date: Fri,  9 Jan 2026 09:40:21 -0300
Message-ID: <20260109124043.25019-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
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


