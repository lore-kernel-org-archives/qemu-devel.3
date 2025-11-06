Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F2CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH217-0000IU-Nk; Thu, 06 Nov 2025 10:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH215-0000Ho-Jw
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:35:15 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH213-0002ND-Bq
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:35:15 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so1478472d50.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762443312; x=1763048112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5AK2aKciqy3kVqhJTGYTxKPvrDhyGUIMBQdaapbIEHw=;
 b=Aa83KQvcJy/qZl9eUN4rs+YuH++KY8D4ObjqK9ctPBYk63E3R8dSXYf/n0Ae+f4uSX
 U/a9sukZgPk2Af+AOyfFEeMVn9i014V/eA7KrhF3PBZaUBz9GfISAtJBdhFKfsXy//gq
 WOyPOnFGYyqdQNar8QX9dXFtcANRa1iYin99xsANHg1oe9xN5oa8n3doAw14W7NAG2LK
 TlkR2QX3MJKwCjWl8UHsDiJVPnBSMOMWvp0m9tDW5NOyZ369R5zrp0qpqNrIpVa88Zhi
 pqORD4ybSTL822xMsUKQcdnVDM4D2aJuLcBhC2JZ+Gl7iGPvWGiWmJLR9OqqqI7EHlUR
 S6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443312; x=1763048112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AK2aKciqy3kVqhJTGYTxKPvrDhyGUIMBQdaapbIEHw=;
 b=ZLdAnhaROPrX4IZqqtZc1cens2W/Jf+Er6/ltDiGvD4BKDc0S+lpuosrtuSaIEDMrz
 0XnBLq/uSSOQ2i9Gt/EEPSH3wV/LAn5j/EkD/2Fhp8UMyn2chJ+qDNnTmfWYO3QADRX6
 Kpt7zS6ZSydYuishljhgT6nRN90h3CuNAI/XEdCSdByiQI+vimLufrzs4ekzHy3SCHRS
 LiEQJnr0PIfYHufdgCZ1tZwyQRhdDdc5HFiqhUHkuEIEWQzmkcCViTMCnxOI7OaTSQBh
 tPXNz5aVe9ucnZVTCv96HJozcyrkyRggFhmrvaNub79wrj42xEBE39vSNXkYAFkQv9hN
 RbMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUObp5BwxwZHZTPnQNBihO3Ewu4/VC3OI7OTndSTvij3hde8shnUF+B61GvkdslnO4mdcZlCKB4GNxF@nongnu.org
X-Gm-Message-State: AOJu0YxwUHFwJv/35nO5Pyb2RoRvoKBLqJxqYQs/ZklGvh2KDEA+LZp8
 O5n7pE9m9ixraywWvGYV8flv34t2ZR1l6GNjY+g8x6xFXCO1YAMY/pQ6qLfcgiWVtOOwlPUEoko
 nAgi7qqTHgWPZs+rM2yT7SHphfHwuV+ZUhVpClnZaAg==
X-Gm-Gg: ASbGnctNSG8r+dQq5GGYUzETjgD0D64qoKdz0i1mEeGxVQ7OI8H6C57xchO4N+Z86mt
 wmH5AUBsZyT7ksqGRe3RkfuE3tyChqjOvUZvyn6pMcucvj3rzSno9UTg1DLClT274H8tkuQ4qO7
 hd1R56TTf40Al8QRXWu+ec/Ei39La+pXKMR4m6K91JDrX6npz3sIotXrVcOc1YDYFfztgpIWJPs
 w+kKYn1KkPT8ut75XrihU/fe9yzMRXKI4FC37u0UWgu0bp4tp68vdwWmAKSSA==
X-Google-Smtp-Source: AGHT+IHN+auJax1uWfWAEw27+ddpWWeTVGsXEup7OP+cBs+oSdCpr/ex3vYyZOQxTfR0NzIdE/Smllz7EDaovm1j6JE=
X-Received: by 2002:a05:690e:1249:b0:63f:9b56:f5c8 with SMTP id
 956f58d0204a3-640b53db765mr3125025d50.2.1762443311706; Thu, 06 Nov 2025
 07:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20210108190945.949196-1-wuhaotsh@google.com>
 <20210108190945.949196-4-wuhaotsh@google.com>
In-Reply-To: <20210108190945.949196-4-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 15:35:00 +0000
X-Gm-Features: AWmQ_bnfugMgacnS3jYrPAcHTkA3HnMsP5PQdl4c_wvcnVYTbhlD_vl2ER3Lfi4
Message-ID: <CAFEAcA93eSO8sQf7gXGTQsjjuKf6HfQfF4JJpUk=A3dWYSgYZw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] hw/adc: Add an ADC module for NPCM7XX
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, minyard@acm.org, hskinnemoen@google.com, 
 venture@google.com, f4bug@amsat.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 8 Jan 2021 at 19:10, Hao Wu <wuhaotsh@google.com> wrote:
>
> The ADC is part of NPCM7XX Module. Its behavior is controled by the
> ADC_CON register. It converts one of the eight analog inputs into a
> digital input and stores it in the ADC_DATA register when enabled.
>
> Users can alter input value by using qom-set QMP command.
>
> Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>

Hi; I was looking at a division-by-zero bug in the
NPCM7xx ADC device which was reported ages ago and
is still present:

https://gitlab.com/qemu-project/qemu/-/issues/550

The problem is that the guest requests an ADC conversion
using the "vref" reference, but vref is zero.

Could a Nuvoton-aware person say what is supposed to happen
here ?

> +static uint32_t npcm7xx_adc_convert(uint32_t input, uint32_t ref)
> +{
> +    uint32_t result;
> +
> +    result = input * (NPCM7XX_ADC_MAX_RESULT + 1) / ref;

In this function we divide by ref...

> +    if (result > NPCM7XX_ADC_MAX_RESULT) {
> +        result = NPCM7XX_ADC_MAX_RESULT;
> +    }
> +
> +    return result;
> +}

> +static void npcm7xx_adc_convert_done(void *opaque)
> +{
> +    NPCM7xxADCState *s = opaque;
> +    uint32_t input = NPCM7XX_ADC_CON_MUX(s->con);
> +    uint32_t ref = (s->con & NPCM7XX_ADC_CON_REFSEL)
> +        ? s->iref : s->vref;

...which we set to either s->iref or s->vref, depending
on whether the guest set the REFSEL bit in the register
or not...

> +
> +    if (input >= NPCM7XX_ADC_NUM_INPUTS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid input: %u\n",
> +                      __func__, input);
> +        return;
> +    }
> +    s->data = npcm7xx_adc_convert(s->adci[input], ref);
> +    if (s->con & NPCM7XX_ADC_CON_INT_EN) {
> +        s->con |= NPCM7XX_ADC_CON_INT;
> +        qemu_irq_raise(s->irq);
> +    }
> +    s->con &= ~NPCM7XX_ADC_CON_CONV;
> +}

> +static void npcm7xx_adc_init(Object *obj)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    int i;
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    timer_init_ns(&s->conv_timer, QEMU_CLOCK_VIRTUAL,
> +            npcm7xx_adc_convert_done, s);
> +    memory_region_init_io(&s->iomem, obj, &npcm7xx_adc_ops, s,
> +                          TYPE_NPCM7XX_ADC, 4 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL);
> +
> +    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
> +        object_property_add_uint32_ptr(obj, "adci[*]",
> +                &s->adci[i], OBJ_PROP_FLAG_WRITE);
> +    }
> +    object_property_add_uint32_ptr(obj, "vref",
> +            &s->vref, OBJ_PROP_FLAG_WRITE);

...but we don't do anything here to arrange for the "vref"
property to have a default value. The board doesn't set
"vref" on the device, so it is zero, and if the guest
tries to do a conversion with the vref clock QEMU crashes.

> +static Property npcm7xx_timer_properties[] = {
> +    DEFINE_PROP_UINT32("iref", NPCM7xxADCState, iref, NPCM7XX_ADC_DEFAULT_IREF),

Here we set a default value for "iref", so that doesn't
have the same problem.

> +    DEFINE_PROP_END_OF_LIST(),
> +};

We should also define a realize method so that we can
sanity check the iref and vref property values (notably
not allowing them to be set to zero, but also any other
sanitization that makes sense for the hardware.)

thanks
-- PMM

