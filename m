Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D63EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB7q-0007v1-3m; Fri, 13 Dec 2024 14:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7A-0006hs-8h
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:18 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB76-0007Ye-Ub
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:15 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-29fae583cc8so1027139fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117250; x=1734722050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHAtuv+A7LoEygNB1h/ibJtbhcSv1EMIHcEESN5V/a8=;
 b=ZkB/prHFsyqwcki96mM2wuBWQeHgqbnWiu334yJ79htSiklQW75M85xJIMAdbWTVl/
 J2VvF6D2oRPC9V4mAhdjlPnC6ecgIPkIUlm/0J7Du/RNP5qJkWwF/9hRbU+gc7O4m7XI
 ppP038oka6oOy4Ag6fDqeWIa5bBU4ZxkVTd0Ei7E6amulexmG7DVhjJdJyXKM1sQZoEP
 h5pvq39BbNQlxva4ttsIC+vCfvg5M7gDv62nM2/ZRWhF01a7BYNf8e1B255a//6yICY+
 YF64jJJwdfh3ItylHKySC0jIzq1TC4j4AzuuMWagus8lC+hoapTxoldKd0E4eKdqOP99
 XUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117250; x=1734722050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHAtuv+A7LoEygNB1h/ibJtbhcSv1EMIHcEESN5V/a8=;
 b=ACgp0xcN7kY/ezCY0rDt+ERTEq9WBu7XlaMfJD+FhwfXbOuw5Q0IHuBGn2Xa2mVRNW
 Bsto3SuC8j/s1MEkC2ehWLRaDupUehM35ep4cl1gYuaYrfDzv6Lw1QnijJz+sZTyNO+x
 rUjChRKhvhGPS0CN2bIt2cQbuhp9mE2MgZmT8Ah0RiERSBNLMonkJlF2Vv2TMJl0RBxS
 wPVYX2anYoByGUEx2+wlYGKCef5fbGtL61UxeY2tTWDmo2cmYNgYfu/3Buyi4xKJ3ZqF
 B2O7Hs5QkT/3HXOlFWg/2NfvfDOLn+bMMLfBvlJEHB4wCCa1H4c7zuydI4M9r+9H2hAX
 4qpA==
X-Gm-Message-State: AOJu0YyRvEAogOZDVqgvaT4KjcV0F3eNvX8XHgjlS+vB99DrIbLXlNH0
 7LhjG2m2+usEXWJQq59O+pyOpQqKX4WiW+mwqFoRKXK1pcFp/ei4LhEbKMLDQfgu0JVqQdMFrGi
 qcD2g+H6U
X-Gm-Gg: ASbGncuPgu/oqQplhJ8x4deC5SNHDy0dUsXmidjCjjh4XupnSMoL/N7K6gNT5UUrgiU
 6bpbnZ9KueZKsLgablYOMMBpkowPcK4rxIDo1xOZb5Nj7339jo38rJrGZnc3nXE/tWdeOxDXTSR
 1JhVS2mQNibUrkrcQ88zjojFRaYJ844tWxbgrUsjYXgo+rDgilFjGjhu5DThL5+txYOu54K7Ei2
 w4/LriJomqNPffEeiVPJjGe99rcQsc/fWk7MYhg60n9xApCCQ1TQhF5USAjRWn6
X-Google-Smtp-Source: AGHT+IHKZDa2W8ubI6qavisMqiq253sPSn7Oi58sHuNQ5pX2dsluYchS87gqmIiaFECvFkDG7EtjgQ==
X-Received: by 2002:a05:6808:384c:b0:3ea:9a5c:ac06 with SMTP id
 5614622812f47-3eb94e4c57amr5398084b6e.1.1734117250386; 
 Fri, 13 Dec 2024 11:14:10 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerNV Non-Virt...)
Subject: [PATCH 49/71] hw/ppc: Constify all Property
Date: Fri, 13 Dec 2024 13:07:23 -0600
Message-ID: <20241213190750.2513964-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/pnv.c             | 2 +-
 hw/ppc/pnv_adu.c         | 2 +-
 hw/ppc/pnv_chiptod.c     | 2 +-
 hw/ppc/pnv_core.c        | 4 ++--
 hw/ppc/pnv_homer.c       | 2 +-
 hw/ppc/pnv_i2c.c         | 2 +-
 hw/ppc/pnv_lpc.c         | 2 +-
 hw/ppc/pnv_pnor.c        | 2 +-
 hw/ppc/pnv_psi.c         | 2 +-
 hw/ppc/ppc405_uc.c       | 2 +-
 hw/ppc/ppc440_uc.c       | 2 +-
 hw/ppc/ppc4xx_devs.c     | 4 ++--
 hw/ppc/ppc4xx_sdram.c    | 4 ++--
 hw/ppc/prep_systemio.c   | 2 +-
 hw/ppc/rs6000_mc.c       | 2 +-
 hw/ppc/spapr_cpu_core.c  | 2 +-
 hw/ppc/spapr_nvdimm.c    | 2 +-
 hw/ppc/spapr_pci.c       | 2 +-
 hw/ppc/spapr_rng.c       | 2 +-
 hw/ppc/spapr_tpm_proxy.c | 2 +-
 20 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0f0d7567d..b90a052ce0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2422,7 +2422,7 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property pnv_chip_properties[] = {
+static const Property pnv_chip_properties[] = {
     DEFINE_PROP_UINT32("chip-id", PnvChip, chip_id, 0),
     DEFINE_PROP_UINT64("ram-start", PnvChip, ram_start, 0),
     DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index f636dedf79..646736f7e9 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -185,7 +185,7 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
                           PNV9_XSCOM_ADU_SIZE);
 }
 
-static Property pnv_adu_properties[] = {
+static const Property pnv_adu_properties[] = {
     DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 1e41fe557a..840ef23128 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -450,7 +450,7 @@ static int pnv_chiptod_power9_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
 }
 
-static Property pnv_chiptod_properties[] = {
+static const Property pnv_chiptod_properties[] = {
     DEFINE_PROP_BOOL("primary", PnvChipTOD, primary, false),
     DEFINE_PROP_BOOL("secondary", PnvChipTOD, secondary, false),
     DEFINE_PROP_LINK("chip", PnvChipTOD , chip, TYPE_PNV_CHIP, PnvChip *),
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e6b02294b1..22864c92f3 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -435,7 +435,7 @@ static void pnv_core_unrealize(DeviceState *dev)
     g_free(pc->threads);
 }
 
-static Property pnv_core_properties[] = {
+static const Property pnv_core_properties[] = {
     DEFINE_PROP_UINT32("hwid", PnvCore, hwid, 0),
     DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
     DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
@@ -693,7 +693,7 @@ static void pnv_quad_power10_realize(DeviceState *dev, Error **errp)
                           pqc->xscom_qme_size);
 }
 
-static Property pnv_quad_properties[] = {
+static const Property pnv_quad_properties[] = {
     DEFINE_PROP_UINT32("quad-id", PnvQuad, quad_id, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index f9a203d11d..b1f83e2cf2 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -412,7 +412,7 @@ static void pnv_homer_realize(DeviceState *dev, Error **errp)
                           hmrc->homer_size);
 }
 
-static Property pnv_homer_properties[] = {
+static const Property pnv_homer_properties[] = {
     DEFINE_PROP_LINK("chip", PnvHomer, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index eec5047ce8..4bd61abeed 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -543,7 +543,7 @@ static void pnv_i2c_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(DEVICE(dev), &i2c->psi_irq, 1);
 }
 
-static Property pnv_i2c_properties[] = {
+static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_LINK("chip", PnvI2C, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_UINT32("engine", PnvI2C, engine, 1),
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 8c203d2059..4d47167163 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -828,7 +828,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out_named(dev, &lpc->psi_irq_lpchc, "LPCHC", 1);
 }
 
-static Property pnv_lpc_properties[] = {
+static const Property pnv_lpc_properties[] = {
     DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_has_serirq, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index 6280408299..eed6d32650 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -112,7 +112,7 @@ static void pnv_pnor_realize(DeviceState *dev, Error **errp)
                           TYPE_PNV_PNOR, s->size);
 }
 
-static Property pnv_pnor_properties[] = {
+static const Property pnv_pnor_properties[] = {
     DEFINE_PROP_INT64("size", PnvPnor, size, 128 * MiB),
     DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 37c56882b8..e7d6ceee99 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -552,7 +552,7 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom_offset)
     return 0;
 }
 
-static Property pnv_psi_properties[] = {
+static const Property pnv_psi_properties[] = {
     DEFINE_PROP_UINT64("bar", PnvPsi, bar, 0),
     DEFINE_PROP_UINT64("fsp-bar", PnvPsi, fsp_bar, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 58cbd0507a..801f97811f 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -965,7 +965,7 @@ static void ppc405_cpc_realize(DeviceState *dev, Error **errp)
                         &dcr_read_epcpc, &dcr_write_epcpc);
 }
 
-static Property ppc405_cpc_properties[] = {
+static const Property ppc405_cpc_properties[] = {
     DEFINE_PROP_UINT32("sys-clk", Ppc405CpcState, sysclk, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 1312aa2080..05a5ef6f77 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1020,7 +1020,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     ppc460ex_pcie_register_dcrs(s);
 }
 
-static Property ppc460ex_pcie_props[] = {
+static const Property ppc460ex_pcie_props[] = {
     DEFINE_PROP_INT32("busnum", PPC460EXPCIEState, num, -1),
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
     DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index db8f6b9497..530a392f2a 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -231,7 +231,7 @@ static void ppc4xx_mal_finalize(Object *obj)
     g_free(mal->txctpr);
 }
 
-static Property ppc4xx_mal_properties[] = {
+static const Property ppc4xx_mal_properties[] = {
     DEFINE_PROP_UINT8("txc-num", Ppc4xxMalState, txcnum, 0),
     DEFINE_PROP_UINT8("rxc-num", Ppc4xxMalState, rxcnum, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -539,7 +539,7 @@ bool ppc4xx_dcr_realize(Ppc4xxDcrDeviceState *dev, PowerPCCPU *cpu,
     return sysbus_realize(SYS_BUS_DEVICE(dev), errp);
 }
 
-static Property ppc4xx_dcr_properties[] = {
+static const Property ppc4xx_dcr_properties[] = {
     DEFINE_PROP_LINK("cpu", Ppc4xxDcrDeviceState, cpu, TYPE_POWERPC_CPU,
                      PowerPCCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index 2ee21f1ca7..6cfb07a11f 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -425,7 +425,7 @@ static void ppc4xx_sdram_ddr_realize(DeviceState *dev, Error **errp)
                         s, &sdram_ddr_dcr_read, &sdram_ddr_dcr_write);
 }
 
-static Property ppc4xx_sdram_ddr_props[] = {
+static const Property ppc4xx_sdram_ddr_props[] = {
     DEFINE_PROP_LINK("dram", Ppc4xxSdramDdrState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdrState, nbanks, 4),
@@ -710,7 +710,7 @@ static void ppc4xx_sdram_ddr2_realize(DeviceState *dev, Error **errp)
                         s, &sdram_ddr2_dcr_read, &sdram_ddr2_dcr_write);
 }
 
-static Property ppc4xx_sdram_ddr2_props[] = {
+static const Property ppc4xx_sdram_ddr2_props[] = {
     DEFINE_PROP_LINK("dram", Ppc4xxSdramDdr2State, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdr2State, nbanks, 4),
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 4d3a251ed8..ca475c69f4 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -285,7 +285,7 @@ static const VMStateDescription vmstate_prep_systemio = {
     },
 };
 
-static Property prep_systemio_properties[] = {
+static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 07b0b664d9..bee9bc62d4 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -207,7 +207,7 @@ static const VMStateDescription vmstate_rs6000mc = {
     },
 };
 
-static Property rs6000mc_properties[] = {
+static const Property rs6000mc_properties[] = {
     DEFINE_PROP_UINT32("ram-size", RS6000MCState, ram_size, 0),
     DEFINE_PROP_BOOL("auto-configure", RS6000MCState, autoconfigure, true),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 135f86a622..88d743a3c3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -361,7 +361,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property spapr_cpu_core_properties[] = {
+static const Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", SpaprCpuCore, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 7d2dfe5e3d..2ef6f29f3d 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -884,7 +884,7 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
 }
 
-static Property spapr_nvdimm_properties[] = {
+static const Property spapr_nvdimm_properties[] = {
 #ifdef CONFIG_LIBPMEM
     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
 #endif
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7e24084673..3edff528ca 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2033,7 +2033,7 @@ static void spapr_phb_reset(DeviceState *qdev)
     g_hash_table_remove_all(sphb->msi);
 }
 
-static Property spapr_phb_properties[] = {
+static const Property spapr_phb_properties[] = {
     DEFINE_PROP_UINT32("index", SpaprPhbState, index, -1),
     DEFINE_PROP_UINT64("mem_win_size", SpaprPhbState, mem_win_size,
                        SPAPR_PCI_MEM32_WIN_SIZE),
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index c2fda7ad20..51c3a54d45 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -130,7 +130,7 @@ static void spapr_rng_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property spapr_rng_properties[] = {
+static const Property spapr_rng_properties[] = {
     DEFINE_PROP_BOOL("use-kvm", SpaprRngState, use_kvm, false),
     DEFINE_PROP_LINK("rng", SpaprRngState, backend, TYPE_RNG_BACKEND,
                      RngBackend *),
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index e10af35a18..37521b88cb 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -145,7 +145,7 @@ static void spapr_tpm_proxy_unrealize(DeviceState *d)
     qemu_unregister_reset(spapr_tpm_proxy_reset, tpm_proxy);
 }
 
-static Property spapr_tpm_proxy_properties[] = {
+static const Property spapr_tpm_proxy_properties[] = {
     DEFINE_PROP_STRING("host-path", SpaprTpmProxy, host_path),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


