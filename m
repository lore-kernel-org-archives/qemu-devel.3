Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DBECCF9FE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJI-0000fz-Ij; Thu, 30 Oct 2025 16:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJ9-0000f0-Lv
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:44 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIv-0005vP-GT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BE05180A76;
 Thu, 30 Oct 2025 23:31:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-IwcerLAU; Thu, 30 Oct 2025 23:31:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856282;
 bh=Qznovkf0Y+7NhB3GQmNH7kj9tnURcGnlg9ou7FjQK0s=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uYuMjD8hiUzHNHgixl08d1N6WnyyCUf8uwzJQptJNVqgF4h1v0ka864AhBTa/+Iwj
 LVxJcrXBOKljrPEmNbl/FospG3p1YamxZYitnrV+Lh76CpdGofUgVHV1B7U2jo3bkH
 jskN7bcx+Y7yDXS6ikv/zxMjX5qcgMQ9PEhJpGPA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 3/8] qapi: add backend-transfer migration parameter
Date: Thu, 30 Oct 2025 23:31:10 +0300
Message-ID: <20251030203116.870742-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We are going to implement backend-transfer feature: some devices
will be able to transfer their backend through migration stream
for local migration through UNIX domain socket. For example,
virtio-net will migrate its attached TAP netdev, with all its
connected file descriptors.

In this commit we introduce a migration parameter, which pick
devices for backend-transfer migration in context of next
outgoing or incoming migration. Of course, user is responsible
to pick same set of devices on source and target.

QMP command query-backend-transfer-support command may help
to prepare such set as intersection of
query-backend-transfer-support results on source and target.

With this commit, no device yet support backend-transfer,
so passing something other then empty list to backend-transfer
migration parameter will fail.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/hw/qdev-core.h   |  3 +++
 include/migration/misc.h |  2 ++
 migration/options.c      | 31 +++++++++++++++++++++++++++++++
 qapi/migration.json      | 35 +++++++++++++++++++++++++++++------
 system/qdev-monitor.c    | 31 +++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0551fbaa6c..9ed0b3f04d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1168,4 +1168,7 @@ typedef enum MachineInitPhase {
 bool phase_check(MachineInitPhase phase);
 void phase_advance(MachineInitPhase phase);
 
+bool migrate_backend_transfer(DeviceState *dev);
+bool migrate_backend_transfer_check_list(const strList *list, Error **errp);
+
 #endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 592b93021e..7f931bed17 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -152,4 +152,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
+const strList *migrate_backend_transfer_list(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index 5183112775..1644728ed7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -24,6 +25,7 @@
 #include "migration/colo.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "qemu-file.h"
@@ -262,6 +264,12 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+const strList *migrate_backend_transfer_list(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.backend_transfer;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -963,6 +971,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
 
+    if (s->parameters.backend_transfer) {
+        params->has_backend_transfer = true;
+        params->backend_transfer = QAPI_CLONE(strList,
+                                              s->parameters.backend_transfer);
+    }
+
     return params;
 }
 
@@ -997,6 +1011,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
     params->has_cpr_exec_command = true;
+    params->has_backend_transfer = true;
 }
 
 /*
@@ -1183,6 +1198,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_backend_transfer &&
+        !migrate_backend_transfer_check_list(params->backend_transfer, errp)) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1305,6 +1325,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
+
+    if (params->has_backend_transfer) {
+        dest->backend_transfer = params->backend_transfer;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1443,6 +1467,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_backend_transfer) {
+        qapi_free_strList(s->parameters.backend_transfer);
+
+        s->parameters.backend_transfer = QAPI_CLONE(strList,
+                                                    params->backend_transfer);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..9478c4ddab 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -951,9 +951,15 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -978,7 +984,8 @@
            'mode',
            'zero-page-detection',
            'direct-io',
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
 
 ##
 # @MigrateSetParameters:
@@ -1137,9 +1144,15 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # TODO: either fuse back into `MigrationParameters`, or make
@@ -1179,7 +1192,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': [ 'str' ],
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @migrate-set-parameters:
@@ -1352,9 +1367,15 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1391,7 +1412,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': [ 'str' ],
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 9d3d961c15..549c77b2f0 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -939,6 +939,19 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+bool migrate_backend_transfer(DeviceState *dev)
+{
+    const strList *el = migrate_backend_transfer_list();
+
+    for ( ; el; el = el->next) {
+        if (find_device_state(el->value, false, NULL) == dev) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
@@ -952,6 +965,24 @@ static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
     return dc->backend_transfer_support(dev, errp);
 }
 
+bool migrate_backend_transfer_check_list(const strList *list, Error **errp)
+{
+    const strList *el = list;
+
+    for ( ; el; el = el->next) {
+        DeviceState *dev = find_device_state(el->value, true, errp);
+        if (!dev) {
+            return false;
+        }
+
+        if (!qdev_backend_transfer_support(dev, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static int qdev_add_if_backend_transfer_supported(Object *obj, void *opaque)
 {
     DevPathList **list = opaque;
-- 
2.48.1


