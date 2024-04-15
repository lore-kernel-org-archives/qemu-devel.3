Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJ8c-0003Wd-5s; Mon, 15 Apr 2024 06:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwJ8N-0003Vh-NF
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:00:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwJ8J-0001TZ-9e
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:00:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4185e80adfbso2548455e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713175210; x=1713780010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wVZoDGmy7n2YFhP3n9Yj01/03KToH2CTZo5lCQd8atk=;
 b=c3zpf019oxV+LWLPhFoPco35sP8xqhUcQbp/lIa0Gj0cJusCtKpCW+eMaBqHRJAR47
 Y1rJG/a5Kr1ToVQj8s+M0Do/AnGXlvghrgELnPHwhy2M0U12lbACtiqEAC7QgSqrgHq5
 BkJwG6o5v03NQBeGEtdBKXqZfKxZzP4a1fnaTADFNFIutW4EYXvFY5l6NkJf+nuPIbEC
 IwGJ6FZEQ3lIHesTa0HmZQTtC6I4Tsj+qQzK+ctz3lVAQoUjCUVQoApEwSwceshkWysc
 QHpW3ZOBLZf875ooJrHTLNUSsUYanbxh9pd7N+mTv/8mJEftWU9nZW+gmkqSchqHQ18j
 vpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713175210; x=1713780010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVZoDGmy7n2YFhP3n9Yj01/03KToH2CTZo5lCQd8atk=;
 b=YxQ46LILEJOyZRr8Hvzmd6CZNxU5dsoNI8NhQbCa68Vms6wL5u8fWIbcp0HYg3gK4C
 SFetEkOfZpxHxtxoptSLzfydzg7pedF5mwUnLWXDkSKtGG5I6Y5GRBwe4FMuxMCRgrcB
 8U5+2QLXf1NsIkHdUUc21HkmG37glDS0STS6jfU2ZUmzEhc36AdztFjq5XHVmhjIRq57
 Wwvyb9S/JpCpmvTDy6GrgNvUZ+hr6bOLB0D32pGChw/EOksfFaRdyPfro9RxWdfnEr1i
 1OKeERSKemMYF5qdZgdav9Y68fYZXCjYeXmWdQ/dc0HyIbyfi60uY7snL1dnSmWkmk1p
 OmDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSa/fqUHcWlH2jEXOQ+Iwlib9aNZhwyIyo1XUvIYtdet4M1ldmWI4uhvrd/hEaM5EIqceYWnXyeszm1Azlf/0bHZmedqE=
X-Gm-Message-State: AOJu0YyxBiQYd3eM5OyFMputsKO+aY/8IBa0UqcbIYyyyktHgzuosUuK
 fMwMqiKwp83a9cMkUQaoB6wKUDkqPnZ1yQp/+KdmnMvBzLFjx0E0DeVNeFa67HQ=
X-Google-Smtp-Source: AGHT+IEZ4Zam1WLxIHlxdzE2MTRpFWGgWUfgh2liw+KOPw3Kv0mzCSJOwO8vYV510gSeLqIYzSE0ZA==
X-Received: by 2002:a05:600c:501e:b0:418:5ed2:5aa7 with SMTP id
 n30-20020a05600c501e00b004185ed25aa7mr1621819wmr.14.1713175210588; 
 Mon, 15 Apr 2024 03:00:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 ay36-20020a05600c1e2400b004186df974f1sm1959303wmb.33.2024.04.15.03.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 03:00:10 -0700 (PDT)
Message-ID: <3995d868-c7fe-40c0-840f-4929ad17557f@linaro.org>
Date: Mon, 15 Apr 2024 12:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] hw/display : Add device DM163
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-2-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414130604.182059-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Inès,

On 14/4/24 15:05, Inès Varhol wrote:
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. The columns of the matrix are
> driven by the DM163 and the rows are driven externally.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   docs/system/arm/b-l475e-iot01a.rst |   3 +-
>   include/hw/display/dm163.h         |  58 +++++
>   hw/display/dm163.c                 | 333 +++++++++++++++++++++++++++++
>   hw/display/Kconfig                 |   3 +
>   hw/display/meson.build             |   1 +
>   hw/display/trace-events            |  14 ++
>   6 files changed, 411 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/display/dm163.h
>   create mode 100644 hw/display/dm163.c


> diff --git a/include/hw/display/dm163.h b/include/hw/display/dm163.h
> new file mode 100644
> index 0000000000..00d0504640
> --- /dev/null
> +++ b/include/hw/display/dm163.h
> @@ -0,0 +1,58 @@
> +/*
> + * QEMU DM163 8x3-channel constant current led driver
> + * driving columns of associated 8x8 RGB matrix.
> + *
> + * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
> + * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (C) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DISPLAY_DM163_H
> +#define HW_DISPLAY_DM163_H
> +
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_DM163 "dm163"
> +OBJECT_DECLARE_SIMPLE_TYPE(DM163State, DM163);
> +
> +#define DM163_NUM_LEDS 24
> +#define RGB_MATRIX_NUM_ROWS 8
> +#define RGB_MATRIX_NUM_COLS (DM163_NUM_LEDS / 3)

Maybe better as:

   #define DM163_NUM_LEDS (RGB_MATRIX_NUM_COLS * RGB_MATRIX_NUM_ROWS)

> +#define COLOR_BUFFER_SIZE RGB_MATRIX_NUM_ROWS

It could ease the code to define here directly as:

   /* The last row is filled with 0 (turned off row) */
   #define COLOR_BUFFER_SIZE (RGB_MATRIX_NUM_ROWS + 1)

> +
> +typedef struct DM163State {
> +    DeviceState parent_obj;
> +
> +    /* DM163 driver */
> +    uint64_t bank0_shift_register[3];
> +    uint64_t bank1_shift_register[3];
> +    uint16_t latched_outputs[DM163_NUM_LEDS];
> +    uint16_t outputs[DM163_NUM_LEDS];
> +    qemu_irq sout;
> +
> +    uint8_t sin;
> +    uint8_t dck;
> +    uint8_t rst_b;
> +    uint8_t lat_b;
> +    uint8_t selbk;
> +    uint8_t en_b;
> +
> +    /* IM120417002 colors shield */
> +    uint8_t activated_rows;
> +
> +    /* 8x8 RGB matrix */
> +    QemuConsole *console;
> +    uint8_t redraw;
> +    /* Rows currently being displayed on the matrix. */
> +    /* The last row is filled with 0 (turned off row) */
> +    uint32_t buffer[COLOR_BUFFER_SIZE + 1][RGB_MATRIX_NUM_COLS];
> +    uint8_t last_buffer_idx;
> +    uint8_t buffer_idx_of_row[RGB_MATRIX_NUM_ROWS];
> +    /* Used to simulate retinal persistence of rows */
> +    uint8_t age_of_row[RGB_MATRIX_NUM_ROWS];

Maybe "row_persistence_delay"?

> +} DM163State;
> +
> +#endif /* HW_DISPLAY_DM163_H */


> +static void dm163_dck_gpio_handler(void *opaque, int line, int new_state)
> +{
> +    DM163State *s = DM163(opaque);

GPIO handlers are initialized in dm163_realize() where we know @dev
is already a DM163State:

   static void dm163_realize(DeviceState *dev, Error **errp)
   {
       DM163State *s = DM163(dev);
                       ^^^^^
       qdev_init_gpio_in(dev, dm163_rows_gpio_handler, 8);

So here (and other handlers) you can avoid the QOM cast macro,
and directly use:

       DM163State *s = opaque;

> +
> +    if (new_state && !s->dck) {
> +        /*
> +         * On raising dck, sample selbk to get the bank to use, and
> +         * sample sin for the bit to enter into the bank shift buffer.
> +         */
> +        uint64_t *sb =
> +            s->selbk ? s->bank1_shift_register : s->bank0_shift_register;
> +        /* Output the outgoing bit on sout */
> +        const bool sout = (s->selbk ? sb[2] & MAKE_64BIT_MASK(63, 1) :
> +                           sb[2] & MAKE_64BIT_MASK(15, 1)) != 0;
> +        qemu_set_irq(s->sout, sout);
> +        /* Enter sin into the shift buffer */
> +        sb[2] = (sb[2] << 1) | ((sb[1] >> 63) & 1);
> +        sb[1] = (sb[1] << 1) | ((sb[0] >> 63) & 1);
> +        sb[0] = (sb[0] << 1) | s->sin;
> +    }
> +
> +    s->dck = new_state;
> +    trace_dm163_dck(new_state);
> +}


> +static void dm163_en_b_gpio_handler(void *opaque, int line, int new_state)
> +{
> +    DM163State *s = DM163(opaque);
> +
> +    s->en_b = new_state;
> +    dm163_propagate_outputs(s);
> +    trace_dm163_en_b(new_state);
> +}
> +
> +static inline uint8_t dm163_bank0(const DM163State *s, uint8_t led)

No need to force the compiler to inline these methods.

> +{
> +    /*
> +     * Bank 1 uses 6 bits per led, so a value may be stored accross
> +     * two uint64_t entries.
> +     */
> +    const uint8_t low_bit = 6 * led;
> +    const uint8_t low_word = low_bit / 64;
> +    const uint8_t high_word = (low_bit + 5) / 64;
> +    const uint8_t low_shift = low_bit % 64;
> +
> +    if (low_word == high_word) {
> +        /* Simple case: the value belongs to one entry. */
> +        return (s->bank0_shift_register[low_word] &
> +                MAKE_64BIT_MASK(low_shift, 6)) >> low_shift;
> +    }
> +
> +    const uint8_t bits_in_low_word = 64 - low_shift;
> +    const uint8_t bits_in_high_word = 6 - bits_in_low_word;
> +    return ((s->bank0_shift_register[low_word] &
> +             MAKE_64BIT_MASK(low_shift, bits_in_low_word)) >>
> +            low_shift) |
> +           ((s->bank0_shift_register[high_word] &
> +             MAKE_64BIT_MASK(0, bits_in_high_word))
> +         << bits_in_low_word);
> +}
> +
> +static inline uint8_t dm163_bank1(const DM163State *s, uint8_t led)
> +{
> +    const uint64_t entry = s->bank1_shift_register[led / 8];
> +    const unsigned shift = 8 * (led % 8);
> +    return (entry & MAKE_64BIT_MASK(shift, 8)) >> shift;
> +}


> +static void dm163_realize(DeviceState *dev, Error **errp)
> +{
> +    DM163State *s = DM163(dev);
> +
> +    qdev_init_gpio_in(dev, dm163_rows_gpio_handler, 8);

s/8/RGB_MATRIX_NUM_ROWS/

> +    qdev_init_gpio_in(dev, dm163_sin_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_dck_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_rst_b_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_lat_b_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_selbk_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_en_b_gpio_handler, 1);
> +    qdev_init_gpio_out_named(dev, &s->sout, "sout", 1);
> +
> +    s->console = graphic_console_init(dev, 0, &dm163_ops, s);
> +    qemu_console_resize(s->console, RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE,
> +                        RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
> +}


> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 2336a0ca15..fc7cbdcd36 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events


> +# dm163.c
> +dm163_redraw(uint8_t redraw) "0x%02x"
> +dm163_dck(int new_state) "dck : %d"
> +dm163_en_b(int new_state) "en_b : %d"
> +dm163_rst_b(int new_state) "rst_b : %d"
> +dm163_lat_b(int new_state) "lat_b : %d"
> +dm163_sin(int new_state) "sin : %d"
> +dm163_selbk(int new_state) "selbk : %d"

unsigned new_state, "%u"

> +dm163_activated_rows(int new_state) "Activated rows : 0x%" PRIx32 ""
> +dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
> +dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> +dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> +dm163_refresh_rate(uint32_t rr) "refresh rate %d"

Minor comments, otherwise LGTM!

Regards,

Phil.

