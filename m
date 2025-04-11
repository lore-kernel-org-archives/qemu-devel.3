Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44905C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jq7-0003vD-6z; Fri, 11 Apr 2025 15:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jq5-0003uv-7z
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:14:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jq3-0005xU-IN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:14:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E24761F453;
 Fri, 11 Apr 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nDdyb8LBvk2cGMnL7r5nRYQqV2zhbnFKysMMSxK7yo=;
 b=IDTcfhXuIrAv9hKK/zs/b5q/DAhVFhmXcnGEcDvXxWML/LhaXFVfx1fRpLpqDCvCvdkTon
 4Bqk9BiX/g8G+30R6CY/SRuKhpJ+2z593Msttc1TcWT8E8fr+8m5xZ4rVichvGJNUmvDDr
 1b861pJfBpmWGSWnBsgsaw4eGJuqqus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nDdyb8LBvk2cGMnL7r5nRYQqV2zhbnFKysMMSxK7yo=;
 b=NhfwtQYvhREeAGHmeGvixQaWZmp/JWZ5sF1/ogzDm9aqb3GQGdWLre3UuR1mchrr3rKQvM
 4eVLb1mn56kfu9Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nDdyb8LBvk2cGMnL7r5nRYQqV2zhbnFKysMMSxK7yo=;
 b=IDTcfhXuIrAv9hKK/zs/b5q/DAhVFhmXcnGEcDvXxWML/LhaXFVfx1fRpLpqDCvCvdkTon
 4Bqk9BiX/g8G+30R6CY/SRuKhpJ+2z593Msttc1TcWT8E8fr+8m5xZ4rVichvGJNUmvDDr
 1b861pJfBpmWGSWnBsgsaw4eGJuqqus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nDdyb8LBvk2cGMnL7r5nRYQqV2zhbnFKysMMSxK7yo=;
 b=NhfwtQYvhREeAGHmeGvixQaWZmp/JWZ5sF1/ogzDm9aqb3GQGdWLre3UuR1mchrr3rKQvM
 4eVLb1mn56kfu9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6296D13886;
 Fri, 11 Apr 2025 19:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ULdJCSxq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:14:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 03/13] migration: Run a post update routine after setting
 parameters
Date: Fri, 11 Apr 2025 16:14:33 -0300
Message-Id: <20250411191443.22565-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
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

Some migration parameters are updated immediately once they are set
via migrate-set-parameters. Move that work outside of
migrate_params_apply() and leave that function with the single
responsibility of setting s->parameters and not doing any
side-effects.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 39 +++++++++++++++++++++++++++++----------
 migration/ram.c     |  2 +-
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 7cd465ca94..cac28540dd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1302,7 +1302,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 }
 
-static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
+static void migrate_params_apply(MigrateSetParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1344,9 +1344,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
-        if (s->to_dst_file && !migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_bandwidth);
-        }
     }
 
     if (params->has_avail_switchover_bandwidth) {
@@ -1359,7 +1356,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
-        colo_checkpoint_delay_set();
     }
 
     if (params->has_multifd_channels) {
@@ -1379,13 +1375,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
-        xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
     if (params->has_max_postcopy_bandwidth) {
         s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-        if (s->to_dst_file && migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_postcopy_bandwidth);
-        }
     }
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle = params->max_cpu_throttle;
@@ -1434,6 +1426,32 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 }
 
+static void migrate_post_update_params(MigrateSetParameters *new, Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (new->has_max_bandwidth) {
+        if (s->to_dst_file && !migration_in_postcopy()) {
+            migration_rate_set(new->max_bandwidth);
+        }
+    }
+
+    if (new->has_x_checkpoint_delay) {
+        colo_checkpoint_delay_set();
+    }
+
+    if (new->has_xbzrle_cache_size) {
+        xbzrle_cache_resize(new->xbzrle_cache_size, errp);
+    }
+
+    if (new->has_max_postcopy_bandwidth) {
+        if (s->to_dst_file && migration_in_postcopy()) {
+            migration_rate_set(new->max_postcopy_bandwidth);
+        }
+    }
+
+}
+
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
@@ -1445,5 +1463,6 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         return;
     }
 
-    migrate_params_apply(params, errp);
+    migrate_params_apply(params);
+    migrate_post_update_params(params, errp);
 }
diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..e0ba8e0d48 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -144,7 +144,7 @@ static void XBZRLE_cache_unlock(void)
 /**
  * xbzrle_cache_resize: resize the xbzrle cache
  *
- * This function is called from migrate_params_apply in main
+ * This function is called from migrate_post_update_config in main
  * thread, possibly while a migration is in progress.  A running
  * migration may be using the cache and might finish during this call,
  * hence changes to the cache are protected by XBZRLE.lock().
-- 
2.35.3


