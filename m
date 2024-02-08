Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D32BC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Xb-0001av-V2; Thu, 08 Feb 2024 13:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XU-0001Y9-TK
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XS-0005oR-HX
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:24 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418Iju5a015620; Thu, 8 Feb 2024 18:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=WCcP6TWmLDaYsdFn0Xjp5tMFbrHpoq809H/HBgSJSqQ=;
 b=Ip8SwOhkAIPOYWcSvr9lPXhB0iiKaLZUwqyO4f41U0uz2gO0FQF2tnfbThtvHRs039e3
 B/uGfOCrbwn3sT1e7XAwEfXr8tfKrd2eB3GEfYQ9nu941FDXZvn1UYiNGs9c1dozqobb
 mqM5QEuHMHNe7SVfSDbKA22yZAX4QaDcgy2v8MPzipAeuSqknPBwKyYSCb/Ty1w7y5q0
 j4/XizSo7BW95wzhRo9iO4FxIYrdwujVfwpcAB7QwMQXumE5q0Fxhij/cgzGl8KcB0YA
 Mtx75VWa+ngJg0ZyFD7foO0udCgQ/YMLVQ3HtV0pO9v4J4NkS/QRsIseAUlcW/elap0l ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd5mph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:21 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418HcbYb038354; Thu, 8 Feb 2024 18:54:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawn91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq36B013534;
 Thu, 8 Feb 2024 18:54:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-8; Thu, 08 Feb 2024 18:54:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 07/13] migration: per-mode notifiers
Date: Thu,  8 Feb 2024 10:54:00 -0800
Message-Id: <1707418446-134863-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: T9FMOo7z8P-XDqvW5RLZIyhUavWS4CbR
X-Proofpoint-ORIG-GUID: T9FMOo7z8P-XDqvW5RLZIyhUavWS4CbR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Keep a separate list of migration notifiers for each migration mode.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 ++
 migration/migration.c    | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index d75c8b0..0ea1902 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -79,6 +79,8 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode);
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s, MigrationEventType type);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 5f04c46..1601a03 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -68,8 +68,13 @@
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
 
-static NotifierWithReturnList migration_state_notifiers =
-    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(migration_state_notifiers);
+#define NOTIFIER_ELEM_INIT(array, elem)    \
+    [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
+
+static NotifierWithReturnList migration_state_notifiers[] = {
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+};
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1455,11 +1460,17 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode)
+{
+    notify->notify = (NotifierWithReturnFunc)func;
+    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+}
+
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers, notify);
+    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
@@ -1472,10 +1483,11 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 
 void migration_call_notifiers(MigrationState *s, MigrationEventType type)
 {
+    MigMode mode = s->parameters.mode;
     MigrationEvent e;
 
     e.type = type;
-    notifier_with_return_list_notify(&migration_state_notifiers, &e, 0);
+    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
-- 
1.8.3.1


