Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DABCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6p-0008K7-VU; Fri, 10 Oct 2025 13:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6k-0008It-8j
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:48 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6J-0007Ut-QP
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6A8F0C0179;
 Fri, 10 Oct 2025 20:40:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-7AA8UpLt; Fri, 10 Oct 2025 20:40:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118015;
 bh=4QZahEI9jXh4SY0arLFmkWwqBvNmEl03FiavUfOzMw4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=P79CGupdtdmTnEvoM7CQzh6iNbipS2j1A1KGRVPfX97PQf/OvuR+Llf7wFLDfaw1L
 LZkXx171rLL36NuijXBEN7z16HBQaRkkgqNUcixXJLfVzuP5fgLmtlJkRIV5QrhLWb
 wW5+bNFaxsFwxbwcqmdtViTVMpCVhqashE6p+mJQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
Date: Fri, 10 Oct 2025 20:39:54 +0300
Message-ID: <20251010173957.166759-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

   backend-transfer = ["virtio-net-tap"]

Why not simple boolean? To simplify migration to further versions,
when more devices will support backend-transfer migration.

Alternatively, we may add per-device option to disable backend-transfer
migration, but still:

1. It's more comfortable to set same capabilities/parameters on both
source and target QEMU, than care about each device.

2. To not break the design, that machine-type + device options +
migration capabilities and parameters are fully define the resulting
migration stream. We'll break this if add in future more
backend-transfer support in devices under same backend-transfer=true
parameter.

The commit only brings the interface, the realization will come in later
commit. That's why we add a temporary not-implemented error in
migrate_params_check().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/options.c | 39 +++++++++++++++++++++++++++++++++++++++
 migration/options.h |  2 ++
 qapi/migration.json | 42 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5183112775..76709af3ab 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -262,6 +263,20 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_virtio_net_tap(void)
+{
+    MigrationState *s = migrate_get_current();
+    BackendTransferList *el = s->parameters.backend_transfer;
+
+    for ( ; el; el = el->next) {
+        if (el->value == BACKEND_TRANSFER_VIRTIO_NET_TAP) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -963,6 +978,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
 
+    if (s->parameters.backend_transfer) {
+        params->has_backend_transfer = true;
+        params->backend_transfer = QAPI_CLONE(BackendTransferList,
+                                              s->parameters.backend_transfer);
+    }
+
     return params;
 }
 
@@ -997,6 +1018,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
     params->has_cpr_exec_command = true;
+    params->has_backend_transfer = true;
 }
 
 /*
@@ -1183,6 +1205,12 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    /* TODO: implement backend-transfer and remove this check */
+    if (params->has_backend_transfer) {
+        error_setg(errp, "Not implemented");
+        return false;
+    }
+
     return true;
 }
 
@@ -1305,6 +1333,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
+
+    if (params->has_backend_transfer) {
+        dest->backend_transfer = params->backend_transfer;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1443,6 +1475,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_backend_transfer) {
+        qapi_free_BackendTransferList(s->parameters.backend_transfer);
+
+        s->parameters.backend_transfer = QAPI_CLONE(BackendTransferList,
+                                                    params->backend_transfer);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..55c0345433 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
+bool migrate_virtio_net_tap(void);
+
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..1bfe7df191 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -770,6 +770,19 @@
       '*transform': 'BitmapMigrationBitmapAliasTransform'
   } }
 
+##
+# @BackendTransfer:
+#
+# @virtio-net-tap: Enable backend-transfer migration for
+#     virtio-net/tap. When enabled, TAP fds and all related state are
+#     passed to the destination in the migration channel (which must
+#     be a UNIX domain socket).
+#
+# Since: 10.2
+##
+{ 'enum': 'BackendTransfer',
+  'data': [ 'virtio-net-tap' ] }
+
 ##
 # @BitmapMigrationNodeAlias:
 #
@@ -951,9 +964,13 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of targets for backend-transfer migration.
+#     See description in `BackendTransfer`.  Default is no
+#     backend-transfer migration (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -978,7 +995,8 @@
            'mode',
            'zero-page-detection',
            'direct-io',
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
 
 ##
 # @MigrateSetParameters:
@@ -1137,9 +1155,13 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of targets for backend-transfer migration.
+#     See description in `BackendTransfer`.  Default is no
+#     backend-transfer migration (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # TODO: either fuse back into `MigrationParameters`, or make
@@ -1179,7 +1201,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @migrate-set-parameters:
@@ -1352,9 +1376,13 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: List of targets for backend-transfer migration.
+#     See description in `BackendTransfer`.  Default is no
+#     backend-transfer migration (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1391,7 +1419,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
-- 
2.48.1


