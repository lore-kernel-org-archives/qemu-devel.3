Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF3AC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCvq-0001Tu-SF; Sat, 18 Jul 2026 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCvp-0001RQ-5Q; Sat, 18 Jul 2026 17:50:49 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCvj-0003qk-KX; Sat, 18 Jul 2026 17:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411443; x=1815947443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5LjASN1hs9znu0rglgqwL2J7wlBaZZQroFQNY57/utc=;
 b=HEeY6j/ItWaU0qmdianowKFvdTpQBWlK1o59R5KDXqEqM8Ct6GNA9ZcG
 j9TuCvkOzsAOQzFZ/rvQXC/bp/EBmf9WIhsb+Ow6syytKTIVLS+GEWk/k
 0Htp1v11fYLmVH/WBNZNmt2CKP8U77cc0cDI6Re+Mdi5/POh+VTJWRT1+
 s6X8Trf7t3iTaRtgeD3bwd02rQRIdnv5pNJjQQboWXvycO20rtDgyAOyc
 Q2YtQ7b0CmSGtMOGHTvpE0sBc8Afe0doFswxkT8Qnc9/X3j83xpxpOgzW
 XDZ3jRShUau8tTRJjPB1XbmEJNdl+lUnN1yjLB4VxegOWw/BqH0cwQn8+ w==;
X-CSE-ConnectionGUID: QuS7MO9CSZWxK+jKC0IYnw==
X-CSE-MsgGUID: r7zneoKGSVeJvNkv7wS8OA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23939791"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:50:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:2616]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id a750c74b-d457-4262-aa44-236b3d8eeb6d; Sat, 18 Jul 2026 21:50:39 +0000 (UTC)
X-Farcaster-Flow-ID: a750c74b-d457-4262-aa44-236b3d8eeb6d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:50:39 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:50:29 +0000
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
Subject: [RFC PATCH v2 049/137] hw/char: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:24 +0000
Message-ID: <20260718213652.37673-50-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/char to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The public serial helpers serial_mm_init(), serial_hds_isa_init(),
parallel_hds_isa_init(), pl011_create(), sifive_uart_create(),
xilinx_uartlite_create() and mcf_uart_create*() gain a leading
Object *parent argument, threaded through from every board caller.

Per-site rationale (reviewers: dispute the modeling here):

hw/char/exynos4210_uart.c:662 | qdev_new | parent | "uart[*]" | helper called from Exynos4210 SoC realize; thread Object *parent
hw/char/mcf_uart.c:354 | qdev_new | parent | "uart[*]" | helper called from mcf5206 mbar realize and mcf5208 board init; thread Object *parent through mcf_uart_create() + mcf_uart_create_mmap()
hw/char/mchp_pfsoc_mmuart.c:153 | qdev_new | parent | "uart[*]" | helper called from PolarFire SoC realize; thread Object *parent; note site already uses sysbus_realize (no _and_unref) so leave as-is
hw/char/parallel-isa.c:25 | isa_new | parent | "parallel[*]" | static helper called from parallel_hds_isa_init(); thread Object *parent through both and update pc.c + sun4u.c callers
hw/char/pl011.c:41 | qdev_new | parent | "uart[*]" | helper called from many ARM board inits; thread Object *parent through pl011_create()
hw/char/serial-isa.c:168 | isa_new | parent | "serial[*]" | static helper called from serial_hds_isa_init(); thread Object *parent through both and update microvm/pc/pnv/sun4u callers
hw/char/serial-mm.c:102 | qdev_new | parent | "serial[*]" | very widely used helper; thread Object *parent through serial_mm_init() and update all 41 callers
hw/char/sifive_uart.c:402 | qdev_new | parent | "uart[*]" | helper called from SiFive E/U SoC realize; thread Object *parent
hw/char/spapr_vty.c:161 | qdev_new | parent | "vty[*]" | helper called from spapr_machine_init loop; thread Object *parent
hw/char/xen_console.c:565 | qdev_new_orphan | ORPHAN-JUSTIFIED | - | XenBackend .create() callback; hotplugged device analogous to qdev_device_add() path

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/allwinner-a10.c              |  2 +-
 hw/arm/allwinner-h3.c               |  8 ++++----
 hw/arm/allwinner-r40.c              |  2 +-
 hw/arm/exynos4210.c                 |  8 ++++----
 hw/arm/integratorcp.c               |  4 ++--
 hw/arm/kzm.c                        |  2 +-
 hw/arm/msf2-soc.c                   |  2 +-
 hw/arm/musicpal.c                   |  4 ++--
 hw/arm/npcm7xx.c                    |  2 +-
 hw/arm/npcm8xx.c                    |  2 +-
 hw/arm/omap1.c                      |  8 ++++----
 hw/arm/omap_sx1.c                   |  2 +-
 hw/arm/realview.c                   |  8 ++++----
 hw/arm/versatilepb.c                |  8 ++++----
 hw/arm/vexpress.c                   |  8 ++++----
 hw/char/exynos4210_uart.c           |  6 +++---
 hw/char/mcf_uart.c                  | 11 ++++++-----
 hw/char/mchp_pfsoc_mmuart.c         |  4 ++--
 hw/char/omap_uart.c                 |  4 ++--
 hw/char/parallel-isa.c              | 10 +++++-----
 hw/char/pl011.c                     |  6 +++---
 hw/char/serial-isa.c                | 11 ++++++-----
 hw/char/serial-mm.c                 |  6 +++---
 hw/char/sifive_uart.c               |  8 ++++----
 hw/char/spapr_vty.c                 |  6 +++---
 hw/hppa/machine.c                   |  9 ++++++---
 hw/i386/microvm.c                   |  2 +-
 hw/i386/pc.c                        |  8 ++++----
 hw/loongarch/virt.c                 |  2 +-
 hw/m68k/mcf5206.c                   |  4 ++--
 hw/m68k/mcf5208.c                   |  9 ++++++---
 hw/microblaze/petalogix_ml605_mmu.c |  2 +-
 hw/mips/boston.c                    |  3 ++-
 hw/mips/jazz.c                      |  4 ++--
 hw/mips/loongson3_virt.c            |  2 +-
 hw/mips/malta.c                     |  7 ++++---
 hw/or1k/or1k-sim.c                  |  2 +-
 hw/or1k/virt.c                      |  2 +-
 hw/ppc/e500.c                       |  4 ++--
 hw/ppc/pnv.c                        |  2 +-
 hw/ppc/ppc440_bamboo.c              |  4 ++--
 hw/ppc/sam460ex.c                   |  4 ++--
 hw/ppc/spapr.c                      |  2 +-
 hw/ppc/virtex_ml507.c               |  3 ++-
 hw/riscv/boston-aia.c               |  3 ++-
 hw/riscv/k230.c                     |  8 ++++----
 hw/riscv/microblaze-v-generic.c     |  2 +-
 hw/riscv/microchip_pfsoc.c          | 10 +++++-----
 hw/riscv/sifive_e.c                 |  4 ++--
 hw/riscv/sifive_u.c                 |  4 ++--
 hw/riscv/tt_atlantis.c              |  2 +-
 hw/riscv/virt.c                     |  2 +-
 hw/riscv/xiangshan_kmh.c            |  2 +-
 hw/sparc64/niagara.c                |  2 +-
 hw/sparc64/sun4u.c                  |  6 +++---
 hw/xtensa/xtfpga.c                  |  2 +-
 include/hw/arm/exynos4210.h         |  2 +-
 include/hw/arm/omap.h               |  4 ++--
 include/hw/char/mchp_pfsoc_mmuart.h |  2 +-
 include/hw/char/parallel.h          |  2 +-
 include/hw/char/pl011.h             |  2 +-
 include/hw/char/serial-isa.h        |  2 +-
 include/hw/char/serial-mm.h         |  2 +-
 include/hw/char/sifive_uart.h       |  4 ++--
 include/hw/m68k/mcf.h               |  5 +++--
 include/hw/ppc/spapr_vio.h          |  2 +-
 66 files changed, 152 insertions(+), 139 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 66f30757dd..cbc0b38986 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -156,7 +156,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, qdev_get_gpio_in(dev, 56));
 
     /* FIXME use a qdev chardev prop instead of serial_hd() */
-    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
+    serial_mm_init(OBJECT(s), get_system_memory(), AW_A10_UART0_REG_BASE, 2,
                    qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 427dbad7c3..ce716d1687 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -406,19 +406,19 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                                           AW_H3_GIC_SPI_OHCI3));
 
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
+    serial_mm_init(OBJECT(s), get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     /* UART1 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
+    serial_mm_init(OBJECT(s), get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART1),
                    115200, serial_hd(1), DEVICE_LITTLE_ENDIAN);
     /* UART2 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
+    serial_mm_init(OBJECT(s), get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART2),
                    115200, serial_hd(2), DEVICE_LITTLE_ENDIAN);
     /* UART3 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
+    serial_mm_init(OBJECT(s), get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3),
                    115200, serial_hd(3), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index a1ae75deb6..4f9d8a606e 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -489,7 +489,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
         };
         const hwaddr addr = s->memmap[AW_R40_DEV_UART0 + i];
 
-        serial_mm_init(get_system_memory(), addr, 2,
+        serial_mm_init(OBJECT(s), get_system_memory(), addr, 2,
                        qdev_get_gpio_in(DEVICE(&s->gic), uart_irqs[i]),
                        115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 3199ea9cb7..7d9d87d7ba 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -723,19 +723,19 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
 
     /*** UARTs ***/
-    uart[0] = exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
+    uart[0] = exynos4210_uart_create(OBJECT(s), EXYNOS4210_UART0_BASE_ADDR,
                            EXYNOS4210_UART0_FIFO_SIZE, 0, serial_hd(0),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 0)]);
 
-    uart[1] = exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
+    uart[1] = exynos4210_uart_create(OBJECT(s), EXYNOS4210_UART1_BASE_ADDR,
                            EXYNOS4210_UART1_FIFO_SIZE, 1, serial_hd(1),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 1)]);
 
-    uart[2] = exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
+    uart[2] = exynos4210_uart_create(OBJECT(s), EXYNOS4210_UART2_BASE_ADDR,
                            EXYNOS4210_UART2_FIFO_SIZE, 2, serial_hd(2),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 2)]);
 
-    uart[3] = exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
+    uart[3] = exynos4210_uart_create(OBJECT(s), EXYNOS4210_UART3_BASE_ADDR,
                            EXYNOS4210_UART3_FIFO_SIZE, 3, serial_hd(3),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 3)]);
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 163012a7bf..7560ad5983 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -637,8 +637,8 @@ static void integratorcp_init(MachineState *machine)
     sysbus_create_varargs_orphan("integrator_pit", 0x13000000,
                           pic[5], pic[6], pic[7], NULL);
     sysbus_create_simple_orphan("pl031", 0x15000000, pic[8]);
-    pl011_create(0x16000000, pic[1], serial_hd(0));
-    pl011_create(0x17000000, pic[2], serial_hd(1));
+    pl011_create(OBJECT(machine), 0x16000000, pic[1], serial_hd(0));
+    pl011_create(OBJECT(machine), 0x17000000, pic[2], serial_hd(1));
     icp = sysbus_create_simple_orphan(TYPE_ICP_CONTROL_REGS, 0xcb000000,
                                qdev_get_gpio_in(sic, 3));
     sysbus_create_simple_orphan("pl050_keyboard", 0x18000000, pic[3]);
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index de9919c8cb..36e12bb362 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -120,7 +120,7 @@ static void kzm_init(MachineState *machine)
     }
 
     if (serial_hd(2)) { /* touchscreen */
-        serial_mm_init(get_system_memory(), KZM_FPGA_ADDR+0x10, 0,
+        serial_mm_init(OBJECT(machine), get_system_memory(), KZM_FPGA_ADDR+0x10, 0,
                        qdev_get_gpio_in(DEVICE(&s->soc.avic), 52),
                        14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     }
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 27d77af9dc..76eba752bd 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -146,7 +146,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < MSF2_NUM_UARTS; i++) {
         if (serial_hd(i)) {
-            serial_mm_init(get_system_memory(), uart_addr[i], 2,
+            serial_mm_init(OBJECT(s), get_system_memory(), uart_addr[i], 2,
                            qdev_get_gpio_in(armv7m, uart_irq[i]),
                            115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
         }
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 43e15a4e48..d9fe08d57b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1255,10 +1255,10 @@ static void musicpal_init(MachineState *machine)
     qdev_connect_gpio_out(uart_orgate, 0,
                           qdev_get_gpio_in(pic, MP_UART_SHARED_IRQ));
 
-    serial_mm_init(address_space_mem, MP_UART1_BASE, 2,
+    serial_mm_init(OBJECT(machine), address_space_mem, MP_UART1_BASE, 2,
                    qdev_get_gpio_in(uart_orgate, 0),
                    1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
-    serial_mm_init(address_space_mem, MP_UART2_BASE, 2,
+    serial_mm_init(OBJECT(machine), address_space_mem, MP_UART2_BASE, 2,
                    qdev_get_gpio_in(uart_orgate, 1),
                    1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
 
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 87734c1cfb..8363a04f10 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -588,7 +588,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 
     /* UART0..3 (16550 compatible) */
     for (i = 0; i < ARRAY_SIZE(npcm7xx_uart_addr); i++) {
-        serial_mm_init(get_system_memory(), npcm7xx_uart_addr[i], 2,
+        serial_mm_init(OBJECT(s), get_system_memory(), npcm7xx_uart_addr[i], 2,
                        npcm7xx_irq(s, NPCM7XX_UART0_IRQ + i), 115200,
                        serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 9ce6ea52d9..48fcc65a98 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -602,7 +602,7 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
 
     /* UART0..6 (16550 compatible) */
     for (i = 0; i < ARRAY_SIZE(npcm8xx_uart_addr); i++) {
-        serial_mm_init(get_system_memory(), npcm8xx_uart_addr[i], 2,
+        serial_mm_init(OBJECT(s), get_system_memory(), npcm8xx_uart_addr[i], 2,
                        npcm8xx_irq(s, NPCM8XX_UART0_IRQ + i), 115200,
                        serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index eefa2e441a..c86914a464 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3738,7 +3738,7 @@ static int omap_validate_tipb_mpui_addr(struct omap_mpu_state_s *s,
     return range_covers_byte(0xe1010000, 0xe1020004 - 0xe1010000, addr);
 }
 
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
+struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                 const char *cpu_type)
 {
     int i;
@@ -3842,21 +3842,21 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
 
     omap_tcmi_init(system_memory, 0xfffecc00, s);
 
-    s->uart[0] = omap_uart_init(0xfffb0000,
+    s->uart[0] = omap_uart_init(parent, 0xfffb0000,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_UART1),
                     omap_findclk(s, "uart1_ck"),
                     omap_findclk(s, "uart1_ck"),
                     s->drq[OMAP_DMA_UART1_TX], s->drq[OMAP_DMA_UART1_RX],
                     "uart1",
                     serial_hd(0));
-    s->uart[1] = omap_uart_init(0xfffb0800,
+    s->uart[1] = omap_uart_init(parent, 0xfffb0800,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_UART2),
                     omap_findclk(s, "uart2_ck"),
                     omap_findclk(s, "uart2_ck"),
                     s->drq[OMAP_DMA_UART2_TX], s->drq[OMAP_DMA_UART2_RX],
                     "uart2",
                     serial_hd(0) ? serial_hd(1) : NULL);
-    s->uart[2] = omap_uart_init(0xfffb9800,
+    s->uart[2] = omap_uart_init(parent, 0xfffb9800,
                                 qdev_get_gpio_in(s->ih[0], OMAP_INT_UART3),
                     omap_findclk(s, "uart3_ck"),
                     omap_findclk(s, "uart3_ck"),
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index a468b045d4..1bd6c6d4bc 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -125,7 +125,7 @@ static void sx1_init(MachineState *machine, const int version)
 
     memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, machine->ram);
 
-    mpu = omap310_mpu_init(machine->ram, machine->cpu_type);
+    mpu = omap310_mpu_init(OBJECT(machine), machine->ram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
     memory_region_init_rom(flash, NULL, "omap_sx1.flash0-0", flash_size,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f51730c487..965fef4fcf 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -224,10 +224,10 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple_orphan("pl050_keyboard", 0x10006000, pic[20]);
     sysbus_create_simple_orphan("pl050_mouse", 0x10007000, pic[21]);
 
-    pl011_create(0x10009000, pic[12], serial_hd(0));
-    pl011_create(0x1000a000, pic[13], serial_hd(1));
-    pl011_create(0x1000b000, pic[14], serial_hd(2));
-    pl011_create(0x1000c000, pic[15], serial_hd(3));
+    pl011_create(OBJECT(machine), 0x10009000, pic[12], serial_hd(0));
+    pl011_create(OBJECT(machine), 0x1000a000, pic[13], serial_hd(1));
+    pl011_create(OBJECT(machine), 0x1000b000, pic[14], serial_hd(2));
+    pl011_create(OBJECT(machine), 0x1000c000, pic[15], serial_hd(3));
 
     /* DMA controller is optional, apparently.  */
     dev = qdev_new_orphan("pl081");
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 59bb2d1346..6fb7223265 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -279,10 +279,10 @@ static void versatile_init(MachineState *machine, int board_id)
         n--;
     }
 
-    pl011_create(0x101f1000, pic[12], serial_hd(0));
-    pl011_create(0x101f2000, pic[13], serial_hd(1));
-    pl011_create(0x101f3000, pic[14], serial_hd(2));
-    pl011_create(0x10009000, sic[6], serial_hd(3));
+    pl011_create(OBJECT(machine), 0x101f1000, pic[12], serial_hd(0));
+    pl011_create(OBJECT(machine), 0x101f2000, pic[13], serial_hd(1));
+    pl011_create(OBJECT(machine), 0x101f3000, pic[14], serial_hd(2));
+    pl011_create(OBJECT(machine), 0x10009000, sic[6], serial_hd(3));
 
     dev = qdev_new_orphan("pl080");
     object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5cbb2c44cb..7c5a69b5a9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -643,10 +643,10 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple_orphan("pl050_keyboard", map[VE_KMI0], pic[12]);
     sysbus_create_simple_orphan("pl050_mouse", map[VE_KMI1], pic[13]);
 
-    pl011_create(map[VE_UART0], pic[5], serial_hd(0));
-    pl011_create(map[VE_UART1], pic[6], serial_hd(1));
-    pl011_create(map[VE_UART2], pic[7], serial_hd(2));
-    pl011_create(map[VE_UART3], pic[8], serial_hd(3));
+    pl011_create(OBJECT(machine), map[VE_UART0], pic[5], serial_hd(0));
+    pl011_create(OBJECT(machine), map[VE_UART1], pic[6], serial_hd(1));
+    pl011_create(OBJECT(machine), map[VE_UART2], pic[7], serial_hd(2));
+    pl011_create(OBJECT(machine), map[VE_UART3], pic[8], serial_hd(3));
 
     sysbus_create_simple_orphan("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple_orphan("sp804", map[VE_TIMER23], pic[3]);
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 6bc18851d9..dee0ecb4d7 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -650,7 +650,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
     }
 };
 
-DeviceState *exynos4210_uart_create(hwaddr addr,
+DeviceState *exynos4210_uart_create(Object *parent, hwaddr addr,
                                     int fifo_size,
                                     int channel,
                                     Chardev *chr,
@@ -659,7 +659,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     DeviceState  *dev;
     SysBusDevice *bus;
 
-    dev = qdev_new_orphan(TYPE_EXYNOS4210_UART);
+    dev = qdev_new(parent, "uart[*]", TYPE_EXYNOS4210_UART);
 
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "channel", channel);
@@ -667,7 +667,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     qdev_prop_set_uint32(dev, "tx-size", fifo_size);
 
     bus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(bus, &error_fatal);
+    sysbus_realize(bus, &error_fatal);
     if (addr != (hwaddr)-1) {
         sysbus_mmio_map(bus, 0, addr);
     }
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index f4fc47364e..2c5bfa6b67 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -347,25 +347,26 @@ static void mcf_uart_register(void)
 
 type_init(mcf_uart_register)
 
-DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chrdrv)
+DeviceState *mcf_uart_create(Object *parent, qemu_irq irq, Chardev *chrdrv)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_MCF_UART);
+    dev = qdev_new(parent, "uart[*]", TYPE_MCF_UART);
     if (chrdrv) {
         qdev_prop_set_chr(dev, "chardev", chrdrv);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
     return dev;
 }
 
-DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chrdrv)
+DeviceState *mcf_uart_create_mmap(Object *parent, hwaddr base, qemu_irq irq,
+                                  Chardev *chrdrv)
 {
     DeviceState *dev;
 
-    dev = mcf_uart_create(irq, chrdrv);
+    dev = mcf_uart_create(parent, irq, chrdrv);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index 1a6d736f56..fb8ee96b1f 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -146,11 +146,11 @@ static void mchp_pfsoc_mmuart_register_types(void)
 
 type_init(mchp_pfsoc_mmuart_register_types)
 
-MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
+MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(Object *parent, MemoryRegion *sysmem,
                                                hwaddr base,
                                                qemu_irq irq, Chardev *chr)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_MCHP_PFSOC_UART);
+    DeviceState *dev = qdev_new(parent, "uart[*]", TYPE_MCHP_PFSOC_UART);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 8cbf6ce803..4c7922a435 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -47,7 +47,7 @@ void omap_uart_reset(struct omap_uart_s *s)
     s->clksel = 0;
 }
 
-struct omap_uart_s *omap_uart_init(hwaddr base,
+struct omap_uart_s *omap_uart_init(Object *parent, hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
                 const char *label, Chardev *chr)
@@ -57,7 +57,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->base = base;
     s->fclk = fclk;
     s->irq = irq;
-    s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
+    s->serial = serial_mm_init(parent, get_system_memory(), base, 2, irq,
                                omap_clk_getrate(fclk) / 16,
                                chr ?: qemu_chr_new(label, "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 19583c0f23..758aa58017 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -17,19 +17,19 @@
 #include "hw/char/parallel.h"
 #include "qapi/error.h"
 
-static void parallel_init(ISABus *bus, int index, Chardev *chr)
+static void parallel_init(Object *parent, ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new_orphan(TYPE_ISA_PARALLEL);
+    isadev = isa_new(parent, "parallel[*]", TYPE_ISA_PARALLEL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
 }
 
-void parallel_hds_isa_init(ISABus *bus, int n)
+void parallel_hds_isa_init(Object *parent, ISABus *bus, int n)
 {
     int i;
 
@@ -37,7 +37,7 @@ void parallel_hds_isa_init(ISABus *bus, int n)
 
     for (i = 0; i < n; i++) {
         if (parallel_hds[i]) {
-            parallel_init(bus, i, parallel_hds[i]);
+            parallel_init(parent, bus, i, parallel_hds[i]);
         }
     }
 }
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c8adf964ca..d3227f1df8 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -33,15 +33,15 @@
 #include "qemu/module.h"
 #include "trace.h"
 
-DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
+DeviceState *pl011_create(Object *parent, hwaddr addr, qemu_irq irq, Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("pl011");
+    dev = qdev_new(parent, "uart[*]", "pl011");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 4dbdc0df91..4fae200e70 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -160,19 +160,20 @@ static void serial_register_types(void)
 
 type_init(serial_register_types)
 
-static void serial_isa_init(ISABus *bus, int index, Chardev *chr)
+static void serial_isa_init(Object *parent, ISABus *bus, int index,
+                            Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new_orphan(TYPE_ISA_SERIAL);
+    isadev = isa_new(parent, "serial[*]", TYPE_ISA_SERIAL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
 }
 
-void serial_hds_isa_init(ISABus *bus, int from, int to)
+void serial_hds_isa_init(Object *parent, ISABus *bus, int from, int to)
 {
     int i;
 
@@ -181,7 +182,7 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
 
     for (i = from; i < to; ++i) {
         if (serial_hd(i)) {
-            serial_isa_init(bus, i, serial_hd(i));
+            serial_isa_init(parent, bus, i, serial_hd(i));
         }
     }
 }
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index cd0844c450..bf853bb762 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -94,12 +94,12 @@ static const VMStateDescription vmstate_serial_mm = {
     }
 };
 
-SerialMM *serial_mm_init(MemoryRegion *address_space,
+SerialMM *serial_mm_init(Object *parent, MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end)
 {
-    SerialMM *smm = SERIAL_MM(qdev_new_orphan(TYPE_SERIAL_MM));
+    SerialMM *smm = SERIAL_MM(qdev_new(parent, "serial[*]", TYPE_SERIAL_MM));
     MemoryRegion *mr;
 
     qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
@@ -107,7 +107,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
     qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
     qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(smm), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(smm), &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 1613a975e0..7a35990c33 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -393,16 +393,16 @@ type_init(sifive_uart_register_types)
 /*
  * Create UART device.
  */
-SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
-    Chardev *chr, qemu_irq irq)
+SiFiveUARTState *sifive_uart_create(Object *parent, MemoryRegion *address_space,
+    hwaddr base, Chardev *chr, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("riscv.sifive.uart");
+    dev = qdev_new(parent, "uart[*]", "riscv.sifive.uart");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(address_space, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, irq);
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index a331d4be3b..a5bf6aa851 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -154,13 +154,13 @@ static target_ulong h_get_term_char(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
-void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev)
+void spapr_vty_create(Object *parent, SpaprVioBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan("spapr-vty");
+    dev = qdev_new(parent, "vty[*]", "spapr-vty");
     qdev_prop_set_chr(dev, "chardev", chardev);
-    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+    qdev_realize(dev, &bus->bus, &error_fatal);
 }
 
 static const Property spapr_vty_properties[] = {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e3c9053bf2..002f4299cc 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -607,7 +607,8 @@ static void machine_HP_715_init(MachineState *machine)
                                     SYS_BUS_DEVICE(lasi_dev), 0));
 
     /* Serial ports: Lasi use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_UART + 0x800), 0,
+    serial_mm_init(OBJECT(machine), addr_space,
+        translate(NULL, LASI_HPA_715 + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
@@ -694,11 +695,13 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
+    serial_mm_init(OBJECT(machine), addr_space,
+        translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
-    serial_mm_init(addr_space, translate(NULL, DINO_UART_HPA + 0x800), 0,
+    serial_mm_init(OBJECT(machine), addr_space,
+        translate(NULL, DINO_UART_HPA + 0x800), 0,
         qdev_get_gpio_in(dino_dev, DINO_IRQ_RS232INT), 7272727 / 16,
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d13036bd73..8e52cdd0db 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -273,7 +273,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (mms->isa_serial) {
-        serial_hds_isa_init(isa_bus, 0, 1);
+        serial_hds_isa_init(OBJECT(mms), isa_bus, 0, 1);
     }
 
     if (!x86ms->igvm) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 24ba1189d7..3d405cb33c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -981,7 +981,7 @@ static const MemoryRegionOps ioportF0_io_ops = {
     },
 };
 
-static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
+static void pc_superio_init(Object *parent, ISABus *isa_bus, bool create_fdctrl,
                             bool create_i8042, bool no_vmport, Error **errp)
 {
     int i;
@@ -989,8 +989,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     qemu_irq *a20_line;
     ISADevice *i8042, *port92, *vmmouse;
 
-    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
+    serial_hds_isa_init(parent, isa_bus, 0, MAX_ISA_SERIAL_PORTS);
+    parallel_hds_isa_init(parent, isa_bus, MAX_PARALLEL_PORTS);
 
     for (i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
@@ -1136,7 +1136,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 
     /* Super I/O */
-    pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
+    pc_superio_init(OBJECT(pcms), isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
 
     pcms->machine_done.notify = pc_machine_done;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e0129b2f33..20a68ebd44 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -471,7 +471,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     for (i = VIRT_UART_COUNT; i-- > 0;) {
         hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
         irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
-        serial_mm_init(get_system_memory(), base, 0,
+        serial_mm_init(OBJECT(lvms), get_system_memory(), base, 0,
                        qdev_get_gpio_in(pch_pic, irq),
                        115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 9f373b99b1..b3c745d3f9 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -596,8 +596,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
     m5206_timer_init(&s->timer[0], s->pic[9]);
     m5206_timer_init(&s->timer[1], s->pic[10]);
-    s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
-    s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
+    s->uart[0] = mcf_uart_create(OBJECT(s), s->pic[12], serial_hd(0));
+    s->uart[1] = mcf_uart_create(OBJECT(s), s->pic[13], serial_hd(1));
 }
 
 static const Property mcf5206_mbar_properties[] = {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0b8636daa9..f305478b8d 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -309,9 +309,12 @@ static void mcf5208evb_init(MachineState *machine)
     /* Internal peripherals.  */
     intc = mcf_intc_init(OBJECT(machine), address_space_mem, 0xfc048000, cpu);
 
-    mcf_uart_create_mmap(0xfc060000, qdev_get_gpio_in(intc, 26), serial_hd(0));
-    mcf_uart_create_mmap(0xfc064000, qdev_get_gpio_in(intc, 27), serial_hd(1));
-    mcf_uart_create_mmap(0xfc068000, qdev_get_gpio_in(intc, 28), serial_hd(2));
+    mcf_uart_create_mmap(OBJECT(machine), 0xfc060000,
+                         qdev_get_gpio_in(intc, 26), serial_hd(0));
+    mcf_uart_create_mmap(OBJECT(machine), 0xfc064000,
+                         qdev_get_gpio_in(intc, 27), serial_hd(1));
+    mcf_uart_create_mmap(OBJECT(machine), 0xfc068000,
+                         qdev_get_gpio_in(intc, 28), serial_hd(2));
 
     mcf5208_sys_init(address_space_mem, intc, cpu);
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b77df1132b..1dc34dc247 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -122,7 +122,7 @@ petalogix_ml605_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(dev, i);
     }
 
-    serial_mm_init(address_space_mem, UART16550_BASEADDR + 0x1000, 2,
+    serial_mm_init(OBJECT(machine), address_space_mem, UART16550_BASEADDR + 0x1000, 2,
                    irq[UART16550_IRQ], 115200, serial_hd(0),
                    DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 18ede54ae8..770160c4e5 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -755,7 +755,8 @@ static void boston_mach_init(MachineState *machine)
     memory_region_add_subregion_overlap(sys_mem,
                           boston_memmap[BOSTON_PLATREG].base, platreg, 0);
 
-    s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
+    s->uart = serial_mm_init(OBJECT(machine), sys_mem,
+                             boston_memmap[BOSTON_UART].base, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
                              serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 13eaa2d2ec..31ef357554 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -375,10 +375,10 @@ static void mips_jazz_init(MachineState *machine,
                                                        0));
 
     /* Serial ports */
-    serial_mm_init(address_space, 0x80006000, 0,
+    serial_mm_init(OBJECT(machine), address_space, 0x80006000, 0,
                    qdev_get_gpio_in(rc4030, 8), 8000000 / 16,
                    serial_hd(0), DEVICE_NATIVE_ENDIAN);
-    serial_mm_init(address_space, 0x80007000, 0,
+    serial_mm_init(OBJECT(machine), address_space, 0x80007000, 0,
                    qdev_get_gpio_in(rc4030, 9), 8000000 / 16,
                    serial_hd(1), DEVICE_NATIVE_ENDIAN);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f43c231004..6f2ac8ba90 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -532,7 +532,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
 
-    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
+    serial_mm_init(OBJECT(machine), address_space_mem, virt_memmap[VIRT_UART].base, 0,
                    qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
                    DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 8dc7429ac9..ea11299af8 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -569,7 +569,7 @@ static void malta_fgpa_display_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
+static MaltaFPGAState *malta_fpga_init(Object *parent, MemoryRegion *address_space,
          hwaddr base, qemu_irq uart_irq, Chardev *uart_chr)
 {
     MaltaFPGAState *s;
@@ -592,7 +592,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     qemu_chr_fe_set_handlers(&s->display, NULL, NULL,
                              malta_fgpa_display_event, NULL, s, NULL, true);
 
-    s->uart = serial_mm_init(address_space, base + 0x900, 3, uart_irq,
+    s->uart = serial_mm_init(parent, address_space, base + 0x900, 3, uart_irq,
                              230400, uart_chr, DEVICE_NATIVE_ENDIAN);
 
     malta_fpga_reset(s);
@@ -1133,7 +1133,8 @@ void mips_malta_init(MachineState *machine)
     /* FPGA */
 
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
-    malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hd(2));
+    malta_fpga_init(OBJECT(machine), system_memory, FPGA_ADDRESS, cbus_irq,
+                    serial_hd(2));
 
     /* Load firmware in flash / BIOS. */
     dinfo = drive_get(IF_PFLASH, 0, fl_idx);
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index da05d7cbe3..7ea61327c3 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -266,7 +266,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     } else {
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
-    serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
+    serial_mm_init(OBJECT(state), get_system_memory(), base, 0, serial_irq, 115200,
                    serial_hd(uart_idx),
                    DEVICE_BIG_ENDIAN);
 
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 276be32648..c0e0e3c48b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -238,7 +238,7 @@ static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr base,
     qemu_irq serial_irq = get_per_cpu_irq(OBJECT(state), cpus, num_cpus,
                                           irq_pin);
 
-    serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
+    serial_mm_init(OBJECT(state), get_system_memory(), base, 0, serial_irq, 115200,
                    serial_hd(0), DEVICE_BIG_ENDIAN);
 
     /* Add device tree node for serial. */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 85977c8b69..f7a7c136da 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1006,13 +1006,13 @@ void ppce500_init(MachineState *machine)
 
     /* Serial */
     if (serial_hd(0)) {
-        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
+        serial_mm_init(OBJECT(machine), ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hd(0), DEVICE_BIG_ENDIAN);
     }
 
     if (serial_hd(1)) {
-        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
+        serial_mm_init(OBJECT(machine), ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hd(1), DEVICE_BIG_ENDIAN);
     }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1eb3c09672..40a7559528 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1311,7 +1311,7 @@ static void pnv_init(MachineState *machine)
     pnv->isa_bus = pnv_isa_create(pnv->chips[0], &error_fatal);
 
     /* Create serial port */
-    serial_hds_isa_init(pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
+    serial_hds_isa_init(OBJECT(machine), pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
 
     /* Create an RTC ISA device too */
     mc146818_rtc_init(OBJECT(machine), pnv->isa_bus, 2000, NULL);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 68c7328129..499949bfdf 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -200,13 +200,13 @@ static void bamboo_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), PPC440EP_PCI_IO, isa);
 
     if (serial_hd(0) != NULL) {
-        serial_mm_init(address_space_mem, 0xef600300, 0,
+        serial_mm_init(OBJECT(machine), address_space_mem, 0xef600300, 0,
                        qdev_get_gpio_in(uicdev, 0),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
     if (serial_hd(1) != NULL) {
-        serial_mm_init(address_space_mem, 0xef600400, 0,
+        serial_mm_init(OBJECT(machine), address_space_mem, 0xef600400, 0,
                        qdev_get_gpio_in(uicdev, 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 41d4670fa8..be506b02f2 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -446,13 +446,13 @@ static void sam460ex_init(MachineState *machine)
 
     /* SoC has 4 UARTs but board has only one wired and two described in fdt */
     if (serial_hd(0) != NULL) {
-        serial_mm_init(get_system_memory(), 0x4ef600300, 0,
+        serial_mm_init(OBJECT(machine), get_system_memory(), 0x4ef600300, 0,
                        qdev_get_gpio_in(uic[1], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
     if (serial_hd(1) != NULL) {
-        serial_mm_init(get_system_memory(), 0x4ef600400, 0,
+        serial_mm_init(OBJECT(machine), get_system_memory(), 0x4ef600400, 0,
                        qdev_get_gpio_in(uic[0], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b81db9e8f3..969f821aca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3033,7 +3033,7 @@ static void spapr_machine_init(MachineState *machine)
     spapr->vio_bus = spapr_vio_bus_init();
 
     for (i = 0; serial_hd(i); i++) {
-        spapr_vty_create(spapr->vio_bus, serial_hd(i));
+        spapr_vty_create(OBJECT(machine), spapr->vio_bus, serial_hd(i));
     }
 
     /* We always have at least the nvram device on VIO */
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 1379c168d3..8f4b8965a9 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -228,7 +228,8 @@ static void virtex_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(dev, i);
     }
 
-    serial_mm_init(address_space_mem, UART16550_BASEADDR, 2, irq[UART16550_IRQ],
+    serial_mm_init(OBJECT(machine), address_space_mem, UART16550_BASEADDR, 2,
+                   irq[UART16550_IRQ],
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 029cf23696..26bacf0e59 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -404,7 +404,8 @@ static void boston_mach_init(MachineState *machine)
     memory_region_add_subregion_overlap(sys_mem,
                           boston_memmap[BOSTON_PLATREG].base, platreg, 0);
 
-    s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
+    s->uart = serial_mm_init(OBJECT(machine), sys_mem,
+                             boston_memmap[BOSTON_UART].base, 2,
                              qdev_get_gpio_in(s->cps.aplic, UART_INT), 10000000,
                              serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 9c67dfb895..d51ad08d87 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -137,8 +137,8 @@ static DeviceState *k230_create_plic(Object *parent, int base_hartid,
                               memmap[K230_DEV_PLIC].size);
 }
 
-static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
-                             int index)
+static void k230_create_uart(Object *parent, MemoryRegion *sys_mem,
+                             DeviceState *plic, int index)
 {
     int uart_dev = K230_DEV_UART0 + index;
     g_autofree char *name = g_strdup_printf("uart%d", index);
@@ -147,7 +147,7 @@ static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
     create_unimplemented_device(name, memmap[uart_dev].base,
                                 memmap[uart_dev].size);
 
-    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
+    serial_mm_init(parent, sys_mem, memmap[uart_dev].base, 2,
                    qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
                    399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
 }
@@ -190,7 +190,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
     /* UART */
     for (int i = 0; i < K230_UART_COUNT; i++) {
-        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
+        k230_create_uart(OBJECT(s), sys_mem, DEVICE(s->c908_plic), i);
     }
 
     /* Watchdog */
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 5864007f01..063be14b19 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -100,7 +100,7 @@ static void mb_v_generic_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
 
     /* Full uart */
-    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
+    serial_mm_init(OBJECT(machine), sysmem, UART16550_BASEADDR + 0x1000, 2,
                    irq[UART16550_IRQ], 115200, serial_hd(1),
                    DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 18ce57fba4..52fb5d5970 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -346,23 +346,23 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
 
     /* MMUARTs */
-    s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
+    s->serial0 = mchp_pfsoc_mmuart_create(OBJECT(s), system_memory,
         memmap[MICROCHIP_PFSOC_MMUART0].base,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART0_IRQ),
         serial_hd(0));
-    s->serial1 = mchp_pfsoc_mmuart_create(system_memory,
+    s->serial1 = mchp_pfsoc_mmuart_create(OBJECT(s), system_memory,
         memmap[MICROCHIP_PFSOC_MMUART1].base,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART1_IRQ),
         serial_hd(1));
-    s->serial2 = mchp_pfsoc_mmuart_create(system_memory,
+    s->serial2 = mchp_pfsoc_mmuart_create(OBJECT(s), system_memory,
         memmap[MICROCHIP_PFSOC_MMUART2].base,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART2_IRQ),
         serial_hd(2));
-    s->serial3 = mchp_pfsoc_mmuart_create(system_memory,
+    s->serial3 = mchp_pfsoc_mmuart_create(OBJECT(s), system_memory,
         memmap[MICROCHIP_PFSOC_MMUART3].base,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART3_IRQ),
         serial_hd(3));
-    s->serial4 = mchp_pfsoc_mmuart_create(system_memory,
+    s->serial4 = mchp_pfsoc_mmuart_create(OBJECT(s), system_memory,
         memmap[MICROCHIP_PFSOC_MMUART4].base,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
         serial_hd(4));
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index d07edde237..fb62bc9aca 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -266,13 +266,13 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(s->plic),
                                         SIFIVE_E_AON_WDT_IRQ));
 
-    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
+    sifive_uart_create(OBJECT(s), sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
     create_unimplemented_device("riscv.sifive.e.qspi0",
         memmap[SIFIVE_E_DEV_QSPI0].base, memmap[SIFIVE_E_DEV_QSPI0].size);
     create_unimplemented_device("riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_DEV_PWM0].base, memmap[SIFIVE_E_DEV_PWM0].size);
-    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART1].base,
+    sifive_uart_create(OBJECT(s), sys_mem, memmap[SIFIVE_E_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
     create_unimplemented_device("riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_DEV_QSPI1].base, memmap[SIFIVE_E_DEV_QSPI1].size);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 41eb22dc02..0ef0124140 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -783,9 +783,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_DEV_PLIC].size);
     g_free(plic_hart_config);
-    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART0].base,
+    sifive_uart_create(OBJECT(s), system_memory, memmap[SIFIVE_U_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
-    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
+    sifive_uart_create(OBJECT(s), system_memory, memmap[SIFIVE_U_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     riscv_aclint_swi_create(OBJECT(dev), memmap[SIFIVE_U_DEV_CLINT].base, 0,
         ms->smp.cpus, false);
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1e9bbc0f0b..4d2f5fbeda 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -544,7 +544,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
+    serial_mm_init(OBJECT(machine), system_memory, s->memmap[TT_ATL_UART1].base, 2,
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     /*
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 70e31f6327..cecb221bec 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1489,7 +1489,7 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
+    serial_mm_init(OBJECT(machine), system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index c1c10e9456..5f44e36400 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -112,7 +112,7 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
     s->irqchip = xiangshan_kmh_create_aia(OBJECT(dev), num_harts);
 
     /* UART */
-    serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
+    serial_mm_init(OBJECT(s), system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
                    qdev_get_gpio_in(s->irqchip, XIANGSHAN_KMH_UART0_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index d47d62dac7..bceda70f2e 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -151,7 +151,7 @@ static void niagara_init(MachineState *machine)
             exit(1);
         }
     }
-    serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL,
+    serial_mm_init(OBJECT(machine), sysmem, NIAGARA_UART_BASE, 0, NULL,
                    115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(OBJECT(machine), NIAGARA_RTC_BASE);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 19a54b1f8a..dbf49ef43d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -319,14 +319,14 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     /* Serial ports */
     i = 0;
     if (s->console_serial_base) {
-        serial_mm_init(pci_address_space(pci_dev), s->console_serial_base,
+        serial_mm_init(OBJECT(s), pci_address_space(pci_dev), s->console_serial_base,
                        0, NULL, 115200, serial_hd(i), DEVICE_BIG_ENDIAN);
         i++;
     }
-    serial_hds_isa_init(s->isa_bus, i, MAX_ISA_SERIAL_PORTS);
+    serial_hds_isa_init(OBJECT(s), s->isa_bus, i, MAX_ISA_SERIAL_PORTS);
 
     /* Parallel ports */
-    parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
+    parallel_hds_isa_init(OBJECT(s), s->isa_bus, MAX_PARALLEL_PORTS);
 
     /* Keyboard */
     isa_create_simple(OBJECT(s), "i8042", s->isa_bus, TYPE_I8042);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 07b791b9bf..10bbc34399 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -312,7 +312,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     xtfpga_fpga_init(system_io, 0x0d020000, freq);
     xtfpga_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000, extints[1]);
 
-    serial_mm_init(system_io, 0x0d050020, 2, extints[0],
+    serial_mm_init(OBJECT(machine), system_io, 0x0d050020, 2, extints[0],
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index b29e7243c7..2770267b4a 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -120,7 +120,7 @@ uint32_t exynos4210_get_irq(uint32_t grp, uint32_t bit);
 /*
  * exynos4210 UART
  */
-DeviceState *exynos4210_uart_create(hwaddr addr,
+DeviceState *exynos4210_uart_create(Object *parent, hwaddr addr,
                                     int fifo_size,
                                     int channel,
                                     Chardev *chr,
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 2675d064f2..e000dffe13 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -256,7 +256,7 @@ struct omap_dma_lcd_channel_s {
 #define OMAP_DMA_USB_W2FC_TX2      31
 
 struct omap_uart_s;
-struct omap_uart_s *omap_uart_init(hwaddr base,
+struct omap_uart_s *omap_uart_init(Object *parent, hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
                 const char *label, Chardev *chr);
@@ -426,7 +426,7 @@ struct omap_mpu_state_s {
 };
 
 /* omap1.c */
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
+struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *sdram,
                 const char *core);
 
 #define OMAP_BAD_REG(paddr)        \
diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
index 1e27732df1..af6ab2f2a9 100644
--- a/include/hw/char/mchp_pfsoc_mmuart.h
+++ b/include/hw/char/mchp_pfsoc_mmuart.h
@@ -62,7 +62,7 @@ typedef struct MchpPfSoCMMUartState {
  *
  * @return: a pointer to the device specific control structure
  */
-MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
+MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(Object *parent, MemoryRegion *sysmem,
     hwaddr base, qemu_irq irq, Chardev *chr);
 
 #endif /* HW_MCHP_PFSOC_MMUART_H */
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index f2c92eb5bc..782cc12602 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -23,7 +23,7 @@ typedef struct ParallelState {
     int it_shift;
 } ParallelState;
 
-void parallel_hds_isa_init(ISABus *bus, int n);
+void parallel_hds_isa_init(Object *parent, ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 5695787650..474cbaa5df 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -60,6 +60,6 @@ struct PL011State {
     uint8_t padding_for_rust[16];
 };
 
-DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
+DeviceState *pl011_create(Object *parent, hwaddr addr, qemu_irq irq, Chardev *chr);
 
 #endif
diff --git a/include/hw/char/serial-isa.h b/include/hw/char/serial-isa.h
index 8517afa128..2653f9c12d 100644
--- a/include/hw/char/serial-isa.h
+++ b/include/hw/char/serial-isa.h
@@ -31,7 +31,7 @@
 #define MAX_ISA_SERIAL_PORTS 4
 
 #define TYPE_ISA_SERIAL "isa-serial"
-void serial_hds_isa_init(ISABus *bus, int from, int to);
+void serial_hds_isa_init(Object *parent, ISABus *bus, int from, int to);
 void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
 void isa_serial_set_enabled(ISADevice *serial, bool enabled);
 
diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
index 0076bdc061..7b99a1db71 100644
--- a/include/hw/char/serial-mm.h
+++ b/include/hw/char/serial-mm.h
@@ -44,7 +44,7 @@ struct SerialMM {
     uint8_t endianness;
 };
 
-SerialMM *serial_mm_init(MemoryRegion *address_space,
+SerialMM *serial_mm_init(Object *parent, MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end);
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 5f3b1327de..fca1c6fdb9 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -85,7 +85,7 @@ struct SiFiveUARTState {
     QEMUTimer *fifo_trigger_handle;
 };
 
-SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
-    Chardev *chr, qemu_irq irq);
+SiFiveUARTState *sifive_uart_create(Object *parent, MemoryRegion *address_space,
+    hwaddr base, Chardev *chr, qemu_irq irq);
 
 #endif
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index ff818c55d0..af501ee459 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -10,8 +10,9 @@ uint64_t mcf_uart_read(void *opaque, hwaddr addr,
                        unsigned size);
 void mcf_uart_write(void *opaque, hwaddr addr,
                     uint64_t val, unsigned size);
-DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chr);
-DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chr);
+DeviceState *mcf_uart_create(Object *parent, qemu_irq irq, Chardev *chr);
+DeviceState *mcf_uart_create_mmap(Object *parent, hwaddr base, qemu_irq irq,
+                                  Chardev *chr);
 
 /* mcf_intc.c */
 DeviceState *mcf_intc_init(Object *parent, struct MemoryRegion *sysmem,
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index fcb29aebff..3ca0c9d261 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -137,7 +137,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
 
 SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
 void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
-void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
+void spapr_vty_create(Object *parent, SpaprVioBus *bus, Chardev *chardev);
 void spapr_vlan_create(Object *parent, SpaprVioBus *bus, NICInfo *nd);
 void spapr_vscsi_create(Object *parent, SpaprVioBus *bus);
 
-- 
2.47.1


