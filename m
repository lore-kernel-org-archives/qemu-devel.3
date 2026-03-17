Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C83EFEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z59-0003yP-2Q; Tue, 17 Mar 2026 14:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z54-0003wL-8C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z51-00035i-Hg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23F554D3BF;
 Tue, 17 Mar 2026 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lssqIUf9TDxBTExNNOE76ZmyHuhCOxsdXOC6b5j4Axo=;
 b=Z0+FK3CKOxyYDTmXe4L9KI4j9hGnQRmgngBSKbpI7/flBvfHHeiSvKhCeFH9Xg9ghIi3Kv
 Zv3kAT1DF4NRvquuGQ+liVzgEA5Z6CyDEP9qXe2kvweiNNKtLH68FYPHMQMCEIMV7DfDdS
 Ww1GEm9gdxdKtPnpv0EwiWV7zpRPcrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lssqIUf9TDxBTExNNOE76ZmyHuhCOxsdXOC6b5j4Axo=;
 b=g3fR9Orne/UoGlTIuQ5owEj3lIQmtMZz2jR7i9JgRgcygnaqaE4qFNSdtrav1EV4lWHPOX
 HE+JjrzqHHRBEZDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z0+FK3CK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g3fR9Orn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lssqIUf9TDxBTExNNOE76ZmyHuhCOxsdXOC6b5j4Axo=;
 b=Z0+FK3CKOxyYDTmXe4L9KI4j9hGnQRmgngBSKbpI7/flBvfHHeiSvKhCeFH9Xg9ghIi3Kv
 Zv3kAT1DF4NRvquuGQ+liVzgEA5Z6CyDEP9qXe2kvweiNNKtLH68FYPHMQMCEIMV7DfDdS
 Ww1GEm9gdxdKtPnpv0EwiWV7zpRPcrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lssqIUf9TDxBTExNNOE76ZmyHuhCOxsdXOC6b5j4Axo=;
 b=g3fR9Orne/UoGlTIuQ5owEj3lIQmtMZz2jR7i9JgRgcygnaqaE4qFNSdtrav1EV4lWHPOX
 HE+JjrzqHHRBEZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F31834273B;
 Tue, 17 Mar 2026 18:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJrHLSCcuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 04/10] migration/multifd: Fix leaks of TLS error objects
Date: Tue, 17 Mar 2026 15:23:14 -0300
Message-ID: <20260317182320.31991-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
References: <20260317182320.31991-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23F554D3BF
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-5-farosas@suse.de
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


