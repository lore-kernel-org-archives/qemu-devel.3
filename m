Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A98C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTm-0003XL-8H; Fri, 21 Jun 2024 13:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTj-0003W8-U5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:15 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTi-0003OL-9R
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 176D121B41;
 Fri, 21 Jun 2024 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGlDNuyeK6ZUFejVGI4gg5g94gsU8TO4M2YH0XyWtrQ=;
 b=B1ZkBgmn/2O9P6pJHQ+10vIYtaT3AXJHdLhD1sYlWDSPejDQfhRv5U8l1pG9lqFp3P4/P+
 fWzK3KII+TtThp8dqq/g8QMQ/kO7ARRzsBdVLHDhh8Lhl/8TQR3GS1/xyOl6PqwhZ1unVe
 bl8AzVCSuItOglEzIvTOey+FF8vuHxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGlDNuyeK6ZUFejVGI4gg5g94gsU8TO4M2YH0XyWtrQ=;
 b=sUq0MOgo2Yq2EDGcBFv9RauaFGYcluTZy5e+VaL7KFGtzPYVFXsd+LRKRkvbtblyFT7aqB
 gaCyI6b/273X0OAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGlDNuyeK6ZUFejVGI4gg5g94gsU8TO4M2YH0XyWtrQ=;
 b=B1ZkBgmn/2O9P6pJHQ+10vIYtaT3AXJHdLhD1sYlWDSPejDQfhRv5U8l1pG9lqFp3P4/P+
 fWzK3KII+TtThp8dqq/g8QMQ/kO7ARRzsBdVLHDhh8Lhl/8TQR3GS1/xyOl6PqwhZ1unVe
 bl8AzVCSuItOglEzIvTOey+FF8vuHxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGlDNuyeK6ZUFejVGI4gg5g94gsU8TO4M2YH0XyWtrQ=;
 b=sUq0MOgo2Yq2EDGcBFv9RauaFGYcluTZy5e+VaL7KFGtzPYVFXsd+LRKRkvbtblyFT7aqB
 gaCyI6b/273X0OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D683713AAA;
 Fri, 21 Jun 2024 17:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wM2qJn++dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/28] migration: Cleanup incoming migration setup state change
Date: Fri, 21 Jun 2024 14:54:26 -0300
Message-Id: <20240621175434.31180-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

Destination QEMU can setup incoming ports for two purposes: either a fresh
new incoming migration, in which QEMU will switch to SETUP for channel
establishment, or a paused postcopy migration, in which QEMU will stay in
POSTCOPY_PAUSED until kicking off the RECOVER phase.

Now the state machine worked on dest node for the latter, only because
migrate_set_state() implicitly will become a noop if the current state
check failed.  It wasn't clear at all.

Clean it up by providing a helper migration_incoming_state_setup() doing
proper checks over current status.  Postcopy-paused will be explicitly
checked now, and then we can bail out for unknown states.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 795b30f0d0..41a88fc50a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -618,6 +618,29 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+static bool
+migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
+{
+    MigrationStatus current = mis->state;
+
+    if (current == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /*
+         * Incoming postcopy migration will stay in PAUSED state even if
+         * reconnection happened.
+         */
+        return true;
+    }
+
+    if (current != MIGRATION_STATUS_NONE) {
+        error_setg(errp, "Illegal migration incoming state: %s",
+                   MigrationStatus_str(current));
+        return false;
+    }
+
+    migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
@@ -656,8 +679,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
-                      MIGRATION_STATUS_SETUP);
+    if (!migration_incoming_state_setup(mis, errp)) {
+        return;
+    }
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
-- 
2.35.3


