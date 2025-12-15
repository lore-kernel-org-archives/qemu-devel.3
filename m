Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E45D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdE-0002k7-Dr; Mon, 15 Dec 2025 17:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdA-0002jZ-Oe
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGd9-0002eX-5p
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B39E35BDE8;
 Mon, 15 Dec 2025 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJvG76Q4MRyf/6x4TyO7///Sqex9FH/YFLAPqQtRKyE=;
 b=Av+/yO4Loz+zPsmOSjQXCmPVl5ovGZ3i+1WZ+VzQiwjVmK4iWn35ztUPPVqsNlxVarmwZl
 O72CnpgpfY5wFLNlC5A2TeOAYwqP51xmeDv4IxPF0if82LJ5NHN540xoHvW9E7i6nIuJE0
 gLd7q4umycFDndzGqOGtW3uLSb8w+ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJvG76Q4MRyf/6x4TyO7///Sqex9FH/YFLAPqQtRKyE=;
 b=TSy80n3b0sb+IFtvRTBPqmiqycCNGtifFBY982XtBYdtp5rypP9V/IZTKFP/1fSE+2JtaB
 jv9hXvkJkhrJJ0BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KcKHjHXf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WE2+bIwy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJvG76Q4MRyf/6x4TyO7///Sqex9FH/YFLAPqQtRKyE=;
 b=KcKHjHXfON0UDEmizKGz0UMf1lk/M+RolFO7yCqXoaqu0I63aHEjQC53BzWhD05kUFFqSF
 Bs+Ibg2ICbV1P6f7tvHjb4kav1Zlo1O1RLlnKDJdO7/JNR+DEeQO+jW8BYyKwkFijdsH0O
 3NJZNzhW1fOSgSRtbXO7cZ5WGpqfZQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJvG76Q4MRyf/6x4TyO7///Sqex9FH/YFLAPqQtRKyE=;
 b=WE2+bIwyw0rZ0B+MooX4Wu2dzcZDK8+FBt06t1be007BlYfdCc5avgjnqkuEABdJxgEDFF
 g+D01Kh3mcIzwcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBE4D3EA63;
 Mon, 15 Dec 2025 22:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sNjjKSmFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3 09/51] migration: Add a flag to track block-bitmap-mapping
 input
Date: Mon, 15 Dec 2025 18:59:55 -0300
Message-ID: <20251215220041.12657-10-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B39E35BDE8
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
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 3 ++-
 migration/migration.h          | 7 +++++++
 migration/options.c            | 6 +++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a83aba9630..4f9f5800de 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -321,6 +321,7 @@ static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
+    MigrationState *s = migrate_get_current();
 
     params = qmp_query_migrate_parameters(NULL);
 
@@ -407,7 +408,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
 
-        if (params->has_block_bitmap_mapping) {
+        if (s->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
 
             monitor_printf(mon, "%s:\n",
diff --git a/migration/migration.h b/migration/migration.h
index 213b33fe6e..20802596fb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -514,6 +514,13 @@ struct MigrationState {
     QemuEvent postcopy_package_loaded_event;
 
     GSource *hup_source;
+
+    /*
+     * The block-bitmap-mapping option is allowed to be an empty list,
+     * therefore we need a way to know whether the user has given
+     * anything as input.
+     */
+    bool has_block_bitmap_mapping;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index e7f4aeaf03..5ef30e0f8d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -784,7 +784,7 @@ bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.has_block_bitmap_mapping;
+    return s->has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
@@ -1069,7 +1069,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
 
-    if (s->parameters.has_block_bitmap_mapping) {
+    if (s->has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
         params->block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
@@ -1557,7 +1557,7 @@ static void migrate_params_apply(MigrationParameters *params)
         qapi_free_BitmapMigrationNodeAliasList(
             s->parameters.block_bitmap_mapping);
 
-        s->parameters.has_block_bitmap_mapping = true;
+        s->has_block_bitmap_mapping = true;
         s->parameters.block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
-- 
2.51.0


