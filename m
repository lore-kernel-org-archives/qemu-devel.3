Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C754C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmay-0005RU-FE; Wed, 21 Aug 2024 10:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgmal-0004Xf-9f; Wed, 21 Aug 2024 10:45:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgmag-00073l-Oe; Wed, 21 Aug 2024 10:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kNEcfz7hJAz/U71mAYHvPo73lBqJvJH+D0fo0fTCMwU=; b=kIZ5GRKxlRViIV4thRJAbMJH2H
 CCxxEMWrxvybkvSLgkUTovLEB40ItG+6FLGe6cBHxaFYP7tHusStVFu36xwbI/RF7LGAWpyPLOFks
 GbJNqmlSH15yvdoM2ePAFoKRgRZoKwiXtX6DCGpb3sgzs+5g2V7FZGoFHVpWo08mW6CvNHw3fqsq8
 VOOWybOMRNxb1n6FOujUWJrk3g1EuUWBAjnxfh7gnDXo9w/4EN/VDBGXhBoS/3zhw59zUMd56Shni
 zldjOOhpfc9YkT5E5/T+y2qJkOHtvbLH9djJ20ie2wa9t7AaAHMSAuaAjWIsOixwmaW86jbdaY3gh
 bcUgiiG3nXnwKMOJczmk7/uLSkxE6/lGVB4HrCdQsJLaWrWx/38NHjywBXKTlep/J/Vol09wvc+Bw
 wKDAT75mGICWxSMALfnV0Jbakxt8T423WzO9LJz5nfBuduo3WQPdqp/GWF41ldf6e147WdP0LElM9
 Q139Zbppq1peWPzo4DWdWt9tkoRPvpZet2b7IY6oybbO2/qKMXpBkYUHkWxB2tda4E8C7V43URYhc
 4CpRKUPiaA3Fx+KxVvyShNAThaTxcEOKHGbuj45FveUfq8j7RpzATDn4cZGb+F5nqwtBKJnhWE/vW
 fXb9AgKVcSdW3l3PG7qN/8qIHlmXOmM9yHZjZsB2w=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgmZo-0001Gq-DU; Wed, 21 Aug 2024 15:44:48 +0100
Message-ID: <2a0ffad6-1d5f-4440-a111-edb8adf0879d@ilande.co.uk>
Date: Wed, 21 Aug 2024 15:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Jia Liu <proljc@gmail.com>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Subbaraya Sundeep
 <sundeep.lkml@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>
References: <20240814181534.218964-1-shentey@gmail.com>
 <20240814181534.218964-5-shentey@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240814181534.218964-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/5] hw/char/serial.h: Extract serial-isa.h
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 14/08/2024 19:15, Bernhard Beschow wrote:

> The includes where updated based on compile errors. Now, the inclusion of the
> header roughly matches Kconfig dependencies:
> 
>    # grep -r -e "select SERIAL_ISA"
>    hw/ppc/Kconfig:    select SERIAL_ISA
>    hw/isa/Kconfig:    select SERIAL_ISA
>    hw/sparc64/Kconfig:    select SERIAL_ISA
>    hw/i386/Kconfig:    select SERIAL_ISA
>    hw/i386/Kconfig:    select SERIAL_ISA # for serial_hds_isa_init()
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/char/serial-isa.h | 38 ++++++++++++++++++++++++++++++++++++
>   include/hw/char/serial.h     |  9 ---------
>   hw/char/serial-isa.c         |  1 +
>   hw/i386/microvm-dt.c         |  2 +-
>   hw/i386/microvm.c            |  2 +-
>   hw/i386/pc.c                 |  2 +-
>   hw/isa/isa-superio.c         |  2 +-
>   hw/isa/vt82c686.c            |  2 +-
>   hw/ppc/pnv.c                 |  2 +-
>   hw/sparc64/sun4u.c           |  1 +
>   10 files changed, 46 insertions(+), 15 deletions(-)
>   create mode 100644 include/hw/char/serial-isa.h
> 
> diff --git a/include/hw/char/serial-isa.h b/include/hw/char/serial-isa.h
> new file mode 100644
> index 0000000000..8517afa128
> --- /dev/null
> +++ b/include/hw/char/serial-isa.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU ISA 16550A UART emulation
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + * Copyright (c) 2008 Citrix Systems, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_SERIAL_ISA_H
> +#define HW_SERIAL_ISA_H
> +
> +#include "hw/isa/isa.h"
> +
> +#define MAX_ISA_SERIAL_PORTS 4
> +
> +#define TYPE_ISA_SERIAL "isa-serial"
> +void serial_hds_isa_init(ISABus *bus, int from, int to);
> +void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
> +void isa_serial_set_enabled(ISADevice *serial, bool enabled);
> +
> +#endif
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 40aad21df3..ccf322a031 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -104,13 +104,4 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
>                            qemu_irq irq, int baudbase,
>                            Chardev *chr, enum device_endian end);
>   
> -/* serial-isa.c */
> -
> -#define MAX_ISA_SERIAL_PORTS 4
> -
> -#define TYPE_ISA_SERIAL "isa-serial"
> -void serial_hds_isa_init(ISABus *bus, int from, int to);
> -void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
> -void isa_serial_set_enabled(ISADevice *serial, bool enabled);
> -
>   #endif
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 329b352b9a..b562ec9d37 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -29,6 +29,7 @@
>   #include "sysemu/sysemu.h"
>   #include "hw/acpi/acpi_aml_interface.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
> index b3049e4f9f..fc5db6ed7f 100644
> --- a/hw/i386/microvm-dt.c
> +++ b/hw/i386/microvm-dt.c
> @@ -34,7 +34,7 @@
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "sysemu/device_tree.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/i386/fw_cfg.h"
>   #include "hw/rtc/mc146818rtc.h"
>   #include "hw/sysbus.h"
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 40edcee7af..05c882669c 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -39,7 +39,7 @@
>   #include "hw/intc/i8259.h"
>   #include "hw/timer/i8254.h"
>   #include "hw/rtc/mc146818rtc.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/i386/topology.h"
>   #include "hw/i386/e820_memory_layout.h"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..b273d4a2e1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -25,7 +25,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "hw/i386/pc.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/char/parallel.h"
>   #include "hw/hyperv/hv-balloon.h"
>   #include "hw/i386/fw_cfg.h"
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index a8c8c58ef7..cff756e791 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -22,7 +22,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/input/i8042.h"
>   #include "hw/char/parallel-isa.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "trace.h"
>   
>   static void isa_superio_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 505b44c4e6..1aa5c9613f 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -17,7 +17,7 @@
>   #include "hw/isa/vt82c686.h"
>   #include "hw/block/fdc.h"
>   #include "hw/char/parallel-isa.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/pci/pci.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/ide/pci.h"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3526852685..ffc3f2bca0 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -53,7 +53,7 @@
>   #include "hw/ppc/pnv_pnor.h"
>   
>   #include "hw/isa/isa.h"
> -#include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/rtc/mc146818rtc.h"
>   
>   #include <libfdt.h>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 4ece1ac1ff..a839abbf5d 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -35,6 +35,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/pci-host/sabre.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/serial-isa.h"
>   #include "hw/char/parallel-isa.h"
>   #include "hw/rtc/m48t59.h"
>   #include "migration/vmstate.h"

This appears to be a straightforward substitution and LGTM:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


