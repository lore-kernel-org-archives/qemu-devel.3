Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6D0C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWS-0004La-RJ; Wed, 29 Jan 2025 11:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVf-0003J4-Hb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVa-0005Ik-1n
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:45 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5A491F383;
 Wed, 29 Jan 2025 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPTgO9qfqtFHHdsTFt9buHaJRm0RpRZ+idKcpCjruXI=;
 b=uC8m99O9E+rz86CLEOwb6TcpiYRQNS1Fy71/FLydQ0Sj9HlvWHvBQuPLCRluqfPDMxKXRN
 xhEGwE5T/9yAjSYVeivSv9i6dx7IhKZS/aFX9Wr7kZlDPJbtGCMMYyIZch4TinltSX6Zpd
 NxPJy56iujmIw3zwSDGRIXlNzGcCtg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPTgO9qfqtFHHdsTFt9buHaJRm0RpRZ+idKcpCjruXI=;
 b=KmuCR2QJkZb+0m70+PmA5XDHjPV4uhCV8PYI4Fm5JJli3sLocJpYxyCrywpXQ6NLNXRlDC
 zV3Qf8mxvELfYGBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPTgO9qfqtFHHdsTFt9buHaJRm0RpRZ+idKcpCjruXI=;
 b=xcCHkykRpIddWn8u3CowzhtRvfkTHdHnx62WWf6dLLJnKgrpfuKQ7eYj8nSYAsvpiI6bWV
 nh6Q6zRlCII8wwyJMyetBYCC1ONuRzH1/ugyEJ16tRmM/T4rFTMa2NGzkSy2cabwHgReJc
 jT2Pq2zyuxFe9WQi7NTXxrl01nBw/zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPTgO9qfqtFHHdsTFt9buHaJRm0RpRZ+idKcpCjruXI=;
 b=f0xQey3sZtW7FG1zPAm/Pm6Kq6L+xEAMBVMd1fvjhRZyilef4qdtDXE+V41hbUgzyCqZls
 kfEh7DZnHflaHZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6170413AA6;
 Wed, 29 Jan 2025 16:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OEL1CONQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 17/42] migration: cpr-transfer mode
Date: Wed, 29 Jan 2025 13:00:34 -0300
Message-Id: <20250129160059.6987-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Add the cpr-transfer migration mode, which allows the user to transfer
a guest to a new QEMU instance on the same host with minimal guest pause
time, by preserving guest RAM in place, albeit with new virtual addresses
in new QEMU, and by preserving device file descriptors.  Pages that were
locked in memory for DMA in old QEMU remain locked in new QEMU, because the
descriptor of the device that locked them remains open.

cpr-transfer preserves memory and devices descriptors by sending them to
new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
be sent over the normal migration channel, because devices and backends
are created prior to reading the channel, so this mode sends CPR state
over a second "cpr" migration channel.  New QEMU reads the cpr channel
prior to creating devices or backends.  The user specifies the cpr channel
in the channel arguments on the outgoing side, and in a second -incoming
command-line parameter on the incoming side.

The user must start old QEMU with the the '-machine aux-ram-share=on' option,
which allows anonymous memory to be transferred in place to the new process
by transferring a memory descriptor for each ram block.  Memory-backend
objects must have the share=on attribute, but memory-backend-epc is not
supported.

The user starts new QEMU on the same host as old QEMU, with command-line
arguments to create the same machine, plus the -incoming option for the
main migration channel, like normal live migration.  In addition, the user
adds a second -incoming option with channel type "cpr".  This CPR channel
must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
UNIX domain socket.

To initiate CPR, the user issues a migrate command to old QEMU, adding
a second migration channel of type "cpr" in the channels argument.
Old QEMU stops the VM, saves state to the migration channels, and enters
the postmigrate state.  New QEMU mmap's memory descriptors, and execution
resumes.

The implementation splits qmp_migrate into start and finish functions.
Start sends CPR state to new QEMU, which responds by closing the CPR
channel.  Old QEMU detects the HUP then calls finish, which connects the
main migration channel.

In summary, the usage is:

  qemu-system-$arch -machine aux-ram-share=on ...

  start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"

  Issue commands to old QEMU:
    migrate_set_parameter mode cpr-transfer

    {"execute": "migrate", ...
        {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-17-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h   |   5 ++
 migration/cpr.c           |  36 +++++++++++--
 migration/migration.c     | 106 +++++++++++++++++++++++++++++++++++++-
 migration/migration.h     |   2 +
 migration/options.c       |   8 ++-
 migration/ram.c           |   2 +
 migration/vmstate-types.c |   1 +
 qapi/migration.json       |  44 +++++++++++++++-
 qemu-options.hx           |   2 +
 stubs/vmstate.c           |   7 +++
 system/vl.c               |   7 +++
 11 files changed, 210 insertions(+), 10 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index c669b8b8a3..3a6deb7933 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -10,6 +10,8 @@
 
 #include "qapi/qapi-types-migration.h"
 
+#define MIG_MODE_NONE           -1
+
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
 
@@ -17,6 +19,9 @@ void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 
+MigMode cpr_get_incoming_mode(void);
+void cpr_set_incoming_mode(MigMode mode);
+
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 87bcfdb5ff..584b0b98f7 100644
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
@@ -116,6 +116,18 @@ QIOChannel *cpr_state_ioc(void)
     return qemu_file_get_ioc(cpr_state_file);
 }
 
+static MigMode incoming_mode = MIG_MODE_NONE;
+
+MigMode cpr_get_incoming_mode(void)
+{
+    return incoming_mode;
+}
+
+void cpr_set_incoming_mode(MigMode mode)
+{
+    incoming_mode = mode;
+}
+
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
@@ -124,8 +136,14 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
 
     trace_cpr_state_save(MigMode_str(mode));
 
-    /* set f based on mode in a later patch in this series */
-    return 0;
+    if (mode == MIG_MODE_CPR_TRANSFER) {
+        f = cpr_transfer_output(channel, errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
@@ -155,8 +173,16 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     QEMUFile *f;
     MigMode mode = 0;
 
-    /* set f and mode based on other parameters later in this patch series */
-    return 0;
+    if (channel) {
+        mode = MIG_MODE_CPR_TRANSFER;
+        cpr_set_incoming_mode(mode);
+        f = cpr_transfer_input(channel, errp);
+    } else {
+        return 0;
+    }
+    if (!f) {
+        return -1;
+    }
 
     trace_cpr_state_load(MigMode_str(mode));
 
diff --git a/migration/migration.c b/migration/migration.c
index 5f2540fac3..88b09914ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -77,6 +77,7 @@
 static NotifierWithReturnList migration_state_notifiers[] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
 };
 
 /* Messages sent on the return path from destination to source */
@@ -110,6 +111,7 @@ static int migration_maybe_pause(MigrationState *s,
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
+static void migrate_hup_delete(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -220,6 +222,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
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
 
@@ -435,6 +443,7 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    cpr_set_incoming_mode(MIG_MODE_NONE);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -747,6 +756,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
+
+    /* Close cpr socket to tell source that we are listening */
+    cpr_state_close();
 }
 
 static void process_incoming_migration_bh(void *opaque)
@@ -1423,6 +1435,8 @@ static void migrate_fd_cleanup(MigrationState *s)
     s->vmdesc = NULL;
 
     qemu_savevm_state_cleanup();
+    cpr_state_close();
+    migrate_hup_delete(s);
 
     close_return_path_on_source(s);
 
@@ -1534,6 +1548,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
 static void migrate_fd_cancel(MigrationState *s)
 {
     int old_state ;
+    bool setup = (s->state == MIGRATION_STATUS_SETUP);
 
     trace_migrate_fd_cancel();
 
@@ -1568,6 +1583,17 @@ static void migrate_fd_cancel(MigrationState *s)
             }
         }
     }
+
+    /*
+     * If qmp_migrate_finish has not been called, then there is no path that
+     * will complete the cancellation.  Do it now.
+     */
+    if (setup && !s->to_dst_file) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
+                          MIGRATION_STATUS_CANCELLED);
+        cpr_state_close();
+        migrate_hup_delete(s);
+    }
 }
 
 void migration_add_notifier_mode(NotifierWithReturn *notify,
@@ -1665,7 +1691,9 @@ bool migration_thread_is_self(void)
 
 bool migrate_mode_is_cpr(MigrationState *s)
 {
-    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
+    MigMode mode = s->parameters.mode;
+    return mode == MIG_MODE_CPR_REBOOT ||
+           mode == MIG_MODE_CPR_TRANSFER;
 }
 
 int migrate_init(MigrationState *s, Error **errp)
@@ -2046,6 +2074,40 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
     return true;
 }
 
+static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
+                               Error **errp);
+
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
@@ -2056,6 +2118,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
+    MigrationChannel *cpr_channel = NULL;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2076,6 +2139,7 @@ void qmp_migrate(const char *uri, bool has_channels,
             }
             channelv[type] = channels->value;
         }
+        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
         addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
         if (!addr) {
             error_setg(errp, "Channel list has no main entry");
@@ -2096,12 +2160,52 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
+        error_setg(errp, "missing 'cpr' migration channel");
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
     }
 
+    if (cpr_state_save(cpr_channel, &local_err)) {
+        goto out;
+    }
+
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
+    if (local_err) {
+        migrate_fd_error(s, local_err);
+        error_propagate(errp, local_err);
+    }
+}
+
+static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
+                               Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+
     if (!resume_requested) {
         if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
             return;
diff --git a/migration/migration.h b/migration/migration.h
index 1d4d4e910d..fb1b8f99d3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -468,6 +468,8 @@ struct MigrationState {
     bool switchover_acked;
     /* Is this a rdma migration */
     bool rdma_migration;
+
+    GSource *hup_source;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index b8d5300326..1ad950e397 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qnull.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -745,8 +746,11 @@ uint64_t migrate_max_postcopy_bandwidth(void)
 
 MigMode migrate_mode(void)
 {
-    MigrationState *s = migrate_get_current();
-    MigMode mode = s->parameters.mode;
+    MigMode mode = cpr_get_incoming_mode();
+
+    if (mode == MIG_MODE_NONE) {
+        mode = migrate_get_current()->parameters.mode;
+    }
 
     assert(mode >= 0 && mode < MIG_MODE__MAX);
     return mode;
diff --git a/migration/ram.c b/migration/ram.c
index ce28328141..5aace00bf1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -195,7 +195,9 @@ static bool postcopy_preempt_active(void)
 
 bool migrate_ram_is_ignored(RAMBlock *block)
 {
+    MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
+           mode == MIG_MODE_CPR_TRANSFER ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                     && qemu_ram_is_named_file(block));
 }
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 0319c3568b..741a588b7e 100644
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
index a605dc26db..4679ce9f2a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -614,9 +614,48 @@
 #     or COLO.
 #
 #     (since 8.2)
+#
+# @cpr-transfer: This mode allows the user to transfer a guest to a
+#     new QEMU instance on the same host with minimal guest pause
+#     time by preserving guest RAM in place.  Devices and their pinned
+#     pages will also be preserved in a future QEMU release.
+#
+#     The user starts new QEMU on the same host as old QEMU, with
+#     command-line arguments to create the same machine, plus the
+#     -incoming option for the main migration channel, like normal
+#     live migration.  In addition, the user adds a second -incoming
+#     option with channel type "cpr".  This CPR channel must support
+#     file descriptor transfer with SCM_RIGHTS, i.e. it must be a
+#     UNIX domain socket.
+#
+#     To initiate CPR, the user issues a migrate command to old QEMU,
+#     adding a second migration channel of type "cpr" in the channels
+#     argument.  Old QEMU stops the VM, saves state to the migration
+#     channels, and enters the postmigrate state.  Execution resumes
+#     in new QEMU.
+#
+#     New QEMU reads the CPR channel before opening a monitor, hence
+#     the CPR channel cannot be specified in the list of channels for
+#     a migrate-incoming command.  It may only be specified on the
+#     command line.
+#
+#     The main channel address cannot be a file type, and for an
+#     inet socket, the port cannot be 0 (meaning dynamically choose
+#     a port).
+#
+#     Memory-backend objects must have the share=on attribute, but
+#     memory-backend-epc is not supported.  The VM must be started
+#     with the '-machine aux-ram-share=on' option.
+#
+#     When using -incoming defer, you must issue the migrate command
+#     to old QEMU before issuing any monitor commands to new QEMU.
+#     However, new QEMU does not open and read the migration stream
+#     until you issue the migrate incoming command.
+#
+#     (since 10.0)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
 
 ##
 # @ZeroPageDetection:
@@ -1578,11 +1617,12 @@
 # The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
+# @cpr: Checkpoint and restart state channel.
 #
 # Since: 8.1
 ##
 { 'enum': 'MigrationChannelType',
-  'data': [ 'main' ] }
+  'data': [ 'main', 'cpr' ] }
 
 ##
 # @MigrationChannel:
diff --git a/qemu-options.hx b/qemu-options.hx
index 3d1af7325b..d19bf533d6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -112,6 +112,8 @@ SRST
         specified on the command line, or implicitly created by the -m
         command line option.  The default is off.
 
+        To use the cpr-transfer migration mode, you must set aux-ram-share=on.
+
     ``memory-backend='id'``
         An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
         Allows to use a memory backend as main RAM.
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 8513d9204e..c190762d7c 100644
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
index 504f05b954..db8e604eba 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -77,6 +77,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "system/tpm.h"
@@ -3706,6 +3707,12 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
+    /*
+     * Load incoming CPR state before any devices are created, because it
+     * contains file descriptors that are needed in device initialization code.
+     */
+    cpr_state_load(incoming_channels[MIGRATION_CHANNEL_TYPE_CPR], &error_fatal);
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
-- 
2.35.3


