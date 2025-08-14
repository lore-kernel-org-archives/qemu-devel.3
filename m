Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A973CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbaA-0005Vf-5C; Thu, 14 Aug 2025 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba7-0005U1-2G
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba4-0002qF-8y
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:38 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECg3g0020157;
 Thu, 14 Aug 2025 17:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4QWKzsape/wPi0214a2KMaISzaNbmpDGJwl9PMlhRvc=; b=
 pJFwSz/nsPDW92T1bZUp8w2cdQwDS+iBPrqSYiLV1fpylgHDuY8QUtycyszT+ATQ
 eW0Sk2PEtKqbI/5nivZ9rnarcur26Vb47lMDpF40AXqfb04LvlsjvtOx4NdVtVEQ
 2mry08XV2nA5wHmOzdmeF+iRWMP9modLmL0B1b5kodP/MUHIaoK9iVbN8Fa4cP+i
 oyVXdlsB0h2SlqBMhu/935WcfUikCyte3hED8tOxTu0xyCKcybUfkT8IF2ze6cpe
 z4jZnK5O91rW/4IFdQHInRa4iwaOHgohLpDeSdnXAmFcEFI54jLjLojdNZJSA6R1
 RlEDzEWfgg9nR5QQ7d4UZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4jhap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGs9gL010435; Thu, 14 Aug 2025 17:17:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuI038225;
 Thu, 14 Aug 2025 17:17:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-7; Thu, 14 Aug 2025 17:17:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 6/9] migration: cpr-exec save and load
Date: Thu, 14 Aug 2025 10:17:20 -0700
Message-Id: <1755191843-283480-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX4zdlPyL0Mo+N
 8cHbzNhW8/p776A9LBsLQ9rDz+yl2srA+YniBXG66GFapj7ZbsL08huA+9aODdTfmELjZCbNp9z
 j7LwgpXlMJFfU/2y4il9nQsLpRhFeA+54AWh59jQJ+OwRoWo7xwyEhc61IKIMFnqjpVMpfsZsVM
 gmgfZcK+vmQxV2T6XLDqj20ulngXWcg7cxhefPw/pr51vzBOX259NQlXWCvCZ3IO7axhqV4zKYG
 cHrbgPXRVjXcTKukzwAZ0d0e2BdYRvvP9+nNY0IcavLOCraf2qkSYUE1rbiOHCYNJ+ZgExar7Sv
 ROi0HGE0ILErQiWCHjrfYLLZ0nvsRwRHPCxqdA6OFTigDkBqgXJxg+BarzC5r8xNbnoRa+GYKiJ
 +yNXEGP7WE/yJKF0SU8FVwjfSHNGKKcPq+yjGSEwmbPARs3p6kotFImCBBVDkBlco4WpsbGv
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689e1a2e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=mt9KrOKPv6uyc6Gi5S4A:9 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: 4Bn6d7IUCNIxCvqlLEhYqV6KIs-DFKzH
X-Proofpoint-ORIG-GUID: 4Bn6d7IUCNIxCvqlLEhYqV6KIs-DFKzH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To preserve CPR state across exec, create a QEMUFile based on a memfd, and
keep the memfd open across exec.  Save the value of the memfd in an
environment variable so post-exec QEMU can find it.

These new functions are called in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  5 +++
 migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100644 migration/cpr-exec.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index f4fc5ca..aaeec02 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -54,4 +54,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+QEMUFile *cpr_exec_output(Error **errp);
+QEMUFile *cpr_exec_input(Error **errp);
+void cpr_exec_persist_state(QEMUFile *f);
+bool cpr_exec_has_state(void);
+void cpr_exec_unpersist_state(void);
 #endif
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
new file mode 100644
index 0000000..2c32e9c
--- /dev/null
+++ b/migration/cpr-exec.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/memfd.h"
+#include "qapi/error.h"
+#include "io/channel-file.h"
+#include "io/channel-socket.h"
+#include "migration/cpr.h"
+#include "migration/qemu-file.h"
+#include "migration/misc.h"
+#include "migration/vmstate.h"
+#include "system/runstate.h"
+
+#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
+
+static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_input(ioc);
+}
+
+static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_output(ioc);
+}
+
+void cpr_exec_persist_state(QEMUFile *f)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+    int mfd = dup(fioc->fd);
+    char val[16];
+
+    /* Remember mfd in environment for post-exec load */
+    qemu_clear_cloexec(mfd);
+    snprintf(val, sizeof(val), "%d", mfd);
+    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
+}
+
+static int cpr_exec_find_state(void)
+{
+    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
+    int mfd;
+
+    assert(val);
+    g_unsetenv(CPR_EXEC_STATE_NAME);
+    assert(!qemu_strtoi(val, NULL, 10, &mfd));
+    return mfd;
+}
+
+bool cpr_exec_has_state(void)
+{
+    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
+}
+
+void cpr_exec_unpersist_state(void)
+{
+    int mfd;
+    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
+
+    g_unsetenv(CPR_EXEC_STATE_NAME);
+    assert(val);
+    assert(!qemu_strtoi(val, NULL, 10, &mfd));
+    close(mfd);
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);
+
+    if (mfd < 0) {
+        error_setg_errno(errp, errno, "memfd_create failed");
+        return NULL;
+    }
+
+    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    int mfd = cpr_exec_find_state();
+
+    lseek(mfd, 0, SEEK_SET);
+    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
+}
diff --git a/migration/meson.build b/migration/meson.build
index 276da3b..6087ccc 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -16,6 +16,7 @@ system_ss.add(files(
   'channel-block.c',
   'cpr.c',
   'cpr-transfer.c',
+  'cpr-exec.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
-- 
1.8.3.1


