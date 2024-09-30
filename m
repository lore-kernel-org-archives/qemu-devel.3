Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40800CDD1A9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGw-0008Rw-Sx; Mon, 30 Sep 2024 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGu-0008HI-0E
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGr-000237-Dt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuZPj012968;
 Mon, 30 Sep 2024 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=csvpu3r/bw0LJzy/7jC0nAjTs/IOMAKbwtz+BIp/kxE=; b=
 ILCOX3R4Vz3P/bHEbxQ+Cu4RqQazC9HUlP6zxWyMwsx6aK/hpfU703CbkAd8s/Jf
 lbLYSpUG8sDaxPcD8UB4S6R0UrpQ61Z5i0xR5F6WN1MhUznZUsD1O8uPhxHkif38
 ZNsMtaozyRCqSs+1QiChR9O/9E6CmMHrw6+vmTVGTwZT/6tf49QjI6IgQuxdTmdD
 Hl4tGfpr/w/MGLXPC0k3Id93OyaW8lYxn3/Jv+BTz9vg5grvCtCdf2PKQjJ6ScH6
 RDhPGftsjTHqmytgfTcyKBqM1Uq2lNmUN2TP2FsfaVwmiiwkxDAZfK4VQUxhiq9t
 GOefRpEb8Y060Goyat9OWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9mgc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UJ116F012569; Mon, 30 Sep 2024 19:41:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868u4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepVA028204;
 Mon, 30 Sep 2024 19:41:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-14; Mon, 30 Sep 2024 19:41:09 +0000
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
Subject: [PATCH V2 13/13] migration: cpr-transfer mode
Date: Mon, 30 Sep 2024 12:40:44 -0700
Message-Id: <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: AX4iBxfBYcZySMn5hXb0lgCagW8jLHQn
X-Proofpoint-GUID: AX4iBxfBYcZySMn5hXb0lgCagW8jLHQn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/migration/cpr.h   |  1 +
 migration/cpr.c           | 34 +++++++++++++++++++----
 migration/migration.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++--
 migration/migration.h     |  2 ++
 migration/ram.c           |  2 ++
 migration/vmstate-types.c |  5 ++--
 qapi/migration.json       | 27 ++++++++++++++++++-
 stubs/vmstate.c           |  7 +++++
 8 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index e886c98..5cd373f 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -30,6 +30,7 @@ int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
+bool cpr_needed_for_reuse(void *opaque);
 
 QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
 QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 86f66c1..911b556 100644
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
@@ -57,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
         VMSTATE_UINT32(namelen, CprFd),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
         VMSTATE_INT32(id, CprFd),
-        VMSTATE_INT32(fd, CprFd),
+        VMSTATE_FD(fd, CprFd),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -174,9 +175,16 @@ int cpr_state_save(Error **errp)
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
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
@@ -205,8 +213,18 @@ int cpr_state_load(Error **errp)
     uint32_t v;
     QEMUFile *f;
 
-    /* set f based on mode in a later patch in this series */
-    return 0;
+    /*
+     * Mode will be loaded in CPR state, so cannot use it to decide which
+     * form of state to load.
+     */
+    if (cpr_uri) {
+        f = cpr_transfer_input(cpr_uri, errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
 
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_MAGIC) {
@@ -243,3 +261,9 @@ void cpr_state_close(void)
         cpr_state_file = NULL;
     }
 }
+
+bool cpr_needed_for_reuse(void *opaque)
+{
+    MigMode mode = migrate_mode();
+    return mode == MIG_MODE_CPR_TRANSFER;
+}
diff --git a/migration/migration.c b/migration/migration.c
index 3301583..73b85aa 100644
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
@@ -718,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
+
+    /* Close cpr socket to tell source that we are listening */
+    cpr_state_close();
 }
 
 static void process_incoming_migration_bh(void *opaque)
@@ -1414,6 +1426,8 @@ static void migrate_fd_cleanup(MigrationState *s)
     s->vmdesc = NULL;
 
     qemu_savevm_state_cleanup();
+    cpr_state_close();
+    migrate_hup_delete(s);
 
     close_return_path_on_source(s);
 
@@ -1698,7 +1712,9 @@ bool migration_thread_is_self(void)
 
 bool migrate_mode_is_cpr(MigrationState *s)
 {
-    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
+    MigMode mode = s->parameters.mode;
+    return mode == MIG_MODE_CPR_REBOOT ||
+           mode == MIG_MODE_CPR_TRANSFER;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2033,6 +2049,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         return false;
     }
 
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
+        !s->parameters.cpr_uri) {
+        error_setg(errp, "cpr-transfer mode requires setting cpr-uri");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
@@ -2076,6 +2098,37 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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
@@ -2136,7 +2189,19 @@ void qmp_migrate(const char *uri, bool has_channels,
         goto out;
     }
 
-    qmp_migrate_finish(addr, resume_requested, errp);
+    /*
+     * For cpr-transfer, the target may not be listening yet on the migration
+     * channel, because first it must finish cpr_load_state.  The target tells
+     * us it is listening by closing the cpr-state socket.  Wait for that HUP
+     * event before connecting in qmp_migrate_finish.
+     */
+    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
+                        QAPI_CLONE(MigrationAddress, addr));
+
+    } else {
+        qmp_migrate_finish(addr, resume_requested, errp);
+    }
 
 out:
     if (local_err) {
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
diff --git a/migration/ram.c b/migration/ram.c
index 81eda27..e2cef50 100644
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
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 6e45a4a..b5a55b8 100644
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
@@ -321,7 +322,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
 {
     int32_t *v = pv;
     qemu_get_sbe32s(f, v);
-    if (*v < 0) {
+    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
         return 0;
     }
     *v = qemu_file_get_fd(f);
@@ -334,7 +335,7 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
     int32_t *v = pv;
 
     qemu_put_sbe32s(f, v);
-    if (*v < 0) {
+    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
         return 0;
     }
     return qemu_file_put_fd(f, *v);
diff --git a/qapi/migration.json b/qapi/migration.json
index c0d8bcc..f51b4cb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -611,9 +611,34 @@
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
+#     postmigrate state.  Execution resumes in new QEMU.  Guest RAM is
+#     preserved in place, albeit with new virtual addresses in new
+#     QEMU.  The incoming migration channel cannot be a file type.
+#
+#     This mode requires a second migration channel, specified by the
+#     cpr-uri migration property on the outgoing side, and by
+#     the cpr-uri QEMU command-line option on the incoming
+#     side.  The channel must be a type, such as unix socket, that
+#     supports SCM_RIGHTS.
+#
+#     Memory-backend objects must have the share=on attribute, but
+#     memory-backend-epc is not supported.  The VM must be started
+#     with the '-machine anon-alloc=memfd' option.
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
-- 
1.8.3.1


