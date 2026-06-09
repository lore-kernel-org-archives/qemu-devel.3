Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C27CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYN-0002LZ-Tt; Tue, 09 Jun 2026 10:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYL-0002K2-T8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYK-00071A-Bx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGeD1zI3ggDIrCAmlMnK5fJi1wnvoZniFOpyG6WU/JE=;
 b=c+TDXmIDv8VSJ0aBq8nHJOl5AoNgjc0aD1WHdm2qJXqwkq0zLWtqRcfjS52LZZ5L5JLWVA
 7z9ILUM7dOy3ZxrF7dnWgHroEPEcTTTZfJniGW1brIO2TNctGI/0o/fldC8NOg0ypvX0vo
 QgPCJv0AtkDguQhq0xlA0hmeatX/IwA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-Q8zQ7gqzO4-2VViSfnbn-Q-1; Tue,
 09 Jun 2026 10:35:36 -0400
X-MC-Unique: Q8zQ7gqzO4-2VViSfnbn-Q-1
X-Mimecast-MFC-AGG-ID: Q8zQ7gqzO4-2VViSfnbn-Q_1781015735
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C513195C248; Tue,  9 Jun 2026 14:35:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01E593008B39; Tue,  9 Jun 2026 14:35:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:29 +0400
Subject: [PATCH 10/17] hw/input/ps2: keep QemuInputHandlerState in PS2State
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-10-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JMFo3VFOQuBSAxO/bJx1/IJb/8LPj7ALKGdmAiibs/8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR4KU3K78DfqR1oRXIcprh8lEBs9YWSC3pCU
 IxZUPNXezKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeAAKCRDa6OEJdZac
 5Uv6D/sEqgFxcgLBE9GGOeEeU5uj6+ouomla2pWedO5C+KCEx2jx0kTsvcwgyiOxiceuHNRxBOc
 G09oSQLsFaH2zGysudTyoSyVcRtPeNc0kUy6lcTY0FARMKZB9zVPG2ElzGLddg6J3S/0uo7B/m9
 9ezp6PNaSVxeWYWYbJDPGqp4t/9mK51Rwv08ZSMv5HmCkUOITMogo8puyGRgAtoUjI1UQ4KTphI
 Ck84EmmWMohGGnUs5+/OzX8QrMEH9LGZBAt/2GCMil0Lw/RZ3TwkKaPLDCBYttnILiFT43ifPm4
 gkIy5lM0Vn6KKMhKV1Q843cUL7qYTHCeKH3Fij+vedphTH8vWvj3O6CEuj3rGIvIotPi1Qxn1T8
 phLcoOsHnEpjDc81sCdoUKGakuAyvpwQsVtnIR4zxpC4YZ8JuVI6Iww18RIcAOm0dLXdyOgZD2z
 JkCGWowea+BRHHnvlLeouh7y2gg3uBecaXRwRTfm6+TK17dTJWTKITQ7kfR6kC8pd8smO/ZEYvy
 ekHIjpyhkUw6lfKV3/Cvtn7SLhf8C0RDlQ+kVV0HPGQKRPuGIC5HIDSBFL6OXVjTTFDbViWCTjs
 378Wqoex7JQQwI9BiZRGQ5yID5thCPSHvZjIk4H7D4qczquY3GjkeS17ycWxgdDKInJhNL02aW0
 btwSKPfuWoE9qAA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Track the input handled state, and dispose it on unrealize.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/input/ps2.h |  2 ++
 hw/input/ps2.c         | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 058db3e0890..d0c532a38f2 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -26,6 +26,7 @@
 #define HW_PS2_H
 
 #include "hw/core/sysbus.h"
+#include "ui/input.h"
 
 #define PS2_MOUSE_BUTTON_LEFT   0x01
 #define PS2_MOUSE_BUTTON_RIGHT  0x02
@@ -59,6 +60,7 @@ struct PS2State {
     PS2Queue queue;
     int32_t write_cmd;
     qemu_irq irq;
+    QemuInputHandlerState *hs;
 };
 
 #define TYPE_PS2_DEVICE "ps2-device"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f2523ff4bc7..97df7a9a43e 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1233,7 +1233,16 @@ static const QemuInputHandler ps2_keyboard_handler = {
 
 static void ps2_kbd_realize(DeviceState *dev, Error **errp)
 {
-    qemu_input_handler_register(dev, &ps2_keyboard_handler);
+    PS2State *s = PS2_DEVICE(dev);
+
+    s->hs = qemu_input_handler_register(dev, &ps2_keyboard_handler);
+}
+
+static void ps2_kbd_unrealize(DeviceState *dev)
+{
+    PS2State *s = PS2_DEVICE(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static const QemuInputHandler ps2_mouse_handler = {
@@ -1245,7 +1254,16 @@ static const QemuInputHandler ps2_mouse_handler = {
 
 static void ps2_mouse_realize(DeviceState *dev, Error **errp)
 {
-    qemu_input_handler_register(dev, &ps2_mouse_handler);
+    PS2State *s = PS2_DEVICE(dev);
+
+    s->hs = qemu_input_handler_register(dev, &ps2_mouse_handler);
+}
+
+static void ps2_mouse_unrealize(DeviceState *dev)
+{
+    PS2State *s = PS2_DEVICE(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static void ps2_kbd_class_init(ObjectClass *klass, const void *data)
@@ -1255,6 +1273,7 @@ static void ps2_kbd_class_init(ObjectClass *klass, const void *data)
     PS2DeviceClass *ps2dc = PS2_DEVICE_CLASS(klass);
 
     dc->realize = ps2_kbd_realize;
+    dc->unrealize = ps2_kbd_unrealize;
     resettable_class_set_parent_phases(rc, NULL, ps2_kbd_reset_hold, NULL,
                                        &ps2dc->parent_phases);
     dc->vmsd = &vmstate_ps2_keyboard;
@@ -1274,6 +1293,7 @@ static void ps2_mouse_class_init(ObjectClass *klass, const void *data)
     PS2DeviceClass *ps2dc = PS2_DEVICE_CLASS(klass);
 
     dc->realize = ps2_mouse_realize;
+    dc->unrealize = ps2_mouse_unrealize;
     resettable_class_set_parent_phases(rc, NULL, ps2_mouse_reset_hold, NULL,
                                        &ps2dc->parent_phases);
     dc->vmsd = &vmstate_ps2_mouse;

-- 
2.54.0


