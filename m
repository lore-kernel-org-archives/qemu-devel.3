Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02852CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvh-0000Tq-7N; Mon, 22 Sep 2025 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gva-0000QV-Bp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvT-0001ti-1u
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NKHu006483;
 Mon, 22 Sep 2025 13:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=a1OWDnMLDg8boXx6EnW3WJpFBvSqT8/lF0638NDHTDw=; b=
 m7peNvEpdWJWWx16SmsiO5beBcqIwtsXHrG4iKEBU5/+/7vfF85jnuAfhUFYqmjk
 DfcgLw4LxG5/GcYn995GRwho7OHpFM5rm0BGhoyOqOYuOMHDIgC5LjF0DS5Yz0fX
 tKDoJiHQa9e5t26KGTfOhptCZLoDxnwCsf6GWwz3zxGUif7slOag9ddsg98h8thU
 qEwKij1k7GHaI7MYOP/FGI1S2vQ2O4GzjnjEzWZl/Qj/zvv7Okn4s6ncSDZke+ni
 h0C4Vbhp/kyL0XWvmznXKCeu0KJhuO2KSO3K2EVUkRDyMh9ikPmy8H6cLKATIa/b
 nww5fxwRfINQmh2+ZwOeow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvttfmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCMrcL034116; Mon, 22 Sep 2025 13:49:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhan86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWD004351;
 Mon, 22 Sep 2025 13:49:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-2; Mon, 22 Sep 2025 13:49:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 1/8] migration: multi-mode notifier
Date: Mon, 22 Sep 2025 06:49:38 -0700
Message-Id: <1758548985-354793-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/Qe2ZnnjzvI5
 M95mU5YM4OhUfWRi2qOQKbY6wEs28p9LUG4X9YzECVxyjHcdYxbYZoYHkOpy+znyOjiTLSxmpbl
 LwXtHySknXKxckP3eXoHKxv0rSNWPE3N4qwlATjgU9F2Fj3NBfDCYsdwCsdmm928uO2p2F9PDvW
 WmUXr7EfD8ISG035cl7ppEDxUARiaTF7akwIWdKnlfVp4i9fsiHl9qFRJREtGGFevv6REAU6yNO
 ELOVvrylyZWpkQl50iJLjFqvq+j2hTWM+u7dqskBnYbfTPMH0XIHpVXL7k9OM++uUIQvYu+9NpQ
 tK3S3epdOlV6T7g64Es5dPwZ+fx9qjmhBOf+xZ2+BU1WvtCsWZZaEBOXgFTZs4u7EBywv/wnEtJ
 jWVmNmyOdEB1jmf2o2FBeYKzCFufYQ==
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d153fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=qm0lDVemfS40E2rT5CEA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: Ga9aDgP-61HG5lJfm8DQqM3p0By6obAZ
X-Proofpoint-ORIG-GUID: Ga9aDgP-61HG5lJfm8DQqM3p0By6obAZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow a notifier to be added for multiple migration modes.
To allow a notifier to appear on multiple per-node lists, use
a generic list type.  We can no longer use NotifierWithReturnList,
because it shoe horns the notifier onto a single list.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/misc.h | 12 ++++++++++
 migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a261f99..592b930 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
+/*
+ * Same as migration_add_notifier, but applies to all @mode in the argument
+ * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
+ * the notifier is added for all modes.
+ */
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...);
+
+/*
+ * Remove a notifier from all modes.
+ */
 void migration_remove_notifier(NotifierWithReturn *notify);
+
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d..08a98f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -74,11 +74,7 @@
 
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
-static NotifierWithReturnList migration_state_notifiers[] = {
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
-};
+static GSList *migration_state_notifiers[MIG_MODE__MAX];
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1665,23 +1661,51 @@ void migration_cancel(void)
     }
 }
 
+static int get_modes(MigMode mode, va_list ap);
+
+static void add_notifiers(NotifierWithReturn *notify, int modes)
+{
+    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (modes & BIT(mode)) {
+            migration_state_notifiers[mode] =
+                g_slist_prepend(migration_state_notifiers[mode], notify);
+        }
+    }
+}
+
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...)
+{
+    int modes;
+    va_list ap;
+
+    va_start(ap, mode);
+    modes = get_modes(mode, ap);
+    va_end(ap);
+
+    notify->notify = (NotifierWithReturnFunc)func;
+    add_notifiers(notify, modes);
+}
+
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+    migration_add_notifier_modes(notify, func, mode, -1);
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
+    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
-        notifier_with_return_remove(notify);
+        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+            migration_blockers[mode] =
+                g_slist_remove(migration_state_notifiers[mode], notify);
+        }
         notify->notify = NULL;
     }
 }
@@ -1691,13 +1715,23 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
+    NotifierWithReturn *notifier;
+    GSList *elem, *next;
     int ret;
 
     e.type = type;
-    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
-                                           &e, errp);
-    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
-    return ret;
+
+    for (elem = migration_state_notifiers[mode]; elem; elem = next) {
+        next = elem->next;
+        notifier = (NotifierWithReturn *)elem->data;
+        ret = notifier->notify(notifier, &e, errp);
+        if (ret) {
+            assert(type == MIG_EVENT_PRECOPY_SETUP);
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 bool migration_has_failed(MigrationState *s)
-- 
1.8.3.1


