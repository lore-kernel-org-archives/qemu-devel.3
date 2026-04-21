Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F1CF327AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4yO-0003ky-Re; Tue, 21 Apr 2026 02:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wF4yM-0003jf-UU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:52:38 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wF4yI-00006p-FV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:52:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C4A81A1CAF;
 Tue, 21 Apr 2026 08:52:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 16BE51A1C9C;
 Tue, 21 Apr 2026 08:52:32 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 271F61800086;
 Tue, 21 Apr 2026 14:52:31 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCHv7 03/15] hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
Date: Tue, 21 Apr 2026 12:22:14 +0530
Message-Id: <20260421065226.3907745-4-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
References: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the Analog IP to i.MX8MM SoC. iMX8MM and i.MX8MP uses
the same Analog IP so the analog ip source will be shared.

The ARM PLL divider control register (arm-pll-fdiv-ctl0) has
a different reset value on i.MX8MM (0x000fa030) compared to
i.MX8MP (0x000fa031). So iMX8MM will be overriding this property
with its own reset-value.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 12 ++++++++++++
 include/hw/arm/fsl-imx8mm.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1399a2e04c..1a9193fe1a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -621,6 +621,7 @@ config FSL_IMX8MP_EVK
 config FSL_IMX8MM
     bool
     select ARM_GIC
+    select FSL_IMX8MP_ANALOG
     select IMX
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 23a82613d7..8218448074 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
+
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -303,6 +305,15 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Analog */
+    object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-reset",
+                            0x000fa030, &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL].addr);
+
     /* UARTs */
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         static const struct {
@@ -338,6 +349,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
+        case FSL_IMX8MM_ANA_PLL:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 2811e809b9..0a020c32a1 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx8mp_analog.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -33,6 +34,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
 };
-- 
2.34.1


