Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF370CDD1A9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGn-0007sC-8N; Mon, 30 Sep 2024 15:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGh-0007XP-IT
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGf-00022q-Ri
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuX8T007871;
 Mon, 30 Sep 2024 19:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=2GEiIcSxrwEcMxbQLQ6IYADhuLjJTqizq+JqDue8yiE=; b=
 lzKZ97gdnKk4CJpYkZBPd/Yi0/gySxm3gS7ph1kHXgdUBIkC5v5AWmGOvFT0bFcn
 BZHW0Iis2tiwrg4kV8weQMXsO0CUUmnFkPAJL6qUV0qjdL/3EGO4RQ0cbAMRAumZ
 LEgSZIhViWhOQIrNhL9AvdRRwmtDLm2FCz2TqE1ORB8vb43bl+aKuAdFdxi3dmBT
 0+HyWu6aHMBKKBuj7dLK6ZsVyB82S8FPmeNBJwYPhqcrea/FemhZNF5t1wTlaUuI
 e8JEst+o2H0u/GK1M0fRY7ROIg1RPTraZC9oHLa8em96vwTcMO99BUSHiWW9M6jh
 DmqAavIWEHjLSeYW8HOGZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtmhkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UJLfmD012516; Mon, 30 Sep 2024 19:41:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868u3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepV8028204;
 Mon, 30 Sep 2024 19:41:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-13; Mon, 30 Sep 2024 19:41:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 12/13] migration: split qmp_migrate
Date: Mon, 30 Sep 2024 12:40:43 -0700
Message-Id: <1727725244-105198-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: 664ZMXleHMpAYR5RcsvEHDatdvogWzfz
X-Proofpoint-GUID: 664ZMXleHMpAYR5RcsvEHDatdvogWzfz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Split qmp_migrate into start and finish functions.  Finish will be
called asynchronously in a subsequent patch, but for now, call it
immediately.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 868bf0e..3301583 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2073,6 +2073,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
     return true;
 }
 
+static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
+                               Error **errp);
+
 void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
@@ -2120,12 +2123,6 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (!resume_requested) {
-        if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
-            return;
-        }
-    }
-
     if (migrate_mode_is_cpr(s)) {
         int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
@@ -2139,6 +2136,30 @@ void qmp_migrate(const char *uri, bool has_channels,
         goto out;
     }
 
+    qmp_migrate_finish(addr, resume_requested, errp);
+
+out:
+    if (local_err) {
+        migrate_fd_error(s, local_err);
+        error_propagate(errp, local_err);
+        if (stopped) {
+            vm_resume(s->vm_old_state);
+        }
+    }
+}
+
+static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
+                               Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+
+    if (!resume_requested) {
+        if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
+            return;
+        }
+    }
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
@@ -2163,14 +2184,13 @@ void qmp_migrate(const char *uri, bool has_channels,
                           MIGRATION_STATUS_FAILED);
     }
 
-out:
     if (local_err) {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
-        if (stopped) {
+        if (migrate_mode_is_cpr(s)) {
             vm_resume(s->vm_old_state);
         }
         return;
-- 
1.8.3.1


