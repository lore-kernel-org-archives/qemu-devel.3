Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yr4-00059l-Nu; Wed, 01 Oct 2025 11:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yql-0004Hd-M3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqX-0006QC-4x
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMjnL022670;
 Wed, 1 Oct 2025 15:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4edrD0sBeQIujxDqM6RK89EPYcxKr67jW4zXh/e605s=; b=
 hacYUa5cMP5499BxpZWlwj0iO5Qcgknido56zq53bFTpFEhXp9VheLQBIvy53gr+
 tbYGl+ojFcSQ2YLRX3oG0XbRGZs5uQeE2DxmGAl7IetFu0IdsrupONrECcfESvXX
 TSsFg9qLzV4cI67ANfLukC3FubI991kiY1scNddJciSAPTPDdPkJgkysjloTxdda
 iOe+FVmxcRoU0dnPVPVZG6PknRzzF04yBi3RZpTrbtM0x2D2qtPYc/zUkhQTIALD
 JBMNICXzW4okLlO9IlU0N2KK3Ot2mUNloRcrhbwUHeLD3TkwumGiJlbDPkHy0Bhu
 7U9a6/eAr/POi4FRHSuUkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bhqvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmWsa023147; Wed, 1 Oct 2025 15:34:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqo014790;
 Wed, 1 Oct 2025 15:34:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-7; Wed, 01 Oct 2025 15:34:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 06/19] migration: cpr-exec mode
Date: Wed,  1 Oct 2025 08:33:58 -0700
Message-Id: <1759332851-370353-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: RCM8GLOuMaHMyZagBjfVc9PAN5cLRuTg
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd49fa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=jH6umg94fvhmFQBqOokA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX70t8IioaMoQk
 m0FAZquT4+5cwu0m420My+EbPdHAZ3P/gIE/4Cnkpg3NZ+0D3PNQgIthEHRKCcVyWv2z6Hjt89l
 K1MudnArYnwUYVXl2eBTusnt5l60jvTmz3g2PGsLNA8yOo2pJfdRwoZnLL5LM9I3aa+t6Tig/uE
 Mz0aC/uteABliLUcTEPJLNfI8XTDqBy3+Q6asPLQAzXC5DxaaUOcWTb3GnasifPepUNr/fMOCjZ
 FaYxEcXxzeaCi+0shp5XfePBESq1wnXy3zEhxzV1O3dHENIIZC0LwAz+Lqc+DLIckckOZvAlABr
 AtrVchTgMvKUc8sb5wlMhjfgbU2bSxqSVEqzQohtvVfeelJ9eyDOTD0rYBe6+28CBBu6uUhLIZl
 LGVa1RiMyhOjomoa+8EEoaJbe8F5IA==
X-Proofpoint-ORIG-GUID: RCM8GLOuMaHMyZagBjfVc9PAN5cLRuTg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 qapi/migration.json       | 25 ++++++++++++-
 include/migration/cpr.h   |  2 +
 migration/cpr-exec.c      | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c           | 23 +++++++++++-
 migration/migration.c     | 10 ++++-
 migration/ram.c           |  1 +
 migration/vmstate-types.c |  8 ++++
 system/vl.c               |  4 +-
 migration/trace-events    |  1 +
 9 files changed, 164 insertions(+), 5 deletions(-)

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
index b84389f..a412d66 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -53,9 +53,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
 void cpr_exec_persist_state(QEMUFile *f);
 bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
+void cpr_exec_unpreserve_fds(void);
 #endif
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 9b54eab..8b12ba9 100644
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
 
@@ -91,3 +97,92 @@ QEMUFile *cpr_exec_input(Error **errp)
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
+static void cpr_exec_preserve_fds(void)
+{
+    cpr_walk_fd(preserve_fd);
+}
+
+void cpr_exec_unpreserve_fds(void)
+{
+    cpr_walk_fd(unpreserve_fd);
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
+    cpr_exec_preserve_fds();
+
+    trace_cpr_exec();
+    execvp(argv[0], argv);
+
+    /*
+     * exec should only fail if argv[0] is bogus, or has a permissions problem,
+     * or the system is very short on resources.
+     */
+    g_strfreev(argv);
+    cpr_exec_unpreserve_fds();
+
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    error_report_err(error_copy(err));
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, err);
+
+    /* Note, we can go from state COMPLETED to FAILED */
+    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+
+    err = NULL;
+    if (!migration_block_activate(&err)) {
+        /* error was already reported */
+        error_free(err);
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
index d3e370e..afadf69 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
@@ -185,6 +186,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     if (mode == MIG_MODE_CPR_TRANSFER) {
         g_assert(channel);
         f = cpr_transfer_output(channel, errp);
+    } else if (mode == MIG_MODE_CPR_EXEC) {
+        f = cpr_exec_output(errp);
     } else {
         return 0;
     }
@@ -202,6 +205,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
         return ret;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        cpr_exec_persist_state(f);
+    }
+
     /*
      * Close the socket only partially so we can later detect when the other
      * end closes by getting a HUP event.
@@ -220,7 +227,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
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
@@ -232,6 +245,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     }
 
     trace_cpr_state_load(MigMode_str(mode));
+    cpr_set_incoming_mode(mode);
 
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_MAGIC) {
@@ -253,6 +267,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return ret;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
+        cpr_exec_unpreserve_fds();
+    }
+
     /*
      * Let the caller decide when to close the socket (and generate a HUP event
      * for the sending side).
@@ -273,7 +292,7 @@ void cpr_state_close(void)
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


