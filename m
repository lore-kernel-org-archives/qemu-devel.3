Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30724CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTtG-0004lQ-LK; Mon, 24 Nov 2025 05:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsZ-0004Pm-Ek
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:33:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsT-0003gP-8d
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:33:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477a219db05so24492555e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763980380; x=1764585180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DroxQ5/HVnqSQxGA/kku4GCjdJ80+XK78I7r2rnM5fU=;
 b=deuykgzds+5SeCjgBTj3mEnuDycc0JUtAxFmmoCibATtPiZ56zDftL6wmUOr6QMIoX
 QiEmcTrCyu8epfNS7WOyAQNPGNhqcnzAijTrr6WM5KCmt1qdwogHN98mQ6+djOpWToZ6
 CRNp2mFkAY6S8uelqeSxprARFDp0GSrfLd1bHPEfcMKYVfirC5kUfXB+XjPfXFMnGXhM
 Ogm4PLpK+O+l0QfBbuVSJZArIeLEiw5Pv58k7KzpYHgiDKjwXGVk5N9YQXfHhefIAU3D
 ZwxSVs826djMcIvQBb0DXlkJK+vqDSb1282gHbZ9OVsD5C3A6pqmJBFwCUghc9i1r9dr
 XdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763980380; x=1764585180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DroxQ5/HVnqSQxGA/kku4GCjdJ80+XK78I7r2rnM5fU=;
 b=hjj67sG16oM+vBXkefTXJdMV4s9JQerSy3yzXB1oASvFdH78LgwthFiMT2klUvhuhV
 AcKH8D69RvhKsq9EtTInh0uw4XAkvGggG8JdPcl/4iKu2i3aW8rIOidzxqvfVDRmVXLN
 AYPaGaGaJE3IdsN7/x+x8Hn6J8n6JZ3t0YppqARviZuCO89j7WP5mqofpbLnysbpMvZa
 T9NUngB5yfQR9cdFxgIIee54XlWSE5RjGXp5dXmZ3zcpqkxhKNB2czEeeRJ8r6awZ6cs
 GUkE47+/wVGI9Vk99UVMcep2MYjYsn+PyZIbfPZ2SDSJ4+LaybEkYHWy8ha9dkj0v9Tg
 8c+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUgegaAOgtolRKqJY04UL810BGvnDzw9LFrxB1HO+ifZU43GL5KYNWYhPqF5jApA/Fgs6wvteaZQVY@nongnu.org
X-Gm-Message-State: AOJu0Yz66X5RqytL8JAj+WI3HpXcMVaPam8PhEuF16xAWspr+20al2Fp
 rwudCRvli4Cs/uIc2WHZyuqhtGJ2lw2PbpiIlmtj9Cx+N4yrVjcBTwsQz+u/rJo+CgA=
X-Gm-Gg: ASbGncvf8p2K6xNulXpGm6LmCNFVb6eALAu0pPcaqqOAhEOn92BpjjMdY4wdiG10Cr5
 4lKghCEOCIZMeu4sGggwkV/JBfmG3Mw/OQJg+ysSiQbUo0Mwkh09KoBCOupprAa/ouloCjJNNup
 kC45e9OgK4919RFYJ/PzYjLUPNyW9VlPTrTFviS1vhMnPXyFtrvS8O4L97lrzb7RLY2deckTPJu
 fJkEkBQ6zDKJmDMefj/7qJ4Io7xuiwaNYsybCWG6XY5Kp6JVBS4KTCVP5AJHXwczCaToNbep8t4
 f5/XTlYZodyrJahS879szjD37YNoNKMIDb54Vb7dB6AB6iZCVhefgFNN9UtMQQqh5QcWbh3moMl
 FngrWn4ER7qXxTMIwUM4x6p0Us+GgnrKsXA8BtPBhpcS1dk9jE333/E5LJBt8+Qmz2UE6usz8u9
 nHkVg47LEk/wyHS4zKBgZ1tCDWSz3VZ1AbWdMZpQurvnf6zS83wSEsi962PYot
X-Google-Smtp-Source: AGHT+IEO99S8d9OGiAKUi/mVW1W55jy6M+Bl7T4PueIZ28g2eo6TUJVNFrDeAlPx1AyCifAk/OOmNw==
X-Received: by 2002:a05:600c:45cc:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-477c10dc259mr98884085e9.13.1763980379239; 
 Mon, 24 Nov 2025 02:32:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3558d5sm187736175e9.1.2025.11.24.02.32.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 02:32:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-11.0 2/2] hw/pci: Rename PCIDeviceClass::exit() ->
 PCIDeviceClass::unrealize()
Date: Mon, 24 Nov 2025 11:32:44 +0100
Message-ID: <20251124103244.78932-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124103244.78932-1-philmd@linaro.org>
References: <20251124103244.78932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Commit 7ee6c1e182c ("pci: Permit incremental conversion of
device models to realize") renamed:

  PCIDeviceClass::init() -> PCIDeviceClass::realize()

Finish the conversion by renaming the counter part

  PCIDeviceClass::exit() PCIDeviceClass::unrealize()

This clarifies the handler is called during the DeviceUnrealize
path, not during Object destruction in instance_finalize().

Manual change adapting style when needed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h                |  1 -
 include/hw/pci/pci_device.h         |  3 ++-
 hw/audio/ac97.c                     |  8 ++++----
 hw/audio/es1370.c                   |  8 ++++----
 hw/audio/intel-hda.c                |  8 ++++----
 hw/audio/via-ac97.c                 |  4 ++--
 hw/char/diva-gsp.c                  |  6 +++---
 hw/char/serial-pci-multi.c          |  8 ++++----
 hw/char/serial-pci.c                |  4 ++--
 hw/cxl/switch-mailbox-cci.c         |  4 ++--
 hw/display/ati.c                    |  8 ++++----
 hw/display/bochs-display.c          |  4 ++--
 hw/display/vga-pci.c                |  4 ++--
 hw/ide/cmd646.c                     |  4 ++--
 hw/ide/ich.c                        |  4 ++--
 hw/ide/piix.c                       |  6 +++---
 hw/ide/via.c                        |  4 ++--
 hw/mem/cxl_type3.c                  |  4 ++--
 hw/misc/edu.c                       |  4 ++--
 hw/misc/ivshmem-pci.c               |  4 ++--
 hw/misc/pci-testdev.c               |  5 ++---
 hw/net/can/can_kvaser_pci.c         |  4 ++--
 hw/net/can/can_mioe3680_pci.c       |  4 ++--
 hw/net/can/can_pcm3680_pci.c        |  4 ++--
 hw/net/can/ctucan_pci.c             |  4 ++--
 hw/net/e1000.c                      |  5 ++---
 hw/net/e1000e.c                     |  4 ++--
 hw/net/eepro100.c                   |  8 ++++----
 hw/net/igb.c                        |  4 ++--
 hw/net/igbvf.c                      |  4 ++--
 hw/net/ne2000-pci.c                 |  4 ++--
 hw/net/pcnet-pci.c                  |  4 ++--
 hw/net/rocker/rocker.c              |  4 ++--
 hw/net/rtl8139.c                    |  4 ++--
 hw/net/sungem.c                     |  4 ++--
 hw/net/tulip.c                      |  4 ++--
 hw/net/vmxnet3.c                    |  4 ++--
 hw/nvme/ctrl.c                      |  4 ++--
 hw/pci-bridge/cxl_downstream.c      |  4 ++--
 hw/pci-bridge/cxl_root_port.c       |  2 +-
 hw/pci-bridge/cxl_upstream.c        |  4 ++--
 hw/pci-bridge/gen_pcie_root_port.c  |  2 +-
 hw/pci-bridge/pci_bridge_dev.c      |  4 ++--
 hw/pci-bridge/pci_expander_bridge.c |  8 ++++----
 hw/pci-bridge/pcie_pci_bridge.c     |  4 ++--
 hw/pci-bridge/pcie_root_port.c      |  4 ++--
 hw/pci-bridge/simba.c               |  2 +-
 hw/pci-bridge/xio3130_downstream.c  |  4 ++--
 hw/pci-bridge/xio3130_upstream.c    |  4 ++--
 hw/pci-host/designware.c            |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/pci/pci.c                        |  4 ++--
 hw/remote/proxy.c                   |  4 ++--
 hw/riscv/riscv-iommu-pci.c          |  4 ++--
 hw/scsi/esp-pci.c                   |  4 ++--
 hw/scsi/lsi53c895a.c                |  4 ++--
 hw/scsi/megasas.c                   |  4 ++--
 hw/scsi/mptsas.c                    |  4 ++--
 hw/scsi/vmw_pvscsi.c                | 10 ++++------
 hw/sd/sdhci-pci.c                   |  4 ++--
 hw/ufs/ufs.c                        |  4 ++--
 hw/usb/hcd-ehci-pci.c               |  4 ++--
 hw/usb/hcd-ohci-pci.c               |  8 ++++----
 hw/usb/hcd-uhci.c                   |  4 ++--
 hw/usb/hcd-xhci-pci.c               |  4 ++--
 hw/vfio/pci.c                       |  4 ++--
 hw/virtio/virtio-pci.c              |  4 ++--
 hw/watchdog/wdt_i6300esb.c          |  4 ++--
 hw/xen/xen_pt.c                     |  4 ++--
 69 files changed, 151 insertions(+), 155 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6bccb25ac2f..2c93d54aebc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -149,7 +149,6 @@ typedef uint32_t PCIConfigReadFunc(PCIDevice *pci_dev,
                                    uint32_t address, int len);
 typedef void PCIMapIORegionFunc(PCIDevice *pci_dev, int region_num,
                                 pcibus_t addr, pcibus_t size, int type);
-typedef void PCIUnregisterFunc(PCIDevice *pci_dev);
 
 typedef void MSITriggerFunc(PCIDevice *dev, MSIMessage msg);
 typedef MSIMessage MSIPrepareMessageFunc(PCIDevice *dev, unsigned vector);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea50113..0a5f623f7a0 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -27,7 +27,8 @@ struct PCIDeviceClass {
     DeviceClass parent_class;
 
     void (*realize)(PCIDevice *dev, Error **errp);
-    PCIUnregisterFunc *exit;
+    void (*unrealize)(PCIDevice *dev);
+
     PCIConfigReadFunc *config_read;
     PCIConfigWriteFunc *config_write;
 
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 60daa62ea33..cbffef8da94 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1270,7 +1270,7 @@ static void ac97_on_reset(DeviceState *dev)
     mixer_reset(s);
 }
 
-static void ac97_realize(PCIDevice *dev, Error **errp)
+static void ac97_pci_realize(PCIDevice *dev, Error **errp)
 {
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
@@ -1297,7 +1297,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     ac97_on_reset(DEVICE(s));
 }
 
-static void ac97_exit(PCIDevice *dev)
+static void ac97_pci_unrealize(PCIDevice *dev)
 {
     AC97LinkState *s = AC97(dev);
 
@@ -1315,8 +1315,8 @@ static void ac97_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = ac97_realize;
-    k->exit = ac97_exit;
+    k->realize = ac97_pci_realize;
+    k->unrealize = ac97_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801AA_5;
     k->revision = 0x01;
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9873ffadabb..56b8583174d 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -828,7 +828,7 @@ static void es1370_on_reset(DeviceState *dev)
     es1370_reset (s);
 }
 
-static void es1370_realize(PCIDevice *dev, Error **errp)
+static void es1370_pci_realize(PCIDevice *dev, Error **errp)
 {
     ES1370State *s = ES1370(dev);
     uint8_t *c = s->dev.config;
@@ -855,7 +855,7 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     es1370_reset (s);
 }
 
-static void es1370_exit(PCIDevice *dev)
+static void es1370_pci_unrealize(PCIDevice *dev)
 {
     ES1370State *s = ES1370(dev);
     int i;
@@ -876,8 +876,8 @@ static void es1370_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS (klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
 
-    k->realize = es1370_realize;
-    k->exit = es1370_exit;
+    k->realize = es1370_pci_realize;
+    k->unrealize = es1370_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_ENSONIQ;
     k->device_id = PCI_DEVICE_ID_ENSONIQ_ES1370;
     k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 758e130c938..f672b9a9779 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1086,7 +1086,7 @@ static void intel_hda_reset(DeviceState *dev)
     intel_hda_update_irq(d);
 }
 
-static void intel_hda_realize(PCIDevice *pci, Error **errp)
+static void intel_hda_pci_realize(PCIDevice *pci, Error **errp)
 {
     IntelHDAState *d = INTEL_HDA(pci);
     uint8_t *conf = d->pci.config;
@@ -1132,7 +1132,7 @@ static void intel_hda_realize(PCIDevice *pci, Error **errp)
                        intel_hda_response, intel_hda_xfer);
 }
 
-static void intel_hda_exit(PCIDevice *pci)
+static void intel_hda_pci_unrealize(PCIDevice *pci)
 {
     IntelHDAState *d = INTEL_HDA(pci);
 
@@ -1225,8 +1225,8 @@ static void intel_hda_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = intel_hda_realize;
-    k->exit = intel_hda_exit;
+    k->realize = intel_hda_pci_realize;
+    k->unrealize = intel_hda_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->class_id = PCI_CLASS_MULTIMEDIA_HD_AUDIO;
     device_class_set_legacy_reset(dc, intel_hda_reset);
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 019d2968534..54f6e34a114 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -451,7 +451,7 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 2, PCI_BASE_ADDRESS_SPACE_IO, &s->midi);
 }
 
-static void via_ac97_exit(PCIDevice *dev)
+static void via_ac97_unrealize(PCIDevice *dev)
 {
     ViaAC97State *s = VIA_AC97(dev);
 
@@ -468,7 +468,7 @@ static void via_ac97_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = via_ac97_realize;
-    k->exit = via_ac97_exit;
+    k->unrealize = via_ac97_unrealize;
     k->vendor_id = PCI_VENDOR_ID_VIA;
     k->device_id = PCI_DEVICE_ID_VIA_AC97;
     k->revision = 0x50;
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index e1f0713cb79..841398ab91f 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -186,7 +186,7 @@ static void diva_serial_class_initfn(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
     pc->realize = diva_pci_realize;
-    pc->exit = diva_pci_exit;
+    pc->unrealize = diva_pci_exit;
     pc->vendor_id = PCI_VENDOR_ID_HP;
     pc->device_id = PCI_DEVICE_ID_HP_DIVA;
     pc->subsystem_vendor_id = PCI_VENDOR_ID_HP;
@@ -234,7 +234,7 @@ static void diva_aux_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->mem);
 }
 
-static void diva_aux_exit(PCIDevice *dev)
+static void diva_aux_unrealize(PCIDevice *dev)
 {
     DivaAuxState *pci = DO_UPCAST(DivaAuxState, dev, dev);
     qemu_free_irq(pci->irq);
@@ -245,7 +245,7 @@ static void diva_aux_class_initfn(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
     pc->realize = diva_aux_realize;
-    pc->exit = diva_aux_exit;
+    pc->unrealize = diva_aux_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_HP;
     pc->device_id = PCI_DEVICE_ID_HP_DIVA_AUX;
     pc->subsystem_vendor_id = PCI_VENDOR_ID_HP;
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 34f30fb70b8..4566f612cdc 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -48,7 +48,7 @@ typedef struct PCIMultiSerialState {
     IRQState     irqs[PCI_SERIAL_MAX_PORTS];
 } PCIMultiSerialState;
 
-static void multi_serial_pci_exit(PCIDevice *dev)
+static void multi_serial_pci_unrealize(PCIDevice *dev)
 {
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
@@ -104,7 +104,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
         if (!qdev_realize(DEVICE(s), NULL, errp)) {
-            multi_serial_pci_exit(dev);
+            multi_serial_pci_unrealize(dev);
             return;
         }
         s->irq = &pci->irqs[i];
@@ -147,7 +147,7 @@ static void multi_2x_serial_pci_class_initfn(ObjectClass *klass,
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
     pc->realize = multi_serial_pci_realize;
-    pc->exit = multi_serial_pci_exit;
+    pc->unrealize = multi_serial_pci_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
     pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL2;
     pc->revision = 1;
@@ -163,7 +163,7 @@ static void multi_4x_serial_pci_class_initfn(ObjectClass *klass,
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
     pc->realize = multi_serial_pci_realize;
-    pc->exit = multi_serial_pci_exit;
+    pc->unrealize = multi_serial_pci_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
     pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL4;
     pc->revision = 1;
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 46efabc4cbe..b3ac7a812b5 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -60,7 +60,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
 }
 
-static void serial_pci_exit(PCIDevice *dev)
+static void serial_pci_unrealize(PCIDevice *dev)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
@@ -85,7 +85,7 @@ static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
     pc->realize = serial_pci_realize;
-    pc->exit = serial_pci_exit;
+    pc->unrealize = serial_pci_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
     pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL;
     pc->revision = 1;
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 223f2204331..dc55c728423 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -62,7 +62,7 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
                                  CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
-static void cswmbcci_exit(PCIDevice *pci_dev)
+static void cswbcci_unrealize(PCIDevice *pci_dev)
 {
     /* Nothing to do here yet */
 }
@@ -78,7 +78,7 @@ static void cswmbcci_class_init(ObjectClass *oc, const void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = cswbcci_realize;
-    pc->exit = cswmbcci_exit;
+    pc->unrealize = cswbcci_unrealize;
     /* Serial bus, CXL Switch CCI */
     pc->class_id = 0x0c0b;
     /*
diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a879..6b9f06b6b36 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -948,7 +948,7 @@ static const MemoryRegionOps ati_mm_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void ati_vga_realize(PCIDevice *dev, Error **errp)
+static void ati_vga_pci_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
@@ -1032,7 +1032,7 @@ static void ati_vga_reset(DeviceState *dev)
     s->mode = VGA_MODE;
 }
 
-static void ati_vga_exit(PCIDevice *dev)
+static void ati_vga_pci_unrealize(PCIDevice *dev)
 {
     ATIVGAState *s = ATI_VGA(dev);
 
@@ -1064,8 +1064,8 @@ static void ati_vga_class_init(ObjectClass *klass, const void *data)
     k->vendor_id = PCI_VENDOR_ID_ATI;
     k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
     k->romfile = "vgabios-ati.bin";
-    k->realize = ati_vga_realize;
-    k->exit = ati_vga_exit;
+    k->realize = ati_vga_pci_realize;
+    k->unrealize = ati_vga_pci_unrealize;
 }
 
 static void ati_vga_init(Object *o)
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c9745..9c4687993f9 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -338,7 +338,7 @@ static void bochs_display_init(Object *obj)
     dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static void bochs_display_exit(PCIDevice *dev)
+static void bochs_display_unrealize(PCIDevice *dev)
 {
     BochsDisplayState *s = BOCHS_DISPLAY(dev);
 
@@ -361,8 +361,8 @@ static void bochs_display_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_QEMU_VGA;
 
     k->realize   = bochs_display_realize;
+    k->unrealize = bochs_display_unrealize;
     k->romfile   = "vgabios-bochs-display.bin";
-    k->exit      = bochs_display_exit;
     dc->vmsd     = &vmstate_bochs_display;
     device_class_set_props(dc, bochs_display_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b81f7fd2d0f..98f57a18799 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -301,7 +301,7 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
 }
 
-static void pci_secondary_vga_exit(PCIDevice *dev)
+static void pci_secondary_vga_unrealize(PCIDevice *dev)
 {
     PCIVGAState *d = PCI_VGA(dev);
     VGACommonState *s = &d->vga;
@@ -398,7 +398,7 @@ static void secondary_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_secondary_vga_realize;
-    k->exit = pci_secondary_vga_exit;
+    k->unrealize = pci_secondary_vga_unrealize;
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
     device_class_set_props(dc, secondary_pci_properties);
     device_class_set_legacy_reset(dc, pci_secondary_vga_reset);
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 2a59516a9dd..0abeb7c0bb4 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -302,7 +302,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void pci_cmd646_ide_exitfn(PCIDevice *dev)
+static void pci_cmd646_ide_unrealize(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
     unsigned i;
@@ -325,7 +325,7 @@ static void cmd646_ide_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, cmd646_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_cmd646_ide_realize;
-    k->exit = pci_cmd646_ide_exitfn;
+    k->unrealize = pci_cmd646_ide_unrealize;
     k->vendor_id = PCI_VENDOR_ID_CMD;
     k->device_id = PCI_DEVICE_ID_CMD_646;
     k->revision = 0x07;
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d4..9648791d487 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -167,7 +167,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     assert(!ret || ret == -ENOTSUP);
 }
 
-static void pci_ich9_uninit(PCIDevice *dev)
+static void pci_ich9_ahci_unrealize(PCIDevice *dev)
 {
     AHCIPCIState *d;
     d = ICH9_AHCI(dev);
@@ -182,7 +182,7 @@ static void ich_ahci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_ich9_ahci_realize;
-    k->exit = pci_ich9_uninit;
+    k->unrealize = pci_ich9_ahci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801IR;
     k->revision = 0x02;
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a0f2709c697..d73e03ec4a9 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -166,7 +166,7 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void pci_piix_ide_exitfn(PCIDevice *dev)
+static void pci_piix_ide_unrealize(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
     unsigned i;
@@ -186,7 +186,7 @@ static void piix3_ide_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, piix_ide_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
-    k->exit = pci_piix_ide_exitfn;
+    k->unrealize = pci_piix_ide_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_1;
     k->class_id = PCI_CLASS_STORAGE_IDE;
@@ -209,7 +209,7 @@ static void piix4_ide_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, piix_ide_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
-    k->exit = pci_piix_ide_exitfn;
+    k->unrealize = pci_piix_ide_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82371AB;
     k->class_id = PCI_CLASS_STORAGE_IDE;
diff --git a/hw/ide/via.c b/hw/ide/via.c
index dedc2674c00..506b1b72186 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -234,7 +234,7 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void via_ide_exitfn(PCIDevice *dev)
+static void via_ide_unrealize(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
     unsigned i;
@@ -258,7 +258,7 @@ static void via_ide_class_init(ObjectClass *klass, const void *data)
     k->config_read = via_ide_cfg_read;
     k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
-    k->exit = via_ide_exitfn;
+    k->unrealize = via_ide_unrealize;
     k->vendor_id = PCI_VENDOR_ID_VIA;
     k->device_id = PCI_DEVICE_ID_VIA_IDE;
     k->revision = 0x06;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4f3688a71b6..95e52fa36a9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -984,7 +984,7 @@ err_free_special_ops:
     }
 }
 
-static void ct3_exit(PCIDevice *pci_dev)
+static void ct3_unrealize(PCIDevice *pci_dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -2133,7 +2133,7 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
     CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
 
     pc->realize = ct3_realize;
-    pc->exit = ct3_exit;
+    pc->unrealize = ct3_unrealize;
     pc->class_id = PCI_CLASS_MEMORY_CXL;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0xd93; /* LVF for now */
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cece633e113..54101666870 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -389,7 +389,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
 }
 
-static void pci_edu_uninit(PCIDevice *pdev)
+static void pci_edu_unrealize(PCIDevice *pdev)
 {
     EduState *edu = EDU(pdev);
 
@@ -421,7 +421,7 @@ static void edu_class_init(ObjectClass *class, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
 
     k->realize = pci_edu_realize;
-    k->exit = pci_edu_uninit;
+    k->unrealize = pci_edu_unrealize;
     k->vendor_id = PCI_VENDOR_ID_QEMU;
     k->device_id = 0x11e8;
     k->revision = 0x10;
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 636d0b83dee..01385200b01 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -927,7 +927,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
                      s->ivshmem_bar2);
 }
 
-static void ivshmem_exit(PCIDevice *dev)
+static void ivshmem_common_unrealize(PCIDevice *dev)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
     int i;
@@ -997,7 +997,7 @@ static void ivshmem_common_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = ivshmem_common_realize;
-    k->exit = ivshmem_exit;
+    k->unrealize = ivshmem_common_unrealize;
     k->config_write = ivshmem_write_config;
     k->vendor_id = PCI_VENDOR_ID_IVSHMEM;
     k->device_id = PCI_DEVICE_ID_IVSHMEM;
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index ba71c5069ff..fd6c08028f7 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -304,8 +304,7 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void
-pci_testdev_uninit(PCIDevice *dev)
+static void pci_testdev_unrealize(PCIDevice *dev)
 {
     PCITestDevState *d = PCI_TEST_DEV(dev);
     int i;
@@ -337,7 +336,7 @@ static void pci_testdev_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_testdev_realize;
-    k->exit = pci_testdev_uninit;
+    k->unrealize = pci_testdev_unrealize;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_TEST;
     k->revision = 0x00;
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index be16769de29..49252368873 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -248,7 +248,7 @@ static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
                                             &d->xilinx_io);
 }
 
-static void kvaser_pci_exit(PCIDevice *pci_dev)
+static void kvaser_pci_unrealize(PCIDevice *pci_dev)
 {
     KvaserPCIState *d = KVASER_PCI_DEV(pci_dev);
     CanSJA1000State *s = &d->sja_state;
@@ -288,7 +288,7 @@ static void kvaser_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = kvaser_pci_realize;
-    k->exit = kvaser_pci_exit;
+    k->unrealize = kvaser_pci_unrealize;
     k->vendor_id = KVASER_PCI_VENDOR_ID1;
     k->device_id = KVASER_PCI_DEVICE_ID1;
     k->revision = 0x00;
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 44f3ba370dc..e8cabd9c116 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -183,7 +183,7 @@ static void mioe3680_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void mioe3680_pci_exit(PCIDevice *pci_dev)
+static void mioe3680_pci_unrealize(PCIDevice *pci_dev)
 {
     Mioe3680PCIState *d = MIOe3680_PCI_DEV(pci_dev);
     int i;
@@ -229,7 +229,7 @@ static void mioe3680_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = mioe3680_pci_realize;
-    k->exit = mioe3680_pci_exit;
+    k->unrealize = mioe3680_pci_unrealize;
     k->vendor_id = MIOe3680_PCI_VENDOR_ID1;
     k->device_id = MIOe3680_PCI_DEVICE_ID1;
     k->revision = 0x00;
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 7296d63be79..b0719f46c36 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -184,7 +184,7 @@ static void pcm3680i_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void pcm3680i_pci_exit(PCIDevice *pci_dev)
+static void pcm3680i_pci_unrealize(PCIDevice *pci_dev)
 {
     Pcm3680iPCIState *d = PCM3680i_PCI_DEV(pci_dev);
     int i;
@@ -230,7 +230,7 @@ static void pcm3680i_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pcm3680i_pci_realize;
-    k->exit = pcm3680i_pci_exit;
+    k->unrealize = pcm3680i_pci_unrealize;
     k->vendor_id = PCM3680i_PCI_VENDOR_ID1;
     k->device_id = PCM3680i_PCI_DEVICE_ID1;
     k->revision = 0x00;
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index bed6785433e..dfb00bf7eb1 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -195,7 +195,7 @@ static void ctucan_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void ctucan_pci_exit(PCIDevice *pci_dev)
+static void ctucan_pci_unrealize(PCIDevice *pci_dev)
 {
     CtuCanPCIState *d = CTUCAN_PCI_DEV(pci_dev);
     int i;
@@ -243,7 +243,7 @@ static void ctucan_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = ctucan_pci_realize;
-    k->exit = ctucan_pci_exit;
+    k->unrealize = ctucan_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_TEDIA;
     k->device_id = PCI_DEVICE_ID_TEDIA_CTUCAN_VER21;
     k->revision = 0x00;
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a80a7b0cdb4..e3d8133fca3 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1590,8 +1590,7 @@ e1000_mmio_setup(E1000State *d)
     memory_region_init_io(&d->io, OBJECT(d), &e1000_io_ops, d, "e1000-io", IOPORT_SIZE);
 }
 
-static void
-pci_e1000_uninit(PCIDevice *dev)
+static void pci_e1000_unrealize(PCIDevice *dev)
 {
     E1000State *d = E1000(dev);
 
@@ -1690,7 +1689,7 @@ static void e1000_class_init(ObjectClass *klass, const void *data)
     const E1000Info *info = data;
 
     k->realize = pci_e1000_realize;
-    k->exit = pci_e1000_uninit;
+    k->unrealize = pci_e1000_unrealize;
     k->romfile = "efi-e1000.rom";
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = info->device_id;
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 89e6d52ba0f..d596861922c 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -494,7 +494,7 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
                             macaddr);
 }
 
-static void e1000e_pci_uninit(PCIDevice *pci_dev)
+static void e1000e_pci_unrealize(PCIDevice *pci_dev)
 {
     E1000EState *s = E1000E(pci_dev);
 
@@ -680,7 +680,7 @@ static void e1000e_class_init(ObjectClass *class, const void *data)
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
 
     c->realize = e1000e_pci_realize;
-    c->exit = e1000e_pci_uninit;
+    c->unrealize = e1000e_pci_unrealize;
     c->vendor_id = PCI_VENDOR_ID_INTEL;
     c->device_id = E1000_DEV_ID_82574L;
     c->revision = 0;
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index d47df5a97fd..1119c918f76 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1820,7 +1820,7 @@ static const VMStateDescription vmstate_eepro100 = {
     }
 };
 
-static void pci_nic_uninit(PCIDevice *pci_dev)
+static void e100_pci_unrealize(PCIDevice *pci_dev)
 {
     EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, pci_dev);
 
@@ -1836,7 +1836,7 @@ static NetClientInfo net_eepro100_info = {
     .receive = nic_receive,
 };
 
-static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
+static void e100_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, pci_dev);
     E100PCIDeviceInfo *info = eepro100_get_class(s);
@@ -2074,8 +2074,8 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     k->romfile = "pxe-eepro100.rom";
-    k->realize = e100_nic_realize;
-    k->exit = pci_nic_uninit;
+    k->realize = e100_pci_realize;
+    k->unrealize = e100_pci_unrealize;
     k->device_id = info->device_id;
     k->revision = info->revision;
     k->subsystem_vendor_id = info->subsystem_vendor_id;
diff --git a/hw/net/igb.c b/hw/net/igb.c
index e4c02365d67..0772d9353be 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -471,7 +471,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
                          macaddr);
 }
 
-static void igb_pci_uninit(PCIDevice *pci_dev)
+static void igb_pci_unrealize(PCIDevice *pci_dev)
 {
     IGBState *s = IGB(pci_dev);
 
@@ -606,7 +606,7 @@ static void igb_class_init(ObjectClass *class, const void *data)
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
 
     c->realize = igb_pci_realize;
-    c->exit = igb_pci_uninit;
+    c->unrealize = igb_pci_unrealize;
     c->vendor_id = PCI_VENDOR_ID_INTEL;
     c->device_id = E1000_DEV_ID_82576;
     c->revision = 1;
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 9b0db8f8411..a8eb7a6e60a 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -291,7 +291,7 @@ static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
     igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
 }
 
-static void igbvf_pci_uninit(PCIDevice *dev)
+static void igbvf_pci_unrealize(PCIDevice *dev)
 {
     IgbVfState *s = IGBVF(dev);
 
@@ -308,7 +308,7 @@ static void igbvf_class_init(ObjectClass *class, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(class);
 
     c->realize = igbvf_pci_realize;
-    c->exit = igbvf_pci_uninit;
+    c->unrealize = igbvf_pci_unrealize;
     c->vendor_id = PCI_VENDOR_ID_INTEL;
     c->device_id = E1000_DEV_ID_82576_VF;
     c->revision = 1;
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index ce937e1b618..0db621e138e 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -76,7 +76,7 @@ static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
-static void pci_ne2000_exit(PCIDevice *pci_dev)
+static void pci_ne2000_unrealize(PCIDevice *pci_dev)
 {
     PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
     NE2000State *s = &d->ne2000;
@@ -106,7 +106,7 @@ static void ne2000_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_ne2000_realize;
-    k->exit = pci_ne2000_exit;
+    k->unrealize = pci_ne2000_unrealize;
     k->romfile = "efi-ne2k_pci.rom",
     k->vendor_id = PCI_VENDOR_ID_REALTEK;
     k->device_id = PCI_DEVICE_ID_REALTEK_8029;
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0ca5bc21938..5f2b323696b 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -178,7 +178,7 @@ static void pci_physical_memory_read(void *dma_opaque, hwaddr addr,
     pci_dma_read(dma_opaque, addr, buf, len);
 }
 
-static void pci_pcnet_uninit(PCIDevice *dev)
+static void pci_pcnet_unrealize(PCIDevice *dev)
 {
     PCIPCNetState *d = PCI_PCNET(dev);
 
@@ -262,7 +262,7 @@ static void pcnet_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_pcnet_realize;
-    k->exit = pci_pcnet_uninit;
+    k->unrealize = pci_pcnet_unrealize;
     k->romfile = "efi-pcnet.rom",
     k->vendor_id = PCI_VENDOR_ID_AMD;
     k->device_id = PCI_DEVICE_ID_AMD_LANCE;
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index cc49701dd3c..a032d3b780b 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1399,7 +1399,7 @@ err_world_type_by_name:
     }
 }
 
-static void pci_rocker_uninit(PCIDevice *dev)
+static void pci_rocker_unrealize(PCIDevice *dev)
 {
     Rocker *r = ROCKER(dev);
     int i;
@@ -1481,7 +1481,7 @@ static void rocker_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_rocker_realize;
-    k->exit = pci_rocker_uninit;
+    k->unrealize = pci_rocker_unrealize;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
     k->revision = ROCKER_PCI_REVISION;
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 324fb932aac..04bd4d3dcb2 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3325,7 +3325,7 @@ static void rtl8139_timer(void *opaque)
     rtl8139_set_next_tctr_time(s);
 }
 
-static void pci_rtl8139_uninit(PCIDevice *dev)
+static void pci_rtl8139_unrealize(PCIDevice *dev)
 {
     RTL8139State *s = RTL8139(dev);
 
@@ -3421,7 +3421,7 @@ static void rtl8139_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_rtl8139_realize;
-    k->exit = pci_rtl8139_uninit;
+    k->unrealize = pci_rtl8139_unrealize;
     k->romfile = "efi-rtl8139.rom";
     k->vendor_id = PCI_VENDOR_ID_REALTEK;
     k->device_id = PCI_DEVICE_ID_REALTEK_8139;
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index b405eb89fa5..233d019a44f 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1328,7 +1328,7 @@ static const MemoryRegionOps sungem_mmio_pcs_ops = {
     },
 };
 
-static void sungem_uninit(PCIDevice *dev)
+static void sungem_unrealize(PCIDevice *dev)
 {
     SunGEMState *s = SUNGEM(dev);
 
@@ -1460,7 +1460,7 @@ static void sungem_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = sungem_realize;
-    k->exit = sungem_uninit;
+    k->unrealize = sungem_unrealize;
     k->vendor_id = PCI_VENDOR_ID_APPLE;
     k->device_id = PCI_DEVICE_ID_APPLE_UNI_N_GMAC;
     k->revision = 0x01;
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 319af906c8d..cc0b470620c 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -988,7 +988,7 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
-static void pci_tulip_exit(PCIDevice *pci_dev)
+static void pci_tulip_unrealize(PCIDevice *pci_dev)
 {
     TULIPState *s = DO_UPCAST(TULIPState, dev, pci_dev);
 
@@ -1017,7 +1017,7 @@ static void tulip_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_tulip_realize;
-    k->exit = pci_tulip_exit;
+    k->unrealize = pci_tulip_unrealize;
     k->vendor_id = PCI_VENDOR_ID_DEC;
     k->device_id = PCI_DEVICE_ID_DEC_21143;
     k->subsystem_vendor_id = PCI_VENDOR_ID_HP;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 03732375a76..eb4a13b653d 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2237,7 +2237,7 @@ static void vmxnet3_instance_init(Object *obj)
     PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
+static void vmxnet3_pci_unrealize(PCIDevice *pci_dev)
 {
     VMXNET3State *s = VMXNET3(pci_dev);
 
@@ -2466,7 +2466,7 @@ static void vmxnet3_class_init(ObjectClass *class, const void *data)
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
 
     c->realize = vmxnet3_pci_realize;
-    c->exit = vmxnet3_pci_uninit;
+    c->unrealize = vmxnet3_pci_unrealize;
     c->vendor_id = PCI_VENDOR_ID_VMWARE;
     c->device_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
     c->revision = PCI_DEVICE_ID_VMWARE_VMXNET3_REVISION;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4d150c7206a..2a6f417e92a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9311,7 +9311,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void nvme_exit(PCIDevice *pci_dev)
+static void nvme_unrealize(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
     NvmeNamespace *ns;
@@ -9509,9 +9509,9 @@ static void nvme_class_init(ObjectClass *oc, const void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = nvme_realize;
+    pc->unrealize = nvme_unrealize;
     pc->config_write = nvme_pci_write_config;
     pc->config_read = nvme_pci_read_config;
-    pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 9431fc3864c..201eee833bb 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -201,7 +201,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
     pci_bridge_unrealize(d);
 }
 
-static void cxl_dsp_exitfn(PCIDevice *d)
+static void cxl_dsp_unrealize(PCIDevice *d)
 {
     PCIESlot *s = PCIE_SLOT(d);
 
@@ -227,7 +227,7 @@ static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, cxl_dsp_props);
     k->config_write = cxl_dsp_config_write;
     k->realize = cxl_dsp_realize;
-    k->exit = cxl_dsp_exitfn;
+    k->unrealize = cxl_dsp_unrealize;
     k->vendor_id = 0x19e5; /* Huawei */
     k->device_id = 0xa129; /* Emulated CXL Switch Downstream Port */
     k->revision = 0;
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e6a4035d26c..024f9bae525 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -163,7 +163,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
     int rc =
         pci_bridge_qemu_reserve_cap_init(pci_dev, 0, crp->res_reserve, errp);
     if (rc < 0) {
-        rpc->parent_class.exit(pci_dev);
+        rpc->parent_class.unrealize(pci_dev);
         return;
     }
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index f9c26c72bae..479129f815f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -354,7 +354,7 @@ err_bridge:
     pci_bridge_unrealize(d);
 }
 
-static void cxl_usp_exitfn(PCIDevice *d)
+static void cxl_usp_unrealize(PCIDevice *d)
 {
     pcie_aer_exit(d);
     pcie_cap_exit(d);
@@ -379,7 +379,7 @@ static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
     k->config_write = cxl_usp_write_config;
     k->config_read = cxl_usp_read_config;
     k->realize = cxl_usp_realize;
-    k->exit = cxl_usp_exitfn;
+    k->unrealize = cxl_usp_unrealize;
     k->vendor_id = 0x19e5; /* Huawei */
     k->device_id = 0xa128; /* Emulated CXL Switch Upstream Port */
     k->revision = 0;
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf..8fb28bbf4a2 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -99,7 +99,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
                                               grp->res_reserve, errp);
 
     if (rc < 0) {
-        rpc->parent_class.exit(d);
+        rpc->parent_class.unrealize(d);
         return;
     }
 
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 7446b8a0474..9f87c7ffc9d 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -125,7 +125,7 @@ shpc_error:
     pci_bridge_unrealize(dev);
 }
 
-static void pci_bridge_dev_exitfn(PCIDevice *dev)
+static void pci_bridge_dev_unrealize(PCIDevice *dev)
 {
     PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
 
@@ -247,7 +247,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pci_bridge_dev_realize;
-    k->exit = pci_bridge_dev_exitfn;
+    k->unrealize = pci_bridge_dev_unrealize;
     k->config_write = pci_bridge_dev_write_config;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4d..038573e53ab 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -412,7 +412,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
     pxb_dev_realize_common(dev, PCI, errp);
 }
 
-static void pxb_dev_exitfn(PCIDevice *pci_dev)
+static void pxb_dev_unrealize_common(PCIDevice *pci_dev)
 {
     PXBDev *pxb = PXB_DEV(pci_dev);
 
@@ -432,7 +432,7 @@ static void pxb_dev_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pxb_dev_realize;
-    k->exit = pxb_dev_exitfn;
+    k->unrealize = pxb_dev_unrealize_common;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PXB;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
@@ -470,7 +470,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pxb_pcie_dev_realize;
-    k->exit = pxb_dev_exitfn;
+    k->unrealize = pxb_dev_unrealize_common;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PXB_PCIE;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
@@ -515,7 +515,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize             = pxb_cxl_dev_realize;
-    k->exit                = pxb_dev_exitfn;
+    k->unrealize           = pxb_dev_unrealize_common;
     /*
      * XXX: These types of bridges don't actually show up in the hierarchy so
      * vendor, device, class, etc. ids are intentionally left out.
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 2c6d58292dd..2e4cefcdd54 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -95,7 +95,7 @@ error:
     pci_bridge_unrealize(d);
 }
 
-static void pcie_pci_bridge_exit(PCIDevice *d)
+static void pcie_pci_bridge_unrealize(PCIDevice *d)
 {
     PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
     pcie_cap_exit(d);
@@ -146,7 +146,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, const void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
     k->realize = pcie_pci_bridge_realize;
-    k->exit = pcie_pci_bridge_exit;
+    k->unrealize = pcie_pci_bridge_unrealize;
     k->config_write = pcie_pci_bridge_write_config;
     dc->vmsd = &pcie_pci_bridge_dev_vmstate;
     device_class_set_props(dc, pcie_pci_bridge_dev_properties);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 123c5e2c6e0..43e6aa83e2b 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -134,7 +134,7 @@ err_bridge:
     pci_bridge_unrealize(d);
 }
 
-static void rp_exit(PCIDevice *d)
+static void rp_unrealize(PCIDevice *d)
 {
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     PCIESlot *s = PCIE_SLOT(d);
@@ -175,7 +175,7 @@ static void rp_class_init(ObjectClass *klass, const void *data)
 
     k->config_write = rp_write_config;
     k->realize = rp_realize;
-    k->exit = rp_exit;
+    k->unrealize = rp_unrealize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     rc->phases.hold = rp_reset_hold;
     device_class_set_props(dc, rp_props);
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index ff7768152cf..3942d7a231a 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -72,7 +72,7 @@ static void simba_pci_bridge_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = simba_pci_bridge_realize;
-    k->exit = pci_bridge_unrealize;
+    k->unrealize = pci_bridge_unrealize;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
     k->revision = 0x11;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 1f48747bffa..6ca7d67ce82 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -123,7 +123,7 @@ err_bridge:
     pci_bridge_unrealize(d);
 }
 
-static void xio3130_downstream_exitfn(PCIDevice *d)
+static void xio3130_downstream_unrealize(PCIDevice *d)
 {
     PCIESlot *s = PCIE_SLOT(d);
 
@@ -160,7 +160,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, const void *data)
 
     k->config_write = xio3130_downstream_write_config;
     k->realize = xio3130_downstream_realize;
-    k->exit = xio3130_downstream_exitfn;
+    k->unrealize = xio3130_downstream_unrealize;
     k->vendor_id = PCI_VENDOR_ID_TI;
     k->device_id = PCI_DEVICE_ID_TI_XIO3130D;
     k->revision = XIO3130_REVISION;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 1945d90800f..5e3025417b9 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -102,7 +102,7 @@ err_bridge:
     pci_bridge_unrealize(d);
 }
 
-static void xio3130_upstream_exitfn(PCIDevice *d)
+static void xio3130_upstream_unrealize(PCIDevice *d)
 {
     pcie_aer_exit(d);
     pcie_cap_exit(d);
@@ -130,7 +130,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 
     k->config_write = xio3130_upstream_write_config;
     k->realize = xio3130_upstream_realize;
-    k->exit = xio3130_upstream_exitfn;
+    k->unrealize = xio3130_upstream_unrealize;
     k->vendor_id = PCI_VENDOR_ID_TI;
     k->device_id = PCI_DEVICE_ID_TI_XIO3130U;
     k->revision = XIO3130_REVISION;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index ca38d8a76d8..eeac07f3398 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -599,8 +599,8 @@ static void designware_pcie_root_class_init(ObjectClass *klass,
     k->device_id = 0xABCD;
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
-    k->exit = pci_bridge_unrealize;
     k->realize = designware_pcie_root_realize;
+    k->unrealize = pci_bridge_unrealize;
     k->config_read = designware_pcie_root_config_read;
     k->config_write = designware_pcie_root_config_write;
 
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 06c5bbef515..04f6eaa3096 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -298,7 +298,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, const void *data)
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     k->realize = xilinx_pcie_root_realize;
-    k->exit = pci_bridge_unrealize;
+    k->unrealize = pci_bridge_unrealize;
     device_class_set_legacy_reset(dc, pci_bridge_reset);
     k->config_read = xilinx_pcie_root_config_read;
     k->config_write = xilinx_pcie_root_config_write;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b1eba348e06..62c54c81aa7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1454,8 +1454,8 @@ static void pci_qdev_unrealize(DeviceState *dev)
     pci_del_option_rom(pci_dev);
     pcie_sriov_unregister_device(pci_dev);
 
-    if (pc->exit) {
-        pc->exit(pci_dev);
+    if (pc->unrealize) {
+        pc->unrealize(pci_dev);
     }
 
     pci_device_deassert_intx(pci_dev);
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 18e0f7a064f..f0e302e8b60 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -129,7 +129,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     probe_pci_info(PCI_DEVICE(dev), errp);
 }
 
-static void pci_proxy_dev_exit(PCIDevice *pdev)
+static void pci_proxy_dev_unrealize(PCIDevice *pdev)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
 
@@ -205,7 +205,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
-    k->exit = pci_proxy_dev_exit;
+    k->unrealize = pci_proxy_dev_unrealize;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index cdb4a7a8f03..d243d91e381 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -138,7 +138,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
     riscv_iommu_pci_setup_iommu(iommu, bus, errp);
 }
 
-static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
+static void riscv_iommu_pci_unrealize(PCIDevice *pci_dev)
 {
     pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
 }
@@ -187,7 +187,7 @@ static void riscv_iommu_pci_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = riscv_iommu_pci_reset_hold;
 
     k->realize = riscv_iommu_pci_realize;
-    k->exit = riscv_iommu_pci_exit;
+    k->unrealize = riscv_iommu_pci_unrealize;
     k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
     dc->desc = "RISCV-IOMMU DMA Remapping device";
     dc->vmsd = &riscv_iommu_vmstate;
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 12c86eb7aaa..39a6b8b8984 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -412,7 +412,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info);
 }
 
-static void esp_pci_scsi_exit(PCIDevice *d)
+static void esp_pci_scsi_unrealize(PCIDevice *d)
 {
     PCIESPState *pci = PCI_ESP(d);
     ESPState *s = &pci->esp;
@@ -433,7 +433,7 @@ static void esp_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = esp_pci_scsi_realize;
-    k->exit = esp_pci_scsi_exit;
+    k->unrealize = esp_pci_scsi_unrealize;
     k->vendor_id = PCI_VENDOR_ID_AMD;
     k->device_id = PCI_DEVICE_ID_AMD_SCSI;
     k->revision = 0x10;
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 9ea4aa0a853..d4a8b23df67 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2367,7 +2367,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_info);
 }
 
-static void lsi_scsi_exit(PCIDevice *dev)
+static void lsi_scsi_unrealize(PCIDevice *dev)
 {
     LSIState *s = LSI53C895A(dev);
 
@@ -2381,7 +2381,7 @@ static void lsi_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = lsi_scsi_realize;
-    k->exit = lsi_scsi_exit;
+    k->unrealize = lsi_scsi_unrealize;
     k->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     k->device_id = PCI_DEVICE_ID_LSI_53C895A;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 844643d916f..f3a5a6c988e 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2317,7 +2317,7 @@ static const VMStateDescription vmstate_megasas_gen2 = {
     }
 };
 
-static void megasas_scsi_uninit(PCIDevice *d)
+static void megasas_scsi_unrealize(PCIDevice *d)
 {
     MegasasState *s = MEGASAS(d);
 
@@ -2532,7 +2532,7 @@ static void megasas_class_init(ObjectClass *oc, const void *data)
     const MegasasInfo *info = data;
 
     pc->realize = megasas_scsi_realize;
-    pc->exit = megasas_scsi_uninit;
+    pc->unrealize = megasas_scsi_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     pc->device_id = info->device_id;
     pc->subsystem_vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 4ada35b7ec8..6115ff80970 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1328,7 +1328,7 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_init(&s->bus, sizeof(s->bus), &dev->qdev, &mptsas_scsi_info);
 }
 
-static void mptsas_scsi_uninit(PCIDevice *dev)
+static void mptsas_scsi_unrealize(PCIDevice *dev)
 {
     MPTSASState *s = MPT_SAS(dev);
 
@@ -1422,7 +1422,7 @@ static void mptsas1068_class_init(ObjectClass *oc, const void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = mptsas_scsi_realize;
-    pc->exit = mptsas_scsi_uninit;
+    pc->unrealize = mptsas_scsi_unrealize;
     pc->romfile = 0;
     pc->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     pc->device_id = PCI_DEVICE_ID_LSI_SAS1068;
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7c98b1b8ea6..b80f59f0b81 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1137,8 +1137,7 @@ static const struct SCSIBusInfo pvscsi_scsi_info = {
         .fail = pvscsi_command_failed,
 };
 
-static void
-pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
+static void pvscsi_realize(PCIDevice *pci_dev, Error **errp)
 {
     PVSCSIState *s = PVSCSI(pci_dev);
 
@@ -1176,8 +1175,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     pvscsi_reset_state(s);
 }
 
-static void
-pvscsi_uninit(PCIDevice *pci_dev)
+static void pvscsi_unrealize(PCIDevice *pci_dev)
 {
     PVSCSIState *s = PVSCSI(pci_dev);
 
@@ -1278,8 +1276,8 @@ static void pvscsi_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    k->realize = pvscsi_realizefn;
-    k->exit = pvscsi_uninit;
+    k->realize = pvscsi_realize;
+    k->unrealize = pvscsi_unrealize;
     k->vendor_id = PCI_VENDOR_ID_VMWARE;
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index c18b91fe63c..5c6f328218f 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -45,7 +45,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->iomem);
 }
 
-static void sdhci_pci_exit(PCIDevice *dev)
+static void sdhci_pci_unrealize(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
 
@@ -60,7 +60,7 @@ static void sdhci_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = sdhci_pci_realize;
-    k->exit = sdhci_pci_exit;
+    k->unrealize = sdhci_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 0577747f469..61a711c0e56 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1805,7 +1805,7 @@ static void ufs_realize(PCIDevice *pci_dev, Error **errp)
     ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
 }
 
-static void ufs_exit(PCIDevice *pci_dev)
+static void ufs_unrealize(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
@@ -1850,7 +1850,7 @@ static void ufs_class_init(ObjectClass *oc, const void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = ufs_realize;
-    pc->exit = ufs_exit;
+    pc->unrealize = ufs_unrealize;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
     pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
     pc->class_id = PCI_CLASS_STORAGE_UFS;
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 38ad3406b32..5dde8d845b8 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -100,7 +100,7 @@ static void usb_ehci_pci_finalize(Object *obj)
     usb_ehci_finalize(s);
 }
 
-static void usb_ehci_pci_exit(PCIDevice *dev)
+static void usb_ehci_pci_unrealize(PCIDevice *dev)
 {
     EHCIPCIState *i = PCI_EHCI(dev);
     EHCIState *s = &i->ehci;
@@ -156,7 +156,7 @@ static void ehci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = usb_ehci_pci_realize;
-    k->exit = usb_ehci_pci_exit;
+    k->unrealize = usb_ehci_pci_unrealize;
     k->class_id = PCI_CLASS_SERIAL_USB;
     k->config_write = usb_ehci_pci_write_config;
     dc->vmsd = &vmstate_ehci_pci;
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 94d1077eb9e..241344b3c8a 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -59,7 +59,7 @@ static void ohci_pci_die(struct OHCIState *ohci)
                  PCI_STATUS_DETECTED_PARITY);
 }
 
-static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
+static void usb_ohci_pci_realize(PCIDevice *dev, Error **errp)
 {
     Error *err = NULL;
     OHCIPCIState *ohci = PCI_OHCI(dev);
@@ -79,7 +79,7 @@ static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, 0, &ohci->state.mem);
 }
 
-static void usb_ohci_exit(PCIDevice *dev)
+static void usb_ohci_pci_unrealize(PCIDevice *dev)
 {
     OHCIPCIState *ohci = PCI_OHCI(dev);
     OHCIState *s = &ohci->state;
@@ -131,8 +131,8 @@ static void ohci_pci_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = usb_ohci_realize_pci;
-    k->exit = usb_ohci_exit;
+    k->realize = usb_ohci_pci_realize;
+    k->unrealize = usb_ohci_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_APPLE;
     k->device_id = PCI_DEVICE_ID_APPLE_IPID_USB;
     k->class_id = PCI_CLASS_SERIAL_USB;
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index e207d0587a1..3133b1c5904 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1233,7 +1233,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&s->dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
 }
 
-static void usb_uhci_exit(PCIDevice *dev)
+static void usb_uhci_common_unrealize(PCIDevice *dev)
 {
     UHCIState *s = UHCI(dev);
 
@@ -1298,7 +1298,7 @@ void uhci_data_class_init(ObjectClass *klass, const void *data)
     const UHCIInfo *info = data;
 
     k->realize = info->realize ? info->realize : usb_uhci_common_realize;
-    k->exit = info->unplug ? usb_uhci_exit : NULL;
+    k->unrealize = info->unplug ? usb_uhci_common_unrealize : NULL;
     k->vendor_id = info->vendor_id;
     k->device_id = info->device_id;
     k->revision  = info->revision;
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b93c80b09d8..4e190722246 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -182,7 +182,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     s->xhci.as = pci_get_address_space(dev);
 }
 
-static void usb_xhci_pci_exit(PCIDevice *dev)
+static void usb_xhci_pci_unrealize(PCIDevice *dev)
 {
     XHCIPciState *s = XHCI_PCI(dev);
     /* destroy msix memory region */
@@ -232,7 +232,7 @@ static void xhci_class_init(ObjectClass *klass, const void *data)
     dc->vmsd    = &vmstate_xhci_pci;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     k->realize      = usb_xhci_pci_realize;
-    k->exit         = usb_xhci_pci_exit;
+    k->unrealize    = usb_xhci_pci_unrealize;
     k->class_id     = PCI_CLASS_SERIAL_USB;
     device_class_set_props(dc, xhci_pci_properties);
     object_class_property_set_description(klass, "conditional-intr-mapping",
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b46b1305a7b..6225f8cc85b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3560,7 +3560,7 @@ static void vfio_pci_finalize(Object *obj)
     vfio_pci_put_device(vdev);
 }
 
-static void vfio_exitfn(PCIDevice *pdev)
+static void vfio_pci_unrealize(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3666,7 +3666,7 @@ static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "VFIO PCI base device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    pdc->exit = vfio_exitfn;
+    pdc->unrealize = vfio_pci_unrealize;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 99cb30fe595..3acb383b00d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2351,7 +2351,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 }
 
-static void virtio_pci_exit(PCIDevice *pci_dev)
+static void virtio_pci_unrealize(PCIDevice *pci_dev)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
@@ -2491,7 +2491,7 @@ static void virtio_pci_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_props(dc, virtio_pci_properties);
     k->realize = virtio_pci_realize;
-    k->exit = virtio_pci_exit;
+    k->unrealize = virtio_pci_unrealize;
     k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_OTHERS;
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 3aa01b8d68f..688f7b54b1f 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -450,7 +450,7 @@ static void i6300esb_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&d->dev, 0, 0, &d->io_mem);
 }
 
-static void i6300esb_exit(PCIDevice *dev)
+static void i6300esb_unrealize(PCIDevice *dev)
 {
     I6300State *d = WATCHDOG_I6300ESB_DEVICE(dev);
 
@@ -465,7 +465,7 @@ static void i6300esb_class_init(ObjectClass *klass, const void *data)
     k->config_read = i6300esb_config_read;
     k->config_write = i6300esb_config_write;
     k->realize = i6300esb_realize;
-    k->exit = i6300esb_exit;
+    k->unrealize = i6300esb_unrealize;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_ESB_9;
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 006b5b55f24..ec711b27623 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -987,7 +987,7 @@ err_out:
     assert(rc);
 }
 
-static void xen_pt_unregister_device(PCIDevice *d)
+static void xen_pt_unrealize(PCIDevice *d)
 {
     xen_pt_destroy(d);
 }
@@ -1057,7 +1057,7 @@ static void xen_pci_passthrough_class_init(ObjectClass *klass, const void *data)
     xpdc->pci_qdev_realize = dc->realize;
     dc->realize = xen_igd_clear_slot;
     k->realize = xen_pt_realize;
-    k->exit = xen_pt_unregister_device;
+    k->unrealize = xen_pt_unrealize;
     k->config_read = xen_pt_pci_read_config;
     k->config_write = xen_pt_pci_write_config;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.51.0


