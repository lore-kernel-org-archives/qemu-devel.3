Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB578CD5BA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAR9-0001rI-8R; Thu, 05 Sep 2024 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAR6-0001gl-63
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:14:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAR2-0000x5-7r
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:13:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42c5347b2f7so5219745e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725534832; x=1726139632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJH05I8SviTnOEWRieNaZX2qI3IbrIciBphhGGxywBA=;
 b=ZWV8xt/rKXou0bmyr9rAP5xf0tCl9I70hgLmNdxYbC3vMN5agCTejvZk0yV+33G8YL
 QBQEmfcZ6lqAyrTmQ/T0AzsxV0FRY1CQvgRaEOJNpzpwCNeNvzhJHdjwtK2Mt5RUa8f6
 lS5W6Dn6NGytzB3oWvckhTNvbRP0w0Jpy20JY4oemssEXBoO1lrdeGEGYmC0nW0Yl7QJ
 jI7PhfIYLsXWUQbN885LIOktwROnQAtYW0SXdUvK/3WSqv2ZnMOj5vyt45ohrtPk5tN8
 wjJpFnTjJXvEOG3lOligoRTP4uGO7aXzGM9H2XBrNy8QEqqFkeKeooSN+trRocXjN5gf
 PPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725534832; x=1726139632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJH05I8SviTnOEWRieNaZX2qI3IbrIciBphhGGxywBA=;
 b=hmMFd1H7M3RPMPn8wFTSajFyYNmmZH/m7wyCJCWkPzw9zo5nnuT2mSoEgUgPK1zX4N
 VfCcQGFRWL+5lapUujRUxxZ9a2wTLFUdv64Y/ndLays+ePAWzVxUBP2t37+Tol11QMJc
 769irqmez5D6+KqpdjjBngNN08WEsLEMQYKypvEEOBzGZMhgqAs9SgHqIt1x0dZs6NoU
 lRMlxpCwcrqSFEwndyeRKK/rIf2uYkhqjKr+dNsjGZg92Z3rE3mz58FvBKbuNUFiVHA9
 HRfXOZ20QCliSSj+AXN3LsO7LLm9kfjRYy96Bwe3M4Xv9uT5tZICHJehmxjdvkQOl7NS
 t8kQ==
X-Gm-Message-State: AOJu0YyvfpL+cg855xavgglpqdSml4Gk1jkCPwSji7zO294PZhUPcKX1
 nfMMQwJxxetlYgRogeeALkrMUTjnmGwbgvcYhpu4uhG2jiDg/PRl01ed3Urm85NSx2+psDjNn1d
 /FhQ=
X-Google-Smtp-Source: AGHT+IHlhtTy9at+KdO9f/fBaE3yzwdg+k26gsV8rN2gaUHJSw0s2iTLo/1Mxu3hqgFXvfz7eOGIpw==
X-Received: by 2002:a05:600c:470f:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42bb01aa115mr166295275e9.6.1725534831939; 
 Thu, 05 Sep 2024 04:13:51 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c554f0c2sm12606055f8f.43.2024.09.05.04.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:13:51 -0700 (PDT)
Message-ID: <08360075-385e-4083-8dea-5e2275d02834@linaro.org>
Date: Thu, 5 Sep 2024 13:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/char: Extract serial-mm
To: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hao Wu <wuhaotsh@google.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bernhard Beschow <shentey@gmail.com>
References: <20240905073832.16222-1-shentey@gmail.com>
 <20240905073832.16222-4-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905073832.16222-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 5/9/24 09:38, Bernhard Beschow wrote:
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
>    # grep -r -e "select SERIAL" | grep -v SERIAL_
>    hw/char/Kconfig:    select SERIAL
>    hw/char/Kconfig:    select SERIAL
>    hw/char/Kconfig:    select SERIAL
>    hw/char/Kconfig:    select SERIAL
>    hw/char/Kconfig:    select SERIAL
> 
>    # grep -r -e "/serial\\.h"
>    include/hw/char/serial-mm.h:#include "hw/char/serial.h"
>    hw/char/serial-pci-multi.c:#include "hw/char/serial.h"
>    hw/char/serial.c:#include "hw/char/serial.h"
>    hw/char/serial-isa.c:#include "hw/char/serial.h"
>    hw/char/serial-pci.c:#include "hw/char/serial.h"
> 
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/arm/aspeed_soc.h         |   2 +-
>   include/hw/char/mchp_pfsoc_mmuart.h |   2 +-
>   include/hw/char/serial-mm.h         |  52 +++++++++
>   include/hw/char/serial.h            |  19 ----
>   hw/arm/allwinner-a10.c              |   2 +-
>   hw/arm/allwinner-h3.c               |   2 +-
>   hw/arm/allwinner-r40.c              |   2 +-
>   hw/arm/aspeed_ast2400.c             |   2 +-
>   hw/arm/aspeed_soc_common.c          |   2 +-
>   hw/arm/kzm.c                        |   2 +-
>   hw/arm/msf2-soc.c                   |   2 +-
>   hw/arm/musicpal.c                   |   2 +-
>   hw/arm/npcm7xx.c                    |   2 +-
>   hw/arm/pxa2xx.c                     |   2 +-
>   hw/char/omap_uart.c                 |   2 +-
>   hw/char/serial-mm.c                 | 157 ++++++++++++++++++++++++++++
>   hw/char/serial.c                    | 126 ----------------------
>   hw/display/sm501.c                  |   2 +-
>   hw/hppa/machine.c                   |   2 +-
>   hw/loongarch/virt.c                 |   2 +-
>   hw/microblaze/petalogix_ml605_mmu.c |   2 +-
>   hw/mips/boston.c                    |   2 +-
>   hw/mips/jazz.c                      |   2 +-
>   hw/mips/loongson3_virt.c            |   2 +-
>   hw/mips/malta.c                     |   2 +-
>   hw/mips/mipssim.c                   |   2 +-
>   hw/openrisc/openrisc_sim.c          |   2 +-
>   hw/openrisc/virt.c                  |   2 +-
>   hw/ppc/e500.c                       |   2 +-
>   hw/ppc/ppc405_uc.c                  |   2 +-
>   hw/ppc/ppc440_bamboo.c              |   2 +-
>   hw/ppc/sam460ex.c                   |   2 +-
>   hw/ppc/virtex_ml507.c               |   2 +-
>   hw/riscv/virt.c                     |   2 +-
>   hw/sparc64/niagara.c                |   2 +-
>   hw/sparc64/sun4u.c                  |   2 +-
>   hw/xtensa/xtfpga.c                  |   2 +-
>   hw/arm/Kconfig                      |  20 ++--
>   hw/char/Kconfig                     |   4 +
>   hw/char/meson.build                 |   1 +
>   hw/display/Kconfig                  |   2 +-
>   hw/hppa/Kconfig                     |   2 +-
>   hw/loongarch/Kconfig                |   2 +-
>   hw/microblaze/Kconfig               |   2 +-
>   hw/mips/Kconfig                     |  10 +-
>   hw/openrisc/Kconfig                 |   4 +-
>   hw/ppc/Kconfig                      |  10 +-
>   hw/riscv/Kconfig                    |   2 +-
>   hw/sparc64/Kconfig                  |   1 +
>   hw/xtensa/Kconfig                   |   2 +-
>   50 files changed, 276 insertions(+), 206 deletions(-)
>   create mode 100644 include/hw/char/serial-mm.h
>   create mode 100644 hw/char/serial-mm.c


> diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
> new file mode 100644
> index 0000000000..62a8489d69
> --- /dev/null
> +++ b/include/hw/char/serial-mm.h
> @@ -0,0 +1,52 @@
> +/*
> + * QEMU 16550A UART emulation
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


> diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
> new file mode 100644
> index 0000000000..2f67776b19
> --- /dev/null
> +++ b/hw/char/serial-mm.c
> @@ -0,0 +1,157 @@
> +/*
> + * QEMU 16550A UART emulation
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

Could we start recommend to also add SPDX tags for new files committed
to the repository? They are clearer than mis-copy/pasted license with
typos and can be parsed by tools.

Regards,

Phil.

