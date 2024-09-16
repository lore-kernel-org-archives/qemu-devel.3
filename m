Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385D0C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 18:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGvk-0000Bo-NV; Mon, 16 Sep 2024 14:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGvj-00007E-Om
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGvi-0003KN-2w
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idXAmc9dosGve1KohATcdwt35F9vOe5dYXXAu7W5+8o=;
 b=Cz4qleZT/tZCJfMfdtrLf7Tp7gH6wSfwx2Aqz9OHRnnTmas8FKH85gq4otu98KqQyMgGBr
 t1ZceFIYtS4lvdRFZqVzg5i4DxKdoL/xhBqJFH1IuurKcVfNre078qBiG+/mpJ9SlhPQ84
 c3rm9EZz5DS2jsw7eIqRZC+VRZxJhUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-pbnYlPV0NrCJTFr7Xm7VSQ-1; Mon,
 16 Sep 2024 14:57:27 -0400
X-MC-Unique: pbnYlPV0NrCJTFr7Xm7VSQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 019EB1955D53; Mon, 16 Sep 2024 18:57:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B94819560AA; Mon, 16 Sep 2024 18:57:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/12] hw/i2c/aspeed: Add AST2700 support
Date: Mon, 16 Sep 2024 20:57:02 +0200
Message-ID: <20240916185708.574546-7-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
References: <20240916185708.574546-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a new ast2700 class to support AST2700.
The I2C bus register memory regions and
I2C bus pool buffer memory regions are discontinuous
and they do not back compatible AST2600.

Add a new ast2700 i2c class init function to match the
address of I2C bus register and pool buffer from the datasheet.

An I2C controller registers owns 8KB address space.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  1 +
 hw/i2c/aspeed_i2c.c         | 62 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index bdaea3207db2..4f23dc10c3e1 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -31,6 +31,7 @@
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
 #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
 #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"
+#define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 
 #define ASPEED_I2C_NR_BUSSES 16
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a17dd2526319..c61bafcb9ad4 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1102,6 +1102,41 @@ static void aspeed_i2c_instance_init(Object *obj)
  *   0xDA0 ... 0xDBF: Device 14 buffer
  *   0xDC0 ... 0xDDF: Device 15 buffer (15 and 16 unused in AST1030)
  *   0xDE0 ... 0xDFF: Device 16 buffer
+ *
+ * Address Definitions (AST2700)
+ *   0x000 ... 0x0FF: Global Register
+ *   0x100 ... 0x17F: Device 0
+ *   0x1A0 ... 0x1BF: Device 0 buffer
+ *   0x200 ... 0x27F: Device 1
+ *   0x2A0 ... 0x2BF: Device 1 buffer
+ *   0x300 ... 0x37F: Device 2
+ *   0x3A0 ... 0x3BF: Device 2 buffer
+ *   0x400 ... 0x47F: Device 3
+ *   0x4A0 ... 0x4BF: Device 3 buffer
+ *   0x500 ... 0x57F: Device 4
+ *   0x5A0 ... 0x5BF: Device 4 buffer
+ *   0x600 ... 0x67F: Device 5
+ *   0x6A0 ... 0x6BF: Device 5 buffer
+ *   0x700 ... 0x77F: Device 6
+ *   0x7A0 ... 0x7BF: Device 6 buffer
+ *   0x800 ... 0x87F: Device 7
+ *   0x8A0 ... 0x8BF: Device 7 buffer
+ *   0x900 ... 0x97F: Device 8
+ *   0x9A0 ... 0x9BF: Device 8 buffer
+ *   0xA00 ... 0xA7F: Device 9
+ *   0xAA0 ... 0xABF: Device 9 buffer
+ *   0xB00 ... 0xB7F: Device 10
+ *   0xBA0 ... 0xBBF: Device 10 buffer
+ *   0xC00 ... 0xC7F: Device 11
+ *   0xCA0 ... 0xCBF: Device 11 buffer
+ *   0xD00 ... 0xD7F: Device 12
+ *   0xDA0 ... 0xDBF: Device 12 buffer
+ *   0xE00 ... 0xE7F: Device 13
+ *   0xEA0 ... 0xEBF: Device 13 buffer
+ *   0xF00 ... 0xF7F: Device 14
+ *   0xFA0 ... 0xFBF: Device 14 buffer
+ *   0x1000 ... 0x107F: Device 15
+ *   0x10A0 ... 0x10BF: Device 15 buffer
  */
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 {
@@ -1501,6 +1536,32 @@ static const TypeInfo aspeed_1030_i2c_info = {
     .class_init = aspeed_1030_i2c_class_init,
 };
 
+static void aspeed_2700_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 I2C Controller";
+
+    aic->num_busses = 16;
+    aic->reg_size = 0x80;
+    aic->reg_gap_size = 0x80;
+    aic->gap = -1; /* no gap */
+    aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
+    aic->pool_size = 0x20;
+    aic->pool_gap_size = 0xe0;
+    aic->pool_base = 0x1a0;
+    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
+    aic->has_dma = true;
+    aic->mem_size = 0x2000;
+}
+
+static const TypeInfo aspeed_2700_i2c_info = {
+    .name = TYPE_ASPEED_2700_I2C,
+    .parent = TYPE_ASPEED_I2C,
+    .class_init = aspeed_2700_i2c_class_init,
+};
+
 static void aspeed_i2c_register_types(void)
 {
     type_register_static(&aspeed_i2c_bus_info);
@@ -1510,6 +1571,7 @@ static void aspeed_i2c_register_types(void)
     type_register_static(&aspeed_2500_i2c_info);
     type_register_static(&aspeed_2600_i2c_info);
     type_register_static(&aspeed_1030_i2c_info);
+    type_register_static(&aspeed_2700_i2c_info);
 }
 
 type_init(aspeed_i2c_register_types)
-- 
2.46.0


