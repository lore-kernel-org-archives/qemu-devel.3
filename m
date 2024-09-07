Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B0E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smoBT-0003qe-VO; Sat, 07 Sep 2024 01:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoBQ-0003mh-TK
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:40:30 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoBP-00021G-23
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:40:28 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a868b739cd9so366799966b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725687625; x=1726292425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0OuCxyszczRrq80gO832nF9eNuehHHXzctHFJxUhlI=;
 b=Le2T8hda77PH7BrPcnqsVZUGx6t/R2b03ZcvMS9xvsd+Nz+lTPohsCAGIT0s8ypEOH
 gPCPK6CyD0VEEwMB42QU5KBykAvFk9A2cuN1kKtnY+rfxOfgT1xsIi/ZbtnpV11Tavlx
 kGJx5+qS77Q8LSdmRfMltgxiuJ5iSENZBMCjNiPyJMbRPpnFMe0mkSQBjxGjvQgGbS+s
 B1aysF7i2JaHLpohWDgNPrfTYrr0hK6uXtNxs3mAKf4/H5JO+C0GaAueJ9YLPkw6RdeN
 2rWgguAqdLOlSrfVssCqcfxaEERPmCZCpIYZmttcjQyVFNBPZH31xWM1WtsW6qkweX2r
 LtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725687625; x=1726292425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0OuCxyszczRrq80gO832nF9eNuehHHXzctHFJxUhlI=;
 b=WFiRpUy1wwtypCEcgKDy/6IXD6DY0IaaTXdtIfOJvr2Ej24Kqcd1m0NxXdvs75lI6x
 bLMo8nI/42pm75MY0zSbg77jI8fkPmUehhVT0m18/SWoLf9Y0agVOhhxKrcmjtVHYIgS
 89ONDnzSnGAHI5iFvmJwIYAdQnbRrGt/d4Vg8TzTMAODcVP10Yofc1vWzi+YY6+ko2q9
 rhDkk5Tdkxc2Q2AtYxhVoBCNo488K0YufNcfY8p1iHrTq6M5uuh/zEqNwGRDf9MW/hd0
 2rJO0vk518gsDvdJzwxPfEfkZGbIZufDNTDFDEovB6tuktEhkES2pZ0xpIXRHNn7XIB1
 59KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURHzg2Dr36AdGzk5Rvq0+ORWUdk/JU/NyDsoPVOMSoLHwQcK1g14cY6yJjanj6AZXt0oN4t9ZEUMLz@nongnu.org
X-Gm-Message-State: AOJu0YwoQ52qdWY9VNsXtOhswo43KYgrzlHFKf8s+MM5utCpxCt5Kn2o
 mvJ0HpcUAAq/wvW4bmGZVLwbHvOPws+Ok+w+ryu8l2wRQlrF34kIB0HSAqM916I=
X-Google-Smtp-Source: AGHT+IGU2XkpfLokMkh7N5Uj4RW/KboqdOaJgebaT/AnIpySJd1o38jXbwqmq7rSwt9usnI1ZOBDrA==
X-Received: by 2002:a17:907:60c8:b0:a86:a41c:29b with SMTP id
 a640c23a62f3a-a8d1bf76062mr166718966b.8.1725687625067; 
 Fri, 06 Sep 2024 22:40:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c6126esm30212766b.120.2024.09.06.22.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:40:24 -0700 (PDT)
Message-ID: <5f68f72e-9449-4cf3-82df-47c912b2c0c3@linaro.org>
Date: Sat, 7 Sep 2024 07:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] adb-mouse: convert to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hsp.cat7@gmail.com
References: <20240904104007.177239-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240904104007.177239-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Mark,

On 4/9/24 12:40, Mark Cave-Ayland wrote:
> Update the ADB mouse implementation to use QemuInputHandler instead of the
> legacy qemu_add_mouse_event_handler() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index 144a0ccce7..7aa36caf2f 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -38,6 +38,7 @@ struct MouseState {
>       ADBDevice parent_obj;
>       /*< private >*/
>   
> +    QemuInputHandlerState *hs;
>       int buttons_state, last_buttons_state;
>       int dx, dy, dz;
>   };
> @@ -51,17 +52,52 @@ struct ADBMouseClass {
>       DeviceRealize parent_realize;
>   };
>   
> -static void adb_mouse_event(void *opaque,
> -                            int dx1, int dy1, int dz1, int buttons_state)
> +#define ADB_MOUSE_BUTTON_LEFT   0x01
> +#define ADB_MOUSE_BUTTON_RIGHT  0x02
> +
> +static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
> +                                   InputEvent *evt)
>   {
> -    MouseState *s = opaque;
> +    MouseState *s = (MouseState *)dev;
> +    InputMoveEvent *move;
> +    InputBtnEvent *btn;
> +    static const int bmap[INPUT_BUTTON__MAX] = {
> +        [INPUT_BUTTON_LEFT]   = ADB_MOUSE_BUTTON_LEFT,
> +        [INPUT_BUTTON_RIGHT]  = ADB_MOUSE_BUTTON_RIGHT,
> +    };
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_REL:
> +        move = evt->u.rel.data;
> +        if (move->axis == INPUT_AXIS_X) {
> +            s->dx += move->value;
> +        } else if (move->axis == INPUT_AXIS_Y) {
> +            s->dy += move->value;
> +        }
> +        break;
> +
> +    case INPUT_EVENT_KIND_BTN:
> +        btn = evt->u.btn.data;
> +        if (bmap[btn->button]) {
> +            if (btn->down) {
> +                s->buttons_state |= bmap[btn->button];
> +            } else {
> +                s->buttons_state &= ~bmap[btn->button];
> +            }
> +        }
> +        break;
>   
> -    s->dx += dx1;
> -    s->dy += dy1;
> -    s->dz += dz1;
> -    s->buttons_state = buttons_state;
> +    default:
> +        /* keep gcc happy */
> +        break;
> +    }
>   }
>   
> +static const QemuInputHandler adb_mouse_handler = {
> +    .name  = "QEMU ADB Mouse",
> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> +    .event = adb_mouse_handle_event,

Don't we need adb_mouse_handle_sync()?

> +};
>   
>   static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
>   {
> @@ -94,10 +130,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
>       dx &= 0x7f;
>       dy &= 0x7f;
>   
> -    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON)) {
> +    if (!(s->buttons_state & ADB_MOUSE_BUTTON_LEFT)) {
>           dy |= 0x80;
>       }
> -    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON)) {
> +    if (!(s->buttons_state & ADB_MOUSE_BUTTON_RIGHT)) {
>           dx |= 0x80;
>       }
>   
> @@ -236,7 +272,7 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
>   
>       amc->parent_realize(dev, errp);
>   
> -    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
> +    s->hs = qemu_input_handler_register((DeviceState *)s, &adb_mouse_handler);

Simply:

        s->hs = qemu_input_handler_register(dev, &adb_mouse_handler);

>   }
>   
>   static void adb_mouse_initfn(Object *obj)

Waiting for clarification on QemuInputHandler::sync, otherwise LGTM.

Regards,

Phil.

