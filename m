Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F7D6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iO-000519-EO; Thu, 22 Jan 2026 18:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iN-00050N-FG
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iL-0007XA-En
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYO6xRxiR5THGxcs3zEI0xVwPCkfMhpmibdg2OaNMFk=;
 b=b6qFh2T7mxDW6AAZ0Z2JvfEia4ACYognMZNTsYQo9EXVkfal+KbMdwKqVXlELEApK4C2QJ
 ggs4l4ihcqn+PxXzDQyynNQYkDeLRTigkz5BK+3dFaiOgDuaphQK2V91lZvH9OjhKUHFhq
 TcVIcSAhRxWduSxJrqeJte0nBczdQZ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-57frVaO9NmKnYET7WvAV8Q-1; Thu, 22 Jan 2026 18:03:43 -0500
X-MC-Unique: 57frVaO9NmKnYET7WvAV8Q-1
X-Mimecast-MFC-AGG-ID: 57frVaO9NmKnYET7WvAV8Q_1769123023
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8bc4493d315so406284585a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123022; x=1769727822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYO6xRxiR5THGxcs3zEI0xVwPCkfMhpmibdg2OaNMFk=;
 b=H3jbdyeRQJDA3Pr35bUVukoVFVy5WPvUaXnSscXPn0hDJueICAtVUEsjwDBPV+VZB3
 u0HixXBpRhi/fkqJidIX5g3gxcsLe9jLGWq+seGOtCwyBiZVFN4Vvf04T6sc3qptjnDq
 oo4Kt7ETHnMTY2zCQ73AXYgbHP4dAmnQU+qCel5wjPVQJg2x9wywOItw1yi9P9OpQn9m
 WWM+vREOj1HpdBq8/d8NxE0D1d0ns6dCKc0ktF6bGDLf1Eovb3t4cvJTtndYpTM4y+VI
 5HEn9k1LZoN0KZRGzd7F1bTHtF10/LwLkaYBwx3M2Rrsxhdpd6sUNUEfnBgbymO+qsPf
 VM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123022; x=1769727822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FYO6xRxiR5THGxcs3zEI0xVwPCkfMhpmibdg2OaNMFk=;
 b=GX6XN6ymQUUdHf99fcvA2dP88Zz6RjaVBRhreZi4JVPEuUpZlAt9B0n81Am+xM3a9j
 jjqaLASAocamj7zds0iFrqNtyV9MD8DZgCQt3xh+2RLh+2dalm3jcrsbf0+R5YqFLGxy
 aTeuqVoiy/Wx46yps2k2+qHmTYon6Hz3gMje+WxumzOnMB/YfHRrmtuDFaIw7hqw52zg
 Fddi8jzj0Y6UhkgHa+1Mt/oJ8FGHs/e4FBwSuowJj5x1Zbu78yHZxh01pcGGpYObOr00
 pEEssr268jVLxzEZk1lgOTOpfinshIp3yg/RH2PnWqDppnCC7Ka/RB9xPCrt7it2/3jv
 hXAQ==
X-Gm-Message-State: AOJu0YzZyvOzbFofeb2/hRP9zsvNgjlwnfn5YtRIXnJ7j3SuPvqGlzbf
 ihHpj27UX+21BBoGv2Ec0OnZ1cOgxJZvhtyxMmg7GI2ajdt0IpRhPfh0eBoWBupP//n6EgG3hJJ
 B7QALqSE81WQav+IJOSP7IUpUz85zVhNwaHXBLuPhHr9AQXlAkjOkH2XyObK7Q+8w2RZnjCyzgq
 Fi1F3PbN9q1/eZ4UV0YeIc2TpsrdWP0p521+Szuw==
X-Gm-Gg: AZuq6aJanX5FyglKVxaKRFNipTYVxeVhYtsypWQ0P0Y1GExIV4Wc9N/whKOgNtgOg3x
 inymtJqc1N7a6jHGEJckKz6lQWgMfUAkgnlfqDS3CyQcVMKG98+/MWSYE39g1rdmvC5fruk7QMc
 jYm+ByObyFMyzWI7HlFXSE0GB5r1fk+eEWRbrRJYsfeJIHHV6PZdYa8DEqEGgJwFV5Yg2uKFR71
 JrPT28tgresaBw6TcC7bydusAv4LdWLfcdrDgvFxt1Oz3fb6U2n/ZdZ7ELizrOBfKusI7BaBvGF
 em76lHoK2v45uhBt5+v1lB2KJ+1CHeYNFHD502BpaVBEqaw/Xjt+kuWT5twTJV0jNkhEaQhaFMZ
 e
X-Received: by 2002:a05:620a:1a9c:b0:8be:94e6:3e6c with SMTP id
 af79cd13be357-8c6e2db89d3mr160748785a.39.1769123022106; 
 Thu, 22 Jan 2026 15:03:42 -0800 (PST)
X-Received: by 2002:a05:620a:1a9c:b0:8be:94e6:3e6c with SMTP id
 af79cd13be357-8c6e2db89d3mr160741785a.39.1769123021386; 
 Thu, 22 Jan 2026 15:03:41 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:40 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 5/5] migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
Date: Thu, 22 Jan 2026 18:03:31 -0500
Message-ID: <20260122230331.3543312-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All three events are shared between precopy and postcopy, rather than
precopy specific.

For example, both precopy and postcopy will go through a SETUP process.

Meanwhile, both FAILED and DONE notifiers will be notified for either
precopy or postcopy on completions / failures.

Rename them to make them match what they do, and shorter.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 14 +++++++-------
 hw/intc/arm_gicv3_kvm.c  |  2 +-
 hw/net/virtio-net.c      |  4 ++--
 hw/vfio/cpr-legacy.c     |  2 +-
 hw/vfio/cpr.c            |  8 ++++----
 hw/vfio/migration.c      |  4 ++--
 migration/cpr-exec.c     |  6 +++---
 migration/migration.c    |  8 ++++----
 net/vhost-vdpa.c         |  4 ++--
 ui/spice-core.c          |  6 +++---
 10 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index b002466e10..766de998cb 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,10 +60,10 @@ bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
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
 
@@ -73,7 +73,7 @@ typedef struct MigrationEvent {
 
 /*
  * A MigrationNotifyFunc may return an error code and an Error object,
- * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
+ * but only when @e->type is MIG_EVENT_SETUP.  The code is an int
  * to allow for different failure modes and recovery actions.
  */
 typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
@@ -83,9 +83,9 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
  * Register the notifier @notify to be called when a migration event occurs
  * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
  * Notifiers may receive events in any of the following orders:
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_DONE
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_FAILED
- *    - MIG_EVENT_PRECOPY_FAILED
+ *    - MIG_EVENT_SETUP -> MIG_EVENT_DONE
+ *    - MIG_EVENT_SETUP -> MIG_EVENT_FAILED
+ *    - MIG_EVENT_FAILED
  */
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
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
index 317f1ad23b..3e2dc30da6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3786,7 +3786,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 
     should_be_hidden = qatomic_read(&n->failover_primary_hidden);
 
-    if (e->type == MIG_EVENT_PRECOPY_SETUP && !should_be_hidden) {
+    if (e->type == MIG_EVENT_SETUP && !should_be_hidden) {
         if (failover_unplug_primary(n, dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
             qapi_event_send_unplug_primary(dev->id);
@@ -3794,7 +3794,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
         } else {
             warn_report("couldn't unplug primary device");
         }
-    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+    } else if (e->type == MIG_EVENT_FAILED) {
         /* We already unplugged the device let's plug it back */
         if (!failover_replug_primary(n, dev, &err)) {
             if (err) {
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
index f857dc25ed..76a902b79c 100644
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
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index da287d8031..18a71828c3 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -164,7 +164,7 @@ static void cpr_exec_cb(void *opaque)
     err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
-    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+    migration_call_notifiers(s, MIG_EVENT_FAILED, NULL);
 
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
index 5bef14ea99..7ba37afb27 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1540,7 +1540,7 @@ static void migration_cleanup(MigrationState *s)
      * migration completed successfully.
      */
     if (!migration_has_failed(s)) {
-        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, NULL);
+        migration_call_notifiers(s, MIG_EVENT_DONE, NULL);
     }
 
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1720,7 +1720,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
         notifier = (NotifierWithReturn *)elem->data;
         ret = notifier->notify(notifier, &e, errp);
         if (ret) {
-            assert(type == MIG_EVENT_PRECOPY_SETUP);
+            assert(type == MIG_EVENT_SETUP);
             return ret;
         }
     }
@@ -3598,7 +3598,7 @@ static void migration_iteration_finish(MigrationState *s)
          * Notify FAILED before starting VM, so that devices can invoke
          * necessary fallbacks before vCPUs run again.
          */
-        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+        migration_call_notifiers(s, MIG_EVENT_FAILED, NULL);
 
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
@@ -4064,7 +4064,7 @@ void migration_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+        if (migration_call_notifiers(s, MIG_EVENT_SETUP, &local_err)) {
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
2.50.1


