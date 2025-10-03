Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7076BCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hvA-0005WL-K3; Fri, 03 Oct 2025 11:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hut-0005Pu-1J
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hu2-0007lO-1y
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdVi/cBHUA+PtA8NtD+4Wqw4Dg6djfpxshDc3YG4eEY=;
 b=GQLUwqXz993at9YYTMlQMeMIRNmHP2LDqicmPAMyEG1p/UbBIOaIhyzwmyNvzGl3PVyROq
 Xd1GXOtf6OXdz3GGVuXtoFsBqy3t+rmwTtcarwAM2G04pYOsTBtRKI1BqzcrblPrSgSudW
 JzUwKjXLfOd8A4CeCJ9Itq2mixrsRsA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Q25rLNAjMCaHYfSkQdDSHg-1; Fri, 03 Oct 2025 11:40:53 -0400
X-MC-Unique: Q25rLNAjMCaHYfSkQdDSHg-1
X-Mimecast-MFC-AGG-ID: Q25rLNAjMCaHYfSkQdDSHg_1759506053
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so48273576d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506053; x=1760110853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdVi/cBHUA+PtA8NtD+4Wqw4Dg6djfpxshDc3YG4eEY=;
 b=Ne452wsAD3NrHgeMXPqsV7b5ONA9lsqh1XV50eTFac9v3DFiwXxWgtrLkPqnOrFK/D
 30+gxu5323sTTXbrdkbT1YqhfIIItx/bku2DpPKgjIO3Ur4vBlhTX4mzAu+ocfZOTDr1
 xqhLXP6DNtr+XnVkyCY633pXUHWFIFv0+5EeClMkvTvr2aBCOjTc52gSYd/4TvgabyeF
 Q1CHldrvWQNzZgM8EfAp4RfmedHCbvHrTRMJx6H2TybIRAplrbHt5mqJ53Atqf8Rr7F5
 8BpaoT90rA6INt1ujKanuEQzw8Q/fSkbeEFdW+zwe2+/yMr45LpLo/OluUCBegRHb9Ma
 kpqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkh8KxKTCvZaoTRBwV0FZcNE0HtD1M2KC8E59og0QE9gyBgvLJyTR7htMhZgGyaIAFnHPKgn2Vd2gN@nongnu.org
X-Gm-Message-State: AOJu0YxoBJs+N6OuTL5NaoUi2ro45XUHsAkw8LFJJKY+4CQDLVMVkDLA
 Pa4j5ZD52CyXBUhHF3zP4ot2nrOjuogc14jH0Ixjv+cepfaiZRDJMerF7fnSqgAjiOMq3CnlcYk
 0NSa7Fl07jMq1g24nWdhBUqdTVcKtFUA3yhVjDEfW3LMDAMsxVmJKsaET
X-Gm-Gg: ASbGncu0KibhNuTJKQDaMbG3jnOTiacO3rScnBiHJ9qsSfUAvhd+y40A6n92Wjy8yez
 kCt/Ra7Cqhh+W1uK0BCMjKjR9MeXLfGl2UCX1oOGoB3e+i6Xvo6aUQRGVsQ5jFzqoCWsnZMVaPy
 3gEjYFLxRa10t0Da9eK/qPQNQdP2J/hguKNjUNzQufXP1+oFARe69wGj/MD8QtZJTtLshJAKVfL
 4dZ3kd8kVPxRlKKq3r1HWqPOfqk7nPdHH1qWeoxgLD/fOR9iSNHqXIY2Vto4166M0XoiWHJFm8u
 HXI15ANtUAsy8Lgnlu92xBGlkO0ae4k5EqlYDw==
X-Received: by 2002:a05:6214:2461:b0:786:547:4946 with SMTP id
 6a1803df08f44-879dc7c8b32mr47251176d6.30.1759506051808; 
 Fri, 03 Oct 2025 08:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxes8mKMqSJsbCQxsc7sB4CFWXNwk8PKu/sNyHU9yeuYfaYb+1/ucLYLZScW9WOv2WFCyr8A==
X-Received: by 2002:a05:6214:2461:b0:786:547:4946 with SMTP id
 6a1803df08f44-879dc7c8b32mr47250776d6.30.1759506051259; 
 Fri, 03 Oct 2025 08:40:51 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 42/45] migration: cpr-exec mode
Date: Fri,  3 Oct 2025 11:39:45 -0400
Message-ID: <20251003153948.1304776-43-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

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
Link: https://lore.kernel.org/r/1759332851-370353-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json       | 25 ++++++++++-
 include/migration/cpr.h   |  2 +
 migration/cpr-exec.c      | 95 +++++++++++++++++++++++++++++++++++++++
 migration/cpr.c           | 23 +++++++++-
 migration/migration.c     | 10 ++++-
 migration/ram.c           |  1 +
 migration/vmstate-types.c |  8 ++++
 system/vl.c               |  4 +-
 migration/trace-events    |  1 +
 9 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2be8fa1d16..be0f3fcc12 100644
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
index b84389ff04..a412d6663c 100644
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
index 81d84425e1..d57714bc5d 100644
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
 
@@ -97,3 +103,92 @@ QEMUFile *cpr_exec_input(Error **errp)
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
index 6feda78f1b..22dbac7c72 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-device.h"
@@ -186,6 +187,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
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
@@ -252,6 +266,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
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
@@ -272,7 +291,7 @@ void cpr_state_close(void)
 bool cpr_incoming_needed(void *opaque)
 {
     MigMode mode = migrate_mode();
-    return mode == MIG_MODE_CPR_TRANSFER;
+    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
 }
 
 /*
diff --git a/migration/migration.c b/migration/migration.c
index a399735f02..a63b46bbef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -333,6 +333,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_exec_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
@@ -1807,7 +1808,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
 {
     MigMode mode = s->parameters.mode;
     return mode == MIG_MODE_CPR_REBOOT ||
-           mode == MIG_MODE_CPR_TRANSFER;
+           mode == MIG_MODE_CPR_TRANSFER ||
+           mode == MIG_MODE_CPR_EXEC;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2156,6 +2158,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
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
index a8e8d2cc67..9aac89638a 100644
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
index a1cd7a95fa..4b01dc19c2 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -322,6 +322,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
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
@@ -330,6 +334,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
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
index 00f3694725..646239e4a6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3837,6 +3837,8 @@ void qemu_init(int argc, char **argv)
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
index 706db97def..e8edd1fbba 100644
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
2.50.1


