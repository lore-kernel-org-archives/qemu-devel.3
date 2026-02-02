Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87169E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2bp-0007Yy-FW; Mon, 02 Feb 2026 17:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bo-0007Yb-5m
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:28 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bm-0000pO-Dj
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C020C3E6C5;
 Mon,  2 Feb 2026 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx76ayTs/F4tYmrxu6mBKE3p0D09KMMO/0lWIIEKtTY=;
 b=Ke/z5a/Opqyu5R+l+gSf0jczddgeodoWxvgjPT0LzdNsnnxOyYsNSl3Iq0CbBbMDzqvJ4Y
 dMatr9GlQmYA0P+Ll0Z5gSk9onavn1cXBc4l2LxdxMPMOPZBZ3GQciicHbj2GqeJM3z4Qx
 BLKije39y6lJs0gOxfphDmXNcgJhBYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx76ayTs/F4tYmrxu6mBKE3p0D09KMMO/0lWIIEKtTY=;
 b=/+5ro7ts5STkjZfWlKJugdLkmughJBjeGk+dE+loioLu2Wxbc0WZIHSNKrnXfoMxuuyLca
 liVBdPZz9bGgtoDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ke/z5a/O";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/+5ro7ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx76ayTs/F4tYmrxu6mBKE3p0D09KMMO/0lWIIEKtTY=;
 b=Ke/z5a/Opqyu5R+l+gSf0jczddgeodoWxvgjPT0LzdNsnnxOyYsNSl3Iq0CbBbMDzqvJ4Y
 dMatr9GlQmYA0P+Ll0Z5gSk9onavn1cXBc4l2LxdxMPMOPZBZ3GQciicHbj2GqeJM3z4Qx
 BLKije39y6lJs0gOxfphDmXNcgJhBYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx76ayTs/F4tYmrxu6mBKE3p0D09KMMO/0lWIIEKtTY=;
 b=/+5ro7ts5STkjZfWlKJugdLkmughJBjeGk+dE+loioLu2Wxbc0WZIHSNKrnXfoMxuuyLca
 liVBdPZz9bGgtoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAC9B3EA62;
 Mon,  2 Feb 2026 22:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJdnKgYogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, armbru@redhat.com, ppandit@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 3/9] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
Date: Mon,  2 Feb 2026 19:40:55 -0300
Message-ID: <20260202224101.20568-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202224101.20568-1-farosas@suse.de>
References: <20260202224101.20568-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C020C3E6C5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of setting parameters one by one, use the temporary object,
which already contains the current migration parameters plus the new
ones and was just validated by migration_params_check(). Use cloning
to overwrite it.

This avoids the need to alter this function every time a new parameter
is added.

Since parameters are not individually checked anymore, the setting of
s->has_block_bitmap_mapping moves into migrate_post_update_params().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 137 +++++---------------------------------------
 1 file changed, 14 insertions(+), 123 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 4161648268..3c80cdfd3a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1106,6 +1106,10 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
             migration_rate_set(new->max_postcopy_bandwidth);
         }
     }
+
+    if (new->has_block_bitmap_mapping) {
+        s->has_block_bitmap_mapping = true;
+    }
 }
 
 /*
@@ -1384,132 +1388,19 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 }
 
+/*
+ * Caller must ensure the has_* fields of @params are true so they all
+ * get copied and the pointer members don't dangle.
+ */
 static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
+    MigrationParameters *cur = &s->parameters;
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-
-    if (params->has_throttle_trigger_threshold) {
-        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
-    }
-
-    if (params->has_cpu_throttle_initial) {
-        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
-    }
-
-    if (params->has_cpu_throttle_increment) {
-        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
-    }
-
-    if (params->has_cpu_throttle_tailslow) {
-        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
-    }
-
-    if (params->tls_creds) {
-        qapi_free_StrOrNull(s->parameters.tls_creds);
-        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    }
-
-    if (params->tls_hostname) {
-        qapi_free_StrOrNull(s->parameters.tls_hostname);
-        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
-                                                params->tls_hostname);
-    }
-
-    if (params->tls_authz) {
-        qapi_free_StrOrNull(s->parameters.tls_authz);
-        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    }
-
-    if (params->has_max_bandwidth) {
-        s->parameters.max_bandwidth = params->max_bandwidth;
-    }
-
-    if (params->has_avail_switchover_bandwidth) {
-        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
-    }
-
-    if (params->has_downtime_limit) {
-        s->parameters.downtime_limit = params->downtime_limit;
-    }
-
-    if (params->has_x_checkpoint_delay) {
-        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
-    }
-
-    if (params->has_multifd_channels) {
-        s->parameters.multifd_channels = params->multifd_channels;
-    }
-    if (params->has_multifd_compression) {
-        s->parameters.multifd_compression = params->multifd_compression;
-    }
-    if (params->has_multifd_qatzip_level) {
-        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
-    }
-    if (params->has_multifd_zlib_level) {
-        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
-    }
-    if (params->has_multifd_zstd_level) {
-        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
-    }
-    if (params->has_xbzrle_cache_size) {
-        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
-    }
-    if (params->has_max_postcopy_bandwidth) {
-        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-    }
-    if (params->has_max_cpu_throttle) {
-        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
-    }
-    if (params->has_announce_initial) {
-        s->parameters.announce_initial = params->announce_initial;
-    }
-    if (params->has_announce_max) {
-        s->parameters.announce_max = params->announce_max;
-    }
-    if (params->has_announce_rounds) {
-        s->parameters.announce_rounds = params->announce_rounds;
-    }
-    if (params->has_announce_step) {
-        s->parameters.announce_step = params->announce_step;
-    }
-
-    if (params->has_block_bitmap_mapping) {
-        qapi_free_BitmapMigrationNodeAliasList(
-            s->parameters.block_bitmap_mapping);
-
-        s->has_block_bitmap_mapping = true;
-        s->parameters.block_bitmap_mapping =
-            QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       params->block_bitmap_mapping);
-    }
-
-    if (params->has_x_vcpu_dirty_limit_period) {
-        s->parameters.x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
-    }
-    if (params->has_vcpu_dirty_limit) {
-        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
-    }
-
-    if (params->has_mode) {
-        s->parameters.mode = params->mode;
-    }
-
-    if (params->has_zero_page_detection) {
-        s->parameters.zero_page_detection = params->zero_page_detection;
-    }
-
-    if (params->has_direct_io) {
-        s->parameters.direct_io = params->direct_io;
-    }
-
-    if (params->has_cpr_exec_command) {
-        qapi_free_strList(s->parameters.cpr_exec_command);
-        s->parameters.cpr_exec_command =
-            QAPI_CLONE(strList, params->cpr_exec_command);
-    }
+    migrate_tls_opts_free(cur);
+    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
+    qapi_free_strList(cur->cpr_exec_command);
+    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
@@ -1531,7 +1422,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     migrate_params_test_apply(params, &tmp);
 
     if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(params);
+        migrate_params_apply(&tmp);
         migrate_post_update_params(params, errp);
     }
 
-- 
2.51.0


