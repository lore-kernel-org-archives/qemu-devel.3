Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8C8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdy-0004YT-HG; Wed, 10 Jun 2026 06:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdw-0004T3-FD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdt-0007N0-Gv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lginq05kULLa0WOrt+nJYrmjrMyTghx9mx56okfUJWI=;
 b=i1UWofO7S+QfxIIZ13HBH+rk6Ji7VdcB30naB0TWt3g3J6vpXrK/aht8WNOH/FjukUiWHT
 9IB7MDx7jd1spJXHe9Rw1Df0XdsG+9SAA3EqgfoUXdaDGne+tyH6CYSbbXoM6oupe9vagP
 n9EOXvLIhj11/uXBjVcYNFJ0zVF3Gv0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Nf_PqFIqNKKuTM2MkA_xsw-1; Wed,
 10 Jun 2026 06:58:37 -0400
X-MC-Unique: Nf_PqFIqNKKuTM2MkA_xsw-1
X-Mimecast-MFC-AGG-ID: Nf_PqFIqNKKuTM2MkA_xsw_1781089115
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7BD119540CC; Wed, 10 Jun 2026 10:58:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D5B1180057F; Wed, 10 Jun 2026 10:58:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:55 +0400
Subject: [PATCH v2 13/22] hw/input: keep QemuInputHandlerState in stellaris
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-13-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=31dKGmjQ0ucYg8DBaj+bqrZrM6KhG0cYtmReIw9YdWs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMANB/B1BjoTx7etAXnd+O/dqm0zB8rk16v+
 gQvRkPtKVCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5d41D/9ha7dg3IdRYdl7vrNGf5174Zn+VxVT+Ipo8GLzqKuTeABvkPNT8sueEPatQUJpvG7gzMb
 hXBY3ysve+Mzzc/CiSmBqf02eW3Ej3kkxKeQ46AQDZsFVKltPpfhwctJXonLV1K6B2wSt93k59U
 hi7TAYPd2YHRz5aiSd0IPIXEehFgAji1x6/m/XN9TWRSY/9KKKchyQrKRAIMY3A+RTcctkimMc/
 W6sHQPHB3VOaZTzjKZQgx8pLH+NdEXF5oNbYU7dvZBrZR0irUjAPeDZXzOLwR7gnKLaH88no+Z1
 KrdJ1td19/7oh24XYWiC6tTdxBo+T33YvtweEG5DeRmKCFyz6Ym8dnRozXrPYlRFLKPK5bYQiqE
 HQSbnWyMdMuYBltM0zhCx+jR2zduaX8pbO08/WQL8rCxbX5OpemyH548c0MF9tU/Q+e2RCRbB8j
 YI82kv8GiXSCONSxs6wOB5fWJ54LcXwpC6VmzSMWiG2/hDpmBgP5K6Y47oW3s0Y8Fjbvv7PPOyp
 lSi3ExruBE/Fdl8P5gRvyeljjrcl+DcpIjReFwvshQx2iGTcsSnQnrXfH04h0+VIht2E/El0pPO
 nnhyhkQLdzGg/A67ZJEt6DTHK8cwf8Y9qcYUn5UhkBkvXfJTIj17h5j8jafwXPuDUyXtklM5EFP
 NTCfJX5qGVjbLNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Also free some allocated fields during unrealize.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/input/stellaris_gamepad.h |  2 ++
 hw/input/stellaris_gamepad.c         | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index e011482646f..c1069735010 100644
--- a/include/hw/input/stellaris_gamepad.h
+++ b/include/hw/input/stellaris_gamepad.h
@@ -13,6 +13,7 @@
 
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
+#include "ui/input.h"
 
 /*
  * QEMU interface:
@@ -28,6 +29,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
 struct StellarisGamepad {
     SysBusDevice parent_obj;
 
+    QemuInputHandlerState *hs;
     uint32_t num_buttons;
     qemu_irq *irqs;
     uint32_t *keycodes;
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 25769fc2616..376d91abad7 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -59,7 +59,16 @@ static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
     s->irqs = g_new0(qemu_irq, s->num_buttons);
     s->pressed = g_new0(uint8_t, s->num_buttons);
     qdev_init_gpio_out(dev, s->irqs, s->num_buttons);
-    qemu_input_handler_register(dev, &stellaris_gamepad_handler);
+    s->hs = qemu_input_handler_register(dev, &stellaris_gamepad_handler);
+}
+
+static void stellaris_gamepad_unrealize(DeviceState *dev)
+{
+    StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
+
+    g_clear_pointer(&s->irqs, g_free);
+    g_clear_pointer(&s->pressed, g_free);
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
@@ -81,6 +90,7 @@ static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
 
     rc->phases.enter = stellaris_gamepad_reset_enter;
     dc->realize = stellaris_gamepad_realize;
+    dc->unrealize = stellaris_gamepad_unrealize;
     dc->vmsd = &vmstate_stellaris_gamepad;
     device_class_set_props(dc, stellaris_gamepad_properties);
 }

-- 
2.54.0


