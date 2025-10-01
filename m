Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A260ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yqt-0004UY-SH; Wed, 01 Oct 2025 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yql-0004IS-St
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqZ-0006Ps-KB
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:39 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FN0ru011640;
 Wed, 1 Oct 2025 15:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=HOUVyH/K5ivY35ieQZAsBir5jT9lYuqM07KxnT9Ynlc=; b=
 rXcwpH6u5Q2Y6v/FHQrgq/J3f8FjUOb+rpOKzyn0JhplaBesm4HEjgFbcOlaaSpQ
 sqNhF7UEOzKdP0LMWAsTcxeuVUqMUNZ3r3P7zWDVej1MCn7QlP1DTh3jeX1HQ4+x
 wZWOWvPSAHlmompgYhi6mbXouhgcJARJolwtQJW+gUB5q8gavNPqcOwWKALokLh+
 fVJKfgHN/TYPX9W0LhqV4KbaPBu6CbVdHHVF7fpsfnw6kqcPTMnLiavViDcLrKz3
 WG80A4RGYzp3KYWafIGLgI4JkDdldtA9P18Xxw0e4d3/8ZQsx82VLt22Z8f6wcC4
 I9ckBgfU7CEgkNYPHjCINQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591Engvg023121; Wed, 1 Oct 2025 15:34:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqm014790;
 Wed, 1 Oct 2025 15:34:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-6; Wed, 01 Oct 2025 15:34:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 05/19] migration: cpr-exec save and load
Date: Wed,  1 Oct 2025 08:33:57 -0700
Message-Id: <1759332851-370353-6-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd49f9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=mt9KrOKPv6uyc6Gi5S4A:9
X-Proofpoint-ORIG-GUID: uwWYlsmfI19036yMU9g-JaBqWAC2nKiP
X-Proofpoint-GUID: uwWYlsmfI19036yMU9g-JaBqWAC2nKiP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfXxELEOfhNwulK
 gmTWZTMnS5LHIBjQVyMA1o2zfYMTTw5AeuJ5z7fA44X8LpWAbjgfOEBD0ODbkeY0KsmtUmQqY7U
 mNor+d/syaCopciT6GhzbGuwf636RhlOa4C3E7Eu2yQ7r3AQkwqbsuOQ4ih9pYqZ/tQ3JXL+Pqw
 VAK/nJnLdX1Q9U7DhxCCCWUWLIKoF4qrsGzrAw2O/FItgozM90SPVhp0Rv4mxWtGGzvAuGTnEcA
 9WNexqS3kHiKUa+Mx9Ld2I0RwuvMR6K6AaMadyOYdrqOrX+fLGgE4vRUIhECX3xYGU+CkOQ6t6d
 stD2iQU3ZHVVXe6LHoRHtiDKxyH0M9ZQJHIU5sOYymrrh4J90J2QjOhp+Kn0RcPmnaszx90dTuF
 W15UHQSuR0VaQWflsWIQVcaj3tG7Uw==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 migration/cpr-exec.c    | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100644 migration/cpr-exec.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 2b074d7..b84389f 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
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
index 0000000..9b54eab
--- /dev/null
+++ b/migration/cpr-exec.c
@@ -0,0 +1,93 @@
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
+    int mfd = qemu_memfd_create(CPR_EXEC_STATE_NAME, 0, false, 0, 0, errp);
+
+    if (mfd < 0) {
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
index 0f71544..16909d5 100644
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


