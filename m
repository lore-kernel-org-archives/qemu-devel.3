Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BD5C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzolD-0000a5-K9; Wed, 24 Apr 2024 22:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzolB-0000ZF-A8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:53 -0400
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol8-0005Vs-VY
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/RsfKs4JwATvFtMGxilZWLtkW2M6AtYnhYyV482uxM=;
 b=CRkVyU0b/z5LlKmh/GFAvpbK0jyX+FER3HbF606lVUATIMws6I5GUqj1PCg64LwDGAfH3s
 6tYEFoqetYMyzvp0JT/ltXD1Ae6CwOSqsQgp3BWVt6s0/nC5G1pfUB1vJJWyKo2W7F5Wpu
 VuAvBDFrLVHx/+zoPf41udxRvVjtW1E=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 11/14] migration/multifd: Add migration option set packet
 size.
Date: Thu, 25 Apr 2024 02:21:14 +0000
Message-Id: <20240425022117.4035031-12-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ae;
 envelope-from=hao.xiang@linux.dev; helo=out-174.mta1.migadu.com
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

The current multifd packet size is 128 * 4kb. This change adds
an option to set the packet size. Both sender and receiver needs
to set the same packet size for things to work.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 migration/options.c | 36 ++++++++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 21 ++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index dc8642df81..a9deb079eb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -79,6 +79,12 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1023 * 4 * 1024)
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -184,6 +190,9 @@ Property migration_properties[] = {
                        ZERO_PAGE_DETECTION_MULTIFD),
     DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
                        parameters.multifd_dsa_accel),
+    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
+                     parameters.multifd_packet_size,
+                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -879,6 +888,13 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
 
+uint64_t migrate_multifd_packet_size(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_packet_size;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1031,6 +1047,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -1094,6 +1112,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1195,6 +1214,17 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "a value between 524288 and 4190208, "
+                    "must be a multiple of guest VM's page size.");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1374,6 +1404,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1524,6 +1557,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
                     " use blockdev-mirror with NBD instead");
         s->parameters.block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        s->parameters.multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index 1cb3393be9..23995e6608 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,6 +92,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 const char *migrate_multifd_dsa_accel(void);
+uint64_t migrate_multifd_packet_size(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 934fa8839e..39d609c394 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -920,6 +920,10 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -954,7 +958,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1134,6 +1139,10 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1189,7 +1198,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*multifd-dsa-accel': 'StrOrNull'} }
+            '*multifd-dsa-accel': 'StrOrNull',
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1373,6 +1383,10 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1425,7 +1439,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*multifd-dsa-accel': 'str'} }
+            '*multifd-dsa-accel': 'str',
+            '*multifd-packet-size': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


