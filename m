Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3960CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvh-0000Tr-6y; Mon, 22 Sep 2025 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gve-0000SL-KE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvb-0001vv-Pn
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:06 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NM0Q030881;
 Mon, 22 Sep 2025 13:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=i7UfslXeC7dbh77BjEQkceC6BmJ39kT/oadJ+bYbN48=; b=
 k2tahy88Wrmf1d/Iyo1zn2jOP2GY53IZgaD2HVmjf4Radf87kbu6y18R/sdR3PQx
 dxPxNNcDDfXqKzOIuaMiSQd/I50zJJCbQ7bmQjsJdrhfVNFE/hpLuRLylGP+kmZ+
 puE2Q21TM33x7+rmCZ2X4lkL8pUu+Qm9COOK3n6EKmYXjbD8wdwMcrqCSkkRLJLC
 2y6AX+UAOTUJd43y2n/2mBjv50b7O8RgUy2W1jz8fnBllLZcxJ9dqiq57Ypmfpy7
 3t8QlmTa/KZxncSzVTDmITjhNIMxas1bcl2bUKzH1W7RpMyfW76Rl+Z3TD1Sz4Mc
 cRHhfmaSDPSniQgylW8XUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad2gn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCARub034252; Mon, 22 Sep 2025 13:49:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhanbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWN004351;
 Mon, 22 Sep 2025 13:49:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-7; Mon, 22 Sep 2025 13:49:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 6/8] migration: cpr-exec mode
Date: Mon, 22 Sep 2025 06:49:43 -0700
Message-Id: <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: VyafF5Sq2-BE5dvqtPM2JIoqARukWvFN
X-Proofpoint-GUID: VyafF5Sq2-BE5dvqtPM2JIoqARukWvFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX0t3+e+Msgwe2
 RoLaTXhFpasEZM+EbKB9pVpYycnUcvDXjYozLxrRbtoF2nOAUbVj67GeycePElK5gOBSdQy8T0L
 C2/5GqbrHP7EdCf9w4ZhH8ZZs1TUAa2Qc/jWfkn5fdGTec4rh9n9PpJVmOjy3TgW9pFd6PcchGa
 okJScTKYMHAJyQBKwzubFj0l7WtTsXxFs0CjBtyhhkzUr/dPgSqQkap+utrvo4GNXw6e2Ms/p0A
 HV/f0ZS+p/3uaEwV2pVhJyQNzNwoNB76Ysm23j12IKHHeNWW1RvMtlQXrPe6tNMmP66Vs2tub6q
 BZyxmho9y3gg2BPa7CJ5xxNRgDp3xdI3bBC6UurFePc8HNh3aT9V/Zb+i4P8Tr3nzo28J+EEVU2
 oiJ6hBuv6WALNGwWnFLlB415/KULWQ==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d15405 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=V5tUqp5okAFojsnLb_sA:9
 cc=ntf awl=host:13614
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

Add the cpr-exec migration mode.  Usage:
  qemu-system-$arch -machine aux-ram-share=on ...
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
the '-machine aux-ram-share=on' option, which allows anonymous
memory to be transferred in place to the new process.  The memfds
are kept open across exec by clearing the close-on-exec flag, their
values are saved in CPR state, and they are mmap'd in new QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json       | 25 +++++++++++++-
 include/migration/cpr.h   |  1 +
 migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c           | 28 ++++++++++++++--
 migration/migration.c     | 10 +++++-
 migration/ram.c           |  1 +
 migration/vmstate-types.c |  8 +++++
 system/vl.c               |  4 ++-
 migration/trace-events    |  1 +
 9 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2be8fa1..be0f3fc 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -694,9 +694,32 @@
 #     until you issue the `migrate-incoming` command.
 #
 #     (since 10.0)
+#
+# @cpr-exec: The migrate command stops the VM, saves state to the
+#     migration channel, directly exec's a new version of QEMU on the
+#     same host, replacing the original process while retaining its
+#     PID, and loads state from the channel.  Guest RAM is preserved
+#     in place.  Devices and their pinned pages are also preserved for
+#     VFIO and IOMMUFD.
+#
+#     Old QEMU starts new QEMU by exec'ing the command specified by
+#     the @cpr-exec-command parameter.  The command may be a direct
+#     invocation of new QEMU, or may be a wrapper that exec's the new
+#     QEMU binary.
+#
+#     Because old QEMU terminates when new QEMU starts, one cannot
+#     stream data between the two, so the channel must be a type,
+#     such as a file, that accepts all data before old QEMU exits.
+#     Otherwise, old QEMU may quietly block writing to the channel.
+#
+#     Memory-backend objects must have the share=on attribute, but
+#     memory-backend-epc is not supported.  The VM must be started
+#     with the '-machine aux-ram-share=on' option.
+#
+#     (since 10.2)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
 
 ##
 # @ZeroPageDetection:
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index b84389f..beed392 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
 void cpr_exec_persist_state(QEMUFile *f);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 2c32e9c..8cf55a3 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -6,15 +6,21 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qemu/memfd.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
+#include "block/block-global-state.h"
+#include "qemu/main-loop.h"
 #include "migration/cpr.h"
 #include "migration/qemu-file.h"
+#include "migration/migration.h"
 #include "migration/misc.h"
 #include "migration/vmstate.h"
 #include "system/runstate.h"
+#include "trace.h"
 
 #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
 
@@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
     lseek(mfd, 0, SEEK_SET);
     return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
 }
+
+static bool preserve_fd(int fd)
+{
+    qemu_clear_cloexec(fd);
+    return true;
+}
+
+static bool unpreserve_fd(int fd)
+{
+    qemu_set_cloexec(fd);
+    return true;
+}
+
+static void cpr_exec_cb(void *opaque)
+{
+    MigrationState *s = migrate_get_current();
+    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
+    Error *err = NULL;
+
+    /*
+     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
+     * earlier because they should not persist across miscellaneous fork and
+     * exec calls that are performed during normal operation.
+     */
+    cpr_walk_fd(preserve_fd);
+
+    trace_cpr_exec();
+    execvp(argv[0], argv);
+
+    /*
+     * exec should only fail if argv[0] is bogus, or has a permissions problem,
+     * or the system is very short on resources.
+     */
+    g_strfreev(argv);
+    cpr_walk_fd(unpreserve_fd);
+
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    error_report_err(error_copy(err));
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, err);
+
+    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+
+    err = NULL;
+    if (!migration_block_activate(&err)) {
+        /* error was already reported */
+        return;
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
+        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
+        assert(s->state == MIGRATION_STATUS_COMPLETED);
+        qemu_bh_schedule(cpr_exec_bh);
+        qemu_notify_event();
+
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        cpr_exec_unpersist_state();
+    }
+    return 0;
+}
+
+void cpr_exec_init(void)
+{
+    static NotifierWithReturn exec_notifier;
+
+    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
+                                MIG_MODE_CPR_EXEC);
+}
diff --git a/migration/cpr.c b/migration/cpr.c
index d3e370e..eea3773 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     if (mode == MIG_MODE_CPR_TRANSFER) {
         g_assert(channel);
         f = cpr_transfer_output(channel, errp);
+    } else if (mode == MIG_MODE_CPR_EXEC) {
+        f = cpr_exec_output(errp);
     } else {
         return 0;
     }
@@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
         return ret;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        cpr_exec_persist_state(f);
+    }
+
     /*
      * Close the socket only partially so we can later detect when the other
      * end closes by getting a HUP event.
@@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     return 0;
 }
 
+static bool unpreserve_fd(int fd)
+{
+    qemu_set_cloexec(fd);
+    return true;
+}
+
 int cpr_state_load(MigrationChannel *channel, Error **errp)
 {
     int ret;
@@ -220,7 +232,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     QEMUFile *f;
     MigMode mode = 0;
 
-    if (channel) {
+    if (cpr_exec_has_state()) {
+        mode = MIG_MODE_CPR_EXEC;
+        f = cpr_exec_input(errp);
+        if (channel) {
+            warn_report("ignoring cpr channel for migration mode cpr-exec");
+        }
+    } else if (channel) {
         mode = MIG_MODE_CPR_TRANSFER;
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
@@ -232,6 +250,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     }
 
     trace_cpr_state_load(MigMode_str(mode));
+    cpr_set_incoming_mode(mode);
 
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_MAGIC) {
@@ -253,6 +272,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return ret;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
+        cpr_walk_fd(unpreserve_fd);
+    }
+
     /*
      * Let the caller decide when to close the socket (and generate a HUP event
      * for the sending side).
@@ -273,7 +297,7 @@ void cpr_state_close(void)
 bool cpr_incoming_needed(void *opaque)
 {
     MigMode mode = migrate_mode();
-    return mode == MIG_MODE_CPR_TRANSFER;
+    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
 }
 
 /*
diff --git a/migration/migration.c b/migration/migration.c
index 08a98f7..2515bec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -333,6 +333,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_exec_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
@@ -1796,7 +1797,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
 {
     MigMode mode = s->parameters.mode;
     return mode == MIG_MODE_CPR_REBOOT ||
-           mode == MIG_MODE_CPR_TRANSFER;
+           mode == MIG_MODE_CPR_TRANSFER ||
+           mode == MIG_MODE_CPR_EXEC;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2145,6 +2147,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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
index 7208bc1..6730a41 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
     MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
            mode == MIG_MODE_CPR_TRANSFER ||
+           mode == MIG_MODE_CPR_EXEC ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588..1aa0573 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field)
 {
     int32_t *v = pv;
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        qemu_get_sbe32s(f, v);
+        return 0;
+    }
     *v = qemu_file_get_fd(f);
     return 0;
 }
@@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field, JSONWriter *vmdesc)
 {
     int32_t *v = pv;
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        qemu_put_sbe32s(f, v);
+        return 0;
+    }
     return qemu_file_put_fd(f, *v);
 }
 
diff --git a/system/vl.c b/system/vl.c
index 4c24073..f395d04 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3867,6 +3867,8 @@ void qemu_init(int argc, char **argv)
     }
     qemu_init_displays();
     accel_setup_post(current_machine);
-    os_setup_post();
+    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
+        os_setup_post();
+    }
     resume_mux_open();
 }
diff --git a/migration/trace-events b/migration/trace-events
index 706db97..e8edd1f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
 cpr_state_load(const char *mode) "%s mode"
 cpr_transfer_input(const char *path) "%s"
 cpr_transfer_output(const char *path) "%s"
+cpr_exec(void) ""
 
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
-- 
1.8.3.1


