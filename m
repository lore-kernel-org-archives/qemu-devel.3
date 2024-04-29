Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F2EC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMn-0005Tf-UL; Mon, 29 Apr 2024 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMT-0004iM-Bv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0005JH-9v
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmj9M006699; Mon, 29 Apr 2024 15:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=GpsDXkwU42jBrI4A7QnchPbVZI0PhZ5nHsXDpLdTUlY=;
 b=m72lAlHbkrT4D8LD6/lkKWjIetDsJxPlS7sqjbKdbwTYRpw1U+Jr8XuqEymR0Fxm6xoh
 jkHjdvOxdp/X1Yg7tFOC+hEBbTbdyBPDqWdUae/uts2nxVRt1nVXKwIgXy8NLI9dP3Tq
 DyxOpFgubNcCE6gleR0q5IMO25wezmQbO/qh6gOo/pEJ/MU/hmyOkFKfcR8zN+Pdycnw
 zCODXVDwSK4ESTIY8n56PdO7SzfAAbmaB28F+pfk6aQV3lZVG2PP091lOYezqEb0B/3d
 KgBzXE7VpG6/FKCihEUv77qlN1QgB4ndzl/9knCI+uaneyiwgwbhjDtpUj5DBGwTRGWf tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdejwnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFgaer011393; Mon, 29 Apr 2024 15:55:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaH8034442;
 Mon, 29 Apr 2024 15:55:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-21; Mon, 29 Apr 2024 15:55:51 +0000
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
Subject: [PATCH V1 20/26] migration: cpr-exec mode
Date: Mon, 29 Apr 2024 08:55:29 -0700
Message-Id: <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: F7RgHGRfLXEparyz_Qa0jv4G3uuqoDYv
X-Proofpoint-ORIG-GUID: F7RgHGRfLXEparyz_Qa0jv4G3uuqoDYv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add the cpr-exec migration mode.  Usage:
  qemu-system-$arch -machine memfd-alloc=on ...
  migrate_set_parameter mode cpr-exec
  migrate_set_parameter cpr-exec-args \
    <arg1> <arg2> ... -incoming <uri>
  migrate -d <uri>

The migrate command stops the VM, saves state to the URI,
directly exec's a new version of QEMU on the same host,
replacing the original process while retaining its PID, and
loads state from the URI.  Guest RAM is preserved in place,
albeit with new virtual addresses.

Arguments for the new QEMU process are taken from the
@cpr-exec-args parameter.  The first argument should be the
path of a new QEMU binary, or a prefix command that exec's the
new QEMU binary.

Because old QEMU terminates when new QEMU starts, one cannot
stream data between the two, so the URI must be a type, such as
a file, that reads all data before old QEMU exits.

Memory backend objects must have the share=on attribute, and
must be mmap'able in the new QEMU process.  For example,
memory-backend-file is acceptable, but memory-backend-ram is
not.

The VM must be started with the '-machine memfd-alloc=on'
option.  This causes implicit ram blocks (those not explicitly
described by a memory-backend object) to be allocated by
mmap'ing a memfd.  Examples include VGA, ROM, and even guest
RAM when it is specified without a memory-backend object.

The implementation saves precreate vmstate at the end of normal
migration in migrate_fd_cleanup, and tells the main loop to call
cpr_exec.  Incoming qemu loads preceate state early, before objects
are created.  The memfds are kept open across exec by clearing the
close-on-exec flag, their values are saved in precreate vmstate,
and they are mmap'd in new qemu.

Note that the memfd-alloc option is not related to memory-backend-memfd.
Later patches add support for memory-backend-memfd, and for additional
devices, including vfio, chardev, and more.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h  |  14 +++++
 include/migration/misc.h |   3 ++
 migration/cpr.c          | 131 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |   1 +
 migration/migration.c    |  21 ++++++++
 migration/migration.h    |   5 +-
 migration/ram.c          |   1 +
 qapi/migration.json      |  30 ++++++++++-
 system/physmem.c         |   2 +
 system/vl.c              |   4 ++
 10 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
new file mode 100644
index 0000000..aa8316d
--- /dev/null
+++ b/include/migration/cpr.h
@@ -0,0 +1,14 @@
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
+bool cpr_needed_for_exec(void *opaque);
+void cpr_unpreserve_fds(void);
+
+#endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index cf30351..5b963ba 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -122,4 +122,7 @@ bool migration_in_bg_snapshot(void);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/cpr.c */
+void cpr_exec(char **argv);
+
 #endif
diff --git a/migration/cpr.c b/migration/cpr.c
new file mode 100644
index 0000000..d4703e1
--- /dev/null
+++ b/migration/cpr.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/ramblock.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/misc.h"
+#include "migration/vmstate.h"
+#include "sysemu/runstate.h"
+#include "trace.h"
+
+/*************************************************************************/
+#define CPR_STATE "CprState"
+
+typedef struct CprState {
+    MigMode mode;
+} CprState;
+
+static CprState cpr_state = {
+    .mode = MIG_MODE_NORMAL,
+};
+
+static int cpr_state_presave(void *opaque)
+{
+    cpr_state.mode = migrate_mode();
+    return 0;
+}
+
+bool cpr_needed_for_exec(void *opaque)
+{
+    return migrate_mode() == MIG_MODE_CPR_EXEC;
+}
+
+static const VMStateDescription vmstate_cpr_state = {
+    .name = CPR_STATE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpr_needed_for_exec,
+    .pre_save = cpr_state_presave,
+    .precreate = true,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(mode, CprState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+vmstate_register_init(NULL, 0, vmstate_cpr_state, &cpr_state);
+
+/*************************************************************************/
+
+typedef int (*cpr_walk_fd_cb)(int fd);
+
+static int walk_ramblock(FactoryObject *obj, void *opaque)
+{
+    RAMBlock *rb = obj->opaque;
+    cpr_walk_fd_cb cb = opaque;
+    return cb(rb->fd);
+}
+
+static int cpr_walk_fd(cpr_walk_fd_cb cb)
+{
+    int ret = vmstate_walk_factory_outgoing(RAM_BLOCK, walk_ramblock, cb);
+    return ret;
+}
+
+static int preserve_fd(int fd)
+{
+    qemu_clear_cloexec(fd);
+    return 0;
+}
+
+static int unpreserve_fd(int fd)
+{
+    qemu_set_cloexec(fd);
+    return 0;
+}
+
+static void cpr_preserve_fds(void)
+{
+    cpr_walk_fd(preserve_fd);
+}
+
+void cpr_unpreserve_fds(void)
+{
+    cpr_walk_fd(unpreserve_fd);
+}
+
+static int cpr_fd_notifier_func(NotifierWithReturn *notifier,
+                                 MigrationEvent *e, Error **errp)
+{
+    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
+        e->type == MIG_EVENT_PRECOPY_FAILED) {
+        cpr_unpreserve_fds();
+    }
+    return 0;
+}
+
+void cpr_mig_init(void)
+{
+    static NotifierWithReturn cpr_fd_notifier;
+
+    migrate_get_current()->parameters.mode = cpr_state.mode;
+    migration_add_notifier(&cpr_fd_notifier, cpr_fd_notifier_func);
+}
+
+void cpr_exec(char **argv)
+{
+    MigrationState *s = migrate_get_current();
+    Error *err = NULL;
+
+    /*
+     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
+     * earlier because they should not persist across miscellaneous fork and
+     * exec calls that are performed during normal operation.
+     */
+    cpr_preserve_fds();
+
+    execvp(argv[0], argv);
+
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    error_report_err(err);
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, err);
+    migration_precreate_unsave();
+}
diff --git a/migration/meson.build b/migration/meson.build
index e667b40..d9e9c60 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'block-dirty-bitmap.c',
   'channel.c',
   'channel-block.c',
+  'cpr.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5..0d91531 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -239,6 +239,7 @@ void migration_object_init(void)
     blk_mig_init();
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_mig_init();
 }
 
 typedef struct {
@@ -1395,6 +1396,15 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        Error *err = NULL;
+        if (migration_precreate_save(&err)) {
+            migrate_set_error(s, err);
+            error_report_err(err);
+            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        }
+    }
+
     assert(!migration_is_active());
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -1410,6 +1420,11 @@ static void migrate_fd_cleanup(MigrationState *s)
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(s, type, NULL);
     block_cleanup_parameters();
+
+    if (migrate_mode() == MIG_MODE_CPR_EXEC && !migration_has_failed(s)) {
+        assert(s->state == MIGRATION_STATUS_COMPLETED);
+        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_args);
+    }
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -1977,6 +1992,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
+        !s->parameters.has_cpr_exec_args) {
+        error_setg(errp, "cpr-exec mode requires setting cpr-exec-args");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
diff --git a/migration/migration.h b/migration/migration.h
index 8045e39..2ad2163 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -490,7 +490,6 @@ bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
 bool migration_has_failed(MigrationState *);
-bool migrate_mode_is_cpr(MigrationState *);
 
 uint64_t ram_get_total_transferred_pages(void);
 
@@ -544,4 +543,8 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+/* CPR */
+bool migrate_mode_is_cpr(MigrationState *);
+void cpr_mig_init(void);
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index a975c5a..add285b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -219,6 +219,7 @@ static bool postcopy_preempt_active(void)
 bool migrate_ram_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
+           migrate_mode() == MIG_MODE_CPR_EXEC ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/qapi/migration.json b/qapi/migration.json
index 49710e7..7c5f45f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -665,9 +665,37 @@
 #     or COLO.
 #
 #     (since 8.2)
+#
+# @cpr-exec: The migrate command stops the VM, saves state to the URI,
+#     directly exec's a new version of QEMU on the same host,
+#     replacing the original process while retaining its PID, and
+#     loads state from the URI.  Guest RAM is preserved in place,
+#     albeit with new virtual addresses.
+#
+#     Arguments for the new QEMU process are taken from the
+#     @cpr-exec-args parameter.  The first argument should be the
+#     path of a new QEMU binary, or a prefix command that exec's the
+#     new QEMU binary.
+#
+#     Because old QEMU terminates when new QEMU starts, one cannot
+#     stream data between the two, so the URI must be a type, such as
+#     a file, that reads all data before old QEMU exits.
+#
+#     Memory backend objects must have the share=on attribute, and
+#     must be mmap'able in the new QEMU process.  For example,
+#     memory-backend-file is acceptable, but memory-backend-ram is
+#     not.
+#
+#     The VM must be started with the '-machine memfd-alloc=on'
+#     option.  This causes implicit ram blocks -- those not explicitly
+#     described by a memory-backend object -- to be allocated by
+#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
+#     RAM when it is specified without a memory-backend object.
+#
+#     (since 9.1)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
 
 ##
 # @ZeroPageDetection:
diff --git a/system/physmem.c b/system/physmem.c
index 3019284..87ad441 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -69,6 +69,7 @@
 
 #include "qemu/pmem.h"
 
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -2069,6 +2070,7 @@ const VMStateDescription vmstate_ram_block = {
     .minimum_version_id = 1,
     .precreate = true,
     .factory = true,
+    .needed = cpr_needed_for_exec,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(align, RAMBlock),
         VMSTATE_VOID_PTR(host, RAMBlock),
diff --git a/system/vl.c b/system/vl.c
index 7797206..7252100 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -76,6 +76,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "migration/vmstate.h"
@@ -3665,6 +3666,9 @@ void qemu_init(int argc, char **argv)
     qemu_create_machine(machine_opts_dict);
 
     vmstate_register_init_all();
+    migration_precreate_load(&error_fatal);
+    /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
+    cpr_unpreserve_fds();
 
     suspend_mux_open();
 
-- 
1.8.3.1


