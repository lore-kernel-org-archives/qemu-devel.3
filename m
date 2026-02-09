Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4C8E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWt-0007GS-Ow; Mon, 09 Feb 2026 09:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSWN-00075c-Bz
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSWA-0005l0-3L
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeVs0VSoR0znTJcAFKWWZCDDka3meHnk/Hyx/hDISyk=;
 b=Z/3KYiSydR0W4C+Y7VHRVKQBD0Xvq0FNXD4/ic6NI0kJdg7y2LxxCDOYOlHqGvfwjjECnt
 STPwcKVdghBhHYfsgw16UETCI3kPkV6z2mVYODe7PcxZ0S+zGyDym5urhApaEXaL+tez6R
 MjcUot1Wca7BkO0wxnW5R2xEwUqIJBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-crOzlAzgPtKiU59sStDuLw-1; Mon,
 09 Feb 2026 09:45:26 -0500
X-MC-Unique: crOzlAzgPtKiU59sStDuLw-1
X-Mimecast-MFC-AGG-ID: crOzlAzgPtKiU59sStDuLw_1770648325
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DCFD19560B2; Mon,  9 Feb 2026 14:45:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3570D19560A2; Mon,  9 Feb 2026 14:45:24 +0000 (UTC)
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
Subject: [PULL 7/9] scsi: track SCSI reservation state for live migration
Date: Mon,  9 Feb 2026 09:45:05 -0500
Message-ID: <20260209144508.45268-8-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SCSI Persistent Reservations are stateful and external to the guest. In
order to transparently move reservations to the destination host during
live migration, it is necessary to track the state built up on the
source host before migration. Only then can the destination host ensure
an equivalent state is restored upon migration.

Snoop on successful PERSISTENT RESERVE OUT commands and save the
reservation key and reservation type. This will allow registered keys
and reservations to be migrated.

Also patch PERSISTENT RESERVE IN replies with the REPORT CAPABILITIES
service action since features that involve the physical SCSI bus target
ports must not be exposed to the guest (it sees a virtual SCSI bus).

Usually this plays out as follows:
1. The guest invokes the REGISTER service action to register a
   reservation key on its I_T nexus.
2. The guest invokes the RESERVE service action to create a reservation
   using the previously-registered key.

This commit implements the snooping and stores the reservation key and
type (if any) for each LUN. The snooped PR state and the migrate_pr flag
to enable PR migration will be used in later commits.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20260129212035.219676-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h   |  10 +++
 include/scsi/constants.h |  21 +++++
 hw/scsi/scsi-bus.c       |   3 +
 hw/scsi/scsi-generic.c   | 165 +++++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events     |   1 +
 5 files changed, 200 insertions(+)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 89b1ed6258..c5ec58089b 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -57,6 +57,13 @@ struct SCSIRequest {
     QTAILQ_ENTRY(SCSIRequest) next;
 };
 
+/* Per-SCSIDevice Persistent Reservation state */
+typedef struct {
+    QemuMutex mutex;   /* protects all fields (e.g. from multiple IOThreads) */
+    uint64_t key;      /* 0 if no registered key */
+    uint8_t resv_type; /* 0 if no reservation */
+} SCSIPRState;
+
 #define TYPE_SCSI_DEVICE "scsi-device"
 OBJECT_DECLARE_TYPE(SCSIDevice, SCSIDeviceClass, SCSI_DEVICE)
 
@@ -97,6 +104,9 @@ struct SCSIDevice
     uint32_t io_timeout;
     bool needs_vpd_bl_emulation;
     bool hba_supports_iothread;
+
+    bool migrate_pr;
+    SCSIPRState pr_state;
 };
 
 extern const VMStateDescription vmstate_scsi_device;
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 9b98451912..cb97bdb636 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -319,4 +319,25 @@
 #define IDENT_DESCR_TGT_DESCR_SIZE 32
 #define XCOPY_BLK2BLK_SEG_DESC_SIZE 28
 
+/*
+ * PERSISTENT RESERVATION IN service action codes
+ */
+#define PRI_READ_KEYS           0x00
+#define PRI_READ_RESERVATION    0x01
+#define PRI_REPORT_CAPABILITIES 0x02
+#define PRI_READ_FULL_STATUS    0x03
+
+/*
+ * PERSISTENT RESERVATION OUT service action codes
+ */
+#define PRO_REGISTER                            0x00
+#define PRO_RESERVE                             0x01
+#define PRO_RELEASE                             0x02
+#define PRO_CLEAR                               0x03
+#define PRO_PREEMPT                             0x04
+#define PRO_PREEMPT_AND_ABORT                   0x05
+#define PRO_REGISTER_AND_IGNORE_EXISTING_KEY    0x06
+#define PRO_REGISTER_AND_MOVE                   0x07
+#define PRO_REPLACE_LOST_RESERVATION            0x08
+
 #endif
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f310ddafb9..9b8656dd83 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -393,6 +393,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     qemu_mutex_init(&dev->requests_lock);
+    qemu_mutex_init(&dev->pr_state.mutex);
     QTAILQ_INIT(&dev->requests);
     scsi_device_realize(dev, &local_err);
     if (local_err) {
@@ -417,6 +418,8 @@ static void scsi_qdev_unrealize(DeviceState *qdev)
 
     scsi_device_unrealize(dev);
 
+    qemu_mutex_destroy(&dev->pr_state.mutex);
+
     blockdev_mark_auto_del(dev->conf.blk);
 }
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2af8803644..0b3cf8f77b 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -265,6 +265,165 @@ static int scsi_generic_emulate_block_limits(SCSIGenericReq *r, SCSIDevice *s)
     return r->buflen;
 }
 
+/*
+ * Patch persistent reservation capabilities that are not emulated.
+ */
+static void scsi_handle_persistent_reserve_in_reply(SCSIGenericReq *r,
+                                                    SCSIDevice *s)
+{
+    uint8_t service_action = r->req.cmd.buf[1] & 0x1f;
+
+    if (!s->migrate_pr) {
+        return; /* when migration is disabled there is no need for patching */
+    }
+
+    if (service_action == PRI_REPORT_CAPABILITIES) {
+        assert(r->buflen >= 3);
+
+        /*
+         * Clear specify initiator ports capable (SIP_C) and all target ports
+         * capable (ATC_C).
+         *
+         * SPEC_I_PT is not supported because the guest sees an emulated SCSI
+         * bus and does not have the underlying transport IDs needed to use
+         * SPEC_I_PT.
+         *
+         * ALL_TG_PT is not supported because we only track the state of this
+         * emulated I_T nexus, not the underlying device's target ports.
+         */
+        r->buf[2] &= ~0xc;
+    }
+}
+
+static int scsi_generic_read_reservation(SCSIDevice *s, uint64_t *key,
+        uint8_t *resv_type, Error **errp)
+{
+    uint8_t cmd[10] = {};
+    uint8_t buf[24] = {};
+    uint32_t additional_length;
+    int ret;
+
+    *key = 0;
+    *resv_type = 0;
+
+    cmd[0] = PERSISTENT_RESERVE_IN;
+    cmd[1] = PRI_READ_RESERVATION;
+    cmd[8] = sizeof(buf);
+
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->io_timeout, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memcpy(&additional_length, &buf[4], sizeof(additional_length));
+    be32_to_cpus(&additional_length);
+
+    if (additional_length >= 0x10) {
+        memcpy(key, &buf[8], sizeof(*key));
+        be64_to_cpus(key);
+
+        *resv_type = buf[21] & 0xf;
+    }
+    return 0;
+}
+
+/*
+ * Snoop changes to registered keys and reservations so that this information
+ * can be transferred during live migration.
+ */
+static void scsi_handle_persistent_reserve_out_reply(
+        SCSIGenericReq *r,
+        SCSIDevice *s)
+{
+    SCSIPRState *pr_state = &s->pr_state;
+    uint8_t service_action = r->req.cmd.buf[1] & 0x1f;
+    uint8_t resv_type = r->req.cmd.buf[2] & 0xf;
+    uint64_t old_key;
+    uint64_t new_key;
+
+    assert(r->buflen >= 16);
+    memcpy(&old_key, &r->buf[0], sizeof(old_key));
+    memcpy(&new_key, &r->buf[8], sizeof(new_key));
+    be64_to_cpus(&old_key);
+    be64_to_cpus(&new_key);
+
+    trace_scsi_generic_persistent_reserve_out_reply(service_action, resv_type,
+                                                    old_key, new_key);
+
+    switch (service_action) {
+    case PRO_REGISTER: /* fallthrough */
+    case PRO_REGISTER_AND_IGNORE_EXISTING_KEY:
+        if (service_action == PRO_REGISTER && old_key == 0 && new_key == 0) {
+            /* Do nothing */
+        } else {
+            WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+                pr_state->key = new_key;
+                if (new_key == 0) {
+                    pr_state->resv_type = 0; /* release reservation */
+                }
+            }
+        }
+        break;
+
+    case PRO_RESERVE:
+        WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+            pr_state->resv_type = resv_type;
+        }
+        break;
+
+    case PRO_RELEASE:
+        WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+            pr_state->resv_type = 0;
+        }
+        break;
+
+    case PRO_CLEAR:
+        WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+            pr_state->key = 0;
+            pr_state->resv_type = 0;
+        }
+        break;
+
+    case PRO_REPLACE_LOST_RESERVATION:
+        WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+            pr_state->key = new_key;
+            pr_state->resv_type = resv_type;
+        }
+        break;
+
+    case PRO_PREEMPT: /* fallthrough */
+    case PRO_PREEMPT_AND_ABORT: {
+        uint64_t dev_key;
+        uint8_t dev_resv_type;
+        Error *local_err = NULL;
+
+        /* Not enough information to know actual state, ask the device */
+        if (!scsi_generic_read_reservation(s, &dev_key, &dev_resv_type,
+                                           &local_err)) {
+            WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+                if (pr_state->key == dev_key) {
+                    pr_state->resv_type = dev_resv_type;
+                } else {
+                    pr_state->resv_type = 0;
+                }
+            }
+        }
+        if (local_err) {
+            warn_report_err(local_err);
+        }
+        break;
+    }
+
+    /*
+     * PRO_REGISTER_AND_MOVE cannot be implemented since it involves the
+     * physical SCSI bus target ports.
+     */
+    default:
+        break; /* do nothing */
+    }
+}
+
 static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
@@ -347,6 +506,9 @@ static void scsi_read_complete(void * opaque, int ret)
     if (r->req.cmd.buf[0] == INQUIRY) {
         len = scsi_handle_inquiry_reply(r, s, len);
     }
+    if (r->req.cmd.buf[0] == PERSISTENT_RESERVE_IN) {
+        scsi_handle_persistent_reserve_in_reply(r, s);
+    }
 
 req_complete:
     scsi_req_data(&r->req, len);
@@ -396,6 +558,9 @@ static void scsi_write_complete(void * opaque, int ret)
         s->blocksize = (r->buf[9] << 16) | (r->buf[10] << 8) | r->buf[11];
         trace_scsi_generic_write_complete_blocksize(s->blocksize);
     }
+    if (r->req.cmd.buf[0] == PERSISTENT_RESERVE_OUT) {
+        scsi_handle_persistent_reserve_out_reply(r, s);
+    }
 
     scsi_command_complete_noio(r, ret);
 }
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 3e81f44dad..ff92fff7c5 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -390,3 +390,4 @@ scsi_generic_realize_blocksize(int blocksize) "block size %d"
 scsi_generic_aio_sgio_command(uint32_t tag, uint8_t cmd, uint32_t timeout) "generic aio sgio: tag=0x%x cmd=0x%x timeout=%u"
 scsi_generic_ioctl_sgio_command(uint8_t cmd, uint32_t timeout) "generic ioctl sgio: cmd=0x%x timeout=%u"
 scsi_generic_ioctl_sgio_done(uint8_t cmd, int ret, uint8_t status, uint8_t host_status) "generic ioctl sgio: cmd=0x%x ret=%d status=0x%x host_status=0x%x"
+scsi_generic_persistent_reserve_out_reply(uint8_t service_action, uint8_t resv_type, uint64_t old_key, uint64_t new_key) "persistent reserve out reply service_action=%u resv_type=%u old_key=0x%" PRIx64 " new_key=0x%" PRIx64
-- 
2.52.0


