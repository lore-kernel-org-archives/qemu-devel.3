Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22A0CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbaD-0005bj-Fa; Thu, 14 Aug 2025 13:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba9-0005V1-75
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba6-0002qi-3o
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgBrB006019;
 Thu, 14 Aug 2025 17:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4h8yjVxm5V5qDbXCr9fWVxE1SakDrlIXzE/XZTxOEg4=; b=
 TV1Lwlqi/WJdWH2fXXIqI5+LSQTVc5myK1CDKho6adzpkFN7ykmKQslgIofRhmjT
 jqSX5cKNZ1GUmlFRRKSnpwd+3WX/FpJ102mbMmRNn46hM4dXF0LCNXIW1Frq6/Pk
 iNxzyo9K8jkxzHC8WsJF+SdYOV0SExZozYewpaMn0NY5yCPd3OqWMSulOrSgcrlu
 fThgg+ivNV2n/SEYn8BiZ47Javq5rdS+PBdCgWHwbfW7Gf0GfI1GgGx1nOfmttYp
 otQVtmG8ny9DrRO/OnC2VHTa1bKCq604TJBhhMsYHC2z5oTTXrCDY52siuBz2yjT
 Hxnbj6kcFhWJ112F7sVACQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ejfd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EFXjc9009866; Thu, 14 Aug 2025 17:17:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuK038225;
 Thu, 14 Aug 2025 17:17:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-8; Thu, 14 Aug 2025 17:17:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 7/9] migration: cpr-exec mode
Date: Thu, 14 Aug 2025 10:17:21 -0700
Message-Id: <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-GUID: Eqqdp1VOXOzUFEMU2TEIOqLNa7ZZXKoX
X-Proofpoint-ORIG-GUID: Eqqdp1VOXOzUFEMU2TEIOqLNa7ZZXKoX
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689e1a2f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=V5tUqp5okAFojsnLb_sA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX4Dn9fBl6XwPj
 6o+HYqRvnjyLjrR/r15MfHeRXP9OYDMx+xDd/XxwdNthz17U9kdpUg16apqonSHjDsbXNZ7Xecf
 wsnf2hwT+y1bCKH4CMRksgWMuV9BvEh/mdIKTerpVcXSuymZ2nTX8+TjPCpo8IBnTrqKl1XgHF9
 GesREVYrwxWaGLx9dRNsEI17vJPEmkFWPYp1fkCNQ+Lm1pgaw7zPkHgNuj5i0tZ2rPmWghDyZ5l
 bn/74OgsqNDuWWiD8nmuEXYoa8Zupk5tkPjuJ6Ep2gz/fCKbfYXC0CUes6ZnBV64qCHT9S1WsoX
 N99CllniqG55hZDgxKVmB8/e94/+LxVE9GZT23D0DNskeDvkHf+Z9dDDfRKu3GelAKO0h1dWiW6
 zg+zgr0RHPd4mPh9JsPmpsbibRaoqb2ILXjyDo02VINaG89Zw1OcRVFEBmEBx8zRJMWw7CPD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 qapi/migration.json       | 25 +++++++++++++++-
 include/migration/cpr.h   |  1 +
 migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c           | 26 ++++++++++++++++-
 migration/migration.c     | 10 ++++++-
 migration/ram.c           |  1 +
 migration/vmstate-types.c |  8 +++++
 migration/trace-events    |  1 +
 8 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index ea410fd..cbc90e8 100644
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
index aaeec02..e99e48e 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -54,6 +54,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
 void cpr_exec_persist_state(QEMUFile *f);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 2c32e9c..7d0429f 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -6,15 +6,20 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qemu/memfd.h"
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
 #include "system/runstate.h"
+#include "trace.h"
 
 #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
 
@@ -92,3 +97,72 @@ QEMUFile *cpr_exec_input(Error **errp)
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
+    cpr_walk_fd(preserve_fd);
+
+    trace_cpr_exec();
+    execvp(argv[0], argv);
+
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
+        assert(s->state == MIGRATION_STATUS_COMPLETED);
+        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
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
index 021bd6a..2078d05 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -198,6 +198,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     if (mode == MIG_MODE_CPR_TRANSFER) {
         g_assert(channel);
         f = cpr_transfer_output(channel, errp);
+    } else if (mode == MIG_MODE_CPR_EXEC) {
+        f = cpr_exec_output(errp);
     } else {
         return 0;
     }
@@ -215,6 +217,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
         return ret;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
+        cpr_exec_persist_state(f);
+    }
+
     /*
      * Close the socket only partially so we can later detect when the other
      * end closes by getting a HUP event.
@@ -226,6 +232,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
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
@@ -237,6 +249,12 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         mode = MIG_MODE_CPR_TRANSFER;
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
+    } else if (cpr_exec_has_state()) {
+        mode = MIG_MODE_CPR_EXEC;
+        f = cpr_exec_input(errp);
+        if (channel) {
+            warn_report("ignoring cpr channel for migration mode cpr-exec");
+        }
     } else {
         return 0;
     }
@@ -245,6 +263,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     }
 
     trace_cpr_state_load(MigMode_str(mode));
+    cpr_set_incoming_mode(mode);
 
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_MAGIC) {
@@ -266,6 +285,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
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
@@ -286,7 +310,7 @@ void cpr_state_close(void)
 bool cpr_incoming_needed(void *opaque)
 {
     MigMode mode = migrate_mode();
-    return mode == MIG_MODE_CPR_TRANSFER;
+    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
 }
 
 /*
diff --git a/migration/migration.c b/migration/migration.c
index 271c521..d604284 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -333,6 +333,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_exec_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
@@ -1797,7 +1798,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
 {
     MigMode mode = s->parameters.mode;
     return mode == MIG_MODE_CPR_REBOOT ||
-           mode == MIG_MODE_CPR_TRANSFER;
+           mode == MIG_MODE_CPR_TRANSFER ||
+           mode == MIG_MODE_CPR_EXEC;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2146,6 +2148,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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


