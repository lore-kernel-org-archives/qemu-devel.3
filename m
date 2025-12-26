Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE73E8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFE7-0001J8-Sp; Fri, 26 Dec 2025 16:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFE4-0001II-9s
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:56 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFE2-0003ht-UE
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:19:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC720336A8;
 Fri, 26 Dec 2025 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSahG4mmiJEfSqy0FxSwFr034hSj4sJZWVFPM3kd81o=;
 b=CyUlMLJ2sUZs+IAmRzQUibtpILB/bkXv2j9OxPraBnAQ+z5H9o/86SlsxbMVbYtXStbSF5
 PMP6WotTIY0V2qEhQ6bXgWdgZTqxsb09bZEM4dMViUUDOl84pJsC/p5w9bPM/B94ioblbC
 EfiuvAB9xSfet+1PR2W0SxRnLByap/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSahG4mmiJEfSqy0FxSwFr034hSj4sJZWVFPM3kd81o=;
 b=Rf8yV/ZqAzalpXCLQQsm/5E8Veydp8cxJAcLGZonk9B6TvBWAtcHnokka84V7aybOdagWl
 8Fv+8GAwptYlxACA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSahG4mmiJEfSqy0FxSwFr034hSj4sJZWVFPM3kd81o=;
 b=CyUlMLJ2sUZs+IAmRzQUibtpILB/bkXv2j9OxPraBnAQ+z5H9o/86SlsxbMVbYtXStbSF5
 PMP6WotTIY0V2qEhQ6bXgWdgZTqxsb09bZEM4dMViUUDOl84pJsC/p5w9bPM/B94ioblbC
 EfiuvAB9xSfet+1PR2W0SxRnLByap/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSahG4mmiJEfSqy0FxSwFr034hSj4sJZWVFPM3kd81o=;
 b=Rf8yV/ZqAzalpXCLQQsm/5E8Veydp8cxJAcLGZonk9B6TvBWAtcHnokka84V7aybOdagWl
 8Fv+8GAwptYlxACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D46423EA63;
 Fri, 26 Dec 2025 21:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GMTRJPH7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 08/25] migration: Free the error earlier in the resume case
Date: Fri, 26 Dec 2025 18:19:10 -0300
Message-ID: <20251226211930.27565-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.982];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

Freeing the error at migration_connect() is redundant in the normal
migration case. The freeing already happened at migrate_init():

qmp_migrate()
-> migrate_prepare()
   -> migrate_init()
-> qmp_migrate_finish()
   -> *_start_outgoing_migration()
   -> migration_channel_connect()
      -> migration_connect()

For the resume case, migrate_prepare() returns early and doesn't reach
migrate_init(). Move the extra migrate_error_free() call to
migrate_prepare() along with the resume check.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4b1afcab24..a56f8fb05e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2088,6 +2088,13 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
                           MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
 
+        /*
+         * If there's a previous error, free it and prepare for
+         * another one. For the non-resume case, this happens at
+         * migrate_init() below.
+         */
+        migrate_error_free(s);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -4016,13 +4023,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    /*
-     * If there's a previous error, free it and prepare for another one.
-     * Meanwhile if migration completes successfully, there won't have an error
-     * dumped when calling migration_cleanup().
-     */
-    migrate_error_free(s);
-
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-- 
2.51.0


