Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C986C30653
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0QO-0000G7-Qf; Sun, 30 Jun 2024 15:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0QB-0000As-Cs
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:41:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Q6-0004Pp-7W
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:41:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UIt2tN001382;
 Sun, 30 Jun 2024 19:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=s2nPXNUcWaNjXppRfhXzp3VvXyVUj6SXPjOtMadq9Ac=; b=
 fZmQ1aySNvNYlSxjrzZFDf0dYFq6HcZkiLb1G6ZeTsmsOWuKT9aZg15zmybe4CCX
 qMEGX9EhStLeL6blSncH6p0vzory5i21y0VDnGimNSjg2MK49DEkTv95rxH6EXBy
 QUk5uM7XmIg4zOhhWGlw1udKhrU1lD9tf/auw6PRCWkhI7I/uGq2fLhWbAzEEl8Y
 9bcg3bz9qiueT3cAxN9HEryud0dJM1BIIma52W/EKb48/4LGOGf/KE1hHlnYg+0s
 rrmQaJGmq9k/kcQVDwT90imlT8eixWtjfwnL3rVnA/+LszTpqMtUVrneU2zaHmLD
 lWkMOOz23oY3Suw4BDPgtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402att9e21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UIF7Pe018995; Sun, 30 Jun 2024 19:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSk014044;
 Sun, 30 Jun 2024 19:40:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-12; Sun, 30 Jun 2024 19:40:50 +0000
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
Subject: [PATCH V2 11/11] migration: cpr-exec mode
Date: Sun, 30 Jun 2024 12:40:34 -0700
Message-Id: <1719776434-435013-12-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 5kF2f7jvzqH_aire-mOMf0vaaCopLgJ4
X-Proofpoint-ORIG-GUID: 5kF2f7jvzqH_aire-mOMf0vaaCopLgJ4
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

Add the cpr-exec migration mode.  Usage:
  qemu-system-$arch -machine anon-alloc=memfd ...
  migrate_set_parameter mode cpr-exec
  migrate_set_parameter cpr-exec-command \
    <arg1> <arg2> ... -incoming <uri-1> \
  migrate -d <uri-1>

The migrate command stops the VM, saves state to uri-1,
directly exec's a new version of QEMU on the same host,
replacing the original process while retaining its PID, and
loads state from uri-1.  Guest RAM is preserved in place,
albeit with new virtual addresses.

The new QEMU process is started by exec'ing the command
specified by the @cpr-exec-command parameter.  The first word of
the command is the binary, and the remaining words are its
arguments.  The command may be a direct invocation of new QEMU,
or may be a non-QEMU command that exec's the new QEMU binary.

This mode creates a second migration channel that is not visible
to the user.  At the start of migration, old QEMU saves CPR state
to the second channel, and at the end of migration, it tells the
main loop to call cpr_exec.  New QEMU loads CPR state early, before
objects are created.

Because old QEMU terminates when new QEMU starts, one cannot
stream data between the two, so uri-1 must be a type,
such as a file, that accepts all data before old QEMU exits.
Otherwise, old QEMU may quietly block writing to the channel.

Memory-backend objects must have the share=on attribute, but
memory-backend-epc is not supported.  The VM must be started with
the '-machine anon-alloc=memfd' option, which allows anonymous
memory to be transferred in place to the new process.  The memfds
are kept open across exec by clearing the close-on-exec flag, their
values are saved in CPR state, and they are mmap'd in new qemu.

Note that the anon-alloc option is not related to memory-backend-memfd.
Later patches add support for memory-backend-memfd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  2 ++
 migration/cpr-exec.c    | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c         | 37 ++++++++++++++++++---
 migration/migration.c   | 14 ++++++--
 migration/ram.c         |  2 ++
 qapi/migration.json     | 24 +++++++++++++-
 6 files changed, 157 insertions(+), 7 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 76d6ccb..c6c60f8 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -30,4 +30,6 @@ QEMUFile *cpr_exec_input(Error **errp);
 void cpr_exec_persist_state(QEMUFile *f);
 bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
+void cpr_mig_init(void);
+void cpr_unpreserve_fds(void);
 #endif
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 5c40457..fd65435 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -11,8 +11,11 @@
 #include "qapi/error.h"
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
+#include "block/block-global-state.h"
+#include "qemu/main-loop.h"
 #include "migration/cpr.h"
 #include "migration/qemu-file.h"
+#include "migration/migration.h"
 #include "migration/misc.h"
 #include "migration/vmstate.h"
 #include "sysemu/runstate.h"
@@ -93,3 +96,85 @@ QEMUFile *cpr_exec_input(Error **errp)
     lseek(mfd, 0, SEEK_SET);
     return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
 }
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
+static void cpr_exec(char **argv)
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
+    cpr_unpreserve_fds();
+
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    error_report_err(error_copy(err));
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, err);
+
+    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+
+    if (s->block_inactive) {
+        Error *local_err = NULL;
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return;
+        } else {
+            s->block_inactive = false;
+        }
+    }
+
+    if (runstate_is_live(s->vm_old_state)) {
+        vm_start();
+    }
+}
+
+static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
+                             Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        assert(s->state == MIGRATION_STATUS_COMPLETED);
+        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        cpr_exec_unpersist_state();
+    }
+    return 0;
+}
+
+void cpr_mig_init(void)
+{
+    static NotifierWithReturn notifier;
+    migration_add_notifier_mode(&notifier, cpr_exec_notifier,
+                                MIG_MODE_CPR_EXEC);
+}
diff --git a/migration/cpr.c b/migration/cpr.c
index 1c296c6..f756c15 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -9,6 +9,7 @@
 #include "qapi/error.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
@@ -160,9 +161,16 @@ int cpr_state_save(Error **errp)
 {
     int ret;
     QEMUFile *f;
+    MigMode mode = migrate_mode();
 
-    /* set f based on mode in a later patch in this series */
-    return 0;
+    if (mode == MIG_MODE_CPR_EXEC) {
+        f = cpr_exec_output(errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
 
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
@@ -170,8 +178,14 @@ int cpr_state_save(Error **errp)
     ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
     if (ret) {
         error_setg(errp, "vmstate_save_state error %d", ret);
+        goto out;
     }
 
+    if (mode == MIG_MODE_CPR_EXEC) {
+        cpr_exec_persist_state(f);
+    }
+
+out:
     qemu_fclose(f);
     return ret;
 }
@@ -182,8 +196,18 @@ int cpr_state_load(Error **errp)
     uint32_t v;
     QEMUFile *f;
 
-    /* set f based on mode in a later patch in this series */
-    return 0;
+    /*
+     * Mode will be loaded in CPR state, so cannot use it to decide which
+     * form of state to load.
+     */
+    if (cpr_exec_has_state()) {
+        f = cpr_exec_input(errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -203,6 +227,11 @@ int cpr_state_load(Error **errp)
         error_setg(errp, "vmstate_load_state error %d", ret);
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
+        cpr_unpreserve_fds();
+    }
+
     qemu_fclose(f);
     return ret;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 8a8e927..a4a020e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -73,9 +73,10 @@
 
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
-static NotifierWithReturnList migration_state_notifiers[] = {
+static NotifierWithReturnList migration_state_notifiers[MIG_MODE__MAX] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_EXEC),
 };
 
 /* Messages sent on the return path from destination to source */
@@ -264,6 +265,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_mig_init();
 }
 
 typedef struct {
@@ -1693,7 +1695,9 @@ bool migration_thread_is_self(void)
 
 bool migrate_mode_is_cpr(MigrationState *s)
 {
-    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
+    MigMode mode = s->parameters.mode;
+    return mode == MIG_MODE_CPR_REBOOT ||
+           mode == MIG_MODE_CPR_EXEC;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2028,6 +2032,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         return false;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
+        !s->parameters.has_cpr_exec_command) {
+        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
diff --git a/migration/ram.c b/migration/ram.c
index eaf3151..45b8f00 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -216,7 +216,9 @@ static bool postcopy_preempt_active(void)
 
 bool migrate_ram_is_ignored(RAMBlock *block)
 {
+    MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
+           mode == MIG_MODE_CPR_EXEC ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/qapi/migration.json b/qapi/migration.json
index 20092d2..4e626df 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -604,9 +604,31 @@
 #     or COLO.
 #
 #     (since 8.2)
+#
+# @cpr-exec: The migrate command stops the VM, saves state to the
+#     migration channel, directly exec's a new version of QEMU on the
+#     same host, replacing the original process while retaining its
+#     PID, and loads state from the channel.  Guest RAM is preserved
+#     in place.
+#
+#     Old QEMU starts new QEMU by exec'ing the command specified by
+#     the @cpr-exec-command parameter.  The command may be a direct
+#     invocation of new QEMU, or may be a non-QEMU command that exec's
+#     the new QEMU binary.
+#
+#     Because old QEMU terminates when new QEMU starts, one cannot
+#     stream data between the two, so the channel must be a type,
+#     such as a file, that accepts all data before old QEMU exits.
+#     Otherwise, old QEMU may quietly block writing to the channel.
+#
+#     Memory-backend objects must have the share=on attribute, but
+#     memory-backend-epc is not supported.  The VM must be started
+#     with the '-machine anon-alloc=memfd' option.
+#
+#     (since 9.1)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
 
 ##
 # @ZeroPageDetection:
-- 
1.8.3.1


