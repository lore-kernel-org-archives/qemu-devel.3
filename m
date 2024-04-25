Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFB6C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzol5-0000Xy-Oc; Wed, 24 Apr 2024 22:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol3-0000X9-5g
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:45 -0400
Received: from out-173.mta1.migadu.com ([95.215.58.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol1-0005IL-An
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:44 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzuSJ1zKYkpx7ByvuyAxfu5NoEWY50aKxHnWj75q2gE=;
 b=IOsynXx6S5B89y3R2OsL6G69El2xPkzR4+iWqeJ3Z4HKiGZ4LZIxM2aGa3nIfsKLuMZSOK
 6PknMF91LaNpo6f4ugRtGCMHLjVFMXjpP1SknXWFYDaJ3fCGFc+BgsEuywkm9AsSuvos8d
 Evco26giDoklEmzP/Bdi2U3obVlbL4Y=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 08/14] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Thu, 25 Apr 2024 02:21:11 +0000
Message-Id: <20240425022117.4035031-9-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.173; envelope-from=hao.xiang@linux.dev;
 helo=out-173.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Intel DSA offloading is an optional feature that turns on if
proper hardware and software stack is available. To turn on
DSA offloading in multifd live migration:

multifd-dsa-accel="[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]"

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 26 +++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffd..7e9bb278c9 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -358,6 +358,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
+            params->multifd_dsa_accel);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -622,6 +625,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_block_incremental = true;
         visit_type_bool(v, param, &p->block_incremental, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL:
+        p->multifd_dsa_accel = g_new0(StrOrNull, 1);
+        p->multifd_dsa_accel->type = QTYPE_QSTRING;
+        visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/options.c b/migration/options.c
index 239f5ecfb4..dc8642df81 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -182,6 +182,8 @@ Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
+                       parameters.multifd_dsa_accel),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -920,6 +922,13 @@ const char *migrate_tls_creds(void)
     return s->parameters.tls_creds;
 }
 
+const char *migrate_multifd_dsa_accel(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_dsa_accel;
+}
+
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1060,6 +1069,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->mode = s->parameters.mode;
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
+    params->multifd_dsa_accel = g_strdup(s->parameters.multifd_dsa_accel ?
+                                         s->parameters.multifd_dsa_accel : "");
 
     return params;
 }
@@ -1068,6 +1079,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->multifd_dsa_accel = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
@@ -1416,6 +1428,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->multifd_dsa_accel) {
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        dest->multifd_dsa_accel = params->multifd_dsa_accel->u.s;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1570,6 +1587,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_zero_page_detection) {
         s->parameters.zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->multifd_dsa_accel) {
+        g_free(s->parameters.multifd_dsa_accel);
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        s->parameters.multifd_dsa_accel =
+            g_strdup(params->multifd_dsa_accel->u.s);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1595,6 +1619,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         params->tls_authz->type = QTYPE_QSTRING;
         params->tls_authz->u.s = strdup("");
     }
+    if (params->multifd_dsa_accel
+        && params->multifd_dsa_accel->type == QTYPE_QNULL) {
+        qobject_unref(params->multifd_dsa_accel->u.n);
+        params->multifd_dsa_accel->type = QTYPE_QSTRING;
+        params->multifd_dsa_accel->u.s = strdup("");
+    }
 
     migrate_params_test_apply(params, &tmp);
 
diff --git a/migration/options.h b/migration/options.h
index ab8199e207..1cb3393be9 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -91,6 +91,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const char *migrate_multifd_dsa_accel(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..934fa8839e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -914,6 +914,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -937,7 +943,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit', 'multifd-dsa-accel',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
@@ -1122,6 +1128,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1176,7 +1188,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*multifd-dsa-accel': 'StrOrNull'} }
 
 ##
 # @migrate-set-parameters:
@@ -1354,6 +1367,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1405,7 +1424,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*multifd-dsa-accel': 'str'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


