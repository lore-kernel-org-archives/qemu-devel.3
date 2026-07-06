Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1537C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmC2-0007Lj-CF; Mon, 06 Jul 2026 12:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wgmBz-0007KL-2x
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:29:11 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wgmBx-0002NL-I6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:29:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BA061A00A9;
 Mon,  6 Jul 2026 18:29:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E39761A00A5;
 Mon,  6 Jul 2026 18:29:04 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 081871800071;
 Tue,  7 Jul 2026 00:29:03 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCHv2 5/7] hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock outputs
Date: Mon,  6 Jul 2026 21:58:57 +0530
Message-Id: <20260706162859.3361063-6-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add cm7_cpuclk (24 MHz) and cm7_refclk (32.768 kHz) clock outputs
to the i.MX8MP CCM. These are required by the ARMv7M model to boot
the Cortex-M7 core in an AMP configuration.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/imx8mp_ccm.c         | 9 +++++++++
 include/hw/misc/imx8mp_ccm.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
index 911911ed86..5530c924b5 100644
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


