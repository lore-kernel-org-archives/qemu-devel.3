Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F1BCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mD-0001A9-9P; Mon, 03 Nov 2025 16:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mB-00019V-TR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lt-0005Tl-26
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8ERM4pYYY4KJ4lCWCOZId0nsbezKUKvl/rCjsGxowM=;
 b=HVMhJQwaWwD+7ZAOznDP5Inyrqbi129obt10iKCde0lpds8SVRDfr4z0csXvHiFuY4r971
 7FI/Yyy2CGQXn788HH5ZAx/0PViHyfsVqM6agIOSzAUAXCy8+FtbWruykgs6knkMOswJBG
 SGkUmL/u5OgQ9KYPu2kE/8EjDdyb2Nc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-R3nrD7rKM0aQ-CJfOVJ3gw-1; Mon, 03 Nov 2025 16:07:20 -0500
X-MC-Unique: R3nrD7rKM0aQ-CJfOVJ3gw-1
X-Mimecast-MFC-AGG-ID: R3nrD7rKM0aQ-CJfOVJ3gw_1762204040
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-891d8184bebso993798585a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204039; x=1762808839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8ERM4pYYY4KJ4lCWCOZId0nsbezKUKvl/rCjsGxowM=;
 b=IhQHy0XJa67ai/lOSvkBH1SgMeHodDZau1ZlHJjSMIdthv+bPsGCmOH7xHwfqxuzHC
 DtnSLRqIcFsx5GHMy8/C/H5GIKH8ZGi2aDZRHgTgM6tLV/Nrzhvsy35cReN8VeFO4aWf
 oNA/D1OdvM6bCkhe4RE+n4sL0y0FH5dC1Ccsls9zcrJd+/Pu8YSXbYh3CzyfXvwgoDpd
 tqHGf+jZeBTSpFaQeKcK2g+Vd64AxUvcLlo2pZzFrl74o6TfVy8kI9B1rJnpYpcr+8CN
 ENLSYANwOukFnvu7gD23tQh22vW+Y54EUUo7k4SKlbtCpRh5r56yJ64uaokMF29qf0vo
 C6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204039; x=1762808839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8ERM4pYYY4KJ4lCWCOZId0nsbezKUKvl/rCjsGxowM=;
 b=VxFl8PWp/4liHH50xaN52/TaJmPK7tgI2EcT86rM0AtZqTV+PCp5sYBLpg2vYnZWUE
 vdHWpS5uvINRs2t8il6az5Dd7HyTlfbYk2zQG5ofnrvp7Ac/hnrV7zOePRTzfnIHlaDe
 idsj5jMLXMs/Ba+8/7LRC9BemlwO6Tap6A1vY23QH3Towbac3WBFCWQ56UDD1FodpcKI
 EvrQjl8Rvr9SQGrQica4h/1t9O/aNJwhRkkPPmHSGwgA7AAIqp9PZy1GI5tJls4ka+ge
 SDgpOJjxvIXP0AlVFsiMd6LuCMyK1IxsSPtIRpN2VIWANITlVdWUImBE8iEeeDd5y/AQ
 wPBg==
X-Gm-Message-State: AOJu0YzSXBLj7Fqh5FOFcjc0wOMEJWXW0U7Dzq/fPHDCfWKEmwtoNhrf
 dFp2+7U/5ZrcqL/xFyQEWL5lUXtAYPfpCothdhJucaXfeT1WxHo9wlvLy2mfHyDNiN3zSegjlUY
 44pX2RlxdcBDkWqjJ7wj9pY47TqHhWvrIXl2WV3IiZTrUHBcc6a3trlHueIYjd/GV4LS01O+kdd
 eP5sR254mOscnl0WUqwXje1RGq8JDHFd1O1XCNtw==
X-Gm-Gg: ASbGncuiuefIa/0qH6NJ0lcRss7MIE03qMM8Ahxn2RBrCODiH12NRg9I32d+w5PTrwl
 CXaZPPEVETN+nck9PhOkfLrPxjPAyziNzN62Fej1PyrvcxPswKKoiCqJ0qqXzE3WVD6M9MqW3r2
 qvN6bg4tVUbgKTxy6qnMuAXv+Q7+N/83vGRMTgN3Gv77URSpEzNDNO2lOkyotaAjmuvjBvvd7cu
 pKTeNtsXAzrCIXeSrgs5cKj8Nfawq7KXlWLpX3NTYOGLt9u8zgcDRddVEY5AXQkueSGf+/Ef2Xj
 q9YqzENGzEVmwy5h85M1uhMLD23YN/9mU3z0vz7ZZW2Kksrqvk/NIpsE6bgsXONc
X-Received: by 2002:a05:620a:3705:b0:865:cacf:e11c with SMTP id
 af79cd13be357-8ab990ab2bamr1592932785a.11.1762204038906; 
 Mon, 03 Nov 2025 13:07:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEck6oGmp2bwI52tE+uCQdS21KUS+LcVLnEJmNxKF0rLYX6CiDjsvytICISZ5msG4D4bnDdvg==
X-Received: by 2002:a05:620a:3705:b0:865:cacf:e11c with SMTP id
 af79cd13be357-8ab990ab2bamr1592925685a.11.1762204038196; 
 Mon, 03 Nov 2025 13:07:18 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 36/36] migration: Introduce POSTCOPY_DEVICE state
Date: Mon,  3 Nov 2025 16:06:25 -0500
Message-ID: <20251103210625.3689448-37-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

Currently, when postcopy starts, the source VM starts switchover and
sends a package containing the state of all non-postcopiable devices.
When the destination loads this package, the switchover is complete and
the destination VM starts. However, if the device state load fails or
the destination side crashes, the source side is already in
POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
up-to-date machine state as the destination has not yet started.

This patch introduces a new POSTCOPY_DEVICE state which is active while
the destination machine is loading the device state, is not yet running,
and the source side can be resumed in case of a migration failure.
Return-path is required for this state to function, otherwise it will be
skipped in favor of POSTCOPY_ACTIVE.

To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
side uses a PONG message that is a response to a PING message processed
just before the POSTCOPY_RUN command that starts the destination VM.
Thus, this feature is effective even if the destination side does not
yet support this new state.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-9-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 10 ++++--
 migration/migration.h                 |  3 ++
 migration/savevm.h                    |  2 ++
 migration/migration.c                 | 50 ++++++++++++++++++++++++---
 migration/postcopy-ram.c              | 10 ++++--
 migration/savevm.c                    |  5 +++
 tests/qtest/migration/precopy-tests.c |  3 +-
 migration/trace-events                |  1 +
 tests/qemu-iotests/194                |  2 +-
 9 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index c7a6737cc1..93f71de3fe 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,6 +142,12 @@
 # @postcopy-active: like active, but now in postcopy mode.
 #     (since 2.5)
 #
+# @postcopy-device: like postcopy-active, but the destination is still
+#     loading device state and is not running yet.  If migration fails
+#     during this state, the source side will resume.  If there is no
+#     return-path from destination to source, this state is skipped.
+#     (since 10.2)
+#
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
 # @postcopy-recover-setup: setup phase for a postcopy recovery
@@ -173,8 +179,8 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'postcopy-paused',
-            'postcopy-recover-setup',
+            'active', 'postcopy-device', 'postcopy-active',
+            'postcopy-paused', 'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
 ##
diff --git a/migration/migration.h b/migration/migration.h
index 4a37f7202c..213b33fe6e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -510,6 +510,9 @@ struct MigrationState {
     /* Is this a rdma migration */
     bool rdma_migration;
 
+    bool postcopy_package_loaded;
+    QemuEvent postcopy_package_loaded_event;
+
     GSource *hup_source;
 };
 
diff --git a/migration/savevm.h b/migration/savevm.h
index c337e3e3d1..125a2507b7 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -29,6 +29,8 @@
 #define QEMU_VM_COMMAND              0x08
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
+#define QEMU_VM_PING_PACKAGED_LOADED 0x42
+
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 637be71bfe..c2daab6bdd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1206,6 +1206,7 @@ bool migration_is_running(void)
 
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1227,6 +1228,7 @@ static bool migration_is_active(void)
     MigrationState *s = current_migration;
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
@@ -1349,6 +1351,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -1402,6 +1405,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
@@ -1732,6 +1736,7 @@ bool migration_in_postcopy(void)
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1833,6 +1838,9 @@ int migrate_init(MigrationState *s, Error **errp)
     memset(&mig_stats, 0, sizeof(mig_stats));
     migration_reset_vfio_bytes_transferred();
 
+    s->postcopy_package_loaded = false;
+    qemu_event_reset(&s->postcopy_package_loaded_event);
+
     return 0;
 }
 
@@ -2568,6 +2576,11 @@ static void *source_return_path_thread(void *opaque)
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
             qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+                trace_source_return_path_thread_postcopy_package_loaded();
+                ms->postcopy_package_loaded = true;
+                qemu_event_set(&ms->postcopy_package_loaded_event);
+            }
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2813,6 +2826,15 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
+    if (ms->rp_state.rp_thread_created) {
+        /*
+        * This ping will tell us that all non-postcopiable device state has been
+        * successfully loaded and the destination is about to start. When
+        * response is received, it will trigger transition from POSTCOPY_DEVICE
+        * to POSTCOPY_ACTIVE state.
+        */
+        qemu_savevm_send_ping(fb, QEMU_VM_PING_PACKAGED_LOADED);
+    }
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -2868,8 +2890,13 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
-    /* Now, switchover looks all fine, switching to postcopy-active */
+    /*
+     * Now, switchover looks all fine, switching to POSTCOPY_DEVICE, or
+     * directly to POSTCOPY_ACTIVE if there is no return path.
+     */
     migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
+                      ms->rp_state.rp_thread_created ?
+                      MIGRATION_STATUS_POSTCOPY_DEVICE :
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     bql_unlock();
@@ -3311,8 +3338,8 @@ static MigThrError migration_detect_error(MigrationState *s)
         return postcopy_pause(s);
     } else {
         /*
-         * For precopy (or postcopy with error outside IO), we fail
-         * with no time.
+         * For precopy (or postcopy with error outside IO, or before dest
+         * starts), we fail with no time.
          */
         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
         trace_migration_thread_file_err();
@@ -3447,7 +3474,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
-    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
+                        s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
     bool complete_ready;
 
@@ -3463,6 +3491,18 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * POSTCOPY_ACTIVE it means switchover already happened.
          */
         complete_ready = !pending_size;
+        if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
+            (s->postcopy_package_loaded || complete_ready)) {
+            /*
+             * If package has been loaded, the event is set and we will
+             * immediatelly transition to POSTCOPY_ACTIVE. If we are ready for
+             * completion, we need to wait for destination to load the postcopy
+             * package before actually completing.
+             */
+            qemu_event_wait(&s->postcopy_package_loaded_event);
+            migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
+        }
     } else {
         /*
          * Exact pending reporting is only needed for precopy.  Taking RAM
@@ -4117,6 +4157,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
+    qemu_event_destroy(&ms->postcopy_package_loaded_event);
 }
 
 static void migration_instance_init(Object *obj)
@@ -4138,6 +4179,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
+    qemu_event_init(&ms->postcopy_package_loaded_event, 0);
 }
 
 /*
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 8405cce7b4..3f98dcb6fd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2117,7 +2117,8 @@ static void *postcopy_listen_thread(void *opaque)
     object_ref(OBJECT(migr));
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      mis->to_src_file ? MIGRATION_STATUS_POSTCOPY_DEVICE :
+                                         MIGRATION_STATUS_POSTCOPY_ACTIVE);
     qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
@@ -2164,8 +2165,7 @@ static void *postcopy_listen_thread(void *opaque)
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
             g_clear_pointer(&local_err, error_report_err);
-            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                           MIGRATION_STATUS_FAILED);
+            migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
             goto out;
         }
     }
@@ -2176,6 +2176,10 @@ static void *postcopy_listen_thread(void *opaque)
      */
     qemu_event_wait(&mis->main_thread_load_event);
 
+    /*
+     * Device load in the main thread has finished, we should be in
+     * POSTCOPY_ACTIVE now.
+     */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                    MIGRATION_STATUS_COMPLETED);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 01b5a8bfff..62cc2ce25c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2170,6 +2170,11 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
         return -1;
     }
 
+    /* We might be already in POSTCOPY_ACTIVE if there is no return path */
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    }
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index bb38292550..57ca623de5 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1316,13 +1316,14 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     }
 
     /* ensure new status don't go unnoticed */
-    assert(MIGRATION_STATUS__MAX == 15);
+    assert(MIGRATION_STATUS__MAX == 16);
 
     for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
         switch (i) {
         case MIGRATION_STATUS_DEVICE: /* happens too fast */
         case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
         case MIGRATION_STATUS_COLO: /* no support in tests */
+        case MIGRATION_STATUS_POSTCOPY_DEVICE: /* postcopy can't be cancelled */
         case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
         case MIGRATION_STATUS_POSTCOPY_PAUSED:
         case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
diff --git a/migration/trace-events b/migration/trace-events
index 772636f3ac..bf11b62b17 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -191,6 +191,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_postcopy_package_loaded(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret) "ret=%d"
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index e114c0b269..806624394d 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -76,7 +76,7 @@ with iotests.FilePath('source.img') as source_img_path, \
 
     while True:
         event1 = source_vm.event_wait('MIGRATION')
-        if event1['data']['status'] == 'postcopy-active':
+        if event1['data']['status'] in ('postcopy-device', 'postcopy-active'):
             # This event is racy, it depends do we really do postcopy or bitmap
             # was migrated during downtime (and no data to migrate in postcopy
             # phase). So, don't log it.
-- 
2.50.1


