Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85DCC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0QC-0000At-TC; Sun, 30 Jun 2024 15:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Px-0008Vc-Ql
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pv-0004Pf-AM
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJDtaG021987;
 Sun, 30 Jun 2024 19:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=b028g9TMxwjL28USZRQNrGWTPltZfSI206ZNnMeo+FE=; b=
 V81i7Hi0rFgrkpqkfcmY9IJ2tBsxa4ZD9ONcztXag4fvRq8MNWq2o4pxnYS454bx
 p2xkL+WQ+7crQHEJjsd30eTXjpcA/DTgrdPg8byljydCVdD8ASxiuqOEFS+VVtuy
 oL7m9dpmPw8OyBhznyRsRVIvmv9Zj2239M4d+eKs2H1jv2dxr8u72KvSGcASNtwF
 +KPPOtRxZDI1y7m4410VaXZG3+1iDLqvybdZAFeBQrAY/YXNKKwlQJFoc5XJcMM2
 i/AkxTiv+Tatrdfu/nnbkpIFJSUB4y8byjlSJlCQdi3LbLYCdFDthynahO7H5BD/
 wnTxWndv1NzzYRsPvRNHag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296asg9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UI4VL7018993; Sun, 30 Jun 2024 19:40:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSi014044;
 Sun, 30 Jun 2024 19:40:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-11; Sun, 30 Jun 2024 19:40:48 +0000
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
Subject: [PATCH V2 10/11] migration: cpr-exec save and load
Date: Sun, 30 Jun 2024 12:40:33 -0700
Message-Id: <1719776434-435013-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300157
X-Proofpoint-GUID: dfX4xSzsgK0SbDrY6mNJmAPiS-CwiTHy
X-Proofpoint-ORIG-GUID: dfX4xSzsgK0SbDrY6mNJmAPiS-CwiTHy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 migration/cpr-exec.c    | 95 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100644 migration/cpr-exec.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 42b4019..76d6ccb 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -25,4 +25,9 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 
+QEMUFile *cpr_exec_output(Error **errp);
+QEMUFile *cpr_exec_input(Error **errp);
+void cpr_exec_persist_state(QEMUFile *f);
+bool cpr_exec_has_state(void);
+void cpr_exec_unpersist_state(void);
 #endif
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
new file mode 100644
index 0000000..5c40457
--- /dev/null
+++ b/migration/cpr-exec.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
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
+#include "sysemu/runstate.h"
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
index 87feb4c..dd1d315 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'channel.c',
   'channel-block.c',
   'cpr.c',
+  'cpr-exec.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
-- 
1.8.3.1


