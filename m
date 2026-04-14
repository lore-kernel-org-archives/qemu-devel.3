Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9974BF531EA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCWSn-0003p1-PD; Tue, 14 Apr 2026 01:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCWSj-0003nV-63
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:37:27 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCWSg-00044C-HE
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:37:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6265B201B48;
 Tue, 14 Apr 2026 07:37:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A89020224D;
 Tue, 14 Apr 2026 07:37:21 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4AB7C1802227;
 Tue, 14 Apr 2026 13:37:20 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCHv5 04/15] hw/arm/fsl-imx8mm: Add Clock Control Module IP to
 iMX8MM
Date: Tue, 14 Apr 2026 11:07:04 +0530
Message-Id: <20260414053715.1378021-5-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add the Clock Control Module (CCM) device to i.MX8MM SoC.
The CCM implementation is shared with i.MX8MP as the register
layout is identical between the two variants.Hence iMX8MM will
be using the source of iMX8MP CCM.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 10 ++++++++++
 include/hw/arm/fsl-imx8mm.h |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1a9193fe1a..c785f3f3a3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -622,6 +622,7 @@ config FSL_IMX8MM
     bool
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
+    select FSL_IMX8MP_CCM
     select IMX
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 5145d1d72c..ec7c467068 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
+
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
@@ -305,6 +307,13 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_CCM].addr);
+
     /* Analog */
     object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-reset",
                             0x000fa030, &error_abort);
@@ -350,6 +359,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
         case FSL_IMX8MM_ANA_PLL:
+        case FSL_IMX8MM_CCM:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 0a020c32a1..df35f0f5ac 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -14,6 +14,7 @@
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx8mp_analog.h"
+#include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -34,6 +35,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
-- 
2.34.1


