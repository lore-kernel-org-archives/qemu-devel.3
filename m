Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB8CD5BAE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smBZa-00052C-5r; Thu, 05 Sep 2024 08:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1smBZX-0004z8-R6; Thu, 05 Sep 2024 08:26:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1smBZV-00032U-GC; Thu, 05 Sep 2024 08:26:47 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 071624E6004;
 Thu, 05 Sep 2024 14:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id xoMHgmzaeXOz; Thu,  5 Sep 2024 14:26:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EEF7F4E6000; Thu, 05 Sep 2024 14:26:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EB522746F60;
 Thu, 05 Sep 2024 14:26:35 +0200 (CEST)
Date: Thu, 5 Sep 2024 14:26:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>, 
 Stafford Horne <shorne@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, 
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 3/3] hw/char: Extract serial-mm
In-Reply-To: <20240905073832.16222-4-shentey@gmail.com>
Message-ID: <b80ddcfd-bd02-8ebd-315f-285c533aaf81@eik.bme.hu>
References: <20240905073832.16222-1-shentey@gmail.com>
 <20240905073832.16222-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 5 Sep 2024, Bernhard Beschow wrote:
> hw/char/serial currently contains the implementation of both TYPE_SERIAL and
> TYPE_SERIAL_MM. According to serial_class_init(), TYPE_SERIAL is an internal
> class while TYPE_SERIAL_MM is used by numerous machine types directly. Let's
> move the latter into its own module which makes the dependencies more obvious
> and the code more tidy.
>
> The includes and the dependencies have been converted mechanically except in the
> hw/char directories which were updated manually. The result was compile-tested.
> Now, only hw/char makes direct use of TYPE_SERIAL:
>
>  # grep -r -e "select SERIAL" | grep -v SERIAL_
>  hw/char/Kconfig:    select SERIAL
>  hw/char/Kconfig:    select SERIAL
>  hw/char/Kconfig:    select SERIAL
>  hw/char/Kconfig:    select SERIAL
>  hw/char/Kconfig:    select SERIAL
>
>  # grep -r -e "/serial\\.h"
>  include/hw/char/serial-mm.h:#include "hw/char/serial.h"
>  hw/char/serial-pci-multi.c:#include "hw/char/serial.h"
>  hw/char/serial.c:#include "hw/char/serial.h"
>  hw/char/serial-isa.c:#include "hw/char/serial.h"
>  hw/char/serial-pci.c:#include "hw/char/serial.h"
>
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/arm/aspeed_soc.h         |   2 +-
> include/hw/char/mchp_pfsoc_mmuart.h |   2 +-
> include/hw/char/serial-mm.h         |  52 +++++++++
> include/hw/char/serial.h            |  19 ----
> hw/arm/allwinner-a10.c              |   2 +-
> hw/arm/allwinner-h3.c               |   2 +-
> hw/arm/allwinner-r40.c              |   2 +-
> hw/arm/aspeed_ast2400.c             |   2 +-
> hw/arm/aspeed_soc_common.c          |   2 +-
> hw/arm/kzm.c                        |   2 +-
> hw/arm/msf2-soc.c                   |   2 +-
> hw/arm/musicpal.c                   |   2 +-
> hw/arm/npcm7xx.c                    |   2 +-
> hw/arm/pxa2xx.c                     |   2 +-
> hw/char/omap_uart.c                 |   2 +-
> hw/char/serial-mm.c                 | 157 ++++++++++++++++++++++++++++
> hw/char/serial.c                    | 126 ----------------------
> hw/display/sm501.c                  |   2 +-
> hw/hppa/machine.c                   |   2 +-
> hw/loongarch/virt.c                 |   2 +-
> hw/microblaze/petalogix_ml605_mmu.c |   2 +-
> hw/mips/boston.c                    |   2 +-
> hw/mips/jazz.c                      |   2 +-
> hw/mips/loongson3_virt.c            |   2 +-
> hw/mips/malta.c                     |   2 +-
> hw/mips/mipssim.c                   |   2 +-
> hw/openrisc/openrisc_sim.c          |   2 +-
> hw/openrisc/virt.c                  |   2 +-
> hw/ppc/e500.c                       |   2 +-
> hw/ppc/ppc405_uc.c                  |   2 +-
> hw/ppc/ppc440_bamboo.c              |   2 +-
> hw/ppc/sam460ex.c                   |   2 +-
> hw/ppc/virtex_ml507.c               |   2 +-
> hw/riscv/virt.c                     |   2 +-
> hw/sparc64/niagara.c                |   2 +-
> hw/sparc64/sun4u.c                  |   2 +-
> hw/xtensa/xtfpga.c                  |   2 +-
> hw/arm/Kconfig                      |  20 ++--
> hw/char/Kconfig                     |   4 +
> hw/char/meson.build                 |   1 +
> hw/display/Kconfig                  |   2 +-
> hw/hppa/Kconfig                     |   2 +-
> hw/loongarch/Kconfig                |   2 +-
> hw/microblaze/Kconfig               |   2 +-
> hw/mips/Kconfig                     |  10 +-
> hw/openrisc/Kconfig                 |   4 +-
> hw/ppc/Kconfig                      |  10 +-
> hw/riscv/Kconfig                    |   2 +-
> hw/sparc64/Kconfig                  |   1 +
> hw/xtensa/Kconfig                   |   2 +-
> 50 files changed, 276 insertions(+), 206 deletions(-)
> create mode 100644 include/hw/char/serial-mm.h
> create mode 100644 hw/char/serial-mm.c
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 624d489e0d..689f52dae8 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -39,7 +39,7 @@
> #include "hw/misc/unimp.h"
> #include "hw/misc/aspeed_peci.h"
> #include "hw/fsi/aspeed_apb2opb.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-mm.h"
> #include "hw/intc/arm_gicv3.h"
>
> #define ASPEED_SPIS_NUM  2
> diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
> index b0e14ca355..a7b8b1b08b 100644
> --- a/include/hw/char/mchp_pfsoc_mmuart.h
> +++ b/include/hw/char/mchp_pfsoc_mmuart.h
> @@ -29,7 +29,7 @@
> #define HW_MCHP_PFSOC_MMUART_H
>
> #include "hw/sysbus.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-mm.h"
>
> #define MCHP_PFSOC_MMUART_REG_COUNT 13
>
> diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
> new file mode 100644
> index 0000000000..62a8489d69
> --- /dev/null
> +++ b/include/hw/char/serial-mm.h
> @@ -0,0 +1,52 @@
> +/*
> + * QEMU 16550A UART emulation

This is now only "memory mapped 16550A compatible UART emulation" or 
something like that, the actual 16550A emulation is in serial.c where this 
was moved from. Maybe worth making it clear in this comment and in 
serial-mm.c as well.

Regards,
BALATON Zoltan

