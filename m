Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D236CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn1a-0006du-VN; Tue, 26 May 2026 04:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1Q-0006Ek-6i
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1O-0008Ds-2t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h11gBrQjDc1xp7lwgLlMFe1x0NpMNhYNvv5wr5xATZU=;
 b=YhYcZjHR4DWHKH32fqd41GP9HrPOPM8E0A6+L+YQYjnl6RFdzG/c03Ida2Wx0ECY54ceqF
 x/6Xh8woWq947R2oQt7ir6Paf8cU4c/ZDW1YOYxWXLfVIz0fBTxzx+zsskRFc8tso2rux+
 KJGVXeH4tDbP1w/uqLbZDJAkzDTeH+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-A4VfRvp8MYueMsZGVw5cXw-1; Tue,
 26 May 2026 04:20:13 -0400
X-MC-Unique: A4VfRvp8MYueMsZGVw5cXw-1
X-Mimecast-MFC-AGG-ID: A4VfRvp8MYueMsZGVw5cXw_1779783612
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32929195609F; Tue, 26 May 2026 08:20:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EB5C1800357; Tue, 26 May 2026 08:20:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/37] hw/i2c/aspeed_i2c: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:48 +0200
Message-ID: <20260526081848.651835-38-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

From: Kane Chen <kane_chen@aspeedtech.com>

Replace the legacy reset callback registered via
device_class_set_legacy_reset() with the Resettable interface.

Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-24-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 90f83a03fd4f..80c445750059 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1160,9 +1160,9 @@ static const VMStateDescription aspeed_i2c_vmstate = {
     }
 };
 
-static void aspeed_i2c_reset(DeviceState *dev)
+static void aspeed_i2c_reset_hold(Object *obj, ResetType type)
 {
-    AspeedI2CState *s = ASPEED_I2C(dev);
+    AspeedI2CState *s = ASPEED_I2C(obj);
 
     s->intr_status = 0;
 }
@@ -1363,9 +1363,10 @@ static const Property aspeed_i2c_properties[] = {
 static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &aspeed_i2c_vmstate;
-    device_class_set_legacy_reset(dc, aspeed_i2c_reset);
+    rc->phases.hold = aspeed_i2c_reset_hold;
     device_class_set_props(dc, aspeed_i2c_properties);
     dc->realize = aspeed_i2c_realize;
     dc->desc = "Aspeed I2C Controller";
@@ -1506,9 +1507,9 @@ static const TypeInfo aspeed_i2c_bus_slave_info = {
     .class_init     = aspeed_i2c_bus_slave_class_init,
 };
 
-static void aspeed_i2c_bus_reset(DeviceState *dev)
+static void aspeed_i2c_bus_reset_hold(Object *obj, ResetType type)
 {
-    AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
+    AspeedI2CBus *s = ASPEED_I2C_BUS(obj);
 
     memset(s->regs, 0, sizeof(s->regs));
     s->pending_intr_sts = 0;
@@ -1556,10 +1557,11 @@ static const Property aspeed_i2c_bus_properties[] = {
 static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "Aspeed I2C Bus";
     dc->realize = aspeed_i2c_bus_realize;
-    device_class_set_legacy_reset(dc, aspeed_i2c_bus_reset);
+    rc->phases.hold = aspeed_i2c_bus_reset_hold;
     device_class_set_props(dc, aspeed_i2c_bus_properties);
 }
 
-- 
2.54.0


