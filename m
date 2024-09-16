Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9ACC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGwe-0002EH-1z; Mon, 16 Sep 2024 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwJ-0001cm-R3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwB-0003MO-RK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pe2fqJNcufIGFVz5cq0V5UOsF2nBRtUC4RSg+LfeJw4=;
 b=V6keBT5onnR1FGjTaaMMqbexZDxv3wQlBjJmxFQixmzmy8PuN8ZvtsXNHyFag10a0kzT92
 zhXbwNz/R5p1yoUSlmSlPOLwyq9EcgbNsbcucCJyOt2uR4JSS5026WpjPca5p1zHituF6z
 TQ1VISwzMsxQ0cxu7Qz5JmKwBE1DXu8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-qbnphpovO36O3FMZ9XrFjw-1; Mon,
 16 Sep 2024 14:57:21 -0400
X-MC-Unique: qbnphpovO36O3FMZ9XrFjw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12D8D19560AB; Mon, 16 Sep 2024 18:57:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDA1F19560AA; Mon, 16 Sep 2024 18:57:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/12] hw/i2c/aspeed: Introduce a new bus pool buffer attribute
 in AspeedI2Cbus
Date: Mon, 16 Sep 2024 20:56:59 +0200
Message-ID: <20240916185708.574546-4-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
References: <20240916185708.574546-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the datasheet of ASPEED SOCs,
each I2C bus has their own pool buffer since AST2500.
Only AST2400 utilized a pool buffer share to all I2C bus.
Besides, using a share pool buffer only support
pool buffer memory regions are continuous for all I2C bus.

To make this model more readable and support discontinuous
bus pool buffer memory regions, changes to introduce
a new bus pool buffer attribute in AspeedI2Cbus and
new memops. So, it does not need to calculate
the pool buffer offset for different I2C bus.

Introduce a new has_share_pool class attribute in AspeedI2CClass and
use it to create either a share pool buffer or bus pool buffers
in aspeed_i2c_realize. Update each pull buffer size to 0x10 for AST2500
and 0x20 for AST2600 and AST1030.

Incrementing the version of aspeed_i2c_bus_vmstate to 6.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |   4 ++
 hw/i2c/aspeed_i2c.c         | 131 +++++++++++++++++++++++++++++++-----
 2 files changed, 117 insertions(+), 18 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 02ede859067e..8e62ec64f835 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 
 #define ASPEED_I2C_NR_BUSSES 16
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
+#define ASPEED_I2C_BUS_POOL_SIZE 0x20
 #define ASPEED_I2C_OLD_NUM_REG 11
 #define ASPEED_I2C_NEW_NUM_REG 22
 
@@ -239,12 +240,14 @@ struct AspeedI2CBus {
     I2CSlave *slave;
 
     MemoryRegion mr;
+    MemoryRegion mr_pool;
 
     I2CBus *bus;
     uint8_t id;
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I2C_NEW_NUM_REG];
+    uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];
 };
 
 struct AspeedI2CState {
@@ -284,6 +287,7 @@ struct AspeedI2CClass {
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
     bool has_dma;
+    bool has_share_pool;
     uint64_t mem_size;
 };
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ee30243c25f9..819f70197369 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -941,12 +941,48 @@ static const MemoryRegionOps aspeed_i2c_share_pool_ops = {
     },
 };
 
+static uint64_t aspeed_i2c_bus_pool_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    AspeedI2CBus *s = opaque;
+    uint64_t ret = 0;
+    int i;
+
+    for (i = 0; i < size; i++) {
+        ret |= (uint64_t) s->pool[offset + i] << (8 * i);
+    }
+
+    return ret;
+}
+
+static void aspeed_i2c_bus_pool_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    AspeedI2CBus *s = opaque;
+    int i;
+
+    for (i = 0; i < size; i++) {
+        s->pool[offset + i] = (value >> (8 * i)) & 0xFF;
+    }
+}
+
+static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
+    .read = aspeed_i2c_bus_pool_read,
+    .write = aspeed_i2c_bus_pool_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 5,
-    .minimum_version_id = 5,
+    .version_id = 6,
+    .minimum_version_id = 6,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
+        VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -996,7 +1032,21 @@ static void aspeed_i2c_instance_init(Object *obj)
  *   0x140 ... 0x17F: Device 5
  *   0x180 ... 0x1BF: Device 6
  *   0x1C0 ... 0x1FF: Device 7
- *   0x200 ... 0x2FF: Buffer Pool (AST2500 unused in linux driver)
+ *   0x200 ... 0x20F: Device 1 buffer (AST2500 unused in linux driver)
+ *   0x210 ... 0x21F: Device 2 buffer
+ *   0x220 ... 0x22F: Device 3 buffer
+ *   0x230 ... 0x23F: Device 4 buffer
+ *   0x240 ... 0x24F: Device 5 buffer
+ *   0x250 ... 0x25F: Device 6 buffer
+ *   0x260 ... 0x26F: Device 7 buffer
+ *   0x270 ... 0x27F: Device 8 buffer
+ *   0x280 ... 0x28F: Device 9 buffer
+ *   0x290 ... 0x29F: Device 10 buffer
+ *   0x2A0 ... 0x2AF: Device 11 buffer
+ *   0x2B0 ... 0x2BF: Device 12 buffer
+ *   0x2C0 ... 0x2CF: Device 13 buffer
+ *   0x2D0 ... 0x2DF: Device 14 buffer
+ *   0x2E0 ... 0x2FF: Reserved
  *   0x300 ... 0x33F: Device 8
  *   0x340 ... 0x37F: Device 9
  *   0x380 ... 0x3BF: Device 10
@@ -1005,6 +1055,41 @@ static void aspeed_i2c_instance_init(Object *obj)
  *   0x440 ... 0x47F: Device 13
  *   0x480 ... 0x4BF: Device 14
  *   0x800 ... 0xFFF: Buffer Pool (AST2400 unused in linux driver)
+ *
+ * Address Definitions (AST2600 and AST1030)
+ *   0x000 ... 0x07F: Global Register
+ *   0x080 ... 0x0FF: Device 1
+ *   0x100 ... 0x17F: Device 2
+ *   0x180 ... 0x1FF: Device 3
+ *   0x200 ... 0x27F: Device 4
+ *   0x280 ... 0x2FF: Device 5
+ *   0x300 ... 0x37F: Device 6
+ *   0x380 ... 0x3FF: Device 7
+ *   0x400 ... 0x47F: Device 8
+ *   0x480 ... 0x4FF: Device 9
+ *   0x500 ... 0x57F: Device 10
+ *   0x580 ... 0x5FF: Device 11
+ *   0x600 ... 0x67F: Device 12
+ *   0x680 ... 0x6FF: Device 13
+ *   0x700 ... 0x77F: Device 14
+ *   0x780 ... 0x7FF: Device 15 (15 and 16 unused in AST1030)
+ *   0x800 ... 0x87F: Device 16
+ *   0xC00 ... 0xC1F: Device 1 buffer
+ *   0xC20 ... 0xC3F: Device 2 buffer
+ *   0xC40 ... 0xC5F: Device 3 buffer
+ *   0xC60 ... 0xC7F: Device 4 buffer
+ *   0xC80 ... 0xC9F: Device 5 buffer
+ *   0xCA0 ... 0xCBF: Device 6 buffer
+ *   0xCC0 ... 0xCDF: Device 7 buffer
+ *   0xCE0 ... 0xCFF: Device 8 buffer
+ *   0xD00 ... 0xD1F: Device 9 buffer
+ *   0xD20 ... 0xD3F: Device 10 buffer
+ *   0xD40 ... 0xD5F: Device 11 buffer
+ *   0xD60 ... 0xD7F: Device 12 buffer
+ *   0xD80 ... 0xD9F: Device 13 buffer
+ *   0xDA0 ... 0xDBF: Device 14 buffer
+ *   0xDC0 ... 0xDDF: Device 15 buffer (15 and 16 unused in AST1030)
+ *   0xDE0 ... 0xDFF: Device 16 buffer
  */
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 {
@@ -1039,10 +1124,19 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
                                     &s->busses[i].mr);
     }
 
-    memory_region_init_io(&s->pool_iomem, OBJECT(s),
-                          &aspeed_i2c_share_pool_ops, s,
-                          "aspeed.i2c-share-pool", aic->pool_size);
-    memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iomem);
+    if (aic->has_share_pool) {
+        memory_region_init_io(&s->pool_iomem, OBJECT(s),
+                              &aspeed_i2c_share_pool_ops, s,
+                              "aspeed.i2c-share-pool", aic->pool_size);
+        memory_region_add_subregion(&s->iomem, aic->pool_base,
+                                    &s->pool_iomem);
+    } else {
+        for (i = 0; i < aic->num_busses; i++) {
+            memory_region_add_subregion(&s->iomem,
+                                        aic->pool_base + (aic->pool_size * i),
+                                        &s->busses[i].mr_pool);
+        }
+    }
 
     if (aic->has_dma) {
         if (!s->dram_mr) {
@@ -1218,6 +1312,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
     AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
     AspeedI2CClass *aic;
     g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
+    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
 
     if (!s->controller) {
         error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
@@ -1235,6 +1330,10 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
                           s, name, aic->reg_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+
+    memory_region_init_io(&s->mr_pool, OBJECT(s), &aspeed_i2c_bus_pool_ops,
+                          s, pool_name, aic->pool_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr_pool);
 }
 
 static Property aspeed_i2c_bus_properties[] = {
@@ -1287,6 +1386,7 @@ static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x40;
     aic->gap = 7;
     aic->bus_get_irq = aspeed_2400_i2c_bus_get_irq;
+    aic->has_share_pool = true;
     aic->pool_size = 0x800;
     aic->pool_base = 0x800;
     aic->bus_pool_base = aspeed_2400_i2c_bus_pool_base;
@@ -1306,7 +1406,7 @@ static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
 
 static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
 {
-    return &bus->controller->share_pool[bus->id * 0x10];
+    return bus->pool;
 }
 
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
@@ -1320,7 +1420,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x40;
     aic->gap = 7;
     aic->bus_get_irq = aspeed_2500_i2c_bus_get_irq;
-    aic->pool_size = 0x100;
+    aic->pool_size = 0x10;
     aic->pool_base = 0x200;
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->check_sram = true;
@@ -1339,11 +1439,6 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
     return bus->irq;
 }
 
-static uint8_t *aspeed_2600_i2c_bus_pool_base(AspeedI2CBus *bus)
-{
-   return &bus->controller->share_pool[bus->id * 0x20];
-}
-
 static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1355,9 +1450,9 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x80;
     aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
-    aic->pool_size = 0x200;
+    aic->pool_size = 0x20;
     aic->pool_base = 0xC00;
-    aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
+    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x1000;
 }
@@ -1379,9 +1474,9 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x80;
     aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
-    aic->pool_size = 0x200;
+    aic->pool_size = 0x20;
     aic->pool_base = 0xC00;
-    aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
+    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x10000;
 }
-- 
2.46.0


