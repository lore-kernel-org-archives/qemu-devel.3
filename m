Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F76C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgeX-0003N0-8z; Wed, 24 Apr 2024 13:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeV-0003MR-HN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:27 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeP-0004id-6P
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 86AF760B63;
 Wed, 24 Apr 2024 20:43:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8811::1:29])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kgPOp63Iaa60-dokvgVqv; Wed, 24 Apr 2024 20:43:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713980596;
 bh=n4liKD3hcfOzSFLz8RaC/xan5xgjn1y66b2B/eUtxCM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=l/DVRmmNTOnHqmPIhlYJDjKIhnw1VWvNL0e0U1MYrWuiI2lxW2THC7KoWOktZNvAm
 5DTbajsz4szoIVSteFlZJPgeQf96RivZ5yOZ1s7nHXCnxWLdDq9Vqn6usrNSfgarDQ
 YanLUl7ygp2AA0BQ+tsk34LtjN4IJCYR+ICjO42A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 2/2] qapi: introduce exit-on-error paramter for
 migrate-incoming
Date: Wed, 24 Apr 2024 20:42:45 +0300
Message-Id: <20240424174245.1237942-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Now we do set MIGRATION_FAILED state, but don't give a chance to
orchestrator to query migration state and get the error.

Let's provide a possibility for QMP-based orchestrators to get an error
like with outgoing migration.

For x-exit-preconfig we can enable new behavior unconditionally, as
it's an unstable command.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 31 +++++++++++++++++++++----------
 migration/migration.h          |  3 +++
 qapi/migration.json            |  7 ++++++-
 system/vl.c                    |  7 +------
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffd..9c94a18029 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -466,7 +466,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, &err);
+    qmp_migrate_incoming(NULL, true, caps, true, true, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
diff --git a/migration/migration.c b/migration/migration.c
index 806b7b080b..fe72529ba7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -234,6 +234,8 @@ void migration_object_init(void)
     qemu_cond_init(&current_incoming->page_request_cond);
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
+    current_incoming->exit_on_error = true;
+
     migration_object_check(current_migration, &error_fatal);
 
     blk_mig_init();
@@ -597,12 +599,15 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
 
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
+                                          bool exit_on_error,
                                           Error **errp)
 {
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    mis->exit_on_error = exit_on_error;
+
     /*
      * Having preliminary checks for uri and channel
      */
@@ -738,11 +743,12 @@ process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
 
     if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
+        error_setg(&local_err, "Failed to setup decompress threads");
         goto fail;
     }
 
@@ -779,25 +785,26 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_report("load of migration failed: %s", strerror(-ret));
+        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
         goto fail;
     }
 
     if (colo_incoming_co() < 0) {
+        error_setg(&local_err, "colo incoming failed");
         goto fail;
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
     return;
 fail:
+    migrate_report_err(local_err);
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    qemu_fclose(mis->from_src_file);
-
-    multifd_recv_cleanup();
-    compress_threads_load_cleanup();
+    migration_incoming_state_destroy();
 
-    exit(EXIT_FAILURE);
+    if (mis->exit_on_error) {
+        exit(EXIT_FAILURE);
+    }
 }
 
 /**
@@ -1785,7 +1792,9 @@ void migrate_del_blocker(Error **reasonp)
 }
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
-                          MigrationChannelList *channels, Error **errp)
+                          MigrationChannelList *channels,
+                          bool has_exit_on_error, bool exit_on_error,
+                          Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1803,7 +1812,9 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
-    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels,
+                                  has_exit_on_error ? exit_on_error : true,
+                                  &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1839,7 +1850,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, false, NULL, errp);
+    qemu_start_incoming_migration(uri, false, NULL, mis->exit_on_error, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
diff --git a/migration/migration.h b/migration/migration.h
index f9f436c33e..089f710ee1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -227,6 +227,9 @@ struct MigrationIncomingState {
      * is needed as this field is updated serially.
      */
     unsigned int switchover_ack_pending_num;
+
+    /* Do exit on incoming migration failure */
+    bool exit_on_error;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..9de8b98d0b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1837,6 +1837,10 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
+# @exit-on-error: Do exit on incoming migration failure.  Default true.
+#     When set to false, the error is reported by MIGRATION event and
+#     error could be retrieved by query-migrate command.  (since 9.1)
+#
 # Since: 2.3
 #
 # Notes:
@@ -1889,7 +1893,8 @@
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
-                      '*channels': [ 'MigrationChannel' ] } }
+                      '*channels': [ 'MigrationChannel' ],
+                      '*exit-on-error': 'bool' } }
 
 ##
 # @xen-save-devices-state:
diff --git a/system/vl.c b/system/vl.c
index c644222982..f5b4c18200 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2718,13 +2718,8 @@ void qmp_x_exit_preconfig(Error **errp)
     }
 
     if (incoming) {
-        Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, false, NULL, &local_err);
-            if (local_err) {
-                error_reportf_err(local_err, "-incoming %s: ", incoming);
-                exit(1);
-            }
+            qmp_migrate_incoming(incoming, false, NULL, true, true, errp);
         }
     } else if (autostart) {
         qmp_cont(NULL);
-- 
2.34.1


