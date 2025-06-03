Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CF1C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcB-0006dO-Bl; Mon, 02 Jun 2025 21:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGc9-0006Zn-Us
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGc8-0001W8-75
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 488B7218E0;
 Tue,  3 Jun 2025 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mgq3Nz6Cs/i/2dv8VCv+yMPeRGuaJeqkTVyNzmqY+0=;
 b=tSVZjrFVs9J7+DovTL0mM+obJxEUjOJgd1r8oGqzV8TG0OLMsZ4rqxzu+RahDyKcq9PrwF
 P+i+2AzZB57C9YMyx43dfPg3hBb13QKUDhgOe7J+8EPGjY7biO35ZW7t1S1RNODxqAcZWp
 ocr3252NbumMNb2+cAAaSmgOp6zQ8n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mgq3Nz6Cs/i/2dv8VCv+yMPeRGuaJeqkTVyNzmqY+0=;
 b=7ul6BJNFBSN4fi3VpSzDy9ZCOiPyu9fonE+qIizr1Sm4PimqQntYBBhlvCtC76a8g17lyV
 +XGFlahMJ8MEPfDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mgq3Nz6Cs/i/2dv8VCv+yMPeRGuaJeqkTVyNzmqY+0=;
 b=tSVZjrFVs9J7+DovTL0mM+obJxEUjOJgd1r8oGqzV8TG0OLMsZ4rqxzu+RahDyKcq9PrwF
 P+i+2AzZB57C9YMyx43dfPg3hBb13QKUDhgOe7J+8EPGjY7biO35ZW7t1S1RNODxqAcZWp
 ocr3252NbumMNb2+cAAaSmgOp6zQ8n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mgq3Nz6Cs/i/2dv8VCv+yMPeRGuaJeqkTVyNzmqY+0=;
 b=7ul6BJNFBSN4fi3VpSzDy9ZCOiPyu9fonE+qIizr1Sm4PimqQntYBBhlvCtC76a8g17lyV
 +XGFlahMJ8MEPfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAAC213700;
 Tue,  3 Jun 2025 01:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLupHh9SPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/21] migration: Use visitors in migrate_params_test_apply
Date: Mon,  2 Jun 2025 22:38:02 -0300
Message-Id: <20250603013810.4772-14-farosas@suse.de>
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

Convert the code in migrate_params_test_apply() from an open-coded
copy of every migration parameter to a copy using visitors.

This hides the details of QAPI from the migration code and avoids the
need to update migrate_params_test_apply() every time a new migration
parameter is added. Both were very confusing and while the visitor
code can become a bit involved, there is no need for new contributors
to ever touch it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 143 ++++++++++++--------------------------------
 1 file changed, 39 insertions(+), 104 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 27b5f549f9..ac4b06da7e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -20,6 +20,10 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/visitor.h"
+#include "qobject/qdict.h"
 #include "qobject/qnull.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
@@ -1184,117 +1188,46 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrationParameters *params,
-                                      MigrationParameters *dest)
+static bool migrate_params_test_apply(MigrationParameters *params,
+                                      MigrationParameters *dest, Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    QObject *ret_out = NULL;
+    Visitor *v;
+    bool ok;
 
     QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
-    if (params->has_throttle_trigger_threshold) {
-        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
+    /* read in from params */
+    v = qobject_output_visitor_new(&ret_out);
+    ok = visit_type_MigrationParameters(v, NULL, &params, errp);
+    if (!ok) {
+        goto out;
     }
+    visit_complete(v, &ret_out);
+    visit_free(v);
 
-    if (params->has_cpu_throttle_initial) {
-        dest->cpu_throttle_initial = params->cpu_throttle_initial;
+    /* write out to dest */
+    v = qobject_input_visitor_new(ret_out);
+    ok = visit_start_struct(v, NULL, NULL, 0, errp);
+    if (!ok) {
+        goto out;
     }
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
-        tls_option_set_str(&dest->tls_creds, params->tls_creds);
-    }
-
-    if (params->tls_hostname) {
-        tls_option_set_str(&dest->tls_hostname, params->tls_hostname);
-    }
-
-    if (params->tls_authz) {
-        tls_option_set_str(&dest->tls_authz, params->tls_authz);
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
+    ok = visit_type_MigrationParameters_members(v, dest, errp);
+    if (!ok) {
+        goto out;
     }
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
+    ok = visit_check_struct(v, errp);
+    visit_end_struct(v, NULL);
+    if (!ok) {
+        goto out;
     }
 
-    if (params->has_block_bitmap_mapping) {
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
-    }
+out:
+    visit_free(v);
+    qobject_unref(ret_out);
 
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
+    return ok;
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1315,9 +1248,11 @@ static void migrate_params_apply(MigrationParameters *params)
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationParameters *tmp = g_new0(MigrationParameters, 1);
 
-    migrate_params_test_apply(params, &tmp);
+    if (!migrate_params_test_apply(params, tmp, errp)) {
+        return;
+    }
 
     /*
      * Mark block_bitmap_mapping as present now while we have the
@@ -1327,10 +1262,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
         migrate_get_current()->has_block_bitmap_mapping = true;
     }
 
-    if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(&tmp);
+    if (migrate_params_check(tmp, errp)) {
+        migrate_params_apply(tmp);
         migrate_post_update_params(params, errp);
     }
 
-    migrate_tls_opts_free(&tmp);
+    qapi_free_MigrationParameters(tmp);
 }
-- 
2.35.3


