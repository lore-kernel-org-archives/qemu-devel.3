Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3261BC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0MM-0003kx-2z; Wed, 29 Jul 2026 05:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MK-0003kb-Jf
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:52 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MI-0004wq-Qo
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 89981C0A85;
 Wed, 29 Jul 2026 12:13:49 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bDa8GXKW9mI0-YOhrtORp; Wed, 29 Jul 2026 12:13:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785316428;
 bh=S8Vp8LJifdN8Jxab7p9d0uomfrkWpnzEOimzEfJAt10=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qwuoPnb2UGk5sSmBnNIMciU7576qiQL7up+iQFhzU+cQHHkQTxX6VKG/ttjyQNdCs
 J+8SFBNbbVtPSDyXRcm1NOkpEpPL6U2n+mcLUBLniPXdAo7S8YnPSCAvWe9jxH+hZy
 8F+97z2TayFYgDMOAVQT6VYTs8+0XNdc9FXhaars=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v20 09/15] qapi: add local migration parameter
Date: Wed, 29 Jul 2026 12:12:47 +0300
Message-ID: <20260729091334.1863155-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We can't simply auto-detect local migration by checking whether the
migration channel is a UNIX domain socket: the UNIX socket may be only
the first part of the transfer channel to a remote target.  Hence an
explicit parameter is needed. More over, "local" migration parameter
may be useful in cpr-exec mode, when FDs are passed through exec
instead of UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/misc.h |  2 ++
 migration/options.c      | 18 +++++++++++++++++-
 qapi/migration.json      | 22 ++++++++++++++++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 2b2fbb59a40..019717f4cda 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -161,4 +161,6 @@ bool multifd_join_device_state_save_threads(void);
 
 void migration_request_switchover_ack_legacy(const char *requester);
 
+bool migrate_local(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index dfce19405d4..5c439f6d724 100644
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
@@ -350,6 +352,12 @@ bool migrate_mapped_ram(void)
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
@@ -1085,7 +1093,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1433,6 +1441,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         qapi_free_strList(dest->cpr_exec_command);
         dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        dest->local = params->local;
+    }
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1565,6 +1577,10 @@ static void migrate_params_apply(MigrationParameters *params)
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
index b1eaf7b0545..bb744f134ce 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -830,7 +830,8 @@
            'zero-page-detection',
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'local'] }
 
 ##
 # @migrate-set-parameters:
@@ -1012,10 +1013,21 @@
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
 #
+# @local: Permit the use of optimizations for local migration.
+#     This must only be set when either both the source and
+#     destination QEMU processes are directly connected with a UNIX
+#     domain socket as the migration channel (to enable use of file
+#     descriptor passing) or cpr-exec migration mode is enabled
+#     (this way file descriptors are inherited by new process).
+#     Individual device backends may need additional configuration
+#     flags set  to enable local migration optimizations.
+#     This will be documented against the device
+#     backends where it applies.  (Since 11.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
+#     and @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
@@ -1053,7 +1065,9 @@
             '*direct-io': 'bool',
             '*x-rdma-chunk-size': { 'type': 'uint64',
                                     'features': [ 'unstable' ] },
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*local': { 'type': 'bool',
+                        'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
-- 
2.43.0


