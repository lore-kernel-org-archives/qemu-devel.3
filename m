Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CEFC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsr-0005No-5f; Thu, 22 Feb 2024 12:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsp-0005Mb-6q
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsn-0003J0-AP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:18 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH9aGe031377; Thu, 22 Feb 2024 17:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=yYkqhag+ZGTXKPDA5eix+T8bZQxSgGbYTN0RzZrNURA=;
 b=IPB7mvfqLH0XDWvIzdq3AgNifFgTQWrZWjhqx/uNQjZiPewp54yFXLAhhHMfAdrO5IqF
 UCfPTAWycFMyDAWBS3cnXVPJed/VZlcv2K9J9Tcx3icJixi2SQTeLfHIIGtY4z31gFyO
 4qE+PnBq8ANrvIA7P3ZCGbrKb5xKXcQYLe/6bHO0QKQcILWfDKVzzgwtLvV0kkxM7Mt0
 eXwfFYVAut9qPzGQv8Wzg+K7xv5qzElTx75s0jyZ5lD0o47aKxMDmD9bhmGa2O3jq8vQ
 zCwmsamlEVguLxIQuycU76b2/92OKZVk4cXXhX7VRMPdBYSyE+HhFACfoRkEPMomh+ES gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2dfy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:15 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG4la1024355; Thu, 22 Feb 2024 17:28:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgA9032453;
 Thu, 22 Feb 2024 17:28:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-11; Thu, 22 Feb 2024 17:28:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 10/14] migration: stop vm for cpr
Date: Thu, 22 Feb 2024 09:28:36 -0800
Message-Id: <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220138
X-Proofpoint-GUID: SFswUIRABeJ6Duo_pXWc6LKlQ64c5frt
X-Proofpoint-ORIG-GUID: SFswUIRABeJ6Duo_pXWc6LKlQ64c5frt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

When migration for cpr is initiated, stop the vm and set state
RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
possibility of ram and device state being out of sync, and guarantees
that a guest in the suspended state remains suspended, because qmp_cont
rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  1 +
 migration/migration.c    | 51 +++++++++++++++++++++++++++++-------------------
 migration/migration.h    |  2 --
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e4933b8..5d1aa59 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,6 +60,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
diff --git a/migration/migration.c b/migration/migration.c
index 37c836b..90a9094 100644
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
 
-    s->vm_old_state = runstate_get();
-    global_state_store();
-
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
diff --git a/migration/migration.h b/migration/migration.h
index aef8afb..65c0b61 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
-int migration_stop_vm(RunState state);
-
 #endif
-- 
1.8.3.1


