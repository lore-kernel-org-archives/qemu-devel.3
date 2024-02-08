Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A3BC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Xe-0001bu-Dw; Thu, 08 Feb 2024 13:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XY-0001Zz-Ou
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XW-0005os-Jx
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:27 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418IkQVu020283; Thu, 8 Feb 2024 18:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=AKrGyHd5sYvDWxNgBylMHS2Y8gYn4BTh9nzo3WKhqw8=;
 b=eKWrlmOTruS35o/V5auHxz5kB/HkUjGnxT3+IQtWgsnzpcvK7algYuK0PFHDeGGYxX6f
 ckP9MyYXemmIzTLgNDKY00GkKNUasRZOtLXMKGjwTW2ra2P6cAxsOGRJk/sq41/puzKl
 qs9VHQLdws0vmeCXtCv/+X7djLZY4lRV3jF1y4UJC0GM2jWiyKvgsY2F8yYU+8AZ9I+m
 /OyTAa9LfxLuQTZYLHuCCmFSnEOdJ5w6H288CtTb483wLyLlUmZXs/ugL8QcosgnbfrW
 9bbaz2BAIbaszIJo+d78zI+bE9gQRjpAiC+7cAZO1jh9ewc9F6l4uVOLYWmpspQ9mOSo uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwewdes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:24 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418HcD5q038384; Thu, 8 Feb 2024 18:54:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawneh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq36H013534;
 Thu, 8 Feb 2024 18:54:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-11; Thu, 08 Feb 2024 18:54:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 10/13] migration: stop vm for cpr
Date: Thu,  8 Feb 2024 10:54:03 -0800
Message-Id: <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080099
X-Proofpoint-ORIG-GUID: swgr-NiT0Q330me73bx0eP6ODAqfvc9m
X-Proofpoint-GUID: swgr-NiT0Q330me73bx0eP6ODAqfvc9m
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 migration/migration.c    | 32 +++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 6dc234b..54c99a3 100644
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
index d1fce9e..fc5c587 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
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
@@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
     bql_lock();
     migration_downtime_start(s);
 
-    s->vm_old_state = runstate_get();
-    global_state_store();
-
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
-    trace_migration_completion_vm_stop(ret);
-    if (ret < 0) {
-        goto out_unlock;
+    if (!migrate_mode_is_cpr(s)) {
+        s->vm_old_state = runstate_get();
+        global_state_store();
+        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
+        trace_migration_completion_vm_stop(ret);
+        if (ret < 0) {
+            goto out_unlock;
+        }
     }
 
     ret = migration_maybe_pause(s, current_active_state,
@@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         goto fail;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        s->vm_old_state = runstate_get();
+        global_state_store();
+        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
+        trace_migration_completion_vm_stop(ret);
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
1.8.3.1


