Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4658D25051
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDKa-0005Cp-HG; Mon, 12 Jan 2026 03:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vfDKN-00055H-I6; Mon, 12 Jan 2026 03:31:12 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vfDKL-0008QA-Tj; Mon, 12 Jan 2026 03:31:07 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 12 Jan
 2026 16:30:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 12 Jan 2026 16:30:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize bus
 naming
Date: Mon, 12 Jan 2026 16:30:53 +0800
Message-ID: <20260112083054.4151945-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

On some Aspeed-based machines, multiple I2C controllers may exist
across different components, such as the primary SoC and an external
IO expander or co-processor (e.g., AST1700). Using the current static
naming convention results in object name conflicts when multiple
controllers attempt to instantiate buses with the same ID.

This patch introduces a 'bus-label' property for the Aspeed I2C
controller. This allows higher-level layers, such as the SoC realize
function, to provide a unique identifier for the buses. The I2C bus
object name is then constructed using this label (e.g., "ioexp0.0"
instead of the default "aspeed.i2c.bus.0").

This enhancement ensures unique bus identifiers across the system and
resolves naming conflicts in multi-controller configurations.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/i2c/aspeed_i2c.h |  2 ++
 hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index ffcff2580f..68bd138026 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -252,6 +252,7 @@ struct AspeedI2CBus {
     MemoryRegion mr_pool;
 
     I2CBus *bus;
+    char *name;
     uint8_t id;
     qemu_irq irq;
 
@@ -269,6 +270,7 @@ struct AspeedI2CState {
     uint32_t intr_status;
     uint32_t ctrl_global;
     uint32_t new_clk_divider;
+    char *bus_label;
     MemoryRegion pool_iomem;
     uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 1b8ac561c3..7cf92423c7 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1215,9 +1215,16 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
                           "aspeed.i2c", aic->mem_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
+    /* default value */
+    if (!s->bus_label) {
+        s->bus_label = g_strdup(TYPE_ASPEED_I2C_BUS);
+    }
+
     for (i = 0; i < aic->num_busses; i++) {
         Object *bus = OBJECT(&s->busses[i]);
         int offset = i < aic->gap ? 1 : 5;
+        g_autofree char *name = g_strdup_printf("%s.%d",
+                                                s->bus_label, i);
 
         if (!object_property_set_link(bus, "controller", OBJECT(s), errp)) {
             return;
@@ -1227,6 +1234,10 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
             return;
         }
 
+        if (!object_property_set_str(bus, "bus-name", name, errp)) {
+            return;
+        }
+
         if (!sysbus_realize(SYS_BUS_DEVICE(bus), errp)) {
             return;
         }
@@ -1263,6 +1274,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_i2c_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
 };
 
 static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
@@ -1423,24 +1435,26 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
 {
     AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
     AspeedI2CClass *aic;
-    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
-    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
+    g_autofree char *pool_name = NULL;
 
-    if (!s->controller) {
-        error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
+    if (!s->controller || !s->name) {
+        error_setg(errp, TYPE_ASPEED_I2C_BUS
+                   ": 'controller' or 'bus-name' not set");
         return;
     }
 
+    pool_name = g_strdup_printf("%s.pool", s->name);
+
     aic = ASPEED_I2C_GET_CLASS(s->controller);
 
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
-    s->bus = i2c_init_bus(dev, name);
+    s->bus = i2c_init_bus(dev, s->name);
     s->slave = i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE,
                                        0xff);
 
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
-                          s, name, aic->reg_size);
+                          s, s->name, aic->reg_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
     memory_region_init_io(&s->mr_pool, OBJECT(s), &aspeed_i2c_bus_pool_ops,
@@ -1452,6 +1466,7 @@ static const Property aspeed_i2c_bus_properties[] = {
     DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
     DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I2C,
                      AspeedI2CState *),
+    DEFINE_PROP_STRING("bus-name", AspeedI2CBus, name),
 };
 
 static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


