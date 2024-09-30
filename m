Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B0CDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGX-0006w3-UG; Mon, 30 Sep 2024 15:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGV-0006qe-Hg
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGT-00020u-Mv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuZPg032368;
 Mon, 30 Sep 2024 19:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=splEVkPaHERaSEPsTDypJ2dZt7hIdIjvgo6rTNk9yzI=; b=
 c3K+uHZxo2HHviIXme3a3svkj8lXCi00yPZEnqhfBmtayepR+4N9dbDiWZRJWZXH
 zZWWfNkqOpCb78EOrS1ECFaLhEJlk15ZlA5o7S04vXebBMB1OsDEovNb/XyR4zC2
 PD2NEuQ//r7qUD9uCkJ/4b+pjGzb4oQRzTYo3i16WnvJtxGv6eIviCmxLzFZOZ4G
 uC100qcbdCsZTifQHggKVrfoNDZkMPFFX8yRk12bMG6vwwgJZvAM5KIH1VWvzV6r
 9pGop4DSc3q3rVAQrJQlSLMVTr/hBgW6AAMU1TmPb63n2u0VaqSwjgZi2VvDmDsM
 9I44GZTu7ZINjWLjvSvqcA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1ckpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UJWkVR012531; Mon, 30 Sep 2024 19:40:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868tty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepUo028204;
 Mon, 30 Sep 2024 19:40:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-4; Mon, 30 Sep 2024 19:40:55 +0000
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
Subject: [PATCH V2 03/13] migration: save cpr mode
Date: Mon, 30 Sep 2024 12:40:34 -0700
Message-Id: <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: CZmC-26_7ubatDqP8MXOHE_wvOPir9wk
X-Proofpoint-GUID: CZmC-26_7ubatDqP8MXOHE_wvOPir9wk
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

Save the mode in CPR state, so the user does not need to explicitly specify
it for the target.  Modify migrate_mode() so it returns the incoming mode on
the target.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  7 +++++++
 migration/cpr.c         | 23 ++++++++++++++++++++++-
 migration/migration.c   |  1 +
 migration/options.c     |  9 +++++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index e7b898b..ac7a63e 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -8,9 +8,16 @@
 #ifndef MIGRATION_CPR_H
 #define MIGRATION_CPR_H
 
+#include "qapi/qapi-types-migration.h"
+
+#define MIG_MODE_NONE           -1
+
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
 
+MigMode cpr_get_incoming_mode(void);
+void cpr_set_incoming_mode(MigMode mode);
+
 typedef int (*cpr_walk_fd_cb)(int fd);
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
diff --git a/migration/cpr.c b/migration/cpr.c
index e50fc75..7514c4e 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -21,10 +21,23 @@
 typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
 
 typedef struct CprState {
+    MigMode mode;
     CprFdList fds;
 } CprState;
 
-static CprState cpr_state;
+static CprState cpr_state = {
+    .mode = MIG_MODE_NONE,
+};
+
+MigMode cpr_get_incoming_mode(void)
+{
+    return cpr_state.mode;
+}
+
+void cpr_set_incoming_mode(MigMode mode)
+{
+    cpr_state.mode = mode;
+}
 
 /****************************************************************************/
 
@@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
 /*************************************************************************/
 #define CPR_STATE "CprState"
 
+static int cpr_state_presave(void *opaque)
+{
+    cpr_state.mode = migrate_mode();
+    return 0;
+}
+
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save = cpr_state_presave,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32(mode, CprState),
         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
         VMSTATE_END_OF_LIST()
     }
diff --git a/migration/migration.c b/migration/migration.c
index 834b0a2..df00e5c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -416,6 +416,7 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    cpr_set_incoming_mode(MIG_MODE_NONE);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 147cd2b..cc85a84 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -768,8 +769,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
 
 MigMode migrate_mode(void)
 {
-    MigrationState *s = migrate_get_current();
-    MigMode mode = s->parameters.mode;
+    MigMode mode = cpr_get_incoming_mode();
+
+    if (mode == MIG_MODE_NONE) {
+        MigrationState *s = migrate_get_current();
+        mode = s->parameters.mode;
+    }
 
     assert(mode >= 0 && mode < MIG_MODE__MAX);
     return mode;
-- 
1.8.3.1


