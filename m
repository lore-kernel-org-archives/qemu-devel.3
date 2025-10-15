Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED49BCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91T1-0005dz-Dy; Wed, 15 Oct 2025 09:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SV-0005TA-MR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S9-00034l-4r
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:27 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8166588ACF;
 Wed, 15 Oct 2025 16:21:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-95StWcB1; Wed, 15 Oct 2025 16:21:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534513;
 bh=MqiBmROUNBmcgWznWmpS2J0vN0EQYgRHjh9r7Qc714k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fX7heLf4GCGYP8i3Cov6V7R1LuO7yyjyND2b1DBJg1pL/Yxh3qElFmPlhIozhV8NL
 NRo8ON2xDFXSBbq6+uiUJ37GI27O3pMXi6O1eCdQiBY+nVFhNslsPnfRdvUwc8QGt0
 amhNDkijw+XlsGWFuFaWaoYfd1h8pPLMd4kp57dU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
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
Subject: [PATCH v8 16/19] qapi: introduce backend-transfer migration parameter
Date: Wed, 15 Oct 2025 16:21:32 +0300
Message-ID: <20251015132136.1083972-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This parameter enables backend-transfer feature: all devices
which support it will migrate their backends (for example a TAP
device, by passing open file descriptor to migration channel).

Currently no such devices, so the new parameter is a noop.

Next commit will add support for virtio-net, to migrate its
TAP backend.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/options.c | 18 ++++++++++++++++++
 migration/options.h |  2 ++
 qapi/migration.json | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5183112775..a461b07b54 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -262,6 +262,12 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_backend_transfer(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.backend_transfer;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -963,6 +969,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
 
+    params->has_backend_transfer = true;
+    params->backend_transfer = s->parameters.backend_transfer;
+
     return params;
 }
 
@@ -997,6 +1006,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
     params->has_cpr_exec_command = true;
+    params->has_backend_transfer = true;
 }
 
 /*
@@ -1305,6 +1315,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
+
+    if (params->has_backend_transfer) {
+        dest->backend_transfer = params->backend_transfer;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1443,6 +1457,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_backend_transfer) {
+        s->parameters.backend_transfer = params->backend_transfer;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..755ba1c024 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
+bool migrate_backend_transfer(void);
+
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..35601a1f87 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -951,9 +951,16 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: Enable backend-transfer feature for devices that
+#     supports it. In general that means that backend state and its
+#     file descriptors are passed to the destination in the migraton
+#     channel (which must be a UNIX socket). Individual devices
+#     declare the support for backend-transfer by per-device
+#     backend-transfer option. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -978,7 +985,8 @@
            'mode',
            'zero-page-detection',
            'direct-io',
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
 
 ##
 # @MigrateSetParameters:
@@ -1137,9 +1145,16 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: Enable backend-transfer feature for devices that
+#     supports it. In general that means that backend state and its
+#     file descriptors are passed to the destination in the migraton
+#     channel (which must be a UNIX socket). Individual devices
+#     declare the support for backend-transfer by per-device
+#     backend-transfer option. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # TODO: either fuse back into `MigrationParameters`, or make
@@ -1179,7 +1194,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': 'bool',
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @migrate-set-parameters:
@@ -1352,9 +1369,16 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: Enable backend-transfer feature for devices that
+#     supports it. In general that means that backend state and its
+#     file descriptors are passed to the destination in the migraton
+#     channel (which must be a UNIX socket). Individual devices
+#     declare the support for backend-transfer by per-device
+#     backend-transfer option. (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @backend-transfer, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1391,7 +1415,9 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': { 'type': 'bool',
+                                   'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
-- 
2.48.1


