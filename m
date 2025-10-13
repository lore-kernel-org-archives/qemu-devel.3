Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A80CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvz-0005Fz-0Y; Mon, 13 Oct 2025 08:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvS-0004pF-QH
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvH-0008AY-LS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOzTP/IGNoBBnnYrqRH1AZrDTpQKJs1urmCGz64xytk=;
 b=dwAKB+s/1qRdL2RYpwcZQ+W1QL5YaLaq8KmB1KISZf3s8a7ZGE1axUSBalrZcqzVlh+Dk+
 7VMBR5oyjkk37asUdK+QOa3jOSDmEBM0dvJwNrTEZT1UA5o9/kU1vmgsSdCuYlHPa/DlrP
 az9ie5vqx0QOCqX9Y0a7ROgf+QHQp+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-5sGmlVFgMKiyiv1dtANBKA-1; Mon,
 13 Oct 2025 08:45:03 -0400
X-MC-Unique: 5sGmlVFgMKiyiv1dtANBKA-1
X-Mimecast-MFC-AGG-ID: 5sGmlVFgMKiyiv1dtANBKA_1760359503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 036A81955F45; Mon, 13 Oct 2025 12:45:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 847BD1800282; Mon, 13 Oct 2025 12:45:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/29] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_mmio_map_unimplemented() API
Date: Mon, 13 Oct 2025 14:44:10 +0200
Message-ID: <20251013124421.71977-20-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Refactor aspeed_mmio_map_unimplemented() to take MemoryRegion *
instead of AspeedSoCState *, removing its dependency on SoC state and
aligning it with the updated aspeed_mmio_map() interface.

All related call sites are updated to explicitly pass s->memory.
Affected files include headers, aspeed_soc_common.c, and SoC realize
functions in AST10x0, AST2400, AST2600, AST27x0 (SSP/TSP), and AST2700.

This change simplifies the MMIO mapping helpers, improves API
consistency, and reduces coupling between SoC logic and memory
operations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 +-
 hw/arm/aspeed_ast10x0.c     | 24 ++++++++++++++++--------
 hw/arm/aspeed_ast2400.c     |  6 ++++--
 hw/arm/aspeed_ast2600.c     | 12 ++++++++----
 hw/arm/aspeed_ast27x0-ssp.c |  8 ++++----
 hw/arm/aspeed_ast27x0-tsp.c |  8 ++++----
 hw/arm/aspeed_ast27x0.c     | 10 +++++-----
 hw/arm/aspeed_soc_common.c  |  4 ++--
 8 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 606cf6bb6193..957362b88d06 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -310,7 +310,7 @@ void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
 void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
                      hwaddr addr);
-void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
+void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                    const char *name, hwaddr addr,
                                    uint64_t size);
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index caa9feb667ec..e861b6dad699 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -201,10 +201,12 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* General I/O memory space to catch all unimplemented device */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->sbc_unimplemented),
+    aspeed_mmio_map_unimplemented(s->memory,
+                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),
                                   "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC],
                                   0x40000);
 
@@ -406,20 +408,26 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->pwm), "aspeed.pwm",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
+                                  "aspeed.pwm",
                                   sc->memmap[ASPEED_DEV_PWM], 0x100);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->espi), "aspeed.espi",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),
+                                  "aspeed.espi",
                                   sc->memmap[ASPEED_DEV_ESPI], 0x800);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->udc), "aspeed.udc",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
+                                  "aspeed.udc",
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->sgpiom), "aspeed.sgpiom",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
+                                  "aspeed.sgpiom",
                                   sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->jtag[0]), "aspeed.jtag",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
+                                  "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x20);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->jtag[1]), "aspeed.jtag",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
+                                  "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG1], 0x20);
 }
 
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 669075221581..e0604851a558 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -259,12 +259,14 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                                 &s->spi_boot_container);
 
     /* IO space */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->video), "aspeed.video",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
+                                  "aspeed.video",
                                   sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
 
     /* CPU */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index bf0ecde0514b..ed0985a16e08 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -370,16 +370,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 &s->spi_boot_container);
 
     /* IO space */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->video), "aspeed.video",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
+                                  "aspeed.video",
                                   sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
 
     /* eMMC Boot Controller stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->emmc_boot_controller),
+    aspeed_mmio_map_unimplemented(s->memory,
+                                  SYS_BUS_DEVICE(&s->emmc_boot_controller),
                                   "aspeed.emmc-boot-controller",
                                   sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);
 
@@ -441,7 +444,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_DEV_SRAM], &s->sram);
 
     /* DPMCU */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu), "aspeed.dpmcu",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
+                                  "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   ASPEED_SOC_DPMCU_SIZE);
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 83cf3c14b6c3..99a3de15b56c 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -241,16 +241,16 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
                                   "aspeed.ipc0",
                                   sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
                                   "aspeed.scuio",
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 86aa56560898..568d7555e26e 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -241,16 +241,16 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
                                   "aspeed.ipc0",
                                   sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
                                   "aspeed.scuio",
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 8db67dc806ac..9b645c6c5502 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1014,23 +1014,23 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ltpi),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
                                   "aspeed.ltpi",
                                   sc->memmap[ASPEED_DEV_LTPI],
                                   AST2700_SOC_LTPI_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
                                   "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   AST2700_SOC_IO_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem0),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem0),
                                   "aspeed.iomem0",
                                   sc->memmap[ASPEED_DEV_IOMEM0],
                                   AST2700_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem1),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem1),
                                   "aspeed.iomem1",
                                   sc->memmap[ASPEED_DEV_IOMEM1],
                                   AST2700_SOC_IOMEM_SIZE);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index ca4e589dce85..e7d0a9c2909a 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -117,14 +117,14 @@ void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
     memory_region_add_subregion(memory, addr, sysbus_mmio_get_region(dev, n));
 }
 
-void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
+void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                    const char *name, hwaddr addr, uint64_t size)
 {
     qdev_prop_set_string(DEVICE(dev), "name", name);
     qdev_prop_set_uint64(DEVICE(dev), "size", size);
     sysbus_realize(dev, &error_abort);
 
-    memory_region_add_subregion_overlap(s->memory, addr,
+    memory_region_add_subregion_overlap(memory, addr,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
-- 
2.51.0


