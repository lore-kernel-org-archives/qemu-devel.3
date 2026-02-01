Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C585E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmaBN-00019y-Hx; Sun, 01 Feb 2026 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBL-00019Q-Er
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:15 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBI-0005YB-Hd
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:15 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C468D807CC;
 Sun, 01 Feb 2026 19:20:10 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:765::1:3b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4Kp2C46Aq8c0-MSCfCKtD; Sun, 01 Feb 2026 19:20:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769962810;
 bh=AIepM3J8V/vaTzwRFdY0iEBThQ1LNyZOI1AMBNNUhgc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VfIMG6ILbdqIu9i6xu6aisGwmFuWk19tx6DY4N+HmiaRMjdHBRWLgLq6OtYTgGD4I
 uGLxlQ9SqTqPYeTWATO3MYS2EMMluwUCbafMh8xy29+K53wbEmZQlKctIbKqMRAIAb
 pFyzYosjVLwsYaxW+aCSSdpipYMAFY3w091Nj5xU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, thuth@redhat.com,
 armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
Date: Sun,  1 Feb 2026 19:19:55 +0300
Message-ID: <20260201162001.296328-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201162001.296328-1-vsementsov@yandex-team.ru>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to implement backend-transfer feature: some devices
will be able to transfer their backend through migration stream
for local migration through UNIX domain socket. For example,
virtio-net will migrate its attached TAP netdev, with all its
connected file descriptors.

In this commit we introduce a migration parameter, which enables
the feature, for supporting devices (no one at the moment).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/misc.h |  2 ++
 migration/options.c      | 18 +++++++++++++++++-
 qapi/migration.json      | 13 +++++++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e26d418a6e..f23a4d8b59 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -152,4 +152,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
+bool migrate_backend_transfer(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index 1ffe85a2d8..a4c9e68457 100644
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
@@ -336,6 +338,12 @@ bool migrate_mapped_ram(void)
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
@@ -1047,7 +1055,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_cpr_exec_command, &p->has_backend_transfer,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1386,6 +1394,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
+
+    if (params->has_backend_transfer) {
+        dest->backend_transfer = params->backend_transfer;
+    }
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1514,6 +1526,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_backend_transfer) {
+        s->parameters.backend_transfer = params->backend_transfer;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index f925e5541b..cbe88f0c91 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -828,7 +828,8 @@
            'mode',
            'zero-page-detection',
            'direct-io',
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'backend-transfer'] }
 
 ##
 # @migrate-set-parameters:
@@ -1004,6 +1005,13 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @backend-transfer: Enable backend-transfer feature for devices that
+#     supports it.  In general that means that backend state and its
+#     file descriptors are passed to the destination in the migraton
+#     channel (which must be a UNIX socket).  Individual devices
+#     declare the support for backend-transfer by per-device
+#     backend-transfer option.  (Since 11.0)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1043,7 +1051,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*backend-transfer': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.52.0


