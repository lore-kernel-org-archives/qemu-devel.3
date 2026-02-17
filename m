Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46586E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjN-0001A7-AW; Tue, 17 Feb 2026 11:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjL-00019m-9z
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:19 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjI-00038C-UL
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D9F65BD26;
 Tue, 17 Feb 2026 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMoJHi/jUafcNoVo1u4cOIrAwRUSJp2lE9e5dows5eA=;
 b=d+JvVqyAxEkZHkEy15grL0wTzz4ga/QHc9KVr5Fb05KhJHuU8IuVbYYCfD1f9pM0DuGqfT
 jdbS2uju84bpuLTiFG+2I6QW3XV9+eL6nd0w1nrEtFHBGTK25uFY9OqTIio+8kl2gp2aeh
 G+a1vggoQbfJY64PgvnThZQns25gz0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMoJHi/jUafcNoVo1u4cOIrAwRUSJp2lE9e5dows5eA=;
 b=aNTFdaTEaW20A3DE06PiYTTiSgf72pnlwkjc+iFli6hgns3Ax+dOoSeA6BJVnIuKJsZO9V
 4+18geW2zD3l/fAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d+JvVqyA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aNTFdaTE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMoJHi/jUafcNoVo1u4cOIrAwRUSJp2lE9e5dows5eA=;
 b=d+JvVqyAxEkZHkEy15grL0wTzz4ga/QHc9KVr5Fb05KhJHuU8IuVbYYCfD1f9pM0DuGqfT
 jdbS2uju84bpuLTiFG+2I6QW3XV9+eL6nd0w1nrEtFHBGTK25uFY9OqTIio+8kl2gp2aeh
 G+a1vggoQbfJY64PgvnThZQns25gz0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMoJHi/jUafcNoVo1u4cOIrAwRUSJp2lE9e5dows5eA=;
 b=aNTFdaTEaW20A3DE06PiYTTiSgf72pnlwkjc+iFli6hgns3Ax+dOoSeA6BJVnIuKJsZO9V
 4+18geW2zD3l/fAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54ADE3EA66;
 Tue, 17 Feb 2026 16:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0PzCBv+TlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 05/32] migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
Date: Tue, 17 Feb 2026 13:14:16 -0300
Message-ID: <20260217161443.12738-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8D9F65BD26
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

All three events are shared between precopy and postcopy, rather than
precopy specific.

For example, both precopy and postcopy will go through a SETUP process.

Meanwhile, both FAILED and DONE notifiers will be notified for either
precopy or postcopy on completions / failures.

Rename them to make them match what they do, and shorter.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260126213614.3815900-6-peterx@redhat.com
[fixed-up entry in scsi-disk.c that got merged first]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/intc/arm_gicv3_kvm.c  |  2 +-
 hw/net/virtio-net.c      |  4 ++--
 hw/scsi/scsi-disk.c      |  4 ++--
 hw/vfio/cpr-legacy.c     |  2 +-
 hw/vfio/cpr.c            |  8 ++++----
 hw/vfio/migration.c      |  4 ++--
 include/migration/misc.h | 18 +++++++-----------
 migration/cpr-exec.c     |  6 +++---
 migration/migration.c    |  8 ++++----
 net/vhost-vdpa.c         |  4 ++--
 ui/spice-core.c          |  6 +++---
 11 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6f311e37ef..fddeefa26f 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -774,7 +774,7 @@ static void vm_change_state_handler(void *opaque, bool running,
 static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
                                   MigrationEvent *e, Error **errp)
 {
-    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    if (e->type == MIG_EVENT_DONE) {
         GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
         return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                                  KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 512a7c02c9..cc89619a43 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3789,7 +3789,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 
     should_be_hidden = qatomic_read(&n->failover_primary_hidden);
 
-    if (e->type == MIG_EVENT_PRECOPY_SETUP && !should_be_hidden) {
+    if (e->type == MIG_EVENT_SETUP && !should_be_hidden) {
         if (failover_unplug_primary(n, dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
             qapi_event_send_unplug_primary(dev->id);
@@ -3797,7 +3797,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
         } else {
             warn_report("couldn't unplug primary device");
         }
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         /* We already unplugged the device let's plug it back */
         if (!failover_replug_primary(n, dev, &err)) {
             if (err) {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 877ad21579..2f400f5b77 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2747,14 +2747,14 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
 static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
-    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    if (e->type == MIG_EVENT_FAILED) {
         SCSIDiskState *s =
             container_of(notifier, SCSIDiskState, migration_notifier);
         SCSIDevice *d = &s->qdev;
         Error *local_err = NULL;
 
         if (!scsi_generic_pr_state_preempt(d, &local_err)) {
-            /* MIG_EVENT_PRECOPY_FAILED cannot fail, so just warn */
+            /* MIG_EVENT_FAILED cannot fail, so just warn */
             error_prepend(&local_err, "scsi-block migration rollback: ");
             warn_report_err(local_err);
         }
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 7c03ddb961..033a546c30 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -137,7 +137,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
         container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
-    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
+    if (e->type != MIG_EVENT_FAILED) {
         return 0;
     }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 998230d271..ffa4f8e099 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -18,7 +18,7 @@
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                              MigrationEvent *e, Error **errp)
 {
-    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
+    if (e->type == MIG_EVENT_SETUP &&
         !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
 
         error_setg(errp,
@@ -186,7 +186,7 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
                                        MigrationEvent *e,
                                        Error **errp)
 {
-    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    if (e->type == MIG_EVENT_DONE) {
         vfio_kvm_device_close();
     }
     return 0;
@@ -272,9 +272,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
     VFIOPCIDevice *vdev =
         container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
 
-    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+    if (e->type == MIG_EVENT_SETUP) {
         return vfio_cpr_set_msi_virq(vdev, errp, false);
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         return vfio_cpr_set_msi_virq(vdev, errp, true);
     }
     return 0;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b4695030c7..adacfe36c6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -917,10 +917,10 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
 
     trace_vfio_migration_state_notifier(vbasedev->name, e->type);
 
-    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    if (e->type == MIG_EVENT_FAILED) {
         /*
          * MigrationNotifyFunc may not return an error code and an Error
-         * object for MIG_EVENT_PRECOPY_FAILED. Hence, report the error
+         * object for MIG_EVENT_FAILED. Hence, report the error
          * locally and ignore the errp argument.
          */
         ret = vfio_migration_set_state_or_reset(vbasedev,
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 1cd6cfd7f7..3159a5e53c 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -62,19 +62,15 @@ bool migration_thread_is_self(void);
 /*
  * Notifiers may receive events in any of the following orders:
  *
- *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
- *      -> MIG_EVENT_PRECOPY_DONE
- *
- *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
- *      -> MIG_EVENT_PRECOPY_FAILED
- *
- *    - MIG_EVENT_PRECOPY_FAILED
+ *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_DONE
+ *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_FAILED
+ *    - MIG_EVENT_FAILED
  */
 typedef enum MigrationEventType {
-    MIG_EVENT_PRECOPY_SETUP,
-    MIG_EVENT_PRECOPY_DONE,
-    MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_SETUP,
     MIG_EVENT_POSTCOPY_START,
+    MIG_EVENT_DONE,
+    MIG_EVENT_FAILED,
     MIG_EVENT_MAX
 } MigrationEventType;
 
@@ -84,7 +80,7 @@ typedef struct MigrationEvent {
 
 /*
  * A MigrationNotifyFunc may return an error code and an Error object,
- * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
+ * but only when @e->type is MIG_EVENT_SETUP.  The code is an int
  * to allow for different failure modes and recovery actions.
  */
 typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index e315a30f92..daa50916d2 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -164,7 +164,7 @@ static void cpr_exec_cb(void *opaque)
     err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
-    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
+    migration_call_notifiers(MIG_EVENT_FAILED, NULL);
 
     if (!migration_block_activate(&err)) {
         /* error was already reported */
@@ -182,12 +182,12 @@ static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
 {
     MigrationState *s = migrate_get_current();
 
-    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    if (e->type == MIG_EVENT_DONE) {
         QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
         assert(s->state == MIGRATION_STATUS_COMPLETED);
         qemu_bh_schedule(cpr_exec_bh);
         qemu_notify_event();
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         cpr_exec_unpersist_state();
     }
     return 0;
diff --git a/migration/migration.c b/migration/migration.c
index a5b0561cbe..7ab0294d22 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1337,7 +1337,7 @@ static void migration_cleanup(MigrationState *s)
      * migration completed successfully.
      */
     if (!migration_has_failed(s)) {
-        migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
+        migration_call_notifiers(MIG_EVENT_DONE, NULL);
     }
 
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1541,7 +1541,7 @@ int migration_call_notifiers(MigrationEventType type, Error **errp)
         notifier = (NotifierWithReturn *)elem->data;
         ret = notifier->notify(notifier, &e, errp);
         if (ret) {
-            assert(type == MIG_EVENT_PRECOPY_SETUP);
+            assert(type == MIG_EVENT_SETUP);
             return ret;
         }
     }
@@ -3331,7 +3331,7 @@ static void migration_iteration_finish(MigrationState *s)
          * Notify FAILED before starting VM, so that devices can invoke
          * necessary fallbacks before vCPUs run again.
          */
-        migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
+        migration_call_notifiers(MIG_EVENT_FAILED, NULL);
 
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
@@ -3769,7 +3769,7 @@ void migration_start_outgoing(MigrationState *s)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        if (migration_call_notifiers(MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+        if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
             goto fail;
         }
     }
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 74d26a9497..f4b1f0e9e0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -378,9 +378,9 @@ static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
 {
     VhostVDPAState *s = container_of(notifier, VhostVDPAState, migration_state);
 
-    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+    if (e->type == MIG_EVENT_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         vhost_vdpa_net_log_global_enable(s, false);
     }
     return 0;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ce3c2954e3..ee13ecc4a5 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -583,13 +583,13 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
         return 0;
     }
 
-    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+    if (e->type == MIG_EVENT_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (e->type == MIG_EVENT_PRECOPY_DONE ||
+    } else if (e->type == MIG_EVENT_DONE ||
                e->type == MIG_EVENT_POSTCOPY_START) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         spice_server_migrate_end(spice_server, false);
         spice_have_target_host = false;
     }
-- 
2.51.0


