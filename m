Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA82C369B1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3JqD-0003x3-8o; Fri, 11 Apr 2025 15:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqB-0003wZ-Es
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jq9-0005yP-4Q
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:03 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD9341F453;
 Fri, 11 Apr 2025 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHvVJjcEIzNSFG0PMffj1+aMv+tXjeJ0kBNej+uLdBE=;
 b=FN1MgTCwBOczp+xeBRGgrfY/gRDlYR/poq89Rq5hbcgduHp0C+S06c6xc8XnLHCAtCjddh
 /JZgUHbLBfdrLIeY9SoyL/0siLv5n2USVvuMPYcXcHjO6hCmcpAvB0Jiwu1yBn3tBQ9CYL
 IyrbGdqWfB+/fti/zWvWwSuB0wvPEFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHvVJjcEIzNSFG0PMffj1+aMv+tXjeJ0kBNej+uLdBE=;
 b=RGv0E2aHHGteUzgQegh5dpcioP6Tp1J/6vfQRhclXiAWo4wdFIK0pVORlg9QGl10RdYVqA
 CTSBUKIeJ8FPv3Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHvVJjcEIzNSFG0PMffj1+aMv+tXjeJ0kBNej+uLdBE=;
 b=FN1MgTCwBOczp+xeBRGgrfY/gRDlYR/poq89Rq5hbcgduHp0C+S06c6xc8XnLHCAtCjddh
 /JZgUHbLBfdrLIeY9SoyL/0siLv5n2USVvuMPYcXcHjO6hCmcpAvB0Jiwu1yBn3tBQ9CYL
 IyrbGdqWfB+/fti/zWvWwSuB0wvPEFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHvVJjcEIzNSFG0PMffj1+aMv+tXjeJ0kBNej+uLdBE=;
 b=RGv0E2aHHGteUzgQegh5dpcioP6Tp1J/6vfQRhclXiAWo4wdFIK0pVORlg9QGl10RdYVqA
 CTSBUKIeJ8FPv3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6039B13886;
 Fri, 11 Apr 2025 19:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MGLiCDJq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:14:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 06/13] migration: Remove the parameters copy during
 validation
Date: Fri, 11 Apr 2025 16:14:36 -0300
Message-Id: <20250411191443.22565-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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

While validating migration parameters, a temporary structure is used
to apply the values to be validated. Only when validation succeeds on
the temporary values, they are actually copied into the internal
s->parameters.

There is however an extra step, which is to copy s->parameters into
the temporary structure prior to merging the new values in. This is
not documented.

The validation function is intended to only validate new values by
checking the QAPI generated has_* boolean fields for each struct
member. However, nothing ever sets the has_* fields on the temporary
structure, so the reason that copy is there is to take advantage of
the has_* fields of s->parameters, which _have_ been set by
migrate_params_init() for the same reason of allowing
migrate_params_check() to interpret the values as newly added.

This is convoluted and has led to the current state of validating
_every_ parameter, even the ones who were not set by the user.

migrate_params_init() sets _all_ has_* fields because there are global
qdev properties defined for every parameter and those need to be
validated at migration_object_check().

Detangle the validation done at object creation from the one done
after user input, remove the s->parameters copy and move the
migrate_params_init() function close to the
migrate_params_check(). Add comments.

With the removal of the copy at migrate_set_parameters, there's still
the need to convert MigrateSetParameters into MigrationParameters to
satisfy the signature of migrate_params_check(). This is fine. Keep
it, but replace the inline copy of every member (done at
migrate_params_test_apply) with a QAPI_CLONE call as long prophecized
by the code comments.

This last step cannot be in a separate patch because with the removal
of the s->parameters copy, something needs to be done to set the has_*
fields of the temporary structure so it can be validated. That
something is already embedded in the MigrateSetParameters ->
MigrationParameters conversion due to the former having the booleans
properly set by QAPI.

MigrateSetParameters and MigrationParameters are obviously not of the
same type, so the QAPI_CLONE call will use the common base
MigrationConfigBase. The only remaining fields will be the TLS options
which will be set inline.

For the validation done at migration_check_object(), introduce a new
copy, to make sure we're not operating on the s->parameters and
leaving it dirty with the has_* fields set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  22 +++++-
 migration/options.c   | 175 ++++++++++++------------------------------
 2 files changed, 67 insertions(+), 130 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..2c3bb98df8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4051,8 +4051,6 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
-    migrate_params_init(&ms->parameters);
-
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
@@ -4070,11 +4068,29 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
 {
     /* Assuming all off */
     bool old_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
+    g_autoptr(MigrationParameters) globals = NULL;
 
-    if (!migrate_params_check(&ms->parameters, errp)) {
+    /*
+     * Copy the values that were already set via qdev properties
+     * (-global).
+     */
+    globals = QAPI_CLONE(MigrationParameters, &ms->parameters);
+
+    /*
+     * Set the has_* fields because migrate_params_check() only
+     * validates new fields.
+     */
+    migrate_params_init(globals);
+
+    if (!migrate_params_check(globals, errp)) {
         return false;
     }
 
+    /*
+     * After the validation succeeds, there's no need to apply the
+     * 'globals' because the values are already in s->config.
+     */
+
     return migrate_caps_check(old_caps, ms->capabilities, errp);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 625d597a85..87599e4fdd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -958,11 +958,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
-    params->tls_authz = g_strdup("");
-
-    /* Set has_* up only for parameter checks */
+    /* these should match the parameters in migration_properties */
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
@@ -1178,138 +1174,51 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrateSetParameters *params,
-                                      MigrationParameters *dest)
+/*
+ * Compatibility layer to convert MigrateSetParameters to
+ * MigrationParameters. In the existing QMP user interface, the
+ * migrate-set-parameters command takes the TLS options as 'StrOrNull'
+ * while the query-migrate-parameters command returns the TLS strings
+ * as 'str'.
+ */
+static void migrate_params_copy_compat(MigrationParameters *dst,
+                                       MigrateSetParameters *src)
 {
-    *dest = migrate_get_current()->parameters;
-
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
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
-        if (params->tls_creds->type == QTYPE_QNULL) {
-            dest->tls_creds = NULL;
+    /* copy the common elements between the two */
+    QAPI_CLONE_MEMBERS(MigrationConfigBase,
+                       (MigrationConfigBase *)dst,
+                       (MigrationConfigBase *)src);
+
+     /* now copy the elements of different type */
+    if (src->tls_creds) {
+        if (src->tls_creds->type == QTYPE_QNULL) {
+            dst->tls_creds = NULL;
         } else {
-            dest->tls_creds = params->tls_creds->u.s;
+            dst->tls_creds = src->tls_creds->u.s;
         }
     }
 
-    if (params->tls_hostname) {
-        if (params->tls_hostname->type == QTYPE_QNULL) {
-            dest->tls_hostname = NULL;
+    if (src->tls_hostname) {
+        if (src->tls_hostname->type == QTYPE_QNULL) {
+            dst->tls_hostname = NULL;
         } else {
-            dest->tls_hostname = params->tls_hostname->u.s;
+            dst->tls_hostname = src->tls_hostname->u.s;
         }
     }
 
-    if (params->tls_authz) {
-        if (params->tls_authz->type == QTYPE_QNULL) {
-            dest->tls_authz = NULL;
+    if (src->tls_authz) {
+        if (src->tls_authz->type == QTYPE_QNULL) {
+            dst->tls_authz = NULL;
         } else {
-            dest->tls_authz = params->tls_authz->u.s;
+            dst->tls_authz = src->tls_authz->u.s;
         }
     }
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
-        dest->has_block_bitmap_mapping = true;
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
 }
 
 static void migrate_params_apply(MigrateSetParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-
     if (params->has_throttle_trigger_threshold) {
         s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
@@ -1328,20 +1237,32 @@ static void migrate_params_apply(MigrateSetParameters *params)
 
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+
+        if (params->tls_creds->type == QTYPE_QNULL) {
+            s->parameters.tls_creds = NULL;
+        } else {
+            s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        }
     }
 
     if (params->tls_hostname) {
         g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+
+        if (params->tls_hostname->type == QTYPE_QNULL) {
+            s->parameters.tls_hostname = NULL;
+        } else {
+            s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        }
     }
 
     if (params->tls_authz) {
         g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+
+        if (params->tls_authz->type == QTYPE_QNULL) {
+            s->parameters.tls_authz = NULL;
+        } else {
+            s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        }
     }
 
     if (params->has_max_bandwidth) {
@@ -1456,9 +1377,9 @@ static void migrate_post_update_params(MigrateSetParameters *new, Error **errp)
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationParameters tmp = {};
 
-    migrate_params_test_apply(params, &tmp);
+    migrate_params_copy_compat(&tmp, params);
 
     if (!migrate_params_check(&tmp, errp)) {
         /* Invalid parameter */
-- 
2.35.3


