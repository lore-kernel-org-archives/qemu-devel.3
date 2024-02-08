Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980ADC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Xc-0001bB-Qn; Thu, 08 Feb 2024 13:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XW-0001Yj-SG
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XU-0005oh-Lw
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418Ik6d0020088; Thu, 8 Feb 2024 18:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=zPAMmVxL+ok2jMGzEmCWKDz75wO7j7NGVcD7kUCLI9A=;
 b=G7kwu6Mp4/SCK+W3t0ozWFce+bulZjFHj3NKb+WYWZ8MEFfEwqtD9grd+uqVobovSkXl
 wf7G1yrlrTd/2/U/5Wby0figemuhj9ehh5sg9zyDWgxqfC/ZPt66QDXwC8TV7AZAw9Bl
 iJ9y4nA6vbA9yuh3MdNJCbJOnZ7Po8pVWaETN/TXLpfdrlfJWGASL+5hb8UCP09XitJn
 S889quMLW3SwzWs3fFZCcw9jNwatjy+QeKdJq/zlx5loscBBNOE3tKJ3UNGYV2P0K2LN
 ToF+jzaVp5y3ss27HeqFrSfZEjC0sDhY1ad2PddaSKU613+ofmjt3QY2mNANsElFIIHY LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwewdeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:23 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418HWkMx038686; Thu, 8 Feb 2024 18:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawncg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:22 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq36F013534;
 Thu, 8 Feb 2024 18:54:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-10; Thu, 08 Feb 2024 18:54:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 09/13] migration: notifier error checking
Date: Thu,  8 Feb 2024 10:54:02 -0800
Message-Id: <1707418446-134863-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: L_HM-5lXPE70miD4wBHITZEjCcxr9mrH
X-Proofpoint-GUID: L_HM-5lXPE70miD4wBHITZEjCcxr9mrH
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

Check the status returned by migration notifiers and report errors.
If notifiers fail, call the notifiers again so they can clean up.
None of the notifiers return an error status at this time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  3 ++-
 migration/migration.c    | 40 +++++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0ea1902..6dc234b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -82,7 +82,8 @@ void migration_add_notifier(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 void migration_remove_notifier(NotifierWithReturn *notify);
-void migration_call_notifiers(MigrationState *s, MigrationEventType type);
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 01d8867..d1fce9e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1318,6 +1318,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    Error *local_err = NULL;
+
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1362,13 +1364,23 @@ static void migrate_fd_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
+    if (!migration_has_failed(s) &&
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, &local_err)) {
+
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    }
+
     if (s->error) {
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    migration_call_notifiers(s, s->state == MIGRATION_STATUS_COMPLETED ?
-                             MIG_EVENT_PRECOPY_DONE :
-                             MIG_EVENT_PRECOPY_FAILED);
+
+    if (migration_has_failed(s)) {
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+    }
+
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1481,13 +1493,15 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s, MigrationEventType type)
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp)
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
 
     e.type = type;
-    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
+    return notifier_with_return_list_notify(&migration_state_notifiers[mode],
+                                            &e, errp);
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2535,7 +2549,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
+    if (migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, errp)) {
+        goto fail;
+    }
 
     migration_downtime_end(ms);
 
@@ -2555,11 +2571,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
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
@@ -2580,6 +2595,7 @@ fail:
             error_report_err(local_err);
         }
     }
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
@@ -3594,7 +3610,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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


