Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A169CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQIC-0001C7-Ai; Mon, 10 Nov 2025 06:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIPzg-0003vW-Jx
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:23:38 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIPzd-00067d-FK
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:23:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CCF21A20DB;
 Mon, 10 Nov 2025 12:23:28 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 357BA1A0C47;
 Mon, 10 Nov 2025 12:23:28 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 591971800083;
 Mon, 10 Nov 2025 19:23:27 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 03/13] hw/arm/fsl-imx8mm: Implemented support for SNVS
Date: Mon, 10 Nov 2025 16:52:47 +0530
Message-Id: <20251110112257.184578-4-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SNVS contains an RTC which allows Linux to deal correctly with time

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/fsl-imx8mm.c            | 10 ++++++++++
 include/hw/arm/fsl-imx8mm.h    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 1cdfa153cb..e50e72bdcf 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
 Boot options
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 248eebfbce..7d9707c131 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -170,6 +170,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MM_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -340,6 +342,13 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
@@ -348,6 +357,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
+        case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
             /* device implemented and treated above */
             break;
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 0716484429..4fd11798a5 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mm_analog.h"
 #include "hw/misc/imx8mm_ccm.h"
 #include "qom/object.h"
@@ -36,6 +37,7 @@ struct FslImx8mmState {
     GICv3State         gic;
     IMX8MMCCMState     ccm;
     IMX8MMAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
 };
 
-- 
2.34.1


