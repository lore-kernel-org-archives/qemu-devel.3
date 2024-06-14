Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37748C27C7B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1M2-0003vL-5n; Fri, 14 Jun 2024 03:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1M0-0003ph-7D
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Ly-0000pe-IK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoU+Bge2QZ5zBPkFGdidGCwM1XG5mHtF715S1Ovk9Cc=;
 b=QHL/+HT5gQp4SRh1uSXxX843Zka7GJLL1ewJo9swns9IyzwqfXmCVUOm3zeQtZdNIjuqF6
 mwbs2uv0hDRPiR+M5C2AtqgXBXjkwoyUJiIqOxxjv0gGTQoTVFBGeE68Zm5Wcs4ijZoiLC
 AK6BJHWO+IqjjAp3IcWEYFk3XPveUAo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-lJLSe1dgN3OW0u6Tcz_rFw-1; Fri,
 14 Jun 2024 03:28:02 -0400
X-MC-Unique: lJLSe1dgN3OW0u6Tcz_rFw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16F741954210; Fri, 14 Jun 2024 07:28:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5B9D300021A; Fri, 14 Jun 2024 07:27:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/19] aspeed/soc: fix incorrect dram size for AST2700
Date: Fri, 14 Jun 2024 09:26:17 +0200
Message-ID: <20240614072620.1262053-17-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

AST2700 dram size calculation is not back compatible AST2600.
According to the DDR capacity hardware behavior,
if users write the data to the address which is beyond the ram size,
it would write the data to the "address % ram_size".
For example:
a. sdram base address "0x4 00000000"
b. sdram size 1 GiB
The available address range is from "0x4 00000000" to "0x4 3FFFFFFF".
If users write 0x12345678 to address "0x5 00000000",
the value of DRAM address 0 (base address 0x4 00000000) will be 0x12345678.

Add aspeed_soc_ast2700_dram_init to calculate the dram size and add
memory I/O whose address range is from "max_ram_size - ram_size" to max_ram_size
and its read/write handler to emulate DDR capacity hardware behavior.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 +
 hw/arm/aspeed_ast27x0.c     | 87 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index caef0d100ba5..849ba37f9524 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -59,6 +59,7 @@ struct AspeedSoCState {
     MemoryRegion sram;
     MemoryRegion spi_boot_container;
     MemoryRegion spi_boot;
+    AddressSpace dram_as;
     AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
@@ -129,6 +130,7 @@ struct Aspeed27x0SoCState {
     ARMCPU cpu[ASPEED_CPUS_NUM];
     AspeedINTCState intc;
     GICv3State gic;
+    MemoryRegion dram_empty;
 };
 
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 29e75072c4b7..b6876b4862ff 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qapi/qmp/qlist.h"
+#include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  =  0x400000000,
@@ -191,6 +192,90 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(DEVICE(&a->gic), sc->irqmap[dev]);
 }
 
+static uint64_t aspeed_ram_capacity_read(void *opaque, hwaddr addr,
+                                                    unsigned int size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: DRAM read out of ram size, addr:0x%" PRIx64 "\n",
+                   __func__, addr);
+    return 0;
+}
+
+static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
+                                                unsigned int size)
+{
+    AspeedSoCState *s = ASPEED_SOC(opaque);
+    ram_addr_t ram_size;
+    MemTxResult result;
+
+    ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
+                                        &error_abort);
+
+    /*
+     * Emulate ddr capacity hardware behavior.
+     * If writes the data to the address which is beyond the ram size,
+     * it would write the data to the "address % ram_size".
+     */
+    result = address_space_write(&s->dram_as, addr % ram_size,
+                                 MEMTXATTRS_UNSPECIFIED, &data, 4);
+    if (result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: DRAM write failed, addr:0x%" HWADDR_PRIx
+                      ", data :0x%" PRIx64  "\n",
+                      __func__, addr % ram_size, data);
+    }
+}
+
+static const MemoryRegionOps aspeed_ram_capacity_ops = {
+    .read = aspeed_ram_capacity_read,
+    .write = aspeed_ram_capacity_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+/*
+ * SDMC should be realized first to get correct RAM size and max size
+ * values
+ */
+static bool aspeed_soc_ast2700_dram_init(DeviceState *dev, Error **errp)
+{
+    ram_addr_t ram_size, max_ram_size;
+    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
+                                        &error_abort);
+    max_ram_size = object_property_get_uint(OBJECT(&s->sdmc), "max-ram-size",
+                                            &error_abort);
+
+    memory_region_init(&s->dram_container, OBJECT(s), "ram-container",
+                       ram_size);
+    memory_region_add_subregion(&s->dram_container, 0, s->dram_mr);
+    address_space_init(&s->dram_as, s->dram_mr, "dram");
+
+    /*
+     * Add a memory region beyond the RAM region to emulate
+     * ddr capacity hardware behavior.
+     */
+    if (ram_size < max_ram_size) {
+        memory_region_init_io(&a->dram_empty, OBJECT(s),
+                              &aspeed_ram_capacity_ops, s,
+                              "ram-empty", max_ram_size - ram_size);
+
+        memory_region_add_subregion(s->memory,
+                                    sc->memmap[ASPEED_DEV_SDRAM] + ram_size,
+                                    &a->dram_empty);
+    }
+
+    memory_region_add_subregion(s->memory,
+                      sc->memmap[ASPEED_DEV_SDRAM], &s->dram_container);
+    return true;
+}
+
 static void aspeed_soc_ast2700_init(Object *obj)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(obj);
@@ -461,7 +546,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* RAM */
-    if (!aspeed_soc_dram_init(s, errp)) {
+    if (!aspeed_soc_ast2700_dram_init(dev, errp)) {
         return;
     }
 
-- 
2.45.2


