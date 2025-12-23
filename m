Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CCBE6F096
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QK-0003Fg-N8; Tue, 23 Dec 2025 09:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0001IC-Sx
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PC-0003nG-Gk
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SiKop/pkTYvinHIAY2aXedBPdBPIWINt60UXVR2YPEY=;
 b=Bl+pzDhKxU6w56nJpKgEhZ2upn1Di0Kx7Xe4mjIm0XPtaQUPBm+7Wv1CIjK6Q8/WJwdN1h
 Oi1w7FRN0YVtaSpQJoIGCIbmwu0Ioojz9IgrncbfXms9cEggovrbvYzvEJvqQAnINN1ARY
 wBIHzWHYoOIdJmhvflMFTS7lXxzIp5E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-PPzBKl9KPLOzemJI1YU6LQ-1; Tue, 23 Dec 2025 09:30:27 -0500
X-MC-Unique: PPzBKl9KPLOzemJI1YU6LQ-1
X-Mimecast-MFC-AGG-ID: PPzBKl9KPLOzemJI1YU6LQ_1766500227
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8bb3388703dso1752690485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500227; x=1767105027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiKop/pkTYvinHIAY2aXedBPdBPIWINt60UXVR2YPEY=;
 b=aiLUZk8uJsJWRF3f7LGVzN3M2scK+ezrTWn6pEwAhQjITYTM8DvkeAOxaK2+D+Neis
 bszLZqGTQs7AD0m9HWF4uY8ad+T8xJzJRHurX5MPnUVXYpETg2TAzbcZSjrLSEkzg136
 cLhYb9F2Raxu2R2a8Lp4mcAJtOYwpVwTeYgLGKiwNeqc1V2Bh8b/qNxNKHBjUjPYP0nw
 5yOg3gtH/uA4/GtKPmU5E4EhcMWh/aALvPa2fJpr8AnamexPzB8ug8bJEvxOkDBjR1JX
 1UV7YIvOP+aC90UDygRX3vnxOVCj+o4OZ3R2fQo0CGvNZ0WtD/043HYbh6jECaFO8ZOW
 gWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500227; x=1767105027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SiKop/pkTYvinHIAY2aXedBPdBPIWINt60UXVR2YPEY=;
 b=XSK4x+7TmtKmNV2e82K96gUnxmDdqmqOBHjLttfCj5V7v9d0C95i/yuQJqbhLINGSp
 mThU+g07LcqoN8GxXSh1iK5oOLmeI5eGMlW+qs16u1mXrjjoFa6wNz7++U0U/pY/DXFL
 uJLdblcqrq5QbWcT/F8v9EzUC5xHRz5dwFNs7KO8yo0YXJgsSlUj7dO3ZUdwYMoTe5Xr
 nGqveejOLgb6mWDgvTGo6eB/7bUnYj2z5yoEw9hB8kKhe2BnX56aWqn0t51ScE3v+uCh
 FKYIweZtD7Pk8wNsEJ89yIIzKMASM8BvUOBHdvjBF9BHbYv8Hf0jjr1f6SznCmXukrol
 kkdA==
X-Gm-Message-State: AOJu0YzTeXrSEdNHUVhqEYslCYgMPcsw6MZ5OTlOJk8Ml1zNBGghxHBV
 0r4LdUJuRbH209WeyyW9xZq6bLAq2xKEiviz61E37yHLA7JhO5ehrgV6tF/lIErKfZWXOwt/Vke
 C/410UHsL9+Vx8rlbyAijV7kh5rkJ6IxbnRNjo+LMqkzgdHuHZAzT3q5YzdvSRWpwnCzvW5xvQS
 XKfn9HDwdBEnD8RO7GTW0ylD9dR2mEeK7fyHNykA==
X-Gm-Gg: AY/fxX50nKtMHgqWtDTbzQ8GX+117GFPA9G44GaImoPf13Z00nPJ6KCN47N5TNFSgGd
 gnoTWX3ejU+wwaeZfzCvCbZ25YVAzNAXrYii8E/Ef6oAwlm/a11uHXqWB/cFjdHKeJZ9DzpK1A8
 tR902hwKr8yRmtrkMJHImsGgiV1Vv2GcweNsaAebl2FanjO9wj30OTEHJdi3ufGNul0V0f9S82V
 XHVAcTwFu+sbRTkFswDgn51aUP8IjZ01PvMxD4xDQAXpZnfvlZXeQmQtIp3lKSHQGtsCl7b5I+B
 LRmmnCZcDAPN4dfqRA0qbu91tjvpFMQyR7zu1Gz+V6j9YbiA3eiRN29u9jRL+CGdn+ArvaBnfjv
 VIgY=
X-Received: by 2002:a05:620a:1285:b0:8c0:f15f:b0e with SMTP id
 af79cd13be357-8c0f15f0c27mr1139557785a.80.1766500226488; 
 Tue, 23 Dec 2025 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH97n+WTi4MjSc01Tg8sbthygXJ+UGO3HXBS615L90p2n+dxlgJa1gXy1kohNcv0FC5ByTYKg==
X-Received: by 2002:a05:620a:1285:b0:8c0:f15f:b0e with SMTP id
 af79cd13be357-8c0f15f0c27mr1139544585a.80.1766500225093; 
 Tue, 23 Dec 2025 06:30:25 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:24 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 19/31] migration: Normalize tls arguments
Date: Tue, 23 Dec 2025 09:29:47 -0500
Message-ID: <20251223142959.1460293-20-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

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
Link: https://lore.kernel.org/r/20251215220041.12657-6-farosas@suse.de
[peterx: in hmp_info_migrate_parameters(), remove an extra dump of
 max_postcopy_bandwidth, introduced likely by accident]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            |   6 +-
 migration/options.h            |   1 +
 migration/migration-hmp-cmds.c |   6 +-
 migration/options.c            | 144 +++++++++++++++++++--------------
 migration/tls.c                |   2 +-
 5 files changed, 93 insertions(+), 66 deletions(-)

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
diff --git a/migration/options.h b/migration/options.h
index a7b3262d1e..25fb316420 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,4 +92,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+void migrate_tls_opts_free(MigrationParameters *params);
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 79426bf5d7..edc561a34a 100644
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
diff --git a/migration/options.c b/migration/options.c
index d55f3104be..6ef3c56fb6 100644
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
@@ -259,6 +260,11 @@ static void release_StrOrNull(Object *obj, const char *name, void *opaque)
 
 static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
 {
+    /*
+     * Initialization to the empty string here is important so
+     * query-migrate-parameters doesn't need to deal with a NULL value
+     * when it's called before any TLS option has been set.
+     */
     object_property_set_default_str(op, "");
 }
 
@@ -450,13 +456,6 @@ bool migrate_rdma(void)
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
@@ -931,21 +930,38 @@ const char *migrate_tls_authz(void)
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
@@ -985,6 +1001,25 @@ AnnounceParameters *migrate_announce_params(void)
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
@@ -1000,10 +1035,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
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
@@ -1063,9 +1097,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
-
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
@@ -1243,7 +1274,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
         ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+         *params->tls_creds->u.s)) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1305,18 +1336,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
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
@@ -1425,21 +1462,19 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
@@ -1544,32 +1579,23 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
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
 
-- 
2.50.1


