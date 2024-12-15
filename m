Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B6BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtzv-0002LQ-JK; Sun, 15 Dec 2024 14:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzq-00025a-VY
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:43 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzo-0001Uh-Cb
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:42 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e173ed85bso1605264a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289779; x=1734894579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/xuH1pEhrlq1qA7+A0AsoIQRxHu+dYKCPiI8CdN18M=;
 b=oKsxC7oL3IuvC8jbch5D4rP9GrzbI68RvabqUMsWcubasJaD2nu3I9IR1+BRaGGJd8
 wUm2jzELQhnMghyySc64ekiHqr8am/FnBOg4XGaTsI2tfEoCweaNzbVO53kvuzYH58/K
 WTJtRYSHDhiRjYWqoTi7uwmFJUim5BrJkdVEXjtsk2FRNDY4CqM/fVNpkGFY7eh4U3L5
 cOTuCr1BKEwefaSci/a83bHy8mlxHs5V6e64OBc8NfCeC7MO7lDWY+dfHX8ryjfDKEH4
 bOTI5Aok6N7kk7DvEuis+bVNRSrFg40er2Iayg9Yo/QRYlbbV0cyX9RpYU5NwXBMLkto
 d9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289779; x=1734894579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/xuH1pEhrlq1qA7+A0AsoIQRxHu+dYKCPiI8CdN18M=;
 b=TiwLmARVViwSuU/pUH65EcVbCOdRVm/9rziAfMmuRRPH0iPIq3R8VnU99BQgSCbFg4
 W4W79zpV8snk405GEuCfO9I7ud+5TjMUPkL5VdlwKy1cEv0KUOvoA/2gk9jG30h4h/sc
 V+x9WNHj2TUT/3ElSssb8mjdVEbIG991tBYdx/enQ/83zgm+zpekHV4L/4tMT08M+3eU
 BUXRVGK1ZXfYiUeqs+iBAD/J9AZK/MopACoMNUxxlY2tHWHsGEFKLkSJMcSBGn6j16br
 slgsCF5/z+mhQI696jJkm60+K8WvDEXwsUsCXaToMRHFGqPfms8HfVHlOxYmHoYlgLpf
 Ctyw==
X-Gm-Message-State: AOJu0Yx+OK5XvmMfQB8u7mBkmzVyQ9IahSneNm7dzcB6LIAtfEOi9knk
 kym9+p34mJsoOISzBVNK28jv7SBD58k2x2IcOQYXaEwsNaVhhQn0fzA32CDREjKQPMImcyYCaXY
 b3IqKUJZs
X-Gm-Gg: ASbGncvtryzffn5QmUBGVzsegBoPkPKWAnnlvDzWqXaBYD/jDjO4M9E/CS2xzkFq8Df
 3as/QQcKy+zafr5epfylYaIEPe+TwgaVf/wesTDdVgWe+0vBbMhJtrqfnu1nML4icHXOwsBFdgH
 bj6sVbN/tz7A2hRPQU2l6nKy6GCh8nOWdg78E5/DWO4kwL/tg49KfOcuF5x12H9NCIMvoqqTSiZ
 7+VY/I2Ifs12nEDs7/nlfLMbPYo5icS3g+WLMV4WUeXVUFD2KBab72kyUaQRE1cMfHI6EubI1d/
 waOQ5J7HEhCTilMIl4nqd8UANDNvz/kSwBhi6S5hgPY=
X-Google-Smtp-Source: AGHT+IG+3BGu1mRvD5SN/EAC2P8nhwNaLYiO2wZP+E09s0Y5u7kSPq5jRetdv2x6+jkaWRZmeRwdUA==
X-Received: by 2002:a05:6830:700f:b0:71d:ffa1:6b0a with SMTP id
 46e09a7af769-71e3ba3ad3emr4964439a34.23.1734289778852; 
 Sun, 15 Dec 2024 11:09:38 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/67] hw/pci-host: Constify all Property
Date: Sun, 15 Dec 2024 13:05:11 -0600
Message-ID: <20241215190533.3222854-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/dino.c         | 2 +-
 hw/pci-host/gpex.c         | 2 +-
 hw/pci-host/grackle.c      | 2 +-
 hw/pci-host/gt64120.c      | 2 +-
 hw/pci-host/i440fx.c       | 2 +-
 hw/pci-host/mv64361.c      | 2 +-
 hw/pci-host/pnv_phb.c      | 4 ++--
 hw/pci-host/pnv_phb3.c     | 2 +-
 hw/pci-host/pnv_phb4.c     | 2 +-
 hw/pci-host/pnv_phb4_pec.c | 2 +-
 hw/pci-host/ppce500.c      | 2 +-
 hw/pci-host/q35.c          | 4 ++--
 hw/pci-host/raven.c        | 2 +-
 hw/pci-host/sabre.c        | 2 +-
 hw/pci-host/uninorth.c     | 2 +-
 hw/pci-host/versatile.c    | 2 +-
 hw/pci-host/xilinx-pcie.c  | 2 +-
 17 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 283fc0dc57..ead9893f21 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -492,7 +492,7 @@ static void dino_pcihost_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), dino_set_irq, DINO_IRQS);
 }
 
-static Property dino_pcihost_properties[] = {
+static const Property dino_pcihost_properties[] = {
     DEFINE_PROP_LINK("memory-as", DinoState, memory_as, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf5..8a955ca130 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -147,7 +147,7 @@ static const char *gpex_host_root_bus_path(PCIHostState *host_bridge,
     return "0000:00";
 }
 
-static Property gpex_host_properties[] = {
+static const Property gpex_host_properties[] = {
     /*
      * Permit CPU accesses to unmapped areas of the PIO and MMIO windows
      * (discarding writes and returning -1 for reads) rather than aborting.
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 8e589ff2c9..d64de73774 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -129,7 +129,7 @@ static char *grackle_ofw_unit_address(const SysBusDevice *dev)
     return g_strdup_printf("%x", s->ofw_addr);
 }
 
-static Property grackle_properties[] = {
+static const Property grackle_properties[] = {
     DEFINE_PROP_UINT32("ofw-addr", GrackleState, ofw_addr, -1),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 14fc803d27..3c73ebe83f 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1274,7 +1274,7 @@ static const TypeInfo gt64120_pci_info = {
     },
 };
 
-static Property gt64120_properties[] = {
+static const Property gt64120_properties[] = {
     DEFINE_PROP_BOOL("cpu-little-endian", GT64120State,
                      cpu_little_endian, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 4f0a0438d7..40780fbc52 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -353,7 +353,7 @@ static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
     return "0000:00";
 }
 
-static Property i440fx_props[] = {
+static const Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
                      pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
     DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, I440FXState,
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 421c287eb0..2518d5abe6 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -98,7 +98,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
-static Property mv64361_pcihost_props[] = {
+static const Property mv64361_pcihost_props[] = {
     DEFINE_PROP_UINT8("index", MV64361PCIState, index, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index d4c118d443..888f0786a0 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -183,7 +183,7 @@ static const char *pnv_phb_root_bus_path(PCIHostState *host_bridge,
     return phb->bus_path;
 }
 
-static Property pnv_phb_properties[] = {
+static const Property pnv_phb_properties[] = {
     DEFINE_PROP_UINT32("index", PnvPHB, phb_id, 0),
     DEFINE_PROP_UINT32("chip-id", PnvPHB, chip_id, 0),
     DEFINE_PROP_UINT32("version", PnvPHB, version, 0),
@@ -302,7 +302,7 @@ static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
     pci_config_set_interrupt_pin(pci->config, 0);
 }
 
-static Property pnv_phb_root_port_properties[] = {
+static const Property pnv_phb_root_port_properties[] = {
     DEFINE_PROP_UINT32("version", PnvPHBRootPort, version, 0),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 2a74dbe45f..529b33b5a2 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1090,7 +1090,7 @@ void pnv_phb3_update_regions(PnvPHB3 *phb)
     pnv_phb3_check_all_m64s(phb);
 }
 
-static Property pnv_phb3_properties[] = {
+static const Property pnv_phb3_properties[] = {
     DEFINE_PROP_UINT32("index", PnvPHB3, phb_id, 0),
     DEFINE_PROP_UINT32("chip-id", PnvPHB3, chip_id, 0),
     DEFINE_PROP_LINK("chip", PnvPHB3, chip, TYPE_PNV_CHIP, PnvChip *),
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 99991008c1..482fe25803 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1688,7 +1688,7 @@ static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno,
     }
 }
 
-static Property pnv_phb4_properties[] = {
+static const Property pnv_phb4_properties[] = {
     DEFINE_PROP_UINT32("index", PnvPHB4, phb_id, 0),
     DEFINE_PROP_UINT32("chip-id", PnvPHB4, chip_id, 0),
     DEFINE_PROP_LINK("pec", PnvPHB4, pec, TYPE_PNV_PHB4_PEC,
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ce8e228f98..f8975403d3 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -283,7 +283,7 @@ static int pnv_pec_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static Property pnv_pec_properties[] = {
+static const Property pnv_pec_properties[] = {
     DEFINE_PROP_UINT32("index", PnvPhb4PecState, index, 0),
     DEFINE_PROP_UINT32("chip-id", PnvPhb4PecState, chip_id, 0),
     DEFINE_PROP_LINK("chip", PnvPhb4PecState, chip, TYPE_PNV_CHIP,
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index b70631045a..54071fc125 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -507,7 +507,7 @@ static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static Property pcihost_properties[] = {
+static const Property pcihost_properties[] = {
     DEFINE_PROP_UINT32("first_slot", PPCE500PCIState, first_slot, 0x11),
     DEFINE_PROP_UINT32("first_pin_irq", PPCE500PCIState, first_pin_irq, 0x1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index f3e713318e..af0b77ea1e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -170,7 +170,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
  * properties need to be initialized manually by
  * q35_host_initfn() after the object_initialize() call.
  */
-static Property q35_host_props[] = {
+static const Property q35_host_props[] = {
     DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, Q35PCIHost, parent_obj.base_addr,
                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, Q35PCIHost,
@@ -662,7 +662,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                    OBJECT(&mch->smram));
 }
 
-static Property mch_props[] = {
+static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        16),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index a7dfddd69e..b0a4a669f5 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -422,7 +422,7 @@ static const TypeInfo raven_info = {
     },
 };
 
-static Property raven_pcihost_properties[] = {
+static const Property raven_pcihost_properties[] = {
     DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
                        EM_NONE),
     DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 1707feb951..623afed644 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -492,7 +492,7 @@ static char *sabre_ofw_unit_address(const SysBusDevice *dev)
                (uint32_t)(s->special_base & 0xffffffff));
 }
 
-static Property sabre_properties[] = {
+static const Property sabre_properties[] = {
     DEFINE_PROP_UINT64("special-base", SabreState, special_base, 0),
     DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index e4c1abd871..bd670cfa9d 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -423,7 +423,7 @@ static const TypeInfo unin_internal_pci_host_info = {
     },
 };
 
-static Property pci_unin_main_pci_host_props[] = {
+static const Property pci_unin_main_pci_host_props[] = {
     DEFINE_PROP_UINT32("ofw-addr", UNINHostState, ofw_addr, -1),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index d257acee17..5d59640691 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -498,7 +498,7 @@ static const TypeInfo versatile_pci_host_info = {
     },
 };
 
-static Property pci_vpb_properties[] = {
+static const Property pci_vpb_properties[] = {
     DEFINE_PROP_UINT8("broken-irq-mapping", PCIVPBState, irq_mapping_prop,
                       PCI_VPB_IRQMAP_ASSUME_OK),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 24f691ea82..848403970b 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -156,7 +156,7 @@ static void xilinx_pcie_host_init(Object *obj)
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
 
-static Property xilinx_pcie_host_props[] = {
+static const Property xilinx_pcie_host_props[] = {
     DEFINE_PROP_UINT32("bus_nr", XilinxPCIEHost, bus_nr, 0),
     DEFINE_PROP_SIZE("cfg_base", XilinxPCIEHost, cfg_base, 0),
     DEFINE_PROP_SIZE("cfg_size", XilinxPCIEHost, cfg_size, 32 * MiB),
-- 
2.43.0


