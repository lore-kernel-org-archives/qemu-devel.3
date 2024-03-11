Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A7C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjxv-0005LJ-AE; Mon, 11 Mar 2024 14:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjxt-0005KP-BC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:01:33 -0400
Received: from out-184.mta0.migadu.com ([91.218.175.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rjjxp-0002sq-4M
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:01:33 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1710180087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R769JfmEyVOIMzlVN65hso0+xIgOCOUWqBq1mzEuFc8=;
 b=MYYuuYj3lPTcrnngXwC6J2TkMUjXyiK9ss8H2zF2Ve8+zks6ncsYxgaZPDeMu0H1Bci9To
 xtei26wglW3wAezZJGdVcWitGOMuKbn9PPZGa/FRFsPwNMPn+xuSSh043a1GsLb5r9w84d
 MmEm6GxW0aNsX8PydLkUDZmHsKTjixI=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v6 3/7] migration/multifd: Add new migration option
 zero-page-detection.
Date: Mon, 11 Mar 2024 18:00:11 +0000
Message-Id: <20240311180015.3359271-4-hao.xiang@linux.dev>
In-Reply-To: <20240311180015.3359271-1-hao.xiang@linux.dev>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.184; envelope-from=hao.xiang@linux.dev;
 helo=out-184.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@bytedance.com>

This new parameter controls where the zero page checking is running.
1. If this parameter is set to 'legacy', zero page checking is
done in the migration main thread.
2. If this parameter is set to 'none', zero page checking is disabled.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240301022829.3390548-2-hao.xiang@bytedance.com>
---
 hw/core/qdev-properties-system.c    | 10 +++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 migration/migration-hmp-cmds.c      |  9 ++++++++
 migration/options.c                 | 21 ++++++++++++++++++
 migration/options.h                 |  1 +
 migration/ram.c                     |  4 ++++
 qapi/migration.json                 | 33 ++++++++++++++++++++++++++---
 7 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b45e90edb2..71a21bf24e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -693,6 +693,16 @@ const PropertyInfo qdev_prop_granule_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+const PropertyInfo qdev_prop_zero_page_detection = {
+    .name = "ZeroPageDetection",
+    .description = "zero_page_detection values, "
+                   "none,legacy",
+    .enum_table = &ZeroPageDetection_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 626be87dd3..438f65389f 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -9,6 +9,7 @@ extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
+extern const PropertyInfo qdev_prop_zero_page_detection;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -50,6 +51,9 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
                        MigMode)
 #define DEFINE_PROP_GRANULE_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_granule_mode, GranuleMode)
+#define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
+                       ZeroPageDetection)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99b49df5dd..7e96ae6ffd 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
             MultiFDCompression_str(params->multifd_compression));
+        assert(params->has_zero_page_detection);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
+            qapi_enum_lookup(&ZeroPageDetection_lookup,
+                params->zero_page_detection));
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
@@ -634,6 +639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
         break;
+    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
+        p->has_zero_page_detection = true;
+        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection, &err);
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size = true;
         if (!visit_type_size(v, param, &cache_size, &err)) {
diff --git a/migration/options.c b/migration/options.c
index 40eb930940..8c849620dd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -179,6 +179,9 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_MODE("mode", MigrationState,
                       parameters.mode,
                       MIG_MODE_NORMAL),
+    DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
+                       parameters.zero_page_detection,
+                       ZERO_PAGE_DETECTION_LEGACY),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -931,6 +934,13 @@ uint64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
+ZeroPageDetection migrate_zero_page_detection(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.zero_page_detection;
+}
+
 /* parameter setters */
 
 void migrate_set_block_incremental(bool value)
@@ -1041,6 +1051,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
     params->has_mode = true;
     params->mode = s->parameters.mode;
+    params->has_zero_page_detection = true;
+    params->zero_page_detection = s->parameters.zero_page_detection;
 
     return params;
 }
@@ -1077,6 +1089,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
+    params->has_zero_page_detection = true;
 }
 
 /*
@@ -1391,6 +1404,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->has_zero_page_detection) {
+        dest->zero_page_detection = params->zero_page_detection;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1541,6 +1558,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->has_zero_page_detection) {
+        s->parameters.zero_page_detection = params->zero_page_detection;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 6ddd8dad9b..8b2481385a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -94,6 +94,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+ZeroPageDetection migrate_zero_page_detection(void);
 
 /* parameters setters */
 
diff --git a/migration/ram.c b/migration/ram.c
index f4abc47bbf..930061d1eb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1140,6 +1140,10 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
+        return 0;
+    }
+
     if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         return 0;
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 51d188b902..83fdef73b9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -670,6 +670,18 @@
 { 'enum': 'MigMode',
   'data': [ 'normal', 'cpr-reboot' ] }
 
+##
+# @ZeroPageDetection:
+#
+# @none: Do not perform zero page checking.
+#
+# @legacy: Perform zero page checking in main migration thread.
+#
+# Since: 9.0
+##
+{ 'enum': 'ZeroPageDetection',
+  'data': [ 'none', 'legacy' ] }
+
 ##
 # @BitmapMigrationBitmapAliasTransform:
 #
@@ -891,6 +903,10 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages.
+#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -924,7 +940,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'zero-page-detection'] }
 
 ##
 # @MigrateSetParameters:
@@ -1083,6 +1100,10 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages.
+#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1136,7 +1157,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*zero-page-detection': 'ZeroPageDetection'} }
 
 ##
 # @migrate-set-parameters:
@@ -1311,6 +1333,10 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages.
+#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1361,7 +1387,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*zero-page-detection': 'ZeroPageDetection'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


