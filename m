Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FEDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGe6-0004zh-OQ; Wed, 10 Jun 2026 06:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGe5-0004uy-4b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGe3-0007cf-MF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7UMc9Olibe39PMu1zZm86wMxYjIQkDMmyXGtriuq+A=;
 b=LxZaxqWyseuXoOjwSGGO53+Rsv8XaEoGQlGwDrXaGCaWg7MJSLi5beUsK64MMFfkwTnwjf
 2xizXKNtNgqL8yAXGu4cACdjxBPvwrZPGnMQp8haXN6XuK+soi6O52UoiLtvBGhrTAIvw9
 eNPtVzyAbv9XfMrJEVAM5g/DSE56oYc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-NHmnLpk-NKyBl44V5LRyiA-1; Wed,
 10 Jun 2026 06:58:43 -0400
X-MC-Unique: NHmnLpk-NKyBl44V5LRyiA-1
X-Mimecast-MFC-AGG-ID: NHmnLpk-NKyBl44V5LRyiA_1781089121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CAC118009DC; Wed, 10 Jun 2026 10:58:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF1083008B35; Wed, 10 Jun 2026 10:58:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:56 +0400
Subject: [PATCH v2 14/22] hw/m68k: keep QemuInputHandlerState in next-kbd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-14-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4Pla2htVz5YE2pGrHqAWgYdSRFlBor8jDG+m/EG6xN4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMABWdcufUUdygn8eQu/IxUkR2C3U/5HafEW
 1q+pVP5/oaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5WA7D/40oHrucQ7s4qu7LEzBE8Yj6uh30x5c6VqKfwA0U7Vu3csLSq/2RWJ8Ov4dgzZDWCSkU5v
 qkIuBWhgVKomC/kR9l9jThcrAgwIU9OxYNeppiubJHtI4/KkyOJiSJPlt7mJNfaiFB65vuWarV5
 ymun1qcKKKmkOV8oDrFb9j88J+oLI2AvNCpOZHVqYEXigAX/DfCmmGhhWspJ16Fbf+lksT/CBay
 BQvF74C4SrQ2W968dN1WbYRmZqyh4yy+iN8cnSENtCfv9JrtGM6HFQCi3/gebyoS3RxVyC3zO4a
 FZBJTuw0cYVE29okcggtxGsb6MioD3Nc0HpJbQj7KDzlcxtnNjvxOwrJfP5jrVUI/eB+mDn4Z8E
 mLaOmPvoJgVocn4a4VCDGoFjZtiXAHRZ/1gcTPHhTx4joMKl2BI6U79CXa+w1i0gZRum2tHsurN
 yukC4tspM9CGOEqw6+DAAUh20pSGv5NrKCz3t7F0bkUVJd33hBRFu5QjYQ2y/Mw1xQlp5+J8I1j
 PZpW0HREuZ9uYiSlYVgbPbm5fl3rWp/NpMTASOch4z+6eoB4sWHUoFftnsfu5V9jXlutMDTtp6U
 3qYvt74Z0zaP+wRgAldKF/BJA6eF3OxrgWSTpcU9/6gNVOdyDfwMG/KUvLAb8kDEyhrw+UI65yk
 5Jb0bbq7hW7rXoQ==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/m68k/next-kbd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 7be5ab2fb79..84a610edab2 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -65,6 +65,7 @@ typedef struct {
 struct NextKBDState {
     SysBusDevice sbd;
     MemoryRegion mr;
+    QemuInputHandlerState *hs;
     KBDQueue queue;
     uint16_t shift;
 };
@@ -304,7 +305,14 @@ static void nextkbd_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
-    qemu_input_handler_register(dev, &nextkbd_handler);
+    s->hs = qemu_input_handler_register(dev, &nextkbd_handler);
+}
+
+static void nextkbd_unrealize(DeviceState *dev)
+{
+    NextKBDState *s = NEXTKBD(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static const VMStateDescription nextkbd_vmstate = {
@@ -319,6 +327,7 @@ static void nextkbd_class_init(ObjectClass *oc, const void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->vmsd = &nextkbd_vmstate;
     dc->realize = nextkbd_realize;
+    dc->unrealize = nextkbd_unrealize;
     device_class_set_legacy_reset(dc, nextkbd_reset);
 }
 

-- 
2.54.0


