Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDFC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsY-0004ko-ES; Thu, 22 Feb 2024 12:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsT-0004j3-EU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsR-0003D9-QF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:57 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MGtc6q005183; Thu, 22 Feb 2024 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=hFgl8tvTrOvJ0dXJAR8o7o4bvOTku39BFJ3n9ZyNU1Y=;
 b=bo/u/J81vGErnfvhPnPEWrQ+0GgYocoX+d2VwLKdwx6u8+N6ipr/SIohPiNNylD46UOB
 oAGPPbiVPyxUklMUtJTQ1o5YoZNyibvqsk/IJ2/IpKdjhUvflBd5BZd9F5AV+5JGv4fG
 uX9GK67H3bDuJNcnlHFmGfS2NKZRCaaFRrVU0PUyS67uNK/2FSFiYgl5XTiAfNekFnV/
 eGXsjCGvhTW/VPneesv9a7GXTFdjouY1VTSzKVAcWN91ouSBBjR11vec/h9E5l+OwB0z
 UfJLE8o8iJYcy8BhL6V8iSaXh7gOkR5x/rs7Vt49Gam2bESzN9RN85AamJqg6xTZH+7J QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw52v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:54 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG9UJn024561; Thu, 22 Feb 2024 17:28:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgA3032453;
 Thu, 22 Feb 2024 17:28:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-8; Thu, 22 Feb 2024 17:28:52 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 07/14] migration: per-mode notifiers
Date: Thu, 22 Feb 2024 09:28:33 -0800
Message-Id: <1708622920-68779-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Gsmrrpfx117hphCD1zdhg_TqezvPCIVI
X-Proofpoint-ORIG-GUID: Gsmrrpfx117hphCD1zdhg_TqezvPCIVI
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

Keep a separate list of migration notifiers for each migration mode.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/migration/misc.h |  6 ++++++
 migration/migration.c    | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e36a1f3..4dc06a9 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -86,6 +86,12 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
 
+/*
+ * Same as migration_add_notifier, but applies to be specified @mode.
+ */
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode);
+
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s, MigrationEventType type);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 33149c4..925103b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -69,8 +69,13 @@
 #include "qemu/sockets.h"
 #include "sysemu/kvm.h"
 
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
@@ -1463,11 +1468,17 @@ static void migrate_fd_cancel(MigrationState *s)
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
@@ -1480,10 +1491,11 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 
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


