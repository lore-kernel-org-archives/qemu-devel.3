Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8239CD10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkq6-0002gL-SY; Sun, 17 Nov 2024 14:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq5-0002gD-9F
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:41 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq2-0005sT-1K
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:41 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpy-00000002GTX-1tPD; Sun, 17 Nov 2024 20:21:34 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its load
 handler
Date: Sun, 17 Nov 2024 20:20:00 +0100
Message-ID: <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This QEMU_VM_COMMAND sub-command and its switchover_start SaveVMHandler is
used to mark the switchover point in main migration stream.

It can be used to inform the destination that all pre-switchover main
migration stream data has been sent/received so it can start to process
post-switchover data that it might have received via other migration
channels like the multifd ones.

Add also the relevant MigrationState bit stream compatibility property and
its hw_compat entry.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/machine.c                  |  1 +
 include/migration/client-options.h |  4 +++
 include/migration/register.h       | 12 +++++++++
 migration/colo.c                   |  3 +++
 migration/migration-hmp-cmds.c     |  2 ++
 migration/migration.c              |  3 +++
 migration/migration.h              |  2 ++
 migration/options.c                |  9 +++++++
 migration/savevm.c                 | 39 ++++++++++++++++++++++++++++++
 migration/savevm.h                 |  1 +
 migration/trace-events             |  1 +
 scripts/analyze-migration.py       | 11 +++++++++
 12 files changed, 88 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a35c4a8faecb..ed8d39fd769f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@
 
 GlobalProperty hw_compat_9_1[] = {
     { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
+    { "migration", "send-switchover-start", "off"},
 };
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 59f4b55cf4f7..289c9d776221 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -10,6 +10,10 @@
 #ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
 #define QEMU_MIGRATION_CLIENT_OPTIONS_H
 
+
+/* properties */
+bool migrate_send_switchover_start(void);
+
 /* capabilities */
 
 bool migrate_background_snapshot(void);
diff --git a/include/migration/register.h b/include/migration/register.h
index 0b0292738320..ff0faf5f68c8 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -279,6 +279,18 @@ typedef struct SaveVMHandlers {
      * otherwise
      */
     bool (*switchover_ack_needed)(void *opaque);
+
+    /**
+     * @switchover_start
+     *
+     * Notifies that the switchover has started. Called only on
+     * the destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*switchover_start)(void *opaque);
 } SaveVMHandlers;
 
 /**
diff --git a/migration/colo.c b/migration/colo.c
index 9590f281d0f1..a75c2c41b464 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         bql_unlock();
         goto out;
     }
+
+    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
+
     /* Note: device state is saved into buffer */
     ret = qemu_save_device_state(fb);
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e21948..59d0c48a3e0d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -46,6 +46,8 @@ static void migration_global_dump(Monitor *mon)
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
+    monitor_printf(mon, "send-switchover-start: %s\n",
+                   ms->send_switchover_start ? "on" : "off");
     monitor_printf(mon, "clear-bitmap-shift: %u\n",
                    ms->clear_bitmap_shift);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c85..2e9d6d5087d7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2543,6 +2543,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
     restart_block = true;
 
+    qemu_savevm_maybe_send_switchover_start(ms->to_dst_file);
+
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2742,6 +2744,7 @@ static int migration_completion_precopy(MigrationState *s,
      */
     s->block_inactive = !migrate_colo();
     migration_rate_set(RATE_LIMIT_DISABLED);
+    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                              s->block_inactive);
 out_unlock:
diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b2c..2a18349cfec2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -403,6 +403,8 @@ struct MigrationState {
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+    /* Whether we send switchover start notification during migration */
+    bool send_switchover_start;
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a807..f916c8ed4e09 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -92,6 +92,8 @@ Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
+    DEFINE_PROP_BOOL("send-switchover-start", MigrationState,
+                     send_switchover_start, true),
     DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
                       multifd_flush_after_each_section, false),
     DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
@@ -206,6 +208,13 @@ bool migrate_auto_converge(void)
     return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
 }
 
+bool migrate_send_switchover_start(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->send_switchover_start;
+}
+
 bool migrate_background_snapshot(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/savevm.c b/migration/savevm.c
index f4e4876f7202..a254c38edcca 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -90,6 +90,7 @@ enum qemu_vm_cmd {
     MIG_CMD_ENABLE_COLO,       /* Enable COLO */
     MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
+    MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
     MIG_CMD_MAX
 };
 
@@ -109,6 +110,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
     [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
+    [MIG_CMD_SWITCHOVER_START] = { .len =  0, .name = "SWITCHOVER_START" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -1201,6 +1203,19 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
     qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
 }
 
+static void qemu_savevm_send_switchover_start(QEMUFile *f)
+{
+    trace_savevm_send_switchover_start();
+    qemu_savevm_command_send(f, MIG_CMD_SWITCHOVER_START, 0, NULL);
+}
+
+void qemu_savevm_maybe_send_switchover_start(QEMUFile *f)
+{
+    if (migrate_send_switchover_start()) {
+        qemu_savevm_send_switchover_start(f);
+    }
+}
+
 bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
@@ -1713,6 +1728,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
+        qemu_savevm_maybe_send_switchover_start(f);
         qemu_savevm_state_complete_precopy(f, false, false);
         ret = qemu_file_get_error(f);
     }
@@ -2413,6 +2429,26 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis)
     return ret;
 }
 
+static int loadvm_postcopy_handle_switchover_start(void)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        int ret;
+
+        if (!se->ops || !se->ops->switchover_start) {
+            continue;
+        }
+
+        ret = se->ops->switchover_start(se->opaque);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -2511,6 +2547,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_ENABLE_COLO:
         return loadvm_process_enable_colo(mis);
+
+    case MIG_CMD_SWITCHOVER_START:
+        return loadvm_postcopy_handle_switchover_start();
     }
 
     return 0;
diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a995c93..4d402723bc3c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -53,6 +53,7 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
 void qemu_savevm_send_postcopy_resume(QEMUFile *f);
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
+void qemu_savevm_maybe_send_switchover_start(QEMUFile *f);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
diff --git a/migration/trace-events b/migration/trace-events
index bb0e0cc6dcfe..551f5af0740f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -39,6 +39,7 @@ savevm_send_postcopy_run(void) ""
 savevm_send_postcopy_resume(void) ""
 savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
+savevm_send_switchover_start(void) ""
 savevm_state_setup(void) ""
 savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 8a254a5b6a2e..a4d4042584c0 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -564,7 +564,9 @@ class MigrationDump(object):
     QEMU_VM_SUBSECTION    = 0x05
     QEMU_VM_VMDESCRIPTION = 0x06
     QEMU_VM_CONFIGURATION = 0x07
+    QEMU_VM_COMMAND       = 0x08
     QEMU_VM_SECTION_FOOTER= 0x7e
+    QEMU_MIG_CMD_SWITCHOVER_START = 0x0b
 
     def __init__(self, filename):
         self.section_classes = {
@@ -626,6 +628,15 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
             elif section_type == self.QEMU_VM_SECTION_PART or section_type == self.QEMU_VM_SECTION_END:
                 section_id = file.read32()
                 self.sections[section_id].read()
+            elif section_type == self.QEMU_VM_COMMAND:
+                command_type = file.read16()
+                command_data_len = file.read16()
+                if command_type != self.QEMU_MIG_CMD_SWITCHOVER_START:
+                    raise Exception("Unknown QEMU_VM_COMMAND: %x" %
+                                    (command_type))
+                if command_data_len != 0:
+                    raise Exception("Invalid SWITCHOVER_START length: %x" %
+                                    (command_data_len))
             elif section_type == self.QEMU_VM_SECTION_FOOTER:
                 read_section_id = file.read32()
                 if read_section_id != section_id:

