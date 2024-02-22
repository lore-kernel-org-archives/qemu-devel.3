Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E65BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsX-0004kf-WF; Thu, 22 Feb 2024 12:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsW-0004kI-Kk
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsU-0003ER-Tl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH93vN003389; Thu, 22 Feb 2024 17:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Tblg+6OG6Lt4MehE1ykRrcRbYGVc+HXXJGb9aqjcWwo=;
 b=ImhQSAntfymYxztspEX3IPpMmei5TFLyky/RIxBK1h5E9gaEaKeXxE+Xb0uM5g90EpF5
 iRCMxpYoTwJ2kSbrsMGBboOJX9eMY3/T3OcZU8R+7dmnBukNqAWME/tKDTzqKTxcAsqs
 axkOAMzGHATQCKNwMFK6QcF08bYTjMt84IMV2C0UwSyzOVhInBRiNGwR10KvLqi6/wOp
 alXQjtIGzU5ONkg1AVFzdPXfHl7SUdPP1vkBPgrHnafPmqUp4emkykUQY+SFK9Q8GjMY
 dJvPoL32JdSiDX0/qOBtVSL5D6kVPB2sAy2Iw1zTKkEm7p11yzkCdJ/+ZOdec+M6Eu2+ ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knw1cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG4lZx024355; Thu, 22 Feb 2024 17:28:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgA7032453;
 Thu, 22 Feb 2024 17:28:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-10; Thu, 22 Feb 2024 17:28:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 09/14] migration: notifier error checking
Date: Thu, 22 Feb 2024 09:28:35 -0800
Message-Id: <1708622920-68779-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: xq6s9JdbXDsISQP5FYapEljN5vDHLmjl
X-Proofpoint-GUID: xq6s9JdbXDsISQP5FYapEljN5vDHLmjl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Check the status returned by migration notifiers for event type
MIG_EVENT_PRECOPY_SETUP, and report errors.  None of the notifiers
return an error status at this time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  8 +++++++-
 migration/migration.c    | 25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4dc06a9..e4933b8 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -72,6 +72,11 @@ typedef struct MigrationEvent {
     MigrationEventType type;
 } MigrationEvent;
 
+/*
+ * A MigrationNotifyFunc may return an error code and an Error object,
+ * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
+ * to allow for different failure modes and recovery actions.
+ */
 typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
                                    MigrationEvent *e, Error **errp);
 
@@ -93,7 +98,8 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-void migration_call_notifiers(MigrationState *s, MigrationEventType type);
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 6a115d2..37c836b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1376,7 +1376,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(s, type);
+    migration_call_notifiers(s, type, NULL);
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1489,13 +1489,18 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s, MigrationEventType type)
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp)
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
+    int ret;
 
     e.type = type;
-    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
+    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
+                                           &e, errp);
+    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
+    return ret;
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2549,7 +2554,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
 
     migration_downtime_end(ms);
 
@@ -2569,11 +2574,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_setg(errp, "postcopy_start: Migration stream errored");
-        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                              MIGRATION_STATUS_FAILED);
+        error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
+        bql_lock();
+        goto fail;
     }
-
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
 
     return ret;
@@ -2594,6 +2598,7 @@ fail:
             error_report_err(local_err);
         }
     }
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
@@ -3613,7 +3618,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP);
+        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+            goto fail;
+        }
     }
 
     migration_rate_set(rate_limit);
-- 
1.8.3.1


