Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF16EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyz0-0001Kk-Rh; Fri, 28 Aug 2026 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyw-0001JY-3w
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyt-0008BB-BK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC2B51FD66;
 Fri, 28 Aug 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb8Z5SCDyJWp7TdpiITGRQvtQ0lXojHnbL+MAwG9tnw=;
 b=fPzYQ+fafM6yfMYiPJR+WziDDACJnLy0KU2dp3KnztpEWRCfYX4yNeV8HNvMozKQ27+enE
 cVHQZZ4ROKmFPyfjRb9Z+X+nb/qB9/xDH4Y+Wd2YuDIXS4sklJXk31Wf8PbenRN+lR/zMC
 UVslGR5Iii/WJYCAmbk8RtHXv9A/dw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb8Z5SCDyJWp7TdpiITGRQvtQ0lXojHnbL+MAwG9tnw=;
 b=Z/pcjmZ/dA3MDOTTEQ8Wkj5wVGkVAfsS+9xDI5WIvZyF2wIkW7IEPE1Cr6yiajm7UvbOAv
 BYtf1/e6j2OrZ8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb8Z5SCDyJWp7TdpiITGRQvtQ0lXojHnbL+MAwG9tnw=;
 b=Rb4BiYoZvWBWsky638zse+ukJU/2b/sFkzNfPgtE+GhIbOovMKUp+xRYTOWbSRUHpEdsrd
 kATQsdPvy8q0cZCO2DaffcGy4pK/IFqmswon+UHnG1cGiGcn6prcWxiTzlSENwkW51b090
 dDOEjj1A5OzztL7wq8fb37dVTcf2c24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb8Z5SCDyJWp7TdpiITGRQvtQ0lXojHnbL+MAwG9tnw=;
 b=kk7sJuEDnflcevRrIGZvpeutaA8rn1V+I+0j8G27YNiznACoGjsHGePunlAztgzUrEs2IV
 0kbWsQLAqmpI7iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A05FC13686;
 Fri, 28 Aug 2026 15:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QBUqHDywkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL v2 03/30] migration: Rename postcopy_listen_thread_bh
Date: Fri, 28 Aug 2026 12:58:18 -0300
Message-ID: <20260828155845.2874508-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Rename postcopy_listen_thread_bh to postcopy_incoming_complete_bh for a
more robust naming scheme. This will allow fast snapshot load to use
this bh funciton directly to cleanup the incoming state.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7dead1c68fc..2286d25f8c6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2109,7 +2109,7 @@ bool postcopy_is_paused(MigrationStatus status)
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
 
-static void postcopy_listen_thread_bh(void *opaque)
+static void postcopy_incoming_complete_bh(void *opaque)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -2217,7 +2217,7 @@ out:
     rcu_unregister_thread();
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
-    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
+    migration_bh_schedule(postcopy_incoming_complete_bh, NULL);
 
     object_unref(OBJECT(migr));
 
-- 
2.53.0


