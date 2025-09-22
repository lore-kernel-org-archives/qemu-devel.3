Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC2FCAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvc-0000Rf-R1; Mon, 22 Sep 2025 09:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gva-0000QO-74
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvV-0001v2-Nc
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NM5B030887;
 Mon, 22 Sep 2025 13:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=pqnZsGOveum6MdUWHm6O4m8PyUF0whO7RsRA30FGE0w=; b=
 E4izIl3OJEoVuICWOvc8lkp3aDnFsNAjLkGo0iXttH9o3f6VamNK0ZSwc8mPLmAM
 +fqvtNsw4zH9fjCSqYQP3/z9MJxD9vqnqpJJ9+0YCiY0yD4vASjOO34YgK8bxCBZ
 /MvubyXxqpD7//AKpcSeIQWTGXrUbj+8z9QhtVwRWY+ESbnnykhwQ5iQn5GzPt+F
 SZDV8949oyeRBudJRjnSuVN4bTVM0lszAErNZkhMOXkWaSoFk5BYGFvVmL17oDB9
 Ejo4gpNJquawIiL7swOCrQ1P3qg6XhQacb72tSeR3J/sPb25uIV4YdbG/fLtzF8E
 W6LXzU9YTKjJ/2FdLddBhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad2gmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCARua034252; Mon, 22 Sep 2025 13:49:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhanb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWL004351;
 Mon, 22 Sep 2025 13:49:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-6; Mon, 22 Sep 2025 13:49:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 5/8] migration: cpr-exec save and load
Date: Mon, 22 Sep 2025 06:49:42 -0700
Message-Id: <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: stoIjZNoyFdXhEM8gq1-gsfJLcY_xVFg
X-Proofpoint-GUID: stoIjZNoyFdXhEM8gq1-gsfJLcY_xVFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX9F7ifZdON4TB
 A82ONeVEhYxR+SnOXyzLVNlnRhYOst8vCjm06IkPFBaOyTJlbWNnXbxP2ZvcTEGNm81OocQPYs3
 1B1NWJ73vVwWtgUSupwP/k08wb/go7oI5NZ5YNrJFmgb5rtQ7em9eDIMHMuSQYjGPSUD9HfX8MI
 E993c1VsMBqVxc+88Xu43/YWwx3lGBvKOU09BF1g/8kO4QTj4xCpMrkd3n9CBUXom/K/5uI57gQ
 YnNLjl39earFUpSSB4eiBHBpmuW3j9kYHtCK5wffxi1L5ADYrUXkBi5oyp2397aZGX28NSrlShC
 ygWdfTiGaOOjYR19f3a6GxNiYnT5SareeQeipKHwRidzjK7jy49WBXUFtLadJPGGluG+W6de3Cl
 cAFURplz9eieiD/IRqO4h7xbkL/KRg==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d15404 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mt9KrOKPv6uyc6Gi5S4A:9 cc=ntf
 awl=host:13614
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


