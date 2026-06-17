Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81785CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs86-0007Ax-75; Wed, 17 Jun 2026 11:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs82-0006rK-25
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7y-0004J7-No
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OS0BvrZteOopO22QianGRQGnCdCp4nlyvY3EnxVGj8g=;
 b=fF4B/MgDZFzhHX6E4EkSYNWwNdv81ygGyozR7Sf/9GWI9v8fq8gF7FmNiG8d+Ydk3x5Pki
 fKCBkALD2lVlGohfavjNDmbMxG7rTS1ytDrzp/3EXgre7kZN4Zl35HpZXFuKXmCk+wY04F
 C4AmQh+gxBq+YDja/3VIO9gXrhU0QH0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Cuoqjze-P6K7rK2hXhQ81Q-1; Wed,
 17 Jun 2026 11:24:28 -0400
X-MC-Unique: Cuoqjze-P6K7rK2hXhQ81Q-1
X-Mimecast-MFC-AGG-ID: Cuoqjze-P6K7rK2hXhQ81Q_1781709867
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDB73195395D
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9546018005B3; Wed, 17 Jun 2026 15:24:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:08 +0400
Subject: [GIT PULL 11/27] hw/arm: keep QemuInputHandlerState in musicpal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-11-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QJ+id6RnEmy1UMWxYzi3z2UECPHZM98p4AGKtZtfKoA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvoBQxejkcPdnMlHGCRiag+994WQ2Joueegc
 EQ9msYx5/CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5W23D/4ndabr9fxP/N9KMngXCVD4N6hAu/3II186vMmAlFsU5pFaKs+4cCTCk8lzT7rsQO2kQsX
 15fS5rH9w+Cz5IdySSdh9Cuogzp1lXi4x52ECjVZBf+pfT+KrwpH04tWKiuIcWHaneUW31XROxK
 YYCSTr2JHBKCIZ3GY+y5XigwJrTHqqmvPxQTSaT2KYTz5n3G0cttaMcVPqSk3yrT1cdErilGCU6
 T9T9oPq1ZThuRlXk4pVAHhPC54XW8EoFLvF+UHKYDHI4o6rUgV3gV7ivohtzf1lqIJsbn4g5dpN
 mgH3sjYIYHvGn9ROFNNPifNhpOujyFr4WYdGcSH0HJGunV7CrrOLNpuhdUB57maHeTcMifM8K7z
 j1sju8ET4lcPEZxbHYQSsRaxFFDUPhxY2GYFVaxPnXJ52m9pfyLbWLvnnj0niKJO3pxLgEaKhDZ
 phJuNjj3rlQ2D95Rjaubt9SqZ5xf6PjEboU7m8qgOsllICY/TwsJUCBanyPo9E0mmDn4NVkQ2A+
 Evnd5eejB2LClPgGbHbHPv2/SEY+0EzUw0ON2rgWp6+q4zkUaxQr0Lo+rQer/sSWhgryQN6ThOw
 1RoIabnsQF/hi8josgCZtXTXYgYY0clzGIDc8llnDDQvzQXM+CuVLWy1PCXMZkknwbljAEhKQ5E
 cfxvnEp199u/guA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


