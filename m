Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9325CFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d4-0001K5-Rh; Tue, 10 Mar 2026 18:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cy-0001GV-Ed
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:37 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cw-00074G-FW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:36 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 dbc7f4c6c79c3533e5c7fb9054bc230051c576484705bc45bf6eb498b72f8c21 with SMTP id
 69b09bf73b0c4bd463bb6c9c; Tue, 10 Mar 2026 22:32:23 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181943;
 bh=JDEJveIC4LRq/vyTFe2UtG8lUnBAAXmro3Cm4J8twlg=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=kyxd4EEZm1gTJDsqusPedUc7ruxUc10knBqzbCEE6gMDWAvQXZzkr6SUd0117256v
 xkTciexiys67jwKPUpmPnpSdR74IIGcqEDa0IMtLTsvNnUtL6xCILS2FzC5n5TLhH+
 bYQAhD8uz16F8zYkmUtY41BKWNlTszXt4V4tIO9NNqI2FRfQ32mENjHoklAwVewdRX
 8Ke5ozPr71QKh4aSrFy6dqnsxnReZNCQQAdyoKZgohrWAv66+Dw3BUrqCBMIetiLTU
 rtiu82WIgrc9f6SKSbwQv9Qs1TvSDK6NHf6is2WcSxsTZnIHMRjDCcpHMPsrEmq3VF
 pix5zU9Gl2sdw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:54 -0500
Subject: [PATCH 14/15] hw/alpha: Use QOM path resolution to get Typhoon PCI bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-14-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=hrcnc7S03eaLSYz9ETaJoDrd1Sz9oSiV/EYFgG89M78=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP7ksvCt9RZr9ZxNRsZbvVjsTO8nPlMS+jlxZs/+r
 0H7Di0I7ihlYRDjYpAVU2S5fFbirEPu7q60lT/uw8xhZQIZwsDFKQATseNj+Cui/azUYYEOL5vp
 fO1lnjJOsW/C/0uLq54PSAoIihJKXsLIcHvxFdbguZnbWzVl13RvTY+9rnb5t7LNyztqqw1Y8xm
 DeQE=
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

Use object_resolve_path_component() in clipper_init() to retrieve
the PCI bus after it is realized in typhoon_init(). Modify
typhoon_init() such that it returns nothing instead of the PCI bus.

After this commit, we could cleanly split typhoon_init()
into the typhoon's instance_init and realize hooks.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h | 3 ++-
 hw/alpha/dp264.c     | 4 +++-
 hw/alpha/typhoon.c   | 6 ++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index cf16e235fb..27c3a72b13 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -20,9 +20,10 @@ typedef struct TyphoonClass {
 
 OBJECT_DECLARE_TYPE(TyphoonState, TyphoonClass, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(TyphoonState *);
+void typhoon_init(TyphoonState *);
 
 #define TYPHOON_PROP_RAM "ram"
+#define TYPHOON_PCI_BUS_NAME "pci"
 
 #define TYPHOON_GPIO_ISA_IRQ "isa-irq"
 #define TYPHOON_GPIO_RTC_IRQ "rtc-irq"
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index de5829a004..92a15b0239 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -111,7 +111,9 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(typhoon);
+    typhoon_init(typhoon);
+    pci_bus = PCI_BUS(object_resolve_path_component(typhoon_obj,
+                                                    TYPHOON_PCI_BUS_NAME));
 
     /*
      * Init the PCI -> ISA bridge.
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ad5010bea8..55f3aae584 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -833,7 +833,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(TyphoonState *s)
+void typhoon_init(TyphoonState *s)
 {
     TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_GET_CLASS(s);
     MemoryRegion *addr_space = get_system_memory();
@@ -900,7 +900,7 @@ PCIBus *typhoon_init(TyphoonState *s)
     memory_region_add_subregion(addr_space, 0x801fc000000ULL,
                                 &s->pchip.reg_io);
 
-    b = pci_register_root_bus(dev, "pci",
+    b = pci_register_root_bus(dev, TYPHOON_PCI_BUS_NAME,
                               typhoon_set_irq, tc->sys_map_irq, s,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
                               tc->devfn_min, 64, TYPE_PCI_BUS);
@@ -937,8 +937,6 @@ PCIBus *typhoon_init(TyphoonState *s)
     /* Pchip1 PCI special/interrupt acknowledge, 0x802.F800.0000, 64MB.  */
     /* Pchip1 PCI I/O, 0x802.FC00.0000, 32MB.  */
     /* Pchip1 PCI configuration, 0x802.FE00.0000, 16MB.  */
-
-    return b;
 }
 
 static void typhoon_pcihost_init(Object *obj)

-- 
2.53.0


