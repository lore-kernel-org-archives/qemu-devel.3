Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC6C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD3P-00039Z-08; Sat, 18 Jul 2026 17:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD3J-0002zl-P7; Sat, 18 Jul 2026 17:58:35 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD3E-0004mr-Fw; Sat, 18 Jul 2026 17:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411908; x=1815947908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ebcd7WqkKmtnKQS6szp08fKMgmlqMo1enH2NE0lisY8=;
 b=WMBldoEatNU0/dX3fus898hnjEGxeTHOhyd+V/9gjIqfSiJ/fcJyTp+w
 CGKWbSnzNHav7Jq/f4NXCsU7fdnBGS90lRhwOTWqHPJfE2PQD5kGwcy1F
 i7akoTw9btY5cKe5Nb6qP3/s6/BTyCr8DoMgm/m7UyCMiSxClrLS7lg+m
 Kvix3zVpWkj3UHVcASAjeJxjYFZY3LZOrVSvQfB5tDFDTpAH5328j7yML
 hTaVg6dXpB1O9SHGCnbevDnr97YUpjmmJexGHNqAI+nQ0PMQH/gC8xrgp
 OSU2MhEIA+j+Wz6uVda7CUOdWUXS3PFjaP4NOrM9qx6Rav7GZYYV33Kn/ Q==;
X-CSE-ConnectionGUID: zUa3SqKTRYuPxX6aLhI5Ag==
X-CSE-MsgGUID: 7u4HRjgtRauDJU1n08KwGw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23917558"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:58:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:9693]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id 7519f9d8-c9a5-4f96-a9a6-5d9afbfa1e7b; Sat, 18 Jul 2026 21:58:24 +0000 (UTC)
X-Farcaster-Flow-ID: 7519f9d8-c9a5-4f96-a9a6-5d9afbfa1e7b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:58:24 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:58:14 +0000
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
Subject: [RFC PATCH v2 077/137] hw/misc/unimp: Give
 create_unimplemented_device() a QOM parent
Date: Sat, 18 Jul 2026 21:35:52 +0000
Message-ID: <20260718213652.37673-78-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Every one of the ~500 call sites already sits inside a SoC .realize()
or a board .init() where the natural composition-tree owner is in
scope.  Thread that owner through as the first argument, reuse the
existing @name string as the child<> id, and switch the internal
qdev_new_orphan()+sysbus_realize_and_unref() pair to the parented
qdev_new()+sysbus_realize().

Parent expression per caller class:

  *_realize(DeviceState *dev, ...)      OBJECT(dev)
  *_soc_realize(DeviceState *dev_soc,)  OBJECT(dev_soc)
  board_init(MachineState *machine)    OBJECT(machine) / OBJECT(ms) etc.

No behavioural change: the low-priority overlap mapping still lets
real device models take precedence.  All 20 softmmu targets build.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/allwinner-a10.c                   |   2 +-
 hw/arm/allwinner-h3.c                    |   2 +-
 hw/arm/allwinner-r40.c                   |   2 +-
 hw/arm/fsl-imx6.c                        |   2 +-
 hw/arm/fsl-imx6ul.c                      |  35 +++---
 hw/arm/fsl-imx7.c                        |  33 +++---
 hw/arm/fsl-imx8mm.c                      |   2 +-
 hw/arm/fsl-imx8mp.c                      |   2 +-
 hw/arm/max78000_soc.c                    | 105 ++++++++--------
 hw/arm/mps2-tz.c                         |   7 +-
 hw/arm/mps2.c                            |  27 +++--
 hw/arm/mps3r.c                           |  10 +-
 hw/arm/msf2-soc.c                        |  20 ++--
 hw/arm/npcm7xx.c                         |  91 +++++++-------
 hw/arm/npcm8xx.c                         | 145 ++++++++++++-----------
 hw/arm/nrf51_soc.c                       |   4 +-
 hw/arm/stellaris.c                       |  12 +-
 hw/arm/stm32f100_soc.c                   |  60 +++++-----
 hw/arm/stm32f405_soc.c                   |  84 ++++++-------
 hw/arm/stm32l4x5_soc.c                   |  88 +++++++-------
 hw/arm/xilinx_zynq.c                     |  61 +++++-----
 hw/avr/atmega.c                          |  20 ++--
 hw/loongarch/virt.c                      |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   2 +-
 hw/mips/loongson3_virt.c                 |   5 +-
 hw/pci-host/bonito.c                     |  14 +--
 hw/riscv/k230.c                          | 107 ++++++++---------
 hw/riscv/microblaze-v-generic.c          |  10 +-
 hw/riscv/microchip_pfsoc.c               |  54 ++++-----
 hw/riscv/opentitan.c                     |  52 ++++----
 hw/riscv/sifive_e.c                      |  12 +-
 hw/riscv/sifive_u.c                      |   6 +-
 hw/riscv/tt_atlantis.c                   |   2 +-
 hw/sparc/sun4m.c                         |   8 +-
 hw/sparc64/niagara.c                     |   3 +-
 include/hw/misc/unimp.h                  |   9 +-
 36 files changed, 557 insertions(+), 543 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index cbc0b38986..8b37fd61f3 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -131,7 +131,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     memory_region_init_ram(&s->sram_a, OBJECT(dev), "sram A", 48 * KiB,
                            &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0x00000000, &s->sram_a);
-    create_unimplemented_device("a10-sram-ctrl", 0x01c00000, 4 * KiB);
+    create_unimplemented_device(OBJECT(dev), "a10-sram-ctrl", 0x01c00000, 4 * KiB);
 
     /* Clock Control Module */
     sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &error_fatal);
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 6f9a07610f..711bfae095 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -468,7 +468,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
 
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(unimplemented); i++) {
-        create_unimplemented_device(unimplemented[i].device_name,
+        create_unimplemented_device(OBJECT(dev), unimplemented[i].device_name,
                                     unimplemented[i].base,
                                     unimplemented[i].size);
     }
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 4f9d8a606e..9c15d361b4 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -532,7 +532,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
 
     /* Unimplemented devices */
     for (unsigned i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
-        create_unimplemented_device(r40_unimplemented[i].device_name,
+        create_unimplemented_device(OBJECT(dev), r40_unimplemented[i].device_name,
                                     r40_unimplemented[i].base,
                                     r40_unimplemented[i].size);
     }
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 44046953be..f0fbdc1a68 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -471,7 +471,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     /*
      * PCIe PHY
      */
-    create_unimplemented_device("pcie-phy", FSL_IMX6_PCIe_ADDR,
+    create_unimplemented_device(OBJECT(dev), "pcie-phy", FSL_IMX6_PCIe_ADDR,
                                 FSL_IMX6_PCIe_SIZE);
 
     /* ROM memory */
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..adbb896fd1 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -161,6 +161,7 @@ static void fsl_imx6ul_init(Object *obj)
 
 static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(dev);
     DeviceState *mpcore = DEVICE(&s->a7mpcore);
@@ -198,37 +199,37 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE DAP
      */
-    create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
     /*
      * MMDC
      */
-    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
                                 FSL_IMX6UL_MMDC_CFG_SIZE);
 
     /*
      * OCOTP
      */
-    create_unimplemented_device("a7mpcore-ocotp", FSL_IMX6UL_OCOTP_CTRL_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-ocotp", FSL_IMX6UL_OCOTP_CTRL_ADDR,
                                 FSL_IMX6UL_OCOTP_CTRL_SIZE);
 
     /*
      * QSPI
      */
-    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_QSPI_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-qspi", FSL_IMX6UL_QSPI_ADDR,
                                 FSL_IMX6UL_QSPI_SIZE);
 
     /*
      * CAAM
      */
-    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_CAAM_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-qspi", FSL_IMX6UL_CAAM_ADDR,
                                 FSL_IMX6UL_CAAM_SIZE);
 
     /*
      * USBMISC
      */
-    create_unimplemented_device("a7mpcore-usbmisc", FSL_IMX6UL_USBO2_USBMISC_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-usbmisc", FSL_IMX6UL_USBO2_USBMISC_ADDR,
                                 FSL_IMX6UL_USBO2_USBMISC_SIZE);
 
     /*
@@ -322,9 +323,9 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * IOMUXC
      */
-    create_unimplemented_device("iomuxc", FSL_IMX6UL_IOMUXC_ADDR,
+    create_unimplemented_device(obj, "iomuxc", FSL_IMX6UL_IOMUXC_ADDR,
                                 FSL_IMX6UL_IOMUXC_SIZE);
-    create_unimplemented_device("iomuxc_gpr", FSL_IMX6UL_IOMUXC_GPR_ADDR,
+    create_unimplemented_device(obj, "iomuxc_gpr", FSL_IMX6UL_IOMUXC_GPR_ADDR,
                                 FSL_IMX6UL_IOMUXC_GPR_SIZE);
 
     /*
@@ -581,7 +582,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * SDMA
      */
-    create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR,
+    create_unimplemented_device(obj, "sdma", FSL_IMX6UL_SDMA_ADDR,
                                 FSL_IMX6UL_SDMA_SIZE);
 
     /*
@@ -595,7 +596,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "sai%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_SAIn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX6UL_SAIn_ADDR[i],
                                     FSL_IMX6UL_SAIn_SIZE);
     }
 
@@ -615,14 +616,14 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "pwm%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_PWMn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX6UL_PWMn_ADDR[i],
                                     FSL_IMX6UL_PWMn_SIZE);
     }
 
     /*
      * Audio ASRC (asynchronous sample rate converter)
      */
-    create_unimplemented_device("asrc", FSL_IMX6UL_ASRC_ADDR,
+    create_unimplemented_device(obj, "asrc", FSL_IMX6UL_ASRC_ADDR,
                                 FSL_IMX6UL_ASRC_SIZE);
 
     /*
@@ -635,14 +636,14 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "can%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_CANn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX6UL_CANn_ADDR[i],
                                     FSL_IMX6UL_CANn_SIZE);
     }
 
     /*
      * APHB_DMA
      */
-    create_unimplemented_device("aphb_dma", FSL_IMX6UL_APBH_DMA_ADDR,
+    create_unimplemented_device(obj, "aphb_dma", FSL_IMX6UL_APBH_DMA_ADDR,
                                 FSL_IMX6UL_APBH_DMA_SIZE);
 
     /*
@@ -655,7 +656,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "adc%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_ADCn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX6UL_ADCn_ADDR[i],
                                     FSL_IMX6UL_ADCn_SIZE);
     }
 
@@ -670,13 +671,13 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * CSU
      */
-    create_unimplemented_device("csu", FSL_IMX6UL_CSU_ADDR,
+    create_unimplemented_device(obj, "csu", FSL_IMX6UL_CSU_ADDR,
                                 FSL_IMX6UL_CSU_SIZE);
 
     /*
      * TZASC
      */
-    create_unimplemented_device("tzasc", FSL_IMX6UL_TZASC_ADDR,
+    create_unimplemented_device(obj, "tzasc", FSL_IMX6UL_TZASC_ADDR,
                                 FSL_IMX6UL_TZASC_SIZE);
 
     /*
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 2defa498d3..07a5ae8cd0 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -154,6 +154,7 @@ static void fsl_imx7_init(Object *obj)
 
 static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(dev);
     DeviceState *mpcore = DEVICE(&s->a7mpcore);
@@ -229,7 +230,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE DAP
      */
-    create_unimplemented_device("a7mpcore-dap", FSL_IMX7_A7MPCORE_DAP_ADDR,
+    create_unimplemented_device(obj, "a7mpcore-dap", FSL_IMX7_A7MPCORE_DAP_ADDR,
                                 FSL_IMX7_A7MPCORE_DAP_SIZE);
 
     /*
@@ -305,9 +306,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * IOMUXC and IOMUXC_LPSR
      */
-    create_unimplemented_device("iomuxc", FSL_IMX7_IOMUXC_ADDR,
+    create_unimplemented_device(obj, "iomuxc", FSL_IMX7_IOMUXC_ADDR,
                                 FSL_IMX7_IOMUXC_SIZE);
-    create_unimplemented_device("iomuxc_lspr", FSL_IMX7_IOMUXC_LPSR_ADDR,
+    create_unimplemented_device(obj, "iomuxc_lspr", FSL_IMX7_IOMUXC_LPSR_ADDR,
                                 FSL_IMX7_IOMUXC_LPSR_SIZE);
 
     /*
@@ -520,12 +521,12 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * SDMA
      */
-    create_unimplemented_device("sdma", FSL_IMX7_SDMA_ADDR, FSL_IMX7_SDMA_SIZE);
+    create_unimplemented_device(obj, "sdma", FSL_IMX7_SDMA_ADDR, FSL_IMX7_SDMA_SIZE);
 
     /*
      * CAAM
      */
-    create_unimplemented_device("caam", FSL_IMX7_CAAM_ADDR, FSL_IMX7_CAAM_SIZE);
+    create_unimplemented_device(obj, "caam", FSL_IMX7_CAAM_ADDR, FSL_IMX7_CAAM_SIZE);
 
     /*
      * PWMs
@@ -539,7 +540,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "pwm%d", i);
-        create_unimplemented_device(name, FSL_IMX7_PWMn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX7_PWMn_ADDR[i],
                                     FSL_IMX7_PWMn_SIZE);
     }
 
@@ -553,7 +554,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "can%d", i);
-        create_unimplemented_device(name, FSL_IMX7_CANn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX7_CANn_ADDR[i],
                                     FSL_IMX7_CANn_SIZE);
     }
 
@@ -568,14 +569,14 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "sai%d", i);
-        create_unimplemented_device(name, FSL_IMX7_SAIn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX7_SAIn_ADDR[i],
                                     FSL_IMX7_SAIn_SIZE);
     }
 
     /*
      * OCOTP
      */
-    create_unimplemented_device("ocotp", FSL_IMX7_OCOTP_ADDR,
+    create_unimplemented_device(obj, "ocotp", FSL_IMX7_OCOTP_ADDR,
                                 FSL_IMX7_OCOTP_SIZE);
 
     /*
@@ -638,7 +639,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0, irq);
 
         snprintf(name, NAME_SIZE, "usbmisc%d", i);
-        create_unimplemented_device(name, FSL_IMX7_USBMISCn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX7_USBMISCn_ADDR[i],
                                     FSL_IMX7_USBMISCn_SIZE);
     }
 
@@ -652,37 +653,37 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "adc%d", i);
-        create_unimplemented_device(name, FSL_IMX7_ADCn_ADDR[i],
+        create_unimplemented_device(obj, name, FSL_IMX7_ADCn_ADDR[i],
                                     FSL_IMX7_ADCn_SIZE);
     }
 
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX7_LCDIF_ADDR,
+    create_unimplemented_device(obj, "lcdif", FSL_IMX7_LCDIF_ADDR,
                                 FSL_IMX7_LCDIF_SIZE);
 
     /*
      * DMA APBH
      */
-    create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
+    create_unimplemented_device(obj, "dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
                                 FSL_IMX7_DMA_APBH_SIZE);
     /*
      * PCIe PHY
      */
-    create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
+    create_unimplemented_device(obj, "pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
                                 FSL_IMX7_PCIE_PHY_SIZE);
 
     /*
      * CSU
      */
-    create_unimplemented_device("csu", FSL_IMX7_CSU_ADDR,
+    create_unimplemented_device(obj, "csu", FSL_IMX7_CSU_ADDR,
                                 FSL_IMX7_CSU_SIZE);
 
     /*
      * TZASC
      */
-    create_unimplemented_device("tzasc", FSL_IMX7_TZASC_ADDR,
+    create_unimplemented_device(obj, "tzasc", FSL_IMX7_TZASC_ADDR,
                                 FSL_IMX7_TZASC_SIZE);
 
     /*
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 875e92bb34..a38298c4a6 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -669,7 +669,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
             break;
 
         default:
-            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
+            create_unimplemented_device(OBJECT(dev), fsl_imx8mm_memmap[i].name,
                                         fsl_imx8mm_memmap[i].addr,
                                         fsl_imx8mm_memmap[i].size);
             break;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9..c5bace6605 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -738,7 +738,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             break;
 
         default:
-            create_unimplemented_device(fsl_imx8mp_memmap[i].name,
+            create_unimplemented_device(OBJECT(dev), fsl_imx8mp_memmap[i].name,
                                         fsl_imx8mp_memmap[i].addr,
                                         fsl_imx8mp_memmap[i].size);
             break;
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 321e63723e..b8e0265de2 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -52,6 +52,7 @@ static void max78000_soc_initfn(Object *obj)
 
 static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
+    Object *obj = OBJECT(dev_soc);
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *gcrdev, *armv7m;
@@ -146,52 +147,52 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
 
-    create_unimplemented_device("systemInterface",      0x40000400, 0x400);
-    create_unimplemented_device("functionControl",      0x40000800, 0x400);
-    create_unimplemented_device("watchdogTimer0",       0x40003000, 0x400);
-    create_unimplemented_device("dynamicVoltScale",     0x40003c00, 0x40);
-    create_unimplemented_device("SIMO",                 0x40004400, 0x400);
-    create_unimplemented_device("trimSystemInit",       0x40005400, 0x400);
-    create_unimplemented_device("generalCtrlFunc",      0x40005800, 0x400);
-    create_unimplemented_device("wakeupTimer",          0x40006400, 0x400);
-    create_unimplemented_device("powerSequencer",       0x40006800, 0x400);
-    create_unimplemented_device("miscControl",          0x40006c00, 0x400);
-
-    create_unimplemented_device("gpio0",                0x40008000, 0x1000);
-    create_unimplemented_device("gpio1",                0x40009000, 0x1000);
-
-    create_unimplemented_device("parallelCamInterface", 0x4000e000, 0x1000);
-    create_unimplemented_device("CRC",                  0x4000f000, 0x1000);
-
-    create_unimplemented_device("timer0",               0x40010000, 0x1000);
-    create_unimplemented_device("timer1",               0x40011000, 0x1000);
-    create_unimplemented_device("timer2",               0x40012000, 0x1000);
-    create_unimplemented_device("timer3",               0x40013000, 0x1000);
-
-    create_unimplemented_device("i2c0",                 0x4001d000, 0x1000);
-    create_unimplemented_device("i2c1",                 0x4001e000, 0x1000);
-    create_unimplemented_device("i2c2",                 0x4001f000, 0x1000);
-
-    create_unimplemented_device("standardDMA",          0x40028000, 0x1000);
-    create_unimplemented_device("flashController0",     0x40029000, 0x400);
-
-    create_unimplemented_device("adc",                  0x40034000, 0x1000);
-    create_unimplemented_device("pulseTrainEngine",     0x4003c000, 0xa0);
-    create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
-    create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
-
-    create_unimplemented_device("spi1",                 0x40046000, 0x2000);
-    create_unimplemented_device("i2s",                  0x40060000, 0x1000);
-    create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
-    create_unimplemented_device("gpio2",                0x40080400, 0x200);
-    create_unimplemented_device("lowPowerWatchdogTimer",    0x40080800, 0x400);
-    create_unimplemented_device("lowPowerTimer4",       0x40080c00, 0x400);
-
-    create_unimplemented_device("lowPowerTimer5",       0x40081000, 0x400);
-    create_unimplemented_device("lowPowerUART0",        0x40081400, 0x400);
-    create_unimplemented_device("lowPowerComparator",   0x40088000, 0x400);
-
-    create_unimplemented_device("spi0",                 0x400be000, 0x400);
+    create_unimplemented_device(obj, "systemInterface",      0x40000400, 0x400);
+    create_unimplemented_device(obj, "functionControl",      0x40000800, 0x400);
+    create_unimplemented_device(obj, "watchdogTimer0",       0x40003000, 0x400);
+    create_unimplemented_device(obj, "dynamicVoltScale",     0x40003c00, 0x40);
+    create_unimplemented_device(obj, "SIMO",                 0x40004400, 0x400);
+    create_unimplemented_device(obj, "trimSystemInit",       0x40005400, 0x400);
+    create_unimplemented_device(obj, "generalCtrlFunc",      0x40005800, 0x400);
+    create_unimplemented_device(obj, "wakeupTimer",          0x40006400, 0x400);
+    create_unimplemented_device(obj, "powerSequencer",       0x40006800, 0x400);
+    create_unimplemented_device(obj, "miscControl",          0x40006c00, 0x400);
+
+    create_unimplemented_device(obj, "gpio0",                0x40008000, 0x1000);
+    create_unimplemented_device(obj, "gpio1",                0x40009000, 0x1000);
+
+    create_unimplemented_device(obj, "parallelCamInterface", 0x4000e000, 0x1000);
+    create_unimplemented_device(obj, "CRC",                  0x4000f000, 0x1000);
+
+    create_unimplemented_device(obj, "timer0",               0x40010000, 0x1000);
+    create_unimplemented_device(obj, "timer1",               0x40011000, 0x1000);
+    create_unimplemented_device(obj, "timer2",               0x40012000, 0x1000);
+    create_unimplemented_device(obj, "timer3",               0x40013000, 0x1000);
+
+    create_unimplemented_device(obj, "i2c0",                 0x4001d000, 0x1000);
+    create_unimplemented_device(obj, "i2c1",                 0x4001e000, 0x1000);
+    create_unimplemented_device(obj, "i2c2",                 0x4001f000, 0x1000);
+
+    create_unimplemented_device(obj, "standardDMA",          0x40028000, 0x1000);
+    create_unimplemented_device(obj, "flashController0",     0x40029000, 0x400);
+
+    create_unimplemented_device(obj, "adc",                  0x40034000, 0x1000);
+    create_unimplemented_device(obj, "pulseTrainEngine",     0x4003c000, 0xa0);
+    create_unimplemented_device(obj, "oneWireMaster",        0x4003d000, 0x1000);
+    create_unimplemented_device(obj, "semaphore",            0x4003e000, 0x1000);
+
+    create_unimplemented_device(obj, "spi1",                 0x40046000, 0x2000);
+    create_unimplemented_device(obj, "i2s",                  0x40060000, 0x1000);
+    create_unimplemented_device(obj, "lowPowerControl",      0x40080000, 0x400);
+    create_unimplemented_device(obj, "gpio2",                0x40080400, 0x200);
+    create_unimplemented_device(obj, "lowPowerWatchdogTimer",    0x40080800, 0x400);
+    create_unimplemented_device(obj, "lowPowerTimer4",       0x40080c00, 0x400);
+
+    create_unimplemented_device(obj, "lowPowerTimer5",       0x40081000, 0x400);
+    create_unimplemented_device(obj, "lowPowerUART0",        0x40081400, 0x400);
+    create_unimplemented_device(obj, "lowPowerComparator",   0x40088000, 0x400);
+
+    create_unimplemented_device(obj, "spi0",                 0x400be000, 0x400);
 
     /*
      * The MAX78000 user guide's base address map lists the CNN TX FIFO as
@@ -199,13 +200,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
      * is listed as having data accessible up to offset 0x1000, the user
      * guide is likely incorrect.
      */
-    create_unimplemented_device("cnnTxFIFO",            0x400c0400, 0x2000);
+    create_unimplemented_device(obj, "cnnTxFIFO",            0x400c0400, 0x2000);
 
-    create_unimplemented_device("cnnGlobalControl",     0x50000000, 0x10000);
-    create_unimplemented_device("cnnx16quad0",          0x50100000, 0x40000);
-    create_unimplemented_device("cnnx16quad1",          0x50500000, 0x40000);
-    create_unimplemented_device("cnnx16quad2",          0x50900000, 0x40000);
-    create_unimplemented_device("cnnx16quad3",          0x50d00000, 0x40000);
+    create_unimplemented_device(obj, "cnnGlobalControl",     0x50000000, 0x10000);
+    create_unimplemented_device(obj, "cnnx16quad0",          0x50100000, 0x40000);
+    create_unimplemented_device(obj, "cnnx16quad1",          0x50500000, 0x40000);
+    create_unimplemented_device(obj, "cnnx16quad2",          0x50900000, 0x40000);
+    create_unimplemented_device(obj, "cnnx16quad3",          0x50d00000, 0x40000);
 
 }
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 17945d2b71..32e3db1134 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -800,6 +800,7 @@ static uint32_t boot_ram_size(MPS2TZMachineState *mms)
 
 static void mps2tz_common_init(MachineState *machine)
 {
+    Object *obj = OBJECT(machine);
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1193,11 +1194,11 @@ static void mps2tz_common_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
 
-    create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
+    create_unimplemented_device(obj, "FPGA NS PC", 0x48007000, 0x1000);
 
     if (mmc->fpga_type == FPGA_AN547) {
-        create_unimplemented_device("U55 timing adapter 0", 0x48102000, 0x1000);
-        create_unimplemented_device("U55 timing adapter 1", 0x48103000, 0x1000);
+        create_unimplemented_device(obj, "U55 timing adapter 0", 0x48102000, 0x1000);
+        create_unimplemented_device(obj, "U55 timing adapter 1", 0x48103000, 0x1000);
     }
 
     create_non_mpc_ram(mms);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 2edd222674..23a814e4e4 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -135,6 +135,7 @@ static void make_ram_alias(MemoryRegion *mr, const char *name,
 
 static void mps2_common_init(MachineState *machine)
 {
+    Object *obj = OBJECT(machine);
     MPS2MachineState *mms = MPS2_MACHINE(machine);
     MPS2MachineClass *mmc = MPS2_MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
@@ -246,25 +247,25 @@ static void mps2_common_init(MachineState *machine)
                              OBJECT(system_memory), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&mms->armv7m), &error_fatal);
 
-    create_unimplemented_device("zbtsmram mirror", 0x00400000, 0x00400000);
-    create_unimplemented_device("RESERVED 1", 0x00800000, 0x00800000);
-    create_unimplemented_device("Block RAM", 0x01000000, 0x00010000);
-    create_unimplemented_device("RESERVED 2", 0x01010000, 0x1EFF0000);
-    create_unimplemented_device("RESERVED 3", 0x20800000, 0x00800000);
-    create_unimplemented_device("PSRAM", 0x21000000, 0x01000000);
+    create_unimplemented_device(obj, "zbtsmram mirror", 0x00400000, 0x00400000);
+    create_unimplemented_device(obj, "RESERVED 1", 0x00800000, 0x00800000);
+    create_unimplemented_device(obj, "Block RAM", 0x01000000, 0x00010000);
+    create_unimplemented_device(obj, "RESERVED 2", 0x01010000, 0x1EFF0000);
+    create_unimplemented_device(obj, "RESERVED 3", 0x20800000, 0x00800000);
+    create_unimplemented_device(obj, "PSRAM", 0x21000000, 0x01000000);
     /* These three ranges all cover multiple devices; we may implement
      * some of them below (in which case the real device takes precedence
      * over the unimplemented-region mapping).
      */
-    create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
+    create_unimplemented_device(obj, "CMSDK APB peripheral region @0x40000000",
                                 0x40000000, 0x00010000);
-    create_unimplemented_device("CMSDK AHB peripheral region @0x40010000",
+    create_unimplemented_device(obj, "CMSDK AHB peripheral region @0x40010000",
                                 0x40010000, 0x00010000);
-    create_unimplemented_device("Extra peripheral region @0x40020000",
+    create_unimplemented_device(obj, "Extra peripheral region @0x40020000",
                                 0x40020000, 0x00010000);
 
-    create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
-    create_unimplemented_device("VGA", 0x41000000, 0x0200000);
+    create_unimplemented_device(obj, "RESERVED 4", 0x40030000, 0x001D0000);
+    create_unimplemented_device(obj, "VGA", 0x41000000, 0x0200000);
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
@@ -362,7 +363,7 @@ static void mps2_common_init(MachineState *machine)
     for (i = 0; i < 4; i++) {
         static const hwaddr gpiobase[] = {0x40010000, 0x40011000,
                                           0x40012000, 0x40013000};
-        create_unimplemented_device("cmsdk-ahb-gpio", gpiobase[i], 0x1000);
+        create_unimplemented_device(obj, "cmsdk-ahb-gpio", gpiobase[i], 0x1000);
     }
 
     /* CMSDK APB subsystem */
@@ -458,7 +459,7 @@ static void mps2_common_init(MachineState *machine)
             qbus_mark_full(qbus);
         }
     }
-    create_unimplemented_device("i2s", 0x40024000, 0x400);
+    create_unimplemented_device(obj, "i2s", 0x40024000, 0x400);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 8e249c9b9d..4d432de6ba 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -458,7 +458,7 @@ static void mps3r_common_init(MachineState *machine)
     for (int i = 0; i < 4; i++) {
         /* CMSDK GPIO controllers */
         g_autofree char *s = g_strdup_printf("gpio%d", i);
-        create_unimplemented_device(s, 0xe0000000 + i * 0x1000, 0x1000);
+        create_unimplemented_device(OBJECT(machine), s, 0xe0000000 + i * 0x1000, 0x1000);
     }
 
     object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
@@ -526,7 +526,7 @@ static void mps3r_common_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->scc), 0, 0xe0200000);
 
-    create_unimplemented_device("i2s-audio", 0xe0201000, 0x1000);
+    create_unimplemented_device(OBJECT(machine), "i2s-audio", 0xe0201000, 0x1000);
 
     object_initialize_child(OBJECT(mms), "fpgaio", &mms->fpgaio,
                             TYPE_MPS2_FPGAIO);
@@ -537,7 +537,7 @@ static void mps3r_common_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0xe0202000);
 
-    create_unimplemented_device("clcd", 0xe0209000, 0x1000);
+    create_unimplemented_device(OBJECT(machine), "clcd", 0xe0209000, 0x1000);
 
     object_initialize_child(OBJECT(mms), "rtc", &mms->rtc, TYPE_PL031);
     sysbus_realize(SYS_BUS_DEVICE(&mms->rtc), &error_fatal);
@@ -552,8 +552,8 @@ static void mps3r_common_init(MachineState *machine)
     lan9118_init(OBJECT(machine), 0xe0300000,
                  qdev_get_gpio_in(gicdev, 18));
 
-    create_unimplemented_device("usb", 0xe0301000, 0x1000);
-    create_unimplemented_device("qspi-write-config", 0xe0600000, 0x1000);
+    create_unimplemented_device(OBJECT(machine), "usb", 0xe0301000, 0x1000);
+    create_unimplemented_device(OBJECT(machine), "qspi-write-config", 0xe0600000, 0x1000);
 
     mms->bootinfo.ram_size = machine->ram_size;
     mms->bootinfo.board_id = -1;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 76eba752bd..c03778c439 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -210,16 +210,16 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
                        qdev_get_gpio_in(armv7m, MSF2_EMAC_IRQ));
 
     /* Below devices are not modelled yet. */
-    create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
-    create_unimplemented_device("dma", 0x40003000, 0x1000);
-    create_unimplemented_device("watchdog", 0x40005000, 0x1000);
-    create_unimplemented_device("i2c_1", 0x40012000, 0x1000);
-    create_unimplemented_device("gpio", 0x40013000, 0x1000);
-    create_unimplemented_device("hs-dma", 0x40014000, 0x1000);
-    create_unimplemented_device("can", 0x40015000, 0x1000);
-    create_unimplemented_device("rtc", 0x40017000, 0x1000);
-    create_unimplemented_device("apb_config", 0x40020000, 0x10000);
-    create_unimplemented_device("usb", 0x40043000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "i2c_0", 0x40002000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "dma", 0x40003000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "watchdog", 0x40005000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "i2c_1", 0x40012000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "gpio", 0x40013000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "hs-dma", 0x40014000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "can", 0x40015000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "rtc", 0x40017000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "apb_config", 0x40020000, 0x10000);
+    create_unimplemented_device(OBJECT(dev_soc), "usb", 0x40043000, 0x1000);
 }
 
 static const Property m2sxxx_soc_properties[] = {
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index a930f7843a..1ee8820070 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -479,6 +479,7 @@ static void npcm7xx_init(Object *obj)
 
 static void npcm7xx_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
     NPCM7xxState *s = NPCM7XX(dev);
     NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
     int i;
@@ -600,30 +601,30 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* GPIO modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_gpio) != ARRAY_SIZE(s->gpio));
     for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
-        Object *obj = OBJECT(&s->gpio[i]);
+        Object *gobj = OBJECT(&s->gpio[i]);
 
-        object_property_set_uint(obj, "reset-pullup",
+        object_property_set_uint(gobj, "reset-pullup",
                                  npcm7xx_gpio[i].reset_pu, &error_abort);
-        object_property_set_uint(obj, "reset-pulldown",
+        object_property_set_uint(gobj, "reset-pulldown",
                                  npcm7xx_gpio[i].reset_pd, &error_abort);
-        object_property_set_uint(obj, "reset-osrc",
+        object_property_set_uint(gobj, "reset-osrc",
                                  npcm7xx_gpio[i].reset_osrc, &error_abort);
-        object_property_set_uint(obj, "reset-odsc",
+        object_property_set_uint(gobj, "reset-odsc",
                                  npcm7xx_gpio[i].reset_odsc, &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
-        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm7xx_gpio[i].regs_addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+        sysbus_realize(SYS_BUS_DEVICE(gobj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(gobj), 0, npcm7xx_gpio[i].regs_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(gobj), 0,
                            npcm7xx_irq(s, NPCM7XX_GPIO0_IRQ + i));
     }
 
     /* SMBus modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_smbus_addr) != ARRAY_SIZE(s->smbus));
     for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
-        Object *obj = OBJECT(&s->smbus[i]);
+        Object *sobj = OBJECT(&s->smbus[i]);
 
-        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
-        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm7xx_smbus_addr[i]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+        sysbus_realize(SYS_BUS_DEVICE(sobj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(sobj), 0, npcm7xx_smbus_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(sobj), 0,
                            npcm7xx_irq(s, NPCM7XX_SMBUS0_IRQ + i));
     }
 
@@ -781,39 +782,39 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, 0, npcm7xx_irq(s, irq));
     }
 
-    create_unimplemented_device("npcm7xx.shm",          0xc0001000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.vdmx",         0xe0800000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.pcierc",       0xe1000000,  64 * KiB);
-    create_unimplemented_device("npcm7xx.kcs",          0xf0007000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.gfxi",         0xf000e000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.espi",         0xf009f000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.peci",         0xf0100000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.siox[1]",      0xf0101000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.siox[2]",      0xf0102000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.ahbpci",       0xf0400000,   1 * MiB);
-    create_unimplemented_device("npcm7xx.mcphy",        0xf05f0000,  64 * KiB);
-    create_unimplemented_device("npcm7xx.vcd",          0xf0810000,  64 * KiB);
-    create_unimplemented_device("npcm7xx.ece",          0xf0820000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.vdma",         0xf0822000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[0]",      0xf0830000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[1]",      0xf0831000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[2]",      0xf0832000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[3]",      0xf0833000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[4]",      0xf0834000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[5]",      0xf0835000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[6]",      0xf0836000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[7]",      0xf0837000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.sd",           0xf0840000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
-    create_unimplemented_device("npcm7xx.aes",          0xf0858000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.des",          0xf0859000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.sha",          0xf085a000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.secacc",       0xf085b000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.spixcs0",      0xf8000000,  16 * MiB);
-    create_unimplemented_device("npcm7xx.spixcs1",      0xf9000000,  16 * MiB);
-    create_unimplemented_device("npcm7xx.spix",         0xfb001000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.shm",          0xc0001000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.vdmx",         0xe0800000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.pcierc",       0xe1000000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.kcs",          0xf0007000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.gfxi",         0xf000e000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.espi",         0xf009f000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.peci",         0xf0100000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.siox[1]",      0xf0101000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.siox[2]",      0xf0102000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.ahbpci",       0xf0400000,   1 * MiB);
+    create_unimplemented_device(obj, "npcm7xx.mcphy",        0xf05f0000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.vcd",          0xf0810000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.ece",          0xf0820000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.vdma",         0xf0822000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[0]",      0xf0830000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[1]",      0xf0831000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[2]",      0xf0832000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[3]",      0xf0833000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[4]",      0xf0834000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[5]",      0xf0835000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[6]",      0xf0836000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[7]",      0xf0837000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.sd",           0xf0840000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.aes",          0xf0858000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.des",          0xf0859000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.sha",          0xf085a000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.secacc",       0xf085b000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm7xx.spixcs0",      0xf8000000,  16 * MiB);
+    create_unimplemented_device(obj, "npcm7xx.spixcs1",      0xf9000000,  16 * MiB);
+    create_unimplemented_device(obj, "npcm7xx.spix",         0xfb001000,   4 * KiB);
 }
 
 static const Property npcm7xx_properties[] = {
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 48fcc65a98..c7c371cac6 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -471,6 +471,7 @@ static void npcm8xx_init(Object *obj)
 
 static void npcm8xx_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
     NPCM8xxState *s = NPCM8XX(dev);
     NPCM8xxClass *nc = NPCM8XX_GET_CLASS(s);
     int i;
@@ -614,30 +615,30 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     /* GPIO modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gpio) != ARRAY_SIZE(s->gpio));
     for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
-        Object *obj = OBJECT(&s->gpio[i]);
+        Object *gobj = OBJECT(&s->gpio[i]);
 
-        object_property_set_uint(obj, "reset-pullup",
+        object_property_set_uint(gobj, "reset-pullup",
                                  npcm8xx_gpio[i].reset_pu, &error_abort);
-        object_property_set_uint(obj, "reset-pulldown",
+        object_property_set_uint(gobj, "reset-pulldown",
                                  npcm8xx_gpio[i].reset_pd, &error_abort);
-        object_property_set_uint(obj, "reset-osrc",
+        object_property_set_uint(gobj, "reset-osrc",
                                  npcm8xx_gpio[i].reset_osrc, &error_abort);
-        object_property_set_uint(obj, "reset-odsc",
+        object_property_set_uint(gobj, "reset-odsc",
                                  npcm8xx_gpio[i].reset_odsc, &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
-        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm8xx_gpio[i].regs_addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+        sysbus_realize(SYS_BUS_DEVICE(gobj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(gobj), 0, npcm8xx_gpio[i].regs_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(gobj), 0,
                            npcm8xx_irq(s, NPCM8XX_GPIO0_IRQ + i));
     }
 
     /* SMBus modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_smbus_addr) != ARRAY_SIZE(s->smbus));
     for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
-        Object *obj = OBJECT(&s->smbus[i]);
+        Object *sobj = OBJECT(&s->smbus[i]);
 
-        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
-        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm8xx_smbus_addr[i]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+        sysbus_realize(SYS_BUS_DEVICE(sobj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(sobj), 0, npcm8xx_smbus_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(sobj), 0,
                            npcm8xx_irq(s, NPCM8XX_SMBUS0_IRQ + i));
     }
 
@@ -766,66 +767,66 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pspi), 0,
             npcm8xx_irq(s, NPCM8XX_PSPI_IRQ));
 
-    create_unimplemented_device("npcm8xx.shm",          0xc0001000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
-    create_unimplemented_device("npcm8xx.vdmx",         0xe0800000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.pcierc",       0xe1000000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.rootc",        0xe8000000, 128 * MiB);
-    create_unimplemented_device("npcm8xx.kcs",          0xf0007000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.gfxi",         0xf000e000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.fsw",          0xf000f000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.bt",           0xf0030000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.espi",         0xf009f000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.peci",         0xf0100000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.siox[1]",      0xf0101000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.siox[2]",      0xf0102000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.tmps",         0xf0188000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.viru1",        0xf0204000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.viru2",        0xf0205000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.jtm1",         0xf0208000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.jtm2",         0xf0209000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.flm0",         0xf0210000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.flm1",         0xf0211000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.flm2",         0xf0212000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.flm3",         0xf0213000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.ahbpci",       0xf0400000,   1 * MiB);
-    create_unimplemented_device("npcm8xx.dap",          0xf0500000, 960 * KiB);
-    create_unimplemented_device("npcm8xx.mcphy",        0xf05f0000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.tsgen",        0xf07fc000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.copctl",       0xf080c000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.tipctl",       0xf080d000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.rst",          0xf080e000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.vcd",          0xf0810000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.ece",          0xf0820000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.vdma",         0xf0822000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[0]",      0xf0830000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[1]",      0xf0831000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[2]",      0xf0832000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[3]",      0xf0833000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[4]",      0xf0834000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[5]",      0xf0835000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[6]",      0xf0836000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[7]",      0xf0837000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[8]",      0xf0838000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.usbd[9]",      0xf0839000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.pci_mbox1",    0xf0848000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.gdma0",        0xf0850000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.gdma1",        0xf0851000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.gdma2",        0xf0852000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.aes",          0xf0858000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.des",          0xf0859000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.sha",          0xf085a000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.pci_mbox2",    0xf0868000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.i3c0",         0xfff10000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.i3c1",         0xfff11000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.i3c2",         0xfff12000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.i3c3",         0xfff13000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.i3c4",         0xfff14000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.i3c5",         0xfff15000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.spixcs0",      0xf8000000,  16 * MiB);
-    create_unimplemented_device("npcm8xx.spixcs1",      0xf9000000,  16 * MiB);
-    create_unimplemented_device("npcm8xx.spix",         0xfb001000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.vect",         0xffff0000,   256);
+    create_unimplemented_device(obj, "npcm8xx.shm",          0xc0001000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.vdmx",         0xe0800000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.pcierc",       0xe1000000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.rootc",        0xe8000000, 128 * MiB);
+    create_unimplemented_device(obj, "npcm8xx.kcs",          0xf0007000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.gfxi",         0xf000e000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.fsw",          0xf000f000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.bt",           0xf0030000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.espi",         0xf009f000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.peci",         0xf0100000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.siox[1]",      0xf0101000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.siox[2]",      0xf0102000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.tmps",         0xf0188000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.viru1",        0xf0204000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.viru2",        0xf0205000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.jtm1",         0xf0208000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.jtm2",         0xf0209000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.flm0",         0xf0210000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.flm1",         0xf0211000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.flm2",         0xf0212000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.flm3",         0xf0213000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.ahbpci",       0xf0400000,   1 * MiB);
+    create_unimplemented_device(obj, "npcm8xx.dap",          0xf0500000, 960 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.mcphy",        0xf05f0000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.tsgen",        0xf07fc000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.copctl",       0xf080c000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.tipctl",       0xf080d000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.rst",          0xf080e000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.vcd",          0xf0810000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.ece",          0xf0820000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.vdma",         0xf0822000,   8 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[0]",      0xf0830000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[1]",      0xf0831000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[2]",      0xf0832000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[3]",      0xf0833000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[4]",      0xf0834000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[5]",      0xf0835000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[6]",      0xf0836000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[7]",      0xf0837000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[8]",      0xf0838000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.usbd[9]",      0xf0839000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.pci_mbox1",    0xf0848000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.gdma0",        0xf0850000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.gdma1",        0xf0851000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.gdma2",        0xf0852000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.aes",          0xf0858000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.des",          0xf0859000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.sha",          0xf085a000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.pci_mbox2",    0xf0868000,  64 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c0",         0xfff10000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c1",         0xfff11000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c2",         0xfff12000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c3",         0xfff13000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c4",         0xfff14000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.i3c5",         0xfff15000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.spixcs0",      0xf8000000,  16 * MiB);
+    create_unimplemented_device(obj, "npcm8xx.spixcs1",      0xf9000000,  16 * MiB);
+    create_unimplemented_device(obj, "npcm8xx.spix",         0xfb001000,   4 * KiB);
+    create_unimplemented_device(obj, "npcm8xx.vect",         0xffff0000,   256);
 }
 
 static const Property npcm8xx_properties[] = {
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 8d8ea71da4..f75b742242 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -171,9 +171,9 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container,
                                         NRF51_IOMEM_BASE, &s->clock, -1);
 
-    create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
+    create_unimplemented_device(OBJECT(dev_soc), "nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
-    create_unimplemented_device("nrf51_soc.private",
+    create_unimplemented_device(OBJECT(dev_soc), "nrf51_soc.private",
                                 NRF51_PRIVATE_BASE, NRF51_PRIVATE_SIZE);
 }
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b2ff6f4d97..6a732a3c11 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1381,12 +1381,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("PWM", 0x40028000, 0x1000);
-    create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
-    create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
-    create_unimplemented_device("analogue-comparator", 0x4003c000, 0x1000);
-    create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
-    create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "PWM", 0x40028000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "QEI-0", 0x4002c000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "QEI-1", 0x4002d000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "analogue-comparator", 0x4003c000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "hibernation", 0x400fc000, 0x1000);
+    create_unimplemented_device(OBJECT(ms), "flash-control", 0x400fd000, 0x1000);
 
     armv7m_load_kernel(ARMV7M(armv7m)->cpu, ms->kernel_filename, 0, flash_size);
 }
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index 2358368dba..e9e722f359 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -149,36 +149,36 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 
-    create_unimplemented_device("timer[2]",  0x40000000, 0x400);
-    create_unimplemented_device("timer[3]",  0x40000400, 0x400);
-    create_unimplemented_device("timer[4]",  0x40000800, 0x400);
-    create_unimplemented_device("timer[6]",  0x40001000, 0x400);
-    create_unimplemented_device("timer[7]",  0x40001400, 0x400);
-    create_unimplemented_device("RTC",       0x40002800, 0x400);
-    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
-    create_unimplemented_device("IWDG",      0x40003000, 0x400);
-    create_unimplemented_device("I2C1",      0x40005400, 0x400);
-    create_unimplemented_device("I2C2",      0x40005800, 0x400);
-    create_unimplemented_device("BKP",       0x40006C00, 0x400);
-    create_unimplemented_device("PWR",       0x40007000, 0x400);
-    create_unimplemented_device("DAC",       0x40007400, 0x400);
-    create_unimplemented_device("CEC",       0x40007800, 0x400);
-    create_unimplemented_device("AFIO",      0x40010000, 0x400);
-    create_unimplemented_device("EXTI",      0x40010400, 0x400);
-    create_unimplemented_device("GPIOA",     0x40010800, 0x400);
-    create_unimplemented_device("GPIOB",     0x40010C00, 0x400);
-    create_unimplemented_device("GPIOC",     0x40011000, 0x400);
-    create_unimplemented_device("GPIOD",     0x40011400, 0x400);
-    create_unimplemented_device("GPIOE",     0x40011800, 0x400);
-    create_unimplemented_device("ADC1",      0x40012400, 0x400);
-    create_unimplemented_device("timer[1]",  0x40012C00, 0x400);
-    create_unimplemented_device("timer[15]", 0x40014000, 0x400);
-    create_unimplemented_device("timer[16]", 0x40014400, 0x400);
-    create_unimplemented_device("timer[17]", 0x40014800, 0x400);
-    create_unimplemented_device("DMA",       0x40020000, 0x400);
-    create_unimplemented_device("RCC",       0x40021000, 0x400);
-    create_unimplemented_device("Flash Int", 0x40022000, 0x400);
-    create_unimplemented_device("CRC",       0x40023000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[2]",  0x40000000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[3]",  0x40000400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[4]",  0x40000800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[6]",  0x40001000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[7]",  0x40001400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RTC",       0x40002800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "WWDG",      0x40002C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "IWDG",      0x40003000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C1",      0x40005400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C2",      0x40005800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "BKP",       0x40006C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "PWR",       0x40007000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DAC",       0x40007400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CEC",       0x40007800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "AFIO",      0x40010000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "EXTI",      0x40010400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOA",     0x40010800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOB",     0x40010C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOC",     0x40011000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOD",     0x40011400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOE",     0x40011800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "ADC1",      0x40012400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[1]",  0x40012C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[15]", 0x40014000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[16]", 0x40014400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer[17]", 0x40014800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DMA",       0x40020000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RCC",       0x40021000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "Flash Int", 0x40022000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CRC",       0x40023000, 0x400);
 }
 
 static void stm32f100_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index c2bc460603..dc9b3053a5 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -254,48 +254,48 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
     }
 
-    create_unimplemented_device("timer[7]",    0x40001400, 0x400);
-    create_unimplemented_device("timer[12]",   0x40001800, 0x400);
-    create_unimplemented_device("timer[6]",    0x40001000, 0x400);
-    create_unimplemented_device("timer[13]",   0x40001C00, 0x400);
-    create_unimplemented_device("timer[14]",   0x40002000, 0x400);
-    create_unimplemented_device("RTC and BKP", 0x40002800, 0x400);
-    create_unimplemented_device("WWDG",        0x40002C00, 0x400);
-    create_unimplemented_device("IWDG",        0x40003000, 0x400);
-    create_unimplemented_device("I2S2ext",     0x40003000, 0x400);
-    create_unimplemented_device("I2S3ext",     0x40004000, 0x400);
-    create_unimplemented_device("I2C1",        0x40005400, 0x400);
-    create_unimplemented_device("I2C2",        0x40005800, 0x400);
-    create_unimplemented_device("I2C3",        0x40005C00, 0x400);
-    create_unimplemented_device("CAN1",        0x40006400, 0x400);
-    create_unimplemented_device("CAN2",        0x40006800, 0x400);
-    create_unimplemented_device("PWR",         0x40007000, 0x400);
-    create_unimplemented_device("DAC",         0x40007400, 0x400);
-    create_unimplemented_device("timer[1]",    0x40010000, 0x400);
-    create_unimplemented_device("timer[8]",    0x40010400, 0x400);
-    create_unimplemented_device("SDIO",        0x40012C00, 0x400);
-    create_unimplemented_device("timer[9]",    0x40014000, 0x400);
-    create_unimplemented_device("timer[10]",   0x40014400, 0x400);
-    create_unimplemented_device("timer[11]",   0x40014800, 0x400);
-    create_unimplemented_device("GPIOA",       0x40020000, 0x400);
-    create_unimplemented_device("GPIOB",       0x40020400, 0x400);
-    create_unimplemented_device("GPIOC",       0x40020800, 0x400);
-    create_unimplemented_device("GPIOD",       0x40020C00, 0x400);
-    create_unimplemented_device("GPIOE",       0x40021000, 0x400);
-    create_unimplemented_device("GPIOF",       0x40021400, 0x400);
-    create_unimplemented_device("GPIOG",       0x40021800, 0x400);
-    create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
-    create_unimplemented_device("GPIOI",       0x40022000, 0x400);
-    create_unimplemented_device("CRC",         0x40023000, 0x400);
-    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
-    create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
-    create_unimplemented_device("DMA1",        0x40026000, 0x400);
-    create_unimplemented_device("DMA2",        0x40026400, 0x400);
-    create_unimplemented_device("Ethernet",    0x40028000, 0x1400);
-    create_unimplemented_device("USB OTG HS",  0x40040000, 0x30000);
-    create_unimplemented_device("USB OTG FS",  0x50000000, 0x31000);
-    create_unimplemented_device("DCMI",        0x50050000, 0x400);
-    create_unimplemented_device("RNG",         0x50060800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[7]",    0x40001400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[12]",   0x40001800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[6]",    0x40001000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[13]",   0x40001C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[14]",   0x40002000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RTC and BKP", 0x40002800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "WWDG",        0x40002C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "IWDG",        0x40003000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2S2ext",     0x40003000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2S3ext",     0x40004000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C1",        0x40005400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C2",        0x40005800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C3",        0x40005C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CAN1",        0x40006400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CAN2",        0x40006800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "PWR",         0x40007000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DAC",         0x40007400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[1]",    0x40010000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[8]",    0x40010400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SDIO",        0x40012C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[9]",    0x40014000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[10]",   0x40014400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "timer-unimp[11]",   0x40014800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOA",       0x40020000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOB",       0x40020400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOC",       0x40020800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOD",       0x40020C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOE",       0x40021000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOF",       0x40021400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOG",       0x40021800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOH",       0x40021C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "GPIOI",       0x40022000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CRC",         0x40023000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "Flash Int",   0x40023C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "BKPSRAM",     0x40024000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DMA1",        0x40026000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DMA2",        0x40026400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "Ethernet",    0x40028000, 0x1400);
+    create_unimplemented_device(OBJECT(dev_soc), "USB OTG HS",  0x40040000, 0x30000);
+    create_unimplemented_device(OBJECT(dev_soc), "USB OTG FS",  0x50000000, 0x31000);
+    create_unimplemented_device(OBJECT(dev_soc), "DCMI",        0x50050000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RNG",         0x50060800, 0x400);
 }
 
 static void stm32f405_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 39b8cdf97d..d94ef49217 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -359,80 +359,80 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
                                                    EXTI_LPUART1_IRQ));
 
     /* APB1 BUS */
-    create_unimplemented_device("TIM2",      0x40000000, 0x400);
-    create_unimplemented_device("TIM3",      0x40000400, 0x400);
-    create_unimplemented_device("TIM4",      0x40000800, 0x400);
-    create_unimplemented_device("TIM5",      0x40000C00, 0x400);
-    create_unimplemented_device("TIM6",      0x40001000, 0x400);
-    create_unimplemented_device("TIM7",      0x40001400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM2",      0x40000000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM3",      0x40000400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM4",      0x40000800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM5",      0x40000C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM6",      0x40001000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM7",      0x40001400, 0x400);
     /* RESERVED:    0x40001800, 0x1000 */
-    create_unimplemented_device("RTC",       0x40002800, 0x400);
-    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
-    create_unimplemented_device("IWDG",      0x40003000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RTC",       0x40002800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "WWDG",      0x40002C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "IWDG",      0x40003000, 0x400);
     /* RESERVED:    0x40001800, 0x400 */
-    create_unimplemented_device("SPI2",      0x40003800, 0x400);
-    create_unimplemented_device("SPI3",      0x40003C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SPI2",      0x40003800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SPI3",      0x40003C00, 0x400);
     /* RESERVED:    0x40004000, 0x400 */
-    create_unimplemented_device("I2C1",      0x40005400, 0x400);
-    create_unimplemented_device("I2C2",      0x40005800, 0x400);
-    create_unimplemented_device("I2C3",      0x40005C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C1",      0x40005400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C2",      0x40005800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "I2C3",      0x40005C00, 0x400);
     /* RESERVED:    0x40006000, 0x400 */
-    create_unimplemented_device("CAN1",      0x40006400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CAN1",      0x40006400, 0x400);
     /* RESERVED:    0x40006800, 0x400 */
-    create_unimplemented_device("PWR",       0x40007000, 0x400);
-    create_unimplemented_device("DAC1",      0x40007400, 0x400);
-    create_unimplemented_device("OPAMP",     0x40007800, 0x400);
-    create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "PWR",       0x40007000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DAC1",      0x40007400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "OPAMP",     0x40007800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "LPTIM1",    0x40007C00, 0x400);
     /* RESERVED:    0x40008400, 0x400 */
-    create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SWPMI1",    0x40008800, 0x400);
     /* RESERVED:    0x40008C00, 0x800 */
-    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "LPTIM2",    0x40009400, 0x400);
     /* RESERVED:    0x40009800, 0x6800 */
 
     /* APB2 BUS */
-    create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
-    create_unimplemented_device("COMP",      0x40010200, 0x200);
+    create_unimplemented_device(OBJECT(dev_soc), "VREFBUF",   0x40010030, 0x1D0);
+    create_unimplemented_device(OBJECT(dev_soc), "COMP",      0x40010200, 0x200);
     /* RESERVED:    0x40010800, 0x1400 */
-    create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "FIREWALL",  0x40011C00, 0x400);
     /* RESERVED:    0x40012000, 0x800 */
-    create_unimplemented_device("SDMMC1",    0x40012800, 0x400);
-    create_unimplemented_device("TIM1",      0x40012C00, 0x400);
-    create_unimplemented_device("SPI1",      0x40013000, 0x400);
-    create_unimplemented_device("TIM8",      0x40013400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SDMMC1",    0x40012800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM1",      0x40012C00, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SPI1",      0x40013000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM8",      0x40013400, 0x400);
     /* RESERVED:    0x40013C00, 0x400 */
-    create_unimplemented_device("TIM15",     0x40014000, 0x400);
-    create_unimplemented_device("TIM16",     0x40014400, 0x400);
-    create_unimplemented_device("TIM17",     0x40014800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM15",     0x40014000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM16",     0x40014400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TIM17",     0x40014800, 0x400);
     /* RESERVED:    0x40014C00, 0x800 */
-    create_unimplemented_device("SAI1",      0x40015400, 0x400);
-    create_unimplemented_device("SAI2",      0x40015800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SAI1",      0x40015400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "SAI2",      0x40015800, 0x400);
     /* RESERVED:    0x40015C00, 0x400 */
-    create_unimplemented_device("DFSDM1",    0x40016000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DFSDM1",    0x40016000, 0x400);
     /* RESERVED:    0x40016400, 0x9C00 */
 
     /* AHB1 BUS */
-    create_unimplemented_device("DMA1",      0x40020000, 0x400);
-    create_unimplemented_device("DMA2",      0x40020400, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DMA1",      0x40020000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "DMA2",      0x40020400, 0x400);
     /* RESERVED:    0x40020800, 0x800 */
     /* RESERVED:    0x40021400, 0xC00 */
-    create_unimplemented_device("FLASH",     0x40022000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "FLASH",     0x40022000, 0x400);
     /* RESERVED:    0x40022400, 0xC00 */
-    create_unimplemented_device("CRC",       0x40023000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "CRC",       0x40023000, 0x400);
     /* RESERVED:    0x40023400, 0x400 */
-    create_unimplemented_device("TSC",       0x40024000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "TSC",       0x40024000, 0x400);
 
     /* RESERVED:    0x40024400, 0x7FDBC00 */
 
     /* AHB2 BUS */
     /* RESERVED:    0x48002000, 0x7FDBC00 */
-    create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
-    create_unimplemented_device("ADC",       0x50040000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "OTG_FS",    0x50000000, 0x40000);
+    create_unimplemented_device(OBJECT(dev_soc), "ADC",       0x50040000, 0x400);
     /* RESERVED:    0x50040400, 0x20400 */
-    create_unimplemented_device("RNG",       0x50060800, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "RNG",       0x50060800, 0x400);
 
     /* AHB3 BUS */
-    create_unimplemented_device("FMC",       0xA0000000, 0x1000);
-    create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
+    create_unimplemented_device(OBJECT(dev_soc), "FMC",       0xA0000000, 0x1000);
+    create_unimplemented_device(OBJECT(dev_soc), "QUADSPI",   0xA0001000, 0x400);
 }
 
 static void stm32l4x5_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 378ab532a3..30f0ce5b5f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -205,6 +205,7 @@ static void ddr_ctrl_init(Object *parent, uint32_t base)
 
 static void zynq_init(MachineState *machine)
 {
+    Object *obj = OBJECT(machine);
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
@@ -390,67 +391,67 @@ static void zynq_init(MachineState *machine)
      * Refer to the ug585-Zynq-7000-TRM manual B.3 (Module Summary) and
      * the zynq-7000.dtsi. Add placeholders for unimplemented devices.
      */
-    create_unimplemented_device("zynq.i2c0", 0xE0004000, 4 * KiB);
-    create_unimplemented_device("zynq.i2c1", 0xE0005000, 4 * KiB);
-    create_unimplemented_device("zynq.can0", 0xE0008000, 4 * KiB);
-    create_unimplemented_device("zynq.can1", 0xE0009000, 4 * KiB);
-    create_unimplemented_device("zynq.gpio", 0xE000A000, 4 * KiB);
-    create_unimplemented_device("zynq.smcc", 0xE000E000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.i2c0", 0xE0004000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.i2c1", 0xE0005000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.can0", 0xE0008000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.can1", 0xE0009000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.gpio", 0xE000A000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.smcc", 0xE000E000, 4 * KiB);
 
     /* Direct Memory Access Controller, PL330, Non-Secure Mode */
-    create_unimplemented_device("zynq.dma_ns", 0xF8004000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.dma_ns", 0xF8004000, 4 * KiB);
 
     /* System Watchdog Timer Registers */
-    create_unimplemented_device("zynq.swdt", 0xF8005000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.swdt", 0xF8005000, 4 * KiB);
 
     /* AXI_HP Interface (AFI) */
-    create_unimplemented_device("zynq.axi_hp0", 0xF8008000, 0x28);
-    create_unimplemented_device("zynq.axi_hp1", 0xF8009000, 0x28);
-    create_unimplemented_device("zynq.axi_hp2", 0xF800A000, 0x28);
-    create_unimplemented_device("zynq.axi_hp3", 0xF800B000, 0x28);
+    create_unimplemented_device(obj, "zynq.axi_hp0", 0xF8008000, 0x28);
+    create_unimplemented_device(obj, "zynq.axi_hp1", 0xF8009000, 0x28);
+    create_unimplemented_device(obj, "zynq.axi_hp2", 0xF800A000, 0x28);
+    create_unimplemented_device(obj, "zynq.axi_hp3", 0xF800B000, 0x28);
 
-    create_unimplemented_device("zynq.efuse", 0xF800d000, 0x20);
+    create_unimplemented_device(obj, "zynq.efuse", 0xF800d000, 0x20);
 
     /* Embedded Trace Buffer */
-    create_unimplemented_device("zynq.etb", 0xF8801000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.etb", 0xF8801000, 4 * KiB);
 
     /* Cross Trigger Interface, ETB and TPIU */
-    create_unimplemented_device("zynq.cti_etb_tpiu", 0xF8802000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.cti_etb_tpiu", 0xF8802000, 4 * KiB);
 
     /* Trace Port Interface Unit */
-    create_unimplemented_device("zynq.tpiu", 0xF8803000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.tpiu", 0xF8803000, 4 * KiB);
 
     /* CoreSight Trace Funnel */
-    create_unimplemented_device("zynq.funnel", 0xF8804000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.funnel", 0xF8804000, 4 * KiB);
 
     /* Instrumentation Trace Macrocell */
-    create_unimplemented_device("zynq.itm", 0xF8805000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.itm", 0xF8805000, 4 * KiB);
 
     /* Cross Trigger Interface, FTM */
-    create_unimplemented_device("zynq.cti_ftm", 0xF8809000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.cti_ftm", 0xF8809000, 4 * KiB);
 
     /* Fabric Trace Macrocell */
-    create_unimplemented_device("zynq.ftm", 0xF880B000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.ftm", 0xF880B000, 4 * KiB);
 
     /* Cortex A9 Performance Monitoring Unit, CPU */
-    create_unimplemented_device("cortex-a9.pmu0", 0xF8891000, 4 * KiB);
-    create_unimplemented_device("cortex-a9.pmu1", 0xF8893000, 4 * KiB);
+    create_unimplemented_device(obj, "cortex-a9.pmu0", 0xF8891000, 4 * KiB);
+    create_unimplemented_device(obj, "cortex-a9.pmu1", 0xF8893000, 4 * KiB);
 
     /* Cross Trigger Interface, CPU */
-    create_unimplemented_device("zynq.cpu_cti0", 0xF8898000, 4 * KiB);
-    create_unimplemented_device("zynq.cpu_cti1", 0xF8899000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.cpu_cti0", 0xF8898000, 4 * KiB);
+    create_unimplemented_device(obj, "zynq.cpu_cti1", 0xF8899000, 4 * KiB);
 
     /* CoreSight PTM-A9, CPU */
-    create_unimplemented_device("cortex-a9.ptm0", 0xF889c000, 4 * KiB);
-    create_unimplemented_device("cortex-a9.ptm1", 0xF889d000, 4 * KiB);
+    create_unimplemented_device(obj, "cortex-a9.ptm0", 0xF889c000, 4 * KiB);
+    create_unimplemented_device(obj, "cortex-a9.ptm1", 0xF889d000, 4 * KiB);
 
     /* AMBA NIC301 TrustZone */
-    create_unimplemented_device("zynq.trustZone", 0xF8900000, 0x20);
+    create_unimplemented_device(obj, "zynq.trustZone", 0xF8900000, 0x20);
 
     /* AMBA Network Interconnect Advanced Quality of Service (QoS-301) */
-    create_unimplemented_device("zynq.qos301_cpu", 0xF8946000, 0x130);
-    create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
-    create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
+    create_unimplemented_device(obj, "zynq.qos301_cpu", 0xF8946000, 0x130);
+    create_unimplemented_device(obj, "zynq.qos301_dmac", 0xF8947000, 0x130);
+    create_unimplemented_device(obj, "zynq.qos301_iou", 0xF8948000, 0x130);
 
     zynq_binfo.ram_size = machine->ram_size;
     zynq_binfo.board_id = 0xd32;
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 5eb640f628..b124db001f 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -312,7 +312,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
             continue;
         }
         devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
-        create_unimplemented_device(devname,
+        create_unimplemented_device(OBJECT(dev), devname,
                                     OFFSET_DATA + mc->dev[idx].addr, 3);
         g_free(devname);
     }
@@ -344,12 +344,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
             continue;
         }
         if (!mc->dev[idx].is_timer16) {
-            create_unimplemented_device("avr-timer8",
+            create_unimplemented_device(OBJECT(dev), "avr-timer8",
                                         OFFSET_DATA + mc->dev[idx].addr, 5);
-            create_unimplemented_device("avr-timer8-intmask",
+            create_unimplemented_device(OBJECT(dev), "avr-timer8-intmask",
                                         OFFSET_DATA
                                         + mc->dev[idx].intmask_addr, 1);
-            create_unimplemented_device("avr-timer8-intflag",
+            create_unimplemented_device(OBJECT(dev), "avr-timer8-intflag",
                                         OFFSET_DATA
                                         + mc->dev[idx].intflag_addr, 1);
             continue;
@@ -373,12 +373,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         g_free(devname);
     }
 
-    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8, 6);
-    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078, 8);
-    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074, 2);
-    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060, 1);
-    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c, 3);
-    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
+    create_unimplemented_device(OBJECT(dev), "avr-twi",          OFFSET_DATA + 0x0b8, 6);
+    create_unimplemented_device(OBJECT(dev), "avr-adc",          OFFSET_DATA + 0x078, 8);
+    create_unimplemented_device(OBJECT(dev), "avr-ext-mem-ctrl", OFFSET_DATA + 0x074, 2);
+    create_unimplemented_device(OBJECT(dev), "avr-watchdog",     OFFSET_DATA + 0x060, 1);
+    create_unimplemented_device(OBJECT(dev), "avr-spi",          OFFSET_DATA + 0x04c, 3);
+    create_unimplemented_device(OBJECT(dev), "avr-eeprom",       OFFSET_DATA + 0x03f, 3);
 }
 
 static const Property atmega_props[] = {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 20a68ebd44..24d8dc6e57 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -483,7 +483,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      * There are some invalid guest memory access.
      * Create some unimplemented devices to emulate this.
      */
-    create_unimplemented_device("pci-dma-cfg", 0x1001041c, 0x4);
+    create_unimplemented_device(OBJECT(lvms), "pci-dma-cfg", 0x1001041c, 0x4);
     sysbus_create_simple(OBJECT(lvms), "rtc", "ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 0979d3632b..6986eb7732 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -144,7 +144,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
-    create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "xps_gpio", GPIO_BASEADDR, 0x10000);
 
     microblaze_load_kernel(cpu, endianness == ENDIAN_MODE_LITTLE, ddr_base,
                            ram_size, machine->initrd_filename,
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 99d2016ef1..8d8430562c 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -478,6 +478,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
 static void mips_loongson3_virt_init(MachineState *machine)
 {
+    Object *obj = OBJECT(machine);
     int i;
     long bios_size;
     MIPSCPU *cpu = NULL;
@@ -515,8 +516,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * exception when accessing invalid memory. Create some unimplememted
      * devices to emulate this feature.
      */
-    create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
-    create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
+    create_unimplemented_device(obj, "mmio fallback 0", 0x10000000, 256 * MiB);
+    create_unimplemented_device(obj, "mmio fallback 1", 0x30000000, 256 * MiB);
 
     memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 83b328840a..7b4259c0e7 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -647,7 +647,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
         g_free(name);
     }
 
-    create_unimplemented_device("pci.io", BONITO_PCIIO_BASE, 1 * MiB);
+    create_unimplemented_device(OBJECT(dev), "pci.io", BONITO_PCIIO_BASE, 1 * MiB);
 }
 
 static void bonito_pci_realize(PCIDevice *dev, Error **errp)
@@ -681,7 +681,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion(host_mem, BONITO_SPCICONFIG_BASE,
                                 &phb->data_mem);
 
-    create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
+    create_unimplemented_device(OBJECT(dev), "bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
 
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
@@ -692,7 +692,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
                           "cop", 0x100);
     memory_region_add_subregion(host_mem, 0x1fe00300, &s->iomem_cop);
 
-    create_unimplemented_device("ROMCS", BONITO_FLASH_BASE, 60 * MiB);
+    create_unimplemented_device(OBJECT(dev), "ROMCS", BONITO_FLASH_BASE, 60 * MiB);
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
@@ -706,17 +706,17 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
                              get_system_io(), 0, 256 * KiB);
     memory_region_add_subregion(host_mem, BONITO_DEV_BASE,
                                 &s->bonito_localio);
-    create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
+    create_unimplemented_device(OBJECT(dev), "IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
                                 256 * KiB);
-    create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,
+    create_unimplemented_device(OBJECT(dev), "IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,
                                 256 * KiB);
-    create_unimplemented_device("IOCS[3]", BONITO_DEV_BASE + 3 * 256 * KiB,
+    create_unimplemented_device(OBJECT(dev), "IOCS[3]", BONITO_DEV_BASE + 3 * 256 * KiB,
                                 256 * KiB);
 
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
     memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_alias);
-    create_unimplemented_device("PCI_2",
+    create_unimplemented_device(OBJECT(dev), "PCI_2",
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
                                 2 * GiB);
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index d51ad08d87..901106d602 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -144,7 +144,7 @@ static void k230_create_uart(Object *parent, MemoryRegion *sys_mem,
     g_autofree char *name = g_strdup_printf("uart%d", index);
 
     /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
-    create_unimplemented_device(name, memmap[uart_dev].base,
+    create_unimplemented_device(parent, name, memmap[uart_dev].base,
                                 memmap[uart_dev].size);
 
     serial_mm_init(parent, sys_mem, memmap[uart_dev].base, 2,
@@ -154,6 +154,7 @@ static void k230_create_uart(Object *parent, MemoryRegion *sys_mem,
 
 static void k230_soc_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
     K230SoCState *s = RISCV_K230_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
     int c908_cpus;
@@ -209,164 +210,164 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
     /* unimplemented devices */
-    create_unimplemented_device("kpu.l2-cache",
+    create_unimplemented_device(obj, "kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
                                 memmap[K230_DEV_KPU_L2_CACHE].size);
 
-    create_unimplemented_device("kpu_cfg", memmap[K230_DEV_KPU_CFG].base,
+    create_unimplemented_device(obj, "kpu_cfg", memmap[K230_DEV_KPU_CFG].base,
                                 memmap[K230_DEV_KPU_CFG].size);
 
-    create_unimplemented_device("fft", memmap[K230_DEV_FFT].base,
+    create_unimplemented_device(obj, "fft", memmap[K230_DEV_FFT].base,
                                 memmap[K230_DEV_FFT].size);
 
-    create_unimplemented_device("2d-engine.ai",
+    create_unimplemented_device(obj, "2d-engine.ai",
                                 memmap[K230_DEV_AI_2D_ENGINE].base,
                                 memmap[K230_DEV_AI_2D_ENGINE].size);
 
-    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
+    create_unimplemented_device(obj, "gsdma", memmap[K230_DEV_GSDMA].base,
                                 memmap[K230_DEV_GSDMA].size);
 
-    create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
+    create_unimplemented_device(obj, "dma", memmap[K230_DEV_DMA].base,
                                 memmap[K230_DEV_DMA].size);
 
-    create_unimplemented_device("decomp-gzip",
+    create_unimplemented_device(obj, "decomp-gzip",
                                 memmap[K230_DEV_DECOMP_GZIP].base,
                                 memmap[K230_DEV_DECOMP_GZIP].size);
 
-    create_unimplemented_device("2d-engine.non-ai",
+    create_unimplemented_device(obj, "2d-engine.non-ai",
                                 memmap[K230_DEV_NON_AI_2D].base,
                                 memmap[K230_DEV_NON_AI_2D].size);
 
-    create_unimplemented_device("isp", memmap[K230_DEV_ISP].base,
+    create_unimplemented_device(obj, "isp", memmap[K230_DEV_ISP].base,
                                 memmap[K230_DEV_ISP].size);
 
-    create_unimplemented_device("dewarp", memmap[K230_DEV_DEWARP].base,
+    create_unimplemented_device(obj, "dewarp", memmap[K230_DEV_DEWARP].base,
                                 memmap[K230_DEV_DEWARP].size);
 
-    create_unimplemented_device("rx-csi", memmap[K230_DEV_RX_CSI].base,
+    create_unimplemented_device(obj, "rx-csi", memmap[K230_DEV_RX_CSI].base,
                                 memmap[K230_DEV_RX_CSI].size);
 
-    create_unimplemented_device("vpu", memmap[K230_DEV_H264].base,
+    create_unimplemented_device(obj, "vpu", memmap[K230_DEV_H264].base,
                                 memmap[K230_DEV_H264].size);
 
-    create_unimplemented_device("gpu", memmap[K230_DEV_2P5D].base,
+    create_unimplemented_device(obj, "gpu", memmap[K230_DEV_2P5D].base,
                                 memmap[K230_DEV_2P5D].size);
 
-    create_unimplemented_device("vo", memmap[K230_DEV_VO].base,
+    create_unimplemented_device(obj, "vo", memmap[K230_DEV_VO].base,
                                 memmap[K230_DEV_VO].size);
 
-    create_unimplemented_device("vo_cfg", memmap[K230_DEV_VO_CFG].base,
+    create_unimplemented_device(obj, "vo_cfg", memmap[K230_DEV_VO_CFG].base,
                                 memmap[K230_DEV_VO_CFG].size);
 
-    create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].base,
+    create_unimplemented_device(obj, "3d-engine", memmap[K230_DEV_3D_ENGINE].base,
                                 memmap[K230_DEV_3D_ENGINE].size);
 
-    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
+    create_unimplemented_device(obj, "pmu", memmap[K230_DEV_PMU].base,
                                 memmap[K230_DEV_PMU].size);
 
-    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
+    create_unimplemented_device(obj, "rtc", memmap[K230_DEV_RTC].base,
                                 memmap[K230_DEV_RTC].size);
 
-    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
+    create_unimplemented_device(obj, "cmu", memmap[K230_DEV_CMU].base,
                                 memmap[K230_DEV_CMU].size);
 
-    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
+    create_unimplemented_device(obj, "rmu", memmap[K230_DEV_RMU].base,
                                 memmap[K230_DEV_RMU].size);
 
-    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
+    create_unimplemented_device(obj, "boot", memmap[K230_DEV_BOOT].base,
                                 memmap[K230_DEV_BOOT].size);
 
-    create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
+    create_unimplemented_device(obj, "pwr", memmap[K230_DEV_PWR].base,
                                 memmap[K230_DEV_PWR].size);
 
-    create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
+    create_unimplemented_device(obj, "ipcm", memmap[K230_DEV_MAILBOX].base,
                                 memmap[K230_DEV_MAILBOX].size);
 
-    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
+    create_unimplemented_device(obj, "iomux", memmap[K230_DEV_IOMUX].base,
                                 memmap[K230_DEV_IOMUX].size);
 
-    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
+    create_unimplemented_device(obj, "timer", memmap[K230_DEV_TIMER].base,
                                 memmap[K230_DEV_TIMER].size);
 
-    create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
+    create_unimplemented_device(obj, "wdt0", memmap[K230_DEV_WDT0].base,
                                 memmap[K230_DEV_WDT0].size);
 
-    create_unimplemented_device("wdt1", memmap[K230_DEV_WDT1].base,
+    create_unimplemented_device(obj, "wdt1", memmap[K230_DEV_WDT1].base,
                                 memmap[K230_DEV_WDT1].size);
 
-    create_unimplemented_device("ts", memmap[K230_DEV_TS].base,
+    create_unimplemented_device(obj, "ts", memmap[K230_DEV_TS].base,
                                 memmap[K230_DEV_TS].size);
 
-    create_unimplemented_device("hdi", memmap[K230_DEV_HDI].base,
+    create_unimplemented_device(obj, "hdi", memmap[K230_DEV_HDI].base,
                                 memmap[K230_DEV_HDI].size);
 
-    create_unimplemented_device("stc", memmap[K230_DEV_STC].base,
+    create_unimplemented_device(obj, "stc", memmap[K230_DEV_STC].base,
                                 memmap[K230_DEV_STC].size);
 
-    create_unimplemented_device("security", memmap[K230_DEV_SECURITY].base,
+    create_unimplemented_device(obj, "security", memmap[K230_DEV_SECURITY].base,
                                 memmap[K230_DEV_SECURITY].size);
 
-    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
+    create_unimplemented_device(obj, "i2c0", memmap[K230_DEV_I2C0].base,
                                 memmap[K230_DEV_I2C0].size);
 
-    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
+    create_unimplemented_device(obj, "i2c1", memmap[K230_DEV_I2C1].base,
                                 memmap[K230_DEV_I2C1].size);
 
-    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
+    create_unimplemented_device(obj, "i2c2", memmap[K230_DEV_I2C2].base,
                                 memmap[K230_DEV_I2C2].size);
 
-    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
+    create_unimplemented_device(obj, "i2c3", memmap[K230_DEV_I2C3].base,
                                 memmap[K230_DEV_I2C3].size);
 
-    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
+    create_unimplemented_device(obj, "i2c4", memmap[K230_DEV_I2C4].base,
                                 memmap[K230_DEV_I2C4].size);
 
-    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
+    create_unimplemented_device(obj, "pwm", memmap[K230_DEV_PWM].base,
                                 memmap[K230_DEV_PWM].size);
 
-    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
+    create_unimplemented_device(obj, "gpio0", memmap[K230_DEV_GPIO0].base,
                                 memmap[K230_DEV_GPIO0].size);
 
-    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
+    create_unimplemented_device(obj, "gpio1", memmap[K230_DEV_GPIO1].base,
                                 memmap[K230_DEV_GPIO1].size);
 
-    create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
+    create_unimplemented_device(obj, "adc", memmap[K230_DEV_ADC].base,
                                 memmap[K230_DEV_ADC].size);
 
-    create_unimplemented_device("codec", memmap[K230_DEV_CODEC].base,
+    create_unimplemented_device(obj, "codec", memmap[K230_DEV_CODEC].base,
                                 memmap[K230_DEV_CODEC].size);
 
-    create_unimplemented_device("i2s", memmap[K230_DEV_I2S].base,
+    create_unimplemented_device(obj, "i2s", memmap[K230_DEV_I2S].base,
                                 memmap[K230_DEV_I2S].size);
 
-    create_unimplemented_device("usb0", memmap[K230_DEV_USB0].base,
+    create_unimplemented_device(obj, "usb0", memmap[K230_DEV_USB0].base,
                                 memmap[K230_DEV_USB0].size);
 
-    create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
+    create_unimplemented_device(obj, "usb1", memmap[K230_DEV_USB1].base,
                                 memmap[K230_DEV_USB1].size);
 
-    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
+    create_unimplemented_device(obj, "sd0", memmap[K230_DEV_SD0].base,
                                 memmap[K230_DEV_SD0].size);
 
-    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
+    create_unimplemented_device(obj, "sd1", memmap[K230_DEV_SD1].base,
                                 memmap[K230_DEV_SD1].size);
 
-    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
+    create_unimplemented_device(obj, "qspi0", memmap[K230_DEV_QSPI0].base,
                                 memmap[K230_DEV_QSPI0].size);
 
-    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
+    create_unimplemented_device(obj, "qspi1", memmap[K230_DEV_QSPI1].base,
                                 memmap[K230_DEV_QSPI1].size);
 
-    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
+    create_unimplemented_device(obj, "spi", memmap[K230_DEV_SPI].base,
                                 memmap[K230_DEV_SPI].size);
 
-    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
+    create_unimplemented_device(obj, "hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
                                 memmap[K230_DEV_HI_SYS_CFG].size);
 
-    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
+    create_unimplemented_device(obj, "ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
                                 memmap[K230_DEV_DDRC_CFG].size);
 
-    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
+    create_unimplemented_device(obj, "flash", memmap[K230_DEV_FLASH].base,
                                 memmap[K230_DEV_FLASH].size);
 }
 
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index fbfdec7ede..7253ae7822 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -166,11 +166,11 @@ static void mb_v_generic_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
 
     /* unimplemented devices */
-    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
-    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
-    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
-    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
-    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "gpio2", GPIO_BASEADDR2, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "gpio3", GPIO_BASEADDR3, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "i2c", I2C_BASEADDR, 0x10000);
+    create_unimplemented_device(OBJECT(machine), "qspi", QSPI_BASEADDR, 0x10000);
 }
 
 static void mb_v_generic_machine_init(MachineClass *mc)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 0d298aa3fc..0a98ac1c5e 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -233,19 +233,19 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 e51_dtim_mem);
 
     /* Bus Error Units */
-    create_unimplemented_device("microchip.pfsoc.buserr_unit0_mem",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.buserr_unit0_mem",
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT0].base,
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT0].size);
-    create_unimplemented_device("microchip.pfsoc.buserr_unit1_mem",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.buserr_unit1_mem",
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT1].base,
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT1].size);
-    create_unimplemented_device("microchip.pfsoc.buserr_unit2_mem",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.buserr_unit2_mem",
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT2].base,
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT2].size);
-    create_unimplemented_device("microchip.pfsoc.buserr_unit3_mem",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.buserr_unit3_mem",
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT3].base,
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT3].size);
-    create_unimplemented_device("microchip.pfsoc.buserr_unit4_mem",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.buserr_unit4_mem",
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].base,
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
 
@@ -259,7 +259,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         iks->clint_timebase_freq, false);
 
     /* L2 cache controller */
-    create_unimplemented_device("microchip.pfsoc.l2cc",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.l2cc",
         memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
 
     /*
@@ -314,17 +314,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                        MICROCHIP_PFSOC_MAILBOX_IRQ));
 
     /* AXISW */
-    create_unimplemented_device("microchip.pfsoc.axisw",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.axisw",
         memmap[MICROCHIP_PFSOC_AXISW].base,
         memmap[MICROCHIP_PFSOC_AXISW].size);
 
     /* MPUCFG */
-    create_unimplemented_device("microchip.pfsoc.mpucfg",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.mpucfg",
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
     /* FMETER */
-    create_unimplemented_device("microchip.pfsoc.fmeter",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.fmeter",
         memmap[MICROCHIP_PFSOC_FMETER].base,
         memmap[MICROCHIP_PFSOC_FMETER].size);
 
@@ -368,48 +368,48 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(4));
 
     /* Watchdogs */
-    create_unimplemented_device("microchip.pfsoc.watchdog0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.watchdog0",
         memmap[MICROCHIP_PFSOC_WDOG0].base,
         memmap[MICROCHIP_PFSOC_WDOG0].size);
-    create_unimplemented_device("microchip.pfsoc.watchdog1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.watchdog1",
         memmap[MICROCHIP_PFSOC_WDOG1].base,
         memmap[MICROCHIP_PFSOC_WDOG1].size);
-    create_unimplemented_device("microchip.pfsoc.watchdog2",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.watchdog2",
         memmap[MICROCHIP_PFSOC_WDOG2].base,
         memmap[MICROCHIP_PFSOC_WDOG2].size);
-    create_unimplemented_device("microchip.pfsoc.watchdog3",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.watchdog3",
         memmap[MICROCHIP_PFSOC_WDOG3].base,
         memmap[MICROCHIP_PFSOC_WDOG3].size);
-    create_unimplemented_device("microchip.pfsoc.watchdog4",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.watchdog4",
         memmap[MICROCHIP_PFSOC_WDOG4].base,
         memmap[MICROCHIP_PFSOC_WDOG4].size);
 
     /* SPI */
-    create_unimplemented_device("microchip.pfsoc.spi0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.spi0",
         memmap[MICROCHIP_PFSOC_SPI0].base,
         memmap[MICROCHIP_PFSOC_SPI0].size);
-    create_unimplemented_device("microchip.pfsoc.spi1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.spi1",
         memmap[MICROCHIP_PFSOC_SPI1].base,
         memmap[MICROCHIP_PFSOC_SPI1].size);
 
     /* I2C */
-    create_unimplemented_device("microchip.pfsoc.i2c0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.i2c0",
         memmap[MICROCHIP_PFSOC_I2C0].base,
         memmap[MICROCHIP_PFSOC_I2C0].size);
-    create_unimplemented_device("microchip.pfsoc.i2c1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.i2c1",
         memmap[MICROCHIP_PFSOC_I2C1].base,
         memmap[MICROCHIP_PFSOC_I2C1].size);
 
     /* CAN */
-    create_unimplemented_device("microchip.pfsoc.can0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.can0",
         memmap[MICROCHIP_PFSOC_CAN0].base,
         memmap[MICROCHIP_PFSOC_CAN0].size);
-    create_unimplemented_device("microchip.pfsoc.can1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.can1",
         memmap[MICROCHIP_PFSOC_CAN1].base,
         memmap[MICROCHIP_PFSOC_CAN1].size);
 
     /* USB */
-    create_unimplemented_device("microchip.pfsoc.usb",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.usb",
         memmap[MICROCHIP_PFSOC_USB].base,
         memmap[MICROCHIP_PFSOC_USB].size);
 
@@ -440,13 +440,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
 
     /* GPIOs */
-    create_unimplemented_device("microchip.pfsoc.gpio0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.gpio0",
         memmap[MICROCHIP_PFSOC_GPIO0].base,
         memmap[MICROCHIP_PFSOC_GPIO0].size);
-    create_unimplemented_device("microchip.pfsoc.gpio1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.gpio1",
         memmap[MICROCHIP_PFSOC_GPIO1].base,
         memmap[MICROCHIP_PFSOC_GPIO1].size);
-    create_unimplemented_device("microchip.pfsoc.gpio2",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.gpio2",
         memmap[MICROCHIP_PFSOC_GPIO2].base,
         memmap[MICROCHIP_PFSOC_GPIO2].size);
 
@@ -467,15 +467,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                        MICROCHIP_PFSOC_MAILBOX_IRQ));
 
     /* FPGA Fabric */
-    create_unimplemented_device("microchip.pfsoc.fabricfic3",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.fabricfic3",
         memmap[MICROCHIP_PFSOC_FABRIC_FIC3].base,
         memmap[MICROCHIP_PFSOC_FABRIC_FIC3].size);
     /* FPGA Fabric */
-    create_unimplemented_device("microchip.pfsoc.fabricfic0",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.fabricfic0",
         memmap[MICROCHIP_PFSOC_FABRIC_FIC0].base,
         memmap[MICROCHIP_PFSOC_FABRIC_FIC0].size);
     /* FPGA Fabric */
-    create_unimplemented_device("microchip.pfsoc.fabricfic1",
+    create_unimplemented_device(OBJECT(dev), "microchip.pfsoc.fabricfic1",
         memmap[MICROCHIP_PFSOC_FABRIC_FIC1].base,
         memmap[MICROCHIP_PFSOC_FABRIC_FIC1].size);
 
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 5b2f33d5ac..76653ccc77 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -258,57 +258,57 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         }
     }
 
-    create_unimplemented_device("riscv.lowrisc.ibex.gpio",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.gpio",
         memmap[IBEX_DEV_GPIO].base, memmap[IBEX_DEV_GPIO].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.spi_device",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.spi_device",
         memmap[IBEX_DEV_SPI_DEVICE].base, memmap[IBEX_DEV_SPI_DEVICE].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.i2c",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.i2c",
         memmap[IBEX_DEV_I2C].base, memmap[IBEX_DEV_I2C].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.pattgen",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.pattgen",
         memmap[IBEX_DEV_PATTGEN].base, memmap[IBEX_DEV_PATTGEN].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.sensor_ctrl",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.sensor_ctrl",
         memmap[IBEX_DEV_SENSOR_CTRL].base, memmap[IBEX_DEV_SENSOR_CTRL].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.otp_ctrl",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.otp_ctrl",
         memmap[IBEX_DEV_OTP_CTRL].base, memmap[IBEX_DEV_OTP_CTRL].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.lc_ctrl",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.lc_ctrl",
         memmap[IBEX_DEV_LC_CTRL].base, memmap[IBEX_DEV_LC_CTRL].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.pwrmgr",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.pwrmgr",
         memmap[IBEX_DEV_PWRMGR].base, memmap[IBEX_DEV_PWRMGR].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.rstmgr",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.rstmgr",
         memmap[IBEX_DEV_RSTMGR].base, memmap[IBEX_DEV_RSTMGR].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.clkmgr",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.clkmgr",
         memmap[IBEX_DEV_CLKMGR].base, memmap[IBEX_DEV_CLKMGR].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.pinmux",
         memmap[IBEX_DEV_PINMUX].base, memmap[IBEX_DEV_PINMUX].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.aon_timer",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.aon_timer",
         memmap[IBEX_DEV_AON_TIMER].base, memmap[IBEX_DEV_AON_TIMER].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.usbdev",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.usbdev",
         memmap[IBEX_DEV_USBDEV].base, memmap[IBEX_DEV_USBDEV].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.flash_ctrl",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.flash_ctrl",
         memmap[IBEX_DEV_FLASH_CTRL].base, memmap[IBEX_DEV_FLASH_CTRL].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.aes",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.aes",
         memmap[IBEX_DEV_AES].base, memmap[IBEX_DEV_AES].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.hmac",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.hmac",
         memmap[IBEX_DEV_HMAC].base, memmap[IBEX_DEV_HMAC].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.kmac",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.kmac",
         memmap[IBEX_DEV_KMAC].base, memmap[IBEX_DEV_KMAC].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.keymgr",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.keymgr",
         memmap[IBEX_DEV_KEYMGR].base, memmap[IBEX_DEV_KEYMGR].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.csrng",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.csrng",
         memmap[IBEX_DEV_CSRNG].base, memmap[IBEX_DEV_CSRNG].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.entropy",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.entropy",
         memmap[IBEX_DEV_ENTROPY].base, memmap[IBEX_DEV_ENTROPY].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.edn0",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.edn0",
         memmap[IBEX_DEV_EDNO].base, memmap[IBEX_DEV_EDNO].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.edn1",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.edn1",
         memmap[IBEX_DEV_EDN1].base, memmap[IBEX_DEV_EDN1].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.alert_handler",
         memmap[IBEX_DEV_ALERT_HANDLER].base, memmap[IBEX_DEV_ALERT_HANDLER].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.sram_ctrl",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.sram_ctrl",
         memmap[IBEX_DEV_SRAM_CTRL].base, memmap[IBEX_DEV_SRAM_CTRL].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.otbn",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.otbn",
         memmap[IBEX_DEV_OTBN].base, memmap[IBEX_DEV_OTBN].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.ibex_cfg",
+    create_unimplemented_device(OBJECT(dev_soc), "riscv.lowrisc.ibex.ibex_cfg",
         memmap[IBEX_DEV_IBEX_CFG].base, memmap[IBEX_DEV_IBEX_CFG].size);
 }
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fb62bc9aca..31cec460b3 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -268,19 +268,19 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     sifive_uart_create(OBJECT(s), sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
-    create_unimplemented_device("riscv.sifive.e.qspi0",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.qspi0",
         memmap[SIFIVE_E_DEV_QSPI0].base, memmap[SIFIVE_E_DEV_QSPI0].size);
-    create_unimplemented_device("riscv.sifive.e.pwm0",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_DEV_PWM0].base, memmap[SIFIVE_E_DEV_PWM0].size);
     sifive_uart_create(OBJECT(s), sys_mem, memmap[SIFIVE_E_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
-    create_unimplemented_device("riscv.sifive.e.qspi1",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_DEV_QSPI1].base, memmap[SIFIVE_E_DEV_QSPI1].size);
-    create_unimplemented_device("riscv.sifive.e.pwm1",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.pwm1",
         memmap[SIFIVE_E_DEV_PWM1].base, memmap[SIFIVE_E_DEV_PWM1].size);
-    create_unimplemented_device("riscv.sifive.e.qspi2",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.qspi2",
         memmap[SIFIVE_E_DEV_QSPI2].base, memmap[SIFIVE_E_DEV_QSPI2].size);
-    create_unimplemented_device("riscv.sifive.e.pwm2",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.e.pwm2",
         memmap[SIFIVE_E_DEV_PWM2].base, memmap[SIFIVE_E_DEV_PWM2].size);
 
     /* Flash memory */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3d60a501dd..aba6716b73 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -861,13 +861,13 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    create_unimplemented_device("riscv.sifive.u.gem-mgmt",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_DEV_GEM_MGMT].base, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
 
-    create_unimplemented_device("riscv.sifive.u.dmc",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.u.dmc",
         memmap[SIFIVE_U_DEV_DMC].base, memmap[SIFIVE_U_DEV_DMC].size);
 
-    create_unimplemented_device("riscv.sifive.u.l2cc",
+    create_unimplemented_device(OBJECT(dev), "riscv.sifive.u.l2cc",
         memmap[SIFIVE_U_DEV_L2CC].base, memmap[SIFIVE_U_DEV_L2CC].size);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->spi0), errp);
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 6e0a54fe3c..068a0bc542 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -556,7 +556,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    create_unimplemented_device("tt-atlantis.uart0",
+    create_unimplemented_device(OBJECT(machine), "tt-atlantis.uart0",
                                 s->memmap[TT_ATL_UART1].base,
                                 s->memmap[TT_ATL_UART1].size);
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 144345d46a..a0d0213d0b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -948,7 +948,7 @@ static void sun4m_hw_init(MachineState *machine)
     }
 
     if (hwdef->sx_base) {
-        create_unimplemented_device("sun-sx", hwdef->sx_base, 0x2000);
+        create_unimplemented_device(OBJECT(machine), "sun-sx", hwdef->sx_base, 0x2000);
     }
 
     dev = qdev_new(OBJECT(machine), "nvram", "sysbus-m48t08");
@@ -1032,16 +1032,16 @@ static void sun4m_hw_init(MachineState *machine)
     if (hwdef->dbri_base) {
         /* ISDN chip with attached CS4215 audio codec */
         /* prom space */
-        create_unimplemented_device("sun-DBRI.prom",
+        create_unimplemented_device(OBJECT(machine), "sun-DBRI.prom",
                                     hwdef->dbri_base + 0x1000, 0x30);
         /* reg space */
-        create_unimplemented_device("sun-DBRI",
+        create_unimplemented_device(OBJECT(machine), "sun-DBRI",
                                     hwdef->dbri_base + 0x10000, 0x100);
     }
 
     if (hwdef->bpp_base) {
         /* parallel port */
-        create_unimplemented_device("sun-bpp", hwdef->bpp_base, 0x20);
+        create_unimplemented_device(OBJECT(machine), "sun-bpp", hwdef->bpp_base, 0x20);
     }
 
     initrd_size = 0;
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index bceda70f2e..8fb9937127 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -98,6 +98,7 @@ static void add_rom_or_fail(const char *file, const hwaddr addr)
 /* Niagara hardware initialisation */
 static void niagara_init(MachineState *machine)
 {
+    Object *obj = OBJECT(machine);
     NiagaraBoardState *s = g_new(NiagaraBoardState, 1);
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
     MemoryRegion *sysmem = get_system_memory();
@@ -153,7 +154,7 @@ static void niagara_init(MachineState *machine)
     }
     serial_mm_init(OBJECT(machine), sysmem, NIAGARA_UART_BASE, 0, NULL,
                    115200, serial_hd(0), DEVICE_BIG_ENDIAN);
-    create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
+    create_unimplemented_device(obj, "sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(OBJECT(machine), NIAGARA_RTC_BASE);
 }
 
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 5158d29634..afef25671e 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -38,15 +38,18 @@ struct UnimplementedDeviceState {
  * use it to cover a large region and then map other devices on top of it
  * if necessary.
  */
-static inline void create_unimplemented_device(const char *name,
+static inline void create_unimplemented_device(Object *parent,
+                                               const char *name,
                                                hwaddr base,
                                                hwaddr size)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
+    g_autofree char *id = name[strlen(name) - 1] == ']'
+                          ? g_strdup(name) : g_strdup_printf("%s[*]", name);
+    DeviceState *dev = qdev_new(parent, id, TYPE_UNIMPLEMENTED_DEVICE);
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, -1000);
 }
-- 
2.47.1


