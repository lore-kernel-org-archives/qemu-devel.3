Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB61CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs87-0007Mj-K8; Wed, 17 Jun 2026 11:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs85-0007B2-EX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs83-0004M6-O5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=veqIheazVSNeAGffIbSjjrfNv+j5lmphVNvLCzpp0bU=;
 b=bZVeoAjLvLV26PGPX6bNWks4F2ELRXO8pajd/ANHL7wYWXaRGzyHRpsrFcVsspFr5qXtCN
 B/jp/LR1qLvex6eJRtUFppUa9S1pccw6/vzgem+5H6v1jX7VyoEHwT+6NKB77LZvgOv8++
 H0V/S8lIhNwhdZ+FsC7dQXkGza1JOrI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-Xbq1eLy3PT6wZucnsSsyDg-1; Wed,
 17 Jun 2026 11:24:34 -0400
X-MC-Unique: Xbq1eLy3PT6wZucnsSsyDg-1
X-Mimecast-MFC-AGG-ID: Xbq1eLy3PT6wZucnsSsyDg_1781709873
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A6061800581
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2C661955BC2; Wed, 17 Jun 2026 15:24:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:09 +0400
Subject: [GIT PULL 12/27] hw/input: keep QemuInputHandlerState in adb-kbd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-12-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SZvZzOXK1/3PzlA7TyLmVM26YUEPvp9224SDkFz4kOY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpXrTL8SCk7W2NDya1sAAQqi8f4qPFkG1t/
 mveKWuArrOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5e5AD/9dT96c66BFsQugNv7WuRNfd/TakoDlt82OOaO8duuDjjk63dDmgsKwI14fGxaqQ/xaMrS
 n/YOzesJ7doX6h42aEjGEb3il2fzvCV9v7iWMgLuu/DRMHoY4DY6odT9LlbsIRs/uAPde2YcuXu
 Auz8x58J+/FbxirI52v16DYz4vyCwPoW0Sf3dKMmG6Tp3osTxxqNbSevCtni76p+fuYqQsQZ3nJ
 dcukwwLM+LrOTSHUSS7RJmprgZsfG7AAtIBNI5F/tBr8LPuDrbDbu/gYR0sheWHuRaADH1UO+9w
 m6uz+ZlRxSHKu5Ohm+TSYXFc+rbg2y+Ke5XeLbh7dthv7Y+/MICltHlQYppHhxupLgnEyg/v9PK
 8H39URVo15MTASVsjNUrMLGJ+PB4PDh7hy5NG0PyUhdrTHBFH8ycdKiLmQk4ZpWCILaq9mmCTCR
 G6AcQMBO0WPx/Ex52Di3hoAsWY7FJruHAHQlyt4zsZw6YeL/muPJn1JZZOj4blQoiAtEudPQaq7
 fKKXyBVsUVMY8icKANSvYIsfKAiqVo6jkT6umieupUxibzU7/6yRMZ6ERvDwhRXgwc42ZV5EBiQ
 Z6CNwQHCpE4Sa4885PAKzkcRnX0mavM8YtERzNQYdojqrx/ae9ZnJxshq8mRHVg/wpzIw4+SjmK
 hnKlpSK5jCi+71Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


