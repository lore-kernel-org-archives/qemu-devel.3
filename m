Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE74CC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDB0-0001X8-8e; Sat, 18 Jul 2026 18:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAP-0001LT-3o; Sat, 18 Jul 2026 18:05:54 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAM-0006DK-U0; Sat, 18 Jul 2026 18:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412350; x=1815948350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TGLbKWq9Z9BZZ0ElyIhhTb4+EdvWjYAXyzWadJpm6bI=;
 b=eVuqg/KboZY9lwtm7opo0anF0Cp3LGIiZVFiScEmusltnF1/pbbSfMv3
 UmTutZEHz8ndhg3vdTFcPrzIulv1tbH5af9MkR/ntl2IqSo4g+riv8zSg
 ZBfVGegt8yGrKbV2NAsmkvqSlsaZvL5Rc/ElAp7Cb0G93Xm7GloJABSU1
 CLJRBJekq8IfZ/CN8QY4RZ6TgsYuTcIULKE9EKQmsrCj7qjSqRwgiMeMe
 0NQVf8vxYY4023jmO9/QjUUVu6Z/XyRyBOXy9Oah89DmOYcq1xWNTceaw
 2du23BO8G3kRSMuyO/pNB0RIQZXtVBjIfAjF+UGiHDeqPStekMxECew7q Q==;
X-CSE-ConnectionGUID: qx349e16RYmpYL5Pv95zpg==
X-CSE-MsgGUID: q3Sjx06LRv6H39Cv3Kdp/Q==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23944869"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:05:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:24978]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.177:2525]
 with esmtp (Farcaster)
 id be74d66e-9f5c-4be6-a574-75e84bd9268f; Sat, 18 Jul 2026 22:05:47 +0000 (UTC)
X-Farcaster-Flow-ID: be74d66e-9f5c-4be6-a574-75e84bd9268f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:47 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:38 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 103/137] hw/arm/omap: Give lcdc and dma memory regions
 an explicit owner
Date: Sat, 18 Jul 2026 21:36:18 +0000
Message-ID: <20260718213652.37673-104-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Thread Object *owner as the first argument through omap_lcdc_init()
and omap_dma_init(), matching the earlier conversion of omap1.c
sub-block helpers. omap310_mpu_init() passes its parent through.

No functional change intended.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/omap1.c         | 4 ++--
 hw/display/omap_lcdc.c | 5 +++--
 hw/dma/omap_dma.c      | 4 ++--
 include/hw/arm/omap.h  | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index be6af35e26..474a3902fe 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3800,7 +3800,7 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
         dma_irqs[i] = qdev_get_gpio_in(s->ih[omap1_dma_irq_map[i].ih],
                                        omap1_dma_irq_map[i].intr);
     }
-    s->dma = omap_dma_init(0xfffed800, dma_irqs, system_memory,
+    s->dma = omap_dma_init(parent, 0xfffed800, dma_irqs, system_memory,
                            qdev_get_gpio_in(s->ih[0], OMAP_INT_DMA_LCD),
                            s, omap_findclk(s, "dma_ck"));
 
@@ -3835,7 +3835,7 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                     qdev_get_gpio_in(s->ih[1], OMAP_INT_OS_TIMER),
                     omap_findclk(s, "clk32-kHz"));
 
-    s->lcd = omap_lcdc_init(system_memory, 0xfffec000,
+    s->lcd = omap_lcdc_init(parent, system_memory, 0xfffec000,
                             qdev_get_gpio_in(s->ih[0], OMAP_INT_LCD_CTRL),
                             omap_dma_get_lcdch(s->dma),
                             omap_findclk(s, "lcd_ck"));
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index b88ea5f2f1..3f6066e3a8 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -489,7 +489,8 @@ static const GraphicHwOps omap_ops = {
     .gfx_update  = omap_update_display,
 };
 
-struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
+struct omap_lcd_panel_s *omap_lcdc_init(Object *owner,
+                                        MemoryRegion *sysmem,
                                         hwaddr base,
                                         qemu_irq irq,
                                         struct omap_dma_lcd_channel_s *dma,
@@ -502,7 +503,7 @@ struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
     s->sysmem = sysmem;
     omap_lcdc_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_lcdc_ops, s, "omap.lcdc", 0x100);
+    memory_region_init_io(&s->iomem, owner, &omap_lcdc_ops, s, "omap.lcdc", 0x100);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     s->con = qemu_graphic_console_create(NULL, 0, &omap_ops, s);
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 77f1441498..b130ba2480 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1089,7 +1089,7 @@ static void omap_dma_clk_update(void *opaque, int line, int on)
             soc_dma_set_request(s->ch[i].dma, on);
 }
 
-struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
+struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
                                 MemoryRegion *sysmem,
                                 qemu_irq lcd_irq,
                                 struct omap_mpu_state_s *mpu, omap_clk clk)
@@ -1127,7 +1127,7 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
     omap_dma_reset(s->dma);
     omap_dma_clk_update(s, 0, 1);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_dma_ops, s, "omap.dma", memsize);
+    memory_region_init_io(&s->iomem, owner, &omap_dma_ops, s, "omap.dma", memsize);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     mpu->drq = s->dma->drq;
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e000dffe13..591abf752b 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -173,7 +173,7 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 
 /* omap_dma.c */
 struct soc_dma_s;
-struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
+struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
                                 MemoryRegion *sysmem,
                                 qemu_irq lcd_irq,
                                 struct omap_mpu_state_s *mpu, omap_clk clk);
@@ -296,7 +296,8 @@ void omap_mcbsp_i2s_attach(struct omap_mcbsp_s *s, I2SCodec *slave);
 /* omap_lcdc.c */
 struct omap_lcd_panel_s;
 void omap_lcdc_reset(struct omap_lcd_panel_s *s);
-struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
+struct omap_lcd_panel_s *omap_lcdc_init(Object *owner,
+                                        MemoryRegion *sysmem,
                                         hwaddr base,
                                         qemu_irq irq,
                                         struct omap_dma_lcd_channel_s *dma,
-- 
2.47.1


