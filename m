Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E0C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2O-0004Qt-8j; Wed, 11 Jun 2025 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2K-0004Pd-G2
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2I-00074s-LT
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AW/pwmZORZx+McBlT7cscgzaAVx8u1KbpDgUZMs5o20=;
 b=gtNS4TLwXlc6ifU5FB3vGJ1X91pXlrZZSVA2cA20krJhrwJzMjgeM9GK6WQBqrHKS0l0eD
 wh1+KWcMdEFhSUVo7eBHZ1smF1tcFz4ejKBUgF5E18jnC4qYzlQN6Kd3M4Jnb52eFI3XKN
 Q4ZkRQMSKDC/t55Ez3MIItmhAK/+YJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-b5Kr2RgOP8yfC_Za46Gg3w-1; Wed,
 11 Jun 2025 11:06:38 -0400
X-MC-Unique: b5Kr2RgOP8yfC_Za46Gg3w-1
X-Mimecast-MFC-AGG-ID: b5Kr2RgOP8yfC_Za46Gg3w_1749654397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63B4A19560A1; Wed, 11 Jun 2025 15:06:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 803AD180045C; Wed, 11 Jun 2025 15:06:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/27] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Wed, 11 Jun 2025 17:05:57 +0200
Message-ID: <20250611150620.701903-6-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Rorie Reyes <rreyes@linux.ibm.com>

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250609164418.17585-4-rreyes@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/ap-bridge.h | 39 +++++++++++++++++++++++++++++++++++
 hw/vfio/ap.c                 | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
index 470e439a98ed5306dadb29f7507ca880756eb13f..7efc52928db15c429b2486e09e701b5cc4a799f2 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -16,4 +16,43 @@
 
 void s390_init_ap(void);
 
+typedef struct ChscSeiNt0Res {
+    uint16_t length;
+    uint16_t code;
+    uint8_t reserved1;
+    uint16_t reserved2;
+    uint8_t nt;
+#define PENDING_EVENT_INFO_BITMASK 0x80;
+    uint8_t flags;
+    uint8_t reserved3;
+    uint8_t rs;
+    uint8_t cc;
+} QEMU_PACKED ChscSeiNt0Res;
+
+#define NT0_RES_RESPONSE_CODE 1
+#define NT0_RES_NT_DEFAULT    0
+#define NT0_RES_RS_AP_CHANGE  5
+#define NT0_RES_CC_AP_CHANGE  3
+
+#define EVENT_INFORMATION_NOT_STORED 1
+#define EVENT_INFORMATION_STORED     0
+
+/**
+ * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
+ * change event
+ * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
+ * data
+ *
+ * This function checks for any pending AP config change events and,
+ * if present, populates the provided response structure with the
+ * appropriate SEI NT0 fields.
+ *
+ * Return:
+ *   EVENT_INFORMATION_STORED - An event was available and written to @res
+ *   EVENT_INFORMATION_NOT_STORED - No event was available
+ */
+int ap_chsc_sei_nt0_get_event(void *res);
+
+bool ap_chsc_sei_nt0_have_event(void);
+
 #endif
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 681fd4a4f1cb861cb287fca9ce2134e55ec20323..874e0d1eaf1dafa105f9f42705e9973ffc719803 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -10,6 +10,7 @@
  * directory.
  */
 
+#include <stdbool.h>
 #include "qemu/osdep.h"
 #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
@@ -101,6 +102,38 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    APConfigChgEvent *cfg_chg_event;
+
+    WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {
+        if (QTAILQ_EMPTY(&cfg_chg_events)) {
+            return EVENT_INFORMATION_NOT_STORED;
+        }
+
+        cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+        QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
+    }
+
+    memset(nt0_res, 0, sizeof(*nt0_res));
+    g_free(cfg_chg_event);
+    nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
+    nt0_res->length = sizeof(ChscSeiNt0Res);
+    nt0_res->code = NT0_RES_RESPONSE_CODE;
+    nt0_res->nt = NT0_RES_NT_DEFAULT;
+    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
+    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
+
+    return EVENT_INFORMATION_STORED;
+}
+
+bool ap_chsc_sei_nt0_have_event(void)
+{
+    QEMU_LOCK_GUARD(&cfg_chg_events_lock);
+    return !QTAILQ_EMPTY(&cfg_chg_events);
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
@@ -197,6 +230,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
+    static bool lock_initialized;
+
+    if (!lock_initialized) {
+        qemu_mutex_init(&cfg_chg_events_lock);
+        lock_initialized = true;
+    }
+
     if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
-- 
2.49.0


