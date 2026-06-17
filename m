Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE3CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8X-0008KL-KJ; Wed, 17 Jun 2026 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8I-00080J-6k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8G-0004PE-7Y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fyg+V/YGlQ10OA7N0ZvlQJ2lOYS9yJAZDhN3+859L6s=;
 b=TiuqFzUvVImWK0+7Jj3hpg4YG0/yuOwLpovJ2S6JfX8BSOooe4yFgHpSfQ4Qp0675XVW6J
 h06qa4aj68/myW8QhGpAuS0KrD7/BvkHOwxkdX3whkEp3YfPzNaus9z3UakHLY8jdMqAT3
 f9Z6f6UdB6W5EVwB9yjNr+ElprH480E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-UhAq3ozSOHy7mRHwa__jXA-1; Wed,
 17 Jun 2026 11:24:45 -0400
X-MC-Unique: UhAq3ozSOHy7mRHwa__jXA-1
X-Mimecast-MFC-AGG-ID: UhAq3ozSOHy7mRHwa__jXA_1781709883
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E88F1945CAC
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DB6436918; Wed, 17 Jun 2026 15:24:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:11 +0400
Subject: [GIT PULL 14/27] hw/m68k: keep QemuInputHandlerState in next-kbd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-14-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DBBYHwbqJbFwGl+d/VFOQNwyJmVR5Qb+sHR1dfLAJ5E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpvPM7B9Vbo1UPKodmRkopX38wjVUQV3x1S
 efqsN3wUViJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5TrcD/9s3pylvGUZ3wmn4vQjxz9DPzhW7uFt1iOSK8Yc9LXkU8qTPf0OHG+9dL1JilzDwDl4Ty2
 naQGTRHMPITvLHoMJ5yiaWXUdoTTi2JJWq5LUANS0RUfODJTO37DWdBc3AbkgqGsxZr1l3pUYik
 MCXjEyDB3Hxp4c5UIiEx2fD7fsYsKAgGNDK18cHTTIUGRa6s6qWbOFe8IsQJ4B9Tys8HuWniLwA
 11LBD35jBzH2HLT42ebfsWwtCotrdZjr9cwoOqkqs556ARl/vwu7w5h5UEFMOzmov5MEvVPgP80
 BURZpCykC6V5iAEIJ7+AVb8DoYFQDFrwJaD6YCjRmc4KCswv/ZaaVNgdTnurST5MMdKDde3dzrf
 Uw6IAk+zmpythOA6zZiyN6IllcTnhemrMg3Q/0PIB4qftMFB4L0aSDPH3CCuAD0pVaa/Vv5FckX
 RSjeSYTHSYSvz8ZDskRtJStEWb1mvXZQio2hHVlzNileTPvRZqunYSEDLOk42dijFDqTi3Ug8fb
 7dRlkhXzl8meufJtSJhjyFgk48aYKsCmXZEGh24cF94pmy+Us8wT29URTRLlaCURyZbqHek6gff
 QaAGHFdCqFe62lYa2fthLA5ZRs+DR0Z/jVD0/7j0h3t4FEXSI5lB9AzWt4JevzcSZWdl/vEg7Id
 c2RKMlg27+8ZUKw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


