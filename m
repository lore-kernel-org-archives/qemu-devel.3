Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A78CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdc-0003bt-7K; Wed, 10 Jun 2026 06:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGda-0003M4-D1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdY-00075A-Mm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThQPvh/6KMck6XC4Go6k9daunEMDeU/oyPrV5UqYbus=;
 b=aaYD08hrqKqiAqil+Z417TYFIqMDWsrZWVjtltvppqJUjojpD7hhY4Co6G6sBd2EdXhgqr
 hy7FDIXsvFz88tiSr0k9cKT2FamgJ7N2wxVCQD+8zWqP3TOXI7B+XRjps74XzUNn1mdDHn
 sy+nneyRnzEaR1y2xq4/eeiShlXYspc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-q9b2zmKfPHKtTqTkXBuZmA-1; Wed,
 10 Jun 2026 06:58:16 -0400
X-MC-Unique: q9b2zmKfPHKtTqTkXBuZmA-1
X-Mimecast-MFC-AGG-ID: q9b2zmKfPHKtTqTkXBuZmA_1781089095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D12BD180267D; Wed, 10 Jun 2026 10:58:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86EFC3000223; Wed, 10 Jun 2026 10:58:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:52 +0400
Subject: [PATCH v2 10/22] hw/input/ps2: keep QemuInputHandlerState in PS2State
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-10-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HRbJvGcvY/gPmNkSLQ78JPU6/EdaocsZHw4YvB7qXuE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMAl2/dYRYAMIc8DUL+7/tCb2SsFSSeVtmLp
 cUCsPfgVx+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5WHGD/0d8kJfPqiPILqhE7IYpr7k5O9/AXCo23IIdU63YRdHtKVc/+PEo+PIW8egYioawHIW1sD
 Uo0MtzjENAK6LJb/dPxKs5HjaoX4evMa3lmgqiiHY1vqz3h1z3GDrZTszptFUokKYFudepiB//8
 o7GCOQ9mEdS/b52YqjV7AfzySba3fNn+TB0KVubclapwxfz2GudZxqO5VYYItHubBmdRuAz8ZVX
 fi+Lm7p/p9wM5Jc+ew8+LvrUwA01+3y1Ywy/3KWardvK411hUSXEWbz5uBBZMB4BJGE+CE/7fqD
 7LRk0Uy9252irX/om0NPHprJM2d6PCbsUDKf7UmChkL/UX2rJKq8TL0edU4WFir056l0VruFMd8
 rH+B/2YrLFfluxATSXPzkz4T3n3AmSf0+t2f2N6SKQTp2a+Wvrqs1yzyae9op5oplRoqPruD76b
 NfQ/488QJswiCf4Kq8wzJAZDedoxMbz1gJLCMNZbnhz7BzjUeFhGf9AVqL2kJy7WsgO4CprdZn3
 BhI7fsPI0RwLLIsgoPqf6XYP9T+m3wWArCJNG56JaVVgWWeSVId1rkGbwJOwvZKpTBHDOEYBHP/
 SDB0aGOGhC/Bo4I1FbC1UTtZhtXck84UEC8ImKa13QFxoYpo0Go4Sw0cN3E75nmq0fvfYLVAzkA
 ZU41fLUcvKWacAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Track the input handled state, and dispose it on unrealize.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


