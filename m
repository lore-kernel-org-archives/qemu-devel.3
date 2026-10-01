Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74003CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGtU-0002D2-7C; Thu, 01 Oct 2026 09:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsE-0008Ar-1e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsA-0006P6-W4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZUO+N+iFLVdWfP5JZWA+I6Hf84H1L+rJV/aCMuk3dE=;
 b=baaul12HyDoylPuCo6lg3hAisVBf1fGK0RX/cOeUm/9LjKvfaU7sW4vh/L00060vhBbPoI
 AXDP5zIXsrIuV1T3uxCRqFBzWEQhS/+FC6ayZXdCbq9MevLgVuyC8Exwtv19Dui+wMdkCE
 SE0b20PLRzugTutxONfoY20QjY0Dpew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-zNnFAf7JNNe-tfefAXSiqA-1; Thu,
 01 Oct 2026 09:30:48 -0400
X-MC-Unique: zNnFAf7JNNe-tfefAXSiqA-1
X-Mimecast-MFC-AGG-ID: zNnFAf7JNNe-tfefAXSiqA_1790861446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E3F31954209; Thu,  1 Oct 2026 13:30:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC9A11956086; Thu,  1 Oct 2026 13:30:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:56 +0400
Subject: [GIT PULL 17/27] hw/usb/dev-smartcard-reader: fix pending queue
 migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-17-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5970;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MC4KdGeMrdRuJwsOCRfJidfJ/pgfrIwMkZf/D2hjl+o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBI9X+v02ay5uJCCVFjgWiX1mOdwGmdgkP+F
 h56lk8rzlCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5au7D/9Sjo7L3gDDvBTtZ+iZy3ZmFgiL5yZF9jHOUg1WPXUCk06DSpW1PbeFnSBBo8FsN4CKOkj
 uDos529nry9yquFhOlistLz4u7f08wxcBEkI72Kto4y1Cu6Vj1GwxQqLjaylWXDHNsmih1ZbFGB
 +opXL+j5De6Or7LitBlyZAEel3gF2MtmnP6jq3tBBCrqCP/QlHY9p90AJofA8yRMlHzTUPxaO//
 /fm5ViVQ5DLZ9iKKIR6RfAif0Rr+AcgRg46BKOwAfljipf5XQZM4tp6cj2PNX24B6ff0YsN7DHe
 /T1jN/O9EdKdKNSAE/0HryJMa9TgQ44NcAKS34hZ1dI+Yd+4cNpJagnnKMqmXEhteV0x1anuEyu
 2KBBa/sbFVnA/IvijootAcyz81GqYad57qx5REeUa0q1d3HW0wmIj4InZ+xEgApD2qVG0V/b2AC
 +PWVDBsiyW06a1ArW7TV8Z23S42lJUWRg7ilJrvPlZ7m7eIFRNl9+RIlDI8PmegUp4UUEpiUNUI
 Ylq40lOOJ67Zexy7B2nSmpuhrDljhb8WO3e1qPTWMJBkVJ37Hu/ikuczGS/Lr28C8TJlpBPVzHi
 Fue3a1LBcrvfKt03n3HZqxmzxYo55bYld0yT4XCJ4VXWbdJopuXJqtnb9KO+Z7Tr43J5CGGocdO
 AhRmh3G/ATzALjg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The original vmstate migrated the bulk_in_pending and pending_answers
arrays but not the pending_answers queue indices (pending_answers_start,
pending_answers_end). This made migration silently lose in-flight
smartcard responses.

Add a vmstate subsection "usb-ccid/pending-answers" that migrates the
missing pending_answers indices. A compat property
x-migrate-pending-answers (default on, off for <= 11.0) gates the
subsection so older machine types keep the old behavior.

Populate pending_answers_num in pre_save so post_load can reconstruct
start/end when loading from an older source that lacks the subsection.

When the subsection is absent, post_load derives pending_answers
start/end from the legacy count. Validate all wire-sourced indices
and bulk-in entry bounds on load.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 70 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b30849d6f769..4aa5df13f386 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -58,6 +58,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
     { "usb-ccid", "x-accurate-message-length", "off" },
+    { "usb-ccid", "x-migrate-pending-answers", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e3c86cb90e6c..5ca50c111217 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -312,6 +312,8 @@ struct USBCCIDState {
     uint8_t  notify_slot_change;
     uint8_t  debug;
     bool accurate_message_length;
+    bool migrate_pending_answers;
+    bool pending_answers_loaded;
 };
 
 static uint32_t ccid_bulk_in_pending_num(USBCCIDState *s)
@@ -1409,16 +1411,35 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     s->debug = parse_debug_env("QEMU_CCID_DEBUG", D_VERBOSE, s->debug);
 }
 
+static int ccid_pre_load(void *opaque)
+{
+    USBCCIDState *s = opaque;
+
+    s->pending_answers_loaded = false;
+    return 0;
+}
+
 static int ccid_post_load(void *opaque, int version_id)
 {
     USBCCIDState *s = opaque;
     int i;
 
-    if (s->bulk_in_pending_end - s->bulk_in_pending_start > BULK_IN_PENDING_NUM) {
+    if (!s->pending_answers_loaded) {
+        /*
+         * Version 1 did not migrate the pending_answers[] queue indices.
+         * The historical interpretation of pending_answers[] as starting at
+         * element zero.
+         */
+        if (s->pending_answers_num > PENDING_ANSWERS_NUM) {
+            return -EINVAL;
+        }
+        s->pending_answers_start = 0;
+        s->pending_answers_end = s->pending_answers_num;
+    } else if (s->pending_answers_end - s->pending_answers_start > PENDING_ANSWERS_NUM) {
         return -EINVAL;
     }
 
-    if (s->pending_answers_num > PENDING_ANSWERS_NUM) {
+    if (s->bulk_in_pending_end - s->bulk_in_pending_start > BULK_IN_PENDING_NUM) {
         return -EINVAL;
     }
 
@@ -1447,12 +1468,14 @@ static bool ccid_pre_save(void *opaque, Error **errp)
 {
     USBCCIDState *s = opaque;
 
-    if (ccid_pending_answers_num(s) || ccid_bulk_in_pending_num(s)) {
+    if (!s->migrate_pending_answers &&
+        (ccid_pending_answers_num(s) || ccid_bulk_in_pending_num(s))) {
         error_setg(errp, "usb-ccid has pending queue state which cannot be "
                    "migrated safely");
         return false;
     }
 
+    s->pending_answers_num = ccid_pending_answers_num(s);
     s->state_vmstate = s->dev.state;
 
     return true;
@@ -1493,10 +1516,43 @@ static const VMStateDescription usb_device_vmstate = {
     }
 };
 
+static bool ccid_pending_answers_needed(void *opaque)
+{
+    USBCCIDState *s = opaque;
+
+    if (!s->migrate_pending_answers) {
+        return false;
+    }
+
+    return ccid_pending_answers_num(s) > 0;
+}
+
+static int ccid_pending_answers_post_load(void *opaque, int version_id)
+{
+    USBCCIDState *s = opaque;
+
+    s->pending_answers_loaded = true;
+    return 0;
+}
+
+static const VMStateDescription ccid_pending_answers_vmstate = {
+    .name = "usb-ccid/pending-answers",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ccid_pending_answers_needed,
+    .post_load = ccid_pending_answers_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(pending_answers_start, USBCCIDState),
+        VMSTATE_UINT32(pending_answers_end, USBCCIDState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription ccid_vmstate = {
     .name = "usb-ccid",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = ccid_pre_load,
     .post_load = ccid_post_load,
     .pre_save_errp = ccid_pre_save,
     .fields = (const VMStateField[]) {
@@ -1523,13 +1579,19 @@ static const VMStateDescription ccid_vmstate = {
         VMSTATE_UNUSED(1), /* was migration_state */
         VMSTATE_UINT32(state_vmstate, USBCCIDState),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &ccid_pending_answers_vmstate,
+        NULL
+    },
 };
 
 static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
     DEFINE_PROP_BOOL("x-accurate-message-length", USBCCIDState,
                      accurate_message_length, true),
+    DEFINE_PROP_BOOL("x-migrate-pending-answers", USBCCIDState,
+                     migrate_pending_answers, true),
 };
 
 static void ccid_class_initfn(ObjectClass *klass, const void *data)

-- 
2.56.0.rc0.29.g47ce80527c56


