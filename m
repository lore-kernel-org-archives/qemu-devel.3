Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7CBFD2D9B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxZA-0004Ps-Pi; Tue, 10 Mar 2026 09:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZ8-0004Nh-S7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:07 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZ7-0007LC-2r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 779244D211;
 Tue, 10 Mar 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJIdpo4r88UPSBhoejSEqlOOpGzHBhEaMd5/99QldwA=;
 b=Hu3VT7M95KaM5Pm1QQEcyjcm2ELIQDEnNaqtk94N+DxoXe6/8b976aXroFvCYU8V/Fbfvp
 QK80cfcHxvcdvPR42OEqhX+b4tVtQu5TdQpOgyU7e8Tv6t1VVaT2yfpL2rcEEeSP7+abn8
 OSCJCBKSKd9nkLCEuG0rEblO236FwKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJIdpo4r88UPSBhoejSEqlOOpGzHBhEaMd5/99QldwA=;
 b=4WNm/ZFg39Pl1Q06Z3ZI5nK70gUm7stPNSiHcmkIx9qpzUg3ql+ee+a1PlcRrLa0l+XzOE
 ikKmJoOhocxCfGAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hu3VT7M9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4WNm/ZFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJIdpo4r88UPSBhoejSEqlOOpGzHBhEaMd5/99QldwA=;
 b=Hu3VT7M95KaM5Pm1QQEcyjcm2ELIQDEnNaqtk94N+DxoXe6/8b976aXroFvCYU8V/Fbfvp
 QK80cfcHxvcdvPR42OEqhX+b4tVtQu5TdQpOgyU7e8Tv6t1VVaT2yfpL2rcEEeSP7+abn8
 OSCJCBKSKd9nkLCEuG0rEblO236FwKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJIdpo4r88UPSBhoejSEqlOOpGzHBhEaMd5/99QldwA=;
 b=4WNm/ZFg39Pl1Q06Z3ZI5nK70gUm7stPNSiHcmkIx9qpzUg3ql+ee+a1PlcRrLa0l+XzOE
 ikKmJoOhocxCfGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 503823F4B3;
 Tue, 10 Mar 2026 13:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Fb/Be8isGnFcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:55:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 8/8] migration/multifd: Fix leaks of TLS error objects
Date: Tue, 10 Mar 2026 10:55:40 -0300
Message-ID: <20260310135540.8679-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 779244D211
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


