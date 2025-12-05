Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4919BD2CE1C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 05:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROXE-0008N8-VH; Fri, 05 Dec 2025 00:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROWe-0008Fx-0r
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:38:44 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROWS-0005IX-L9
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:38:30 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78F8B1A187C;
 Fri,  5 Dec 2025 06:38:22 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42CDE1A1858;
 Fri,  5 Dec 2025 06:38:22 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 091981800083;
 Fri,  5 Dec 2025 13:38:20 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 02/15] hw/misc/imx8mp_analog: Add property to analog device
Date: Fri,  5 Dec 2025 11:08:06 +0530
Message-Id: <20251205053819.2021772-3-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Add configurable properties for register reset values that differ
between i.MX 8M variants (Plus, Mini, etc.). This allows the same
device implementation to be shared across multiple SoCs.

Properties added:
- arm-pll-fdiv-ctl0-reset: ARM PLL divider control reset value

Default value is set to match i.MX 8MP reset value (0x000FA031).
This can be overridden in the variant like iMX8MM with its own
reset value.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/misc/imx8mp_analog.c         | 12 +++++++++++-
 include/hw/misc/imx8mp_analog.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/misc/imx8mp_analog.c b/hw/misc/imx8mp_analog.c
index 23ffae84f8..7c904d77f4 100644
--- a/hw/misc/imx8mp_analog.c
+++ b/hw/misc/imx8mp_analog.c
@@ -12,6 +12,7 @@
 #include "qemu/log.h"
 
 #include "hw/misc/imx8mp_analog.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #define ANALOG_PLL_LOCK BIT(31)
@@ -51,7 +52,10 @@ static void imx8mp_analog_reset(DeviceState *dev)
     s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] = 0x0010003f;
     s->analog[ANALOG_VPU_PLL_MNIT_CTRL] = 0x00280081;
     s->analog[ANALOG_ARM_PLL_GEN_CTRL] = 0x00000810;
-    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = 0x000fa031;
+
+    /* Use property value instead of hardcoded */
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = s->arm_pll_fdiv_ctl0_reset;
+
     s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] = 0x0010003f;
     s->analog[ANALOG_ARM_PLL_MNIT_CTRL] = 0x00280081;
     s->analog[ANALOG_SYS_PLL1_GEN_CTRL] = 0x0aaaa810;
@@ -138,11 +142,17 @@ static const VMStateDescription imx8mp_analog_vmstate = {
     },
 };
 
+static const Property imx8mp_analog_properties[] = {
+    DEFINE_PROP_UINT32("arm-pll-fdiv-ctl0-reset", IMX8MPAnalogState,
+                       arm_pll_fdiv_ctl0_reset, 0x000fa031), /* imx8mp default */
+};
+
 static void imx8mp_analog_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, imx8mp_analog_reset);
+    device_class_set_props(dc, imx8mp_analog_properties);
     dc->vmsd  = &imx8mp_analog_vmstate;
     dc->desc  = "i.MX 8M Plus Analog Module";
 }
diff --git a/include/hw/misc/imx8mp_analog.h b/include/hw/misc/imx8mp_analog.h
index 955f03215a..b313820392 100644
--- a/include/hw/misc/imx8mp_analog.h
+++ b/include/hw/misc/imx8mp_analog.h
@@ -76,6 +76,9 @@ struct IMX8MPAnalogState {
     } mmio;
 
     uint32_t analog[ANALOG_MAX];
+
+    /* Property for variant-specific reset values */
+    uint32_t arm_pll_fdiv_ctl0_reset;
 };
 
 #endif /* IMX8MP_ANALOG_H */
-- 
2.34.1


