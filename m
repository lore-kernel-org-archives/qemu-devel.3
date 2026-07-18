Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1202C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCje-0000PT-Fp; Sat, 18 Jul 2026 17:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCjc-0000OK-U4; Sat, 18 Jul 2026 17:38:12 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCjY-000201-3K; Sat, 18 Jul 2026 17:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410688; x=1815946688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bxpXC4MITv5hh985dMkHBTgluTdz27C6qpED/8FVkfo=;
 b=ROp170WA6OJv9Lxt8QGpUqiMgGIS5359KepHcd0lUvAPWUT7JrtcIfX6
 f4DG4RuqLUrWy5VTD5fxtDemAIpiqwxy5jIHSC6vcMDS6ypSaJoPRPpHs
 sZoiljlgNJRnzL11puFSZqULEU6fYUkvppYDJBbO0uTroL+q2A9OdsF/p
 Ni020q+KzukaZbGpJ6n8V910fpu1WTt8Qryei2s7wHAQTwXLzhl6/Ux20
 zNx+tQrYTNMKjlG5plj+GA8twvTLdwT3L2X2cFs2aZQruH0H2Uc3fcmL0
 3r5lg6CZb9GXkKVPvuH+BkSZgkiJBK5eLKluKZuVtdaxCvptDl2dNUW7U g==;
X-CSE-ConnectionGUID: DntEBtiETLaNCj6EC6nMng==
X-CSE-MsgGUID: MOr4UklsQfWz2fiAbIrr6Q==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422475"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:38:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:7377]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id dc3916e0-9a56-4512-9bd0-5d49a6de8b32; Sat, 18 Jul 2026 21:38:05 +0000 (UTC)
X-Farcaster-Flow-ID: dc3916e0-9a56-4512-9bd0-5d49a6de8b32
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:38:04 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:54 +0000
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
Subject: [RFC PATCH v2 004/137] sysbus: Make sysbus_create_simple()/_varargs()
 take a QOM parent
Date: Sat, 18 Jul 2026 21:34:39 +0000
Message-ID: <20260718213652.37673-5-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Sysbus is by far the largest producer of orphaned onboard devices:
of the ~1180 unparented device creation sites in the tree, well over
half go through sysbus_create_simple(), sysbus_create_varargs(), or
qdev_new_orphan()+sysbus_realize_and_unref() open-coded.

Apply the same rename-and-reintroduce treatment as qdev_new():
mechanically rename the existing helpers to *_orphan() and
reintroduce the short names with a leading (parent, id, ...) pair
that plumbs down to the new qdev_new().  The parented versions call
sysbus_realize() (not _and_unref) since the child<> property already
holds the sole reference.

The mechanical rename part is generated by

  spatch --sp-file \
      scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci \
      --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i \
          's/\bsysbus_create_simple\b/sysbus_create_simple_orphan/g;
           s/\bsysbus_create_varargs\b/sysbus_create_varargs_orphan/g'

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/allwinner-h3.c                         | 16 ++++-----
 hw/arm/collie.c                               |  2 +-
 hw/arm/exynos4210.c                           | 14 ++++----
 hw/arm/fsl-imx6.c                             |  2 +-
 hw/arm/integratorcp.c                         | 18 +++++-----
 hw/arm/mps2.c                                 |  6 ++--
 hw/arm/musicpal.c                             | 18 +++++-----
 hw/arm/npcm7xx.c                              |  2 +-
 hw/arm/realview.c                             | 24 ++++++-------
 hw/arm/sbsa-ref.c                             |  6 ++--
 hw/arm/stellaris.c                            |  8 ++---
 hw/arm/strongarm.c                            | 10 +++---
 hw/arm/versatilepb.c                          | 28 +++++++--------
 hw/arm/vexpress.c                             | 20 +++++------
 hw/arm/virt.c                                 |  8 ++---
 hw/arm/xilinx_zynq.c                          | 10 +++---
 hw/core/sysbus.c                              | 35 +++++++++++++++++-
 hw/i386/kvm/clock.c                           |  2 +-
 hw/i386/kvm/xen_evtchn.c                      |  2 +-
 hw/i386/kvm/xen_gnttab.c                      |  2 +-
 hw/i386/kvm/xen_overlay.c                     |  2 +-
 hw/i386/kvm/xen_primary_console.c             |  2 +-
 hw/i386/kvm/xen_xenstore.c                    |  2 +-
 hw/i386/microvm.c                             |  2 +-
 hw/intc/apic_common.c                         |  2 +-
 hw/loongarch/virt.c                           |  2 +-
 hw/m68k/next-cube.c                           |  4 +--
 hw/m68k/virt.c                                |  2 +-
 hw/mips/jazz.c                                |  2 +-
 hw/mips/loongson3_virt.c                      |  2 +-
 hw/or1k/virt.c                                |  2 +-
 hw/ppc/amigaone.c                             |  2 +-
 hw/ppc/e500.c                                 |  2 +-
 hw/ppc/pegasos.c                              |  4 +--
 hw/ppc/ppc440_bamboo.c                        |  2 +-
 hw/ppc/sam460ex.c                             |  8 ++---
 hw/riscv/virt.c                               |  4 +--
 hw/sparc/sun4m.c                              |  2 +-
 hw/vmapple/vmapple.c                          |  4 +--
 hw/xen/xen-pvh-common.c                       |  2 +-
 include/hw/core/sysbus.h                      | 36 ++++++++++++++++---
 .../qom-parent/sysbus-create-orphan.cocci     | 18 ++++++++++
 42 files changed, 210 insertions(+), 131 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 262e99b3f9..427dbad7c3 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -379,29 +379,29 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_EMAC));
 
     /* Universal Serial Bus */
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
+    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI0));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
+    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI1));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
+    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI2));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
+    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI3));
 
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
+    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI0));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
+    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI1));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
+    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI2));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
+    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI3));
 
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 91f0a94b6f..81bc019460 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -64,7 +64,7 @@ static void collie_init(MachineState *machine)
                               FLASH_SECTOR_SIZE, 4, 0x00, 0x00, 0x00, 0x00, 0);
     }
 
-    sysbus_create_simple("scoop", 0x40800000, NULL);
+    sysbus_create_simple_orphan("scoop", 0x40800000, NULL);
 
     collie_binfo.board_id = 0x208;
     arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 2b6e61abd0..3199ea9cb7 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -600,7 +600,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Cache controller */
-    sysbus_create_simple("l2x0", EXYNOS4210_L2X0_BASE_ADDR, NULL);
+    sysbus_create_simple_orphan("l2x0", EXYNOS4210_L2X0_BASE_ADDR, NULL);
 
     /* External GIC */
     qdev_prop_set_uint32(DEVICE(&s->ext_gic), "num-cpu", EXYNOS4210_NCPUS);
@@ -667,13 +667,13 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     * The only reason of existence at the moment is that secondary CPU boot
     * loader uses PMU INFORM5 register as a holding pen.
     */
-    sysbus_create_simple("exynos4210.pmu", EXYNOS4210_PMU_BASE_ADDR, NULL);
+    sysbus_create_simple_orphan("exynos4210.pmu", EXYNOS4210_PMU_BASE_ADDR, NULL);
 
-    sysbus_create_simple("exynos4210.clk", EXYNOS4210_CLK_BASE_ADDR, NULL);
-    sysbus_create_simple("exynos4210.rng", EXYNOS4210_RNG_BASE_ADDR, NULL);
+    sysbus_create_simple_orphan("exynos4210.clk", EXYNOS4210_CLK_BASE_ADDR, NULL);
+    sysbus_create_simple_orphan("exynos4210.rng", EXYNOS4210_RNG_BASE_ADDR, NULL);
 
     /* PWM */
-    sysbus_create_varargs("exynos4210.pwm", EXYNOS4210_PWM_BASE_ADDR,
+    sysbus_create_varargs_orphan("exynos4210.pwm", EXYNOS4210_PWM_BASE_ADDR,
                           s->irq_table[exynos4210_get_irq(22, 0)],
                           s->irq_table[exynos4210_get_irq(22, 1)],
                           s->irq_table[exynos4210_get_irq(22, 2)],
@@ -681,7 +681,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                           s->irq_table[exynos4210_get_irq(22, 4)],
                           NULL);
     /* RTC */
-    sysbus_create_varargs("exynos4210.rtc", EXYNOS4210_RTC_BASE_ADDR,
+    sysbus_create_varargs_orphan("exynos4210.rtc", EXYNOS4210_RTC_BASE_ADDR,
                           s->irq_table[exynos4210_get_irq(23, 0)],
                           s->irq_table[exynos4210_get_irq(23, 1)],
                           NULL);
@@ -784,7 +784,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
         sysbus_connect_irq(busdev, n, s->irq_table[exynos4210_get_irq(11, n)]);
     }
 
-    sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
+    sysbus_create_simple_orphan(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
             s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index eec9673c6f..103adcc2bd 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -168,7 +168,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* L2 cache controller */
-    sysbus_create_simple("l2x0", FSL_IMX6_PL310_ADDR, NULL);
+    sysbus_create_simple_orphan("l2x0", FSL_IMX6_PL310_ADDR, NULL);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 8a56165cc2..3df488921a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -626,26 +626,26 @@ static void integratorcp_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
-    dev = sysbus_create_varargs(TYPE_INTEGRATOR_PIC, 0x14000000,
+    dev = sysbus_create_varargs_orphan(TYPE_INTEGRATOR_PIC, 0x14000000,
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ),
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ),
                                 NULL);
     for (i = 0; i < 32; i++) {
         pic[i] = qdev_get_gpio_in(dev, i);
     }
-    sic = sysbus_create_simple(TYPE_INTEGRATOR_PIC, 0xca000000, pic[26]);
-    sysbus_create_varargs("integrator_pit", 0x13000000,
+    sic = sysbus_create_simple_orphan(TYPE_INTEGRATOR_PIC, 0xca000000, pic[26]);
+    sysbus_create_varargs_orphan("integrator_pit", 0x13000000,
                           pic[5], pic[6], pic[7], NULL);
-    sysbus_create_simple("pl031", 0x15000000, pic[8]);
+    sysbus_create_simple_orphan("pl031", 0x15000000, pic[8]);
     pl011_create(0x16000000, pic[1], serial_hd(0));
     pl011_create(0x17000000, pic[2], serial_hd(1));
-    icp = sysbus_create_simple(TYPE_ICP_CONTROL_REGS, 0xcb000000,
+    icp = sysbus_create_simple_orphan(TYPE_ICP_CONTROL_REGS, 0xcb000000,
                                qdev_get_gpio_in(sic, 3));
-    sysbus_create_simple("pl050_keyboard", 0x18000000, pic[3]);
-    sysbus_create_simple("pl050_mouse", 0x19000000, pic[4]);
-    sysbus_create_simple(TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
+    sysbus_create_simple_orphan("pl050_keyboard", 0x18000000, pic[3]);
+    sysbus_create_simple_orphan("pl050_mouse", 0x19000000, pic[4]);
+    sysbus_create_simple_orphan(TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
 
-    dev = sysbus_create_varargs("pl181", 0x1c000000, pic[23], pic[24], NULL);
+    dev = sysbus_create_varargs_orphan("pl181", 0x1c000000, pic[23], pic[24], NULL);
     qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
     qdev_connect_gpio_out_named(dev, "card-inserted", 0,
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 96af49e213..5a0384a412 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -416,7 +416,7 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
     sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
-    sysbus_create_simple(TYPE_PL022, 0x40025000,        /* External ADC */
+    sysbus_create_simple_orphan(TYPE_PL022, 0x40025000,        /* External ADC */
                          qdev_get_gpio_in(armv7m, 22));
     for (i = 0; i < 2; i++) {
         static const int spi_irqno[] = {11, 24};
@@ -435,7 +435,7 @@ static void mps2_common_init(MachineState *machine)
         qdev_connect_gpio_out(orgate_dev, 0,
                               qdev_get_gpio_in(armv7m, spi_irqno[i]));
         for (j = 0; j < 2; j++) {
-            sysbus_create_simple(TYPE_PL022, spibase[2 * i + j],
+            sysbus_create_simple_orphan(TYPE_PL022, spibase[2 * i + j],
                                  qdev_get_gpio_in(orgate_dev, j));
         }
     }
@@ -446,7 +446,7 @@ static void mps2_common_init(MachineState *machine)
                                          0x4002a000};   /* Shield1 */
         DeviceState *dev;
 
-        dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
+        dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
         if (i < 2) {
             /*
              * internal-only bus: mark it full to avoid user-created
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 6dd18a67b2..3bcdea7db8 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1240,9 +1240,9 @@ static void musicpal_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
-    pic = sysbus_create_simple(TYPE_MV88W8618_PIC, MP_PIC_BASE,
+    pic = sysbus_create_simple_orphan(TYPE_MV88W8618_PIC, MP_PIC_BASE,
                                qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-    sysbus_create_varargs(TYPE_MV88W8618_PIT, MP_PIT_BASE,
+    sysbus_create_varargs_orphan(TYPE_MV88W8618_PIT, MP_PIT_BASE,
                           qdev_get_gpio_in(pic, MP_TIMER1_IRQ),
                           qdev_get_gpio_in(pic, MP_TIMER2_IRQ),
                           qdev_get_gpio_in(pic, MP_TIMER3_IRQ),
@@ -1286,7 +1286,7 @@ static void musicpal_init(MachineState *machine)
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
     }
-    sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
+    sysbus_create_simple_orphan(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
     dev = qdev_new_orphan(TYPE_MV88W8618_ETH);
     qemu_configure_nic_device(dev, true, "mv88w8618");
@@ -1297,17 +1297,17 @@ static void musicpal_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(pic, MP_ETH_IRQ));
 
-    sysbus_create_simple("mv88w8618_wlan", MP_WLAN_BASE, NULL);
+    sysbus_create_simple_orphan("mv88w8618_wlan", MP_WLAN_BASE, NULL);
 
-    sysbus_create_simple(TYPE_MUSICPAL_MISC, MP_MISC_BASE, NULL);
+    sysbus_create_simple_orphan(TYPE_MUSICPAL_MISC, MP_MISC_BASE, NULL);
 
-    dev = sysbus_create_simple(TYPE_MUSICPAL_GPIO, MP_GPIO_BASE,
+    dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_GPIO, MP_GPIO_BASE,
                                qdev_get_gpio_in(pic, MP_GPIO_IRQ));
-    i2c_dev = sysbus_create_simple(TYPE_GPIO_I2C, -1, NULL);
+    i2c_dev = sysbus_create_simple_orphan(TYPE_GPIO_I2C, -1, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(i2c_dev, "i2c");
 
-    lcd_dev = sysbus_create_simple(TYPE_MUSICPAL_LCD, MP_LCD_BASE, NULL);
-    key_dev = sysbus_create_simple(TYPE_MUSICPAL_KEY, -1, NULL);
+    lcd_dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_LCD, MP_LCD_BASE, NULL);
+    key_dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_KEY, -1, NULL);
 
     /* I2C read data */
     qdev_connect_gpio_out(i2c_dev, 0,
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c27f149c04..87734c1cfb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -521,7 +521,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     }
 
     /* L2 cache controller */
-    sysbus_create_simple("l2x0", NPCM7XX_L2C_BA, NULL);
+    sysbus_create_simple_orphan("l2x0", NPCM7XX_L2C_BA, NULL);
 
     /* System Global Control Registers (GCR). Can fail due to user input. */
     object_property_set_int(OBJECT(&s->gcr), "disabled-modules",
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 0fce9b624f..287c092c2d 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -200,13 +200,13 @@ static void realview_init(MachineState *machine,
         for (n = 0; n < smp_cpus; n++) {
             sysbus_connect_irq(busdev, n, cpu_irq[n]);
         }
-        sysbus_create_varargs("l2x0", periphbase + 0x2000, NULL);
+        sysbus_create_varargs_orphan("l2x0", periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
         realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
-        dev = sysbus_create_simple(TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
+        dev = sysbus_create_simple_orphan(TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
     }
     for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
@@ -221,8 +221,8 @@ static void realview_init(MachineState *machine,
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[19]);
 
-    sysbus_create_simple("pl050_keyboard", 0x10006000, pic[20]);
-    sysbus_create_simple("pl050_mouse", 0x10007000, pic[21]);
+    sysbus_create_simple_orphan("pl050_keyboard", 0x10006000, pic[20]);
+    sysbus_create_simple_orphan("pl050_mouse", 0x10007000, pic[21]);
 
     pl011_create(0x10009000, pic[12], serial_hd(0));
     pl011_create(0x1000a000, pic[13], serial_hd(1));
@@ -238,12 +238,12 @@ static void realview_init(MachineState *machine,
     sysbus_mmio_map(busdev, 0, 0x10030000);
     sysbus_connect_irq(busdev, 0, pic[24]);
 
-    sysbus_create_simple("sp804", 0x10011000, pic[4]);
-    sysbus_create_simple("sp804", 0x10012000, pic[5]);
+    sysbus_create_simple_orphan("sp804", 0x10011000, pic[4]);
+    sysbus_create_simple_orphan("sp804", 0x10012000, pic[5]);
 
-    sysbus_create_simple("pl061", 0x10013000, pic[6]);
-    sysbus_create_simple("pl061", 0x10014000, pic[7]);
-    gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
+    sysbus_create_simple_orphan("pl061", 0x10013000, pic[6]);
+    sysbus_create_simple_orphan("pl061", 0x10014000, pic[7]);
+    gpio2 = sysbus_create_simple_orphan("pl061", 0x10015000, pic[8]);
 
     dev = qdev_new_orphan("pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
@@ -252,7 +252,7 @@ static void realview_init(MachineState *machine,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
 
-    dev = sysbus_create_varargs("pl181", 0x10005000, pic[17], pic[18], NULL);
+    dev = sysbus_create_varargs_orphan("pl181", 0x10005000, pic[17], pic[18], NULL);
     /* Wire up MMC card detect and read-only signals. These have
      * to go to both the PL061 GPIO and the sysctl register.
      * Note that the PL181 orders these lines (readonly,inserted)
@@ -278,7 +278,7 @@ static void realview_init(MachineState *machine,
                                &error_fatal);
     }
 
-    sysbus_create_simple("pl031", 0x10017000, pic[10]);
+    sysbus_create_simple_orphan("pl031", 0x10017000, pic[10]);
 
     if (!is_pb) {
         dev = qdev_new_orphan("realview_pci");
@@ -319,7 +319,7 @@ static void realview_init(MachineState *machine,
         pci_init_nic_devices(pci_bus, "rtl8139");
     }
 
-    dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
+    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_slave_create_simple(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 47a1a82a39..a821833fa7 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -537,7 +537,7 @@ static void create_rtc(const SBSAMachineState *sms)
     hwaddr base = sbsa_ref_memmap[SBSA_RTC].base;
     int irq = sbsa_ref_irqmap[SBSA_RTC];
 
-    sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
+    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(sms->gic, irq));
 }
 
 static void create_wdt(const SBSAMachineState *sms)
@@ -572,10 +572,10 @@ static void create_gpio(const SBSAMachineState *sms)
     hwaddr base = sbsa_ref_memmap[SBSA_GPIO].base;
     int irq = sbsa_ref_irqmap[SBSA_GPIO];
 
-    pl061_dev = sysbus_create_simple("pl061", base,
+    pl061_dev = sysbus_create_simple_orphan("pl061", base,
                                      qdev_get_gpio_in(sms->gic, irq));
 
-    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
+    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
 
     /* connect powerdown request */
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1f816a3965..3f72cedf2e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1143,7 +1143,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvic, 28));
 
     if (DEV_CAP(1, ADC)) {
-        dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
+        dev = sysbus_create_varargs_orphan(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
                                     qdev_get_gpio_in(nvic, 15),
                                     qdev_get_gpio_in(nvic, 16),
@@ -1189,7 +1189,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     for (i = 0; i < NUM_GPIO; i++) {
         if (DEV_CAP(4, GPIO(i))) {
-            gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
+            gpio_dev[i] = sysbus_create_simple_orphan("pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
                                                                 gpio_irq[i]));
             for (j = 0; j < 8; j++) {
@@ -1201,7 +1201,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     for (i = 0; i < NUM_I2C; i++) {
         if (DEV_CAP(2, I2C(i))) {
-            i2c_dev[i] = sysbus_create_simple(TYPE_STELLARIS_I2C, i2c_addr[i],
+            i2c_dev[i] = sysbus_create_simple_orphan(TYPE_STELLARIS_I2C, i2c_addr[i],
                                               qdev_get_gpio_in(nvic,
                                                                i2c_irq[i]));
         }
@@ -1226,7 +1226,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
     if (DEV_CAP(2, SSI)) {
-        dev = sysbus_create_simple("pl022", 0x40008000,
+        dev = sysbus_create_simple_orphan("pl022", 0x40008000,
                                    qdev_get_gpio_in(nvic, 7));
         if (board->peripherals & BP_OLED_SSI) {
             void *bus;
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 0c6b04f805..f67aaa23ed 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1622,24 +1622,24 @@ StrongARMState *sa1110_init(const char *cpu_type)
 
     s->cpu = ARM_CPU(cpu_create(cpu_type));
 
-    s->pic = sysbus_create_varargs("strongarm_pic", 0x90050000,
+    s->pic = sysbus_create_varargs_orphan("strongarm_pic", 0x90050000,
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ),
                     NULL);
 
-    sysbus_create_varargs("pxa25x-timer", 0x90000000,
+    sysbus_create_varargs_orphan("pxa25x-timer", 0x90000000,
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC0),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC1),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC2),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC3),
                     NULL);
 
-    sysbus_create_simple(TYPE_STRONGARM_RTC, 0x90010000,
+    sysbus_create_simple_orphan(TYPE_STRONGARM_RTC, 0x90010000,
                     qdev_get_gpio_in(s->pic, SA_PIC_RTC_ALARM));
 
     s->gpio = strongarm_gpio_init(0x90040000, s->pic);
 
-    s->ppc = sysbus_create_varargs(TYPE_STRONGARM_PPC, 0x90060000, NULL);
+    s->ppc = sysbus_create_varargs_orphan(TYPE_STRONGARM_PPC, 0x90060000, NULL);
 
     for (i = 0; sa_serial[i].io_base; i++) {
         DeviceState *dev = qdev_new_orphan(TYPE_STRONGARM_UART);
@@ -1651,7 +1651,7 @@ StrongARMState *sa1110_init(const char *cpu_type)
                 qdev_get_gpio_in(s->pic, sa_serial[i].irq));
     }
 
-    s->ssp = sysbus_create_varargs(TYPE_STRONGARM_SSP, 0x80070000,
+    s->ssp = sysbus_create_varargs_orphan(TYPE_STRONGARM_SSP, 0x80070000,
                 qdev_get_gpio_in(s->pic, SA_PIC_SSP), NULL);
     s->ssp_bus = (SSIBus *)qdev_get_child_bus(s->ssp, "ssi");
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 5e9d76859f..b80410db0d 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -232,21 +232,21 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
-    dev = sysbus_create_varargs("pl190", 0x10140000,
+    dev = sysbus_create_varargs_orphan("pl190", 0x10140000,
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ),
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ),
                                 NULL);
     for (n = 0; n < 32; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
-    dev = sysbus_create_simple(TYPE_VERSATILE_PB_SIC, 0x10003000, NULL);
+    dev = sysbus_create_simple_orphan(TYPE_VERSATILE_PB_SIC, 0x10003000, NULL);
     for (n = 0; n < 32; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), n, pic[n]);
         sic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    sysbus_create_simple("pl050_keyboard", 0x10006000, sic[3]);
-    sysbus_create_simple("pl050_mouse", 0x10007000, sic[4]);
+    sysbus_create_simple_orphan("pl050_keyboard", 0x10006000, sic[3]);
+    sysbus_create_simple_orphan("pl050_mouse", 0x10007000, sic[4]);
 
     dev = qdev_new_orphan("versatile_pci");
     busdev = SYS_BUS_DEVICE(dev);
@@ -292,13 +292,13 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_mmio_map(busdev, 0, 0x10130000);
     sysbus_connect_irq(busdev, 0, pic[17]);
 
-    sysbus_create_simple("sp804", 0x101e2000, pic[4]);
-    sysbus_create_simple("sp804", 0x101e3000, pic[5]);
+    sysbus_create_simple_orphan("sp804", 0x101e2000, pic[4]);
+    sysbus_create_simple_orphan("sp804", 0x101e3000, pic[5]);
 
-    sysbus_create_simple("pl061", 0x101e4000, pic[6]);
-    sysbus_create_simple("pl061", 0x101e5000, pic[7]);
-    sysbus_create_simple("pl061", 0x101e6000, pic[8]);
-    sysbus_create_simple("pl061", 0x101e7000, pic[9]);
+    sysbus_create_simple_orphan("pl061", 0x101e4000, pic[6]);
+    sysbus_create_simple_orphan("pl061", 0x101e5000, pic[7]);
+    sysbus_create_simple_orphan("pl061", 0x101e6000, pic[8]);
+    sysbus_create_simple_orphan("pl061", 0x101e7000, pic[9]);
 
     /* The versatile/PB actually has a modified Color LCD controller
        that includes hardware cursor support from the PL111.  */
@@ -312,7 +312,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Wire up the mux control signals from the SYS_CLCD register */
     qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
 
-    dev = sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
+    dev = sysbus_create_varargs_orphan("pl181", 0x10005000, sic[22], sic[1], NULL);
     dinfo = drive_get(IF_SD, 0, 0);
     if (dinfo) {
         DeviceState *card;
@@ -324,7 +324,7 @@ static void versatile_init(MachineState *machine, int board_id)
                                &error_fatal);
     }
 
-    dev = sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
+    dev = sysbus_create_varargs_orphan("pl181", 0x1000b000, sic[23], sic[2], NULL);
     dinfo = drive_get(IF_SD, 0, 1);
     if (dinfo) {
         DeviceState *card;
@@ -337,9 +337,9 @@ static void versatile_init(MachineState *machine, int board_id)
     }
 
     /* Add PL031 Real Time Clock. */
-    sysbus_create_simple("pl031", 0x101e8000, pic[10]);
+    sysbus_create_simple_orphan("pl031", 0x101e8000, pic[10]);
 
-    dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
+    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_slave_create_simple(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 716f55a086..5a0012cb4f 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -313,7 +313,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* 0x100e1000 PL354 Static Memory Controller */
     /* 0x100e2000 System Configuration Controller */
 
-    sysbus_create_simple("sp804", 0x100e4000, pic[48]);
+    sysbus_create_simple_orphan("sp804", 0x100e4000, pic[48]);
     /* 0x100e5000 SP805 Watchdog module */
     /* 0x100e6000 BP147 TrustZone Protection Controller */
     /* 0x100e9000 PL301 'Fast' AXI matrix */
@@ -321,7 +321,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* 0x100ec000 TrustZone Address Space Controller */
     /* 0x10200000 CoreSight debug APB */
     /* 0x1e00a000 PL310 L2 Cache Controller */
-    sysbus_create_varargs("l2x0", 0x1e00a000, NULL);
+    sysbus_create_varargs_orphan("l2x0", 0x1e00a000, NULL);
 }
 
 /* Voltage values for SYS_CFG_VOLT daughterboard registers;
@@ -623,7 +623,7 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, map[VE_PL041]);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[11]);
 
-    dev = sysbus_create_varargs("pl181", map[VE_MMCI], pic[9], pic[10], NULL);
+    dev = sysbus_create_varargs_orphan("pl181", map[VE_MMCI], pic[9], pic[10], NULL);
     /* Wire up MMC card detect and read-only signals */
     qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_WPROT));
@@ -640,22 +640,22 @@ static void vexpress_common_init(MachineState *machine)
                                &error_fatal);
     }
 
-    sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
-    sysbus_create_simple("pl050_mouse", map[VE_KMI1], pic[13]);
+    sysbus_create_simple_orphan("pl050_keyboard", map[VE_KMI0], pic[12]);
+    sysbus_create_simple_orphan("pl050_mouse", map[VE_KMI1], pic[13]);
 
     pl011_create(map[VE_UART0], pic[5], serial_hd(0));
     pl011_create(map[VE_UART1], pic[6], serial_hd(1));
     pl011_create(map[VE_UART2], pic[7], serial_hd(2));
     pl011_create(map[VE_UART3], pic[8], serial_hd(3));
 
-    sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
-    sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
+    sysbus_create_simple_orphan("sp804", map[VE_TIMER01], pic[2]);
+    sysbus_create_simple_orphan("sp804", map[VE_TIMER23], pic[3]);
 
-    dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI], NULL);
+    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_slave_create_simple(i2c, "sii9022", 0x39);
 
-    sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
+    sysbus_create_simple_orphan("pl031", map[VE_RTC], pic[4]); /* RTC */
 
     /* VE_COMPACTFLASH: not modelled */
 
@@ -706,7 +706,7 @@ static void vexpress_common_init(MachineState *machine)
      * no backend is created the transport will just sit harmlessly idle.
      */
     for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
-        sysbus_create_simple("virtio-mmio", map[VE_VIRTIO] + 0x200 * i,
+        sysbus_create_simple_orphan("virtio-mmio", map[VE_VIRTIO] + 0x200 * i,
                              pic[40 + i]);
     }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f8a1ba68be..1845124dc0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1561,7 +1561,7 @@ static void create_rtc(const VirtMachineState *vms)
     const char compat[] = "arm,pl031\0arm,primecell";
     MachineState *ms = MACHINE(vms);
 
-    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -1606,7 +1606,7 @@ static void virt_generic_error_req(Notifier *n, void *opaque)
 static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
-    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
+    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev,
                                                          GPIO_PIN_POWER_BUTTON));
 
@@ -1631,7 +1631,7 @@ static void create_secure_gpio_pwr(char *fdt, DeviceState *pl061_dev,
     DeviceState *gpio_pwr_dev;
 
     /* gpio-pwr */
-    gpio_pwr_dev = sysbus_create_simple("gpio-pwr", -1, NULL);
+    gpio_pwr_dev = sysbus_create_simple_orphan("gpio-pwr", -1, NULL);
 
     /* connect secure pl061 to gpio-pwr */
     qdev_connect_gpio_out(pl061_dev, SECURE_GPIO_RESET,
@@ -1746,7 +1746,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
-        sysbus_create_simple("virtio-mmio", base,
+        sysbus_create_simple_orphan("virtio-mmio", base,
                              qdev_get_gpio_in(vms->gic, irq));
     }
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8c3b47d07a..7f31cd6088 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -269,7 +269,7 @@ static void zynq_init(MachineState *machine)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
-    sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
+    sysbus_create_varargs_orphan("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
         /* See "hw/intc/arm_gic.h" for the IRQ line association */
         DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
@@ -287,8 +287,8 @@ static void zynq_init(MachineState *machine)
     n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
     n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
 
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
+    sysbus_create_simple_orphan(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
+    sysbus_create_simple_orphan(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
 
     dev = qdev_new_orphan(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
@@ -307,9 +307,9 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(busdev, 0, 0xE0001000);
     sysbus_connect_irq(busdev, 0, pic[82 - GIC_INTERNAL]);
 
-    sysbus_create_varargs("cadence_ttc", 0xF8001000,
+    sysbus_create_varargs_orphan("cadence_ttc", 0xF8001000,
             pic[42-GIC_INTERNAL], pic[43-GIC_INTERNAL], pic[44-GIC_INTERNAL], NULL);
-    sysbus_create_varargs("cadence_ttc", 0xF8002000,
+    sysbus_create_varargs_orphan("cadence_ttc", 0xF8002000,
             pic[69-GIC_INTERNAL], pic[70-GIC_INTERNAL], pic[71-GIC_INTERNAL], NULL);
 
     ddr_ctrl_init(0xF8006000);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index fe8baf73b5..bbacb07e1a 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -209,7 +209,40 @@ static void sysbus_device_realize(DeviceState *dev, Error **errp)
 {
 }
 
-DeviceState *sysbus_create_varargs(const char *name,
+static void sysbus_create_tail(SysBusDevice *s, hwaddr addr, va_list va)
+{
+    qemu_irq irq;
+    int n;
+
+    if (addr != (hwaddr)-1) {
+        sysbus_mmio_map(s, 0, addr);
+    }
+    n = 0;
+    while (1) {
+        irq = va_arg(va, qemu_irq);
+        if (!irq) {
+            break;
+        }
+        sysbus_connect_irq(s, n, irq);
+        n++;
+    }
+}
+
+DeviceState *sysbus_create_varargs(Object *parent, const char *id,
+                                    const char *type, hwaddr addr, ...)
+{
+    DeviceState *dev;
+    va_list va;
+
+    dev = qdev_new(parent, id, type);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    va_start(va, addr);
+    sysbus_create_tail(SYS_BUS_DEVICE(dev), addr, va);
+    va_end(va);
+    return dev;
+}
+
+DeviceState *sysbus_create_varargs_orphan(const char *name,
                                    hwaddr addr, ...)
 {
     DeviceState *dev;
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index e3dad136d3..de0df2c82a 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -377,7 +377,7 @@ void kvmclock_create(bool create_always)
     if (create_always ||
         cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
                                        CPUID_KVM_CLOCK2)) {
-        sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
+        sysbus_create_simple_orphan(TYPE_KVM_CLOCK, -1, NULL);
     }
 }
 
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 8b243984e4..1a406fbc00 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -306,7 +306,7 @@ static void gsi_assert_bh(void *opaque)
 
 void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
 {
-    XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple(TYPE_XEN_EVTCHN,
+    XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple_orphan(TYPE_XEN_EVTCHN,
                                                         -1, NULL));
     int i;
 
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 85b324e62d..eb43e9f385 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -152,7 +152,7 @@ static const TypeInfo xen_gnttab_info = {
 
 void xen_gnttab_create(void)
 {
-    xen_gnttab_singleton = XEN_GNTTAB(sysbus_create_simple(TYPE_XEN_GNTTAB,
+    xen_gnttab_singleton = XEN_GNTTAB(sysbus_create_simple_orphan(TYPE_XEN_GNTTAB,
                                                            -1, NULL));
 }
 
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 74cadffb72..1ef47539e4 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -169,7 +169,7 @@ static const TypeInfo xen_overlay_info = {
 
 void xen_overlay_create(void)
 {
-    xen_overlay_singleton = XEN_OVERLAY(sysbus_create_simple(TYPE_XEN_OVERLAY,
+    xen_overlay_singleton = XEN_OVERLAY(sysbus_create_simple_orphan(TYPE_XEN_OVERLAY,
                                                              -1, NULL));
 
     /* If xen_domid wasn't explicitly set, at least make sure it isn't zero. */
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index bf61f6235b..f22ce4b14b 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -84,7 +84,7 @@ static const TypeInfo xen_primary_console_info = {
 
 void xen_primary_console_create(void)
 {
-    DeviceState *dev = sysbus_create_simple(TYPE_XEN_PRIMARY_CONSOLE, -1, NULL);
+    DeviceState *dev = sysbus_create_simple_orphan(TYPE_XEN_PRIMARY_CONSOLE, -1, NULL);
 
     trace_xen_primary_console_create();
 
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 0dc0edf3bf..92493bcb6d 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -276,7 +276,7 @@ static const TypeInfo xen_xenstore_info = {
 
 void xen_xenstore_create(void)
 {
-    DeviceState *dev = sysbus_create_simple(TYPE_XEN_XENSTORE, -1, NULL);
+    DeviceState *dev = sysbus_create_simple_orphan(TYPE_XEN_XENSTORE, -1, NULL);
 
     xen_xenstore_singleton = XEN_XENSTORE(dev);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 08d54c277f..22688687c4 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -197,7 +197,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     for (i = 0; i < mms->virtio_num_transports; i++) {
-        sysbus_create_simple("virtio-mmio",
+        sysbus_create_simple_orphan("virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
                              x86ms->gsi[mms->virtio_irq_base + i]);
     }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 49c03a5bce..aaa7dca480 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -282,7 +282,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     /* Note: We need at least 1M to map the VAPIC option ROM */
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
             current_machine->ram_size >= 1024 * 1024) {
-        vapic = sysbus_create_simple("kvmvapic", -1, NULL);
+        vapic = sysbus_create_simple_orphan("kvmvapic", -1, NULL);
     }
     s->vapic = vapic;
     if (apic_report_tpr_access && info->enable_tpr_reporting) {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 23751c46d7..45acdc3ec1 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -485,7 +485,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      * Create some unimplemented devices to emulate this.
      */
     create_unimplemented_device("pci-dma-cfg", 0x1001041c, 0x4);
-    sysbus_create_simple("ls7a_rtc", VIRT_RTC_REG_BASE,
+    sysbus_create_simple_orphan("ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
 
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 5bb123594d..0c1f5b4481 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1280,7 +1280,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
 
     /* Framebuffer */
-    sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
+    sysbus_create_simple_orphan(TYPE_NEXTFB, 0x0B000000, NULL);
 
     /* MMIO */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);
@@ -1319,7 +1319,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x820c0000, &m->bmapm2);
 
     /* KBD */
-    sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
+    sysbus_create_simple_orphan(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
     memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index f86d55d96c..e2af0196e8 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -202,7 +202,7 @@ static void virt_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
 
     /* virt controller */
-    dev = sysbus_create_simple(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
+    dev = sysbus_create_simple_orphan(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
                                PIC_GPIO(VIRT_CTRL_IRQ_BASE));
 
     /* virtio-mmio */
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index f9be67249f..a902e400cf 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -395,7 +395,7 @@ static void mips_jazz_init(MachineState *machine,
     sysbus_mmio_map(sysbus, 0, 0x80009000);
 
     /* LED indicator */
-    sysbus_create_simple("jazz-led", 0x8000f000, NULL);
+    sysbus_create_simple_orphan("jazz-led", 0x8000f000, NULL);
 
     g_free(dmas);
 }
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index d3b728339e..854f7f6801 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -536,7 +536,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                    qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
                    DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
+    sysbus_create_simple_orphan("goldfish_rtc", virt_memmap[VIRT_RTC].base,
                          qdev_get_gpio_in(liointc, RTC_IRQ));
 
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 3067a5b2e7..9451a0b7df 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -300,7 +300,7 @@ static void openrisc_virt_rtc_init(OR1KVirtState *state, hwaddr base,
     qemu_irq rtc_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
 
     /* Goldfish RTC */
-    sysbus_create_simple(TYPE_GOLDFISH_RTC, base, rtc_irq);
+    sysbus_create_simple_orphan(TYPE_GOLDFISH_RTC, base, rtc_irq);
 
     /* Goldfish RTC FDT */
     nodename = g_strdup_printf("/soc/rtc@%" HWADDR_PRIx, base);
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index bcdf36b344..528c2c656a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -329,7 +329,7 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* Articia S */
-    dev = sysbus_create_simple(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
+    dev = sysbus_create_simple_orphan(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
 
     i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
     if (machine->ram_size > 512 * MiB) {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 65e71826a4..05c305b72c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1076,7 +1076,7 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Register spinning region */
-    sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
+    sysbus_create_simple_orphan("e500-spin", pmc->spin_base, NULL);
 
     if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 9d7e279123..3dc02423ee 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -218,7 +218,7 @@ static void pegasos_init(MachineState *machine)
         MemoryRegion *pci_mem, *mr;
 
         /* Articia S */
-        pm->nb = DEVICE(sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL));
+        pm->nb = DEVICE(sysbus_create_simple_orphan(TYPE_ARTICIA, 0xfe000000, NULL));
         pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
         mr = g_new(MemoryRegion, 1);
         memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", pci_mem,
@@ -233,7 +233,7 @@ static void pegasos_init(MachineState *machine)
     }
     case PEGASOS2:
         /* Marvell Discovery II system controller */
-        pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
+        pm->nb = DEVICE(sysbus_create_simple_orphan(TYPE_MV64361, -1,
                         qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
         pci_bus = mv64361_get_pci_bus(pm->nb, 1);
         break;
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index e76d359e43..7a6c3ebec5 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -183,7 +183,7 @@ static void bamboo_init(MachineState *machine)
     ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
 
     /* PCI */
-    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
+    dev = sysbus_create_varargs_orphan(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 778b04c532..88c4e66b2d 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -336,7 +336,7 @@ static void sam460ex_init(MachineState *machine)
     ppc4xx_sdram_ddr2_enable(PPC4xx_SDRAM_DDR2(dev));
 
     /* IIC controllers and devices */
-    dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700,
+    dev = sysbus_create_simple_orphan(TYPE_PPC4xx_I2C, 0x4ef600700,
                                qdev_get_gpio_in(uic[0], 2));
     i2c = PPC4xx_I2C(dev)->bus;
     /* SPD EEPROM on RAM module */
@@ -347,7 +347,7 @@ static void sam460ex_init(MachineState *machine)
     /* RTC */
     i2c_slave_create_simple(i2c, "m41t80", 0x68);
 
-    dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800,
+    dev = sysbus_create_simple_orphan(TYPE_PPC4xx_I2C, 0x4ef600800,
                                qdev_get_gpio_in(uic[0], 3));
 
     /* External bus controller */
@@ -387,7 +387,7 @@ static void sam460ex_init(MachineState *machine)
                                 l2cache_ram);
 
     /* USB */
-    sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400,
+    sysbus_create_simple_orphan(TYPE_PPC4xx_EHCI, 0x4bffd0400,
                          qdev_get_gpio_in(uic[2], 29));
     dev = qdev_new_orphan("sysbus-ohci");
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
@@ -416,7 +416,7 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
-    dev = sysbus_create_simple(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
+    dev = sysbus_create_simple_orphan(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 81212c81dd..cb1fa3c732 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1473,7 +1473,7 @@ static void virt_machine_init(MachineState *machine)
 
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        sysbus_create_simple("virtio-mmio",
+        sysbus_create_simple_orphan("virtio-mmio",
             s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
@@ -1486,7 +1486,7 @@ static void virt_machine_init(MachineState *machine)
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
+    sysbus_create_simple_orphan("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 69a287937e..80e37555b1 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1018,7 +1018,7 @@ static void sun4m_hw_init(MachineState *machine)
                      slavio_irq[30], fdc_tc);
 
     if (hwdef->cs_base) {
-        sysbus_create_simple("sun-CS4231", hwdef->cs_base,
+        sysbus_create_simple_orphan("sun-CS4231", hwdef->cs_base,
                              slavio_irq[5]);
     }
 
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 9f69ab2bc7..bf19faa04a 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -305,7 +305,7 @@ static void create_rtc(const VMAppleMachineState *vms)
     hwaddr base = vms->memmap[VMAPPLE_RTC].base;
     int irq = vms->irqmap[VMAPPLE_RTC];
 
-    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(vms->gic, irq));
 }
 
 static DeviceState *gpio_key_dev;
@@ -331,7 +331,7 @@ static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
-    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
+    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
 }
 
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 4c9a4fdea8..17f545d07c 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -173,7 +173,7 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
         qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
 
-        sysbus_create_simple("virtio-mmio", base, irq);
+        sysbus_create_simple_orphan("virtio-mmio", base, irq);
 
         trace_xen_create_virtio_mmio_devices(i,
                                              s->cfg.virtio_mmio_irq_base + i,
diff --git a/include/hw/core/sysbus.h b/include/hw/core/sysbus.h
index f3c4259d29..1e07b1978d 100644
--- a/include/hw/core/sysbus.h
+++ b/include/hw/core/sysbus.h
@@ -91,15 +91,43 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
 /* Call func for every dynamically created sysbus device in the system */
 void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque);
 
-/* Legacy helper function for creating devices.  */
-DeviceState *sysbus_create_varargs(const char *name,
+/**
+ * sysbus_create_varargs: Create, parent and realize a sysbus device
+ * @parent: the QOM parent (usually the machine or containing device)
+ * @id: child<> property name
+ * @type: sysbus device type to create
+ * @addr: MMIO region 0 address, or -1 for none
+ * @...: NULL-terminated list of qemu_irq to connect
+ *
+ * Create a sysbus device via qdev_new(@parent, @id, @type), realize
+ * it, optionally map MMIO region 0 at @addr, and connect the given
+ * IRQs.  The returned device is owned by @parent.
+ *
+ * This is a convenience helper for simple sysbus devices; new code
+ * should generally prefer qdev_new() + sysbus_realize() and set
+ * properties explicitly before realize.
+ */
+DeviceState *sysbus_create_varargs(Object *parent, const char *id,
+                                   const char *type, hwaddr addr, ...);
+
+static inline DeviceState *sysbus_create_simple(Object *parent,
+                                                 const char *id,
+                                                 const char *type,
+                                                 hwaddr addr,
+                                                 qemu_irq irq)
+{
+    return sysbus_create_varargs(parent, id, type, addr, irq, NULL);
+}
+
+/* Legacy helper function for creating unparented devices.  */
+DeviceState *sysbus_create_varargs_orphan(const char *name,
                                  hwaddr addr, ...);
 
-static inline DeviceState *sysbus_create_simple(const char *name,
+static inline DeviceState *sysbus_create_simple_orphan(const char *name,
                                               hwaddr addr,
                                               qemu_irq irq)
 {
-    return sysbus_create_varargs(name, addr, irq, NULL);
+    return sysbus_create_varargs_orphan(name, addr, irq, NULL);
 }
 
 #endif /* HW_SYSBUS_H */
diff --git a/scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci b/scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci
new file mode 100644
index 0000000000..b925d9396f
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename sysbus_create_simple()/sysbus_create_varargs() to *_orphan()
+// so that the short names can be reintroduced with a mandatory
+// (parent, id, ...) signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- sysbus_create_simple
++ sysbus_create_simple_orphan
+
+@@
+@@
+- sysbus_create_varargs
++ sysbus_create_varargs_orphan
-- 
2.47.1


