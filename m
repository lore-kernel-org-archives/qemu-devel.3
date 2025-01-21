Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603B6C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxU-0000NY-Jh; Tue, 21 Jan 2025 11:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxP-0000Lu-ML
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxN-0005zT-R6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so40398045e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476304; x=1738081104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2sEtAFoFWHQ01p5+N4SGtbcml5iyx/5IH+2u55pyYU=;
 b=uWmqTyWAUkYeY11VIzZzNu6dkww2abQGqIPyIPcJiT6iiW53J9mPvCLcIzMHdPWed/
 ML+nUUvEiFtIwCYzDqmDCzqblnJaybxjbp2oEwbmSUMeKU9KIVb1OZYhr6KlSe+4CTF4
 vKWsJq95jnDlc4UmFwkPYZXZwN3gIi6554wGS0Wb8pmeRnL5lZ5HugUhq+5sZxWQyypv
 /m7H8IiTSem7UbSuPqg41JabIt6WMpfoydt/Vo08cFK9kToYxjJFkEjpbWMX2lKNwX/W
 kB2CzQmPfPtZm6oAfZrdg59+qbAYx4stB3j/87uUnkga/Ac3bZfoUvRGSZbC5w5hIoJP
 GgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476304; x=1738081104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2sEtAFoFWHQ01p5+N4SGtbcml5iyx/5IH+2u55pyYU=;
 b=C9ihxdttRYUrRaryyyHTAz+lBiwy7TgWcVAr2/d076BgNbu407y9OVZ3YZ9sFFI9wM
 79Q41Th2t/uBU7WocGjUbpBBnBETmS0yiCBOEHO5NODBvCBjhRjs8rm/ifIwKAemy6Po
 rOHC28+sVBuyx7xOo05REmTQK5jHo8bxI9f2pMD1zQMPYndn0oRVusvDmbeYAb43WA1R
 AXDahb9CafE+QlBhRE9mipAcBdIQYK+GXZoV4mnRPelXI+QTKvDaiP5TDJxf/OmK5Eks
 XRWTkmnGn5YUTEDGoJzgEzVE+Egk4vcgPrsykJyw/wcVMsZpkUbDQh+68rG7MmkAgN+q
 iZdQ==
X-Gm-Message-State: AOJu0Yy2VX4pZgFneBIYfGHYSBOUfD3vVE8GqMpFOThqhCyHfUoU01Zc
 flXTvoACMo7NBBKL6to7o7PZSRp1aTWaageIIylMzvTlnrfKGc5qQJ6k9R/gNFDd7L7k5akkumm
 nojM=
X-Gm-Gg: ASbGncsZiYgTIpaIR3srxQdevKrIrCzoRYSiTF0Ju30Hn63Wvr3It+X8v5ACJU71yqt
 MjceuVr8Q96zoVZNRKZrM2dbetWECOwgNoWkdMOBkDrpXK1q2zFRZDagkpbVrwl9HIC7J1/+HGn
 XSHZ5Wbr5khMuD0bWVtUfT2vd9yQfAe/tNrwRfgmaZ+8QlrMXLuVvWR4L2vUZOCS2/7Ld2CPT1O
 iq8zUL5j79jZAOiTnJNlHqOB4o/cbyqoLGCUZxb8rfHnLsUBlmhiiVJiz2BTQ6i3nOcvYQcKtIc
 A8ze0qmxYXCkuGz4mvhp+MuF5N/GZx9d2nloCtn9Q2ge
X-Google-Smtp-Source: AGHT+IHVqbmzrHpbpgLX2XakH9ckSR0ikqCPW62HV7ihCVZEp/lxxvZN70vOCdo3IgRSKmMJZzamwA==
X-Received: by 2002:adf:f1cc:0:b0:38b:ed88:f045 with SMTP id
 ffacd0b85a97d-38bf566fb1bmr14177124f8f.33.1737476303934; 
 Tue, 21 Jan 2025 08:18:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad81sm13927504f8f.52.2025.01.21.08.18.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 1/6] hw/pci-host/bonito: Expose output IRQ as QDev GPIO
Date: Tue, 21 Jan 2025 17:18:12 +0100
Message-ID: <20250121161817.33654-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Expose IRQ using qdev_init_gpio_out() in bonito_host_realize(),
wire it using qdev_connect_gpio_out() in bonito_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/mips.h |  2 +-
 hw/mips/fuloong2e.c    |  2 +-
 hw/pci-host/bonito.c   | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 101799f7d3e..1176291cca6 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -10,7 +10,7 @@
 #include "exec/memory.h"
 
 /* bonito.c */
-PCIBus *bonito_init(qemu_irq *pic);
+PCIBus *bonito_init(qemu_irq irq);
 
 /* rc4030.c */
 typedef struct rc4030DMAState *rc4030_dma;
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 16b6a5129e7..160ceb769dc 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -282,7 +282,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     cpu_mips_clock_init(cpu);
 
     /* North bridge, Bonito --> IP2 */
-    pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
+    pci_bus = bonito_init(env->irq[2]);
 
     /* South bridge -> IP5 */
     pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 49669148923..6bc66c9e227 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -234,7 +234,7 @@ typedef struct PCIBonitoState PCIBonitoState;
 
 struct BonitoState {
     PCIHostState parent_obj;
-    qemu_irq *pic;
+    qemu_irq irq;
     PCIBonitoState *pci_dev;
     MemoryRegion pci_mem;
 };
@@ -554,17 +554,16 @@ static const MemoryRegionOps bonito_spciconf_ops = {
 static void pci_bonito_set_irq(void *opaque, int irq_num, int level)
 {
     BonitoState *s = opaque;
-    qemu_irq *pic = s->pic;
     PCIBonitoState *bonito_state = s->pci_dev;
     int internal_irq = irq_num - BONITO_IRQ_BASE;
 
     if (bonito_state->regs[BONITO_INTEDGE] & (1 << internal_irq)) {
-        qemu_irq_pulse(*pic);
+        qemu_irq_pulse(s->irq);
     } else {   /* level triggered */
         if (bonito_state->regs[BONITO_INTPOL] & (1 << internal_irq)) {
-            qemu_irq_raise(*pic);
+            qemu_irq_raise(s->irq);
         } else {
-            qemu_irq_lower(*pic);
+            qemu_irq_lower(s->irq);
         }
     }
 }
@@ -631,6 +630,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
     BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
     MemoryRegion *pcimem_lo_alias = g_new(MemoryRegion, 3);
 
+    qdev_init_gpio_out(dev, &bs->irq, 1);
     memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIHI_SIZE);
     phb->bus = pci_register_root_bus(dev, "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
@@ -734,7 +734,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     pci_set_byte(dev->config + PCI_MAX_LAT, 0x00);
 }
 
-PCIBus *bonito_init(qemu_irq *pic)
+PCIBus *bonito_init(qemu_irq irq)
 {
     DeviceState *dev;
     BonitoState *pcihost;
@@ -745,8 +745,8 @@ PCIBus *bonito_init(qemu_irq *pic)
     dev = qdev_new(TYPE_BONITO_PCI_HOST_BRIDGE);
     phb = PCI_HOST_BRIDGE(dev);
     pcihost = BONITO_PCI_HOST_BRIDGE(dev);
-    pcihost->pic = pic;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    qdev_connect_gpio_out(dev, 0, irq);
 
     d = pci_new(PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s = PCI_BONITO(d);
-- 
2.47.1


