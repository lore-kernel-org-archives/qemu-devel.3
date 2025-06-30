Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95764C8303B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 19:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKfF-0002YQ-MG; Mon, 30 Jun 2025 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfD-0002YF-Dm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfA-0007TI-HA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A67E21162;
 Mon, 30 Jun 2025 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDvcSIXfqYxA+umokAr0UpiFTPC5+l3e0ZJItgJfC9E=;
 b=xuIn/zFlp+DWTvNgo1faRfJhD8Dch2L7UaDs/RgPiVAFRqkaFUNPgIErYK+SSp3xpuTvzd
 mogUhTt5hl8reA9gNsTbggAcyXgrSySnyW0PtJ0rLhs5nSGiGJEZ1+yyYheX/WxkEVu4ah
 wvX423oLdypc5v69kyvQG1iOa5B9RZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDvcSIXfqYxA+umokAr0UpiFTPC5+l3e0ZJItgJfC9E=;
 b=dbOVAG29v7KFNXV6ayU5Jgxjf0FwCW3qLkPcXzyUBej/dUmd98znwAExS9DkPs/lb5jnsH
 spDOqFvfvBo0slBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDvcSIXfqYxA+umokAr0UpiFTPC5+l3e0ZJItgJfC9E=;
 b=xuIn/zFlp+DWTvNgo1faRfJhD8Dch2L7UaDs/RgPiVAFRqkaFUNPgIErYK+SSp3xpuTvzd
 mogUhTt5hl8reA9gNsTbggAcyXgrSySnyW0PtJ0rLhs5nSGiGJEZ1+yyYheX/WxkEVu4ah
 wvX423oLdypc5v69kyvQG1iOa5B9RZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDvcSIXfqYxA+umokAr0UpiFTPC5+l3e0ZJItgJfC9E=;
 b=dbOVAG29v7KFNXV6ayU5Jgxjf0FwCW3qLkPcXzyUBej/dUmd98znwAExS9DkPs/lb5jnsH
 spDOqFvfvBo0slBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADC901399F;
 Mon, 30 Jun 2025 19:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aJeyG5rsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 03/24] migration: Normalize tls arguments
Date: Mon, 30 Jun 2025 16:58:52 -0300
Message-Id: <20250630195913.28033-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
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

The migration parameters tls_creds, tls_authz and tls_hostname
currently have a non-uniform handling. When used as arguments to
migrate-set-parameters, their type is StrOrNull and when used as
return value from query-migrate-parameters their type is a plain
string.

Not only having to convert between the types is cumbersome, but it
also creates the issue of requiring two different QAPI types to be
used, one for each command. MigrateSetParameters is used for
migrate-set-parameters with the TLS arguments as StrOrNull while
MigrationParameters is used for query-migrate-parameters with the TLS
arguments as str.

Since StrOrNull could be considered a superset of str, change the type
of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
that QTYPE_QNULL is never used.

1) migrate-set-parameters will always write QTYPE_QSTRING to
  s->parameters, either an empty or non-empty string.

2) query-migrate-parameters will always return a QTYPE_QSTRING, either
  empty or non-empty.

3) the migrate_tls_* helpers will always return a non-empty string or
  NULL, for the internal migration code's consumption.

Points (1) and (2) above help simplify the parameters validation and
the query command handling because s->parameters is already kept in
the format that query-migrate-parameters (and info migrate_paramters)
expect. Point (3) is so people don't need to care about StrOrNull in
migration code.

This will allow the type duplication to be removed in the next
patches.

Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
from str to StrOrNull in introspection of the query-migrate-parameters
command. We accept this imprecision to enable de-duplication.

There's no need to free the TLS options in
migration_instance_finalize() because they're freed by the qdev
properties .release method.

Temporary in this patch:
migrate_params_test_apply() copies s->parameters into a temporary
structure, so it's necessary to drop the references to the TLS options
if they were not set by the user to avoid double-free. This is fixed
in the next patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |   7 +-
 migration/options.c            | 156 ++++++++++++++++++++-------------
 migration/options.h            |   1 +
 migration/tls.c                |   2 +-
 qapi/migration.json            |   6 +-
 5 files changed, 106 insertions(+), 66 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e8a563c7d8..547384edb5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -279,11 +279,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         assert(params->tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-            params->tls_creds);
+                       params->tls_creds->u.s);
         assert(params->tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-            params->tls_hostname);
+                       params->tls_hostname->u.s);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -317,9 +317,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
+        assert(params->tls_authz);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
+                       params->tls_authz->u.s);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
diff --git a/migration/options.c b/migration/options.c
index 384ef9e421..f7bbdba5fc 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -167,9 +167,10 @@ const Property migration_properties[] = {
     DEFINE_PROP_SIZE("announce-step", MigrationState,
                       parameters.announce_step,
                       DEFAULT_MIGRATE_ANNOUNCE_STEP),
-    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
-    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
-    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState, parameters.tls_creds),
+    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
+                            parameters.tls_hostname),
+    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState, parameters.tls_authz),
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
                        parameters.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
@@ -241,6 +242,11 @@ static void release_StrOrNull(Object *obj, const char *name, void *opaque)
 
 static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
 {
+    /*
+     * Initialization to the empty string here is important so
+     * query-migrate-parameters doesn't need to deal with a NULL value
+     * when it's called before any TLS option has been set.
+     */
     object_property_set_default_str(op, "");
 }
 
@@ -426,13 +432,6 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
-bool migrate_tls(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.tls_creds && *s->parameters.tls_creds;
-}
-
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
@@ -881,21 +880,38 @@ const char *migrate_tls_authz(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_authz;
+    if (*s->parameters.tls_authz->u.s) {
+        return s->parameters.tls_authz->u.s;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_creds(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_creds;
+    if (*s->parameters.tls_creds->u.s) {
+        return s->parameters.tls_creds->u.s;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_hostname;
+    if (*s->parameters.tls_hostname->u.s) {
+        return s->parameters.tls_hostname->u.s;
+    }
+
+    return NULL;
+}
+
+bool migrate_tls(void)
+{
+    return !!migrate_tls_creds();
 }
 
 uint64_t migrate_vcpu_dirty_limit_period(void)
@@ -935,6 +951,37 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
+void migrate_tls_opts_free(MigrationParameters *params)
+{
+    qapi_free_StrOrNull(params->tls_creds);
+    qapi_free_StrOrNull(params->tls_hostname);
+    qapi_free_StrOrNull(params->tls_authz);
+}
+
+/* either non-empty or empty string */
+static void tls_opt_to_str(StrOrNull **tls_opt)
+{
+    StrOrNull *opt = *tls_opt;
+
+    if (!opt) {
+        return;
+    }
+
+    switch (opt->type) {
+    case QTYPE_QSTRING:
+        return;
+    case QTYPE_QNULL:
+        qobject_unref(opt->u.n);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    opt->type = QTYPE_QSTRING;
+    opt->u.s = g_strdup("");
+    *tls_opt = opt;
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -950,10 +997,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
-    params->tls_authz = g_strdup(s->parameters.tls_authz ?
-                                 s->parameters.tls_authz : "");
+    params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
+    params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
+    params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_avail_switchover_bandwidth = true;
@@ -1010,9 +1056,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
-
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
@@ -1189,7 +1232,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
         ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+         *params->tls_creds->u.s)) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1251,18 +1294,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
+        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
+        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        dest->tls_authz = params->tls_authz->u.s;
+        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1367,21 +1416,19 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->tls_creds) {
-        g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_creds);
+        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
     }
 
     if (params->tls_hostname) {
-        g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_hostname);
+        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
+                                                params->tls_hostname);
     }
 
     if (params->tls_authz) {
-        g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_authz);
+        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
     }
 
     if (params->has_max_bandwidth) {
@@ -1480,32 +1527,23 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-    /* TODO Rewrite "" to null instead for all three tls_* parameters */
-    if (params->tls_creds
-        && params->tls_creds->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_creds->u.n);
-        params->tls_creds->type = QTYPE_QSTRING;
-        params->tls_creds->u.s = strdup("");
-    }
-    if (params->tls_hostname
-        && params->tls_hostname->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_hostname->u.n);
-        params->tls_hostname->type = QTYPE_QSTRING;
-        params->tls_hostname->u.s = strdup("");
-    }
-    if (params->tls_authz
-        && params->tls_authz->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_authz->u.n);
-        params->tls_authz->type = QTYPE_QSTRING;
-        params->tls_authz->u.s = strdup("");
-    }
+    /*
+     * Convert QTYPE_QNULL and NULL to the empty string (""). Even
+     * though NULL is cleaner to deal with in C code, that would force
+     * query-migrate-parameters to convert it once more to the empty
+     * string, so avoid that. The migrate_tls_*() helpers that expose
+     * the options to the rest of the migration code already use
+     * return NULL when the empty string is found.
+     */
+    tls_opt_to_str(&params->tls_creds);
+    tls_opt_to_str(&params->tls_hostname);
+    tls_opt_to_str(&params->tls_authz);
 
     migrate_params_test_apply(params, &tmp);
 
-    if (!migrate_params_check(&tmp, errp)) {
-        /* Invalid parameter */
-        return;
+    if (migrate_params_check(&tmp, errp)) {
+        migrate_params_apply(params, errp);
     }
 
-    migrate_params_apply(params, errp);
+    migrate_tls_opts_free(&tmp);
 }
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..999eee6f3b 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -91,4 +91,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+void migrate_tls_opts_free(MigrationParameters *params);
 #endif
diff --git a/migration/tls.c b/migration/tls.c
index 5cbf952383..8a89d3f767 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -126,7 +126,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     }
 
     const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname && *tls_hostname) {
+    if (tls_hostname) {
         hostname = tls_hostname;
     }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca12..97bb022c45 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1293,9 +1293,9 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'str',
-            '*tls-hostname': 'str',
-            '*tls-authz': 'str',
+            '*tls-creds': 'StrOrNull',
+            '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
             '*avail-switchover-bandwidth': 'size',
             '*downtime-limit': 'uint64',
-- 
2.35.3


