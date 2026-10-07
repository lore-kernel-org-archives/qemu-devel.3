Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055B8CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOce-0004Wh-N8; Wed, 07 Oct 2026 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcT-0004I7-Ja; Wed, 07 Oct 2026 06:11:31 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcR-0004R7-VK; Wed, 07 Oct 2026 06:11:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35A361A000F;
 Wed,  7 Oct 2026 12:11:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F3A811A000C;
 Wed,  7 Oct 2026 12:11:25 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A4151800226;
 Wed,  7 Oct 2026 18:11:23 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 09/11] hw/arm: Add ITCM and DTCM memory regions to i.MX8MP
Date: Wed,  7 Oct 2026 15:41:03 +0530
Message-Id: <20261007101105.3917771-10-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
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

Add the 128 KiB ITCM and DTCM used by the i.MX8MP Cortex-M7
subsystem.

Expose ITCM and DTCM using the system-bus windows available to the
Cortex-A53, and add the Cortex-M7-visible aliases at 0x00000000
and 0x20000000 respectively.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/fsl-imx8mp.c         | 33 +++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mp.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c168c97d1a..18d2b17ca8 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -779,6 +779,37 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].addr,
                                 &s->ocram);
 
+    if (!memory_region_init_ram(&s->itcm, OBJECT(dev), "imx8mp.itcm",
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].addr,
+                                &s->itcm);
+
+    if (!memory_region_init_ram(&s->dtcm, OBJECT(dev), "imx8mp.dtcm",
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].addr,
+                                &s->dtcm);
+
+    /* M7-view aliases: ITCM@0x0, DTCM@0x20000000 */
+    memory_region_init_alias(&s->itcm_alias, OBJECT(dev), "imx8mp.itcm-alias",
+                             &s->itcm, 0,
+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].size);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        0x00000000, &s->itcm_alias, 1);
+
+    memory_region_init_alias(&s->dtcm_alias, OBJECT(dev), "imx8mp.dtcm-alias",
+                             &s->dtcm, 0,
+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].size);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        0x20000000, &s->dtcm_alias, 1);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -796,6 +827,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_IOMUXC_GPR:
         case FSL_IMX8MP_MU_1_A ... FSL_IMX8MP_MU_3_B:
         case FSL_IMX8MP_OCRAM:
+        case FSL_IMX8MP_TCM_ITCM:
+        case FSL_IMX8MP_TCM_DTCM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index f3e134cdc0..f547cbae42 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -90,6 +90,10 @@ struct FslImx8mpState {
     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       ocram;
+    MemoryRegion       itcm;
+    MemoryRegion       dtcm;
+    MemoryRegion       itcm_alias;
+    MemoryRegion       dtcm_alias;
 
     uint32_t           phy_num;
     bool               phy_connected;
-- 
2.34.1


