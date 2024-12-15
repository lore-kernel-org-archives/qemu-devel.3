Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AA2E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0B-0004My-EB; Sun, 15 Dec 2024 14:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu04-0003bG-Gh
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:56 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu01-0001XR-Ix
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:56 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f2d7868ef0so934777eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289792; x=1734894592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6L3BYpq1x+ED6fgI25BXYsC6DYPqvahLoa97JqwBXKk=;
 b=g7hTPGBm/vbGIptpNM2uDDumYbNSdFW4UuxUOXGUUQ0eUl9wGoJ4IYYOQVGFPQNTSG
 G/nQf07xB25wdIHGktvYWU1JmzzuPNFnyPukLeJRvU4GG1oG6X0Dkyk8ZT1XgM4wa6LY
 PfojcmhsK0kvsEqW6U30K2NjQXwz+lj507AbPpJH1Ttq2/CHTbZ2Z6qYQSLnmzExhYJ+
 39iP0Ahh/J4fbM1ktYIYgxZdP0kLA7EVtj6Skb85iq5h4BLutJUpGd7quFSENrw9aBFy
 2DFPxkntZl5JMIj/0ekamyAxaDMg+QPkB/GDasjxsWt6MS8awLmyriqdEnJCJIhyL+f8
 N9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289792; x=1734894592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6L3BYpq1x+ED6fgI25BXYsC6DYPqvahLoa97JqwBXKk=;
 b=Jj1eCn7LXzdtcYs+YGy3aeKrpLLcklV2z8DxKNowSXjqueHblIy/Tm1pz5nLWkRgmy
 l74ssZYpKpgN9Vg3erSDGCD+Ufg9N/WO+sdafnFiw7HSFKp/qeg/XUr8DtAB0wMSeF0i
 Q98XjE2JJQNxPlzERTXkguaoOsGzfUoN8NlW15pLwpwrqcQXjY532yXfjhwLV+HiC8C9
 mHADEgvbj6xufKddo7dTTjC362Ny4Re9FTvzOlymA/4JM1ikPuzOCFSGFCNC2MSOW2jI
 EfZXclRy205otO1Vfsf2k4F8QgvDxEPd1qbLAPeQuzaEMlSf8Up6M/DRF+ycvSwbMgz0
 k8XA==
X-Gm-Message-State: AOJu0Yxo/lRXKhJVGgFY+UFWBo9T6GD3ZbK/YOkRY8SZcaX06kjRLpQj
 GShs6ERH4r7/jPqm6VdjheRyLAsfXGumcMrnavsT10CPpnSLrPE2qQCpiDWBvXXELTVLVBqCAma
 LI37b/al5
X-Gm-Gg: ASbGnctAIJf3PDfgqv6JiVmCrG11QR9PARFr3iOojOEf04M1IOhJfFoje7tCtAfBPDJ
 0YoLX2kamPk/jjK13lRBCnaiZ+JA2tEZfCUQcL4MV8Z62/VcLlKsmQUKUvzmZi8uhVQMeCzz2i5
 c7xm95/JKvU/kM8P5I3+4mVbWgpOMXMomDLb6JVADlrWM4WHB+tjkUw1EVwKsJaayMnRag2I6bK
 mHbaiFAfurW07Jp0yV5PXylB+UWFecKo2YvqT93FZZbpUWl4dTeRkfmUDtERImz624ayWBMcnVZ
 v3p4hS/LQxORoJo/HYhM4pJyopWF20aEheHcBHd7vc4=
X-Google-Smtp-Source: AGHT+IFGvKhhMsdsE2aD1L0Cl6qYJW7kzOTik1ddeWbD4lTM9sHpOyEijwkIo/k15xFEl902KwZpfw==
X-Received: by 2002:a05:6870:4202:b0:288:5ae1:7318 with SMTP id
 586e51a60fabf-2a3ac6d6547mr5474683fac.22.1734289790732; 
 Sun, 15 Dec 2024 11:09:50 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 57/67] hw/ssi: Constify all Property
Date: Sun, 15 Dec 2024 13:05:23 -0600
Message-ID: <20241215190533.3222854-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ssi/aspeed_smc.c       | 4 ++--
 hw/ssi/ibex_spi_host.c    | 2 +-
 hw/ssi/npcm7xx_fiu.c      | 2 +-
 hw/ssi/pnv_spi.c          | 2 +-
 hw/ssi/sifive_spi.c       | 2 +-
 hw/ssi/ssi.c              | 2 +-
 hw/ssi/xilinx_spi.c       | 2 +-
 hw/ssi/xilinx_spips.c     | 4 ++--
 hw/ssi/xlnx-versal-ospi.c | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 033cbbb59b..bbdd4e4786 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1287,7 +1287,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
     }
 };
 
-static Property aspeed_smc_properties[] = {
+static const Property aspeed_smc_properties[] = {
     DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, false),
     DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
     DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
@@ -1336,7 +1336,7 @@ static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 }
 
-static Property aspeed_smc_flash_properties[] = {
+static const Property aspeed_smc_flash_properties[] = {
     DEFINE_PROP_UINT8("cs", AspeedSMCFlash, cs, 0),
     DEFINE_PROP_LINK("controller", AspeedSMCFlash, controller, TYPE_ASPEED_SMC,
                      AspeedSMCState *),
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 9e07432f7c..60a0b17b62 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -561,7 +561,7 @@ static const MemoryRegionOps ibex_spi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static Property ibex_spi_properties[] = {
+static const Property ibex_spi_properties[] = {
     DEFINE_PROP_UINT32("num_cs", IbexSPIHostState, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 119c38c415..fdd3ad2fdc 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -541,7 +541,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
     },
 };
 
-static Property npcm7xx_fiu_properties[] = {
+static const Property npcm7xx_fiu_properties[] = {
     DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c21b2ebb3c..4ca9c469a4 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1195,7 +1195,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static Property pnv_spi_properties[] = {
+static const Property pnv_spi_properties[] = {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
     DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 08a107792b..7458747779 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -328,7 +328,7 @@ static void sifive_spi_realize(DeviceState *dev, Error **errp)
     fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
 }
 
-static Property sifive_spi_properties[] = {
+static const Property sifive_spi_properties[] = {
     DEFINE_PROP_UINT32("num-cs", SiFiveSPIState, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3f357e8f16..cab0014c3f 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -108,7 +108,7 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
     ssc->realize(s, errp);
 }
 
-static Property ssi_peripheral_properties[] = {
+static const Property ssi_peripheral_properties[] = {
     DEFINE_PROP_UINT8("cs", SSIPeripheral, cs_index, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 7f1e1808c5..588c1ec071 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -361,7 +361,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
     }
 };
 
-static Property xilinx_spi_properties[] = {
+static const Property xilinx_spi_properties[] = {
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index aeb462c3ce..f72cb3cbc8 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1420,12 +1420,12 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
     }
 };
 
-static Property xilinx_zynqmp_qspips_properties[] = {
+static const Property xilinx_zynqmp_qspips_properties[] = {
     DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS, dma_burst_size, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property xilinx_spips_properties[] = {
+static const Property xilinx_spips_properties[] = {
     DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
     DEFINE_PROP_UINT8("num-txrx-bytes", XilinxSPIPS, num_txrx_bytes, 1),
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index ecc1903b8e..e51abe9de2 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1825,7 +1825,7 @@ static const VMStateDescription vmstate_xlnx_versal_ospi = {
     }
 };
 
-static Property xlnx_versal_ospi_properties[] = {
+static const Property xlnx_versal_ospi_properties[] = {
     DEFINE_PROP_BOOL("dac-with-indac", XlnxVersalOspi, dac_with_indac, false),
     DEFINE_PROP_BOOL("indac-write-disabled", XlnxVersalOspi,
                      ind_write_disabled, false),
-- 
2.43.0


