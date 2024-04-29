Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C2EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMF-0004X4-JA; Mon, 29 Apr 2024 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vq-4q
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM4-0005Et-79
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:52 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmjvP006702; Mon, 29 Apr 2024 15:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=AsixATSRLpV+Yop01dX+ts3i0CYeTOgvTvdYJbJ4OQY=;
 b=lFrt4iZog+GLRgFaBt6eZ6O0H41PuUQZnVNR7uONQCyoY4aETxwNFrT81CuljVEBbMTe
 eu219Xy3pPOrGZeqlZa46aV8VUHfcXHkJ0RCMYlbB/XO4+JdiwfLq3rNF+wOIGNxrdkj
 IV8i4/5P4KsLPE5y80umIgsSNm/CSTILyRKuJn3QPxMmVhAcTkcYyX564BqNnr7F/FwY
 LN3vwGDvVbtpkBVJkh6zMzH6LX890vO644EAdsgCoJMBNEQKUOYXMnRpRarlEgPZJUpP
 OLKLht07B4DCMxH+tgRFNlVSDcYwgckS/QxnM+lOlr2MvcSFcXrO89/BWY2HSaXAV2AR 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdejwmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEheo5011366; Mon, 29 Apr 2024 15:55:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j64y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGe034442;
 Mon, 29 Apr 2024 15:55:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-7; Mon, 29 Apr 2024 15:55:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 06/26] migration: precreate vmstate for exec
Date: Mon, 29 Apr 2024 08:55:15 -0700
Message-Id: <1714406135-451286-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-GUID: ZbprD0pcIER2DImXWwmIew0YnfdbXrb_
X-Proofpoint-ORIG-GUID: ZbprD0pcIER2DImXWwmIew0YnfdbXrb_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide migration_precreate_save for saving precreate vmstate across exec.
Create a memfd, save its value in the environment, and serialize state
to it.  Reverse the process in migration_precreate_load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |   5 ++
 migration/meson.build    |   1 +
 migration/precreate.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 migration/precreate.c

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c9e200f..cf30351 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -56,6 +56,11 @@ AnnounceParameters *migrate_announce_params(void);
 
 void dump_vmstate_json_to_file(FILE *out_fp);
 
+/* migration/precreate.c */
+int migration_precreate_save(Error **errp);
+void migration_precreate_unsave(void);
+int migration_precreate_load(Error **errp);
+
 /* migration/migration.c */
 void migration_object_init(void);
 void migration_shutdown(void);
diff --git a/migration/meson.build b/migration/meson.build
index f76b1ba..50e7cb2 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -26,6 +26,7 @@ system_ss.add(files(
   'ram-compress.c',
   'options.c',
   'postcopy-ram.c',
+  'precreate.c',
   'savevm.c',
   'socket.c',
   'tls.c',
diff --git a/migration/precreate.c b/migration/precreate.c
new file mode 100644
index 0000000..0bf5e1f
--- /dev/null
+++ b/migration/precreate.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
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
+#include "migration/misc.h"
+#include "migration/qemu-file.h"
+#include "migration/savevm.h"
+
+#define PRECREATE_STATE_NAME "QEMU_PRECREATE_STATE"
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
+static int memfd_create_named(const char *name, Error **errp)
+{
+    int mfd;
+    char val[16];
+
+    mfd = memfd_create(name, 0);
+    if (mfd < 0) {
+        error_setg_errno(errp, errno, "memfd_create failed");
+        return -1;
+    }
+
+    /* Remember mfd in environment for post-exec load */
+    qemu_clear_cloexec(mfd);
+    snprintf(val, sizeof(val), "%d", mfd);
+    g_setenv(name, val, 1);
+
+    return mfd;
+}
+
+static int memfd_find_named(const char *name, int *mfd_p, Error **errp)
+{
+    const char *val = g_getenv(name);
+
+    if (!val) {
+        *mfd_p = -1;
+        return 0;       /* No memfd was created, not an error */
+    }
+    g_unsetenv(name);
+    if (qemu_strtoi(val, NULL, 10, mfd_p)) {
+        error_setg(errp, "Bad %s env value %s", PRECREATE_STATE_NAME, val);
+        return -1;
+    }
+    lseek(*mfd_p, 0, SEEK_SET);
+    return 0;
+}
+
+static void memfd_delete_named(const char *name)
+{
+    int mfd;
+    const char *val = g_getenv(name);
+
+    if (val) {
+        g_unsetenv(name);
+        if (!qemu_strtoi(val, NULL, 10, &mfd)) {
+            close(mfd);
+        }
+    }
+}
+
+static QEMUFile *qemu_file_new_memfd_output(const char *name, Error **errp)
+{
+    int mfd = memfd_create_named(name, errp);
+
+    if (mfd < 0) {
+        return NULL;
+    }
+
+    return qemu_file_new_fd_output(mfd, name);
+}
+
+static QEMUFile *qemu_file_new_memfd_input(const char *name, Error **errp)
+{
+    int ret, mfd;
+
+    ret = memfd_find_named(name, &mfd, errp);
+    if (ret || mfd < 0) {
+        return NULL;
+    }
+
+    return qemu_file_new_fd_input(mfd, name);
+}
+
+int migration_precreate_save(Error **errp)
+{
+    QEMUFile *f = qemu_file_new_memfd_output(PRECREATE_STATE_NAME, errp);
+
+    if (!f) {
+        return -1;
+    } else if (qemu_savevm_precreate_save(f, errp)) {
+        memfd_delete_named(PRECREATE_STATE_NAME);
+        return -1;
+    } else {
+        /* Do not close f, as mfd must remain open. */
+        return 0;
+    }
+}
+
+void migration_precreate_unsave(void)
+{
+    memfd_delete_named(PRECREATE_STATE_NAME);
+}
+
+int migration_precreate_load(Error **errp)
+{
+    int ret;
+    QEMUFile *f = qemu_file_new_memfd_input(PRECREATE_STATE_NAME, errp);
+
+    if (!f) {
+        return -1;
+    }
+    ret = qemu_savevm_precreate_load(f, errp);
+    qemu_fclose(f);
+    g_unsetenv(PRECREATE_STATE_NAME);
+    return ret;
+}
-- 
1.8.3.1


