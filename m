Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E4AE6B27D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s17-0004ac-5x; Fri, 01 Nov 2024 09:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s15-0004Pt-5U
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s12-0002JT-JD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dg9HE026803;
 Fri, 1 Nov 2024 13:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=cisfb0ijx5L+5BrhQN+axrJq0nER1Scead8pkn2CIdc=; b=
 ZzIMCOQWR5HxwpWKbsGksnnKQJc7HxNJRPJ0z5J4tsn2NWNDtLRlh/RX94xZy32c
 cN4mtmS+gwtczkO336z2pFC10izpSw+x/FF+DgB4gp+bsIR6d9BK+kwaVaLTm2iH
 GoZuwuR4pghVvkITTi7YrA2d4agELeAcbUA0fPu4a+nc7Qsy0tFUew7gyHoOFzKE
 svkqb3nk0lPhJPooS+Vv/XtB7WhyQiJFvMTmMSDda30oLyrVWBg9D7yKYuC1MNc7
 ax2R6fyXoqg6MW8EDmqtdwLfSHkEpW/fiM0/2PewrMx4gapRke6Ct8mJxrW6qfWW
 5qMzJgjkxgShEWBde+gf2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42gryscbcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1BiUW2010024; Fri, 1 Nov 2024 13:48:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOM006031;
 Fri, 1 Nov 2024 13:48:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-12; Fri, 01 Nov 2024 13:48:33 +0000
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
Subject: [PATCH V3 11/16] migration: cpr-transfer mode
Date: Fri,  1 Nov 2024 06:47:50 -0700
Message-Id: <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
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
 definitions=main-2411010100
X-Proofpoint-ORIG-GUID: Cdb4wxuvwxbpAdGRhmqESyD3kR1aTt2j
X-Proofpoint-GUID: Cdb4wxuvwxbpAdGRhmqESyD3kR1aTt2j
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

Add the cpr-transfer migration mode.  Usage:
  qemu-system-$arch -machine anon-alloc=memfd ...

  start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"

  Issue commands to old QEMU:
  migrate_set_parameter mode cpr-transfer
  migrate_set_parameter cpr-uri <uri-2>
  migrate -d <uri-1>

The migrate command stops the VM, saves CPR state to uri-2, saves
normal migration state to uri-1, and old QEMU enters the postmigrate
state.  The user starts new QEMU on the same host as old QEMU, with the
same arguments as old QEMU, plus the -incoming option.  Guest RAM is
preserved in place, albeit with new virtual addresses in new QEMU.

This mode requires a second migration channel, specified by the
cpr-uri migration property on the outgoing side, and by the cpr-uri
QEMU command-line option on the incoming side.  The channel must
be a type, such as unix socket, that supports SCM_RIGHTS.

Memory-backend objects must have the share=on attribute, but
memory-backend-epc is not supported.  The VM must be started with
the '-machine anon-alloc=memfd' option, which allows anonymous
memory to be transferred in place to the new process.  The memfds
are kept open by sending the descriptors to new QEMU via the
cpr-uri, which must support SCM_RIGHTS, and they are mmap'd
in new QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/cpr.c           | 29 ++++++++++++++---
 migration/migration.c     | 81 +++++++++++++++++++++++++++++++++++++++++++++--
 migration/migration.h     |  2 ++
 migration/options.c       | 12 +++++--
 migration/ram.c           |  2 ++
 migration/trace-events    |  2 ++
 migration/vmstate-types.c |  1 +
 qapi/migration.json       | 35 +++++++++++++++++++-
 stubs/vmstate.c           |  7 ++++
 system/vl.c               |  6 ++++
 10 files changed, 167 insertions(+), 10 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index b72d1f4..3f3ef43 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -45,7 +45,7 @@ static const VMStateDescription vmstate_cpr_fd = {
         VMSTATE_UINT32(namelen, CprFd),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
         VMSTATE_INT32(id, CprFd),
-        VMSTATE_INT32(fd, CprFd),
+        VMSTATE_FD(fd, CprFd),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -132,9 +132,18 @@ int cpr_state_save(Error **errp)
 {
     int ret;
     QEMUFile *f;
+    MigMode mode = migrate_mode();
 
-    /* set f based on mode in a later patch in this series */
-    return 0;
+    if (mode == MIG_MODE_CPR_TRANSFER) {
+        f = cpr_transfer_output(migrate_cpr_uri(), errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
+
+    trace_cpr_state_save(MigMode_str(mode), migrate_cpr_uri());
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
@@ -162,9 +171,19 @@ int cpr_state_load(Error **errp)
     int ret;
     uint32_t v;
     QEMUFile *f;
+    MigMode mode = 0;
 
-    /* set f based on other parameters in a later patch in this series */
-    return 0;
+    if (cpr_uri) {
+        mode = MIG_MODE_CPR_TRANSFER;
+        f = cpr_transfer_input(cpr_uri, errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
+
+    trace_cpr_state_load(MigMode_str(mode), cpr_uri);
 
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_MAGIC) {
diff --git a/migration/migration.c b/migration/migration.c
index 86b3f39..5a53d01 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -76,6 +76,7 @@
 static NotifierWithReturnList migration_state_notifiers[] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
 };
 
 /* Messages sent on the return path from destination to source */
@@ -109,6 +110,7 @@ static int migration_maybe_pause(MigrationState *s,
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
+static void migrate_hup_delete(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -204,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
+        addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        error_setg(errp, "Migration requires streamable transport (eg unix)");
+        return false;
+    }
+
     return true;
 }
 
@@ -316,6 +324,7 @@ void migration_cancel(const Error *error)
         qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
     }
     migrate_fd_cancel(current_migration);
+    migrate_hup_delete(current_migration);
 }
 
 void migration_shutdown(void)
@@ -416,6 +425,7 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    cpr_set_cpr_uri(NULL);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -717,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
+
+    /* Close cpr socket to tell source that we are listening */
+    cpr_state_close();
 }
 
 static void process_incoming_migration_bh(void *opaque)
@@ -1413,6 +1426,8 @@ static void migrate_fd_cleanup(MigrationState *s)
     s->vmdesc = NULL;
 
     qemu_savevm_state_cleanup();
+    cpr_state_close();
+    migrate_hup_delete(s);
 
     close_return_path_on_source(s);
 
@@ -1573,6 +1588,8 @@ static void migrate_fd_cancel(MigrationState *s)
      */
     if (setup && !s->to_dst_file) {
         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_CANCELLED);
+        cpr_state_close();
+        migrate_hup_delete(s);
         vm_resume(s->vm_old_state);
     }
 }
@@ -1707,7 +1724,9 @@ bool migration_thread_is_self(void)
 
 bool migrate_mode_is_cpr(MigrationState *s)
 {
-    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
+    MigMode mode = s->parameters.mode;
+    return mode == MIG_MODE_CPR_REBOOT ||
+           mode == MIG_MODE_CPR_TRANSFER;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2042,6 +2061,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         return false;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
+        (!s->parameters.cpr_uri || !s->parameters.cpr_uri[0])) {
+        error_setg(errp, "cpr-transfer mode requires setting cpr-uri");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
@@ -2085,6 +2110,37 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
 static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
                                Error **errp);
 
+static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
+                            void *opaque)
+{
+        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
+        g_source_set_callback(s->hup_source, cb, opaque, NULL);
+        g_source_attach(s->hup_source, NULL);
+}
+
+static void migrate_hup_delete(MigrationState *s)
+{
+    if (s->hup_source) {
+        g_source_destroy(s->hup_source);
+        g_source_unref(s->hup_source);
+        s->hup_source = NULL;
+    }
+}
+
+static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
+                                      GIOCondition cond,
+                                      void *opaque)
+{
+    MigrationAddress *addr = opaque;
+
+    qmp_migrate_finish(addr, false, NULL);
+
+    cpr_state_close();
+    migrate_hup_delete(migrate_get_current());
+    qapi_free_MigrationAddress(addr);
+    return G_SOURCE_REMOVE;
+}
+
 void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
@@ -2131,8 +2187,29 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    qmp_migrate_finish(addr, resume_requested, errp);
+    if (cpr_state_save(&local_err)) {
+        goto out;
+    }
 
+    /*
+     * For cpr-transfer, the target may not be listening yet on the migration
+     * channel, because first it must finish cpr_load_state.  The target tells
+     * us it is listening by closing the cpr-state socket.  Wait for that HUP
+     * event before connecting in qmp_migrate_finish.
+     *
+     * The HUP could occur because the target fails while reading CPR state,
+     * in which case the target will not listen for the incoming migration
+     * connection, so qmp_migrate_finish will fail to connect, and then recover.
+     */
+    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
+                        QAPI_CLONE(MigrationAddress, addr));
+
+    } else {
+        qmp_migrate_finish(addr, resume_requested, errp);
+    }
+
+out:
     if (local_err) {
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
diff --git a/migration/migration.h b/migration/migration.h
index 38aa140..74c167b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -457,6 +457,8 @@ struct MigrationState {
     bool switchover_acked;
     /* Is this a rdma migration */
     bool rdma_migration;
+
+    GSource *hup_source;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index 82de1d8..3733bc9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -747,9 +748,16 @@ uint64_t migrate_max_postcopy_bandwidth(void)
 
 MigMode migrate_mode(void)
 {
-    MigrationState *s = migrate_get_current();
-    MigMode mode = s->parameters.mode;
+    MigMode mode;
 
+    /*
+     * cpr_uri is only set during the early cpr-transfer loading stage,
+     * after which it is cleared.
+     */
+    if (cpr_get_cpr_uri()) {
+        return MIG_MODE_CPR_TRANSFER;
+    }
+    mode = migrate_get_current()->parameters.mode;
     assert(mode >= 0 && mode < MIG_MODE__MAX);
     return mode;
 }
diff --git a/migration/ram.c b/migration/ram.c
index 326ce7e..bafe41b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -216,7 +216,9 @@ static bool postcopy_preempt_active(void)
 
 bool migrate_ram_is_ignored(RAMBlock *block)
 {
+    MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
+           mode == MIG_MODE_CPR_TRANSFER ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/migration/trace-events b/migration/trace-events
index 345506b..455dec5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -347,6 +347,8 @@ colo_failover_set_state(const char *new_state) "new state %s"
 cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
 cpr_delete_fd(const char *name, int id) "%s, id %d"
 cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
+cpr_state_save(const char *mode, const char *uri) "%s to %s"
+cpr_state_load(const char *mode, const char *uri) "%s from %s"
 
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index f31deb3..2210f0c 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -15,6 +15,7 @@
 #include "qemu-file.h"
 #include "migration.h"
 #include "migration/vmstate.h"
+#include "migration/client-options.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "trace.h"
diff --git a/qapi/migration.json b/qapi/migration.json
index 5bf3e49..3328d1b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -614,9 +614,42 @@
 #     or COLO.
 #
 #     (since 8.2)
+#
+# @cpr-transfer: This mode allows the user to transfer a guest to a
+#     new QEMU instance on the same host with minimal guest pause
+#     time, by preserving guest RAM in place, albeit with new virtual
+#     addresses in new QEMU.
+#
+#     The user starts new QEMU on the same host as old QEMU, with the
+#     the same arguments as old QEMU, plus the -incoming option.  The
+#     user issues the migrate command to old QEMU, which stops the VM,
+#     saves state to the migration channels, and enters the
+#     postmigrate state.  Execution resumes in new QEMU.
+#
+#     This mode requires a second migration channel, specified by the
+#     cpr-uri migration property on the outgoing side, and by the
+#     cpr-uri QEMU command-line option on the incoming side.  The
+#     channel must be a type, such as unix socket, that supports
+#     SCM_RIGHTS.
+#
+#     Memory-backend objects must have the share=on attribute, but
+#     memory-backend-epc and memory-backend-ram are not supported.
+#     The VM must be started with the '-machine anon-alloc=memfd'
+#     option.
+#
+#     The incoming migration channel cannot be a file type, and for
+#     the tcp type, the port cannot be 0 (meaning dynamically choose
+#     a port).
+#
+#     When using -incoming defer, you must issue the migrate command
+#     to old QEMU before issuing any monitor commands to new QEMU.
+#     However, new QEMU does not open and read the migration stream
+#     until you issue the migrate incoming command.
+#
+#     (since 9.2)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
 
 ##
 # @ZeroPageDetection:
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 8513d92..c190762 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,5 +1,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
+#include "qapi/qapi-types-migration.h"
+#include "migration/client-options.h"
 
 int vmstate_register_with_alias_id(VMStateIf *obj,
                                    uint32_t instance_id,
@@ -21,3 +23,8 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     return true;
 }
+
+MigMode migrate_mode(void)
+{
+    return MIG_MODE_NORMAL;
+}
diff --git a/system/vl.c b/system/vl.c
index 5d08fade..9bd0e33 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3714,6 +3714,12 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
+    /*
+     * Load incoming CPR state before any devices are created, because it
+     * contains file descriptors that are needed in device initialization code.
+     */
+    cpr_state_load(&error_fatal);
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
-- 
1.8.3.1


