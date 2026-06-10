Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdo-000472-JV; Wed, 10 Jun 2026 06:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdl-00044h-9D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdj-00076t-CH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3x98RLTDQDDbBc3k2+DOQ4NJcU8pbjelIglG1thHGM=;
 b=DniyinTf8PsDGrMYIvTZ+LeI/4WSfoHFrgqB89xTjyfk7D58OCR3Itqib7FjFv2CbTU+T0
 oec/OefAHpGGKDrWOXQdzmSh6p0JO93HBuYLc3iP6Gai2ifcnQfxi50vmVks1Dmv4tc9A4
 mUZGX+4A6w2w4uAdet3ZiC2ZqUt9br4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-jBSZrDqCO16aXq5NegReVA-1; Wed,
 10 Jun 2026 06:58:27 -0400
X-MC-Unique: jBSZrDqCO16aXq5NegReVA-1
X-Mimecast-MFC-AGG-ID: jBSZrDqCO16aXq5NegReVA_1781089106
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B2281954111; Wed, 10 Jun 2026 10:58:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 955851800599; Wed, 10 Jun 2026 10:58:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:53 +0400
Subject: [PATCH v2 11/22] hw/arm: keep QemuInputHandlerState in musicpal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-11-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u6RG46vN0H5nTKZNkw4st/d2Sfo+DtW0qvBbkOugEy4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMArNhxzoUTPa1V2FymHQneqUWmH7TotSoj+
 Evc0EapgsiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5ULOEACcYBgo9zeOU4C6MpdEyOBaiNt0ogoVWzZSqhbs9gJ8idctbpP0m6EF0srJ8ZxX6NLjN4J
 9P2IuMTO2fWx9JGYksS/FGkBOmfacU+5z/ISKmHIj5P0k0vAbRjUrW4XQ9uaRxHUHPlHZH7cz07
 yW7llNCunceGQPd10sqrbaXRazvmLXP26pL16DToWgj7fh1fcOz6ugME5vbm71qTnq4bmrwG1zj
 7DoZEAq3zFdZTvCqeaImhDt//flKNxfaGklYxZ9RAebS2WUM9udj+UCZQz5Owtbg7BhRxzSlsy7
 J8U/yQEQvgNppfyy/1XYNeqgdvm+k8JZH5yImxYubbCEmyZ3tAhciE8ZY2hWZZED38KWSP10Fkl
 sXLET0aBIgJ+FHJDdLpvVLIXfNCBi4fbqRQjpNt3yifdRIEmxfBK2PL3tnR3HDg1o7Bo2LcF1n2
 u+qb9njPjuj60pCEUcfmqR7Ut2XYUmDvjsOgPYGKShCic4B0iq82XzamoURfK0uvSV8VjY2+vPj
 PV0bwWyQKHuYtb8FmyplKt+Ee9zCCudlAjAfZC7nlCreY/lapWR7sdC7dDg1YKR9tJsSPHgTMpS
 siS8HwE0QuWOvchdSC+44YxNescbtmlQ1ICSBwntWBy7UEmTM1aoFYm99gcLE+eawwBOCZHeaGI
 sH/YsXO1PLz5kUA==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/musicpal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index e2630243eb7..69e83bdd973 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1062,6 +1062,7 @@ struct musicpal_key_state {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    QemuInputHandlerState *hs;
     uint32_t pressed_keys;
     qemu_irq out[8];
 };
@@ -1158,7 +1159,16 @@ static const QemuInputHandler musicpal_key_handler = {
 
 static void musicpal_key_realize(DeviceState *dev, Error **errp)
 {
-    qemu_input_handler_register(dev, &musicpal_key_handler);
+    musicpal_key_state *s = MUSICPAL_KEY(dev);
+
+    s->hs = qemu_input_handler_register(dev, &musicpal_key_handler);
+}
+
+static void musicpal_key_unrealize(DeviceState *dev)
+{
+    musicpal_key_state *s = MUSICPAL_KEY(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static const VMStateDescription musicpal_key_vmsd = {
@@ -1177,6 +1187,7 @@ static void musicpal_key_class_init(ObjectClass *klass, const void *data)
 
     dc->vmsd = &musicpal_key_vmsd;
     dc->realize = musicpal_key_realize;
+    dc->unrealize = musicpal_key_unrealize;
 }
 
 static const TypeInfo musicpal_key_info = {

-- 
2.54.0


