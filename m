Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C881103E2E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCl-0005Pi-9H; Wed, 11 Mar 2026 17:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCi-0005PI-Ok
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCg-00037U-P2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D77A15BD9A;
 Wed, 11 Mar 2026 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFpzO2GOmQFZ7QvaZSsKWOWuuMK2/7Giq6BtAr8xSjQ=;
 b=FW5kxxaN4HIa8fR6goYBzCOVNLOLN5e9inKMXaB7uxk/b2tW+3+CEpRP6IVss05izNrOWi
 UbRmD/mLjvTo8hCR2caxuaAPzVHWyxSF7PEm0FZ/fTbHxxzMCodx8nzehlxKvnLCg+3lal
 UcAhdKVWq6fsdGtd7euiMIkoqxONvww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFpzO2GOmQFZ7QvaZSsKWOWuuMK2/7Giq6BtAr8xSjQ=;
 b=xtqjbZEoe9oYc2pCP1n/gDw6ovjRavEkLsVf+7EEVbzpNv4M4kcbPZ6Vu6OACyWwHclPGu
 w8cwE1SB+OABV/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFpzO2GOmQFZ7QvaZSsKWOWuuMK2/7Giq6BtAr8xSjQ=;
 b=FW5kxxaN4HIa8fR6goYBzCOVNLOLN5e9inKMXaB7uxk/b2tW+3+CEpRP6IVss05izNrOWi
 UbRmD/mLjvTo8hCR2caxuaAPzVHWyxSF7PEm0FZ/fTbHxxzMCodx8nzehlxKvnLCg+3lal
 UcAhdKVWq6fsdGtd7euiMIkoqxONvww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFpzO2GOmQFZ7QvaZSsKWOWuuMK2/7Giq6BtAr8xSjQ=;
 b=xtqjbZEoe9oYc2pCP1n/gDw6ovjRavEkLsVf+7EEVbzpNv4M4kcbPZ6Vu6OACyWwHclPGu
 w8cwE1SB+OABV/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29C8F3FC1B;
 Wed, 11 Mar 2026 21:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IDcWOObfsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 4/5] migration/multifd: Fix leaks of TLS error objects
Date: Wed, 11 Mar 2026 18:34:17 -0300
Message-ID: <20260311213418.16951-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
References: <20260311213418.16951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The code currently ignores errors from multifd threads that happen
after a first error has already been propagated. Make sure the
subsequent errors are freed appopriately.

This fixes a leak of the TLS session->werr when the certificate
validation fails after multifd threads are already running. The first
writes on the threads will fail deep into the gnutls stack.

No need to check if(err) because the callers are all under a similar
check.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 8b9ed84805..035cb70f7b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -412,28 +412,25 @@ bool multifd_send(MultiFDSendData **send_data)
 /* Multifd send side hit an error; remember it and prepare to quit */
 static void multifd_send_error_propagate(Error *err)
 {
+    MigrationState *s = migrate_get_current();
+
     /*
-     * We don't want to exit each threads twice.  Depending on where
-     * we get the error, or if there are two independent errors in two
-     * threads at the same time, we can end calling this function
-     * twice.
+     * There may be independent errors in each thread. Propagate the
+     * first and free the subsequent ones.
      */
     if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
+        error_free(err);
         return;
     }
 
-    if (err) {
-        MigrationState *s = migrate_get_current();
+    migrate_error_propagate(s, err);
 
-        migrate_error_propagate(s, err);
-
-        if (s->state == MIGRATION_STATUS_SETUP ||
-            s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
-            s->state == MIGRATION_STATUS_DEVICE ||
-            s->state == MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILING);
-        }
+    if (s->state == MIGRATION_STATUS_SETUP ||
+        s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
+        s->state == MIGRATION_STATUS_DEVICE ||
+        s->state == MIGRATION_STATUS_ACTIVE) {
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_FAILING);
     }
 }
 
-- 
2.51.0


