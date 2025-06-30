Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1427C83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKfU-0002jQ-0V; Mon, 30 Jun 2025 15:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfL-0002dC-6D
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfI-0007U1-EP
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7906A1F393;
 Mon, 30 Jun 2025 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUB/IZD2jkUuleGLSl99i/f1/dQ8eMW7zGyUow/gd5k=;
 b=eco0fj8QmGM0ZyO9yLAUo7vvdhJX4AkZb8ftx8Cp7Vw6UWDXnWAGWOioSqaLllr4rEcVDz
 O5jwHI8uBJylZnqRM6VVXtnkQapo2P8sFGY3kilXpxworV6q2LPtTRF3u4SC0PkgJyQJPk
 zIL5KSGHzkEn8gHb/JGx/zHLTVEV3xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUB/IZD2jkUuleGLSl99i/f1/dQ8eMW7zGyUow/gd5k=;
 b=Yq43iG+T7xoGci1/id7FGrG0wLi8J1UdL3SxlrpExN1l/kHxN+El+15rWF79ZgOosjWWfd
 ZZAaEJJ7Qp9+4vBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUB/IZD2jkUuleGLSl99i/f1/dQ8eMW7zGyUow/gd5k=;
 b=SHH7rllYEae0mqdHrzzRyi1avl9WSFJbI0DtdfNgUIN5ljady2blLdwnmZBzFFz/gQmTuN
 Tm4EjFzj9LZJ6Nroau9zK2PhnaCcwi97e8nkeMJq33n1ONC7ugneRPeA++19qC3DK2mzA5
 v9BzqX0wMduLkLjOLl3EQx8luEiCT9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUB/IZD2jkUuleGLSl99i/f1/dQ8eMW7zGyUow/gd5k=;
 b=Ltr+FmnUjVRZKi0Ck2xDuIScnl5MrkbkXK2a6s5pjBlgCP3c1ia4DTCXspikTOmhqT1mb6
 tIHu0nTYauhsq2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6E21399F;
 Mon, 30 Jun 2025 19:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iIwvG6PsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 07/24] migration: Add a flag to track block-bitmap-mapping
 input
Date: Mon, 30 Jun 2025 16:58:56 -0300
Message-Id: <20250630195913.28033-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

The QAPI converts an empty list on the block-bitmap-mapping input into
a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
Fix block_bitmap_mapping migration") started using the
s->parameters.has_block_bitmap_mapping field to tell when the user has
passed in an empty list vs. when no list has been passed at all.

Using s->parameters.has_block_bitmap_mapping field is only possible
because MigrationParameters has had its members made optional due to
historical reasons.

In order to make improvements to the way configuration options are set
for a migration, we'd like to reduce the open-coded usage of the has_*
fields of the global configuration object (s->parameters).

Add a separate boolean to track the status of the block_bitmap_mapping
option.

No functional change intended.

(this was verified to not regress iotest 300, which is the test that
3cba22c9ad refers to)

CC: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 3 ++-
 migration/migration.h          | 7 +++++++
 migration/options.c            | 6 +++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 82cd2dcb8e..f29bdc12a8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -240,6 +240,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
+    MigrationState *s = migrate_get_current();
 
     params = qmp_query_migrate_parameters(NULL);
 
@@ -322,7 +323,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
                        params->tls_authz->u.s);
 
-        if (params->has_block_bitmap_mapping) {
+        if (s->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
 
             monitor_printf(mon, "%s:\n",
diff --git a/migration/migration.h b/migration/migration.h
index 739289de93..84c3007ab8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -510,6 +510,13 @@ struct MigrationState {
     bool rdma_migration;
 
     GSource *hup_source;
+
+    /*
+     * The block-bitmap-mapping option is allowed to be an emtpy list,
+     * therefore we need a way to know whether the user has given
+     * anything as input.
+     */
+    bool has_block_bitmap_mapping;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index 1f8a977865..cb5855303a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -736,7 +736,7 @@ bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.has_block_bitmap_mapping;
+    return s->has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
@@ -1033,7 +1033,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
 
-    if (s->parameters.has_block_bitmap_mapping) {
+    if (s->has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
         params->block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
@@ -1513,7 +1513,7 @@ static void migrate_params_apply(MigrationParameters *params)
         qapi_free_BitmapMigrationNodeAliasList(
             s->parameters.block_bitmap_mapping);
 
-        s->parameters.has_block_bitmap_mapping = true;
+        s->has_block_bitmap_mapping = true;
         s->parameters.block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
-- 
2.35.3


