Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB857D5B875
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGd6-0002iM-F3; Mon, 15 Dec 2025 17:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGd5-0002fu-1V
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:19 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGd3-0002cs-F8
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ADE15BDDC;
 Mon, 15 Dec 2025 22:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdG0teGyKOWRVkYelnUqURTgpdlQXF6e71z+BYL+rlE=;
 b=Wj+F96i4Ivqx5a2WDLfPmpebAHq856NAhal/q5/afHP/53ywjodKui+abSA+4YSocPqCGx
 n6CeDw0klkkRUAv2ZHv84LQCGFrLqI0VfNgYKsMwNHp4suoSDP7WmNGbBhVkgrjwAKlMxC
 YljYXxqKQAQnl/ex8rx1aVuMC6rPZAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdG0teGyKOWRVkYelnUqURTgpdlQXF6e71z+BYL+rlE=;
 b=/vSnhxp9QXM1HBqwifcDglHQntq3gpnM5dc33Pt2L+kQ5zPtEEflJIsmlh/46exy/gEqEH
 pZM53VenUrOafuAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdG0teGyKOWRVkYelnUqURTgpdlQXF6e71z+BYL+rlE=;
 b=Wj+F96i4Ivqx5a2WDLfPmpebAHq856NAhal/q5/afHP/53ywjodKui+abSA+4YSocPqCGx
 n6CeDw0klkkRUAv2ZHv84LQCGFrLqI0VfNgYKsMwNHp4suoSDP7WmNGbBhVkgrjwAKlMxC
 YljYXxqKQAQnl/ex8rx1aVuMC6rPZAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdG0teGyKOWRVkYelnUqURTgpdlQXF6e71z+BYL+rlE=;
 b=/vSnhxp9QXM1HBqwifcDglHQntq3gpnM5dc33Pt2L+kQ5zPtEEflJIsmlh/46exy/gEqEH
 pZM53VenUrOafuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0063EA63;
 Mon, 15 Dec 2025 22:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGDeIieFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 08/51] migration: Run a post update routine after setting
 parameters
Date: Mon, 15 Dec 2025 18:59:54 -0300
Message-ID: <20251215220041.12657-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
index f14baa8561..e7f4aeaf03 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1123,6 +1123,31 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpr_exec_command = true;
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
@@ -1437,7 +1462,7 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 }
 
-static void migrate_params_apply(MigrationParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1477,9 +1502,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
-        if (s->to_dst_file && !migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_bandwidth);
-        }
     }
 
     if (params->has_avail_switchover_bandwidth) {
@@ -1492,7 +1514,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
-        colo_checkpoint_delay_set();
     }
 
     if (params->has_multifd_channels) {
@@ -1512,13 +1533,9 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
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
@@ -1592,7 +1609,8 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     migrate_params_test_apply(params, &tmp);
 
     if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(params, errp);
+        migrate_params_apply(params);
+        migrate_post_update_params(params, errp);
     }
 
     migrate_tls_opts_free(&tmp);
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..a49afbd995 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -176,7 +176,7 @@ static void XBZRLE_cache_unlock(void)
 /**
  * xbzrle_cache_resize: resize the xbzrle cache
  *
- * This function is called from migrate_params_apply in main
+ * This function is called from migrate_post_update_params in main
  * thread, possibly while a migration is in progress.  A running
  * migration may be using the cache and might finish during this call,
  * hence changes to the cache are protected by XBZRLE.lock().
-- 
2.51.0


