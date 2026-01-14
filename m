Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9693D37E32
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0qm-000712-LN; Wed, 14 Jan 2026 08:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qV-0006aU-Od
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:43 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qT-0006jN-Ug
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0BF35C733;
 Wed, 14 Jan 2026 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768397003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY+sOVWOMNcH5jIjpfhheng/LErx1HZkY+eTjKO6zng=;
 b=jc2sre9EPGHZrH7VmK+UGAOWZya7Joy1/eink81Pii3qIghZcv0e8yC63/e3CZU4Y08im2
 VF1CTr2lYzFzzsqqsp3GA+GnH5uCMGF/8aC01MHoJoSo8aPSVVnVCUK7vuEUbiRcdtmgRm
 I0Gb7nU2JJpqaEYzC1bhbGEpDf4g40M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768397003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY+sOVWOMNcH5jIjpfhheng/LErx1HZkY+eTjKO6zng=;
 b=1bdhGdoS5U9oHYRFAt7SR8lbmNqR0aZmO1PGz7cidWT0gs+GsbMHFhMwPxqbgb57ea2oI+
 sEsUiLsFJrxbqnCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768397002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY+sOVWOMNcH5jIjpfhheng/LErx1HZkY+eTjKO6zng=;
 b=Uv8STb15/7IbflqSRW9WKY0DJBEn2yUvXsWHSzS8zORJNqUGlWts2fF5Mduy6ytn1FWpud
 Ico4B7IoxJxCVcmgI7+g/+m8Q5FXEVVhaKXv6paUVNHMaTFPC88NTC/PT6p5eOScRTfbLD
 8Kx5LIdhX+Z/8bLdXVUuyXNt6CqVOhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768397002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY+sOVWOMNcH5jIjpfhheng/LErx1HZkY+eTjKO6zng=;
 b=KqmonMy/LyROJeSmqw76hAmPoEphkhZIUD245meq59J6IqoDTUf8zzR87WAbn5ts6UWI7T
 jdgDjKL7pPjJdvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA2503EA63;
 Wed, 14 Jan 2026 13:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qCG8GsmYZ2nxBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 13:23:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com
Subject: [PATCH 5/5] migration/options: Use QAPI_MERGE in
 migrate_params_test_apply
Date: Wed, 14 Jan 2026 10:23:09 -0300
Message-ID: <20260114132309.5832-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114132309.5832-1-farosas@suse.de>
References: <20260114132309.5832-1-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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
we actually want them all set so migrate_params_apply() can copy all
of them.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 138 +++-----------------------------------------
 1 file changed, 9 insertions(+), 129 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 7a16119ff8..b4773fecc5 100644
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
@@ -1262,129 +1263,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 /*
  * Caller must ensure all has_* fields of @params are true to ensure
  * all fields get copied and the pointer members don't dangle.
@@ -1404,7 +1282,9 @@ static void migrate_params_apply(MigrationParameters *params)
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationState *s = migrate_get_current();
+    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
+                                                    &s->parameters);
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1418,9 +1298,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     tls_opt_to_str(params->tls_hostname);
     tls_opt_to_str(params->tls_authz);
 
-    migrate_params_test_apply(params, &tmp);
+    QAPI_MERGE(MigrationParameters, tmp, params);
 
-    if (migrate_params_check(&tmp, errp)) {
+    if (migrate_params_check(tmp, errp)) {
         /*
          * Mark block_bitmap_mapping as present now while we have the
          * params structure with the user input around.
@@ -1429,9 +1309,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
             migrate_get_current()->has_block_bitmap_mapping = true;
         }
 
-        migrate_params_apply(&tmp);
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


