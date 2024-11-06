Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C829D59F43
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iIi-00011c-7N; Wed, 06 Nov 2024 10:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8iIf-00011E-J3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:50:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8iId-0007uW-UL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:50:29 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so6109457f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 07:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730908226; x=1731513026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LE3DkbD9zEPwveE+Pb/ACWBTZKbszhJIK1kaZIyHv4I=;
 b=He7DUHT22+HaAL+JUXfk0sTFScj/ugLEttJh7k2Zvli433YAY3F7rE//ab5HqU2ruT
 SJN2P5iXBnrP6x4Yhe/N2REwsary6MWNXPJZQKimQ7UVSIMryvWxfTR6ram+cwi3dvr0
 xhQ95y98p7T6he5XLNbkukIpKBir0ZtAOQNjAD2ATxIfgqod3VEWdcuR556zHr25tWEz
 uOMOaSS99hqNi38OUluQ7TJqwRqTQ5nBF4bq5HpXt72AUXcGK9wicWKcjWf820gUJ8F7
 6pXKKx9do5HPxRJ2q1K3QV6A5lgiTO477GYkpUG2xKpQNzmtyHxo27yVHTBWBfXhld6F
 WC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730908226; x=1731513026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LE3DkbD9zEPwveE+Pb/ACWBTZKbszhJIK1kaZIyHv4I=;
 b=gd8PWh6PpHQEwTNecgbhcF9OjL2FBZHP7I+/t8zhjFCfYcF4D+chtkr7+dqc2Z0MUj
 Yy2nwUinw/bJ971MkG42V1S6NABxMOFgLub8UG/foN0I2gFbXhDI0CJogVZweWIA507g
 Okh42Nu2Lmc/w5G21CWf3VuEeR+9Hj+KfTXVHXF6wAKqnI14kGoXpdWSDX3QwE5SwuIh
 rPPc3mwcLRve6UlPa/4P9dr0ILTPPQJ3YY71rKT+procVqXl1uJk5fB32Te+7p7lID8C
 6/8dfhmvdFwinpuwvzqDBG65TbRULelX+NNzPHdD5yTx1N/bnlfnJFIW4gKBFvT+R0gU
 WDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbZtlSxIRU0DaDvJ2tsUg2dLAycH1P8coIHRvbKTTb1nqjlbiFBv3pRjrqva9wzT5ATzhtN2f/01qR@nongnu.org
X-Gm-Message-State: AOJu0Yz0oewGxfTOtUlqKN42ITB05NgOaaCQGlEIXXzcDg1Zzmc+qdH5
 t0xJ0ThIPUlphyS7l7IA30l6DoNbUf0RKsMaBMqo4cfla3AAj0wP0wNnLex4Ap4=
X-Google-Smtp-Source: AGHT+IHpeJVB5WjnPvOu6ZsWhrf/0GBaSjNRHAlaxwieftS4IIgf1h13xVncGciO4+746aX+SkrrPA==
X-Received: by 2002:adf:e199:0:b0:37d:4eeb:7370 with SMTP id
 ffacd0b85a97d-381c7ae14bdmr21032485f8f.56.1730908226024; 
 Wed, 06 Nov 2024 07:50:26 -0800 (PST)
Received: from [172.16.26.160] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116a7a6sm19485692f8f.92.2024.11.06.07.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 07:50:25 -0800 (PST)
Message-ID: <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
Date: Wed, 6 Nov 2024 15:50:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
 qemu_input_handler_register()
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/11/24 13:00, BALATON Zoltan wrote:
> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>> Convert the next-kbd device from the legacy UI 
>> qemu_add_kbd_event_handler()
>> function to use qemu_input_handler_register().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>> hw/m68k/next-kbd.c | 163 ++++++++++++++++++++++++++++++---------------
>> 1 file changed, 108 insertions(+), 55 deletions(-)


>> -static const unsigned char next_keycodes[128] = {
>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>> +#define NEXTKBD_NO_KEY 0xff
> 
> Now you don't need this 0xff define any more because you can use 0 as no 
> key value then the [0 ... Q_KEY_CODE__MAX] init below can also be 
> dropped because static variables are 0 init automatically.

Whether 0 or 0xff is best for NO_KEY, I don't know.
However, definitions are useful when reviewing ...

> 
> Regards,
> BALATON Zoltan
> 
>> +static const int qcode_to_nextkbd_keycode[] = {
>> +    /* Make sure future additions are automatically set to 
>> NEXTKBD_NO_KEY */
>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>> +
>> +    [Q_KEY_CODE_ESC]           = 0x49,
>> +    [Q_KEY_CODE_1]             = 0x4a,
>> +    [Q_KEY_CODE_2]             = 0x4b,
>> +    [Q_KEY_CODE_3]             = 0x4c,
>> +    [Q_KEY_CODE_4]             = 0x4d,
[...]

>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, 
>> InputEvent *evt)
>> +{
>> +    NextKBDState *s = NEXTKBD(dev);
>> +    int qcode, keycode;
>> +    bool key_down = evt->u.key.data->down;
>> +
>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>> +        return;
>> +    }
>> +
>> +    /* Shift key currently has no keycode, so handle separately */
>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>> +        if (key_down) {
>> +            s->shift |= KD_LSHIFT;
>> +        } else {
>> +            s->shift &= ~KD_LSHIFT;
>> +        }
>> +    }
>> +
>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>> +        if (key_down) {
>> +            s->shift |= KD_RSHIFT;
>> +        } else {
>> +            s->shift &= ~KD_RSHIFT;
>> +        }
>> +    }
>> +
>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>> +    if (keycode == NEXTKBD_NO_KEY) {

... here ^

>> +        return;
>> +    }
>> +
>> +    /* If key release event, create keyboard break code */
>> +    if (!key_down) {
>> +        keycode |= 0x80;
>> +    }
>> +
>> +    nextkbd_put_keycode(s, keycode);
>> +}


