Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7183E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaAt-0000Mm-MU; Wed, 04 Feb 2026 05:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAr-0000LW-Vz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAq-0003wH-6E
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uESqxG/T40ZyyeVaSEFM+Nz5YM8i+GpPCgUSainMP+s=;
 b=hAnnabTKV1AcsuQYYTsu06Z8Tr4xMI4oYIC0OylWkYJ1R1MIHJz4q6GPtWLKzLFJeUwMPa
 R9F0IwT+qoh2XPKDk3Adgg0xYoa4YtVY+PamN7UdTj+jHDDq7vpit+nq1nHiTuC+DqDTLD
 X2JJCnidx4ggvohVx9FA9EUjJNHRpMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-epEBqW4nMcG9qGM-9B1hIA-1; Wed,
 04 Feb 2026 05:31:48 -0500
X-MC-Unique: epEBqW4nMcG9qGM-9B1hIA-1
X-Mimecast-MFC-AGG-ID: epEBqW4nMcG9qGM-9B1hIA_1770201107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051821956096; Wed,  4 Feb 2026 10:31:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CDE118004AD; Wed,  4 Feb 2026 10:31:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 03/45] hw/i2c/aspeed: Introduce 'bus-label' to customize bus
 naming
Date: Wed,  4 Feb 2026 11:30:54 +0100
Message-ID: <20260204103136.1795455-4-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260112083054.4151945-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  2 ++
 hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index ffcff2580f05..68bd13802601 100644
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
index 1b8ac561c33b..7cf92423c740 100644
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
2.52.0


