Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B0D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGd1-0002ac-6u; Mon, 15 Dec 2025 17:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcz-0002aE-FS
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcx-0002bn-7T
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE2B35BDE8;
 Mon, 15 Dec 2025 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLRcEZW6pX/P6pjWpPctISzotCOPXAqNg/NKTHGEWiA=;
 b=VWaXC6OvWsw3hcu47cFN68eXjpEo5RxFsfnwHe4c55C+ST90WyJEJDmzXQzhxBF6rjOiT7
 ytufc8Kzr65J7VkzwoeueisUGylEV8VGm7oYkU5zzRW/b+CS2m/GdcLAHVxWIYfLn10GyF
 xbcngs+ssP6T2vhvOD9oVx3g57SDFMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLRcEZW6pX/P6pjWpPctISzotCOPXAqNg/NKTHGEWiA=;
 b=vuBIZ8rMMWYCotQ8yWL5ldPGyQlcg0qxuo7u91IljHPR9VlFZcAR6v5DYjsWUr5gsqVvOl
 VqBjULcTaaxnyqBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j+t2isGf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4PovBd0Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLRcEZW6pX/P6pjWpPctISzotCOPXAqNg/NKTHGEWiA=;
 b=j+t2isGfg/R8IxyrUlEf2gbpN43wGKLzg8wd+zLsrSc81fOldqqDfrMkXvta6RGhN7ADa8
 KtwSHWTMuK9K5ekOTeQWaiAXL1ycDoA6gYyLb0yu521cQ5ZfA+6jzIeQ725ItKm8LZ8Lpg
 lZURqcLz2OCd7Ch3IpRy4o+9y9IKfDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLRcEZW6pX/P6pjWpPctISzotCOPXAqNg/NKTHGEWiA=;
 b=4PovBd0ZMrXDhsoWsEVfSZYhiDphyQENNQGEicDeUCGCfuORHvJGOhfPeelanpSoMjNc1X
 et2eTO1qYBKfmCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16B283EA63;
 Mon, 15 Dec 2025 22:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GIEgMh+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 05/51] migration: Normalize tls arguments
Date: Mon, 15 Dec 2025 18:59:51 -0300
Message-ID: <20251215220041.12657-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DE2B35BDE8
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |   9 ++-
 migration/options.c            | 144 +++++++++++++++++++--------------
 migration/options.h            |   1 +
 migration/tls.c                |   2 +-
 qapi/migration.json            |   6 +-
 5 files changed, 96 insertions(+), 66 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 79426bf5d7..dbab5028c2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -360,15 +360,15 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
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
         assert(params->tls_authz);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
+                       params->tls_authz->u.s);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -403,6 +403,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
+            params->max_postcopy_bandwidth);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
diff --git a/migration/options.c b/migration/options.c
index 5f387437d1..4ca6ff0fe9 100644
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
@@ -257,6 +258,11 @@ static void release_StrOrNull(Object *obj, const char *name, void *opaque)
 
 static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
 {
+    /*
+     * Initialization to the empty string here is important so
+     * query-migrate-parameters doesn't need to deal with a NULL value
+     * when it's called before any TLS option has been set.
+     */
     object_property_set_default_str(op, "");
 }
 
@@ -448,13 +454,6 @@ bool migrate_rdma(void)
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
@@ -929,21 +928,38 @@ const char *migrate_tls_authz(void)
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
@@ -983,6 +999,25 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
+void migrate_tls_opts_free(MigrationParameters *params)
+{
+    qapi_free_StrOrNull(params->tls_creds);
+    qapi_free_StrOrNull(params->tls_hostname);
+    qapi_free_StrOrNull(params->tls_authz);
+}
+
+/* normalize QTYPE_QNULL to QTYPE_QSTRING "" */
+static void tls_opt_to_str(StrOrNull *opt)
+{
+    if (!opt || opt->type == QTYPE_QSTRING) {
+        return;
+    }
+
+    qobject_unref(opt->u.n);
+    opt->type = QTYPE_QSTRING;
+    opt->u.s = g_strdup("");
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -998,10 +1033,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
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
@@ -1061,9 +1095,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
-
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
@@ -1241,7 +1272,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
         ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+         *params->tls_creds->u.s)) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1303,18 +1334,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
+        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
+    } else {
+        /* clear the reference, it's owned by s->parameters */
+        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
+        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
+    } else {
+        /* clear the reference, it's owned by s->parameters */
+        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        dest->tls_authz = params->tls_authz->u.s;
+        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
+    } else {
+        /* clear the reference, it's owned by s->parameters */
+        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1423,21 +1460,19 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
@@ -1542,32 +1577,23 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
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
+    tls_opt_to_str(params->tls_creds);
+    tls_opt_to_str(params->tls_hostname);
+    tls_opt_to_str(params->tls_authz);
 
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
index a7b3262d1e..25fb316420 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,4 +92,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+void migrate_tls_opts_free(MigrationParameters *params);
 #endif
diff --git a/migration/tls.c b/migration/tls.c
index 284a6194b2..56b5d1cc90 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -130,7 +130,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     }
 
     const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname && *tls_hostname) {
+    if (tls_hostname) {
         hostname = tls_hostname;
     }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index cf023bd29d..30a0eb2d7e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1382,9 +1382,9 @@
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
2.51.0


