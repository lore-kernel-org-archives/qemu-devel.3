Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382FC30653
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0Q1-000072-5B; Sun, 30 Jun 2024 15:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0008SB-E9
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pn-0004O2-Jv
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJW3BS026542;
 Sun, 30 Jun 2024 19:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=7+QL5ZrrpPDnlyBxW0st4Wn/YKyjCdy8c6YwBxJSlJI=; b=
 JMYo2HVd42mWYrnCWpGbMD657/sjXoB8OAlMJmyB+Kh0EczHvef2CpXnFzVqCyse
 Xg7y7CrmHGv4kLaqAKLxAsWJXAq3q+stU2+3fz91cscpGTQj9jTKu6E08Qy3HkQP
 Zuw+qyRZxn/gnEXY2c6Lp2XL6iHiNzpsRVrTuF7Fxk9ZsdysrAlf6EAExrJVH0nx
 yWgxJQYy8hipl7kBs0vQjs71bQZPyvuUNaYeNA4Ox5HNx4UV2q1Gpk4sMk3CDF6I
 KolCOLG18bnNhd+zjwk/KkSx8AY24S9LuMhzA5TmmVV270KQh7TkPhhk6oDxER7c
 mon2K3wE7nq0HnI3TDLaTg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0hgjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UHtoa4019083; Sun, 30 Jun 2024 19:40:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSS014044;
 Sun, 30 Jun 2024 19:40:38 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-3; Sun, 30 Jun 2024 19:40:38 +0000
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
Subject: [PATCH V2 02/11] migration: cpr-state
Date: Sun, 30 Jun 2024 12:40:25 -0700
Message-Id: <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: zfmTs7vXi1T1LP0RHQR8hE53gHD2ecPu
X-Proofpoint-GUID: zfmTs7vXi1T1LP0RHQR8hE53gHD2ecPu
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
---
 include/migration/cpr.h |  21 ++++++
 migration/cpr.c         | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |   1 +
 migration/migration.c   |   6 ++
 migration/trace-events  |   5 ++
 system/vl.c             |   3 +
 6 files changed, 224 insertions(+)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
new file mode 100644
index 0000000..8e7e705
--- /dev/null
+++ b/include/migration/cpr.h
@@ -0,0 +1,21 @@
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
+typedef int (*cpr_walk_fd_cb)(int fd);
+void cpr_save_fd(const char *name, int id, int fd);
+void cpr_delete_fd(const char *name, int id);
+int cpr_find_fd(const char *name, int id);
+int cpr_walk_fd(cpr_walk_fd_cb cb);
+void cpr_resave_fd(const char *name, int id, int fd);
+
+int cpr_state_save(Error **errp);
+int cpr_state_load(Error **errp);
+
+#endif
diff --git a/migration/cpr.c b/migration/cpr.c
new file mode 100644
index 0000000..313e74e
--- /dev/null
+++ b/migration/cpr.c
@@ -0,0 +1,188 @@
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
+
+int cpr_walk_fd(cpr_walk_fd_cb cb)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+        if (elem->fd >= 0 && cb(elem->fd)) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+void cpr_resave_fd(const char *name, int id, int fd)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    int old_fd = elem ? elem->fd : -1;
+
+    if (old_fd < 0) {
+        cpr_save_fd(name, id, fd);
+    } else if (old_fd != fd) {
+        error_setg(&error_fatal,
+                   "internal error: cpr fd '%s' id %d value %d "
+                   "already saved with a different value %d",
+                   name, id, fd, old_fd);
+    }
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
+int cpr_state_save(Error **errp)
+{
+    int ret;
+    QEMUFile *f;
+
+    /* set f based on mode in a later patch in this series */
+    return 0;
+
+    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
+    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    if (ret) {
+        error_setg(errp, "vmstate_save_state error %d", ret);
+    }
+
+    qemu_fclose(f);
+    return ret;
+}
+
+int cpr_state_load(Error **errp)
+{
+    int ret;
+    uint32_t v;
+    QEMUFile *f;
+
+    /* set f based on mode in a later patch in this series */
+    return 0;
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_MAGIC) {
+        error_setg(errp, "Not a migration stream (bad magic %x)", v);
+        qemu_fclose(f);
+        return -EINVAL;
+    }
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_VERSION) {
+        error_setg(errp, "Unsupported migration stream version %d", v);
+        qemu_fclose(f);
+        return -ENOTSUP;
+    }
+
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    if (ret) {
+        error_setg(errp, "vmstate_load_state error %d", ret);
+    }
+
+    qemu_fclose(f);
+    return ret;
+}
+
diff --git a/migration/meson.build b/migration/meson.build
index 5ce2acb4..87feb4c 100644
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
index 3dea06d..e394ad7 100644
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
@@ -2118,6 +2119,10 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
+    if (cpr_state_save(&local_err)) {
+        goto out;
+    }
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
@@ -2142,6 +2147,7 @@ void qmp_migrate(const char *uri, bool has_channels,
                           MIGRATION_STATUS_FAILED);
     }
 
+out:
     if (local_err) {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c332..173f2c0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -340,6 +340,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
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
diff --git a/system/vl.c b/system/vl.c
index 03951be..6521ee3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -77,6 +77,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "sysemu/tpm.h"
@@ -3713,6 +3714,8 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
+    cpr_state_load(&error_fatal);
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
-- 
1.8.3.1


