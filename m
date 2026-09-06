Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B629C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP1-0003pL-99; Sun, 06 Sep 2026 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOs-0003hy-Ff
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOq-0000Ci-9p
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN6fzqL1EWyRhromfegl8aRXCAzNpeH8BwajrGveEfc=;
 b=SibIdFh18YksWrrtDQurqSnqp/K3Fj8AwKhdk3uBEwH9kZibXK2U9RlYzZJxVbzlY0ALAx
 0Oaa9U+iLxOqf0QmwqouACNmfbDlO8d5O4woPmd3Cqyh+lzRq0icxBFYJq3F2Gt0yZnOHC
 0OgMeVKUF9Hty7s6yMfMiM+E7o/9iwA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-xdh0iWLsPcawtGWroRbc1w-1; Sun,
 06 Sep 2026 13:11:20 -0400
X-MC-Unique: xdh0iWLsPcawtGWroRbc1w-1
X-Mimecast-MFC-AGG-ID: xdh0iWLsPcawtGWroRbc1w_1788714679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C3741808872; Sun,  6 Sep 2026 17:11:19 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 958A71955F06; Sun,  6 Sep 2026 17:11:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/40] hw/arm/aspeed_ast2600: Wire up the UDC
Date: Sun,  6 Sep 2026 19:10:05 +0200
Message-ID: <20260906171021.26568-25-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC
and map its registers.

The UDC and the second EHCI host controller (EHCI2) share one SoC
interrupt line. Route both through an OR gate whose output drives that
GIC input, so either device can raise the interrupt without the other
clobbering the line.

The gadget USB device is not created by the SoC. It is a separate,
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a
USB host controller's bus; it finds its controller through the "udc"
link property, e.g.

  -device aspeed.udc-gadget,udc=/machine/soc/udc

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260902021542.3194812-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  4 ++++
 hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cba8b7cdca58..38226d9b8049 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -37,6 +37,8 @@
 #include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/usb/aspeed-udc.h"
+#include "hw/core/or-irq.h"
 #include "qom/object.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/unimp.h"
@@ -140,6 +142,8 @@ struct Aspeed2600SoCState {
 
     A15MPPrivState a7mpcore;
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
+    AspeedUDCState udc;
+    OrIRQState ehci2_udc_orgate;
 };
 
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index f7c7ec7fb1d4..1a10d0fe1ecc 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -34,6 +34,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_SPI1]      = 0x1E630000,
     [ASPEED_DEV_SPI2]      = 0x1E631000,
     [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
+    [ASPEED_DEV_UDC]       = 0x1E6A2000,
     [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
     [ASPEED_DEV_MII1]      = 0x1E650000,
     [ASPEED_DEV_MII2]      = 0x1E650008,
@@ -218,6 +219,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
                                 TYPE_PLATFORM_EHCI);
     }
 
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);
+    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,
+                            TYPE_OR_IRQ);
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -581,6 +586,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 + i));
     }
 
+    /*
+     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs
+     * together and drive that GIC input from the OR gate.
+     */
+    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,
+                            &error_abort);
+    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);
+    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,
+                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2));
+
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
@@ -588,10 +603,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_ast2600_get_irq(s,
-                                                      ASPEED_DEV_EHCI1 + i));
     }
+    /*
+     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it through
+     * the OR gate.
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));
+
+    /* UDC - USB 2.0 Device Controller */
+    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,
+                    sc->memmap[ASPEED_DEV_UDC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));
 
     /* SDMC - SDRAM Memory Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
-- 
2.55.0


