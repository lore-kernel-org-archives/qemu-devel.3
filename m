Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BC2E81BCF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWq-0007Fh-PD; Mon, 09 Feb 2026 09:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSWN-00075h-GD
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSWJ-0005lC-AS
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+sLWGRZ9QW9gIBUHgVX+jrs2tYXHDKCGyTDdUHvnsg=;
 b=ed+Oj+n9/uQ+7WVDxt8L13/GVpZeuf+ppnYy4yQjSzfrwArTdtHa0xmdhYpkmGbdc1rTGI
 CEWVbfM7CMqZHGGMGo+WMoBvrlVdI+8IE4ktf4wepnF9rIYmBvWFG96k4D9xPziwdyGcH3
 0T8PybPzPNaVBYR9MBKcYLtz5WoLH6k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-sJnTjeDzO1KbJFTV7kw6Aw-1; Mon,
 09 Feb 2026 09:45:28 -0500
X-MC-Unique: sJnTjeDzO1KbJFTV7kw6Aw-1
X-Mimecast-MFC-AGG-ID: sJnTjeDzO1KbJFTV7kw6Aw_1770648327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA96F1956088; Mon,  9 Feb 2026 14:45:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6719719560A2; Mon,  9 Feb 2026 14:45:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 8/9] scsi: save/load SCSI reservation state
Date: Mon,  9 Feb 2026 09:45:06 -0500
Message-ID: <20260209144508.45268-9-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Add a vmstate subsection to SCSIDiskState so that scsi-block devices can
transfer their reservation state during live migration. Upon loading the
subsection, the destination QEMU invokes the PERSISTENT RESERVE OUT
command's PREEMPT service action to atomically move the reservation from
the source I_T nexus to the destination I_T nexus. This results in
transparent live migration of SCSI reservations.

This approach is incomplete since SCSI reservations are cooperative and
other hosts could interfere. Neither the source QEMU nor the destination
QEMU are aware of changes made by other hosts. The assumption is that
reservation is not taken over by a third host without cooperation from
the source host.

I considered adding the vmstate subsection to SCSIDevice instead of
SCSIDiskState, since reservations are part of the SCSI Primary Commands
that other devices apart from disks could support. However, due to
fragility of migrating reservations, we will probably limit support to
scsi-block and maybe scsi-disk in the future. In the end, I think it
makes sense to place this within scsi-disk.c.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20260129212035.219676-5-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/core/machine.c      |  4 +-
 hw/scsi/scsi-disk.c    | 86 +++++++++++++++++++++++++++++++++++++++++-
 hw/scsi/scsi-generic.c | 83 ++++++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events   |  1 +
 5 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index c5ec58089b..a3e246dbd9 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -253,6 +253,7 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
+bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
 
 /* scsi-disk.c */
 #define SCSI_DISK_QUIRK_MODE_PAGE_APPLE_VENDOR             0
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..16134f8ce5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_10_2[] = {};
+GlobalProperty hw_compat_10_2[] = {
+    { "scsi-block", "migrate-pr", "off" },
+};
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
 GlobalProperty hw_compat_10_1[] = {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ffc3fb8afe..877ad21579 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -28,6 +28,7 @@
 #include "qemu/hw-version.h"
 #include "qemu/memalign.h"
 #include "hw/scsi/scsi.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
@@ -122,6 +123,7 @@ struct SCSIDiskState {
      */
     uint16_t rotation_rate;
     bool migrate_emulated_scsi_request;
+    NotifierWithReturn migration_notifier;
 };
 
 static void scsi_free_request(SCSIRequest *req)
@@ -2737,6 +2739,29 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
 }
 
 #ifdef __linux__
+/*
+ * Preempt on the SCSI Persistent Reservation on the source when migration
+ * fails because the destination may have already preempted and we need to get
+ * the reservation back.
+ */
+static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
+                                         MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        SCSIDiskState *s =
+            container_of(notifier, SCSIDiskState, migration_notifier);
+        SCSIDevice *d = &s->qdev;
+        Error *local_err = NULL;
+
+        if (!scsi_generic_pr_state_preempt(d, &local_err)) {
+            /* MIG_EVENT_PRECOPY_FAILED cannot fail, so just warn */
+            error_prepend(&local_err, "scsi-block migration rollback: ");
+            warn_report_err(local_err);
+        }
+    }
+    return 0;
+}
+
 static int get_device_type(SCSIDiskState *s)
 {
     uint8_t cmd[16];
@@ -2815,6 +2840,16 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 
     scsi_realize(&s->qdev, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
+
+    migration_add_notifier(&s->migration_notifier,
+                           scsi_block_migration_notifier);
+}
+
+static void scsi_block_unrealize(SCSIDevice *dev)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+
+    migration_remove_notifier(&s->migration_notifier);
 }
 
 typedef struct SCSIBlockReq {
@@ -3209,6 +3244,47 @@ static const Property scsi_hd_properties[] = {
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
 };
 
+#ifdef __linux__
+static bool scsi_disk_pr_state_post_load_errp(void *opaque, int version_id,
+                                              Error **errp)
+{
+    SCSIDiskState *s = opaque;
+    SCSIDevice *dev = &s->qdev;
+
+    return scsi_generic_pr_state_preempt(dev, errp);
+}
+
+static bool scsi_disk_pr_state_needed(void *opaque)
+{
+    SCSIDiskState *s = opaque;
+    SCSIPRState *pr_state = &s->qdev.pr_state;
+    bool ret;
+
+    if (!s->qdev.migrate_pr) {
+        return false;
+    }
+
+    /* A reservation requires a key, so checking this field is enough */
+    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+        ret = pr_state->key;
+    }
+    return ret;
+}
+
+static const VMStateDescription vmstate_scsi_disk_pr_state = {
+    .name = "scsi-disk/pr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load_errp = scsi_disk_pr_state_post_load_errp,
+    .needed = scsi_disk_pr_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(qdev.pr_state.key, SCSIDiskState),
+        VMSTATE_UINT8(qdev.pr_state.resv_type, SCSIDiskState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif /* __linux__ */
+
 static const VMStateDescription vmstate_scsi_disk_state = {
     .name = "scsi-disk",
     .version_id = 1,
@@ -3221,7 +3297,13 @@ static const VMStateDescription vmstate_scsi_disk_state = {
         VMSTATE_BOOL(tray_open, SCSIDiskState),
         VMSTATE_BOOL(tray_locked, SCSIDiskState),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+#ifdef __linux__
+        &vmstate_scsi_disk_pr_state,
+#endif
+        NULL
+    },
 };
 
 static void scsi_hd_class_initfn(ObjectClass *klass, const void *data)
@@ -3301,6 +3383,7 @@ static const Property scsi_block_properties[] = {
                       -1),
     DEFINE_PROP_UINT32("io_timeout", SCSIDiskState, qdev.io_timeout,
                        DEFAULT_IO_TIMEOUT),
+    DEFINE_PROP_BOOL("migrate-pr", SCSIDiskState, qdev.migrate_pr, true),
 };
 
 static void scsi_block_class_initfn(ObjectClass *klass, const void *data)
@@ -3310,6 +3393,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, const void *data)
     SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
 
     sc->realize      = scsi_block_realize;
+    sc->unrealize    = scsi_block_unrealize;
     sc->alloc_req    = scsi_block_new_request;
     sc->parse_cdb    = scsi_block_parse_cdb;
     sdc->dma_readv   = scsi_block_dma_readv;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 0b3cf8f77b..a2316a5266 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -424,6 +424,89 @@ static void scsi_handle_persistent_reserve_out_reply(
     }
 }
 
+static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
+{
+    uint8_t cmd[10] = {};
+    uint8_t buf[24] = {};
+    uint64_t key_be = cpu_to_be64(key);
+    int ret;
+
+    cmd[0] = PERSISTENT_RESERVE_OUT;
+    cmd[1] = PRO_REGISTER;
+    cmd[8] = sizeof(buf);
+    memcpy(&buf[8], &key_be, sizeof(key_be));
+
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->io_timeout, errp);
+    if (ret < 0) {
+        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER");
+        return false;
+    }
+    return true;
+}
+
+static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
+                                    uint8_t resv_type, Error **errp)
+{
+    uint8_t cmd[10] = {};
+    uint8_t buf[24] = {};
+    uint64_t key_be = cpu_to_be64(key);
+    int ret;
+
+    cmd[0] = PERSISTENT_RESERVE_OUT;
+    cmd[1] = PRO_PREEMPT;
+    cmd[2] = resv_type & 0xf;
+    cmd[8] = sizeof(buf);
+    memcpy(&buf[0], &key_be, sizeof(key_be));
+    memcpy(&buf[8], &key_be, sizeof(key_be));
+
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->io_timeout, errp);
+    if (ret < 0) {
+        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT");
+        return false;
+    }
+    return true;
+}
+
+/* Register keys and preempt reservations after live migration */
+bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
+{
+    SCSIPRState *pr_state = &s->pr_state;
+    uint64_t key;
+    uint8_t resv_type;
+
+    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+        key = pr_state->key;
+        resv_type = pr_state->resv_type;
+    }
+
+    trace_scsi_generic_pr_state_preempt(key, resv_type);
+
+    if (key) {
+        if (!scsi_generic_pr_register(s, key, errp)) {
+            return false;
+        }
+
+        /*
+         * Two cases:
+         *
+         * 1. There is no reservation (resv_type is 0) and the other I_T nexus
+         *    will be unregistered. This is important so the source host does
+         *    not leak registered keys across live migration.
+         *
+         * 2. There is a reservation (resv_type is not 0) and the other I_T
+         *    nexus will be unregistered and its reservation is atomically
+         *    taken over by us. This is the scenario where a reservation is
+         *    migrated along with the guest.
+         */
+        if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index ff92fff7c5..a8ac1e7f1d 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -391,3 +391,4 @@ scsi_generic_aio_sgio_command(uint32_t tag, uint8_t cmd, uint32_t timeout) "gene
 scsi_generic_ioctl_sgio_command(uint8_t cmd, uint32_t timeout) "generic ioctl sgio: cmd=0x%x timeout=%u"
 scsi_generic_ioctl_sgio_done(uint8_t cmd, int ret, uint8_t status, uint8_t host_status) "generic ioctl sgio: cmd=0x%x ret=%d status=0x%x host_status=0x%x"
 scsi_generic_persistent_reserve_out_reply(uint8_t service_action, uint8_t resv_type, uint64_t old_key, uint64_t new_key) "persistent reserve out reply service_action=%u resv_type=%u old_key=0x%" PRIx64 " new_key=0x%" PRIx64
+scsi_generic_pr_state_preempt(uint64_t key, uint8_t resv_type) "key=0x%" PRIx64 " resv_type=%u"
-- 
2.52.0


