Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2718BC79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP7-0003y8-3P; Sun, 06 Sep 2026 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOx-0003jG-7X
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOv-0000ES-Ms
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbRbjI7NpK7q92OTGkQCxCddrEFm8mE+RALWbEotkw0=;
 b=XSlIqeNY4EqkU1n2HKwPbKdg5Bq6EgdfVNhol5bgsUOjxX/7eck9wWZ162lI1gOJVqWvnb
 gw5HBIEPYbeLHQNOfq9gywF7xrYTgid2DBiJ/dnpw9zO72iPz6gbU7XsNrNsLWko/8Ttkd
 ag64pFVrnhFAbls6XI/YgzVo5loXf9c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-lnWi5AwgNkiX0hscLnELfA-1; Sun,
 06 Sep 2026 13:11:25 -0400
X-MC-Unique: lnWi5AwgNkiX0hscLnELfA-1
X-Mimecast-MFC-AGG-ID: lnWi5AwgNkiX0hscLnELfA_1788714684
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7DA1801344; Sun,  6 Sep 2026 17:11:24 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59BA51955F06; Sun,  6 Sep 2026 17:11:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/40] hw/sensor: tmp105: implement Resettable reset
Date: Sun,  6 Sep 2026 19:10:08 +0200
Message-ID: <20260906171021.26568-28-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Previously the device reset routine was invoked once from realize() and
never registered with the reset subsystem, so a system or bus reset left
the TMP105 registers untouched. Convert tmp105_reset() into a proper
Resettable hold phase (tmp105_reset_hold) registered through
ResettableClass::phases.hold, and drop the manual call from realize() as
the reset framework now drives it. This matches the scheme used by the
other hw/sensor I2C devices.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-3-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sensor/tmp105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index aabeb34f0837..f7d0c738caa8 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -314,9 +314,9 @@ static const VMStateDescription vmstate_tmp105 = {
     }
 };
 
-static void tmp105_reset(I2CSlave *i2c)
+static void tmp105_reset_hold(Object *obj, ResetType type)
 {
-    TMP105State *s = TMP105(i2c);
+    TMP105State *s = TMP105(obj);
 
     s->temperature = 0;
     s->pointer = 0;
@@ -337,8 +337,6 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
     TMP105State *s = TMP105(i2c);
 
     qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
-
-    tmp105_reset(&s->parent_obj);
 }
 
 static void tmp105_initfn(Object *obj)
@@ -352,11 +350,13 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = tmp105_realize;
     k->event = tmp105_event;
     k->recv = tmp105_rx;
     k->send = tmp105_tx;
+    rc->phases.hold = tmp105_reset_hold;
     dc->vmsd = &vmstate_tmp105;
 }
 
-- 
2.55.0


