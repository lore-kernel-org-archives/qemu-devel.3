Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C798EC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJx-0002Qc-DM; Wed, 28 Feb 2024 00:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJK-0001Og-0W
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJ5-0007Hu-Er
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LlFwz6O3mZ2LTaLrgZ+vg13FsQPgmVBoBxanF/BPCd4=;
 b=Bm9XiLx8L0JGpZASBUj3rhdY+3cmkqo0HECNHW38IxzzaNn1BoLfkLkDJFG7qpvnDXv1/m
 +yEXrrplMmmqPkSUlZELITBmZ6m0+Yui+XV074GvWiFXvTkUUu/8SEduNYasJjIFqCmXK9
 w+P3VOxHgdCPlB4Ym+YnR++FhLTM23o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-NuewWbeGNMimO56PS6ym3w-1; Wed,
 28 Feb 2024 00:16:35 -0500
X-MC-Unique: NuewWbeGNMimO56PS6ym3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37A8438212C0;
 Wed, 28 Feb 2024 05:16:35 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 470661C060AF;
 Wed, 28 Feb 2024 05:16:25 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 20/25] migration: stop vm for cpr
Date: Wed, 28 Feb 2024 13:13:10 +0800
Message-ID: <20240228051315.400759-21-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

When migration for cpr is initiated, stop the vm and set state
RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
possibility of ram and device state being out of sync, and guarantees
that a guest in the suspended state remains suspended, because qmp_cont
rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/migration.h    |  2 --
 migration/migration.c    | 51 ++++++++++++++++++++++++----------------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e4933b815b..5d1aa593ed 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,6 +60,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
diff --git a/migration/migration.h b/migration/migration.h
index aef8afbe1f..65c0b61cbd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
-int migration_stop_vm(RunState state);
-
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 37c836b0b0..90a90947fb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -167,11 +167,19 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
     return (a > b) - (a < b);
 }
 
-int migration_stop_vm(RunState state)
+static int migration_stop_vm(MigrationState *s, RunState state)
 {
-    int ret = vm_stop_force_state(state);
+    int ret;
+
+    migration_downtime_start(s);
+
+    s->vm_old_state = runstate_get();
+    global_state_store();
+
+    ret = vm_stop_force_state(state);
 
     trace_vmstate_downtime_checkpoint("src-vm-stopped");
+    trace_migration_completion_vm_stop(ret);
 
     return ret;
 }
@@ -1602,6 +1610,11 @@ bool migration_is_active(MigrationState *s)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migrate_mode_is_cpr(MigrationState *s)
+{
+    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
+}
+
 int migrate_init(MigrationState *s, Error **errp)
 {
     int ret;
@@ -2454,10 +2467,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     bql_lock();
     trace_postcopy_start_set_run();
 
-    migration_downtime_start(ms);
-
-    global_state_store();
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
     }
@@ -2652,15 +2662,12 @@ static int migration_completion_precopy(MigrationState *s,
     int ret;
 
     bql_lock();
-    migration_downtime_start(s);
-
-    s->vm_old_state = runstate_get();
-    global_state_store();
 
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
-    trace_migration_completion_vm_stop(ret);
-    if (ret < 0) {
-        goto out_unlock;
+    if (!migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            goto out_unlock;
+        }
     }
 
     ret = migration_maybe_pause(s, current_active_state,
@@ -3500,15 +3507,10 @@ static void *bg_migration_thread(void *opaque)
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
-    migration_downtime_start(s);
 
     bql_lock();
 
-    s->vm_old_state = runstate_get();
-
-    global_state_store();
-    /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (migration_stop_vm(RUN_STATE_PAUSED)) {
+    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
@@ -3584,6 +3586,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -3655,6 +3658,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
+            goto fail;
+        }
+    }
+
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, "bg_snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.43.0


