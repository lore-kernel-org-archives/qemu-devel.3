Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF9C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEMz0-0005s2-Ch; Tue, 04 Jun 2024 01:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEMyy-0005nP-6c; Tue, 04 Jun 2024 01:45:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEMyw-0008TH-C5; Tue, 04 Jun 2024 01:45:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Jun
 2024 13:44:43 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 4 Jun 2024 13:44:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v5 09/17] aspeed/smc: support different memory region ops for
 SMC flash region
Date: Tue, 4 Jun 2024 13:44:30 +0800
Message-ID: <20240604054438.3424349-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It set "aspeed_smc_flash_ops" struct which containing
read and write callbacks to be used when I/O is performed
on the SMC flash region. And it set the valid max_access_size 4
by default for all ASPEED SMC models.

However, the valid max_access_size 4 only support 32 bits CPUs.
To support all ASPEED SMC model, introduce a new
"const MemoryRegionOps *" attribute in AspeedSMCClass and
use it in aspeed_smc_flash_realize function.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/ssi/aspeed_smc.c         | 14 +++++++++++++-
 include/hw/ssi/aspeed_smc.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index df0c63469c..129d06690d 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1316,7 +1316,7 @@ static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)
      * Use the default segment value to size the memory region. This
      * can be changed by FW at runtime.
      */
-    memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_flash_ops,
+    memory_region_init_io(&s->mmio, OBJECT(s), s->asc->reg_ops,
                           s, name, s->asc->segments[s->cs].size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 }
@@ -1391,6 +1391,7 @@ static void aspeed_2400_smc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_smc_info = {
@@ -1441,6 +1442,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_fmc_info = {
@@ -1480,6 +1482,7 @@ static void aspeed_2400_spi1_class_init(ObjectClass *klass, void *data)
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
     asc->addr_width        = aspeed_2400_spi1_addr_width;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_spi1_info = {
@@ -1525,6 +1528,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_fmc_info = {
@@ -1560,6 +1564,7 @@ static void aspeed_2500_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_spi1_info = {
@@ -1595,6 +1600,7 @@ static void aspeed_2500_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_spi2_info = {
@@ -1682,6 +1688,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_fmc_info = {
@@ -1721,6 +1728,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_spi1_info = {
@@ -1761,6 +1769,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_spi2_info = {
@@ -1843,6 +1852,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_fmc_info = {
@@ -1881,6 +1891,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_spi1_info = {
@@ -1918,6 +1929,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_spi2_info = {
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index d305ce2e2f..234dca32b0 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -115,6 +115,7 @@ struct AspeedSMCClass {
                            AspeedSegments *seg);
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);
     int (*addr_width)(const AspeedSMCState *s);
+    const MemoryRegionOps *reg_ops;
 };
 
 #endif /* ASPEED_SMC_H */
-- 
2.25.1


