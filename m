Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0456CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdv-0004OL-Ma; Wed, 10 Jun 2026 06:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdp-0004Ag-Vb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdn-0007FB-V9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8c1FIMKwaYoOTZE7vyDECq+aVQ4SBC6fnh/QYsxx+g=;
 b=USgKzrE6k0ZgQK7BsT+3zuWvASSbz2XNtQ+gtxusw7qbhI2oKq+mDdOAR20sQjD01hmbgB
 w4Q0qSNajz+dvd4deifaVkE60uPmsfJOBBSqEVG/LsN3Vu97Omv9UppHJ/oHGyI0ksVn2r
 IK5X1Is7wPyZ/6uHzHQAuAzMZ7Oghyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-Q58_Y8iIM-e2yTrXT9NGXw-1; Wed,
 10 Jun 2026 06:58:32 -0400
X-MC-Unique: Q58_Y8iIM-e2yTrXT9NGXw-1
X-Mimecast-MFC-AGG-ID: Q58_Y8iIM-e2yTrXT9NGXw_1781089110
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8870F1800656; Wed, 10 Jun 2026 10:58:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 566E3195410A; Wed, 10 Jun 2026 10:58:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:54 +0400
Subject: [PATCH v2 12/22] hw/input: keep QemuInputHandlerState in adb-kbd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-12-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GmSCc22GoNS7ltH+XjMYln3CZYqrnxab3Gc6bVadlm8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMAeVO6phufymg1FE2Gm2zCMJQDr4SGwKDHi
 AgmekUOyL2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5ZY2D/9SXPuumnO54wQdrMTwm8IVIjtwAGJt7btxM3rYRNkNZ0AlK18Z5sSntjdgEwEL2GIaucX
 nUx0cEE6gnQVXCh451qWyuw7Ya03AadcRfUaDhljXHfzLIUzs4dfALLMGoPrR8P0fEd3Iai3j7q
 xx06KikaBIcsxdmxMB9o8JSnb0JwQ06nz15NXDTxE6xoR12+h6NjqcnlMdm2AUPoZ4Tf04tzvVf
 uut/vCWs8SlPyNyw71a8WOHfaJsBtAlUx3sdypgnTHwXenT+YnqZXDVDdz858b1yr3kCfEQP4R5
 szPrX7g1nyaWfsnYXv6IMzQeWg8Cwc+1QXJs5pfvjYAfvuJtFLDxGehOICCo1p1e6/5qcdOaWPS
 6qZcjNySeOP5/UOMbQ+kwbbY23fo48mL7KZydGNHzCkKbJ2HWCm+IvhVbdozqSLX02MU1GfBJUn
 TOAxkaC7UdRrLEPRk0ZY8+1HGIOF11oNFGg1MCMbzzHREM31wCBDkKZ9rJxn2GY+ct+/9ALpSr/
 GQO8quxUwnVo8q+H+RGmJyy5XoKz9tzziXHdXkhZw0Iq2JKDFseScDTivIaCjqlWFiJpI8I22E5
 WKCdbMtbG2s3u9L1S/RBpCPTmuYGHWsFQbCBxn+X0IDcud+EfB369Ze4I0d9rShQ0Gr/SS37eCv
 vXaiZKZn65ji92A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 hw/input/adb-kbd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index c4ef9ebb90c..ece51d5df72 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -40,6 +40,7 @@ struct KBDState {
     ADBDevice parent_obj;
     /*< public >*/
 
+    QemuInputHandlerState *hs;
     uint8_t data[128];
     int rptr, wptr, count;
 };
@@ -51,6 +52,7 @@ struct ADBKeyboardClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
 };
 
 /* The adb keyboard doesn't have every key imaginable */
@@ -361,9 +363,20 @@ static const QemuInputHandler adb_keyboard_handler = {
 
 static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
 {
+    KBDState *s = ADB_KEYBOARD(dev);
     ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
+
     akc->parent_realize(dev, errp);
-    qemu_input_handler_register(dev, &adb_keyboard_handler);
+    s->hs = qemu_input_handler_register(dev, &adb_keyboard_handler);
+}
+
+static void adb_kbd_unrealizefn(DeviceState *dev)
+{
+    KBDState *s = ADB_KEYBOARD(dev);
+    ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
+    akc->parent_unrealize(dev);
 }
 
 static void adb_kbd_initfn(Object *obj)
@@ -381,6 +394,8 @@ static void adb_kbd_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_parent_realize(dc, adb_kbd_realizefn,
                                     &akc->parent_realize);
+    device_class_set_parent_unrealize(dc, adb_kbd_unrealizefn,
+                                    &akc->parent_unrealize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_kbd_request;

-- 
2.54.0


