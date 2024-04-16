Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C5CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk4Q-0007rK-G0; Tue, 16 Apr 2024 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3T-0006CO-Fa
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:22 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3R-0002RA-2X
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:03 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3J-0002iN-2a; Tue, 16 Apr 2024 16:44:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 19/26] migration: Add x-multifd-channels-device-state
 parameter
Date: Tue, 16 Apr 2024 16:42:58 +0200
Message-ID: <4b4c859f9fc937bc19010814f81ead98a9b17c3e.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This parameter allows specifying how many multifd channels are dedicated
to sending device state in parallel.

It is ignored on the receive side.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/migration-hmp-cmds.c |  7 +++++
 migration/options.c            | 51 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 16 ++++++++++-
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffdae..37d71422fdc3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -341,6 +341,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNELS_DEVICE_STATE),
+            params->x_multifd_channels_device_state);
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
             MultiFDCompression_str(params->multifd_compression));
@@ -626,6 +629,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
         break;
+    case MIGRATION_PARAMETER_X_MULTIFD_CHANNELS_DEVICE_STATE:
+        p->has_x_multifd_channels_device_state = true;
+        visit_type_uint8(v, param, &p->x_multifd_channels_device_state, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_COMPRESSION:
         p->has_multifd_compression = true;
         visit_type_MultiFDCompression(v, param, &p->multifd_compression,
diff --git a/migration/options.c b/migration/options.c
index 949d8a6c0b62..a7f09570b04e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -59,6 +59,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_CHANNELS_DEVICE_STATE 0
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
@@ -138,6 +139,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_UINT8("x-multifd-channels-device-state", MigrationState,
+                      parameters.x_multifd_channels_device_state,
+                      DEFAULT_MIGRATE_MULTIFD_CHANNELS_DEVICE_STATE),
     DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
                       parameters.multifd_compression,
                       DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
@@ -885,6 +889,13 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
 
+int migrate_multifd_channels_device_state(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.x_multifd_channels_device_state;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1032,6 +1043,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->block_incremental = s->parameters.block_incremental;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
+    params->has_x_multifd_channels_device_state = true;
+    params->x_multifd_channels_device_state = s->parameters.x_multifd_channels_device_state;
     params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
     params->has_multifd_zlib_level = true;
@@ -1091,6 +1104,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
     params->has_multifd_channels = true;
+    params->has_x_multifd_channels_device_state = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
     params->has_multifd_zstd_level = true;
@@ -1198,6 +1212,37 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_multifd_channels &&
+        params->has_x_multifd_channels_device_state &&
+        params->x_multifd_channels_device_state > 0 &&
+        !migrate_channel_header()) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "x_multifd_channels_device_state",
+                   "0 without channel header");
+        return false;
+    }
+
+    if (params->has_multifd_channels &&
+        params->has_x_multifd_channels_device_state &&
+        params->x_multifd_channels_device_state > 0 &&
+        params->has_multifd_compression &&
+        params->multifd_compression != MULTIFD_COMPRESSION_NONE) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "x_multifd_channels_device_state",
+                   "0 with compression");
+        return false;
+    }
+
+    /* At least one multifd channel is needed for RAM data */
+    if (params->has_multifd_channels &&
+        params->has_x_multifd_channels_device_state &&
+        params->x_multifd_channels_device_state >= params->multifd_channels) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "x_multifd_channels_device_state",
+                   "a value less than multifd_channels");
+        return false;
+    }
+
     if (params->has_multifd_zlib_level &&
         (params->multifd_zlib_level > 9)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
@@ -1381,6 +1426,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
+    if (params->has_x_multifd_channels_device_state) {
+        dest->x_multifd_channels_device_state = params->x_multifd_channels_device_state;
+    }
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
@@ -1526,6 +1574,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
+    if (params->has_x_multifd_channels_device_state) {
+        s->parameters.x_multifd_channels_device_state = params->x_multifd_channels_device_state;
+    }
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
diff --git a/migration/options.h b/migration/options.h
index 1144d72ec0db..453999b0d28e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -83,6 +83,7 @@ uint64_t migrate_max_bandwidth(void);
 uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
+int migrate_multifd_channels_device_state(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
 int migrate_multifd_zstd_level(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b9032886..0578375cfcfd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -858,6 +858,10 @@
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
 #
+# @x-multifd-channels-device-state: Number of multifd channels dedicated
+#     to sending device state in parallel (ignored on the receive side).
+#     The default value is 0 (since TBD)
+#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #     needs to be a multiple of the target page size and a power of 2
 #     (Since 2.11)
@@ -940,7 +944,7 @@
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
-           'multifd-channels',
+           'multifd-channels', 'x-multifd-channels-device-state',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
@@ -1066,6 +1070,10 @@
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
 #
+# @x-multifd-channels-device-state: Number of multifd channels dedicated
+#     to sending device state in parallel (ignored on the receive side).
+#     The default value is 0 (since TBD)
+#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #     needs to be a multiple of the target page size and a power of 2
 #     (Since 2.11)
@@ -1165,6 +1173,7 @@
             '*block-incremental': { 'type': 'bool',
                                     'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
+            '*x-multifd-channels-device-state': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
@@ -1298,6 +1307,10 @@
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
 #
+# @x-multifd-channels-device-state: Number of multifd channels dedicated
+#     to sending device state in parallel (ignored on the receive side).
+#     The default value is 0 (since TBD)
+#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #     needs to be a multiple of the target page size and a power of 2
 #     (Since 2.11)
@@ -1394,6 +1407,7 @@
             '*block-incremental': { 'type': 'bool',
                                     'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
+            '*x-multifd-channels-device-state': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',

