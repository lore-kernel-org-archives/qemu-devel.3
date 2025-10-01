Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E6CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrD-0005EZ-Ua; Wed, 01 Oct 2025 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqm-0004JN-A3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqZ-0006Pb-MS
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMj7j022680;
 Wed, 1 Oct 2025 15:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=a1OWDnMLDg8boXx6EnW3WJpFBvSqT8/lF0638NDHTDw=; b=
 RrTDqmZCefAPqIrfGYpyN/jD2HZgrkJBh1Suh2rvCAfHuapH/WE6vb7Ik7++6jRW
 Tfxoln7UpwrwDRcS/e2jg/V0dknmCOh8TANn3hArzfNjPaTSIjj8cKmHpxc5CVWx
 iFMKzS24RJPv2xFwZxUH5zUK6q6z1ubnhg9jFFsepjfLmXrd9esd+T8sCWvoCkts
 fmuxezipYUEyYZEl8oylF+tQNA3lMG3X+bvRvO3ph+fNUXc2xC344jboSRHdsUQs
 ip7OWbtQ7RjtlG9gtCLQeoSOgbYjUptuWedehgOpUeVDqoQSjTJLwAOlTvox7FCS
 lJ9NVlMflATJxIJ+YgDDEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bhqvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EnTC5023134; Wed, 1 Oct 2025 15:34:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqe014790;
 Wed, 1 Oct 2025 15:34:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-2; Wed, 01 Oct 2025 15:34:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 01/19] migration: multi-mode notifier
Date: Wed,  1 Oct 2025 08:33:53 -0700
Message-Id: <1759332851-370353-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-GUID: TKj1Rj-LLARM_fus1ioMAa7EAKI5xtEF
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd49f6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=qm0lDVemfS40E2rT5CEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX8XPfRucVJx0T
 O59GZ0bS4OuYE3OqAn32d4eGhHobxLYHGa11S2tO9T6kUGf+F/v0wPxgUxt6x8XCwQ+/KW8kIL6
 d2ByRdQJ1DeuWZm3ZBXdMn+KYDaV/Aa12mHwQ2oWUhxkbI715axpYXDoJBFqRu8YModUNfQaDrv
 dfaXSVUL9MKs/bQ1jX4a0TnnBHUreXilXkyB0f5Msl1z5bslsAW6qrBO/QL9k6gcBy5SGfFwH5t
 QHNnla9qtMYEUEgYM7v19v62Es8Z4RxFtb0chGRcxfh1agetppLlCb5MlrzBlbU2rdXqe29Da1N
 9i4n/683TyYHTRQ+lP3zK/TL4mYZqo9DuNDkKF6HJKsLQLh8NaTpBEn9POTO0FN8wilwygvEsG1
 gXGx+xitJwo1lotytBgiImaauLss8A==
X-Proofpoint-ORIG-GUID: TKj1Rj-LLARM_fus1ioMAa7EAKI5xtEF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


