Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E554C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXc-0006f3-MH; Wed, 29 Jan 2025 11:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWM-0004Bo-Ps
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:33 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWJ-0005R9-3R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7EA31F383;
 Wed, 29 Jan 2025 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvmiNBg7a1uiccKIZL/s+wkT4KMkuTXaypS516pqGRs=;
 b=MiKgEGcuk1qPdv7/oVGCtYXq7ztRDIcGeH8WKUQNtfeaDcfew5MIg7kB/ZPllcrXolJCTz
 p15mYpDqomgxK++VzmpMKrpvsxGeXLcCzIRHLQwZalwMVcGGNtyeTFxQDZwVz9Clrj+nfk
 0YaSOopFmv248ZoJik/0KO0i4gp9J8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvmiNBg7a1uiccKIZL/s+wkT4KMkuTXaypS516pqGRs=;
 b=xmVAJ5c8ueMHmTcVxAkT7pJt8vlj0/WtO6odznFTB4519aEH+42zkBN3TpvfmHnjVf2YKS
 xbloBWgJPxdCEdCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MiKgEGcu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xmVAJ5c8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvmiNBg7a1uiccKIZL/s+wkT4KMkuTXaypS516pqGRs=;
 b=MiKgEGcuk1qPdv7/oVGCtYXq7ztRDIcGeH8WKUQNtfeaDcfew5MIg7kB/ZPllcrXolJCTz
 p15mYpDqomgxK++VzmpMKrpvsxGeXLcCzIRHLQwZalwMVcGGNtyeTFxQDZwVz9Clrj+nfk
 0YaSOopFmv248ZoJik/0KO0i4gp9J8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvmiNBg7a1uiccKIZL/s+wkT4KMkuTXaypS516pqGRs=;
 b=xmVAJ5c8ueMHmTcVxAkT7pJt8vlj0/WtO6odznFTB4519aEH+42zkBN3TpvfmHnjVf2YKS
 xbloBWgJPxdCEdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 557C2137DB;
 Wed, 29 Jan 2025 16:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHbfBRBRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 40/42] migration: Merge precopy/postcopy on switchover start
Date: Wed, 29 Jan 2025 13:00:57 -0300
Message-Id: <20250129160059.6987-41-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7EA31F383
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now after all the cleanups, finally we can merge the switchover startup
phase into one single function for precopy/postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-16-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5302b7b91b..74c50cc72c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -105,7 +105,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static bool migration_switchover_start(MigrationState *s);
+static bool migration_switchover_start(MigrationState *s, Error **errp);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2667,21 +2667,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    if (!migration_switchover_start(ms)) {
-        error_setg(errp, "migration_switchover_start() failed");
+    if (!migration_switchover_start(ms, errp)) {
         goto fail;
     }
 
-    if (!migration_block_inactivate()) {
-        error_setg(errp, "%s: Failed in bdrv_inactivate_all()", __func__);
-        goto fail;
-    }
-
-    /* Switchover phase, switch to unlimited */
-    migration_rate_set(RATE_LIMIT_DISABLED);
-
-    precopy_notify_complete();
-
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2813,7 +2802,7 @@ fail:
 }
 
 /**
- * @migration_switchover_start: Start VM switchover procedure
+ * @migration_switchover_prepare: Start VM switchover procedure
  *
  * @s: The migration state object pointer
  *
@@ -2828,7 +2817,7 @@ fail:
  *
  * Returns: true on success, false on interruptions.
  */
-static bool migration_switchover_start(MigrationState *s)
+static bool migration_switchover_prepare(MigrationState *s)
 {
     /* Concurrent cancellation?  Quit */
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -2876,21 +2865,13 @@ static bool migration_switchover_start(MigrationState *s)
     return s->state == MIGRATION_STATUS_DEVICE;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
-    int ret;
+    ERRP_GUARD();
 
-    bql_lock();
-
-    if (!migrate_mode_is_cpr(s)) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            goto out_unlock;
-        }
-    }
-
-    if (!migration_switchover_start(s)) {
-        goto out_unlock;
+    if (!migration_switchover_prepare(s)) {
+        error_setg(errp, "Switchover is interrupted");
+        return false;
     }
 
     /* Inactivate disks except in COLO */
@@ -2900,8 +2881,8 @@ static int migration_completion_precopy(MigrationState *s)
          * bdrv_activate_all() on the other end won't fail.
          */
         if (!migration_block_inactivate()) {
-            ret = -EFAULT;
-            goto out_unlock;
+            error_setg(errp, "Block inactivate failed during switchover");
+            return false;
         }
     }
 
@@ -2909,6 +2890,27 @@ static int migration_completion_precopy(MigrationState *s)
 
     precopy_notify_complete();
 
+    return true;
+}
+
+static int migration_completion_precopy(MigrationState *s)
+{
+    int ret;
+
+    bql_lock();
+
+    if (!migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            goto out_unlock;
+        }
+    }
+
+    if (!migration_switchover_start(s, NULL)) {
+        ret = -EFAULT;
+        goto out_unlock;
+    }
+
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
-- 
2.35.3


