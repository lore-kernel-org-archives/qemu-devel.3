Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF5BE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB7X-0007d9-O3; Fri, 13 Dec 2024 14:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB74-0006Oh-Hs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:12 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB71-0007XV-SE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:09 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f2da12248fso1551820eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117246; x=1734722046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87UWZos2QKdOl0brnZZzf+GGdw2+NZalufbZuF6TgSQ=;
 b=MQ3RBmVLu9FzGooJu6WgHnUPKi9Gwy0HivyBxGTU38ea850dNP28Fq8u8IiUu6962N
 e579h/k/ScYxP/ndGFRQSuaBkdOagCbo4JCL4cktOlGR5shrL3N/6RTuqBwFJGp7zDA9
 vvib+tHvdshTnXE+mAoQyf9oQO9jhhpI0iWn1LVrcv0+HMK7eok+qYBStmJq27A2XD0p
 Xigaqg/t2XzutdPuX04D0YbVAY9q1iyD0hzaGHRObvOnDVTX7ouvStns1eO6AGvQ0G2e
 HRMK8ONE0c3kbftzASryeKHd1u6gTI1HmxZYiiYSmlmxI0ClLcU7jZ3x09qvnXG9l7iB
 TOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117246; x=1734722046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87UWZos2QKdOl0brnZZzf+GGdw2+NZalufbZuF6TgSQ=;
 b=oWaAbilD5luf7LuMc8aAips7mj/tQyqQG8bLrULo85vjoezxzHU8IJrwAHZK2RL4LO
 ImD6t6j84gsy7ikJDF/2zSdd/0fTPU406rQbwtClZfRvSIWc9xIcM+BzK1NPb1ZkI86o
 xkDDuGsViSjB1YoIecO1l2A59fWlGrorTxCseFslgmCsc69n/E1BzAOSwCBA9CYAxdDs
 cRBg+ind50kAde3obWL+neofcaKZOMmyKrc7pafQPYwOWXFCkdT8V/UTcclKfDlEmgOv
 RW/QHqRxoFkQqT0eGDAuyKux/OuJg66ax8ELBW1LUG9UrcxDqVgcfUEKUMMfADM29dYK
 K1/w==
X-Gm-Message-State: AOJu0YxRkxNrE7LNDB8FzmTjXTxzTsP6pTxkounDGeQNab4g9xDYpSCm
 8eQjNncY/bliNbqc03tlf/50A+++ww2aMCXdHZXy6BIh3KKkHb1Vklo4VRi/FK6h0wZhojSHubQ
 Fmeof5EOS
X-Gm-Gg: ASbGncskXb7qb/Yf/mtiOs2tr3mbKregvo+fziwW6wNI8EVpc1mSwQ2CelFJWZu7Adz
 9qHbAhXHQSw3TLVuYiKH6R9kumFFKXfmrrNOdk5ulA4Zumq2qkb61sWgJ8T9VPCfyoOwHe562CY
 EHknBx+Jci2/7doiUEat56Sg3SOkQ3/OI5JZdyuYJr0tRIEIi6a36TxVJ0UKy21CBw0GNSD2DEk
 5MxQuMBipZA7jiU/hheVwIu3EouvAouvbylYIAEBEW6HBbedm7vSM0P+oHXmV6R
X-Google-Smtp-Source: AGHT+IHSqDxHwDg+BOhasnHGxFBsNzSMeZThXCs3ZRJYG4QeWWpWegMlvdpBTETqsUV4GawJ8eJmjQ==
X-Received: by 2002:a05:6808:2191:b0:3eb:4783:df7e with SMTP id
 5614622812f47-3eb94f9328bmr4978559b6e.17.1734117245676; 
 Fri, 13 Dec 2024 11:14:05 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 qemu-ppc@nongnu.org (open list:Old World (g3beige)),
 qemu-arm@nongnu.org (open list:Versatile PB)
Subject: [PATCH 47/71] hw/pci-host: Constify all Property
Date: Fri, 13 Dec 2024 13:07:21 -0600
Message-ID: <20241213190750.2513964-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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


