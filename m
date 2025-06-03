Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B26BC5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbr-0006S4-Vv; Mon, 02 Jun 2025 21:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbp-0006RO-9A
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbn-0001S0-8m
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C00B1F38D;
 Tue,  3 Jun 2025 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VejkIVv0zcF0IoW2WMiP2MpgZf8Ky81lWE39y2/0xhU=;
 b=lttpkKKIb3MgECjo4hDObre7KNjoL5Z+r6Zug3vdt8T7hjrI0WIIUPOaiG1ijBRJa/+ITV
 PE19eoCRzshMBAHbuxdlbEIqScBXwnydpOODdoW0Pp45VcISiHsSf/vgDADuZIJ/Z16jKF
 jhUd53GBBUideG7+ZrIsABwP5h1rKyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VejkIVv0zcF0IoW2WMiP2MpgZf8Ky81lWE39y2/0xhU=;
 b=TciV3uEfyZnZix/qBRxyq2GVWb02oTiEp7Qtf7+PSgEFvnob3ChBSqIKwNdbRtGDckrynp
 wctdh518UgZmhTDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lttpkKKI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TciV3uEf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VejkIVv0zcF0IoW2WMiP2MpgZf8Ky81lWE39y2/0xhU=;
 b=lttpkKKIb3MgECjo4hDObre7KNjoL5Z+r6Zug3vdt8T7hjrI0WIIUPOaiG1ijBRJa/+ITV
 PE19eoCRzshMBAHbuxdlbEIqScBXwnydpOODdoW0Pp45VcISiHsSf/vgDADuZIJ/Z16jKF
 jhUd53GBBUideG7+ZrIsABwP5h1rKyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VejkIVv0zcF0IoW2WMiP2MpgZf8Ky81lWE39y2/0xhU=;
 b=TciV3uEfyZnZix/qBRxyq2GVWb02oTiEp7Qtf7+PSgEFvnob3ChBSqIKwNdbRtGDckrynp
 wctdh518UgZmhTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB6713700;
 Tue,  3 Jun 2025 01:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHFuEw9SPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/21] migration: Add a flag to track block-bitmap-mapping
 input
Date: Mon,  2 Jun 2025 22:37:54 -0300
Message-Id: <20250603013810.4772-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1C00B1F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The QAPI converts an empty list on the block-bitmap-mapping input into
a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
Fix block_bitmap_mapping migration") started using the
s->parameters.has_block_bitmap_mapping field to tell when the user has
passed in an empty list vs. when no list has been passed at all.

However, using the has_block_bitmap_mapping field of s->parameters is
only possible because MigrationParameters has had its members made
optional due to historical reasons.

In order to make improvements to the way configuration options are set
for a migration, we'd like to reduce the usage of the has_* fields of
the global configuration object (s->parameters).

Add a separate boolean to track the status of the block_bitmap_mapping
option.

(this was verified to not regress iotest 300, which is the test that
3cba22c9ad refers to)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h | 7 +++++++
 migration/options.c   | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84..ab797540b0 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -510,6 +510,13 @@ struct MigrationState {
     bool rdma_migration;
 
     GSource *hup_source;
+
+    /*
+     * The block-bitmap-mapping option is allowed to be an emtpy list,
+     * therefore we need a way to know wheter the user has given
+     * anything as input.
+     */
+    bool has_block_bitmap_mapping;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index f64e141394..cf77826204 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -685,7 +685,7 @@ bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.has_block_bitmap_mapping;
+    return s->has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
@@ -989,7 +989,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
 
-    if (s->parameters.has_block_bitmap_mapping) {
+    if (s->has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
         params->block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
@@ -1469,7 +1469,7 @@ static void migrate_params_apply(MigrationParameters *params)
         qapi_free_BitmapMigrationNodeAliasList(
             s->parameters.block_bitmap_mapping);
 
-        s->parameters.has_block_bitmap_mapping = true;
+        s->has_block_bitmap_mapping = true;
         s->parameters.block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
-- 
2.35.3


