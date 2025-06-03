Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2845BC5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGc3-0006Ym-ML; Mon, 02 Jun 2025 21:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGc2-0006YX-64
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGc0-0001Ua-KP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E50F1F441;
 Tue,  3 Jun 2025 01:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HSojfG//HAWlMfDLj1Grw57riRmTWe09NMmrKcaUY4=;
 b=U2M+sIoIfSxVH+7z+u169Y+sTLh1bWaA5edlTB2g5dTz2gmONZdrPjBjVww4mnw8VOT0aQ
 gfZWf0D94hLSykonmDBPxLcdj4LjpTlahPSmRktkR6iwKTOAmXUlhwD9pqJ444K03d2lvI
 JcCydiDfJtHRTWamf0paq/wXPUVEDeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HSojfG//HAWlMfDLj1Grw57riRmTWe09NMmrKcaUY4=;
 b=1ZIGDDxkAlCzhu26EqSnc+CbxmcxVtVFwBId1L+bw0Nhl0DtV9z8xlZTA32R5LeCIe22Qf
 AvTnRYebDcPHBdAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HSojfG//HAWlMfDLj1Grw57riRmTWe09NMmrKcaUY4=;
 b=U2M+sIoIfSxVH+7z+u169Y+sTLh1bWaA5edlTB2g5dTz2gmONZdrPjBjVww4mnw8VOT0aQ
 gfZWf0D94hLSykonmDBPxLcdj4LjpTlahPSmRktkR6iwKTOAmXUlhwD9pqJ444K03d2lvI
 JcCydiDfJtHRTWamf0paq/wXPUVEDeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HSojfG//HAWlMfDLj1Grw57riRmTWe09NMmrKcaUY4=;
 b=1ZIGDDxkAlCzhu26EqSnc+CbxmcxVtVFwBId1L+bw0Nhl0DtV9z8xlZTA32R5LeCIe22Qf
 AvTnRYebDcPHBdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9550913700;
 Tue,  3 Jun 2025 01:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBKCFRNSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/21] migration: Set block_bitmap_mapping unconditionally in
 query-migrate-parameters
Date: Mon,  2 Jun 2025 22:37:56 -0300
Message-Id: <20250603013810.4772-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

The response type of query-migrate-parameters is MigrationParameters,
the members of which are marked as optional in
migration.json. However, the design of query-migrate-parameters is
that all members are to be non-optional.

The optionality is an attempt at compatibility with
MigrateSetParameters, which needs it to allow migrate-set-parameters
to be given only a subset of parameters.

To satisfy the design of query-migrate-parameters, the
qmp_query_migrate_parameters function sets all (but one) has_* fields
of MigrationParameters to true before returning. The
block-bitmap-mapping parameter is instead set conditionally. This is
incorrect.

Since block-bitmap-mapping is allowed to be passed as input by the
user as an empty list, technically the empty list value output in
query-migrate-parameters has always been valid for that
parameter. Make the parameter non-optional like the rest of
MigrationParameters.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 36 ++++++++++++++++------------------
 migration/options.c            | 10 ++++------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index aacffdc532..685c8ebd53 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -240,6 +240,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
+    const BitmapMigrationNodeAliasList *bmnal;
 
     params = qmp_query_migrate_parameters(NULL);
 
@@ -319,29 +320,26 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
                        params->tls_authz ? params->tls_authz->u.s : "");
 
-        if (params->has_block_bitmap_mapping) {
-            const BitmapMigrationNodeAliasList *bmnal;
+        assert(params->has_block_bitmap_mapping);
+        monitor_printf(mon, "%s:\n",
+                       MigrationParameter_str(
+                           MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
 
-            monitor_printf(mon, "%s:\n",
-                           MigrationParameter_str(
-                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
+        for (bmnal = params->block_bitmap_mapping;
+             bmnal;
+             bmnal = bmnal->next)
+        {
+            const BitmapMigrationNodeAlias *bmna = bmnal->value;
+            const BitmapMigrationBitmapAliasList *bmbal;
 
-            for (bmnal = params->block_bitmap_mapping;
-                 bmnal;
-                 bmnal = bmnal->next)
-            {
-                const BitmapMigrationNodeAlias *bmna = bmnal->value;
-                const BitmapMigrationBitmapAliasList *bmbal;
+            monitor_printf(mon, "  '%s' -> '%s'\n",
+                           bmna->node_name, bmna->alias);
 
-                monitor_printf(mon, "  '%s' -> '%s'\n",
-                               bmna->node_name, bmna->alias);
+            for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
+                const BitmapMigrationBitmapAlias *bmba = bmbal->value;
 
-                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
-                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
-
-                    monitor_printf(mon, "    '%s' -> '%s'\n",
-                                   bmba->name, bmba->alias);
-                }
+                monitor_printf(mon, "    '%s' -> '%s'\n",
+                               bmba->name, bmba->alias);
             }
         }
 
diff --git a/migration/options.c b/migration/options.c
index d4021bc520..190001f8ac 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -989,12 +989,10 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
 
-    if (s->has_block_bitmap_mapping) {
-        params->has_block_bitmap_mapping = true;
-        params->block_bitmap_mapping =
-            QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       s->parameters.block_bitmap_mapping);
-    }
+    params->has_block_bitmap_mapping = true;
+    params->block_bitmap_mapping =
+        QAPI_CLONE(BitmapMigrationNodeAliasList,
+                   s->parameters.block_bitmap_mapping);
 
     params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-- 
2.35.3


