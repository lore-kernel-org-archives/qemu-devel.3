Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1136E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2bu-0007bE-Bj; Mon, 02 Feb 2026 17:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bt-0007b2-JA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2br-0000qD-PW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:33 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6512A3E6C6;
 Mon,  2 Feb 2026 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86+JJGb7GtWR/nbtnYPa1W6mDxZAg2FCQqGlH06dIEk=;
 b=uNwU//SCx78KQ1QOH2eycJjfpNLtXypN1z6zwmdGGhb+OF76PVmb3dWVIGJgovaiIUXgXQ
 TRX8Ux66/uZ8D2rUgGkRfLAfF/PrD/spqBAz5FAmJ+7HgLC7Hoh2WePY5TlM08jMDqj9Ai
 Ee638DcRYGgrLEhG4jt7Fc+COvgtmUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86+JJGb7GtWR/nbtnYPa1W6mDxZAg2FCQqGlH06dIEk=;
 b=9ZayS/tRBeK/VbCgORRn6lWWowHLbK1kAq58U0YMbZGNAQ44LyyUAZ8nBqxR7GNW5FaaV+
 mHygg4oIlbMLw/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86+JJGb7GtWR/nbtnYPa1W6mDxZAg2FCQqGlH06dIEk=;
 b=uNwU//SCx78KQ1QOH2eycJjfpNLtXypN1z6zwmdGGhb+OF76PVmb3dWVIGJgovaiIUXgXQ
 TRX8Ux66/uZ8D2rUgGkRfLAfF/PrD/spqBAz5FAmJ+7HgLC7Hoh2WePY5TlM08jMDqj9Ai
 Ee638DcRYGgrLEhG4jt7Fc+COvgtmUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86+JJGb7GtWR/nbtnYPa1W6mDxZAg2FCQqGlH06dIEk=;
 b=9ZayS/tRBeK/VbCgORRn6lWWowHLbK1kAq58U0YMbZGNAQ44LyyUAZ8nBqxR7GNW5FaaV+
 mHygg4oIlbMLw/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF873EA62;
 Mon,  2 Feb 2026 22:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KC1QIw0ogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 6/9] migration/options: Use QAPI_MERGE in
 migrate_params_test_apply
Date: Mon,  2 Feb 2026 19:40:58 -0300
Message-ID: <20260202224101.20568-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202224101.20568-1-farosas@suse.de>
References: <20260202224101.20568-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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

Convert the code in migrate_params_test_apply() from an open-coded
copy of every migration parameter to a copy using visitors. The
current code has conditionals for each parameter's has_* field, which
is exactly what the visitors do.

This hides the details of QAPI from the migration code and avoids the
need to update migrate_params_test_apply() every time a new migration
parameter is added. Both were very confusing and while the visitor
code can become a bit involved, there is no need for new contributors
to ever touch it.

Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
and there's no need to allocate memory in the migration
code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
routine can be used.

An extra call to migrate_mark_all_params_present() is now needed
because the visitors update the has_ field for non-present fields, but
we actually want them all set so QAPI_CLONE_MEMBERS copies all of
them.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 145 +++-----------------------------------------
 1 file changed, 10 insertions(+), 135 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3c80cdfd3a..180ebed51c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -19,6 +19,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/type-helpers.h"
 #include "qobject/qnull.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
@@ -1265,133 +1266,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrationParameters *params,
-                                      MigrationParameters *dest)
-{
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
-    }
-
-    if (params->has_cpu_throttle_tailslow) {
-        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
-    }
-
-    if (params->tls_creds) {
-        qapi_free_StrOrNull(dest->tls_creds);
-        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    }
-
-    if (params->tls_hostname) {
-        qapi_free_StrOrNull(dest->tls_hostname);
-        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    }
-
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
-        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
-        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
-                                                params->block_bitmap_mapping);
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
-        qapi_free_strList(dest->cpr_exec_command);
-        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
-    }
-}
-
-/*
- * Caller must ensure the has_* fields of @params are true so they all
- * get copied and the pointer members don't dangle.
- */
 static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
@@ -1400,12 +1274,17 @@ static void migrate_params_apply(MigrationParameters *params)
     migrate_tls_opts_free(cur);
     qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
     qapi_free_strList(cur->cpr_exec_command);
+
+    /* mark all present, so they're all copied */
+    migrate_mark_all_params_present(params);
     QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationState *s = migrate_get_current();
+    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
+                                                    &s->parameters);
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1419,14 +1298,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     tls_opt_to_str(params->tls_hostname);
     tls_opt_to_str(params->tls_authz);
 
-    migrate_params_test_apply(params, &tmp);
+    QAPI_MERGE(MigrationParameters, tmp, params);
 
-    if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(&tmp);
+    if (migrate_params_check(tmp, errp)) {
+        migrate_params_apply(tmp);
         migrate_post_update_params(params, errp);
     }
-
-    migrate_tls_opts_free(&tmp);
-    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
-    qapi_free_strList(tmp.cpr_exec_command);
 }
-- 
2.51.0


