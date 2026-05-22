Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE811CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOdT-0001l6-60; Fri, 22 May 2026 08:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdP-0001ji-R3
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdL-0000MR-QA
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1FE6F80739;
 Fri, 22 May 2026 15:05:41 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Z5T7aO0g14Y0-2LOypXuC; Fri, 22 May 2026 15:05:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779451540;
 bh=KTp/pPAQgqp/zvkDHuiMwunwW4/ajjuB2DC44LrntNM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=J9g3uszMUuZJxec7u1EmHEgPfiybJSuOLubwv+cOCcYzLWvEeRSs8CabZLxIFMvfa
 rPenhCLIbQ2FGXRrf5QcZHStGRVDoQU7zl++JUGlqcP+IDEIPVi5fgz/m2P4B5GPdk
 LhY36w+irPgRWWcXK2K7TZyOrSm4lsYPH4lNaClU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, Eric Blake <eblake@redhat.com>
Subject: [PATCH v16 3/8] qapi: add local migration parameter
Date: Fri, 22 May 2026 15:05:28 +0300
Message-ID: <20260522120534.77653-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522120534.77653-1-vsementsov@yandex-team.ru>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We are going to implement local-migration feature: some devices will be
able to transfer open file descriptors through migration stream (which
must UNIX domain socket for that purpose).  This allows to transfer the
whole backend state without reconnecting and restarting the backend
service. For example, virtio-net will migrate its attached TAP netdev,
together with its connected file descriptors.

In this commit we introduce a migration parameter, which enables
the feature for devices that support it (none at the moment).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 include/migration/misc.h |  2 ++
 migration/options.c      | 18 +++++++++++++++++-
 qapi/migration.json      | 12 ++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c3..b14dc70ea3d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -156,4 +156,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
+bool migrate_local(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099b..ba5f9440a08 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -25,6 +26,7 @@
 #include "migration/colo.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "qemu-file.h"
@@ -348,6 +350,12 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.local;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1076,7 +1084,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1424,6 +1432,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         qapi_free_strList(dest->cpr_exec_command);
         dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        dest->local = params->local;
+    }
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1556,6 +1568,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        s->parameters.local = params->local;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 27a79705569..bc331815da0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -836,7 +836,8 @@
            'zero-page-detection',
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'local'] }
 
 ##
 # @migrate-set-parameters:
@@ -1018,6 +1019,12 @@
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
 #
+# @local: Enable local migration for devices that support it.  Backend
+#     state and its file descriptors can then be passed to the
+#     destination in the migration channel.  The migration channel
+#     must be a Unix domain socket.  Usually needs to be enabled per
+#     device.  (Since 11.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
@@ -1059,7 +1066,8 @@
             '*direct-io': 'bool',
             '*x-rdma-chunk-size': { 'type': 'uint64',
                                     'features': [ 'unstable' ] },
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*local': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.52.0


