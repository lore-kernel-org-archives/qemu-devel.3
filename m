Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9896CD3B985
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtgV-0006g4-V7; Tue, 26 Nov 2024 06:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfL-00047B-OI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfG-0002sa-3n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-432d866f70fso50748995e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620207; x=1733225007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnoyXVdD8DdnXViSwr+RJ/lWQxJ2OgIe+SEcc7eHt/g=;
 b=jrWUtcKrnOGHzzC8zLhDSafXS9MMzFnvZfLpz/MlsRTWzJl6mNicR8lVmdFHEjwq7e
 uOMhNSbAZdMNvsKhztPx+f7WSoBZvljYQwkgP1IGzmraeLj0mFF4dVt26iAsGckwz4Gk
 XOzoCxdKJuuSDU9McEorzMbueXaTjhYbqb2IQCl+A44/6BD5bTqlKd8K8m6hN/ezYluW
 WZUqOnNsFLYqd7cXQaBUzjnfu9ayK63BLiW57CfpMYqQH2Or4670FgnyIIOc3YLrKysU
 W/1j3Xat5M3doUlVDJilmJPI2dJMuJ0K3Q7HjCtOexQtV5XPsbzBPCHH4AA0CPqfVPAd
 Rldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620207; x=1733225007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnoyXVdD8DdnXViSwr+RJ/lWQxJ2OgIe+SEcc7eHt/g=;
 b=Q7WlusNrzOO1YX5VgM7J4jY871WAjU0DRCfIgWMEMF9I9AXIpLNhtt/qIL2VSHHayk
 s3+D2IbGPn3MSJgZII/3vSwNPx1uprMAGxwgfLmLTm9IbwMgK0gT+lRpMZZxM++swWel
 Rsg20YI2vgCd291/t2pXC3tG4iqUu7AgM669qh1ROCTreAtHliOoQSNUBwdCVBQ2ux0p
 Aq95FrwvBcSFD8urtrjJayoNAHs3QRY5xeraixDA+VU6vCrW8ZbEHLG7N26untFRe/0i
 oF6VWQT2LDwEaIB8FdV2v35/qAgfJXTe0T6jLb8GEeviCtDtEdLbuK3WNELnT9ommNGv
 7MoA==
X-Gm-Message-State: AOJu0YxXppUpQCcGVTZZ2wPcIFpi3K3H+zH5E6bSG1QXaSJsdPfEbJP0
 N8Mhmj2B9V43xxvJu/9WXs5VMa2ek2A/kbmicWeWGjw6iBWkupSHHjzUadsYkSH2IWyTreI9mnw
 h
X-Gm-Gg: ASbGncvWHaf45T6LSG79u939cPe75B7eIl6MpXTBYk26rX7jPha0ef3xzNvfm+xM7jT
 +ylrkL2jbXOPbIMTMJwbM6osqKjmEc4KdzhpLQHekZkSL0yTfOe2CFSaDrRo+8POU+kKCBv56YB
 1NNIGDaIo+Kftn5Pf20zsPdNmzVL+tP4YpCv2hLpwDnzsHXKUFiCxBcqVzBP3dn2D8V5XX0rqhG
 rQZ5Yo+k/NgqCVs7VhJ10nL2i+jnMKVZS0I/Bf2YmZ/4dU3e6jHJsqMJqqVF2b7GYLX0tmC
X-Google-Smtp-Source: AGHT+IE86je2bY5Ff4z81RfqLwFbRKqw0cw+L5Y7X3+IJXyfozJ9/PHqRDu8tzHFYroJp2IDBzQLLQ==
X-Received: by 2002:a05:600c:6a06:b0:434:9fb5:fe04 with SMTP id
 5b1f17b1804b1-4349fb5ff09mr50911695e9.28.1732620207379; 
 Tue, 26 Nov 2024 03:23:27 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm225022165e9.43.2024.11.26.03.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:23:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 08/13] hw/pci: Propagate bar_at_addr_0_refused to
 pci_register_root_bus()
Date: Tue, 26 Nov 2024 12:22:07 +0100
Message-ID: <20241126112212.64524-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Have pci_register_root_bus() callers set the
'bar_at_addr_0_refused' argument. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h      | 2 +-
 hw/alpha/typhoon.c        | 2 +-
 hw/pci-host/articia.c     | 3 ++-
 hw/pci-host/astro.c       | 3 ++-
 hw/pci-host/bonito.c      | 2 +-
 hw/pci-host/designware.c  | 2 +-
 hw/pci-host/dino.c        | 2 +-
 hw/pci-host/gpex.c        | 3 ++-
 hw/pci-host/grackle.c     | 2 +-
 hw/pci-host/mv64361.c     | 2 +-
 hw/pci-host/pnv_phb3.c    | 2 +-
 hw/pci-host/pnv_phb4.c    | 2 +-
 hw/pci-host/ppc440_pcix.c | 2 +-
 hw/pci-host/ppc4xx_pci.c  | 2 +-
 hw/pci-host/ppce500.c     | 3 ++-
 hw/pci-host/sabre.c       | 2 +-
 hw/pci-host/sh_pci.c      | 2 +-
 hw/pci-host/uninorth.c    | 8 ++++----
 hw/pci-host/xilinx-pcie.c | 2 +-
 hw/pci/pci.c              | 5 +++--
 hw/ppc/ppc440_uc.c        | 2 +-
 hw/ppc/spapr_pci.c        | 2 +-
 hw/s390x/s390-pci-bus.c   | 2 +-
 23 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f5454db0eb5..216b1cbc13a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -310,7 +310,7 @@ PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               void *irq_opaque,
                               MemoryRegion *mem, MemoryRegion *io,
                               uint8_t devfn_min, int nirq,
-                              const char *typename);
+                              const char *typename, bool bar_at_addr_0_refused);
 void pci_unregister_root_bus(PCIBus *bus);
 void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
 PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e8711ae16a3..37f5e07e726 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -891,7 +891,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     b = pci_register_root_bus(dev, "pci",
                               typhoon_set_irq, sys_map_irq, s,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
-                              devfn_min, 64, TYPE_PCI_BUS);
+                              devfn_min, 64, TYPE_PCI_BUS, true);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index f3fcc49f812..847b4c54e2a 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -184,7 +184,8 @@ static void articia_realize(DeviceState *dev, Error **errp)
     /* devfn_min is 8 that matches first PCI slot in AmigaOne */
     h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
                                    amigaone_pcihost_bus0_map_irq, dev, &s->mem,
-                                   &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);
+                                   &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS,
+                                   true);
     pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
                                            TYPE_ARTICIA_PCI_HOST);
     ARTICIA_PCI_HOST(pdev)->as = s;
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 379095b3566..1831646f9e7 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -454,7 +454,8 @@ static void elroy_pcihost_init(Object *obj)
     phb->bus = pci_register_root_bus(DEVICE(s), "pci",
                                      elroy_set_irq, elroy_pci_map_irq, s,
                                      &s->pci_mmio, &s->pci_io,
-                                     PCI_DEVFN(0, 0), ELROY_IRQS, TYPE_PCI_BUS);
+                                     PCI_DEVFN(0, 0), ELROY_IRQS, TYPE_PCI_BUS,
+                                     true);
 
     sysbus_init_mmio(sbd, &s->this_mem);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1516d0074dd..b2c931bacdb 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -635,7 +635,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
     phb->bus = pci_register_root_bus(dev, "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
-                                     PCI_DEVFN(5, 0), 32, TYPE_PCI_BUS);
+                                     PCI_DEVFN(5, 0), 32, TYPE_PCI_BUS, true);
 
     for (size_t i = 0; i < 3; i++) {
         char *name = g_strdup_printf("pci.lomem%zu", i);
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c3fc37b9047..eb6d995d3ed 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -700,7 +700,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                                      &s->pci.memory,
                                      &s->pci.io,
                                      0, 4,
-                                     TYPE_PCIE_BUS);
+                                     TYPE_PCIE_BUS, true);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 
     memory_region_init(&s->pci.address_space_root,
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 283fc0dc575..8c01372e18c 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -473,7 +473,7 @@ static void dino_pcihost_init(Object *obj)
     phb->bus = pci_register_root_bus(DEVICE(s), "pci",
                                      dino_set_irq, dino_pci_map_irq, s,
                                      &s->pci_mem, get_system_io(),
-                                     PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
+                                     PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS, true);
 
     /* Set up windows into PCI bus memory.  */
     for (i = 1; i < 31; i++) {
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf52..299f4d4f840 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -135,7 +135,8 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
 
     pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
                                      pci_swizzle_map_irq_fn, s, &s->io_mmio,
-                                     &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
+                                     &s->io_ioport, 0, 4, TYPE_PCIE_BUS,
+                                     true);
 
     pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
     qdev_realize(DEVICE(&s->gpex_root), BUS(pci->bus), &error_fatal);
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 8e589ff2c9e..2934da19bee 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -58,7 +58,7 @@ static void grackle_realize(DeviceState *dev, Error **errp)
                                      s,
                                      &s->pci_mmio,
                                      &s->pci_io,
-                                     0, 4, TYPE_PCI_BUS);
+                                     0, 4, TYPE_PCI_BUS, true);
 
     pci_create_simple(phb->bus, 0, "grackle");
 }
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 1036d8600d7..d61e3ecc0a7 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -92,7 +92,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
     name = g_strdup_printf("pci.%d", s->index);
     h->bus = pci_register_root_bus(dev, name, mv64361_pcihost_set_irq,
                                    pci_swizzle_map_irq_fn, dev,
-                                   &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
+                                   &s->mem, &s->io, 0, 4, TYPE_PCI_BUS, true);
     g_free(name);
     pci_create_simple(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
 }
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 2a74dbe45f5..633c92c6a56 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1009,7 +1009,7 @@ void pnv_phb3_bus_init(DeviceState *dev, PnvPHB3 *phb)
                                      dev->id ? dev->id : NULL,
                                      pnv_phb3_set_irq, pnv_phb3_map_irq, phb,
                                      &phb->pci_mmio, &phb->pci_io,
-                                     0, 4, TYPE_PNV_PHB3_ROOT_BUS);
+                                     0, 4, TYPE_PNV_PHB3_ROOT_BUS, true);
 
     object_property_set_int(OBJECT(pci->bus), "phb-id", phb->phb_id,
                             &error_abort);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 99991008c13..a9b46af564f 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1563,7 +1563,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
     pci->bus = pci_register_root_bus(dev, dev->id ? dev->id : NULL,
                                      pnv_phb4_set_irq, pnv_phb4_map_irq, phb,
                                      &phb->pci_mmio, &phb->pci_io,
-                                     0, 4, TYPE_PNV_PHB4_ROOT_BUS);
+                                     0, 4, TYPE_PNV_PHB4_ROOT_BUS, true);
 
     object_property_set_int(OBJECT(pci->bus), "phb-id", phb->phb_id,
                             &error_abort);
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 07924bce28a..b0e2aa96872 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -498,7 +498,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
-                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
+                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS, true);
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index b6c6c8993c4..9c17e3c655e 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -329,7 +329,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
     b = pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
                               ppc4xx_pci_map_irq, s->irq, get_system_memory(),
                               get_system_io(), 0, ARRAY_SIZE(s->irq),
-                              TYPE_PCI_BUS);
+                              TYPE_PCI_BUS, true);
     h->bus = b;
 
     pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index b70631045a0..fb659d4c707 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -465,7 +465,8 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
 
     b = pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
                               mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
-                              PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
+                              PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS,
+                              true);
     h->bus = b;
 
     /* Set up PCI view of memory */
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 1707feb9513..06f6a15bf2d 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -381,7 +381,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                                      pci_sabre_set_irq, pci_sabre_map_irq, s,
                                      &s->pci_mmio,
                                      &s->pci_ioport,
-                                     0, 0x40, TYPE_PCI_BUS);
+                                     0, 0x40, TYPE_PCI_BUS, true);
 
     pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 4edebced5eb..8da59ad573d 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -132,7 +132,7 @@ static void sh_pcic_host_realize(DeviceState *dev, Error **errp)
                                      get_system_memory(),
                                      get_system_io(),
                                      PCI_DEVFN(0, 0), PCI_NUM_PINS,
-                                     TYPE_PCI_BUS);
+                                     TYPE_PCI_BUS, true);
     memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, s,
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index e4c1abd8715..f2d410fa4aa 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -124,7 +124,7 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
                                    s,
                                    &s->pci_mmio,
                                    &s->pci_io,
-                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS, true);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
 
@@ -174,7 +174,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
                                    s,
                                    &s->pci_mmio,
                                    &s->pci_io,
-                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS, false);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
 }
@@ -218,7 +218,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
                                    s,
                                    &s->pci_mmio,
                                    &s->pci_io,
-                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS, false);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
 }
@@ -251,7 +251,7 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
                                    s,
                                    &s->pci_mmio,
                                    &s->pci_io,
-                                   PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
+                                   PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS, false);
 
     pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
 }
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 24f691ea829..634d24c479b 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -135,7 +135,7 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
 
     pci->bus = pci_register_root_bus(dev, s->name, xilinx_pcie_set_irq,
                                      pci_swizzle_map_irq_fn, s, &s->mmio,
-                                     &s->io, 0, 4, TYPE_PCIE_BUS);
+                                     &s->io, 0, 4, TYPE_PCIE_BUS, true);
 
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5fea39e4dfa..889821f64c0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -619,11 +619,12 @@ PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               void *irq_opaque,
                               MemoryRegion *mem, MemoryRegion *io,
                               uint8_t devfn_min, int nirq,
-                              const char *typename)
+                              const char *typename, bool bar_at_addr_0_refused)
 {
     PCIBus *bus;
 
-    bus = pci_root_bus_new(parent, name, mem, io, devfn_min, typename, true);
+    bus = pci_root_bus_new(parent, name, mem, io, devfn_min, typename,
+                           bar_at_addr_0_refused);
     pci_bus_irqs(bus, set_irq, irq_opaque, nirq);
     pci_bus_map_irqs(bus, map_irq);
     return bus;
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 1312aa2080e..c93a7744dc1 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1016,7 +1016,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     snprintf(buf, sizeof(buf), "pcie.%d", s->num);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->busmem,
-                                &s->iomem, 0, 4, TYPE_PCIE_BUS);
+                                &s->iomem, 0, 4, TYPE_PCIE_BUS, true);
     ppc460ex_pcie_register_dcrs(s);
 }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7e24084673f..e6e8018c1cd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1886,7 +1886,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                 pci_spapr_set_irq, pci_swizzle_map_irq_fn, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
-                                TYPE_PCI_BUS);
+                                TYPE_PCI_BUS, true);
 
     /*
      * Despite resembling a vanilla PCI bus in most ways, the PAPR
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa70..1ca9df42c5a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -834,7 +834,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 
     b = pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_map_irq,
                               NULL, get_system_memory(), get_system_io(), 0,
-                              64, TYPE_PCI_BUS);
+                              64, TYPE_PCI_BUS, true);
     pci_setup_iommu(b, &s390_iommu_ops, s);
 
     bus = BUS(b);
-- 
2.45.2


