Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB4BFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d1-0001HY-7W; Tue, 10 Mar 2026 18:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cy-0001GX-IH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:37 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cw-00074C-AS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:36 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 24d0e8596e920317483219ab03edf2ef378cf49927040a0877d345556bda89c5 with SMTP id
 69b09bf751a88c07fa9b81ff; Tue, 10 Mar 2026 22:32:23 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181943;
 bh=IeY0CTjPrMoLrbeOYju3Sao9ZHnIH4TAr68jBLhJOeg=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=mx8xjxCPzTQW+925fTA6J8HV5h1oyKdSUVyygXWPDl4saeJrodH0fct0sjOOlgsZW
 PJRIcXL/vbm2juwXMrd7xrC3NCGLi4z4RX9VoIYVgsJFMO20i5rGIL3F+WcNKjmfjD
 2CQexXRB2ZHFxbT/DwvdM/w5u5CbWWN+rym4ou0Nte1kJ3J1XgwOWPi8scnIrwfg5z
 f7SMxdCnehzMw2qLLTLAfNOnoFxGoxkBI1lcPs7gfAYiWgHJ5es/A1nQBiWhJRjK46
 vg9fWMj+Dos9elRg3Bd5BikZ8V789EEPoe0ojyYvnq1pUc4TImBDRy2wnqPCZWOvjc
 ehJXu8WvMoQ3Q==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:53 -0500
Subject: [PATCH 13/15] hw/alpha: Move minimum PCI device slot to TyphoonClass
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-13-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=QT3tNqJcNbGfJRHnVsgH+ev8a5qVOS/RYz7JoiX0oqE=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP5k1DhZZYoU63Vd8R87Vdn8l6RYn03N0zVNXDBJj
 Csw5uD5jlIWBjEuBlkxRZbLZyXOOuTu7kpb+eM+zBxWJpAhDFycAjCRS2aMDGdeG+2edsMzPv3C
 tRWnf9/4tSrX8lDWgzdzH3zsP2fSHBnDyPBBR3/q1dpbm47JC37k6ChKuxtd9kvLm9XN8fqVyzV
 cGzgB
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

Move devfn_min to a member of TyphoonClass and set the
Clipper-specific value, PCI_DEVFN(1, 0), in its subclass init.

Eliminate devfn_min as a parameter of typhoon_init() to enable
its forthcoming split into instance_init and realize hooks.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h | 3 ++-
 hw/alpha/dp264.c     | 3 ++-
 hw/alpha/typhoon.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index fdfe96dcb4..cf16e235fb 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -15,11 +15,12 @@ typedef struct TyphoonClass {
     PCIHostBridgeClass parent_class;
 
     pci_map_irq_fn sys_map_irq;
+    uint8_t devfn_min;
 } TyphoonClass;
 
 OBJECT_DECLARE_TYPE(TyphoonState, TyphoonClass, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(uint8_t devfn_min, TyphoonState *);
+PCIBus *typhoon_init(TyphoonState *);
 
 #define TYPHOON_PROP_RAM "ram"
 
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 8c3c8fec67..de5829a004 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -111,7 +111,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(PCI_DEVFN(1, 0), typhoon);
+    pci_bus = typhoon_init(typhoon);
 
     /*
      * Init the PCI -> ISA bridge.
@@ -259,6 +259,7 @@ static void typhoon_pcihost_clipper_class_init(ObjectClass *oc,
     TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_CLASS(oc);
 
     tc->sys_map_irq = clipper_pci_map_irq;
+    tc->devfn_min = PCI_DEVFN(1, 0);
 }
 
 static const TypeInfo clipper_types[] = {
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index b261dd7bc5..ad5010bea8 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -833,7 +833,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(uint8_t devfn_min, TyphoonState *s)
+PCIBus *typhoon_init(TyphoonState *s)
 {
     TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_GET_CLASS(s);
     MemoryRegion *addr_space = get_system_memory();
@@ -903,7 +903,7 @@ PCIBus *typhoon_init(uint8_t devfn_min, TyphoonState *s)
     b = pci_register_root_bus(dev, "pci",
                               typhoon_set_irq, tc->sys_map_irq, s,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
-                              devfn_min, 64, TYPE_PCI_BUS);
+                              tc->devfn_min, 64, TYPE_PCI_BUS);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 

-- 
2.53.0


