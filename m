Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCDCC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraCX-0001Nw-Ev; Wed, 05 Aug 2026 07:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCR-0001Js-92
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCP-0007Q6-G9
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHSJYHAh8P51d2wOrkpD/aaXu8nPUjIU+7SM2v0XY2o=;
 b=i6T58KwI8tfWkkUhuHh0lKmLbz7Y/AJS9wiBtNjhr8uQFrOxNKDFnFGezNyUzKXLEA4N6y
 k6JXiOTmTv17f1bPS+3XApZOQ82uxGtHrKypxQ299kApONsIh7PanvJMY5mRcCA13TwQY0
 SmgH43uEJyMCRfYEx9+AiPMNzUm88w0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-APumHMs-N6e1J9zdrTbzgQ-1; Wed,
 05 Aug 2026 07:54:13 -0400
X-MC-Unique: APumHMs-N6e1J9zdrTbzgQ-1
X-Mimecast-MFC-AGG-ID: APumHMs-N6e1J9zdrTbzgQ_1785930852
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A902618001D7; Wed,  5 Aug 2026 11:54:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 105CB422; Wed,  5 Aug 2026 11:54:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:07 +0400
Subject: [PATCH 17/27] hw/usb/dev-smartcard-reader: fix pending queue migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-17-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SAviAdY4YXb4F2wTQFY6tqn5wKJuu3AagelCrnSXmKI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOuGeeHSPj2J1ujiZvJj34QtLAQEICiT04ce
 yEuSId90cGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5dyZEACPr1AELHe9knVSGYhxYrZ+xw33dMuzVFf5IHPrNziFvRnejU/XirO+rndEzulPF/N91OA
 G7yUC+PsEuTnODsc0uFwzXkWDx4Dks0lrQqGWfKkO8Ow6a1qI1HsnAYsit86v0Ght0uD2OVsBXx
 pSiuYqm/m64Vq7v7IA9XV60aQy41XnorOIJug9kxSyws5XazvFCwvTWCY9Jpm3n+bQbkyt7SGti
 9AAsRKM7nIWQdhyRA6/UL8k50d/UmdshNplJyFHzqrQc9TNEt4mTlZVR0lPk9aIYD/O5msOKKoQ
 582PngQW0ZsE3IBeTxjUQQPSLlfSdrGSS0YWiPZx+BzWIBAxv29c681omQyeI+2QQg89mbeAVW0
 e6nU4w9M1vgQWoNh2RheuE6DnylkGfje3/HN3SZ488jCItfudHhXWfCFPIuXQY6LHaHCrnJiaCA
 kqbcMiCIqHUW/5yJ7xpG/ply6RoMs3OEsxOiIeCWqYxs3Damwo3PMhRGmAAHynuKevWHOTeEf7K
 9vkFFm0EfR23VUBOxpbClPgnOJ35TXh+S2yjcCUvf1hCSTZOR0aItorOpeqlDH4Yr9N4GgcvQlt
 hYgbBxOxCjVlfidU37WZ0yMyMuo51z04PnmQyj3wb8fvihyt6pAALp9EENyGULPAiw1pliE9V6w
 jFyCmw2cBmhZWfA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 70 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 01e50ebe05e0..28842f53ae4f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -52,6 +52,7 @@ GlobalProperty hw_compat_11_0[] = {
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
2.55.0


