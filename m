Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C744AE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9S-0002hn-7w; Fri, 13 Dec 2024 14:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7k-0007us-AK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:53 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7f-0007f5-VJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:50 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29f88004a92so1253057fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117284; x=1734722084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZhfokFx932XV3g28Kk8wdRBOecdIQ4zxxBiyRlh0hk=;
 b=O3mEu/HeiKcFqvv+dXscl9KpBMZRxuVq7ADNX8/3BTD3MebuhLrCk4ThYNmGTddF7i
 X6J5KAC+dcc2I7+JBvYTUSyWHGPmKDlzdSN2KnAEov9AZJA9XTIhVopodigPytgKfWpH
 +g6t1NVdLRcM717dAc3YZaS1iqQqrUs9iTLkGJeeFx08eNO6Ruy6k36JyLTZfymveDP5
 BzY8Tszc8zyxmjfgkQBVVMxyancnSkJr1qddQGlF4M0s0TRqchJZNqRsNl25Q9Vh9WtV
 CQlA8On1SOuITYQmIO2VIqyO77rsIe1vzxU3jhr0FG420eJyl7OCejlH+UztgMfGJsGW
 fUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117284; x=1734722084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZhfokFx932XV3g28Kk8wdRBOecdIQ4zxxBiyRlh0hk=;
 b=H/DD0vxAV2unTQjzaDVyVKU10i06rI+KaOExPzoe0tdYm19syV2jq4Cu7xjct4sjzY
 wnU7fthgefmQiD/oDAonZwnpNV4N7Oumdq4n92QLsXFYEkLfdYKtPtt4hLymUaRjobzD
 RWqy6b6nGapCVREitzgznpbnLIB7Q4ADIAelBzGwrBEG6RjVScn9JbYP0nYFTZMJFuCo
 5Z1VbtOnA9hEQ/4w2BN7l8i3RO+Od55DY8zf+qWjuTYz4byJEeRzUPZLHdpIA2dKo6ja
 KHUPn9VIeXQZTjx++R/FRPextpwMe1JZy4Ok6YqvYyyL0uiyPumevQKPjfdgM6ZfpwZ7
 avLA==
X-Gm-Message-State: AOJu0YzcwCB09DtX1sm3/ou/RAsPRDunqN40W5R7wxHjJ7hemHACxQYu
 zzcCGcaf2ySkUeh1WhMMlT4Cb5O3kCkBFQmvMOhD4i4pUST3AOvxQy3U4aW3Niquite+wH8a/y1
 bXECwcXOe
X-Gm-Gg: ASbGncvs0/DnnCkCtUGQ8tqZvvBibNEPVZmg0vbEmAJYYhKnkLrPioB/JLdlfOBpWga
 jg1YRyOgIBflOVjITM14edX1kvDZ6K8TwAU0gqD6sCWe3VHUmVt1TLKafqSnnp0HIi1pep7H4wG
 yXK8tHyDFtVil5aFBZ9ty9yOKNR2y2qO5uusZEMkqCsjonwsuFAtB79AUR5QVEDiBpnO2S7Zf+r
 aEWaJ/HXEp39OHjg/HlYDNIRQyF+sQRAvQJWC075iOIZwjMI6qbl9djYDf7y1dg
X-Google-Smtp-Source: AGHT+IGxJDG97/RV+vobqLdaGC+OFpB1PV/YFhJbfs6+AMLABq7v6ZzHh7vq/98aBTpxFiwxKUuJeQ==
X-Received: by 2002:a05:6808:159e:b0:3e5:f4fa:5984 with SMTP id
 5614622812f47-3eba697e467mr1634948b6e.38.1734117282338; 
 Fri, 13 Dec 2024 11:14:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs),
 qemu-riscv@nongnu.org (open list:OpenTitan),
 qemu-ppc@nongnu.org (open list:PowerNV Non-Virt...)
Subject: [PATCH 59/71] hw/ssi: Constify all Property
Date: Fri, 13 Dec 2024 13:07:33 -0600
Message-ID: <20241213190750.2513964-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


