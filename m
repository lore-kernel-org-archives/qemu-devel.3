Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDC5C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbq-0006RP-4j; Mon, 02 Jun 2025 21:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbn-0006Qz-ST
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbm-0001RQ-3i
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 171D0218E8;
 Tue,  3 Jun 2025 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1NmJOzistgkewZvj5rcGicm2xwzriSt4DaxoQcJ+lg=;
 b=h4XVeCQGlnT1Crtxrwu3mNQHmEnwNC6ia5/Ghk2lvuMS+XMGfNW0r3H6Umtcq7HX6RSb/6
 iWGCRu/ebYW7bMu+36u/ARmBg4cJ/2UGUPMB2Sj3aJBlz1mqgzzFJLDbQrMWxmA7COcP4k
 pPgh8h/ASokCQnq8BJAx9GUEO0xR4wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1NmJOzistgkewZvj5rcGicm2xwzriSt4DaxoQcJ+lg=;
 b=mtBT+01NhfRvuGziUe9tJEOo9llbvro4NtMG2bkvKbDHbC2pa4aS/thBbS3k3b4pO1+v8X
 iDlK0rww3MvSkeDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1NmJOzistgkewZvj5rcGicm2xwzriSt4DaxoQcJ+lg=;
 b=h4XVeCQGlnT1Crtxrwu3mNQHmEnwNC6ia5/Ghk2lvuMS+XMGfNW0r3H6Umtcq7HX6RSb/6
 iWGCRu/ebYW7bMu+36u/ARmBg4cJ/2UGUPMB2Sj3aJBlz1mqgzzFJLDbQrMWxmA7COcP4k
 pPgh8h/ASokCQnq8BJAx9GUEO0xR4wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1NmJOzistgkewZvj5rcGicm2xwzriSt4DaxoQcJ+lg=;
 b=mtBT+01NhfRvuGziUe9tJEOo9llbvro4NtMG2bkvKbDHbC2pa4aS/thBbS3k3b4pO1+v8X
 iDlK0rww3MvSkeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89CF013700;
 Tue,  3 Jun 2025 01:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aB2pEg1SPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/21] migration: Run a post update routine after setting
 parameters
Date: Mon,  2 Jun 2025 22:37:53 -0300
Message-Id: <20250603013810.4772-5-farosas@suse.de>
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

Some migration parameters are updated immediately once they are set
via migrate-set-parameters. Move that work outside of
migrate_params_apply() and leave that function with the single
responsibility of setting s->parameters and not doing any
side-effects.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 38 ++++++++++++++++++++++++++++----------
 migration/ram.c     |  2 +-
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index e49d584a99..f64e141394 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1039,6 +1039,31 @@ void migrate_params_init(MigrationParameters *params)
     params->has_direct_io = true;
 }
 
+static void migrate_post_update_params(MigrationParameters *new, Error **errp)
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
+}
+
 /*
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
@@ -1350,7 +1375,7 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 }
 
-static void migrate_params_apply(MigrationParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1389,9 +1414,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
-        if (s->to_dst_file && !migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_bandwidth);
-        }
     }
 
     if (params->has_avail_switchover_bandwidth) {
@@ -1404,7 +1426,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
-        colo_checkpoint_delay_set();
     }
 
     if (params->has_multifd_channels) {
@@ -1424,13 +1445,9 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
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
@@ -1486,7 +1503,8 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     migrate_params_test_apply(params, &tmp);
 
     if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(params, errp);
+        migrate_params_apply(params);
+        migrate_post_update_params(params, errp);
     }
 
     migrate_tls_opts_free(&tmp);
diff --git a/migration/ram.c b/migration/ram.c
index d26dbd37c4..22e462bf72 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -174,7 +174,7 @@ static void XBZRLE_cache_unlock(void)
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


