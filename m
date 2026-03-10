Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8662CFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d4-0001KI-Um; Tue, 10 Mar 2026 18:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cu-0001Fw-Na
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:34 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cs-00073u-5w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:32 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 dd1a111eb4860f1c12934ed2843786ddb528a15c181ef1ee0b540968d4cb5591 with SMTP id
 69b09bf63d2e7d2b970e52cb; Tue, 10 Mar 2026 22:32:22 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181941;
 bh=gbGcz6KPFpon6gDzfcTyRTwLorioz88BSTAwE0HoKnI=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=mzwP3MolxHaOz6FLinAh1dTw77KjqcXICeHcbaipiupj688WG1lsylrvnY0MnUj+e
 3wwSKdfvHU4AKJk7GFNgZ7PPyy0L02Vtlrg+bhob+VlBoKws0PcoxnCq0ypGNJB6rk
 8epSjskzbe42gsxcB5cd1OaECg6TM0VCto9hVNiC36R19vDVI1O6WEEUNOuBvS4fq7
 J0UroFxmt79u2tRJp+n4PvM8BB9gKESaIIXYhzdpZ2U6VUirzpcWEXCNYA69871OrX
 +P4OWmwG/EwTWssPc7IZCGNeRz+HaYX7QJVLVMuGDf3HO7SA4eU5XWOTf2XSttt2hy
 T4MMBr7MQi0zA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:49 -0500
Subject: [PATCH 09/15] hw/alpha: Convert IRQ pointers to named GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-9-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4510; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=rXxKkCgg9TKmZFppB9FKN9HnN6ES1MNT9sY4hCQAZcY=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP7E2vhn+V61dVdcDv5x5O+K1SrIu//TOrFFJGzKz
 g2zYlmEOkpZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBE5k5gZNg2q+B40Jf6C0/i
 o9dnZ7aH255y2Tx/btVTZuGFUwwv7Mph+J/97tc+uc8b1uwrXXFrd2XHipRVwcIXTKR0l1ZLbPN
 a8ZoVAA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Eliminate the qemu_irq parameters of typhoon_init() by using
qdev_init_gpio_in_named() for the IRQ lines.

Replace the qemu_irq variables in clipper_init() by calling
qdev_get_gpio_in_named() in their place.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |  5 ++++-
 hw/alpha/dp264.c     | 12 +++++++-----
 hw/alpha/typhoon.c   | 11 ++++++-----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index f6779520d9..39a96760d7 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -11,9 +11,12 @@
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
 OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *,
+PCIBus *typhoon_init(MemoryRegion *,
                      pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
 
+#define TYPHOON_GPIO_ISA_IRQ "isa-irq"
+#define TYPHOON_GPIO_RTC_IRQ "rtc-irq"
+
 /* alpha_pci.c.  */
 extern const MemoryRegionOps alpha_pci_ignore_ops;
 extern const MemoryRegionOps alpha_pci_conf1_ops;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index c0996efffe..61eeaef6db 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -66,8 +66,6 @@ static void clipper_init(MachineState *machine)
     PCIDevice *pci_dev;
     DeviceState *i82378_dev;
     ISABus *isa_bus;
-    qemu_irq rtc_irq;
-    qemu_irq isa_irq;
     long size, i;
     char *palcode_filename;
     uint64_t palcode_entry;
@@ -108,7 +106,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq,
+    pci_bus = typhoon_init(machine->ram,
                            clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
 
     /*
@@ -136,10 +134,14 @@ static void clipper_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* Connect the ISA PIC to the Typhoon IRQ used for ISA interrupts. */
-    qdev_connect_gpio_out(i82378_dev, 0, isa_irq);
+    qdev_connect_gpio_out(i82378_dev, 0,
+                          qdev_get_gpio_in_named(DEVICE(typhoon),
+                                                 TYPHOON_GPIO_ISA_IRQ, 0));
 
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
-    mc146818_rtc_init(isa_bus, 1900, rtc_irq);
+    mc146818_rtc_init(isa_bus, 1900,
+                      qdev_get_gpio_in_named(DEVICE(typhoon),
+                                             TYPHOON_GPIO_RTC_IRQ, 0));
 
     /* VGA setup.  Don't bother loading the bios.  */
     pci_vga_init(pci_bus);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 5fac5eba1c..03bb4c8055 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -831,8 +831,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
-                     qemu_irq *p_rtc_irq,
+PCIBus *typhoon_init(MemoryRegion *ram,
                      pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
                      TyphoonState *s)
 {
@@ -857,9 +856,6 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
         }
     }
 
-    *p_isa_irq = qemu_allocate_irq(typhoon_set_isa_irq, s, 0);
-    *p_rtc_irq = qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
-
     /*
      * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
      * but the address space hole reserved at this point is 8TB.
@@ -945,6 +941,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
 static void typhoon_pcihost_init(Object *obj)
 {
     TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
+    DeviceState *dev = DEVICE(obj);
 
     int i;
     for (i = 0; i < 4; ++i) {
@@ -953,6 +950,10 @@ static void typhoon_pcihost_init(Object *obj)
                                  (Object **)&s->cchip.cpu[i],
                                  qdev_prop_allow_set_link_before_realize, 0);
     }
+
+    qdev_init_gpio_in_named(dev, typhoon_set_isa_irq, TYPHOON_GPIO_ISA_IRQ, 1);
+    qdev_init_gpio_in_named(dev, typhoon_set_timer_irq, TYPHOON_GPIO_RTC_IRQ,
+                            1);
 }
 
 static void typhoon_pcihost_class_init(ObjectClass *klass, const void *data)

-- 
2.53.0


