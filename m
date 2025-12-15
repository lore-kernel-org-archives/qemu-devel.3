Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0237BD5B873
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGe0-0004Gr-JO; Mon, 15 Dec 2025 17:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdw-0004Di-1F
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:12 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdt-0002pS-D7
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 064305BE06;
 Mon, 15 Dec 2025 22:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANsQLnOi5r+0TJdIl2TP4Q9xn6fuGF1JvuOmuuwC1Yo=;
 b=M4TFS8IGnUP6slqi3RsD8IcVaffbpnjgMFWMVJLJdarHAYEeey/BbWYm19d6M0ncSoiyJ6
 bZiv1nBS+DfSEC3FbHqUgeDnn6ak7X6lirHGiMkLmyHJ7QDP8sWNkvYRa3LXiZ9Ov3gFYb
 NE0nPRYww1XW0PX4JBmMmz9cUBuWuYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANsQLnOi5r+0TJdIl2TP4Q9xn6fuGF1JvuOmuuwC1Yo=;
 b=Xg8/UoQW5+IEfqDqcSUCJoI3OhAall68CWj1Hwnm28KJnNqQK+P/Wa/G3/DUmQPy7PO3Mg
 PFENt7mmziA4rzAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANsQLnOi5r+0TJdIl2TP4Q9xn6fuGF1JvuOmuuwC1Yo=;
 b=M4TFS8IGnUP6slqi3RsD8IcVaffbpnjgMFWMVJLJdarHAYEeey/BbWYm19d6M0ncSoiyJ6
 bZiv1nBS+DfSEC3FbHqUgeDnn6ak7X6lirHGiMkLmyHJ7QDP8sWNkvYRa3LXiZ9Ov3gFYb
 NE0nPRYww1XW0PX4JBmMmz9cUBuWuYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANsQLnOi5r+0TJdIl2TP4Q9xn6fuGF1JvuOmuuwC1Yo=;
 b=Xg8/UoQW5+IEfqDqcSUCJoI3OhAall68CWj1Hwnm28KJnNqQK+P/Wa/G3/DUmQPy7PO3Mg
 PFENt7mmziA4rzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCE73EA63;
 Mon, 15 Dec 2025 22:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GDgZDzuFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 17/51] migration: Use QAPI_MERGE in
 migrate_params_test_apply
Date: Mon, 15 Dec 2025 19:00:03 -0300
Message-ID: <20251215220041.12657-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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

Convert the code in migrate_params_test_apply() from an open-coded
copy of every migration parameter to a copy using visitors. The
current code has conditionals for each parameter's has_* field, which
is exactly what the visitors do.

This hides the details of QAPI from the migration code and avoids the
need to update migrate_params_test_apply() every time a new migration
parameter is added. Both were very confusing and while the visitor
code can become a bit involved, there is no need for new contributors
to ever touch it.

Change the name of the function to a more direct reference of what it
does: merging the user params with the temporary copy.

Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
and there's no need to allocate memory in the migration
code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
routine can be used.

An extra call to migrate_mark_all_params_present() is now needed
because the visitors update the has_ field for non-present fields, but
we actually want them all set so migrate_params_apply() can copy all
of them.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 137 +++++++-------------------------------------
 1 file changed, 22 insertions(+), 115 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 03e63c918c..36feaa5fe6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -20,6 +20,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/type-helpers.h"
 #include "qobject/qnull.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
@@ -1260,124 +1261,28 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrationParameters *params,
-                                      MigrationParameters *dest)
+static void migrate_params_merge(MigrationParameters *dst,
+                                 MigrationParameters *src)
 {
-    MigrationState *s = migrate_get_current();
-
-    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
-
-    if (params->has_throttle_trigger_threshold) {
-        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
-    }
-
-    if (params->has_cpu_throttle_initial) {
-        dest->cpu_throttle_initial = params->cpu_throttle_initial;
-    }
-
-    if (params->has_cpu_throttle_increment) {
-        dest->cpu_throttle_increment = params->cpu_throttle_increment;
+    /* free memory from pointers that are about to be assigned */
+    if (src->has_block_bitmap_mapping) {
+        g_clear_pointer(&dst->block_bitmap_mapping,
+                        qapi_free_BitmapMigrationNodeAliasList);
     }
 
-    if (params->has_cpu_throttle_tailslow) {
-        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
+    if (src->tls_creds) {
+        g_clear_pointer(&dst->tls_creds, qapi_free_StrOrNull);
     }
 
-    if (params->tls_creds) {
-        qapi_free_StrOrNull(dest->tls_creds);
-        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
+    if (src->tls_hostname) {
+        g_clear_pointer(&dst->tls_hostname, qapi_free_StrOrNull);
     }
 
-    if (params->tls_hostname) {
-        qapi_free_StrOrNull(dest->tls_hostname);
-        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
+    if (src->tls_authz) {
+        g_clear_pointer(&dst->tls_authz, qapi_free_StrOrNull);
     }
 
-    if (params->tls_authz) {
-        qapi_free_StrOrNull(dest->tls_authz);
-        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    }
-
-    if (params->has_max_bandwidth) {
-        dest->max_bandwidth = params->max_bandwidth;
-    }
-
-    if (params->has_avail_switchover_bandwidth) {
-        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
-    }
-
-    if (params->has_downtime_limit) {
-        dest->downtime_limit = params->downtime_limit;
-    }
-
-    if (params->has_x_checkpoint_delay) {
-        dest->x_checkpoint_delay = params->x_checkpoint_delay;
-    }
-
-    if (params->has_multifd_channels) {
-        dest->multifd_channels = params->multifd_channels;
-    }
-    if (params->has_multifd_compression) {
-        dest->multifd_compression = params->multifd_compression;
-    }
-    if (params->has_multifd_qatzip_level) {
-        dest->multifd_qatzip_level = params->multifd_qatzip_level;
-    }
-    if (params->has_multifd_zlib_level) {
-        dest->multifd_zlib_level = params->multifd_zlib_level;
-    }
-    if (params->has_multifd_zstd_level) {
-        dest->multifd_zstd_level = params->multifd_zstd_level;
-    }
-    if (params->has_xbzrle_cache_size) {
-        dest->xbzrle_cache_size = params->xbzrle_cache_size;
-    }
-    if (params->has_max_postcopy_bandwidth) {
-        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-    }
-    if (params->has_max_cpu_throttle) {
-        dest->max_cpu_throttle = params->max_cpu_throttle;
-    }
-    if (params->has_announce_initial) {
-        dest->announce_initial = params->announce_initial;
-    }
-    if (params->has_announce_max) {
-        dest->announce_max = params->announce_max;
-    }
-    if (params->has_announce_rounds) {
-        dest->announce_rounds = params->announce_rounds;
-    }
-    if (params->has_announce_step) {
-        dest->announce_step = params->announce_step;
-    }
-
-    if (params->has_block_bitmap_mapping) {
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
-    }
-
-    if (params->has_x_vcpu_dirty_limit_period) {
-        dest->x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
-    }
-    if (params->has_vcpu_dirty_limit) {
-        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
-    }
-
-    if (params->has_mode) {
-        dest->mode = params->mode;
-    }
-
-    if (params->has_zero_page_detection) {
-        dest->zero_page_detection = params->zero_page_detection;
-    }
-
-    if (params->has_direct_io) {
-        dest->direct_io = params->direct_io;
-    }
-
-    if (params->has_cpr_exec_command) {
-        dest->cpr_exec_command = params->cpr_exec_command;
-    }
+    QAPI_MERGE(MigrationParameters, dst, src);
 }
 
 /*
@@ -1399,7 +1304,9 @@ static void migrate_params_apply(MigrationParameters *params)
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationState *s = migrate_get_current();
+    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
+                                                    &s->parameters);
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1413,7 +1320,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     tls_opt_to_str(params->tls_hostname);
     tls_opt_to_str(params->tls_authz);
 
-    migrate_params_test_apply(params, &tmp);
+    migrate_params_merge(tmp, params);
 
     /*
      * Mark block_bitmap_mapping as present now while we have the
@@ -1423,10 +1330,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
         migrate_get_current()->has_block_bitmap_mapping = true;
     }
 
-    if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(&tmp);
+    if (migrate_params_check(tmp, errp)) {
+        /* mark all present, so they're all copied */
+        migrate_mark_all_params_present(tmp);
+        migrate_params_apply(tmp);
         migrate_post_update_params(params, errp);
     }
-
-    migrate_tls_opts_free(&tmp);
 }
-- 
2.51.0


