Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7ACA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOcq-0004oN-N7; Wed, 07 Oct 2026 06:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcT-0004Hw-Ga; Wed, 07 Oct 2026 06:11:31 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcR-0004R1-U9; Wed, 07 Oct 2026 06:11:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 775CD200037;
 Wed,  7 Oct 2026 12:11:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C5F8200031;
 Wed,  7 Oct 2026 12:11:24 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 30F8B180023B;
 Wed,  7 Oct 2026 18:11:22 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCHv4 08/11] hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock
 outputs
Date: Wed,  7 Oct 2026 15:41:02 +0530
Message-Id: <20261007101105.3917771-9-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
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

Add cm7_cpuclk (24 MHz) and cm7_refclk (32.768 kHz) clock outputs
to the i.MX8MP CCM. These are required by the ARMv7M model to boot
the Cortex-M7 core in an AMP configuration.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx8mp_ccm.c         | 9 +++++++++
 include/hw/misc/imx8mp_ccm.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
index 97d363e79d..41746e1eeb 100644
--- a/hw/misc/imx8mp_ccm.c
+++ b/hw/misc/imx8mp_ccm.c
@@ -12,17 +12,24 @@
 #include "qemu/log.h"
 
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
 
 #include "trace.h"
 
 #define CKIH_FREQ 16000000 /* 16MHz crystal input */
 
+#define IMX8MP_CM7_CPUCLK_HZ 24000000ULL   /* osc_24m */
+#define IMX8MP_CM7_REFCLK_HZ 32768ULL      /* osc_32k */
+
 static void imx8mp_ccm_reset(DeviceState *dev)
 {
     IMX8MPCCMState *s = IMX8MP_CCM(dev);
 
     memset(s->ccm, 0, sizeof(s->ccm));
+
+    clock_set_hz(s->cm7_cpuclk, IMX8MP_CM7_CPUCLK_HZ);
+    clock_set_hz(s->cm7_refclk, IMX8MP_CM7_REFCLK_HZ);
 }
 
 #define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
@@ -88,6 +95,8 @@ static void imx8mp_ccm_init(Object *obj)
     SysBusDevice *sd = SYS_BUS_DEVICE(obj);
     IMX8MPCCMState *s = IMX8MP_CCM(obj);
 
+    s->cm7_cpuclk = qdev_init_clock_out(DEVICE(obj), "cm7_cpuclk");
+    s->cm7_refclk = qdev_init_clock_out(DEVICE(obj), "cm7_refclk");
     memory_region_init_io(&s->iomem,
                           obj,
                           &imx8mp_set_clr_tog_ops,
diff --git a/include/hw/misc/imx8mp_ccm.h b/include/hw/misc/imx8mp_ccm.h
index 685c8582ff..c6ede6928c 100644
--- a/include/hw/misc/imx8mp_ccm.h
+++ b/include/hw/misc/imx8mp_ccm.h
@@ -9,6 +9,7 @@
 #ifndef IMX8MP_CCM_H
 #define IMX8MP_CCM_H
 
+#include "hw/core/clock.h"
 #include "hw/misc/imx_ccm.h"
 #include "qom/object.h"
 
@@ -25,6 +26,8 @@ struct IMX8MPCCMState {
     MemoryRegion iomem;
 
     uint32_t ccm[CCM_MAX];
+    Clock *cm7_cpuclk;
+    Clock *cm7_refclk;
 };
 
 #endif /* IMX8MP_CCM_H */
-- 
2.34.1


