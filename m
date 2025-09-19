Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF4CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXr2-0006Dl-BC; Fri, 19 Sep 2025 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqi-0005yU-1P
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:16 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqY-0004bS-Ad
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 33C4680616;
 Fri, 19 Sep 2025 12:56:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-5r6DavdU; Fri, 19 Sep 2025 12:56:02 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275762;
 bh=/RIOMdA4Vd4J0yxL7/kgfD4a4heO241Vzlzk0psOhtM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=U37ZjEdO2OM14Hn1HC5FH/aNtuhRvMXr2FgLy1LyRr9os+Dc7b5E/wuomg4LY4CJD
 ynUK6AqoOE9Gw/sFAdSTJcoePM4u+70JWUGFQDfhWD1kMp2xorwL9AfDzfyoMHiL53
 qdw9pppe+WuZxsExPQcLGEKb8Ok7KVPm6mteMa9A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 16/19] qapi: add interface for local TAP migration
Date: Fri, 19 Sep 2025 12:55:42 +0300
Message-ID: <20250919095545.1912042-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To migrate virtio-net TAP device backend (including open fds) locally,
user should simply set migration parameter

   fds = [virtio-net]

Why not simple boolean? To simplify migration to further versions,
when more devices will support fds migration.

Alternatively, we may add per-device option to disable fds-migration,
but still:

1. It's more comfortable to set same capabilities/parameters on both
source and target QEMU, than care about each device.

2. To not break the design, that machine-type + device options +
migration capabilites and parameters are fully define the resulting
migration stream. We'll break this if add in future more fds-passing
support in devices under same fds=true parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qapi/util.h | 17 +++++++++++++++++
 migration/options.c | 30 +++++++++++++++++++++++++++++
 migration/options.h |  2 ++
 qapi/migration.json | 46 ++++++++++++++++++++++++++++++++++++---------
 4 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 29bc4eb865..b953402416 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -69,4 +69,21 @@ int parse_qapi_name(const char *name, bool complete);
         _len;                                                       \
     })
 
+/*
+ * For any GenericList @list, return true if it contains specified
+ * element.
+ */
+#define QAPI_LIST_CONTAINS(list, el)                                \
+    ({                                                              \
+        bool _found = false;                                        \
+        typeof_strip_qual(list) _tail;                              \
+        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
+            if (_tail->value == el) {                               \
+                _found = true;                                      \
+                break;                                              \
+            }                                                       \
+        }                                                           \
+        _found;                                                     \
+    })
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..061a1b8eaf 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -262,6 +263,13 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_fds_virtio_net(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return QAPI_LIST_CONTAINS(s->parameters.fds, FDS_TARGET_VIRTIO_NET);
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -960,6 +968,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
 
+    if (s->parameters.has_fds) {
+        params->has_fds = true;
+        params->fds = QAPI_CLONE(FdsTargetList, s->parameters.fds);
+    }
+
     return params;
 }
 
@@ -1179,6 +1192,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_fds) {
+        error_setg(errp, "Not implemented");
+        return false;
+    }
+
     return true;
 }
 
@@ -1297,6 +1315,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_fds) {
+        dest->has_fds = true;
+        dest->fds = params->fds;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1429,6 +1452,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+
+    if (params->has_fds) {
+        qapi_free_FdsTargetList(s->parameters.fds);
+
+        s->parameters.has_fds = true;
+        s->parameters.fds = QAPI_CLONE(FdsTargetList, params->fds);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..a79472a235 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
+bool migrate_fds_virtio_net(void);
+
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..6ef9629c6d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -747,6 +747,19 @@
       '*transform': 'BitmapMigrationBitmapAliasTransform'
   } }
 
+##
+# @FdsTarget:
+#
+# @virtio-net: Enable live backend migration for virtio-net.
+#     The only supported backend is TAP device. When enabled, TAP fds
+#     and all related state is passed to target QEMU through migration
+#     channel (which should be unix socket).
+#
+# Since: 10.2
+##
+{ 'enum': 'FdsTarget',
+  'data': [ 'virtio-net' ] }
+
 ##
 # @BitmapMigrationNodeAlias:
 #
@@ -924,10 +937,14 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @fds: List of targets to enable live-backend migration for. This
+#     requires migration channel to be a unix socket (to pass fds
+#     through). (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @x-checkpoint-delay,
+#     @x-vcpu-dirty-limit-period and @fds are experimental.
 #
 # Since: 2.4
 ##
@@ -950,7 +967,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'fds' ] }
 
 ##
 # @MigrateSetParameters:
@@ -1105,10 +1123,14 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @fds: List of targets to enable live-backend migration for. This
+#     requires migration channel to be a unix socket (to pass fds
+#     through). (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @x-checkpoint-delay,
+#     @x-vcpu-dirty-limit-period and @fds are experimental.
 #
 # TODO: either fuse back into `MigrationParameters`, or make
 #     `MigrationParameters` members mandatory
@@ -1146,7 +1168,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*fds': { 'type': [ 'FdsTarget' ], 'features': [ 'unstable' ] } } }
 
 ##
 # @migrate-set-parameters:
@@ -1315,10 +1338,14 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @fds: List of targets to enable live-backend migration for. This
+#     requires migration channel to be a unix socket (to pass fds
+#     through). (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @x-checkpoint-delay,
+#     @x-vcpu-dirty-limit-period and @fds are experimental.
 #
 # Since: 2.4
 ##
@@ -1353,7 +1380,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*fds': { 'type': [ 'FdsTarget' ], 'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
-- 
2.48.1


