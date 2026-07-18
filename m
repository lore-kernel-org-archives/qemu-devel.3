Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01EC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCj0-00008P-US; Sat, 18 Jul 2026 17:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCiy-00007S-RD; Sat, 18 Jul 2026 17:37:32 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCit-0001xW-4v; Sat, 18 Jul 2026 17:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410647; x=1815946647;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NF4gg8dylRsYmR2hq13oa0tNF6iyBeAWx1wOgnMx68E=;
 b=Kypun4JdcqZAsRsdEwA3xq05wuUe9M9PA+s3Bx27h06u8jK6wQSStd7r
 UkHPMfIfSuGapg3LSFY+2aasw7QM9kr5W/A1CfP1zKXFvcHSS92L2mBrY
 O4/q6QO8me4ftDjQRTaAAoC+g62Y8vPVH8jNq10cIDTSYHyJK4Y0uc5Qt
 oNoJvEMefQdF3UTyE3re5yGMMCuV04jbzCP78hGD7aTPIFfmI+CZVAkGP
 gcFDM6DMkFsd5qUXTbx06HX3RWuQC7yKgFX1SXL1ApvZDP3irglwtthKu
 hP5VhffoEPaEWPzuLD0JuE5HaU/Alb3xPrHEhMD4/DYjfAgGIMHCj6PIi w==;
X-CSE-ConnectionGUID: HeLorI/dQ+2Qd2UtAKBXEA==
X-CSE-MsgGUID: j0UtcQYgRKmwlFc1kgxQfw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23816222"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:37:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3439]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.147:2525]
 with esmtp (Farcaster)
 id 449da22a-34c7-4c7b-a340-5315373eb181; Sat, 18 Jul 2026 21:37:24 +0000 (UTC)
X-Farcaster-Flow-ID: 449da22a-34c7-4c7b-a340-5315373eb181
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:23 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:13 +0000
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
Subject: [RFC PATCH v2 002/137] qdev: Rename qdev_new()/qdev_try_new() to
 *_orphan()
Date: Sat, 18 Jul 2026 21:34:37 +0000
Message-ID: <20260718213652.37673-3-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

qdev_new() creates a device on the heap without a QOM parent.  If the
caller does not add one before realize, device_set_realized() dumps
the device into /machine/unattached with an unstable canonical path.

We want the short spelling qdev_new() to be the one that gets
parenting right by construction.  As a first step, rename the current
functions to qdev_new_orphan() and qdev_try_new_orphan() tree-wide so
that a subsequent commit can reintroduce qdev_new() with a mandatory
(parent, id, type) signature.

Purely mechanical, generated by

  spatch --sp-file scripts/coccinelle/qom-parent/qdev-new-orphan.cocci \
         --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i 's/\bqdev_try_new\b/qdev_try_new_orphan/g;
                    s/\bqdev_new\b/qdev_new_orphan/g'

No functional change.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/typhoon.c                            |  2 +-
 hw/arm/aspeed.c                               |  2 +-
 hw/arm/aspeed_soc_common.c                    |  4 +-
 hw/arm/bananapi_m2u.c                         |  2 +-
 hw/arm/cubieboard.c                           |  2 +-
 hw/arm/exynos4210.c                           | 12 ++--
 hw/arm/imx25_pdk.c                            |  2 +-
 hw/arm/imx8mm-evk.c                           |  2 +-
 hw/arm/imx8mp-evk.c                           |  2 +-
 hw/arm/integratorcp.c                         |  8 +--
 hw/arm/max78000fthr.c                         |  2 +-
 hw/arm/mcimx6ul-evk.c                         |  2 +-
 hw/arm/mcimx7d-sabre.c                        |  2 +-
 hw/arm/mps2-tz.c                              |  4 +-
 hw/arm/mps2.c                                 |  4 +-
 hw/arm/msf2-som.c                             |  4 +-
 hw/arm/musicpal.c                             |  6 +-
 hw/arm/netduino2.c                            |  2 +-
 hw/arm/netduinoplus2.c                        |  2 +-
 hw/arm/npcm7xx_boards.c                       |  4 +-
 hw/arm/npcm8xx_boards.c                       |  2 +-
 hw/arm/olimex-stm32-h405.c                    |  2 +-
 hw/arm/omap1.c                                | 12 ++--
 hw/arm/orangepi.c                             |  2 +-
 hw/arm/raspi.c                                |  2 +-
 hw/arm/realview.c                             | 18 ++---
 hw/arm/sabrelite.c                            |  2 +-
 hw/arm/sbsa-ref.c                             | 20 +++---
 hw/arm/stellaris.c                            | 20 +++---
 hw/arm/stm32vldiscovery.c                     |  2 +-
 hw/arm/strongarm.c                            |  4 +-
 hw/arm/versatilepb.c                          | 14 ++--
 hw/arm/vexpress.c                             | 14 ++--
 hw/arm/virt.c                                 | 24 +++----
 hw/arm/xilinx_zynq.c                          | 26 +++----
 hw/arm/xlnx-versal-virt.c                     |  2 +-
 hw/arm/xlnx-versal.c                          | 70 +++++++++----------
 hw/arm/xlnx-zcu102.c                          |  6 +-
 hw/arm/xlnx-zynqmp.c                          |  2 +-
 hw/audio/intel-hda.c                          |  2 +-
 hw/audio/model.c                              |  2 +-
 hw/avr/atmega.c                               |  2 +-
 hw/block/fdc-sysbus.c                         |  4 +-
 hw/block/fdc.c                                |  2 +-
 hw/block/pflash_cfi01.c                       |  2 +-
 hw/block/pflash_cfi02.c                       |  2 +-
 hw/block/xen-block.c                          |  2 +-
 hw/char/exynos4210_uart.c                     |  2 +-
 hw/char/mcf_uart.c                            |  2 +-
 hw/char/mchp_pfsoc_mmuart.c                   |  2 +-
 hw/char/pl011.c                               |  2 +-
 hw/char/serial-mm.c                           |  2 +-
 hw/char/sifive_uart.c                         |  2 +-
 hw/char/spapr_vty.c                           |  2 +-
 hw/char/xen_console.c                         |  2 +-
 hw/core/qdev.c                                |  4 +-
 hw/core/sysbus.c                              |  2 +-
 hw/cxl/cxl-host.c                             |  2 +-
 hw/display/sm501.c                            |  2 +-
 hw/display/xlnx_dp.c                          |  4 +-
 hw/dma/rc4030.c                               |  2 +-
 hw/hexagon/hexagon_dsp.c                      |  4 +-
 hw/hexagon/virt.c                             |  6 +-
 hw/hppa/machine.c                             | 12 ++--
 hw/i2c/core.c                                 |  2 +-
 hw/i2c/smbus_eeprom.c                         |  2 +-
 hw/i386/microvm.c                             |  6 +-
 hw/i386/nitro_enclave.c                       |  4 +-
 hw/i386/pc.c                                  |  2 +-
 hw/i386/pc_piix.c                             |  2 +-
 hw/i386/pc_q35.c                              |  2 +-
 hw/i386/pc_sysfw.c                            |  2 +-
 hw/i386/sgx.c                                 |  2 +-
 hw/i386/x86-common.c                          |  6 +-
 hw/i3c/core.c                                 |  2 +-
 hw/ide/ide-bus.c                              |  2 +-
 hw/intc/exynos4210_gic.c                      |  2 +-
 hw/intc/riscv_aclint.c                        |  4 +-
 hw/intc/riscv_aplic.c                         |  2 +-
 hw/intc/riscv_imsic.c                         |  2 +-
 hw/intc/s390_flic.c                           |  4 +-
 hw/intc/sifive_plic.c                         |  2 +-
 hw/isa/isa-bus.c                              |  6 +-
 hw/loongarch/virt.c                           | 18 ++---
 hw/m68k/an5206.c                              |  2 +-
 hw/m68k/mcf_intc.c                            |  2 +-
 hw/m68k/next-cube.c                           |  2 +-
 hw/m68k/q800.c                                |  4 +-
 hw/m68k/virt.c                                | 10 +--
 hw/mem/sparse-mem.c                           |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c           | 12 ++--
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  8 +--
 hw/mips/boston.c                              |  4 +-
 hw/mips/jazz.c                                | 12 ++--
 hw/mips/loongson3_virt.c                      |  6 +-
 hw/mips/malta.c                               |  4 +-
 hw/misc/empty_slot.c                          |  2 +-
 hw/misc/led.c                                 |  2 +-
 hw/misc/sifive_e_prci.c                       |  2 +-
 hw/misc/sifive_test.c                         |  2 +-
 hw/net/lan9118.c                              |  2 +-
 hw/net/smc91c111.c                            |  2 +-
 hw/net/spapr_llan.c                           |  2 +-
 hw/net/xen_nic.c                              |  2 +-
 hw/nitro/machine.c                            |  4 +-
 hw/nitro/nitro-vsock-bus.c                    |  2 +-
 hw/nvme/ctrl.c                                |  2 +-
 hw/nvram/fw_cfg.c                             |  4 +-
 hw/or1k/or1k-sim.c                            |  6 +-
 hw/or1k/virt.c                                |  8 +--
 hw/pci-bridge/pci_expander_bridge.c           |  4 +-
 hw/pci-host/astro.c                           |  2 +-
 hw/pci-host/bonito.c                          |  2 +-
 hw/pci-host/pnv_phb4_pec.c                    |  2 +-
 hw/pci/pci.c                                  |  2 +-
 hw/ppc/amigaone.c                             |  2 +-
 hw/ppc/e500.c                                 | 22 +++---
 hw/ppc/mac_newworld.c                         | 18 ++---
 hw/ppc/mac_oldworld.c                         |  8 +--
 hw/ppc/pnv.c                                  |  4 +-
 hw/ppc/pnv_bmc.c                              |  2 +-
 hw/ppc/ppc440_bamboo.c                        |  4 +-
 hw/ppc/prep.c                                 |  4 +-
 hw/ppc/sam460ex.c                             | 16 ++---
 hw/ppc/spapr.c                                |  4 +-
 hw/ppc/spapr_irq.c                            |  2 +-
 hw/ppc/spapr_vio.c                            |  2 +-
 hw/ppc/virtex_ml507.c                         |  6 +-
 hw/remote/machine.c                           |  2 +-
 hw/riscv/boston-aia.c                         |  4 +-
 hw/riscv/microblaze-v-generic.c               | 14 ++--
 hw/riscv/microchip_pfsoc.c                    |  2 +-
 hw/riscv/sifive_u.c                           |  4 +-
 hw/riscv/virt.c                               |  8 +--
 hw/rtc/sun4v-rtc.c                            |  2 +-
 hw/s390x/ap-bridge.c                          |  2 +-
 hw/s390x/css-bridge.c                         |  2 +-
 hw/s390x/s390-pci-bus.c                       |  2 +-
 hw/s390x/s390-virtio-ccw.c                    |  6 +-
 hw/scsi/lasi_ncr710.c                         |  2 +-
 hw/scsi/ncr53c710.c                           |  4 +-
 hw/scsi/scsi-bus.c                            |  2 +-
 hw/scsi/spapr_vscsi.c                         |  2 +-
 hw/sh4/r2d.c                                  |  6 +-
 hw/sh4/sh7750.c                               |  4 +-
 hw/sparc/leon3.c                              | 10 +--
 hw/sparc/sun4m.c                              | 38 +++++-----
 hw/sparc64/sun4u.c                            | 14 ++--
 hw/ssi/ssi.c                                  |  2 +-
 hw/tricore/tricore_testboard.c                |  2 +-
 hw/ufs/lu.c                                   |  2 +-
 hw/usb/bus.c                                  |  4 +-
 hw/usb/dev-serial.c                           |  2 +-
 hw/vmapple/vmapple.c                          | 20 +++---
 hw/xen/xen-bus.c                              |  2 +-
 hw/xen/xen-legacy-backend.c                   |  2 +-
 hw/xen/xen-pvh-common.c                       |  2 +-
 hw/xtensa/virt.c                              |  2 +-
 hw/xtensa/xtfpga.c                            |  2 +-
 include/hw/core/qdev.h                        | 14 ++--
 include/hw/i2c/i2c.h                          |  2 +-
 include/hw/misc/unimp.h                       |  2 +-
 include/hw/ssi/ssi.h                          |  2 +-
 include/hw/usb/usb.h                          |  2 +-
 migration/migration.c                         |  2 +-
 net/net.c                                     |  4 +-
 .../qom-parent/qdev-new-orphan.cocci          | 18 +++++
 system/qdev-monitor.c                         |  2 +-
 target/mips/cpu.c                             |  2 +-
 target/xtensa/cpu.c                           |  2 +-
 170 files changed, 459 insertions(+), 441 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/qdev-new-orphan.cocci

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e32fed86f9..af40647ccd 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -830,7 +830,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     PCIBus *b;
     int i;
 
-    dev = qdev_new(TYPE_TYPHOON_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_TYPHOON_PCI_HOST_BRIDGE);
 
     s = TYPHOON_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a48c442058..531e3ce276 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -90,7 +90,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
         if (!dinfo) {
             return;
         }
-        card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
+        card = qdev_new_orphan(emmc ? TYPE_EMMC : TYPE_SD_CARD);
 
         /*
          * Force the boot properties of the eMMC device only when the
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index fd08793575..33f7f10531 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -81,7 +81,7 @@ bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
      * SoC has.
      */
     if (ram_size < max_ram_size) {
-        DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+        DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
 
         qdev_prop_set_string(dev, "name", "ram-empty");
         qdev_prop_set_uint64(dev, "size", max_ram_size  - ram_size);
@@ -128,7 +128,7 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
         DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
         DeviceState *dev;
 
-        dev = qdev_new(flashtype);
+        dev = qdev_new_orphan(flashtype);
         if (dinfo) {
             qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
         }
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9b468cd8ac..748db26d41 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -50,7 +50,7 @@ static void mmc_attach_drive(AwR40State *s, AwSdHostState *mmc, int unit,
         exit(1);
     }
 
-    carddev = qdev_new(TYPE_SD_CARD);
+    carddev = qdev_new_orphan(TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a643ae4e27..215741a194 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -89,7 +89,7 @@ static void cubieboard_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(a10), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_new(TYPE_SD_CARD);
+    carddev = qdev_new_orphan(TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 5efe95030c..2b6e61abd0 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -519,7 +519,7 @@ static DeviceState *pl330_create(uint32_t base, OrIRQState *orgate,
     DeviceState *dev;
     int i;
 
-    dev = qdev_new("pl330");
+    dev = qdev_new_orphan("pl330");
     object_property_set_link(OBJECT(dev), "memory",
                              OBJECT(get_system_memory()),
                              &error_fatal);
@@ -687,7 +687,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                           NULL);
 
     /* Multi Core Timer */
-    dev = qdev_new("exynos4210.mct");
+    dev = qdev_new_orphan("exynos4210.mct");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     for (n = 0; n < 4; n++) {
@@ -713,7 +713,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             i2c_irq = s->irq_table[exynos4210_get_irq(EXYNOS4210_HDMI_INTG, 1)];
         }
 
-        dev = qdev_new("exynos4210.i2c");
+        dev = qdev_new_orphan("exynos4210.i2c");
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_connect_irq(busdev, 0, i2c_irq);
@@ -757,7 +757,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          * public datasheet which is very similar (implementing
          * MMC Specification Version 4.0 being the only difference noted)
          */
-        dev = qdev_new(TYPE_S3C_SDHCI);
+        dev = qdev_new_orphan(TYPE_S3C_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
 
         busdev = SYS_BUS_DEVICE(dev);
@@ -767,14 +767,14 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk);
         qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
                                &error_fatal);
     }
 
     /*** Display controller (FIMD) ***/
-    dev = qdev_new("exynos4210.fimd");
+    dev = qdev_new_orphan("exynos4210.fimd");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(system_mem), &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7ebd6c8eb9..6976652370 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -127,7 +127,7 @@ static void imx25_pdk_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e2..ce7693ca7a 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -97,7 +97,7 @@ static void imx8mm_evk_init(MachineState *machine)
 
         blk = blk_by_legacy_dinfo(di);
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 16e9722d14..90cda63b49 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -110,7 +110,7 @@ static void imx8mp_evk_init(MachineState *machine)
 
         blk = blk_by_legacy_dinfo(di);
         bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index c25bbf3c82..8a56165cc2 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -621,7 +621,7 @@ static void integratorcp_init(MachineState *machine)
                              0, ram_size);
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
-    dev = qdev_new(TYPE_INTEGRATOR_CM);
+    dev = qdev_new_orphan(TYPE_INTEGRATOR_CM);
     qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
@@ -654,14 +654,14 @@ static void integratorcp_init(MachineState *machine)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
+        card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
                                &error_fatal);
     }
 
-    dev = qdev_new("pl041");
+    dev = qdev_new_orphan("pl041");
     if (machine->audiodev) {
         qdev_prop_set_string(dev, "audiodev", machine->audiodev);
     }
@@ -673,7 +673,7 @@ static void integratorcp_init(MachineState *machine)
         smc91c111_init(0xc8000000, pic[27]);
     }
 
-    dev = qdev_new("pl110");
+    dev = qdev_new_orphan("pl110");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(address_space_mem), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 530ca9dd96..d2fb4c018b 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -26,7 +26,7 @@ static void max78000_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new(TYPE_MAX78000_SOC);
+    dev = qdev_new_orphan(TYPE_MAX78000_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 6e9d92b1f1..96309e1bfc 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -59,7 +59,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a0ac647c3d..be9d0d6993 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -59,7 +59,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f101c1b7c3..c0ab898f2e 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -508,7 +508,7 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    mms->lan9118 = qdev_new(TYPE_LAN9118);
+    mms->lan9118 = qdev_new_orphan(TYPE_LAN9118);
     qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
@@ -535,7 +535,7 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    mms->lan9118 = qdev_new(TYPE_LAN9118);
+    mms->lan9118 = qdev_new_orphan(TYPE_LAN9118);
     qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ac9366d844..96af49e213 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -299,7 +299,7 @@ static void mps2_common_init(MachineState *machine)
                 rxovrint = qdev_get_gpio_in(orgate_dev, i * 2 + 1);
             }
 
-            dev = qdev_new(TYPE_CMSDK_APB_UART);
+            dev = qdev_new_orphan(TYPE_CMSDK_APB_UART);
             s = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             qdev_prop_set_uint32(dev, "pclk-frq", SYSCLK_FRQ);
@@ -343,7 +343,7 @@ static void mps2_common_init(MachineState *machine)
             qdev_connect_gpio_out(txrx_orgate_dev, 0,
                                   qdev_get_gpio_in(armv7m, uart_txrx_irqno[i]));
 
-            dev = qdev_new(TYPE_CMSDK_APB_UART);
+            dev = qdev_new_orphan(TYPE_CMSDK_APB_UART);
             s = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             qdev_prop_set_uint32(dev, "pclk-frq", SYSCLK_FRQ);
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1ada1a1361..bb1e774764 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -59,7 +59,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
-    dev = qdev_new(TYPE_MSF2_SOC);
+    dev = qdev_new_orphan(TYPE_MSF2_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_prop_set_string(dev, "part-name", "M2S010");
     qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
@@ -83,7 +83,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
 
     /* Attach SPI flash to SPI0 controller */
     spi_bus = qdev_get_child_bus(dev, "spi0");
-    spi_flash = qdev_new("s25sl12801"); /* Spansion S25FL128SDPBHICO */
+    spi_flash = qdev_new_orphan("s25sl12801"); /* Spansion S25FL128SDPBHICO */
     qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 0x8);
     if (dinfo) {
         qdev_prop_set_drive_err(spi_flash, "drive",
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 69e83bdd97..6dd18a67b2 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1249,7 +1249,7 @@ static void musicpal_init(MachineState *machine)
                           qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
 
     /* Logically OR both UART IRQs together */
-    uart_orgate = qdev_new(TYPE_OR_IRQ);
+    uart_orgate = qdev_new_orphan(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
     qdev_connect_gpio_out(uart_orgate, 0,
@@ -1288,7 +1288,7 @@ static void musicpal_init(MachineState *machine)
     }
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
-    dev = qdev_new(TYPE_MV88W8618_ETH);
+    dev = qdev_new_orphan(TYPE_MV88W8618_ETH);
     qemu_configure_nic_device(dev, true, "mv88w8618");
     object_property_set_link(OBJECT(dev), "dma-memory",
                              OBJECT(get_system_memory()), &error_fatal);
@@ -1333,7 +1333,7 @@ static void musicpal_init(MachineState *machine)
     }
     i2c_slave_realize_and_unref(wm8750_dev, i2c, &error_abort);
 
-    dev = qdev_new(TYPE_MV88W8618_AUDIO);
+    dev = qdev_new_orphan(TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), "wm8750", OBJECT(wm8750_dev),
                              NULL);
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index c32deaf43b..cee887c194 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -44,7 +44,7 @@ static void netduino2_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new(TYPE_STM32F205_SOC);
+    dev = qdev_new_orphan(TYPE_STM32F205_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index a90dcbe8c2..65251dfe96 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,7 +44,7 @@ static void netduinoplus2_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new(TYPE_STM32F405_SOC);
+    dev = qdev_new_orphan(TYPE_STM32F405_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e..9e5d5f08f9 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -84,7 +84,7 @@ static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
     DeviceState *flash;
     qemu_irq flash_cs;
 
-    flash = qdev_new(flash_type);
+    flash = qdev_new_orphan(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
     }
@@ -113,7 +113,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, int unit)
             exit(1);
         }
 
-        DeviceState *carddev = qdev_new(TYPE_SD_CARD);
+        DeviceState *carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
 }
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857..10df2d614c 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -61,7 +61,7 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
     DeviceState *flash;
     qemu_irq flash_cs;
 
-    flash = qdev_new(flash_type);
+    flash = qdev_new_orphan(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
     }
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index e801e4308e..70f7791695 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -47,7 +47,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new(TYPE_STM32F405_SOC);
+    dev = qdev_new_orphan(TYPE_STM32F405_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 44f9dd67c3..9115d12fad 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3763,7 +3763,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
 
     omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
 
-    s->ih[0] = qdev_new("omap-intc");
+    s->ih[0] = qdev_new_orphan("omap-intc");
     qdev_prop_set_uint32(s->ih[0], "size", 0x100);
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "arminth_ck"));
     busdev = SYS_BUS_DEVICE(s->ih[0]);
@@ -3773,7 +3773,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     sysbus_connect_irq(busdev, 1,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ));
     sysbus_mmio_map(busdev, 0, 0xfffecb00);
-    s->ih[1] = qdev_new("omap-intc");
+    s->ih[1] = qdev_new_orphan("omap-intc");
     qdev_prop_set_uint32(s->ih[1], "size", 0x800);
     omap_intc_set_iclk(OMAP_INTC(s->ih[1]), omap_findclk(s, "arminth_ck"));
     busdev = SYS_BUS_DEVICE(s->ih[1]);
@@ -3876,7 +3876,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
         warn_report("missing SecureDigital device");
     }
 
-    s->mmc = qdev_new(TYPE_OMAP_MMC);
+    s->mmc = qdev_new_orphan(TYPE_OMAP_MMC);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->mmc), &error_fatal);
     omap_mmc_set_clk(s->mmc, omap_findclk(s, "mmc_ck"));
 
@@ -3888,7 +3888,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                        qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN));
 
     if (dinfo) {
-        DeviceState *card = qdev_new(TYPE_SD_CARD);
+        DeviceState *card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(s->mmc, "sd-bus"),
@@ -3900,7 +3900,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
                                omap_findclk(s, "clk32-kHz"));
 
-    s->gpio = qdev_new("omap-gpio");
+    s->gpio = qdev_new_orphan("omap-gpio");
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->gpio), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
@@ -3917,7 +3917,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->pwt = omap_pwt_init(system_memory, 0xfffb6000,
                            omap_findclk(s, "armxor_ck"));
 
-    s->i2c[0] = qdev_new("omap_i2c");
+    s->i2c[0] = qdev_new_orphan("omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d84443bb7b..d705cc43b4 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -85,7 +85,7 @@ static void orangepi_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(h3), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_new(TYPE_SD_CARD);
+    carddev = qdev_new_orphan(TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428..2d5f51506d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -283,7 +283,7 @@ void raspi_base_machine_init(MachineState *machine,
         error_report("No SD bus found in SOC object");
         exit(1);
     }
-    carddev = qdev_new(TYPE_SD_CARD);
+    carddev = qdev_new_orphan(TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2b9f3271d6..0fce9b624f 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -61,7 +61,7 @@ static const int realview_board_id[] = {
 
 static void split_irq_from_named(DeviceState *src, const char* outname,
                                  qemu_irq out1, qemu_irq out2) {
-    DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
+    DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
 
     qdev_prop_set_uint32(splitter, "num-lines", 2);
 
@@ -180,7 +180,7 @@ static void realview_init(MachineState *machine,
     }
 
     sys_id = is_pb ? 0x01780500 : 0xc1400400;
-    sysctl = qdev_new("realview_sysctl");
+    sysctl = qdev_new_orphan("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", proc_id);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
@@ -188,10 +188,10 @@ static void realview_init(MachineState *machine,
 
     if (is_mpcore) {
         if (is_pb) {
-            dev = qdev_new(TYPE_A9MPCORE_PRIV);
+            dev = qdev_new_orphan(TYPE_A9MPCORE_PRIV);
             qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
         } else {
-            dev = qdev_new("realview_mpcore");
+            dev = qdev_new_orphan("realview_mpcore");
         }
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
         busdev = SYS_BUS_DEVICE(dev);
@@ -212,7 +212,7 @@ static void realview_init(MachineState *machine,
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    pl041 = qdev_new("pl041");
+    pl041 = qdev_new_orphan("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
@@ -230,7 +230,7 @@ static void realview_init(MachineState *machine,
     pl011_create(0x1000c000, pic[15], serial_hd(3));
 
     /* DMA controller is optional, apparently.  */
-    dev = qdev_new("pl081");
+    dev = qdev_new_orphan("pl081");
     object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
@@ -245,7 +245,7 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple("pl061", 0x10014000, pic[7]);
     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
 
-    dev = qdev_new("pl111");
+    dev = qdev_new_orphan("pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -271,7 +271,7 @@ static void realview_init(MachineState *machine,
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
+        card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
@@ -281,7 +281,7 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple("pl031", 0x10017000, pic[10]);
 
     if (!is_pb) {
-        dev = qdev_new("realview_pci");
+        dev = qdev_new_orphan("realview_pci");
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, 0x10019000); /* PCI controller registers */
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 84bbc2f979..af4dfef7f2 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -96,7 +96,7 @@ static void sabrelite_init(MachineState *machine)
                 qemu_irq cs_line;
                 DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
 
-                flash_dev = qdev_new("sst25vf016b");
+                flash_dev = qdev_new_orphan("sst25vf016b");
                 if (dinfo) {
                     qdev_prop_set_drive_err(flash_dev, "drive",
                                             blk_by_legacy_dinfo(dinfo),
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e..47a1a82a39 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -296,7 +296,7 @@ static PFlashCFI01 *sbsa_flash_create1(SBSAMachineState *sms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", SBSA_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -421,7 +421,7 @@ static void create_its(SBSAMachineState *sms)
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new_orphan(itsclass);
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(sms->gic),
                              &error_abort);
@@ -440,7 +440,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
 
     gictype = gicv3_class_name();
 
-    sms->gic = qdev_new(gictype);
+    sms->gic = qdev_new_orphan(gictype);
     qdev_prop_set_uint32(sms->gic, "revision", 3);
     qdev_prop_set_uint32(sms->gic, "num-cpu", smp_cpus);
     /*
@@ -522,7 +522,7 @@ static void create_uart(const SBSAMachineState *sms, int uart,
 {
     hwaddr base = sbsa_ref_memmap[uart].base;
     int irq = sbsa_ref_irqmap[uart];
-    DeviceState *dev = qdev_new(TYPE_PL011);
+    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
@@ -544,7 +544,7 @@ static void create_wdt(const SBSAMachineState *sms)
 {
     hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
     hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
-    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
+    DeviceState *dev = qdev_new_orphan(TYPE_WDT_SBSA);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     int irq = sbsa_ref_irqmap[SBSA_GWDT_WS0];
 
@@ -590,7 +590,7 @@ static void create_ahci(const SBSAMachineState *sms)
     DriveInfo *hd[NUM_SATA_PORTS];
     SysbusAHCIState *sysahci;
 
-    dev = qdev_new("sysbus-ahci");
+    dev = qdev_new_orphan("sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -605,7 +605,7 @@ static void create_xhci(const SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_XHCI];
-    DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+    DeviceState *dev = qdev_new_orphan(TYPE_XHCI_SYSBUS);
     qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -622,7 +622,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
     DeviceState *dev;
     int i;
 
-    dev = qdev_new(TYPE_ARM_SMMUV3);
+    dev = qdev_new_orphan(TYPE_ARM_SMMUV3);
 
     object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
@@ -658,7 +658,7 @@ static void create_pcie(SBSAMachineState *sms,
     PCIHostState *pci;
     int i;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space */
@@ -712,7 +712,7 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 static void create_secure_ec(MemoryRegion *mem)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
-    DeviceState *dev = qdev_new("sbsa-ec");
+    DeviceState *dev = qdev_new_orphan("sbsa-ec");
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     memory_region_add_subregion(mem, base,
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 56ecc828f4..1f816a3965 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1096,7 +1096,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * Create the system-registers object early, because we will
      * need its sysclk output.
      */
-    ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
+    ssys_dev = qdev_new_orphan(TYPE_STELLARIS_SYS);
     object_property_add_child(soc_container, "sys", OBJECT(ssys_dev));
 
     /*
@@ -1123,7 +1123,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint32(ssys_dev, "dc4", board->dc4);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
-    armv7m = qdev_new(TYPE_ARMV7M);
+    armv7m = qdev_new_orphan(TYPE_ARMV7M);
     object_property_add_child(soc_container, "v7m", OBJECT(armv7m));
     qdev_prop_set_uint32(armv7m, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_uint8(armv7m, "num-prio-bits", NUM_PRIO_BITS);
@@ -1157,7 +1157,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         if (DEV_CAP(2, GPTM(i))) {
             SysBusDevice *sbd;
 
-            dev = qdev_new(TYPE_STELLARIS_GPTM);
+            dev = qdev_new_orphan(TYPE_STELLARIS_GPTM);
             sbd = SYS_BUS_DEVICE(dev);
             object_property_add_child(soc_container, "gptm[*]", OBJECT(dev));
             qdev_connect_clock_in(dev, "clk",
@@ -1172,7 +1172,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
     if (DEV_CAP(1, WDT)) {
-        dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
+        dev = qdev_new_orphan(TYPE_LUMINARY_WATCHDOG);
         object_property_add_child(soc_container, "wdg", OBJECT(dev));
         qdev_connect_clock_in(dev, "WDOGCLK",
                               qdev_get_clock_out(ssys_dev, "SYSCLK"));
@@ -1216,7 +1216,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         if (DEV_CAP(2, UART(i))) {
             SysBusDevice *sbd;
 
-            dev = qdev_new("pl011_luminary");
+            dev = qdev_new_orphan("pl011_luminary");
             object_property_add_child(soc_container, "uart[*]", OBJECT(dev));
             sbd = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
@@ -1304,18 +1304,18 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
             dinfo = drive_get(IF_SD, 0, 0);
             blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-            carddev = qdev_new(TYPE_SD_CARD_SPI);
+            carddev = qdev_new_orphan(TYPE_SD_CARD_SPI);
             qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
             qdev_realize_and_unref(carddev,
                                    qdev_get_child_bus(sddev, "sd-bus"),
                                    &error_fatal);
 
-            ssddev = qdev_new("ssd0323");
+            ssddev = qdev_new_orphan("ssd0323");
             object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev));
             qdev_prop_set_uint8(ssddev, "cs", 1);
             qdev_realize_and_unref(ssddev, bus, &error_fatal);
 
-            gpio_d_splitter = qdev_new(TYPE_SPLIT_IRQ);
+            gpio_d_splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
             object_property_add_child(OBJECT(ms), "splitter",
                                       OBJECT(gpio_d_splitter));
             qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
@@ -1337,7 +1337,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (DEV_CAP(4, EMAC)) {
         DeviceState *enet;
 
-        enet = qdev_new("stellaris_enet");
+        enet = qdev_new_orphan("stellaris_enet");
         object_property_add_child(soc_container, "enet", OBJECT(enet));
         if (nd) {
             qdev_set_nic_properties(enet, nd);
@@ -1357,7 +1357,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         };
         DeviceState *gpad;
 
-        gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
+        gpad = qdev_new_orphan(TYPE_STELLARIS_GAMEPAD);
         object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
         for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
             qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 8f93c0036a..8c37d41e63 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,7 +47,7 @@ static void stm32vldiscovery_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new(TYPE_STM32F100_SOC);
+    dev = qdev_new_orphan(TYPE_STM32F100_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 5a3242195a..0c6b04f805 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -646,7 +646,7 @@ static DeviceState *strongarm_gpio_init(hwaddr base,
     DeviceState *dev;
     int i;
 
-    dev = qdev_new(TYPE_STRONGARM_GPIO);
+    dev = qdev_new_orphan(TYPE_STRONGARM_GPIO);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -1642,7 +1642,7 @@ StrongARMState *sa1110_init(const char *cpu_type)
     s->ppc = sysbus_create_varargs(TYPE_STRONGARM_PPC, 0x90060000, NULL);
 
     for (i = 0; sa_serial[i].io_base; i++) {
-        DeviceState *dev = qdev_new(TYPE_STRONGARM_UART);
+        DeviceState *dev = qdev_new_orphan(TYPE_STRONGARM_UART);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c6991a52e6..5e9d76859f 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -226,7 +226,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    sysctl = qdev_new("realview_sysctl");
+    sysctl = qdev_new_orphan("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
     qdev_prop_set_uint32(sysctl, "proc_id", 0x02000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
@@ -248,7 +248,7 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_create_simple("pl050_keyboard", 0x10006000, sic[3]);
     sysbus_create_simple("pl050_mouse", 0x10007000, sic[4]);
 
-    dev = qdev_new("versatile_pci");
+    dev = qdev_new_orphan("versatile_pci");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10001000); /* PCI controller regs */
@@ -284,7 +284,7 @@ static void versatile_init(MachineState *machine, int board_id)
     pl011_create(0x101f3000, pic[14], serial_hd(2));
     pl011_create(0x10009000, sic[6], serial_hd(3));
 
-    dev = qdev_new("pl080");
+    dev = qdev_new_orphan("pl080");
     object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
@@ -302,7 +302,7 @@ static void versatile_init(MachineState *machine, int board_id)
 
     /* The versatile/PB actually has a modified Color LCD controller
        that includes hardware cursor support from the PL111.  */
-    dev = qdev_new("pl110_versatile");
+    dev = qdev_new_orphan("pl110_versatile");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -317,7 +317,7 @@ static void versatile_init(MachineState *machine, int board_id)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
+        card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
@@ -329,7 +329,7 @@ static void versatile_init(MachineState *machine, int board_id)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
+        card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
@@ -344,7 +344,7 @@ static void versatile_init(MachineState *machine, int board_id)
     i2c_slave_create_simple(i2c, "ds1338", 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
-    pl041 = qdev_new("pl041");
+    pl041 = qdev_new_orphan("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f26d8c6f8d..716f55a086 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -241,7 +241,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * this must happen after the CPUs are created because a15mpcore_priv
      * wires itself up to the CPU's generic_timer gpio out lines.
      */
-    dev = qdev_new(privdev);
+    dev = qdev_new_orphan(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
@@ -301,7 +301,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
 
     /* 0x10020000 PL111 CLCD (daughterboard) */
-    dev = qdev_new("pl111");
+    dev = qdev_new_orphan("pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -517,7 +517,7 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
 static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
                                              DriveInfo *di)
 {
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
@@ -592,7 +592,7 @@ static void vexpress_common_init(MachineState *machine)
 
     sys_id = 0x1190f500;
 
-    sysctl = qdev_new("realview_sysctl");
+    sysctl = qdev_new_orphan("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", daughterboard->proc_id);
 
@@ -614,7 +614,7 @@ static void vexpress_common_init(MachineState *machine)
     /* VE_SP810: not modelled */
     /* VE_SERIALPCI: not modelled */
 
-    pl041 = qdev_new("pl041");
+    pl041 = qdev_new_orphan("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
@@ -633,7 +633,7 @@ static void vexpress_common_init(MachineState *machine)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
+        card = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
@@ -659,7 +659,7 @@ static void vexpress_common_init(MachineState *machine)
 
     /* VE_COMPACTFLASH: not modelled */
 
-    dev = qdev_new("pl111");
+    dev = qdev_new_orphan("pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 219597cabd..f8a1ba68be 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1082,7 +1082,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
         event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
     }
 
-    dev = qdev_new(TYPE_ACPI_GED);
+    dev = qdev_new_orphan(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
     sbdev = SYS_BUS_DEVICE(dev);
@@ -1120,7 +1120,7 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
-    dev = qdev_new(its_class_name());
+    dev = qdev_new_orphan(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
@@ -1137,7 +1137,7 @@ static void create_v2m(VirtMachineState *vms)
     int irq = vms->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
-    dev = qdev_new("arm-gicv2m");
+    dev = qdev_new_orphan("arm-gicv2m");
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -1225,7 +1225,7 @@ static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
     const char *gictype = gicv5_class_name();
     QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
 
-    vms->gic = qdev_new(gictype);
+    vms->gic = qdev_new_orphan(gictype);
     qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
 
     object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
@@ -1356,7 +1356,7 @@ static void create_gicv2(VirtMachineState *vms, MemoryRegion *mem)
         exit(1);
     }
 
-    vms->gic = qdev_new(gic_class_name());
+    vms->gic = qdev_new_orphan(gic_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", 2);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -1412,7 +1412,7 @@ static void create_gicv3(VirtMachineState *vms, MemoryRegion *mem)
         exit(1);
     }
 
-    vms->gic = qdev_new(gicv3_class_name());
+    vms->gic = qdev_new_orphan(gicv3_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -1509,7 +1509,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_new(TYPE_PL011);
+    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
@@ -1670,7 +1670,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     SysBusDevice *s;
     MachineState *ms = MACHINE(vms);
 
-    pl061_dev = qdev_new("pl061");
+    pl061_dev = qdev_new_orphan("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
     qdev_prop_set_uint8(pl061_dev, "pullups", 0);
     qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
@@ -1786,7 +1786,7 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -2069,7 +2069,7 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
         return;
     }
 
-    dev = qdev_new(TYPE_ARM_SMMUV3);
+    dev = qdev_new_orphan(TYPE_ARM_SMMUV3);
 
     if (!vmc->no_nested_smmu) {
         object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
@@ -2162,7 +2162,7 @@ static void create_pcie(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
@@ -2290,7 +2290,7 @@ static void create_platform_bus(VirtMachineState *vms)
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c83439017..8c3b47d07a 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -110,7 +110,7 @@ static void gem_init(uint32_t base, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_CADENCE_GEM);
+    dev = qdev_new_orphan(TYPE_CADENCE_GEM);
     qemu_configure_nic_device(dev, true, NULL);
     object_property_set_int(OBJECT(dev), "phy-addr", 7, &error_abort);
     s = SYS_BUS_DEVICE(dev);
@@ -131,7 +131,7 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     int num_busses =  is_qspi ? NUM_QSPI_BUSSES : 1;
     int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
 
-    dev = qdev_new(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    dev = qdev_new_orphan(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
@@ -152,7 +152,7 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new("n25q128");
+            flash_dev = qdev_new_orphan("n25q128");
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
@@ -195,7 +195,7 @@ static void ddr_ctrl_init(uint32_t base)
     DeviceState *dev;
     SysBusDevice *busdev;
 
-    dev = qdev_new("zynq.ddr-ctlr");
+    dev = qdev_new_orphan("zynq.ddr-ctlr");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base);
@@ -256,13 +256,13 @@ static void zynq_init(MachineState *machine)
     clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
 
     /* Create slcr, keep a pointer to connect clocks */
-    slcr = qdev_new("xilinx-zynq_slcr");
+    slcr = qdev_new_orphan("xilinx-zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
     qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
-    dev = qdev_new(TYPE_A9MPCORE_PRIV);
+    dev = qdev_new_orphan(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
@@ -290,7 +290,7 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
 
-    dev = qdev_new(TYPE_CADENCE_UART);
+    dev = qdev_new_orphan(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     qdev_connect_clock_in(dev, "refclk",
@@ -298,7 +298,7 @@ static void zynq_init(MachineState *machine)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0000000);
     sysbus_connect_irq(busdev, 0, pic[59 - GIC_INTERNAL]);
-    dev = qdev_new(TYPE_CADENCE_UART);
+    dev = qdev_new_orphan(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
     qdev_connect_clock_in(dev, "refclk",
@@ -329,7 +329,7 @@ static void zynq_init(MachineState *machine)
          * - SDIO Specification Version 2.0
          * - MMC Specification Version 3.31
          */
-        dev = qdev_new(TYPE_SYSBUS_SDHCI);
+        dev = qdev_new_orphan(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -338,18 +338,18 @@ static void zynq_init(MachineState *machine)
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
                                &error_fatal);
     }
 
-    dev = qdev_new(TYPE_ZYNQ_XADC);
+    dev = qdev_new_orphan(TYPE_ZYNQ_XADC);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-GIC_INTERNAL]);
 
-    dev = qdev_new("pl330");
+    dev = qdev_new_orphan("pl330");
     object_property_set_link(OBJECT(dev), "memory",
                              OBJECT(address_space_mem),
                              &error_fatal);
@@ -372,7 +372,7 @@ static void zynq_init(MachineState *machine)
         sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - GIC_INTERNAL]);
     }
 
-    dev = qdev_new("xlnx.ps7-dev-cfg");
+    dev = qdev_new_orphan("xlnx.ps7-dev-cfg");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0, pic[40 - GIC_INTERNAL]);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2b04513ba2..48f6e6d463 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -143,7 +143,7 @@ static void create_virtio_regions(VersalVirt *s)
         qemu_irq pic_irq;
 
         pic_irq = versal_get_reserved_irq(&s->soc, i, &dtb_irq);
-        dev = qdev_new("virtio-mmio");
+        dev = qdev_new_orphan("virtio-mmio");
         object_property_add_child(OBJECT(s), "virtio-mmio[*]", OBJECT(dev));
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index facf92b45c..7cb95a4ff8 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -514,7 +514,7 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
     if (split == NULL) {
         size_t i;
 
-        split = qdev_new(TYPE_SPLIT_IRQ);
+        split = qdev_new_orphan(TYPE_SPLIT_IRQ);
         qdev_prop_set_uint16(split, "num-lines", s->intc->len);
         object_property_add_child(container, name, OBJECT(split));
         qdev_realize_and_unref(split, NULL, &error_abort);
@@ -562,7 +562,7 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
-        dev = qdev_new(TYPE_OR_IRQ);
+        dev = qdev_new_orphan(TYPE_OR_IRQ);
         object_property_add_child(container, name, OBJECT(dev));
         qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
         qdev_realize_and_unref(dev, NULL, &error_abort);
@@ -664,7 +664,7 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
 {
     DeviceState *or;
 
-    or = qdev_new(TYPE_OR_IRQ);
+    or = qdev_new_orphan(TYPE_OR_IRQ);
     qdev_prop_set_uint16(or, "num-lines", num_lines);
     object_property_add_child(parent, name, OBJECT(or));
     qdev_realize_and_unref(or, NULL, &error_abort);
@@ -713,7 +713,7 @@ static void versal_create_gic_its(Versal *s,
         return;
     }
 
-    dev = qdev_new(TYPE_ARM_GICV3_ITS);
+    dev = qdev_new_orphan(TYPE_ARM_GICV3_ITS);
     sbd = SYS_BUS_DEVICE(dev);
 
     object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
@@ -755,11 +755,11 @@ static DeviceState *versal_create_gic(Versal *s,
 
     switch (map->gic.version) {
     case 2:
-        dev = qdev_new(gic_class_name());
+        dev = qdev_new_orphan(gic_class_name());
         break;
 
     case 3:
-        dev = qdev_new(gicv3_class_name());
+        dev = qdev_new_orphan(gicv3_class_name());
         break;
 
     default:
@@ -909,7 +909,7 @@ static DeviceState *versal_create_cpu(Versal *s,
                                       size_t cluster_idx,
                                       size_t core_idx)
 {
-    DeviceState *cpu = qdev_new(map->cpu_model);
+    DeviceState *cpu = qdev_new_orphan(map->cpu_model);
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     Object *obj = OBJECT(cpu);
     uint64_t affinity;
@@ -960,7 +960,7 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
     const char compatible[] = "arm,armv8-timer";
     bool has_gtimer;
 
-    cluster = qdev_new(TYPE_CPU_CLUSTER);
+    cluster = qdev_new_orphan(TYPE_CPU_CLUSTER);
     name = g_strdup_printf("%s-cluster", map->name);
     object_property_add_child(OBJECT(s), name, OBJECT(cluster));
     g_free(name);
@@ -1028,7 +1028,7 @@ static void versal_create_uart(Versal *s,
     const char compatible[] = "arm,pl011\0arm,sbsa-uart";
     const char clocknames[] = "uartclk\0apb_pclk";
 
-    dev = qdev_new(TYPE_PL011);
+    dev = qdev_new_orphan(TYPE_PL011);
     object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -1067,7 +1067,7 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
     const char compatible[] = "xlnx,canfd-2.0";
     const char clocknames[] = "can_clk\0s_axi_aclk";
 
-    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XILINX_CANFD));
+    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XILINX_CANFD));
     object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
 
     object_property_set_int(OBJECT(sbd), "ext_clk_freq",
@@ -1107,7 +1107,7 @@ static void versal_create_usb(Versal *s,
     const char compat_versal_dwc3[] = "xlnx,versal-dwc3";
     const char compat_dwc3[] = "snps,dwc3";
 
-    dev = qdev_new(TYPE_XILINX_VERSAL_USB2);
+    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_USB2);
     object_property_add_child(OBJECT(s), "usb[*]", OBJECT(dev));
 
     object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
@@ -1167,7 +1167,7 @@ static void versal_create_gem(Versal *s,
     DeviceState *or;
     int i;
 
-    dev = qdev_new(TYPE_CADENCE_GEM);
+    dev = qdev_new_orphan(TYPE_CADENCE_GEM);
     object_property_add_child(OBJECT(s), "gem[*]", OBJECT(dev));
 
     qemu_configure_nic_device(dev, true, NULL);
@@ -1251,7 +1251,7 @@ static void versal_create_zdma(Versal *s,
         int irq = map->map.irq + map->irq_stride * i;
         g_autofree char *node;
 
-        dev = qdev_new(TYPE_XLNX_ZDMA);
+        dev = qdev_new_orphan(TYPE_XLNX_ZDMA);
         object_property_add_child(OBJECT(s), name, OBJECT(dev));
         object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         object_property_set_link(OBJECT(dev), "dma",
@@ -1286,7 +1286,7 @@ static void versal_create_sdhci(Versal *s,
     const char compatible[] = "arasan,sdhci-8.9a";
     const char clocknames[] = "clk_xin\0clk_ahb";
 
-    dev = qdev_new(TYPE_SYSBUS_SDHCI);
+    dev = qdev_new_orphan(TYPE_SYSBUS_SDHCI);
     object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
 
     object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
@@ -1320,7 +1320,7 @@ static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
     const char compatible[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
 
-    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_ZYNQMP_RTC));
+    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_ZYNQMP_RTC));
     object_property_add_child(OBJECT(s), "rtc", OBJECT(sbd));
     sysbus_realize_and_unref(sbd, &error_abort);
 
@@ -1349,7 +1349,7 @@ static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
     SysBusDevice *sbd;
     MemoryRegion *mr;
 
-    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_VERSAL_TRNG));
+    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_VERSAL_TRNG));
     object_property_add_child(OBJECT(s), "trng", OBJECT(sbd));
     sysbus_realize_and_unref(sbd, &error_abort);
 
@@ -1370,7 +1370,7 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
     for (i = 0; i < map->num; i++) {
         hwaddr ctrl, mem;
 
-        sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_XRAM_CTRL));
+        sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_XRAM_CTRL));
         object_property_add_child(OBJECT(s), "xram[*]", OBJECT(sbd));
         sysbus_realize_and_unref(sbd, &error_fatal);
 
@@ -1392,7 +1392,7 @@ static void versal_create_bbram(Versal *s,
     DeviceState *dev;
     SysBusDevice *sbd;
 
-    dev = qdev_new(TYPE_XLNX_BBRAM);
+    dev = qdev_new_orphan(TYPE_XLNX_BBRAM);
     sbd = SYS_BUS_DEVICE(dev);
 
     object_property_add_child(OBJECT(s), "bbram", OBJECT(dev));
@@ -1415,9 +1415,9 @@ static void versal_create_efuse(Versal *s,
         return;
     }
 
-    ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
-    cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
-    bits = qdev_new(TYPE_XLNX_EFUSE);
+    ctrl = qdev_new_orphan(TYPE_XLNX_VERSAL_EFUSE_CTRL);
+    cache = qdev_new_orphan(TYPE_XLNX_VERSAL_EFUSE_CACHE);
+    bits = qdev_new_orphan(TYPE_XLNX_EFUSE);
 
     qdev_prop_set_uint32(bits, "efuse-nr", 3);
     qdev_prop_set_uint32(bits, "efuse-size", 8192);
@@ -1451,7 +1451,7 @@ static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
     SysBusDevice *sbd;
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
     object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
 
     sbd = SYS_BUS_DEVICE(dev);
@@ -1473,7 +1473,7 @@ static DeviceState *versal_create_ospi(Versal *s,
     DeviceState *dev, *dma_dst, *dma_src, *orgate;
     MemoryRegion *linear_mr = g_new(MemoryRegion, 1);
 
-    dev = qdev_new(TYPE_XILINX_VERSAL_OSPI);
+    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_OSPI);
     object_property_add_child(OBJECT(s), "ospi", OBJECT(dev));
 
     memory_region_init(linear_mr, OBJECT(dev), "linear-mr", map->dac_sz);
@@ -1482,7 +1482,7 @@ static DeviceState *versal_create_ospi(Versal *s,
     memory_region_add_subregion(linear_mr, 0x0, mr_dac);
 
     /* Create the OSPI destination DMA */
-    dma_dst = qdev_new(TYPE_XLNX_CSU_DMA);
+    dma_dst = qdev_new_orphan(TYPE_XLNX_CSU_DMA);
     object_property_add_child(OBJECT(dev), "dma-dst-dev", OBJECT(dma_dst));
     object_property_set_link(OBJECT(dma_dst), "dma",
                              OBJECT(get_system_memory()), &error_abort);
@@ -1494,7 +1494,7 @@ static DeviceState *versal_create_ospi(Versal *s,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Create the OSPI source DMA */
-    dma_src = qdev_new(TYPE_XLNX_CSU_DMA);
+    dma_src = qdev_new_orphan(TYPE_XLNX_CSU_DMA);
     object_property_add_child(OBJECT(dev), "dma-src-dev", OBJECT(dma_src));
 
     object_property_set_bool(OBJECT(dma_src), "is-dst", false, &error_abort);
@@ -1548,7 +1548,7 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     object_unref(container);
 
     /* CFU FDRO */
-    cfu_fdro = qdev_new(TYPE_XLNX_VERSAL_CFU_FDRO);
+    cfu_fdro = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_FDRO);
     object_property_add_child(container, "cfu-fdro", OBJECT(cfu_fdro));
     sbd = SYS_BUS_DEVICE(cfu_fdro);
 
@@ -1557,15 +1557,15 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* cframe bcast */
-    cframe_bcast = qdev_new(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+    cframe_bcast = qdev_new_orphan(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
     object_property_add_child(container, "cframe-bcast", OBJECT(cframe_bcast));
 
     /* CFU APB */
-    cfu_apb = qdev_new(TYPE_XLNX_VERSAL_CFU_APB);
+    cfu_apb = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_APB);
     object_property_add_child(container, "cfu-apb", OBJECT(cfu_apb));
 
     /* IRQ or gate for cframes */
-    cframe_irq_or = qdev_new(TYPE_OR_IRQ);
+    cframe_irq_or = qdev_new_orphan(TYPE_OR_IRQ);
     object_property_add_child(container, "cframe-irq-or-gate",
                               OBJECT(cframe_irq_or));
     qdev_prop_set_uint16(cframe_irq_or, "num-lines", map->num_cframe);
@@ -1580,7 +1580,7 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
         g_autofree char *prop_name;
         size_t j;
 
-        dev = qdev_new(TYPE_XLNX_VERSAL_CFRAME_REG);
+        dev = qdev_new_orphan(TYPE_XLNX_VERSAL_CFRAME_REG);
         object_property_add_child(container, "cframe[*]", OBJECT(dev));
 
         sbd = SYS_BUS_DEVICE(dev);
@@ -1632,7 +1632,7 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     versal_sysbus_connect_irq(s, sbd, 0, map->cfu_apb_irq);
 
     /* CFU SFR */
-    cfu_sfr = qdev_new(TYPE_XLNX_VERSAL_CFU_SFR);
+    cfu_sfr = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_SFR);
     object_property_add_child(container, "cfu-sfr", OBJECT(cfu_sfr));
     sbd = SYS_BUS_DEVICE(cfu_sfr);
 
@@ -1676,7 +1676,7 @@ static inline void versal_create_crl(Versal *s)
     ver = versal_get_version(s);
 
     crl_class = xlnx_versal_crl_class_name(ver);
-    dev = qdev_new(crl_class);
+    dev = qdev_new_orphan(crl_class);
     obj = OBJECT(dev);
     object_property_add_child(OBJECT(s), "crl", obj);
 
@@ -1761,7 +1761,7 @@ static void versal_unimp_area(Versal *s, const char *name,
                                 MemoryRegion *mr,
                                 hwaddr base, hwaddr size)
 {
-    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
     MemoryRegion *mr_dev;
 
     qdev_prop_set_string(dev, "name", name);
@@ -1972,7 +1972,7 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
         return;
     }
 
-    card = qdev_new(TYPE_SD_CARD);
+    card = qdev_new_orphan(TYPE_SD_CARD);
     object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
     qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
     qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
@@ -2015,7 +2015,7 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
     ospi = DEVICE(versal_get_child(s, "ospi"));
     spi_bus = qdev_get_child_bus(ospi, "spi0");
 
-    flash = qdev_new(flash_mdl);
+    flash = qdev_new_orphan(flash_mdl);
 
     if (blk) {
         qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4e48970274..adff52eaf6 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -187,7 +187,7 @@ static void xlnx_zcu102_init(MachineState *machine)
             error_report("No SD bus found for SD card %d", i);
             exit(1);
         }
-        carddev = qdev_new(TYPE_SD_CARD);
+        carddev = qdev_new_orphan(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
@@ -202,7 +202,7 @@ static void xlnx_zcu102_init(MachineState *machine)
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = qdev_new("sst25wf080");
+        flash_dev = qdev_new_orphan("sst25wf080");
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
@@ -226,7 +226,7 @@ static void xlnx_zcu102_init(MachineState *machine)
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = qdev_new("n25q512a11");
+        flash_dev = qdev_new_orphan("n25q512a11");
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 979e55e305..861ee35839 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -365,7 +365,7 @@ static void xlnx_zynqmp_create_unimp_mmio(XlnxZynqMPState *s)
 
     for (nr = 0; nr < ARRAY_SIZE(unimp_areas); nr++) {
         const struct UnimpInfo *info = &unimp_areas[nr];
-        DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+        DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
         SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
         assert(info->name && info->base && info->size > 0);
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index d7c2c3c2fd..cd4743a405 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1313,7 +1313,7 @@ static void intel_hda_and_codec_init(const char *audiodev)
     intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
     hdabus = QLIST_FIRST(&intel_hda->child_bus);
 
-    codec = qdev_new("hda-duplex");
+    codec = qdev_new_orphan("hda-duplex");
     qdev_prop_set_string(codec, "audiodev", audiodev);
     qdev_realize_and_unref(codec, hdabus, &error_fatal);
     object_unref(intel_hda);
diff --git a/hw/audio/model.c b/hw/audio/model.c
index 86a5419b09..bd8ca35153 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -110,7 +110,7 @@ void audio_model_init(void)
     }
 
     if (c->typename) {
-        DeviceState *dev = qdev_new(c->typename);
+        DeviceState *dev = qdev_new_orphan(c->typename);
         BusState *bus = qdev_find_default_bus(DEVICE_GET_CLASS(dev), &error_fatal);
         qdev_prop_set_string(dev, "audiodev", audiodev_id);
         qdev_realize_and_unref(dev, bus, &error_fatal);
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 280f613af3..a85bdf929a 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -284,7 +284,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
      * 0x20 - 0x5f: I/O memory
      * 0x60 - 0xff: Extended I/O
      */
-    s->io = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    s->io = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(s->io, "name", "I/O");
     qdev_prop_set_uint64(s->io, "size", mc->io_size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->io), &error_fatal);
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index ab57dfd83e..4050750e65 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -102,7 +102,7 @@ void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds)
     SysBusDevice *sbd;
     FDCtrlSysBus *sys;
 
-    dev = qdev_new("sysbus-fdc");
+    dev = qdev_new_orphan("sysbus-fdc");
     sys = SYSBUS_FDC(dev);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sbd, &error_fatal);
@@ -118,7 +118,7 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
     DeviceState *dev;
     FDCtrlSysBus *sys;
 
-    dev = qdev_new("sun-fdtwo");
+    dev = qdev_new_orphan("sun-fdtwo");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sys = SYSBUS_FDC(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(sys), 0, irq);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2c1681b7d0..baac5f3c19 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2329,7 +2329,7 @@ void fdctrl_init_drives(FloppyBus *bus, DriveInfo **fds)
 
     for (i = 0; i < MAX_FD; i++) {
         if (fds[i]) {
-            dev = qdev_new("floppy");
+            dev = qdev_new_orphan("floppy");
             qdev_prop_set_uint32(dev, "unit", i);
             qdev_prop_set_enum(dev, "drive-type", FLOPPY_DRIVE_TYPE_AUTO);
             qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(fds[i]),
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5b9ddb20b1..0466682ca8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -958,7 +958,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id2, uint16_t id3,
                                    int be)
 {
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6f952fe7de..a22bdc5830 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -1005,7 +1005,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    uint16_t unlock_addr1,
                                    int be)
 {
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI02);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI02);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 474c12fe4a..9dd69faa02 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -1074,7 +1074,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new(type));
+    xendev = XEN_DEVICE(qdev_new_orphan(type));
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
     if (!object_property_set_str(OBJECT(xendev), "vdev", vdev,
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 46fc4e31b8..6bc18851d9 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -659,7 +659,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     DeviceState  *dev;
     SysBusDevice *bus;
 
-    dev = qdev_new(TYPE_EXYNOS4210_UART);
+    dev = qdev_new_orphan(TYPE_EXYNOS4210_UART);
 
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "channel", channel);
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 24fd42da06..f4fc47364e 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -351,7 +351,7 @@ DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chrdrv)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_MCF_UART);
+    dev = qdev_new_orphan(TYPE_MCF_UART);
     if (chrdrv) {
         qdev_prop_set_chr(dev, "chardev", chrdrv);
     }
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index 6673721454..1a6d736f56 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -150,7 +150,7 @@ MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
                                                hwaddr base,
                                                qemu_irq irq, Chardev *chr)
 {
-    DeviceState *dev = qdev_new(TYPE_MCHP_PFSOC_UART);
+    DeviceState *dev = qdev_new_orphan(TYPE_MCHP_PFSOC_UART);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224..c8adf964ca 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -38,7 +38,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("pl011");
+    dev = qdev_new_orphan("pl011");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 0e0be26fa9..cd0844c450 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -99,7 +99,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end)
 {
-    SerialMM *smm = SERIAL_MM(qdev_new(TYPE_SERIAL_MM));
+    SerialMM *smm = SERIAL_MM(qdev_new_orphan(TYPE_SERIAL_MM));
     MemoryRegion *mr;
 
     qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b9bbaaef59..1613a975e0 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -399,7 +399,7 @@ SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("riscv.sifive.uart");
+    dev = qdev_new_orphan("riscv.sifive.uart");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 1dd9fb155c..a331d4be3b 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -158,7 +158,7 @@ void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
 
-    dev = qdev_new("spapr-vty");
+    dev = qdev_new_orphan("spapr-vty");
     qdev_prop_set_chr(dev, "chardev", chardev);
     qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
 }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index bdeb76dc87..57520192b9 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -562,7 +562,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new(TYPE_XEN_CONSOLE_DEVICE));
+    xendev = XEN_DEVICE(qdev_new_orphan(TYPE_XEN_CONSOLE_DEVICE));
     con = XEN_CONSOLE_DEVICE(xendev);
 
     con->dev = number;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e2aab3d1fc..8a8d206a02 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -145,12 +145,12 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
-DeviceState *qdev_new(const char *name)
+DeviceState *qdev_new_orphan(const char *name)
 {
     return DEVICE(object_new(name));
 }
 
-DeviceState *qdev_try_new(const char *name)
+DeviceState *qdev_try_new_orphan(const char *name)
 {
     ObjectClass *oc = module_object_class_by_name(name);
     if (!oc) {
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3e1160ee92..fe8baf73b5 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -218,7 +218,7 @@ DeviceState *sysbus_create_varargs(const char *name,
     qemu_irq irq;
     int n;
 
-    dev = qdev_new(name);
+    dev = qdev_new_orphan(name);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     if (addr != (hwaddr)-1) {
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1..c7a40a81f0 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -26,7 +26,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
 {
     ERRP_GUARD();
-    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
+    DeviceState *dev = qdev_new_orphan(TYPE_CXL_FMW);
     CXLFixedWindow *fw = CXL_FMW(dev);
     strList *target;
     int i;
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index cacb6c87ec..1e47e6a32b 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1956,7 +1956,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
     /* i2c */
     s->i2c_bus = i2c_init_bus(dev, "sm501.i2c");
     /* ddc */
-    I2CDDCState *ddc = I2CDDC(qdev_new(TYPE_I2CDDC));
+    I2CDDCState *ddc = I2CDDC(qdev_new_orphan(TYPE_I2CDDC));
     i2c_slave_set_address(I2C_SLAVE(ddc), 0x50);
     qdev_realize_and_unref(DEVICE(ddc), BUS(s->i2c_bus), &error_abort);
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 98126ef320..e8490d644d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1346,11 +1346,11 @@ static void xlnx_dp_init(Object *obj)
      * child properties of this device, we can drop the reference we
      * hold to them, leaving the child-property as the only reference.
      */
-    s->dpcd = DPCD(qdev_new("dpcd"));
+    s->dpcd = DPCD(qdev_new_orphan("dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
     object_unref(s->dpcd);
 
-    s->edid = I2CDDC(qdev_new("i2c-ddc"));
+    s->edid = I2CDDC(qdev_new_orphan("i2c-ddc"));
     i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
     object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
     object_unref(s->edid);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 546ff67908..ab8aaf7da4 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -747,7 +747,7 @@ DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_RC4030);
+    dev = qdev_new_orphan(TYPE_RC4030);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     *dmas = rc4030_allocate_dmas(dev, 4);
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index aa49399322..712749cda8 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -131,14 +131,14 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
                            machine->ram_size, &error_fatal);
     memory_region_add_subregion(address_space, 0x0, &hms->ram);
 
-    glob_regs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
+    glob_regs_dev = qdev_new_orphan(TYPE_HEXAGON_GLOBALREG);
     object_property_add_child(OBJECT(machine), "global-regs",
                               OBJECT(glob_regs_dev));
     qdev_prop_set_uint64(glob_regs_dev, "config-table-addr", m_cfg->cfgbase);
     qdev_prop_set_uint32(glob_regs_dev, "dsp-rev", rev);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
 
-    tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
+    tlb_dev = qdev_new_orphan(TYPE_HEXAGON_TLB);
     object_property_add_child(OBJECT(machine), "tlb", OBJECT(tlb_dev));
     qdev_prop_set_uint32(tlb_dev, "num-entries",
                          m_cfg->cfgtable.jtlb_size_entries);
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index a3638998b8..a7a6a8fbeb 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -129,7 +129,7 @@ static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_PL011);
+    dev = qdev_new_orphan(TYPE_PL011);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     qdev_connect_clock_in(dev, "clk", vms->apb_clk);
@@ -268,13 +268,13 @@ static void virt_init(MachineState *ms)
                                 &vms->parent_obj.cfgtable_rom);
     fdt_add_hvx(vms, m_cfg);
 
-    gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
+    gsregs_dev = qdev_new_orphan(TYPE_HEXAGON_GLOBALREG);
     object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
     qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
     qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
 
-    tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
+    tlb_dev = qdev_new_orphan(TYPE_HEXAGON_TLB);
     object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
     qdev_prop_set_uint32(tlb_dev, "num-entries",
                          m_cfg->cfgtable.jtlb_size_entries);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d762163ddf..02cafbda85 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -265,7 +265,7 @@ static LasiState *lasi_init(void)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_LASI_CHIP);
+    dev = qdev_new_orphan(TYPE_LASI_CHIP);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return LASI_CHIP(dev);
@@ -275,7 +275,7 @@ static DinoState *dino_init(MemoryRegion *addr_space)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_DINO_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_DINO_PCI_HOST_BRIDGE);
     object_property_set_link(OBJECT(dev), "memory-as", OBJECT(addr_space),
                              &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -411,7 +411,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     lasi_dev = hpm->lasi_dev;
     if (lasi_dev && machine->enable_graphics &&
         vga_interface_type != VGA_NONE) {
-        dev = qdev_new("artist");
+        dev = qdev_new_orphan("artist");
         s = SYS_BUS_DEVICE(dev);
         bool disabled = object_property_get_bool(OBJECT(dev), "disable", NULL);
         if (!disabled) {
@@ -614,7 +614,7 @@ static void machine_HP_715_init(MachineState *machine)
                      parallel_hds[0]);
 
     /* PS/2 Keyboard/Mouse */
-    dev = qdev_new(TYPE_LASIPS2);
+    dev = qdev_new_orphan(TYPE_LASIPS2);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
@@ -706,7 +706,7 @@ static void machine_HP_B160L_init(MachineState *machine)
                      parallel_hds[0]);
 
     /* PS/2 Keyboard/Mouse */
-    dev = qdev_new(TYPE_LASIPS2);
+    dev = qdev_new_orphan(TYPE_LASIPS2);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
@@ -733,7 +733,7 @@ static AstroState *astro_init(void)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_ASTRO_CHIP);
+    dev = qdev_new_orphan(TYPE_ASTRO_CHIP);
     object_property_set_int(OBJECT(dev), "phys-addr-bits",
                             hppa_phys_addr_bits(&cpu[0]->env),
                             &error_abort);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 54f6bdca88..7803f6113c 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -368,7 +368,7 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
-    dev = qdev_new(name);
+    dev = qdev_new_orphan(name);
     qdev_prop_set_uint8(dev, "address", addr);
     return I2C_SLAVE(dev);
 }
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 693d476220..59fe07b16b 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -164,7 +164,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_SMBUS_EEPROM);
+    dev = qdev_new_orphan(TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
     /* FIXME: use an array of byte or block backend property? */
     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e7adab7d2e..08d54c277f 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -108,7 +108,7 @@ static void create_gpex(MicrovmMachineState *mms)
     DeviceState *dev;
     int i;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space */
@@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     /* Optional and legacy devices */
     if (x86_machine_is_acpi_enabled(x86ms)) {
-        DeviceState *dev = qdev_new(TYPE_ACPI_GED);
+        DeviceState *dev = qdev_new_orphan(TYPE_ACPI_GED);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
@@ -216,7 +216,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (x86_machine_is_acpi_enabled(x86ms) && machine_usb(MACHINE(mms))) {
-        DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+        DeviceState *dev = qdev_new_orphan(TYPE_XHCI_SYSBUS);
         qdev_prop_set_uint32(dev, "intrs", 1);
         qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
         qdev_prop_set_uint32(dev, "p2", 8);
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 1ce9ee3358..fcad27bd9b 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -46,7 +46,7 @@ static BusState *find_free_virtio_mmio_bus(void)
 
 static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
 {
-    DeviceState *dev = qdev_new(TYPE_VHOST_USER_VSOCK);
+    DeviceState *dev = qdev_new_orphan(TYPE_VHOST_USER_VSOCK);
     VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
     BusState *bus;
 
@@ -75,7 +75,7 @@ static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
 
 static void virtio_nsm_init(NitroEnclaveMachineState *nems)
 {
-    DeviceState *dev = qdev_new(TYPE_VIRTIO_NSM);
+    DeviceState *dev = qdev_new_orphan(TYPE_VIRTIO_NSM);
     VirtIONSM *vnsm = VIRTIO_NSM(dev);
     BusState *bus = find_free_virtio_mmio_bus();
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e..bd5ab3d854 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1065,7 +1065,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
 
-        hpet = qdev_try_new(TYPE_HPET);
+        hpet = qdev_try_new_orphan(TYPE_HPET);
         if (!hpet) {
             error_report("couldn't create HPET device");
             exit(1);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..e580f9f2a6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -193,7 +193,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
 
-    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    phb = OBJECT(qdev_new_orphan(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                              OBJECT(ram_memory), &error_fatal);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f..0731403e55 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -199,7 +199,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* create pci host bus */
-    phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
+    phb = OBJECT(qdev_new_orphan(TYPE_Q35_HOST_DEVICE));
 
     pci_hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..d351e3da77 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -79,7 +79,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
                                      const char *name,
                                      const char *alias_prop_name)
 {
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 1);
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 7e4c509f5a..c326385456 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -311,7 +311,7 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
                                 &sgx_epc->mr);
 
     for (list = x86ms->sgx_epc_list; list; list = list->next) {
-        DeviceState *dev = qdev_new(TYPE_SGX_EPC);
+        DeviceState *dev = qdev_new_orphan(TYPE_SGX_EPC);
 
         /* set the memdev link with memory backend */
         object_property_parse(OBJECT(dev), SGX_EPC_MEMDEV_PROP,
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 8f9419e7d3..b8e541e376 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -505,9 +505,9 @@ void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
 
     assert(parent);
     if (kvm_ioapic_in_kernel()) {
-        dev = qdev_new(TYPE_KVM_IOAPIC);
+        dev = qdev_new_orphan(TYPE_KVM_IOAPIC);
     } else {
-        dev = qdev_new(TYPE_IOAPIC);
+        dev = qdev_new_orphan(TYPE_IOAPIC);
     }
     object_property_add_child(parent, "ioapic", OBJECT(dev));
     d = SYS_BUS_DEVICE(dev);
@@ -525,7 +525,7 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
     SysBusDevice *d;
     unsigned int i;
 
-    dev = qdev_new(TYPE_IOAPIC);
+    dev = qdev_new_orphan(TYPE_IOAPIC);
     d = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(d, &error_fatal);
     sysbus_mmio_map(d, 0, IO_APIC_SECONDARY_ADDRESS);
diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 168526003d..2fb865490e 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -547,7 +547,7 @@ I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
 {
     DeviceState *dev;
 
-    dev = qdev_new(name);
+    dev = qdev_new_orphan(name);
     qdev_prop_set_uint8(dev, "static-address", addr);
     qdev_prop_set_uint8(dev, "dcr", dcr);
     qdev_prop_set_uint8(dev, "bcr", bcr);
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index b24e4d17b4..40ba94235f 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -75,7 +75,7 @@ IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
 {
     DeviceState *dev;
 
-    dev = qdev_new(drive->media_cd ? "ide-cd" : "ide-hd");
+    dev = qdev_new_orphan(drive->media_cd ? "ide-cd" : "ide-hd");
     qdev_prop_set_uint32(dev, "unit", unit);
     qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(drive),
                             &error_fatal);
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index d15e41174a..dd29a86035 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -60,7 +60,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     uint32_t n = s->num_cpu;
     uint32_t i;
 
-    s->gic = qdev_new("arm_gic");
+    s->gic = qdev_new_orphan("arm_gic");
     qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
     gicbusdev = SYS_BUS_DEVICE(s->gic);
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 361a8d1bcb..07b5eec742 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -377,7 +377,7 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     bool provide_rdtime)
 {
     int i;
-    DeviceState *dev = qdev_new(TYPE_RISCV_ACLINT_MTIMER);
+    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_ACLINT_MTIMER);
     RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
 
     assert(num_harts <= RISCV_ACLINT_MAX_HARTS);
@@ -560,7 +560,7 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
     uint32_t num_harts, bool sswi)
 {
     int i;
-    DeviceState *dev = qdev_new(TYPE_RISCV_ACLINT_SWI);
+    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_ACLINT_SWI);
 
     assert(num_harts <= RISCV_ACLINT_MAX_HARTS);
     assert(!(addr & 0x3));
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 84606e9f3d..977e259cb9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1113,7 +1113,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
     uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent)
 {
-    DeviceState *dev = qdev_new(TYPE_RISCV_APLIC);
+    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_APLIC);
     uint32_t i;
 
     assert(num_harts < APLIC_MAX_IDC);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index d6b46cdca2..7972f8ce14 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -498,7 +498,7 @@ type_init(riscv_imsic_register_types)
 DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids)
 {
-    DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
+    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_IMSIC);
     CPUState *cpu = cpu_by_arch_id(hartid);
     uint32_t i;
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 57fd4b2b81..c86c0e1e60 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -62,11 +62,11 @@ void s390_flic_init(void)
     DeviceState *dev;
 
     if (kvm_enabled()) {
-        dev = qdev_new(TYPE_KVM_S390_FLIC);
+        dev = qdev_new_orphan(TYPE_KVM_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
                                   OBJECT(dev));
     } else {
-        dev = qdev_new(TYPE_QEMU_S390_FLIC);
+        dev = qdev_new_orphan(TYPE_QEMU_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
                                   OBJECT(dev));
     }
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9..00e6258403 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -481,7 +481,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t enable_stride, uint32_t context_base,
     uint32_t context_stride, uint32_t aperture_size)
 {
-    DeviceState *dev = qdev_new(TYPE_SIFIVE_PLIC);
+    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_PLIC);
     int i;
     SiFivePLICState *plic;
 
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 7e6d2ce5a9..5e6340f635 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -59,7 +59,7 @@ ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
         return NULL;
     }
     if (!dev) {
-        bridge = qdev_new("isabus-bridge");
+        bridge = qdev_new_orphan("isabus-bridge");
         dev = bridge;
     }
 
@@ -155,12 +155,12 @@ int isa_register_portio_list(ISADevice *dev,
 
 ISADevice *isa_new(const char *name)
 {
-    return ISA_DEVICE(qdev_new(name));
+    return ISA_DEVICE(qdev_new_orphan(name));
 }
 
 ISADevice *isa_try_new(const char *name)
 {
-    return ISA_DEVICE(qdev_try_new(name));
+    return ISA_DEVICE(qdev_try_new_orphan(name));
 }
 
 ISADevice *isa_create_simple(ISABus *bus, const char *name)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6693dea647..23751c46d7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -150,7 +150,7 @@ static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
 {
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -295,7 +295,7 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
         event |= ACPI_GED_CPU_HOTPLUG_EVT;
     }
 
-    dev = qdev_new(TYPE_ACPI_GED);
+    dev = qdev_new_orphan(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -322,7 +322,7 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
     int i, irq;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", VIRT_PLATFORM_BUS_SIZE);
@@ -400,7 +400,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     hwaddr mmio_base, mmio_size;
     int i, irq;
 
-    gpex_dev = qdev_new(TYPE_GPEX_HOST);
+    gpex_dev = qdev_new_orphan(TYPE_GPEX_HOST);
     d = SYS_BUS_DEVICE(gpex_dev);
     sysbus_realize_and_unref(d, &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
@@ -601,20 +601,20 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    ipi = qdev_new_orphan(TYPE_LOONGARCH_IPI);
     lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* Create DINTC device*/
     if (virt_has_dmsi(lvms)) {
-        dintc = qdev_new(TYPE_LOONGARCH_DINTC);
+        dintc = qdev_new_orphan(TYPE_LOONGARCH_DINTC);
         lvms->dintc = dintc;
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dintc), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dintc), 0, VIRT_DINTC_BASE);
     }
 
     /* Create EXTIOI device */
-    extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
+    extioi = qdev_new_orphan(TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
@@ -622,13 +622,13 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
 
     virt_cpu_irq_init(lvms);
-    pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
+    pch_pic = qdev_new_orphan(TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
     d = SYS_BUS_DEVICE(pch_pic);
     sysbus_realize_and_unref(d, &error_fatal);
 
-    pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
+    pch_msi = qdev_new_orphan(TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
     num = EXTIOI_IRQS - start;
     qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 1acd2fbdfb..f29c3b5226 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -25,7 +25,7 @@ static void mcf5206_init(M68kCPU *cpu, MemoryRegion *sysmem, uint32_t base)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_MCF5206_MBAR);
+    dev = qdev_new_orphan(TYPE_MCF5206_MBAR);
     object_property_set_link(OBJECT(dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
     s = SYS_BUS_DEVICE(dev);
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index e8d3bd937d..123bd7e385 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -211,7 +211,7 @@ DeviceState *mcf_intc_init(MemoryRegion *sysmem, hwaddr base, M68kCPU *cpu)
 {
     DeviceState  *dev;
 
-    dev = qdev_new(TYPE_MCF_INTC);
+    dev = qdev_new_orphan(TYPE_MCF_INTC);
     object_property_set_link(OBJECT(dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9a0a57c0cc..5bb123594d 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1272,7 +1272,7 @@ static void next_cube_init(MachineState *machine)
     env->sr  = 0x2700;
 
     /* Peripheral Controller */
-    pcdev = qdev_new(TYPE_NEXT_PC);
+    pcdev = qdev_new_orphan(TYPE_NEXT_PC);
     object_property_set_link(OBJECT(pcdev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
 
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ab64250c47..688299ee2d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -355,9 +355,9 @@ static void q800_machine_init(MachineState *machine)
                                                  "auxmode", 0));
 
     adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
-    dev = qdev_new(TYPE_ADB_KEYBOARD);
+    dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
-    dev = qdev_new(TYPE_ADB_MOUSE);
+    dev = qdev_new_orphan(TYPE_ADB_MOUSE);
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     /* VIA 2 */
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 51158ce1c0..f86d55d96c 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -155,7 +155,7 @@ static void virt_init(MachineState *machine)
 
     /* IRQ Controller */
 
-    irqc_dev = qdev_new(TYPE_M68K_IRQC);
+    irqc_dev = qdev_new_orphan(TYPE_M68K_IRQC);
     object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
@@ -169,7 +169,7 @@ static void virt_init(MachineState *machine)
      */
     io_base = VIRT_GF_PIC_MMIO_BASE;
     for (i = 0; i < VIRT_GF_PIC_NB; i++) {
-        pic_dev[i] = qdev_new(TYPE_GOLDFISH_PIC);
+        pic_dev[i] = qdev_new_orphan(TYPE_GOLDFISH_PIC);
         sysbus = SYS_BUS_DEVICE(pic_dev[i]);
         qdev_prop_set_uint8(pic_dev[i], "index", i);
         sysbus_realize_and_unref(sysbus, &error_fatal);
@@ -183,7 +183,7 @@ static void virt_init(MachineState *machine)
     /* goldfish-rtc */
     io_base = VIRT_GF_RTC_MMIO_BASE;
     for (i = 0; i < VIRT_GF_RTC_NB; i++) {
-        dev = qdev_new(TYPE_GOLDFISH_RTC);
+        dev = qdev_new_orphan(TYPE_GOLDFISH_RTC);
         qdev_prop_set_bit(dev, "big-endian", true);
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(sysbus, &error_fatal);
@@ -194,7 +194,7 @@ static void virt_init(MachineState *machine)
     }
 
     /* goldfish-tty */
-    dev = qdev_new(TYPE_GOLDFISH_TTY);
+    dev = qdev_new_orphan(TYPE_GOLDFISH_TTY);
     sysbus = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(sysbus, &error_fatal);
@@ -208,7 +208,7 @@ static void virt_init(MachineState *machine)
     /* virtio-mmio */
     io_base = VIRT_VIRTIO_MMIO_BASE;
     for (i = 0; i < 128; i++) {
-        dev = qdev_new(TYPE_VIRTIO_MMIO);
+        dev = qdev_new_orphan(TYPE_VIRTIO_MMIO);
         qdev_prop_set_bit(dev, "force-legacy", false);
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(sysbus, &error_fatal);
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 3b754de887..3310504578 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -108,7 +108,7 @@ MemoryRegion *sparse_mem_init(uint64_t addr, uint64_t length)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_SPARSE_MEM);
+    dev = qdev_new_orphan(TYPE_SPARSE_MEM);
     qdev_prop_set_uint64(dev, "baseaddr", addr);
     qdev_prop_set_uint64(dev, "length", length);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8f9f54ff1e..178cfd4a5e 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -110,7 +110,7 @@ petalogix_ml605_init(MachineState *machine)
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
 
 
-    dev = qdev_new("xlnx.xps-intc");
+    dev = qdev_new_orphan("xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -126,7 +126,7 @@ petalogix_ml605_init(MachineState *machine)
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
-    dev = qdev_new("xlnx.xps-timer");
+    dev = qdev_new_orphan("xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
@@ -135,8 +135,8 @@ petalogix_ml605_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     /* axi ethernet and dma initialization. */
-    eth0 = qdev_new("xlnx.axi-ethernet");
-    dma = qdev_new("xlnx.axi-dma");
+    eth0 = qdev_new_orphan("xlnx.axi-ethernet");
+    dma = qdev_new_orphan("xlnx.axi-dma");
 
     /* FIXME: attach to the sysbus instead */
     object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
@@ -174,7 +174,7 @@ petalogix_ml605_init(MachineState *machine)
     {
         SSIBus *spi;
 
-        dev = qdev_new("xlnx.xps-spi");
+        dev = qdev_new_orphan("xlnx.xps-spi");
         qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
@@ -188,7 +188,7 @@ petalogix_ml605_init(MachineState *machine)
             dinfo = drive_get(IF_MTD, 0, i);
             qemu_irq cs_line;
 
-            dev = qdev_new("n25q128");
+            dev = qdev_new_orphan("n25q128");
             if (dinfo) {
                 qdev_prop_set_drive_err(dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f6431900..91c1d64451 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -107,7 +107,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
-    dev = qdev_new("xlnx.xps-intc");
+    dev = qdev_new_orphan("xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
@@ -119,7 +119,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(dev, i);
     }
 
-    dev = qdev_new(TYPE_XILINX_UARTLITE);
+    dev = qdev_new_orphan(TYPE_XILINX_UARTLITE);
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -127,7 +127,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_new("xlnx.xps-timer");
+    dev = qdev_new_orphan("xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
@@ -135,7 +135,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
-    dev = qdev_new("xlnx.xps-ethernetlite");
+    dev = qdev_new_orphan("xlnx.xps-ethernetlite");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4579df23eb..e328c578a5 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -432,7 +432,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     DeviceState *dev;
     MemoryRegion *cfg, *mmio;
 
-    dev = qdev_new(TYPE_XILINX_PCIE_HOST);
+    dev = qdev_new_orphan(TYPE_XILINX_PCIE_HOST);
 
     qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
     qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
@@ -688,7 +688,7 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_new(TYPE_BOSTON);
+    dev = qdev_new_orphan(TYPE_BOSTON);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index bec534d38b..f9be67249f 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -127,7 +127,7 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
         return;
     }
 
-    dev = qdev_new("dp8393x");
+    dev = qdev_new_orphan("dp8393x");
     qdev_set_nic_properties(dev, nd);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", TARGET_BIG_ENDIAN);
@@ -296,7 +296,7 @@ static void mips_jazz_init(MachineState *machine,
     /* Video card */
     switch (jazz_model) {
     case JAZZ_MAGNUM:
-        dev = qdev_new("sysbus-g364");
+        dev = qdev_new_orphan("sysbus-g364");
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, 0x60080000);
@@ -313,7 +313,7 @@ static void mips_jazz_init(MachineState *machine,
         }
         break;
     case JAZZ_PICA61:
-        dev = qdev_new(TYPE_VGA_MMIO);
+        dev = qdev_new_orphan(TYPE_VGA_MMIO);
         qdev_prop_set_uint8(dev, "it_shift", 0);
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(sysbus, &error_fatal);
@@ -329,7 +329,7 @@ static void mips_jazz_init(MachineState *machine,
     mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom);
 
     /* SCSI adapter */
-    dev = qdev_new(TYPE_SYSBUS_ESP);
+    dev = qdev_new_orphan(TYPE_SYSBUS_ESP);
     sysbus_esp = SYSBUS_ESP(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = rc4030_dma_read;
@@ -359,7 +359,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0x80004000, rtc);
 
     /* Keyboard (i8042) */
-    i8042 = I8042_MMIO(qdev_new(TYPE_I8042_MMIO));
+    i8042 = I8042_MMIO(qdev_new_orphan(TYPE_I8042_MMIO));
     qdev_prop_set_uint64(DEVICE(i8042), "mask", 1);
     qdev_prop_set_uint32(DEVICE(i8042), "size", 0x1000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(i8042), &error_fatal);
@@ -389,7 +389,7 @@ static void mips_jazz_init(MachineState *machine,
     /* FIXME: missing Jazz sound at 0x8000c000, rc4030[2] */
 
     /* NVRAM */
-    dev = qdev_new("ds1225y");
+    dev = qdev_new_orphan("ds1225y");
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, 0x80009000);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 7de3fb09c1..d3b728339e 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -424,7 +424,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     LoongsonMachineState *s = LOONGSON_MACHINE(machine);
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(dev)->bus;
 
@@ -519,7 +519,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
 
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    ipi = qdev_new_orphan(TYPE_LOONGSON_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
     memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
@@ -527,7 +527,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
-    liointc = qdev_new("loongson.liointc");
+    liointc = qdev_new_orphan("loongson.liointc");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 38c71f66f2..fc5dbf262c 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1098,7 +1098,7 @@ void mips_malta_init(MachineState *machine)
     PCIDevice *piix4;
     DeviceState *dev;
 
-    s = MIPS_MALTA(qdev_new(TYPE_MIPS_MALTA));
+    s = MIPS_MALTA(qdev_new_orphan(TYPE_MIPS_MALTA));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
@@ -1226,7 +1226,7 @@ void mips_malta_init(MachineState *machine)
     stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
 
     /* Northbridge */
-    dev = qdev_new("gt64120");
+    dev = qdev_new_orphan("gt64120");
     qdev_prop_set_bit(dev, "cpu-little-endian", !TARGET_BIG_ENDIAN);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index aab9373c09..182211fdcc 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -58,7 +58,7 @@ void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size)
         /* Only empty slots larger than 0 byte need handling. */
         DeviceState *dev;
 
-        dev = qdev_new(TYPE_EMPTY_SLOT);
+        dev = qdev_new_orphan(TYPE_EMPTY_SLOT);
 
         qdev_prop_set_uint64(dev, "size", slot_size);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 8b758c1b76..620284063b 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -141,7 +141,7 @@ LEDState *led_create_simple(Object *parentobj,
     g_autofree char *name = NULL;
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_LED);
+    dev = qdev_new_orphan(TYPE_LED);
     qdev_prop_set_bit(dev, "gpio-active-high",
                       gpio_polarity == GPIO_POLARITY_ACTIVE_HIGH);
     qdev_prop_set_string(dev, "color", led_color_name[color]);
diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
index a4a60e7b40..7ac5db5933 100644
--- a/hw/misc/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -117,7 +117,7 @@ type_init(sifive_e_prci_register_types)
  */
 DeviceState *sifive_e_prci_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_new(TYPE_SIFIVE_E_PRCI);
+    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_E_PRCI);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index 41f102e2dc..f861858d9b 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -97,7 +97,7 @@ type_init(sifive_test_register_types)
  */
 DeviceState *sifive_test_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_new(TYPE_SIFIVE_TEST);
+    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_TEST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 072a741d81..87213c0d8d 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1339,7 +1339,7 @@ void lan9118_init(uint32_t base, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_LAN9118);
+    dev = qdev_new_orphan(TYPE_LAN9118);
     qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3b526524fb..6186d88717 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -954,7 +954,7 @@ void smc91c111_init(uint32_t base, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_SMC91C111);
+    dev = qdev_new_orphan(TYPE_SMC91C111);
     qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 550848307d..f10ea64798 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -371,7 +371,7 @@ void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd)
 {
     DeviceState *dev;
 
-    dev = qdev_new("spapr-vlan");
+    dev = qdev_new_orphan("spapr-vlan");
 
     qdev_set_nic_properties(dev, nd);
 
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index f4d0b06013..212281aac7 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -619,7 +619,7 @@ static void xen_net_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new(TYPE_XEN_NET_DEVICE));
+    xendev = XEN_DEVICE(qdev_new_orphan(TYPE_XEN_NET_DEVICE));
     net = XEN_NET_DEVICE(xendev);
 
     net->dev = number;
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 8849959359..efcc2c8a3f 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -197,7 +197,7 @@ static void nitro_machine_init(MachineState *machine)
         NitroVsockBridge *bridge = nitro_vsock_bridge_create();
 
         /* Nitro Enclaves require a heartbeat device. Provide one. */
-        qdev_realize(qdev_new(TYPE_NITRO_HEARTBEAT),
+        qdev_realize(qdev_new_orphan(TYPE_NITRO_HEARTBEAT),
                      BUS(&bridge->bus), &error_fatal);
 
         /*
@@ -209,7 +209,7 @@ static void nitro_machine_init(MachineState *machine)
             Chardev *chr = serial_hd(0);
 
             if (chr) {
-                DeviceState *dev = qdev_new(TYPE_NITRO_SERIAL_VSOCK);
+                DeviceState *dev = qdev_new_orphan(TYPE_NITRO_SERIAL_VSOCK);
 
                 qdev_prop_set_chr(dev, "chardev", chr);
                 qdev_realize(dev, BUS(&bridge->bus), &error_fatal);
diff --git a/hw/nitro/nitro-vsock-bus.c b/hw/nitro/nitro-vsock-bus.c
index eed29df512..f7540eaa54 100644
--- a/hw/nitro/nitro-vsock-bus.c
+++ b/hw/nitro/nitro-vsock-bus.c
@@ -48,7 +48,7 @@ void nitro_vsock_bridge_start_enclave(NitroVsockBridge *bridge,
 
 NitroVsockBridge *nitro_vsock_bridge_create(void)
 {
-    DeviceState *dev = qdev_new(TYPE_NITRO_VSOCK_BRIDGE);
+    DeviceState *dev = qdev_new_orphan(TYPE_NITRO_VSOCK_BRIDGE);
 
     qdev_set_id(dev, g_strdup("nitro-vsock"), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e159889..300a5aa835 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9556,7 +9556,7 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
     int cntlid;
 
     if (!n->subsys) {
-        DeviceState *dev = qdev_new(TYPE_NVME_SUBSYS);
+        DeviceState *dev = qdev_new_orphan(TYPE_NVME_SUBSYS);
 
         qdev_prop_set_string(dev, "nqn", n->params.serial);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b057d870c0..01fba1c6f6 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1029,7 +1029,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as)
 
     assert(dma_as);
 
-    dev = qdev_new(TYPE_FW_CFG_IO);
+    dev = qdev_new_orphan(TYPE_FW_CFG_IO);
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
@@ -1061,7 +1061,7 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     FWCfgState *s;
     bool dma_requested = dma_addr && dma_as;
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
+    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
     qdev_prop_set_uint32(dev, "data_width", data_width);
     if (!dma_requested) {
         qdev_prop_set_bit(dev, "dma_enabled", false);
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index b55105cd14..bd668d0e47 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -186,7 +186,7 @@ static void openrisc_sim_net_init(Or1ksimState *state, hwaddr base, hwaddr size,
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
         qdev_realize_and_unref(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
@@ -221,7 +221,7 @@ static void openrisc_sim_ompic_init(Or1ksimState *state, hwaddr base,
     char *nodename;
     int i;
 
-    dev = qdev_new("or1k-ompic");
+    dev = qdev_new_orphan("or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
 
     s = SYS_BUS_DEVICE(dev);
@@ -254,7 +254,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     int i;
 
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
         qdev_realize_and_unref(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 2ff5c084a2..3067a5b2e7 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -110,7 +110,7 @@ static qemu_irq get_per_cpu_irq(OpenRISCCPU *cpus[], int num_cpus, int irq_pin)
     int i;
 
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
         qdev_realize_and_unref(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
@@ -206,7 +206,7 @@ static void openrisc_virt_ompic_init(OR1KVirtState *state, hwaddr base,
     char *nodename;
     int i;
 
-    dev = qdev_new("or1k-ompic");
+    dev = qdev_new_orphan("or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
 
     s = SYS_BUS_DEVICE(dev);
@@ -379,7 +379,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState *state,
     qemu_irq pcie_irq;
     int i;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space. */
@@ -451,7 +451,7 @@ static void openrisc_virt_virtio_init(OR1KVirtState *state, hwaddr base,
     qemu_irq virtio_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
 
     /* VirtIO MMIO devices */
-    dev = qdev_new(TYPE_VIRTIO_MMIO);
+    dev = qdev_new_orphan(TYPE_VIRTIO_MMIO);
     qdev_prop_set_bit(dev, "force-legacy", false);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e08..11a28b5503 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -359,7 +359,7 @@ static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
         dev_name = dev->qdev.id;
     }
 
-    ds = qdev_new(type == CXL ? TYPE_PXB_CXL_HOST : TYPE_PXB_HOST);
+    ds = qdev_new_orphan(type == CXL ? TYPE_PXB_CXL_HOST : TYPE_PXB_HOST);
     if (type == PCIE) {
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else if (type == CXL) {
@@ -368,7 +368,7 @@ static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
         PXB_CXL_DEV(dev)->cxl_host_bridge = PXB_CXL_HOST(ds);
     } else {
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
-        bds = qdev_new("pci-bridge");
+        bds = qdev_new_orphan("pci-bridge");
         bds->id = g_strdup(dev_name);
         qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bus_nr);
         qdev_prop_set_bit(bds, PCI_BRIDGE_DEV_PROP_SHPC, false);
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index fc07608da7..1de3960713 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -521,7 +521,7 @@ static ElroyState *elroy_init(int num)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_ELROY_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_ELROY_PCI_HOST_BRIDGE);
     dev->id = g_strdup_printf("elroy%d", num);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ff2f5c966e..cd7272c90c 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -741,7 +741,7 @@ PCIBus *bonito_init(qemu_irq *pic)
     PCIBonitoState *s;
     PCIDevice *d;
 
-    dev = qdev_new(TYPE_BONITO_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_BONITO_PCI_HOST_BRIDGE);
     phb = PCI_HOST_BRIDGE(dev);
     pcihost = BONITO_PCI_HOST_BRIDGE(dev);
     pcihost->pic = pic;
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ee5cdc3e45..54dac5e989 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -180,7 +180,7 @@ static PnvPHB *pnv_pec_default_phb_realize(PnvPhb4PecState *pec,
                                            int stack_no,
                                            Error **errp)
 {
-    PnvPHB *phb = PNV_PHB(qdev_new(TYPE_PNV_PHB));
+    PnvPHB *phb = PNV_PHB(qdev_new_orphan(TYPE_PNV_PHB));
     int phb_id = pnv_phb4_pec_get_phb_id(pec, stack_no);
 
     object_property_add_child(OBJECT(pec), "phb[*]", OBJECT(phb));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..d14fc6478e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2393,7 +2393,7 @@ static PCIDevice *pci_new_internal(int devfn, bool multifunction,
 {
     DeviceState *dev;
 
-    dev = qdev_new(name);
+    dev = qdev_new_orphan(name);
     qdev_prop_set_int32(dev, "addr", devfn);
     qdev_prop_set_bit(dev, "multifunction", multifunction);
     return PCI_DEVICE(dev);
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 2e94e80b56..bcdf36b344 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -302,7 +302,7 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* nvram */
-    dev = qdev_new(TYPE_A1_NVRAM);
+    dev = qdev_new_orphan(TYPE_A1_NVRAM);
     di = drive_get(IF_MTD, 0, 0);
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 1876882a04..65e71826a4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -815,7 +815,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     unsigned int smp_cpus = machine->smp.cpus;
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
 
-    dev = qdev_new(TYPE_OPENPIC);
+    dev = qdev_new_orphan(TYPE_OPENPIC);
     object_property_add_child(OBJECT(machine), "pic", OBJECT(dev));
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
@@ -840,7 +840,7 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
     DeviceState *dev;
     CPUState *cs;
 
-    dev = qdev_new(TYPE_KVM_OPENPIC);
+    dev = qdev_new_orphan(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
     if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
@@ -993,7 +993,7 @@ void ppce500_init(MachineState *machine)
     /* Register Memory */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    dev = qdev_new("e500-ccsr");
+    dev = qdev_new_orphan("e500-ccsr");
     s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
     sysbus_realize_and_unref(s, &error_fatal);
@@ -1018,7 +1018,7 @@ void ppce500_init(MachineState *machine)
     }
 
     /* I2C */
-    dev = qdev_new("mpc-i2c");
+    dev = qdev_new_orphan("mpc-i2c");
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
@@ -1029,7 +1029,7 @@ void ppce500_init(MachineState *machine)
 
     /* eSDHC */
     if (pmc->has_esdhc) {
-        dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+        dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
         qdev_prop_set_string(dev, "name", "esdhc");
         qdev_prop_set_uint64(dev, "size", MPC85XX_ESDHC_REGS_SIZE);
         s = SYS_BUS_DEVICE(dev);
@@ -1037,7 +1037,7 @@ void ppce500_init(MachineState *machine)
         memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
 
-        dev = qdev_new(TYPE_FSL_ESDHC_BE);
+        dev = qdev_new_orphan(TYPE_FSL_ESDHC_BE);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
@@ -1046,14 +1046,14 @@ void ppce500_init(MachineState *machine)
     }
 
     /* General Utility device */
-    dev = qdev_new("mpc8544-guts");
+    dev = qdev_new_orphan("mpc8544-guts");
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(ccsr_addr_space, MPC8544_UTIL_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
     /* PCI */
-    dev = qdev_new("e500-pcihost");
+    dev = qdev_new_orphan("e500-pcihost");
     object_property_add_child(OBJECT(machine), "pci-host", OBJECT(dev));
     qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
@@ -1081,7 +1081,7 @@ void ppce500_init(MachineState *machine)
     if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
-        dev = qdev_new("mpc8xxx_gpio");
+        dev = qdev_new_orphan("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_IRQ));
@@ -1094,7 +1094,7 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Platform Bus Device */
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
     qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
@@ -1136,7 +1136,7 @@ void ppce500_init(MachineState *machine)
             exit(1);
         }
 
-        dev = qdev_new(TYPE_PFLASH_CFI01);
+        dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
         qdev_prop_set_drive(dev, "drive", blk);
         qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
         qdev_prop_set_uint64(dev, "sector-length", sector_len);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3680d96ed3..31dda69127 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -286,7 +286,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* UniN init */
-    s = SYS_BUS_DEVICE(qdev_new(TYPE_UNI_NORTH));
+    s = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_UNI_NORTH));
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
@@ -295,7 +295,7 @@ static void ppc_core99_init(MachineState *machine)
         machine_arch = ARCH_MAC99_U3;
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
-        uninorth_pci_dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
+        uninorth_pci_dev = qdev_new_orphan(TYPE_U3_AGP_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_pci_dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
@@ -310,14 +310,14 @@ static void ppc_core99_init(MachineState *machine)
         machine_arch = ARCH_MAC99;
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
-        uninorth_agp_dev = qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
+        uninorth_agp_dev = qdev_new_orphan(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_agp_dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
         /* Uninorth internal bus */
-        uninorth_internal_dev = qdev_new(
+        uninorth_internal_dev = qdev_new_orphan(
                                 TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_internal_dev);
         sysbus_realize_and_unref(s, &error_fatal);
@@ -325,7 +325,7 @@ static void ppc_core99_init(MachineState *machine)
         sysbus_mmio_map(s, 1, 0xf4c00000);
 
         /* Uninorth main bus - this must be last to make it the default */
-        uninorth_pci_dev = qdev_new(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+        uninorth_pci_dev = qdev_new_orphan(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
         qdev_prop_set_uint32(uninorth_pci_dev, "ofw-addr", 0xf2000000);
         s = SYS_BUS_DEVICE(uninorth_pci_dev);
         sysbus_realize_and_unref(s, &error_fatal);
@@ -408,10 +408,10 @@ static void ppc_core99_init(MachineState *machine)
         }
 
         adb_bus = qdev_get_child_bus(dev, "adb.0");
-        dev = qdev_new(TYPE_ADB_KEYBOARD);
+        dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
         qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
-        dev = qdev_new(TYPE_ADB_MOUSE);
+        dev = qdev_new_orphan(TYPE_ADB_MOUSE);
         qdev_realize_and_unref(dev, adb_bus, &error_fatal);
     }
 
@@ -453,7 +453,7 @@ static void ppc_core99_init(MachineState *machine)
            move the NVRAM out of ROM again for KVM */
         nvram_addr = 0xFFE00000;
     }
-    dev = qdev_new(TYPE_MACIO_NVRAM);
+    dev = qdev_new_orphan(TYPE_MACIO_NVRAM);
     qdev_prop_set_uint32(dev, "size", MACIO_NVRAM_SIZE);
     qdev_prop_set_uint32(dev, "it_shift", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -462,7 +462,7 @@ static void ppc_core99_init(MachineState *machine)
     pmac_format_nvram_partition(nvr, MACIO_NVRAM_SIZE);
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
+    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 24d9f2e3d5..aa366ca190 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -212,7 +212,7 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     /* Grackle PCI host bridge */
-    grackle_dev = qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    grackle_dev = qdev_new_orphan(TYPE_GRACKLE_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(grackle_dev, "ofw-addr", 0x80000000);
     s = SYS_BUS_DEVICE(grackle_dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -279,9 +279,9 @@ static void ppc_heathrow_init(MachineState *machine)
     /* MacIO CUDA/ADB */
     dev = DEVICE(object_resolve_path_component(macio, "cuda"));
     adb_bus = qdev_get_child_bus(dev, "adb.0");
-    dev = qdev_new(TYPE_ADB_KEYBOARD);
+    dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
-    dev = qdev_new(TYPE_ADB_MOUSE);
+    dev = qdev_new_orphan(TYPE_ADB_MOUSE);
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     if (machine_usb(machine)) {
@@ -303,7 +303,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
+    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0cb45dbfb..b85b6dd46c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1127,7 +1127,7 @@ static void pnv_init(MachineState *machine)
     /*
      * Create our simple PNOR device
      */
-    dev = qdev_new(TYPE_PNV_PNOR);
+    dev = qdev_new_orphan(TYPE_PNV_PNOR);
     pnor = drive_get(IF_MTD, 0, 0);
     if (!pnor && defaults_enabled()) {
         fw_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, PNOR_FILE_NAME);
@@ -1269,7 +1269,7 @@ static void pnv_init(MachineState *machine)
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
-        Object *chip = OBJECT(qdev_new(chip_typename));
+        Object *chip = OBJECT(qdev_new_orphan(chip_typename));
         uint64_t chip_ram_size =  pnv_chip_get_ram_size(pnv, i);
 
         pnv->chips[i] = PNV_CHIP(chip);
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index fb70a8c1f2..6f65984f2e 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -299,7 +299,7 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_IPMI_BMC_SIMULATOR);
+    dev = qdev_new_orphan(TYPE_IPMI_BMC_SIMULATOR);
     qdev_realize(dev, NULL, &error_fatal);
     pnv_bmc_set_pnor(IPMI_BMC(dev), pnor);
 
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2dde008b0e..e76d359e43 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -162,7 +162,7 @@ static void bamboo_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    uicdev = qdev_new(TYPE_PPC_UIC);
+    uicdev = qdev_new_orphan(TYPE_PPC_UIC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uicdev), cpu, &error_fatal);
     object_unref(OBJECT(uicdev));
     uicsbd = SYS_BUS_DEVICE(uicdev);
@@ -172,7 +172,7 @@ static void bamboo_init(MachineState *machine)
                        qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_CINT));
 
     /* SDRAM controller */
-    dev = qdev_new(TYPE_PPC4xx_SDRAM_DDR);
+    dev = qdev_new_orphan(TYPE_PPC4xx_SDRAM_DDR);
     object_property_set_link(OBJECT(dev), "dram", OBJECT(machine->ram),
                              &error_abort);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2672eb9e7a..f53ff9c582 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -289,7 +289,7 @@ static void ibm_40p_init(MachineState *machine)
     g_free(filename);
 
     /* PCI host */
-    dev = qdev_new("raven-pcihost");
+    dev = qdev_new_orphan("raven-pcihost");
     pcihost = SYS_BUS_DEVICE(dev);
     object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
     sysbus_realize_and_unref(pcihost, &error_fatal);
@@ -363,7 +363,7 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* Prepare firmware configuration for OpenBIOS */
-    dev = qdev_new(TYPE_FW_CFG_MEM);
+    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b13dd224ba..778b04c532 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -275,7 +275,7 @@ static void sam460ex_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
 
     /* PLB arbitrer */
-    dev = qdev_new(TYPE_PPC4xx_PLB);
+    dev = qdev_new_orphan(TYPE_PPC4xx_PLB);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
     object_unref(OBJECT(dev));
 
@@ -291,7 +291,7 @@ static void sam460ex_init(MachineState *machine)
          */
         const int input_ints[] = { -1, 30, 10, 16 };
 
-        uic[i] = qdev_new(TYPE_PPC_UIC);
+        uic[i] = qdev_new_orphan(TYPE_PPC_UIC);
         qdev_prop_set_uint32(uic[i], "dcr-base", 0xc0 + i * 0x10);
         ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uic[i]), cpu, &error_fatal);
         object_unref(OBJECT(uic[i]));
@@ -321,7 +321,7 @@ static void sam460ex_init(MachineState *machine)
         error_report("Memory below 64 MiB is not supported");
         exit(1);
     }
-    dev = qdev_new(TYPE_PPC4xx_SDRAM_DDR2);
+    dev = qdev_new_orphan(TYPE_PPC4xx_SDRAM_DDR2);
     object_property_set_link(OBJECT(dev), "dram", OBJECT(machine->ram),
                              &error_abort);
     /*
@@ -351,7 +351,7 @@ static void sam460ex_init(MachineState *machine)
                                qdev_get_gpio_in(uic[0], 3));
 
     /* External bus controller */
-    dev = qdev_new(TYPE_PPC4xx_EBC);
+    dev = qdev_new_orphan(TYPE_PPC4xx_EBC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
     object_unref(OBJECT(dev));
 
@@ -365,7 +365,7 @@ static void sam460ex_init(MachineState *machine)
     ppc4xx_sdr_init(env);
 
     /* MAL */
-    dev = qdev_new(TYPE_PPC4xx_MAL);
+    dev = qdev_new_orphan(TYPE_PPC4xx_MAL);
     qdev_prop_set_uint8(dev, "txc-num", 4);
     qdev_prop_set_uint8(dev, "rxc-num", 16);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
@@ -389,7 +389,7 @@ static void sam460ex_init(MachineState *machine)
     /* USB */
     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400,
                          qdev_get_gpio_in(uic[2], 29));
-    dev = qdev_new("sysbus-ohci");
+    dev = qdev_new_orphan("sysbus-ohci");
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
     qdev_prop_set_uint32(dev, "num-ports", 6);
     sbdev = SYS_BUS_DEVICE(dev);
@@ -402,13 +402,13 @@ static void sam460ex_init(MachineState *machine)
     usb_create_simple(usb_bus, "usb-mouse");
 
     /* PCIe buses */
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new_orphan(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "busnum", 0);
     qdev_prop_set_int32(dev, "dcrn-base", PCIE0_DCRN_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new_orphan(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "busnum", 1);
     qdev_prop_set_int32(dev, "dcrn-base", PCIE1_DCRN_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e9..30bf0cd0c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1885,7 +1885,7 @@ static void spapr_machine_reset(MachineState *machine, ResetType type)
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
 {
-    DeviceState *dev = qdev_new("spapr-nvram");
+    DeviceState *dev = qdev_new_orphan("spapr-nvram");
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     if (dinfo) {
@@ -2799,7 +2799,7 @@ static PCIHostState *spapr_create_default_phb(void)
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_SPAPR_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_SPAPR_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "index", 0);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 3a9c96d939..76ae80d16e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -312,7 +312,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         DeviceState *dev;
         int i;
 
-        dev = qdev_new(TYPE_SPAPR_XIVE);
+        dev = qdev_new_orphan(TYPE_SPAPR_XIVE);
         qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 3f05081bad..0f22fa61a4 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -564,7 +564,7 @@ SpaprVioBus *spapr_vio_bus_init(void)
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_new(TYPE_SPAPR_VIO_BRIDGE);
+    dev = qdev_new_orphan(TYPE_SPAPR_VIO_BRIDGE);
 
     /* Create bus on bridge device */
     qbus = qbus_new(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 09686360e1..d7fd72d353 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -84,7 +84,7 @@ static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    uicdev = qdev_new(TYPE_PPC_UIC);
+    uicdev = qdev_new_orphan(TYPE_PPC_UIC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uicdev), cpu, &error_fatal);
     object_unref(OBJECT(uicdev));
     uicsbd = SYS_BUS_DEVICE(uicdev);
@@ -218,7 +218,7 @@ static void virtex_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     cpu_irq = qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT);
-    dev = qdev_new("xlnx.xps-intc");
+    dev = qdev_new_orphan("xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "kind-of-intr", 0);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -232,7 +232,7 @@ static void virtex_init(MachineState *machine)
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_new("xlnx.xps-timer");
+    dev = qdev_new_orphan("xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index df08f64019..28cb48a4f6 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -39,7 +39,7 @@ static void remote_machine_init(MachineState *machine)
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
 
-    rem_host = REMOTE_PCIHOST(qdev_new(TYPE_REMOTE_PCIHOST));
+    rem_host = REMOTE_PCIHOST(qdev_new_orphan(TYPE_REMOTE_PCIHOST));
 
     rem_host->mr_pci_mem = pci_memory;
     rem_host->mr_sys_mem = system_memory;
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 965d0f5699..0fbb44c5df 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -305,7 +305,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     DeviceState *dev;
     MemoryRegion *cfg, *mmio;
 
-    dev = qdev_new(TYPE_XILINX_PCIE_HOST);
+    dev = qdev_new_orphan(TYPE_XILINX_PCIE_HOST);
 
     qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
     qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
@@ -352,7 +352,7 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_new(TYPE_MIPS_BOSTON_AIA);
+    dev = qdev_new_orphan(TYPE_MIPS_BOSTON_AIA);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68..5864007f01 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -79,7 +79,7 @@ static void mb_v_generic_init(MachineState *machine)
                            ram_size, &error_fatal);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
-    dev = qdev_new("xlnx.xps-intc");
+    dev = qdev_new_orphan("xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << UARTLITE_IRQ);
@@ -92,7 +92,7 @@ static void mb_v_generic_init(MachineState *machine)
     }
 
     /* Uartlite */
-    dev = qdev_new(TYPE_XILINX_UARTLITE);
+    dev = qdev_new_orphan(TYPE_XILINX_UARTLITE);
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -105,7 +105,7 @@ static void mb_v_generic_init(MachineState *machine)
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 0 @ 100 Mhz.  */
-    dev = qdev_new("xlnx.xps-timer");
+    dev = qdev_new_orphan("xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
@@ -114,7 +114,7 @@ static void mb_v_generic_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     /* 2 timers at irq 3 @ 100 Mhz.  */
-    dev = qdev_new("xlnx.xps-timer");
+    dev = qdev_new_orphan("xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
@@ -123,7 +123,7 @@ static void mb_v_generic_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
 
     /* Emaclite */
-    dev = qdev_new("xlnx.xps-ethernetlite");
+    dev = qdev_new_orphan("xlnx.xps-ethernetlite");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
@@ -133,8 +133,8 @@ static void mb_v_generic_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
     /* axi ethernet and dma initialization. */
-    eth0 = qdev_new("xlnx.axi-ethernet");
-    dma = qdev_new("xlnx.axi-dma");
+    eth0 = qdev_new_orphan("xlnx.axi-ethernet");
+    dma = qdev_new_orphan("xlnx.axi-dma");
 
     /* FIXME: attach to the sysbus instead */
     object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4017129c83..cc93b5c2ba 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -580,7 +580,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     /* Attach an SD card */
     if (dinfo) {
         CadenceSDHCIState *sdhci = &(s->soc.sdhci);
-        DeviceState *card = qdev_new(TYPE_SD_CARD);
+        DeviceState *card = qdev_new_orphan(TYPE_SD_CARD);
 
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472..db6d984f94 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -593,7 +593,7 @@ static void sifive_u_machine_init(MachineState *machine)
                                  sizeof(reset_vec), kernel_entry);
 
     /* Connect an SPI flash to SPI0 */
-    flash_dev = qdev_new("is25wp256");
+    flash_dev = qdev_new_orphan("is25wp256");
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
         qdev_prop_set_drive_err(flash_dev, "drive",
@@ -613,7 +613,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     dinfo = drive_get(IF_SD, 0, 0);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    card_dev = qdev_new(TYPE_SD_CARD_SPI);
+    card_dev = qdev_new_orphan(TYPE_SD_CARD_SPI);
     qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(card_dev,
                            qdev_get_child_bus(sd_dev, "sd-bus"),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91..81212c81dd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -125,7 +125,7 @@ static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the ARM virt board.
      */
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -1050,7 +1050,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     qemu_irq irq;
     int i;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
 
     /* Set GPEX object properties for the virt machine */
     object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
@@ -1142,7 +1142,7 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
@@ -1508,7 +1508,7 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-        DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
+        DeviceState *iommu_sys = qdev_new_orphan(TYPE_RISCV_IOMMU_SYS);
 
         object_property_set_uint(OBJECT(iommu_sys), "addr",
                                  s->memmap[VIRT_IOMMU_SYS].base,
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index 3a586adf02..257f70885d 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -57,7 +57,7 @@ void sun4v_rtc_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_SUN4V_RTC);
+    dev = qdev_new_orphan(TYPE_SUN4V_RTC);
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index c7e49d966b..ce9b09240a 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -49,7 +49,7 @@ void s390_init_ap(void)
     }
 
     /* Create bridge device */
-    dev = qdev_new(TYPE_AP_BRIDGE);
+    dev = qdev_new_orphan(TYPE_AP_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
                               OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 440fefb7d0..c6be24e5cb 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -92,7 +92,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_new(TYPE_VIRTUAL_CSS_BRIDGE);
+    dev = qdev_new_orphan(TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
                               OBJECT(dev));
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe..bc335ca883 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -967,7 +967,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
     Error *local_err = NULL;
     DeviceState *dev;
 
-    dev = qdev_try_new(TYPE_S390_PCI_DEVICE);
+    dev = qdev_try_new_orphan(TYPE_S390_PCI_DEVICE);
     if (!dev) {
         error_setg(errp, "zPCI device could not be created");
         return NULL;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa4955..f9eb6cb411 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -253,7 +253,7 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
-    dev = qdev_new(type);
+    dev = qdev_new_orphan(type);
     object_property_add_child(OBJECT(ef), type, OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", chardev);
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
@@ -265,7 +265,7 @@ static void s390_create_sclpcpi(SCLPDevice *sclp)
     BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_SCLP_EVENT_CPI);
+    dev = qdev_new_orphan(TYPE_SCLP_EVENT_CPI);
     object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
@@ -309,7 +309,7 @@ static void ccw_init(MachineState *machine)
                       machine->firmware ?: "s390-ccw.img",
                       true);
 
-    dev = qdev_new(TYPE_S390_PCI_HOST_BRIDGE);
+    dev = qdev_new_orphan(TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5..e1a1f68aaa 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -231,7 +231,7 @@ DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
     LasiNCR710State *s;
     SysBusDevice *sbd;
 
-    dev = qdev_new(TYPE_LASI_NCR710);
+    dev = qdev_new_orphan(TYPE_LASI_NCR710);
     s = LASI_NCR710(dev);
     sbd = SYS_BUS_DEVICE(dev);
     s->lasi_irq = irq;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84..54ce2df641 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2376,7 +2376,7 @@ DeviceState *ncr710_device_create_sysbus(hwaddr addr, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *sysbus;
 
-    dev = qdev_new(TYPE_SYSBUS_NCR710_SCSI);
+    dev = qdev_new_orphan(TYPE_SYSBUS_NCR710_SCSI);
     sysbus = SYS_BUS_DEVICE(dev);
 
     qdev_realize_and_unref(dev, NULL, &error_abort);
@@ -2394,7 +2394,7 @@ DeviceState *ncr53c710_init(MemoryRegion *address_space, hwaddr addr,
 
     /* trace_ncr710_device_init(addr); */
 
-    dev = qdev_new(TYPE_SYSBUS_NCR710_SCSI);
+    dev = qdev_new_orphan(TYPE_SYSBUS_NCR710_SCSI);
     sysbus = SYS_BUS_DEVICE(dev);
 
     qdev_realize_and_unref(dev, NULL, &error_abort);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index dccb2f25b2..806a20baee 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -445,7 +445,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
             driver = "scsi-hd";
         }
     }
-    dev = qdev_new(driver);
+    dev = qdev_new_orphan(driver);
     name = g_strdup_printf("legacy[%d]", unit);
     object_property_add_child(OBJECT(bus), name, OBJECT(dev));
     g_free(name);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..492d7d18a2 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1235,7 +1235,7 @@ void spapr_vscsi_create(SpaprVioBus *bus)
 {
     DeviceState *dev;
 
-    dev = qdev_new("spapr-vscsi");
+    dev = qdev_new_orphan("spapr-vscsi");
 
     qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
     scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 99afe3618e..0b502ca392 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -266,7 +266,7 @@ static void r2d_init(MachineState *machine)
     s = sh7750_init(cpu, address_space_mem);
     fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
 
-    dev = qdev_new("sh_pci");
+    dev = qdev_new_orphan("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
@@ -277,7 +277,7 @@ static void r2d_init(MachineState *machine)
     sysbus_connect_irq(busdev, 2, &fpga->irq[PCI_INTC]);
     sysbus_connect_irq(busdev, 3, &fpga->irq[PCI_INTD]);
 
-    dev = qdev_new("sysbus-sm501");
+    dev = qdev_new_orphan("sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint64(dev, "dma-offset", 0x10000000);
@@ -289,7 +289,7 @@ static void r2d_init(MachineState *machine)
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
-    dev = qdev_new("mmio-ide");
+    dev = qdev_new_orphan("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(busdev, 0, &fpga->irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6aa7f63773..3eb47bc660 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -762,7 +762,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
     cpu->env.intc_handle = &s->intc;
 
     /* SCI */
-    dev = qdev_new(TYPE_SH_SERIAL);
+    dev = qdev_new_orphan(TYPE_SH_SERIAL);
     dev->id = g_strdup("sci");
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sb = SYS_BUS_DEVICE(dev);
@@ -779,7 +779,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
     qdev_connect_gpio_out_named(dev, "tei", 0, s->intc.irqs[SCI1_TEI]);
 
     /* SCIF */
-    dev = qdev_new(TYPE_SH_SERIAL);
+    dev = qdev_new_orphan(TYPE_SH_SERIAL);
     dev->id = g_strdup("scif");
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
     qdev_prop_set_uint8(dev, "features", SH_SERIAL_FEAT_SCIF);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d4a6e91759..d921cd8dc6 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -292,14 +292,14 @@ static void leon3_generic_hw_init(MachineState *machine)
         qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
     }
 
-    ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
+    ahb_pnp = GRLIB_AHB_PNP(qdev_new_orphan(TYPE_GRLIB_AHB_PNP));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
 
-    apb_pnp = GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
+    apb_pnp = GRLIB_APB_PNP(qdev_new_orphan(TYPE_GRLIB_APB_PNP));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
@@ -307,7 +307,7 @@ static void leon3_generic_hw_init(MachineState *machine)
                             GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
 
     /* Allocate IRQ manager */
-    irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    irqmpdev = qdev_new_orphan(TYPE_GRLIB_IRQMP);
     object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
                             &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
@@ -406,7 +406,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     /* Allocate timers */
-    dev = qdev_new(TYPE_GRLIB_GPTIMER);
+    dev = qdev_new_orphan(TYPE_GRLIB_GPTIMER);
     qdev_prop_set_uint32(dev, "nr-timers", LEON3_TIMER_COUNT);
     qdev_prop_set_uint32(dev, "frequency", CPU_CLK);
     qdev_prop_set_uint32(dev, "irq-line", LEON3_TIMER_IRQ);
@@ -423,7 +423,7 @@ static void leon3_generic_hw_init(MachineState *machine)
                             0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
 
     /* Allocate uart */
-    dev = qdev_new(TYPE_GRLIB_APB_UART);
+    dev = qdev_new_orphan(TYPE_GRLIB_APB_UART);
     qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550acdff6d..69a287937e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -280,7 +280,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_SUN4M_IOMMU);
+    dev = qdev_new_orphan(TYPE_SUN4M_IOMMU);
     qdev_prop_set_uint32(dev, "version", version);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -302,7 +302,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusPCNetState *lance;
     NICInfo *nd = qemu_find_nic_info("lance", true, NULL);
 
-    dma = qdev_new(TYPE_SPARC32_DMA);
+    dma = qdev_new_orphan(TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
 
@@ -347,7 +347,7 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     SysBusDevice *s;
     unsigned int i, j;
 
-    dev = qdev_new("slavio_intctl");
+    dev = qdev_new_orphan("slavio_intctl");
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -376,7 +376,7 @@ static void slavio_timer_init_all(hwaddr addr, qemu_irq master_irq,
     SysBusDevice *s;
     unsigned int i;
 
-    dev = qdev_new("slavio_timer");
+    dev = qdev_new_orphan("slavio_timer");
     qdev_prop_set_uint32(dev, "num_cpus", num_cpus);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -414,7 +414,7 @@ static void slavio_misc_init(hwaddr base,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("slavio_misc");
+    dev = qdev_new_orphan("slavio_misc");
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     if (base) {
@@ -451,7 +451,7 @@ static void ecc_init(hwaddr base, qemu_irq irq, uint32_t version)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("eccmemctl");
+    dev = qdev_new_orphan("eccmemctl");
     qdev_prop_set_uint32(dev, "version", version);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -467,7 +467,7 @@ static void apc_init(hwaddr power_base, qemu_irq cpu_halt)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("apc");
+    dev = qdev_new_orphan("apc");
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     /* Power management (APC) XXX: not a Slavio device */
@@ -481,7 +481,7 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("sun-tcx");
+    dev = qdev_new_orphan("sun-tcx");
     qdev_prop_set_uint32(dev, "vram_size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
@@ -533,7 +533,7 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new("cgthree");
+    dev = qdev_new_orphan("cgthree");
     qdev_prop_set_uint32(dev, "vram-size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
@@ -562,7 +562,7 @@ static void idreg_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_MACIO_ID_REGISTER);
+    dev = qdev_new_orphan(TYPE_MACIO_ID_REGISTER);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
@@ -621,7 +621,7 @@ static void afx_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new(TYPE_TCX_AFX);
+    dev = qdev_new_orphan(TYPE_TCX_AFX);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
@@ -678,7 +678,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
     char *filename;
     int ret;
 
-    dev = qdev_new(TYPE_OPENPROM);
+    dev = qdev_new_orphan(TYPE_OPENPROM);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
@@ -835,7 +835,7 @@ static void sun4m_hw_init(MachineState *machine)
     }
 
     /* Create and map RAM frontend */
-    dev = qdev_new("memory");
+    dev = qdev_new_orphan("memory");
     object_property_set_link(OBJECT(dev), "memdev", OBJECT(ram_memdev), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
@@ -946,7 +946,7 @@ static void sun4m_hw_init(MachineState *machine)
         create_unimplemented_device("sun-sx", hwdef->sx_base, 0x2000);
     }
 
-    dev = qdev_new("sysbus-m48t08");
+    dev = qdev_new_orphan("sysbus-m48t08");
     qdev_prop_set_int32(dev, "base-year", 1968);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -958,7 +958,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
        Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device */
-    dev = qdev_new(TYPE_ESCC);
+    dev = qdev_new_orphan(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -971,14 +971,14 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
 
     /* Logically OR both its IRQs together */
-    ms_kb_orgate = qdev_new(TYPE_OR_IRQ);
+    ms_kb_orgate = qdev_new_orphan(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(ms_kb_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(ms_kb_orgate, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(ms_kb_orgate, 0));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(ms_kb_orgate, 1));
     qdev_connect_gpio_out(ms_kb_orgate, 0, slavio_irq[14]);
 
-    dev = qdev_new(TYPE_ESCC);
+    dev = qdev_new_orphan(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -992,7 +992,7 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->serial_base);
 
     /* Logically OR both its IRQs together */
-    serial_orgate = qdev_new(TYPE_OR_IRQ);
+    serial_orgate = qdev_new_orphan(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(serial_orgate), "num-lines", 2,
                             &error_fatal);
     qdev_realize_and_unref(serial_orgate, NULL, &error_fatal);
@@ -1051,7 +1051,7 @@ static void sun4m_hw_init(MachineState *machine)
         ecc_init(hwdef->ecc_base, slavio_irq[28],
                  hwdef->ecc_version);
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
+    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d69ed9a81a..bd73d26e2c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -342,7 +342,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     isa_fdc_init_drives(isa_dev, fd);
 
     /* Power */
-    dev = qdev_new(TYPE_SUN4U_POWER);
+    dev = qdev_new_orphan(TYPE_SUN4U_POWER);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,
@@ -423,7 +423,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
     char *filename;
     int ret;
 
-    dev = qdev_new(TYPE_OPENPROM);
+    dev = qdev_new_orphan(TYPE_OPENPROM);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
@@ -507,7 +507,7 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
     RamDevice *d;
 
     /* allocate RAM */
-    dev = qdev_new(TYPE_SUN4U_MEMORY);
+    dev = qdev_new_orphan(TYPE_SUN4U_MEMORY);
     s = SYS_BUS_DEVICE(dev);
 
     d = SUN4U_RAM(dev);
@@ -559,7 +559,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
 
     /* IOMMU */
-    iommu = qdev_new(TYPE_SUN4U_IOMMU);
+    iommu = qdev_new_orphan(TYPE_SUN4U_IOMMU);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu), &error_fatal);
 
     /* set up devices */
@@ -568,7 +568,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     prom_init(hwdef->prom_addr, machine->firmware);
 
     /* Init sabre (PCI host bridge) */
-    sabre = SABRE(qdev_new(TYPE_SABRE));
+    sabre = SABRE(qdev_new_orphan(TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
     object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
@@ -654,7 +654,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
-    dev = qdev_new("sysbus-m48t59");
+    dev = qdev_new_orphan("sysbus-m48t59");
     qdev_prop_set_int32(dev, "base-year", 1968);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -689,7 +689,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&macaddr);
 
-    dev = qdev_new(TYPE_FW_CFG_IO);
+    dev = qdev_new_orphan(TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3a4fade2d5..b1935271f0 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -140,7 +140,7 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
 
 DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name)
 {
-    DeviceState *dev = qdev_new(name);
+    DeviceState *dev = qdev_new_orphan(name);
 
     ssi_realize_and_unref(dev, bus, &error_fatal);
     return dev;
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index d5d796c8ee..afed9ad0ae 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -89,7 +89,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     memory_region_add_subregion(sysmem, 0xf0050000, pcp_data);
     memory_region_add_subregion(sysmem, 0xf0060000, pcp_text);
 
-    test_dev = TRICORE_TESTDEVICE(qdev_new(TYPE_TRICORE_TESTDEVICE));
+    test_dev = TRICORE_TESTDEVICE(qdev_new_orphan(TYPE_TRICORE_TESTDEVICE));
     memory_region_add_subregion(sysmem, 0xf0000000, &test_dev->iomem);
 
 
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13f4a90145..219f74e4f3 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -472,7 +472,7 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
      * The ufs-lu is the device that is wrapping the scsi-hd. It owns a virtual
      * SCSI bus that serves the scsi-hd.
      */
-    scsi_dev = qdev_new("scsi-hd");
+    scsi_dev = qdev_new_orphan("scsi-hd");
     object_property_add_child(OBJECT(&lu->bus), "ufs-scsi", OBJECT(scsi_dev));
 
     qdev_prop_set_uint32(scsi_dev, "physical_block_size", UFS_BLOCK_SIZE);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 3b6fbd46ac..d45cce7666 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -410,7 +410,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            hub = USB_DEVICE(qdev_try_new("usb-hub"));
+            hub = USB_DEVICE(qdev_try_new_orphan("usb-hub"));
             if (hub) {
                 usb_realize_and_unref(hub, bus, NULL);
             }
@@ -662,7 +662,7 @@ USBDevice *usbdevice_create(const char *driver)
     }
 
     dev = f->usbdevice_init ? f->usbdevice_init()
-                            : USB_DEVICE(qdev_new(f->name));
+                            : USB_DEVICE(qdev_new_orphan(f->name));
     if (!dev) {
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b238cb7937..81897b2d76 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -622,7 +622,7 @@ static USBDevice *usb_braille_init(void)
         return NULL;
     }
 
-    dev = USB_DEVICE(qdev_new("usb-braille"));
+    dev = USB_DEVICE(qdev_new_orphan("usb-braille"));
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
     return dev;
 }
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 607181f517..9f69ab2bc7 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -155,7 +155,7 @@ static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 
     /* PV backdoor device */
-    bdif = qdev_new(TYPE_VMAPPLE_BDIF);
+    bdif = qdev_new_orphan(TYPE_VMAPPLE_BDIF);
     bdif_sb = SYS_BUS_DEVICE(bdif);
     sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base);
 
@@ -169,7 +169,7 @@ static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem)
 {
     SysBusDevice *pvpanic;
 
-    vms->pvpanic = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
+    vms->pvpanic = qdev_new_orphan(TYPE_PVPANIC_MMIO_DEVICE);
     pvpanic = SYS_BUS_DEVICE(vms->pvpanic);
     sysbus_mmio_map(pvpanic, 0, vms->memmap[VMAPPLE_PVPANIC].base);
 
@@ -184,7 +184,7 @@ static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,
     MachineState *machine = MACHINE(vms);
     uint32_t rnd = 1;
 
-    vms->cfg = qdev_new(TYPE_VMAPPLE_CFG);
+    vms->cfg = qdev_new_orphan(TYPE_VMAPPLE_CFG);
     cfg = SYS_BUS_DEVICE(vms->cfg);
     sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
 
@@ -209,7 +209,7 @@ static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
     int irq_iosfc = vms->irqmap[VMAPPLE_APV_IOSFC];
     SysBusDevice *gfx;
 
-    gfx = SYS_BUS_DEVICE(qdev_new("apple-gfx-mmio"));
+    gfx = SYS_BUS_DEVICE(qdev_new_orphan("apple-gfx-mmio"));
     sysbus_mmio_map(gfx, 0, vms->memmap[VMAPPLE_APV_GFX].base);
     sysbus_mmio_map(gfx, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
     sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
@@ -222,7 +222,7 @@ static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
     int irq = vms->irqmap[VMAPPLE_AES_1];
     SysBusDevice *aes;
 
-    aes = SYS_BUS_DEVICE(qdev_new(TYPE_APPLE_AES));
+    aes = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_APPLE_AES));
     sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
     sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
     sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
@@ -243,7 +243,7 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     int i;
     unsigned int smp_cpus = ms->smp.cpus;
 
-    vms->gic = qdev_new(gicv3_class_name());
+    vms->gic = qdev_new_orphan(gicv3_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", 3);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -290,7 +290,7 @@ static void create_uart(const VMAppleMachineState *vms, int uart,
 {
     hwaddr base = vms->memmap[uart].base;
     int irq = vms->irqmap[uart];
-    DeviceState *dev = qdev_new(TYPE_PL011);
+    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
@@ -323,7 +323,7 @@ static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
     int irq = vms->irqmap[gpio];
     SysBusDevice *s;
 
-    pl061_dev = qdev_new("pl061");
+    pl061_dev = qdev_new_orphan("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
     qdev_prop_set_uint8(pl061_dev, "pullups", 0);
     qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
@@ -384,7 +384,7 @@ static void create_pcie(VMAppleMachineState *vms)
     DeviceState *usb_controller;
     USBBus *usb_bus;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     qdev_prop_set_uint32(dev, "num-irqs", GPEX_NUM_IRQS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -420,7 +420,7 @@ static void create_pcie(VMAppleMachineState *vms)
     }
 
     if (defaults_enabled()) {
-        usb_controller = qdev_new(TYPE_QEMU_XHCI);
+        usb_controller = qdev_new_orphan(TYPE_QEMU_XHCI);
         qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal);
 
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index dfad2bc508..746014416b 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1149,7 +1149,7 @@ type_init(xen_register_types)
 
 void xen_bus_init(void)
 {
-    DeviceState *dev = qdev_new(TYPE_XEN_BRIDGE);
+    DeviceState *dev = qdev_new_orphan(TYPE_XEN_BRIDGE);
     BusState *bus = qbus_new(TYPE_XEN_BUS, dev, NULL);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 7977b52712..29c90a388c 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -598,7 +598,7 @@ void xen_be_init(void)
         exit(1);
     }
 
-    xen_sysdev = qdev_new(TYPE_XENSYSDEV);
+    xen_sysdev = qdev_new_orphan(TYPE_XENSYSDEV);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
     xen_sysbus = qbus_new(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus);
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index cca37202ff..4c9a4fdea8 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -193,7 +193,7 @@ static void xen_enable_tpm(XenPVHMachineState *s)
         error_report("Couldn't find tmp0 backend");
         return;
     }
-    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
+    dev = qdev_new_orphan(TYPE_TPM_TIS_SYSBUS);
     /*
      * FIXME This use of &err is is wrong.  If both calls fail, the
      * second will trip error_setv()'s assertion.  If just one call
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e095..e31b783b91 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -61,7 +61,7 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
     qemu_irq *extints;
     int i;
 
-    dev = qdev_new(TYPE_GPEX_HOST);
+    dev = qdev_new_orphan(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space. */
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 8f85fc8ddb..4b1009a398 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -173,7 +173,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
                                       DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
     qdev_prop_set_uint32(dev, "num-blocks",
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e147622341..839c1b4147 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -407,7 +407,7 @@ struct BusState {
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
- * qdev_new: Create a device on the heap
+ * qdev_new_orphan: Create a device on the heap
  * @name: device type to create (we assert() that this type exists)
  *
  * This only allocates the memory and initializes the device state
@@ -416,19 +416,19 @@ struct BusState {
  *
  * Return: a derived DeviceState object with a reference count of 1.
  */
-DeviceState *qdev_new(const char *name);
+DeviceState *qdev_new_orphan(const char *name);
 
 /**
- * qdev_try_new: Try to create a device on the heap
+ * qdev_try_new_orphan: Try to create a device on the heap
  * @name: device type to create
  *
- * This is like qdev_new(), except it returns %NULL when type @name
+ * This is like qdev_new_orphan(), except it returns %NULL when type @name
  * does not exist, rather than asserting.
  *
  * Return: a derived DeviceState object with a reference count of 1 or
  * NULL if type @name does not exist.
  */
-DeviceState *qdev_try_new(const char *name);
+DeviceState *qdev_try_new_orphan(const char *name);
 
 /**
  * qdev_is_realized() - check if device is realized
@@ -454,7 +454,7 @@ static inline bool qdev_is_realized(DeviceState *dev)
  * If @bus, plug @dev into @bus.  This takes a reference to @dev.
  * If @dev has no QOM parent, make one up, taking another reference.
  *
- * If you created @dev using qdev_new(), you probably want to use
+ * If you created @dev using qdev_new_orphan(), you probably want to use
  * qdev_realize_and_unref() instead.
  *
  * Return: true on success, else false setting @errp with error
@@ -472,7 +472,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
  * (private) reference, which is dropped on return regardless of
  * success or failure.  Intended use::
  *
- *     dev = qdev_new();
+ *     dev = qdev_new_orphan();
  *     [...]
  *     qdev_realize_and_unref(dev, bus, errp);
  *
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index dd5930f4b5..bcdc4f21a9 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -188,7 +188,7 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
  * Call 'realize' on @dev, put it on the specified @bus, and drop the
  * reference to it.
  *
- * This function is useful if you have created @dev via qdev_new(),
+ * This function is useful if you have created @dev via qdev_new_orphan(),
  * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
  * the device it returns to you), so that you can set properties on it
  * before realizing it. If you don't need to set properties then
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 77a5077511..5158d29634 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -42,7 +42,7 @@ static inline void create_unimplemented_device(const char *name,
                                                hwaddr base,
                                                hwaddr size)
 {
-    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6d6d8ccb3d..153bf0cb9c 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -92,7 +92,7 @@ DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name);
  * reference to it. Errors are reported via @errp and by returning
  * false.
  *
- * This function is useful if you have created @dev via qdev_new()
+ * This function is useful if you have created @dev via qdev_new_orphan()
  * (which takes a reference to the device it returns to you), so that
  * you can set properties on it before realizing it. If you don't need
  * to set properties then ssi_create_peripheral() is probably better (as it
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
index 78e2ceedd7..6ef190523f 100644
--- a/include/hw/usb/usb.h
+++ b/include/hw/usb/usb.h
@@ -586,7 +586,7 @@ static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **er
 
 static inline USBDevice *usb_create_simple(USBBus *bus, const char *name)
 {
-    USBDevice *dev = USB_DEVICE(qdev_new(name));
+    USBDevice *dev = USB_DEVICE(qdev_new_orphan(name));
 
     usb_realize_and_unref(dev, bus, &error_abort);
     return dev;
diff --git a/migration/migration.c b/migration/migration.c
index 9736c14458..bdd163b65d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4076,7 +4076,7 @@ static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     /*
      * NOTE: TYPE_MIGRATION is not really a device, as the object is
-     * not created using qdev_new(), it is not attached to the qdev
+     * not created using qdev_new_orphan(), it is not attached to the qdev
      * device tree, and it is never realized.
      *
      * TODO: Make this TYPE_OBJECT once QOM provides something like
diff --git a/net/net.c b/net/net.c
index 2892f1730d..e09f0c0d4f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1214,7 +1214,7 @@ DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
         return NULL;
     }
 
-    dev = qdev_new(typename);
+    dev = qdev_new_orphan(typename);
     qdev_set_nic_properties(dev, nd);
     return dev;
 }
@@ -1264,7 +1264,7 @@ void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
             continue;
         }
 
-        dev = qdev_new(model);
+        dev = qdev_new_orphan(model);
         qdev_set_nic_properties(dev, nd);
         qdev_realize_and_unref(dev, bus, &error_fatal);
     }
diff --git a/scripts/coccinelle/qom-parent/qdev-new-orphan.cocci b/scripts/coccinelle/qom-parent/qdev-new-orphan.cocci
new file mode 100644
index 0000000000..6d07c03b39
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/qdev-new-orphan.cocci
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename qdev_new()/qdev_try_new() to qdev_new_orphan()/qdev_try_new_orphan()
+// so that the short name can be reintroduced with a mandatory
+// (parent, id, type) signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/qdev-new-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- qdev_new
++ qdev_new_orphan
+
+@@
+@@
+- qdev_try_new
++ qdev_try_new_orphan
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cc..adc37d6a89 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -707,7 +707,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* create device */
-    dev = qdev_new(driver);
+    dev = qdev_new_orphan(driver);
 
     /* Check whether the hotplug is allowed by the machine */
     if (phase_check(PHASE_MACHINE_READY) &&
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d72044aef6..9ad1b4177d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -756,7 +756,7 @@ MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
 {
     DeviceState *cpu;
 
-    cpu = qdev_new(cpu_type);
+    cpu = qdev_new_orphan(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
                              &error_abort);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2015a4e3d0..8e888a19d1 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -288,7 +288,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 {
     DeviceState *cpu;
 
-    cpu = qdev_new(cpu_type);
+    cpu = qdev_new_orphan(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     qdev_realize(cpu, NULL, &error_abort);
 
-- 
2.47.1


