Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEE6CD342D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slP0s-0003A4-BS; Tue, 03 Sep 2024 04:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slP0q-0002zd-FA; Tue, 03 Sep 2024 04:35:44 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slP0o-00084x-Be; Tue, 03 Sep 2024 04:35:44 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 3 Sep
 2024 16:35:29 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 3 Sep 2024 16:35:29 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 02/11] hw/i2c/aspeed: Introduce a new bus pool buffer
 attribute in AspeedI2Cbus
Date: Tue, 3 Sep 2024 16:35:19 +0800
Message-ID: <20240903083528.2182190-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
 hw/i2c/aspeed_i2c.c         | 131 +++++++++++++++++++++++++++++++-----
 include/hw/i2c/aspeed_i2c.h |   4 ++
 2 files changed, 117 insertions(+), 18 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 9c222a02fe..d3d49340ea 100644
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
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 02ede85906..8e62ec64f8 100644
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
 
-- 
2.34.1


