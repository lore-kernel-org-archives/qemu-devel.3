Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63B0E95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBs-0001yh-Rv; Wed, 04 Feb 2026 05:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBi-0001dT-Si
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBg-00046x-PR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+JbK5VKCKH/PwVOPnkgAGtpmZUz83KKfSRWDMt9nmI=;
 b=S1JAu6aXN/BR+fSYtxWCcG1KsYsT7nMBl3+Ym139crc/1WU5orVTa836bwwekbgI/9qIdE
 VZM+Ryl3bXKTIIVA+/dUS4/O913U7hRt+0dge/jyZCr1iDb0FJs1UCaBvhITF0zJSM2mHc
 3BmF9RUCgHHuvSnGup/RjH/t9LRr66w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-6bYzcxJ2MHGdhKHeeEKyWw-1; Wed,
 04 Feb 2026 05:32:40 -0500
X-MC-Unique: 6bYzcxJ2MHGdhKHeeEKyWw-1
X-Mimecast-MFC-AGG-ID: 6bYzcxJ2MHGdhKHeeEKyWw_1770201159
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8BDE1956051; Wed,  4 Feb 2026 10:32:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F117B18003F6; Wed,  4 Feb 2026 10:32:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 28/45] hw/arm/aspeed: Integrate AST1700 device into AST27X0
Date: Wed,  4 Feb 2026 11:31:19 +0100
Message-ID: <20260204103136.1795455-29-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Connect the AST1700 device as a child of the AST27X0 model to reflect
its role in DC-SCM 2.0 LTPI-based architectures. This patch wires
the AST1700 device into the platform without introducing functional
peripherals.

This forms the base for LTPI expander emulation in QEMU using
AST27X0 as the host controller.

Note: ioexp_num is set to 0 at this stage. Once all related devices
and interrupts are fully implemented, ioexp_num will be updated to
its expected value. This ensures the machine remains functional at
every commit and avoids potential compiler or build issues.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-6-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  7 +++++--
 hw/arm/aspeed_ast27x0.c     | 26 ++++++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 7b08cca908b3..f19bab3457ea 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -45,6 +45,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/misc/aspeed_ltpi.h"
+#include "hw/arm/aspeed_ast1700.h"
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
@@ -112,10 +113,10 @@ struct AspeedSoCState {
     UnimplementedDeviceState dpmcu;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
-    UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
+    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -178,6 +179,7 @@ struct AspeedSoCClass {
     int macs_num;
     int uarts_num;
     int uarts_base;
+    int ioexp_num;
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
@@ -190,7 +192,6 @@ enum {
     ASPEED_DEV_IOMEM,
     ASPEED_DEV_IOMEM0,
     ASPEED_DEV_IOMEM1,
-    ASPEED_DEV_LTPI,
     ASPEED_DEV_UART0,
     ASPEED_DEV_UART1,
     ASPEED_DEV_UART2,
@@ -285,6 +286,8 @@ enum {
     ASPEED_DEV_IPC1,
     ASPEED_DEV_LTPI_CTRL1,
     ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_LTPI_IO0,
+    ASPEED_DEV_LTPI_IO1,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index bbcb6e012709..a05112e2b040 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -26,7 +26,6 @@
 #define AST2700_SOC_IO_SIZE          0x00FE0000
 #define AST2700_SOC_IOMEM_SIZE       0x01000000
 #define AST2700_SOC_DPMCU_SIZE       0x00040000
-#define AST2700_SOC_LTPI_SIZE        0x01000000
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_VBOOTROM]  =  0x00000000,
@@ -91,7 +90,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
     [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
-    [ASPEED_DEV_LTPI]      =  0x30000000,
+    [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
+    [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
@@ -498,10 +498,14 @@ static void aspeed_soc_ast2700_init(Object *obj)
                                 &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
     }
 
+    for (i = 0; i < sc->ioexp_num; i++) {
+        /* AST1700 IOEXP */
+        object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
+                                TYPE_ASPEED_AST1700);
+    }
+
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ltpi", &s->ltpi,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem", &s->iomem,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem0", &s->iomem0,
@@ -995,14 +999,19 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
     }
 
+    /* IO Expander */
+    for (i = 0; i < sc->ioexp_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
+                        sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
+    }
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
-                                  "aspeed.ltpi",
-                                  sc->memmap[ASPEED_DEV_LTPI],
-                                  AST2700_SOC_LTPI_SIZE);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
                                   "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
@@ -1041,6 +1050,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->macs_num     = 3;
     sc->uarts_num    = 13;
     sc->num_cpus     = 4;
+    sc->ioexp_num    = 0;
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
-- 
2.52.0


