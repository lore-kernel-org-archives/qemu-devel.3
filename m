Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7649CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERtm-0000RN-6H; Thu, 30 Oct 2025 08:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vERtf-0000RA-NB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:36:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vERtU-000712-NH
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:36:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7a4176547bfso977364b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761827800; x=1762432600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jiA3TVeTk03hcxDVVESJGnJYy4UZWUreyttuFTt8+BU=;
 b=Im2275GjNiCLLVe9jVMPNS9GM2wJE9Xv8GOz0UULlGOr7Gg9Gi2aWQyHt74+edQA4v
 NOqZD+tdN/hOJeImGK8khYRaAFj8vhitIiK6N3moZCUL47m7gy/QAD8y3LQaUQxAwm9b
 E1CBYpCBFU6smOVqU00dcOhnFUjsau1YjcQ8/oLxO2s6l32RXrakHUD4Xvz0J+m1Jtvj
 7Gmbyh3eLLS/dvALHAHsvOPugEjBgJ1YKQe3x3j/tNMds2+ojXhSV4EYR0KM+9dE9ILc
 tz3/VRhMVsugBH12qDZls2EITs3HBaWRl4helWWtSmWAayCKnEWq6jZr6zYYolgrtBPh
 PqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761827800; x=1762432600;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiA3TVeTk03hcxDVVESJGnJYy4UZWUreyttuFTt8+BU=;
 b=Wtj4B8rk+v4HXkmasbMJVtHAdQp8TC011oLyeCeIbjECpHwqQFdNXJbaa8cxG0/0g9
 NVLncxFGXOj2pCj7DgEPbfAKBb2mCalTq2a2joyJzRW23p8hooRTlgID3ttNnodjVkHG
 CPtQuIWBh1Dg0b7OyOIm9LjS0HPDThRWTpE2/IqakwImAR3I698uuUiJECRUxvwKBCUU
 ZPE+o5Sx8HfjBWdBQxP3WsnydJcZncSWY2xmM5rWbW/7HBD18GSK6JO3cmQcxKobZjJu
 WoYsQmfd2ca70UVvCkVEQlzq3Gepa+bbraKYB24CKZRkfh28yvS6gIMPXRe28fPBist2
 uvqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3rbbBefE7EXzdmwLA+t+nMllUxFH0Tlh+1hFV/olnhsx0FDq+qlBPQ/3xY+uyBFJbM70v8sEa+Db5@nongnu.org
X-Gm-Message-State: AOJu0Yxt6Drjrch/WMk77kKnTj4W2zZNJbCycp31NlA15wQoiD64CSD6
 O1mOi6zJePtB5qPYjo10zSRelq/YJ7SeC+Hq8etz1kEjJa8wbCnCbM6RT3X0031gnEt9rQZgIiz
 Ex6J40Uc=
X-Gm-Gg: ASbGncv6o1HdZMyE/e0/co7HyvuZ1IHdcnHL71uVCX+hTMgcUSQqoxFedCdZwlKl2qX
 QbG/N6CHFOHR2tJSBqXoU+Jj24/a2uMTkoaZEl7qwwduwEX+CEXsveq3oVTaJ6ZOeVtVZ0t4rXH
 nRxa7IJDd32IH6zyfgqP+K8aB54ixODBd+NQlVe0aER91fcciUJu3RLpqCwFtc/iTKgcc0wxEom
 Pp8ICwCC4c0wr3L/P/akTmELWvKU8K1kTYQplT4oyCcAgKmFQ5SigFEGptDBwUlGIovKcNHSQ4L
 3if77VbBmRXaPQBMmfkf9eGbhepCJqU5DrxXpuQaeRe9OCqUlf+bQkKh/6lWtNFHtNW9bspj/q0
 2fsNgtbx8d8NA4V5vAQvilMqHSTPpU4k/a8SNyjqS3myYX/fdnxJUYmU7d1+KQx5NztAh/IhjJk
 A+IfKSB4gN8i2taPYrC+sgH3k=
X-Google-Smtp-Source: AGHT+IHBAXy4Y0BYi28NbGZy4eg1/DCv8LCg9afnRaJRtwwdyfMysMbtGq2EImA627wxI/3bvTSdzA==
X-Received: by 2002:a05:6a00:12e8:b0:781:c54:4d24 with SMTP id
 d2e1a72fcca58-7a4e482d746mr8450553b3a.21.1761827799704; 
 Thu, 30 Oct 2025 05:36:39 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414087d2asm19074545b3a.63.2025.10.30.05.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 05:36:39 -0700 (PDT)
Message-ID: <b6c09324-15d1-4c1a-b941-008c0a4feeb9@ventanamicro.com>
Date: Thu, 30 Oct 2025 09:36:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/char: add NEORV32 UART (CTRL/DATA, fifo,
 chardev)
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-4-michael@videogpu.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251027100938.11822-4-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch fails to build (in my env at least):



/home/danielhb/work/qemu/include/hw/char/neorv32_uart.h:57:5: error: unknown type name ‘CharBackend’; did you mean ‘ChardevBackend’?
    57 |     CharBackend chr;
       |     ^~~~~~~~~~~
       |     ChardevBackend
In file included from /home/danielhb/work/qemu/include/qemu/osdep.h:53,
                  from ../hw/char/neorv32_uart.c:23:
/home/danielhb/work/qemu/include/qemu/compiler.h:65:35: error: invalid operands to binary - (have ‘CharFrontend *’ and ‘int *’)
    65 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)
       |                                   ^
/home/danielhb/work/qemu/include/hw/qdev-properties.h:82:15: note: in expansion of macro ‘type_check’
    82 |             + type_check(_type, typeof_field(_state, _field)),   \
       |               ^~~~~~~~~~
/home/danielhb/work/qemu/include/hw/qdev-properties-system.h:41:5: note: in expansion of macro ‘DEFINE_PROP’
    41 |     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)
       |     ^~~~~~~~~~~
../hw/char/neorv32_uart.c:41:5: note: in expansion of macro ‘DEFINE_PROP_CHR’
    41 |     DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
       |     ^~~~~~~~~~~~~~~
../hw/char/neorv32_uart.c: In function ‘neorv32_uart_read’:
../hw/char/neorv32_uart.c:121:42: error: passing argument 1 of ‘qemu_chr_fe_accept_input’ from incompatible pointer type [-Wincompatible-pointer-types]
   121 |                 qemu_chr_fe_accept_input(&s->chr);
       |                                          ^~~~~~~
       |                                          |
       |                                          int *
In file included from ../hw/char/neorv32_uart.c:28:
/home/danielhb/work/qemu/include/chardev/char-fe.h:131:45: note: expected ‘CharFrontend *’ but argument is of type ‘int *’
   131 | void qemu_chr_fe_accept_input(CharFrontend *c);
       |                               ~~~~~~~~~~~~~~^
../hw/char/neorv32_uart.c: In function ‘neorv32_uart_write’:
../hw/char/neorv32_uart.c:156:31: error: passing argument 1 of ‘qemu_chr_fe_write’ from incompatible pointer type [-Wincompatible-pointer-types]
   156 |             qemu_chr_fe_write(&s->chr, &ch, 1);
       |                               ^~~~~~~
       |                               |
       |                               int *
/home/danielhb/work/qemu/include/chardev/char-fe.h:232:37: note: expected ‘CharFrontend *’ but argument is of type ‘int *’
   232 | int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);
       |                       ~~~~~~~~~~~~~~^
../hw/char/neorv32_uart.c: In function ‘neorv32_uart_be_change’:
../hw/char/neorv32_uart.c:216:30: error: passing argument 1 of ‘qemu_chr_fe_set_handlers’ from incompatible pointer type [-Wincompatible-pointer-types]
   216 |     qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
       |                              ^~~~~~~
       |                              |
       |                              int *
/home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected ‘CharFrontend *’ but argument is of type ‘int *’
   108 | void qemu_chr_fe_set_handlers(CharFrontend *c,
       |                               ~~~~~~~~~~~~~~^
../hw/char/neorv32_uart.c: In function ‘neorv32_uart_realize’:
../hw/char/neorv32_uart.c:227:30: error: passing argument 1 of ‘qemu_chr_fe_set_handlers’ from incompatible pointer type [-Wincompatible-pointer-types]
   227 |     qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
       |                              ^~~~~~~
       |                              |
       |                              int *
/home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected ‘CharFrontend *’ but argument is of type ‘int *’
   108 | void qemu_chr_fe_set_handlers(CharFrontend *c,
       |                               ~~~~~~~~~~~~~~^
[1730/3024] Compiling C object libsystem.a.p/hw_core_sysbus-fdt.c.o
ninja: build stopped: subcommand failed.


Thanks,

Daniel

On 10/27/25 7:09 AM, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.
> Includes Kconfig/meson and public header.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> 
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb..1fd39c2b30 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -95,3 +95,6 @@ config IP_OCTAL_232
>       bool
>       default y
>       depends on IPACK
> +
> +config NEORV32_UART
> +    bool
> 
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index a9e1dc26c0..2f5bf827a7 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
>   system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
>   system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
> +system_ss.add(when: 'CONFIG_NEORV32_UART', if_true: files('neorv32_uart.c'))
>   system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
>   system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
>   system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
> 
> diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
> new file mode 100644
> index 0000000000..b54ab54d6a
> --- /dev/null
> +++ b/hw/char/neorv32_uart.c
> @@ -0,0 +1,311 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "hw/irq.h"
> +#include "hw/char/neorv32_uart.h"
> +#include "hw/qdev-properties-system.h"
> +
> +typedef volatile struct __attribute__((packed,aligned(4))) {
> +  uint32_t CTRL;  /**< offset 0: control register (#NEORV32_UART_CTRL_enum) */
> +  uint32_t DATA;  /**< offset 4: data register  (#NEORV32_UART_DATA_enum) */
> +} neorv32_uart_t;
> +
> +#define NEORV32_UART_IO_REGION_SIZE  (32)
> +
> +static Property neorv32_uart_properties[] = {
> +    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
> +};
> +
> +enum {
> +    NEORV32_UART_CTRL = 0,  /**< offset 0: control register */
> +    NEORV32_UART_DATA = 4  /**< offset 4: data register  */
> +};
> +
> +/** UART control register bits */
> +enum NEORV32_UART_CTRL_enum {
> +  UART_CTRL_EN            =  0, /**< UART control register(0)  (r/w): UART global enable */
> +  UART_CTRL_SIM_MODE      =  1, /**< UART control register(1)  (r/w): Simulation output override enable */
> +  UART_CTRL_HWFC_EN       =  2, /**< UART control register(2)  (r/w): Enable RTS/CTS hardware flow-control */
> +  UART_CTRL_PRSC_LSB      =  3, /**< UART control register(3)  (r/w): clock prescaler select, bit 0 (LSB) */
> +  UART_CTRL_PRSC_MSB      =  5, /**< UART control register(5)  (r/w): clock prescaler select, bit 2 (MSB) */
> +  UART_CTRL_BAUD_LSB      =  6, /**< UART control register(6)  (r/w): BAUD rate divisor, bit 0 (LSB) */
> +  UART_CTRL_BAUD_MSB      = 15, /**< UART control register(15) (r/w): BAUD rate divisor, bit 9 (MSB) */
> +  UART_CTRL_RX_NEMPTY     = 16, /**< UART control register(16) (r/-): RX FIFO not empty */
> +  UART_CTRL_RX_FULL       = 17, /**< UART control register(17) (r/-): RX FIFO full */
> +  UART_CTRL_TX_EMPTY      = 18, /**< UART control register(18) (r/-): TX FIFO empty */
> +  UART_CTRL_TX_NFULL      = 19, /**< UART control register(19) (r/-): TX FIFO not full */
> +  UART_CTRL_IRQ_RX_NEMPTY = 20, /**< UART control register(20) (r/w): Fire IRQ if RX FIFO not empty */
> +  UART_CTRL_IRQ_RX_FULL   = 21, /**< UART control register(21) (r/w): Fire IRQ if RX FIFO full */
> +  UART_CTRL_IRQ_TX_EMPTY  = 22, /**< UART control register(22) (r/w): Fire IRQ if TX FIFO empty */
> +  UART_CTRL_IRQ_TX_NFULL  = 23, /**< UART control register(23) (r/w): Fire IRQ if TX FIFO not full */
> +
> +  UART_CTRL_RX_OVER       = 30, /**< UART control register(30) (r/-): RX FIFO overflow */
> +  UART_CTRL_TX_BUSY       = 31  /**< UART control register(31) (r/-): Transmitter busy or TX FIFO not empty */
> +};
> +
> +/**  bits */
> +enum NEORV32_UART_DATA_enum {
> +  UART_DATA_RTX_LSB          =  0, /**< (r/w): UART rx/tx data, LSB */
> +  UART_DATA_RTX_MSB          =  7, /**< (r/w): UART rx/tx data, MSB */
> +
> +  UART_DATA_RX_FIFO_SIZE_LSB =  8, /**< (r/-): log2(RX FIFO size), LSB */
> +  UART_DATA_RX_FIFO_SIZE_MSB = 11, /**< (r/-): log2(RX FIFO size), MSB */
> +
> +  UART_DATA_TX_FIFO_SIZE_LSB = 12, /**< (r/-): log2(RX FIFO size), LSB */
> +  UART_DATA_TX_FIFO_SIZE_MSB = 15, /**< (r/-): log2(RX FIFO size), MSB */
> +};
> +/**@}*/
> +
> +static void neorv32_uart_update_irq(Neorv32UARTState *s)
> +{
> +    int cond = 0;
> +    if ((s->ie & NEORV32_UART_IE_TXWM) ||
> +        ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
> +        cond = 1;
> +    }
> +    if (cond) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static uint64_t
> +neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    Neorv32UARTState *s = opaque;
> +    unsigned char r;
> +
> +    switch (addr) {
> +        case NEORV32_UART_CTRL:
> +			if (s->rx_fifo_len) {
> +				s->CTRL |= (1 << UART_CTRL_RX_NEMPTY); /* set data available */
> +			} else {
> +				s->CTRL &= ~(1 << UART_CTRL_RX_NEMPTY); /* clear data available */
> +			}
> +			//TODO: assuming here TX is always avalable, fix it.
> +			s->CTRL |= (1 << UART_CTRL_TX_NFULL); /* set TX not full */
> +
> +        	return s->CTRL;
> +
> +        case NEORV32_UART_DATA:
> +            if (s->rx_fifo_len) {
> +                r = s->rx_fifo[0];
> +                memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
> +                s->rx_fifo_len--;
> +                qemu_chr_fe_accept_input(&s->chr);
> +                s->DATA = r;
> +
> +                neorv32_uart_update_irq(s); /* TODO: check if need to call */
> +                return r;
> +            }
> +        }
> +
> +
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=0x%x\n",
> +                  __func__, (int)addr);
> +    return 0;
> +}
> +
> +
> +
> +static void
> +neorv32_uart_write(void *opaque, hwaddr addr,
> +                  uint64_t val64, unsigned int size)
> +{
> +
> +    Neorv32UARTState *s = opaque;
> +    uint32_t value = val64;
> +    unsigned char ch = value;
> +
> +    /* TODO: check if need to update data and control bits */
> +    switch (addr) {
> +        case NEORV32_UART_CTRL:
> +            s->CTRL = value;
> +            /* TODO: check if need to call, depending on IRQ flags */
> +            /* neorv32_uart_update_irq(s); */
> +            return;
> +        case NEORV32_UART_DATA:
> +            s->DATA = value;
> +            qemu_chr_fe_write(&s->chr, &ch, 1);
> +            /* neorv32_uart_update_irq(s); TODO: check if need to call */
> +            return;
> +        }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
> +                  __func__, (int)addr, (int)value);
> +}
> +
> +static const MemoryRegionOps neorv32_uart_ops = {
> +    .read  = neorv32_uart_read,
> +    .write = neorv32_uart_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void neorv32_uart_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
> +                          TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +
> +static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    /* Got a byte.  */
> +    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
> +        printf("WARNING: UART dropped char.\n");
> +        return;
> +    }
> +    s->rx_fifo[s->rx_fifo_len++] = *buf;
> +
> +    neorv32_uart_update_irq(s);
> +}
> +
> +static int neorv32_uart_can_rx(void *opaque)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> +}
> +
> +static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
> +{
> +}
> +
> +static int  neorv32_uart_be_change(void *opaque)
> +{
> +    Neorv32UARTState *s = opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
> +                             neorv32_uart_event, neorv32_uart_be_change, s,
> +                             NULL, true);
> +
> +    return 0;
> +}
> +
> +static void neorv32_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
> +                            neorv32_uart_event, neorv32_uart_be_change, s,
> +                             NULL, true);
> +
> +}
> +
> +static const VMStateDescription vmstate_neorv32_uart = {
> +    .name = TYPE_NEORV32_UART,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(rx_fifo,
> +                            Neorv32UARTState,
> +                            NEORV32_UART_RX_FIFO_SIZE),
> +        VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
> +        VMSTATE_UINT32(ie, Neorv32UARTState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void neorv32_uart_reset_enter(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +    s->rx_fifo_len = 0;
> +    s->ie = 0;
> +}
> +
> +static void neorv32_uart_reset_hold(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s = NEORV32_UART(obj);
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static void neorv32_uart_class_init(ObjectClass *oc,const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +
> +    dc->realize = neorv32_uart_realize;
> +    dc->vmsd = &vmstate_neorv32_uart;
> +    rc->phases.enter = neorv32_uart_reset_enter;
> +    rc->phases.hold  = neorv32_uart_reset_hold;
> +    device_class_set_props(dc, neorv32_uart_properties);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo neorv32_uart_info = {
> +    .name          = TYPE_NEORV32_UART,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(Neorv32UARTState),
> +    .instance_init = neorv32_uart_init,
> +    .class_init    = neorv32_uart_class_init,
> +};
> +
> +static void neorv32_uart_register_types(void)
> +{
> +    type_register_static(&neorv32_uart_info);
> +}
> +
> +type_init(neorv32_uart_register_types)
> +/*
> + * Create UART device.
> + */
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,
> +                                      hwaddr base,
> +                                      Chardev *chr)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +    bool succed= false;
> +
> +    dev = qdev_new("riscv.neorv32.uart");
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    s = SYS_BUS_DEVICE(dev);
> +    succed = sysbus_realize_and_unref(s, &error_fatal);
> +
> +    if (succed) {
> +        memory_region_add_subregion(address_space, base,
> +                                    sysbus_mmio_get_region(s, 0));
> +        return NEORV32_UART(dev);
> +    } else {
> +        return NULL;
> +    }
> +} //neorv32_uart_create
> 
> diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_uart.h
> new file mode 100644
> index 0000000000..3651d4741f
> --- /dev/null
> +++ b/include/hw/char/neorv32_uart.h
> @@ -0,0 +1,68 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_NEORV32_UART_H
> +#define HW_NEORV32_UART_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NEORV32_UART "riscv.neorv32.uart"
> +OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
> +
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8 /**256 < UART data register(8)  (r/-): log2(RX FIFO size), LSB */
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11 /** 2048 < UART data register(11) (r/-): log2(RX FIFO size), MSB */
> +
> +#define NEORV32_UART_RX_FIFO_SIZE  32 //in HW it is  2048 + 256 = _MSB + _LSB
> +
> +enum {
> +	NEORV32_UART_IE_TXWM       = 1, /* Transmit watermark interrupt enable */
> +	NEORV32_UART_IE_RXWM       = 2  /* Receive watermark interrupt enable */
> +};
> +
> +enum {
> +	NEORV32_UART_IP_TXWM       = 1, /* Transmit watermark interrupt pending */
> +	NEORV32_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
> +};
> +
> +
> +
> +struct Neorv32UARTState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    qemu_irq irq;
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
> +    uint8_t rx_fifo_len;
> +    uint32_t ie; //interrupt enable
> +    uint32_t CTRL;
> +    uint32_t DATA;
> +};
> +
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
> +    Chardev *chr);
> +
> +#endif //HW_NEORV32_UART_H


