Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241A8E6B278
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s0a-0003zW-8J; Fri, 01 Nov 2024 09:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0X-0003z4-6z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0U-0002C9-Hp
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dfiar023759;
 Fri, 1 Nov 2024 13:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=c9uS44G7ynQoLuJTNrIMsiM9YHe2zbMmlbNR2XgY2tM=; b=
 mJSANESEtPrWqq6KV/t66VRdPKtD2tzVufl/QmDHrFBAqeOycgLUyaj2feM/b9yQ
 jtca5wdabWBT2qWk77FB1Fu8DGcttP1Jm58ZH+g7w41o5Y4b1fpmOgzj9lIp/xzK
 5mKmAWs14vWcIPkuNQl6g237BKqhAGUVUnhHBWlpzwTJ81o4nILFKqox+q6cWTcj
 vFWzaUK39OZQkxTJsOzhfFhUClEdqVpDgfuBFFBMc5yaZNGFp4rH1+Bi2m6nIOLf
 /rHhiBoSebGEzFlv68rBY5jZV60Efzu/qhxZyJ8Du+Bhfc4quWw+Sx3Ek7jKYBLc
 m/A6Px7sMZFo/ReO+TDOug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc94a24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:47:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1CloLb010012; Fri, 1 Nov 2024 13:47:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91pt60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:47:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuO4006031;
 Fri, 1 Nov 2024 13:47:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-3; Fri, 01 Nov 2024 13:47:58 +0000
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
Subject: [PATCH V3 02/16] migration: cpr-state
Date: Fri,  1 Nov 2024 06:47:41 -0700
Message-Id: <1730468875-249970-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010099
X-Proofpoint-GUID: 6XpCEVmmDWzxV38Pzd2uhZQa1NahEpGy
X-Proofpoint-ORIG-GUID: 6XpCEVmmDWzxV38Pzd2uhZQa1NahEpGy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CPR must save state that is needed after QEMU is restarted, when devices
are realized.  Thus the extra state cannot be saved in the migration stream,
as objects must already exist before that stream can be loaded.  Instead,
define auxilliary state structures and vmstate descriptions, not associated
with any registered object, and serialize the aux state to a cpr-specific
stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
restarts, before devices are realized.

Provide accessors for clients to register file descriptors for saving.
The mechanism for passing the fd's to the new process will be specific
to each migration mode, and added in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h |  23 ++++++
 migration/cpr.c         | 192 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |   1 +
 migration/migration.c   |   1 +
 migration/trace-events  |   5 ++
 5 files changed, 222 insertions(+)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
new file mode 100644
index 0000000..6e4781c
--- /dev/null
+++ b/include/migration/cpr.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2021, 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIGRATION_CPR_H
+#define MIGRATION_CPR_H
+
+#define QEMU_CPR_FILE_MAGIC     0x51435052
+#define QEMU_CPR_FILE_VERSION   0x00000001
+
+void cpr_save_fd(const char *name, int id, int fd);
+void cpr_delete_fd(const char *name, int id);
+int cpr_find_fd(const char *name, int id);
+
+int cpr_state_save(Error **errp);
+int cpr_state_load(Error **errp);
+void cpr_state_close(void);
+struct QIOChannel *cpr_state_ioc(void);
+
+#endif
diff --git a/migration/cpr.c b/migration/cpr.c
new file mode 100644
index 0000000..be1dc92
--- /dev/null
+++ b/migration/cpr.c
@@ -0,0 +1,192 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/misc.h"
+#include "migration/options.h"
+#include "migration/qemu-file.h"
+#include "migration/savevm.h"
+#include "migration/vmstate.h"
+#include "sysemu/runstate.h"
+#include "trace.h"
+
+/*************************************************************************/
+/* cpr state container for all information to be saved. */
+
+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
+
+typedef struct CprState {
+    CprFdList fds;
+} CprState;
+
+static CprState cpr_state;
+
+/****************************************************************************/
+
+typedef struct CprFd {
+    char *name;
+    unsigned int namelen;
+    int id;
+    int fd;
+    QLIST_ENTRY(CprFd) next;
+} CprFd;
+
+static const VMStateDescription vmstate_cpr_fd = {
+    .name = "cpr fd",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(namelen, CprFd),
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
+        VMSTATE_INT32(id, CprFd),
+        VMSTATE_INT32(fd, CprFd),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void cpr_save_fd(const char *name, int id, int fd)
+{
+    CprFd *elem = g_new0(CprFd, 1);
+
+    trace_cpr_save_fd(name, id, fd);
+    elem->name = g_strdup(name);
+    elem->namelen = strlen(name) + 1;
+    elem->id = id;
+    elem->fd = fd;
+    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
+}
+
+static CprFd *find_fd(CprFdList *head, const char *name, int id)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, head, next) {
+        if (!strcmp(elem->name, name) && elem->id == id) {
+            return elem;
+        }
+    }
+    return NULL;
+}
+
+void cpr_delete_fd(const char *name, int id)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+
+    if (elem) {
+        QLIST_REMOVE(elem, next);
+        g_free(elem->name);
+        g_free(elem);
+    }
+
+    trace_cpr_delete_fd(name, id);
+}
+
+int cpr_find_fd(const char *name, int id)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    int fd = elem ? elem->fd : -1;
+
+    trace_cpr_find_fd(name, id, fd);
+    return fd;
+}
+/*************************************************************************/
+#define CPR_STATE "CprState"
+
+static const VMStateDescription vmstate_cpr_state = {
+    .name = CPR_STATE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+/*************************************************************************/
+
+static QEMUFile *cpr_state_file;
+
+QIOChannel *cpr_state_ioc(void)
+{
+    return qemu_file_get_ioc(cpr_state_file);
+}
+
+int cpr_state_save(Error **errp)
+{
+    int ret;
+    QEMUFile *f;
+
+    /* set f based on mode in a later patch in this series */
+    return 0;
+
+    qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
+    qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
+
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    if (ret) {
+        error_setg(errp, "vmstate_save_state error %d", ret);
+        qemu_fclose(f);
+        return ret;
+    }
+
+    /*
+     * Close the socket only partially so we can later detect when the other
+     * end closes by getting a HUP event.
+     */
+    qemu_fflush(f);
+    qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
+                         NULL);
+    cpr_state_file = f;
+    return 0;
+}
+
+int cpr_state_load(Error **errp)
+{
+    int ret;
+    uint32_t v;
+    QEMUFile *f;
+
+    /* set f based on other parameters in a later patch in this series */
+    return 0;
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_CPR_FILE_MAGIC) {
+        error_setg(errp, "Not a migration stream (bad magic %x)", v);
+        qemu_fclose(f);
+        return -EINVAL;
+    }
+    v = qemu_get_be32(f);
+    if (v != QEMU_CPR_FILE_VERSION) {
+        error_setg(errp, "Unsupported migration stream version %d", v);
+        qemu_fclose(f);
+        return -ENOTSUP;
+    }
+
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    if (ret) {
+        error_setg(errp, "vmstate_load_state error %d", ret);
+        qemu_fclose(f);
+        return ret;
+    }
+
+    /*
+     * Let the caller decide when to close the socket (and generate a HUP event
+     * for the sending side).
+     */
+    cpr_state_file = f;
+
+    return ret;
+}
+
+void cpr_state_close(void)
+{
+    if (cpr_state_file) {
+        qemu_fclose(cpr_state_file);
+        cpr_state_file = NULL;
+    }
+}
diff --git a/migration/meson.build b/migration/meson.build
index 66d3de8..e5f4211 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -13,6 +13,7 @@ system_ss.add(files(
   'block-dirty-bitmap.c',
   'channel.c',
   'channel-block.c',
+  'cpr.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
diff --git a/migration/migration.c b/migration/migration.c
index 021faee..6dc7c09 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -27,6 +27,7 @@
 #include "sysemu/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
+#include "migration/cpr.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "migration.h"
diff --git a/migration/trace-events b/migration/trace-events
index c65902f..5356fb5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -341,6 +341,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
 # colo-failover.c
 colo_failover_set_state(const char *new_state) "new state %s"
 
+# cpr.c
+cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
+cpr_delete_fd(const char *name, int id) "%s, id %d"
+cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
+
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
 send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
-- 
1.8.3.1


