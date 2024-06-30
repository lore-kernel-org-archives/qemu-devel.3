Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD65C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0TG-0007Vf-BV; Sun, 30 Jun 2024 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0TD-0007VS-7o
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T9-0006PM-8u
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UIt2tQ001382;
 Sun, 30 Jun 2024 19:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=x1dv9hWX4cv1NLONXGlwM/BmSZbx5fqeVP4rekggHKw=; b=
 HdFk8IVCTdPmXQ8eNBNWYq+a/fM3/nbnDUjx8bbrzIJ/BwqnGe2TX0b6UmRCziJP
 1LHmNZv9tgvAMnicRrBHbHJkTyihsf8jwbtRNXWsTm5Z+FjWe4mmKuhNA9hcSPiR
 LrIYegWsEqPBJFmZmXaJRJOIo1Cu7FNe01SwURu3YP6PVZg9/c9ldPERXRi/qJy9
 GDL2Eb29Sw5OWpJqGbuKo4mBr0TF3GswfWZY+FTpoeN10NqZ0kWFKXxypnyuS0UG
 KiW36KAh7/2iq9BmCfso4u/8sb5suRw2Q8KaPYrC/WjmM1ytUUzBlZUMEp31we3c
 7qh5LobJLtsJnb5n/Z6jZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402att9e35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UIQkq8022828; Sun, 30 Jun 2024 19:44:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4028q5gg56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJg4fC039161;
 Sun, 30 Jun 2024 19:44:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 4028q5gg4e-7; Sun, 30 Jun 2024 19:44:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 6/6] migration: cpr-transfer mode
Date: Sun, 30 Jun 2024 12:44:08 -0700
Message-Id: <1719776648-435073-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300157
X-Proofpoint-GUID: L_XSFKqj8i95tp29-x2LZ87MWGjNHHdl
X-Proofpoint-ORIG-GUID: L_XSFKqj8i95tp29-x2LZ87MWGjNHHdl
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
 migration/cpr.c           |  9 ++++++++-
 migration/migration.c     | 37 +++++++++++++++++++++++++++++++++++++
 migration/ram.c           |  1 +
 migration/vmstate-types.c |  5 +++--
 qapi/migration.json       | 26 +++++++++++++++++++++++++-
 stubs/vmstate.c           |  7 +++++++
 6 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index 50c130c..7ac01a9 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -58,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
         VMSTATE_UINT32(namelen, CprFd),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
         VMSTATE_INT32(id, CprFd),
-        VMSTATE_INT32(fd, CprFd),
+        VMSTATE_FD(fd, CprFd),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -172,6 +172,8 @@ int cpr_state_save(Error **errp)
 
     if (mode == MIG_MODE_CPR_EXEC) {
         f = cpr_exec_output(errp);
+    } else if (mode == MIG_MODE_CPR_TRANSFER) {
+        f = cpr_transfer_output(migrate_cpr_uri(), errp);
     } else {
         return 0;
     }
@@ -209,6 +211,11 @@ int cpr_state_load(Error **errp)
      */
     if (cpr_exec_has_state()) {
         f = cpr_exec_input(errp);
+        if (cpr_uri) {
+            warn_report("ignoring cpr-uri option for migration mode cpr-exec");
+        }
+    } else if (cpr_uri) {
+        f = cpr_transfer_input(cpr_uri, errp);
     } else {
         return 0;
     }
diff --git a/migration/migration.c b/migration/migration.c
index a4a020e..65a36a6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -77,6 +77,7 @@ static NotifierWithReturnList migration_state_notifiers[MIG_MODE__MAX] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_EXEC),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
 };
 
 /* Messages sent on the return path from destination to source */
@@ -205,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
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
 
@@ -1697,6 +1704,7 @@ bool migrate_mode_is_cpr(MigrationState *s)
 {
     MigMode mode = s->parameters.mode;
     return mode == MIG_MODE_CPR_REBOOT ||
+           mode == MIG_MODE_CPR_TRANSFER ||
            mode == MIG_MODE_CPR_EXEC;
 }
 
@@ -2038,6 +2046,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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
@@ -2144,6 +2158,29 @@ void qmp_migrate(const char *uri, bool has_channels,
         goto out;
     }
 
+    /*
+     * For cpr-transfer mode, the target first reads CPR state, which cannot
+     * complete until cpr_state_save above finishes, then the target creates
+     * the migration channel and listens.  We must wait for the channel to
+     * be created before connecting to it.
+     *
+     * This implementation of waiting is a hack.  It restricts the channel
+     * type, and will loop forever if the target dies.  It should be defined
+     * as a main-loop event that calls connect on the back end.
+     */
+    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+        SocketAddress *saddr = &addr->u.socket;
+        if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX) {
+            while (access(saddr->u.fd.str, F_OK)) {
+                usleep(1000000);
+            }
+        } else {
+            error_setg(&local_err, "cpr-transfer requires a unix channel");
+            goto out;
+        }
+    }
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
diff --git a/migration/ram.c b/migration/ram.c
index 45b8f00..1e1e05e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -219,6 +219,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
     MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
            mode == MIG_MODE_CPR_EXEC ||
+           mode == MIG_MODE_CPR_TRANSFER ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 6e45a4a..618b7fb 100644
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
+    if (*v < 0 || migrate_mode() == MIG_MODE_CPR_EXEC) {
         return 0;
     }
     *v = qemu_file_get_fd(f);
@@ -334,7 +335,7 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
     int32_t *v = pv;
 
     qemu_put_sbe32s(f, v);
-    if (*v < 0) {
+    if (*v < 0 || migrate_mode() == MIG_MODE_CPR_EXEC) {
         return 0;
     }
     return qemu_file_put_fd(f, *v);
diff --git a/qapi/migration.json b/qapi/migration.json
index df62456..cd2d949 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -626,9 +626,33 @@
 #     with the '-machine anon-alloc=memfd' option.
 #
 #     (since 9.1)
+#
+# @cpr-transfer: This mode allows the user to transfer a guest to a
+#     new QEMU instance on the same host with minimal guest pause
+#     time, by preserving guest RAM in place, albeit with new virtual
+#     addresses in new QEMU.
+#
+#     The user starts new QEMU on the same host as old QEMU, with the
+#     the same arguments as old QEMU, plus the -incoming option.  The
+#     user issues the migrate command to old QEMU, which stops the VM,
+#     saves state to the migration channels, and enters the postmigrate
+#     state.  Execution resumes in new QEMU.  Guest RAM is preserved in
+#     place, albeit with new virtual addresses in new QEMU.
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
+#     (since 9.1)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-exec', 'cpr-transfer' ] }
 
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


