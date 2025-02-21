Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5367C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQVS-00038R-53; Fri, 21 Feb 2025 05:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQVQ-00038C-OP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:43:40 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQVO-0001sW-R0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:43:40 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso1607012f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740134617; x=1740739417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=01pMw8ez7/NXsPmWGiRyXPFrKsVXvjvuJt653hiR9oQ=;
 b=JvutcCqnKoqQsHSOgGwaM5oKVEVJ+SUAJuofYX1AeDuWobWjNyM9snqFwRGnrtgTmC
 +YSDAU4CH1I6J6CW6/2OU+rTXcqhkN+lNpHWWUSQdvLPdmNBSRs95dlllLSo9mYkJfVv
 XHXV/7Y3Xkpc+4mVcztywfgyOrgfUyNaG3K33v1e8WGhYwCF8KKWByBRLFzMbPhfdkGB
 AGdzdv3Ah30vYReNeAEzKUTK7ose33GkY8jZCdrGhjcIP8s4FUbE8UJomg+T0lnYTu4D
 C5SWYwdm/2E2YIXoUNFzyM7PyTBN4nojSmrasfeC8/lzfAVXvoARVCU24y4buJ/ZpO3W
 u7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740134617; x=1740739417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=01pMw8ez7/NXsPmWGiRyXPFrKsVXvjvuJt653hiR9oQ=;
 b=QsjmKMoZv3HaZbgJCCpdVH7MH0Y1eAgb1OeBU9PHTnU4ubJruMxHxIUFUp/yZffa+R
 f7q8l2odqhmi3e0HduGzBmO4mwOAD/nusfxzreIoZzfqywxYVMvMHf/Kn2EuilTvV53D
 Tdy/Mx+fMm12GL7cv37uMxYX7S/n9PciV+zOgPezpaNJsiI6pnF/GSmxr87iEPm80VOt
 qi/psI0u3FBOCSPyGiVYzxJz3ctfufis9ksGsGrs4vzVduhUsBY+2Fsx1UMBBRZFNWfB
 uTiQJH8KrJGreHySDTlkXup67r2zwWuV5TVkVi+P/FanHFVzFbCFKQfD8EpR/lKXM0eN
 ngtA==
X-Gm-Message-State: AOJu0YyXVFhEgFqT92NGpf8OBB/15jQU6jWbXTzP/J/Lr8H7H5mnW+Ah
 4OGzonFr4nsWkJSnApjJ4UfwSz9rN202YZwBn0yxOaDVMZmndh62decSSoA92nc=
X-Gm-Gg: ASbGncsqKuEbrEwn0uYsL4wD+uFvV33k6dXPot7g5St2hpQTCGiJQIS9DYQyHat06ec
 yCQG3kKakXDeLZAJmWNIKnCXApIli3T4EdhySRnScOS07pKfbzJQ2gDi6n7in31TPjZBt0cawdo
 zoe4EK7mqNwlrxaueS85GeqWlMjpDd3XIJl42wpdpSvZKVYLuDE2B2sM4pswodFdpv5Td7aUGmL
 l+1nuNQA/O3Uct/DMkxWOC2OSzVvyW062ZOcepa8k5nVaIk3Ek7IjVpXKdQ5ChmOG3FDOGhiC7Q
 fIJC/stCGP1XTeEF5QGAXEWzK/3BVpIjcghsDw2sZtzTjpGWo1Zddf/M7wOmS8ivIvuZMQ==
X-Google-Smtp-Source: AGHT+IFn0y3NVMbcJvhMVNlzV0An/H4xPk66AK0UwdP3vVZmBgkHe4ZVLlhmFmZ04PRpJER0PEvI7A==
X-Received: by 2002:a5d:6daa:0:b0:38f:3791:c1df with SMTP id
 ffacd0b85a97d-38f6e95bd45mr2546165f8f.15.1740134616932; 
 Fri, 21 Feb 2025 02:43:36 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fabsm22765614f8f.45.2025.02.21.02.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:43:36 -0800 (PST)
Message-ID: <925aedb5-6cb5-47eb-980f-d72841f6fa86@linaro.org>
Date: Fri, 21 Feb 2025 11:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/rtc: Add RTC PCF8563 module
To: Ilya Chichkov <i.chichkov@yadro.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250221073444.15257-1-i.chichkov@yadro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250221073444.15257-1-i.chichkov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Ilya,

On 21/2/25 08:34, Ilya Chichkov wrote:
> Add PCF8563 a real-time clock with calendar and I2C interface.
> This commit adds support for interfacing with it and implements
> functionality of setting timer, alarm, reading and writing time.
> 
> Datasheet: https://www.micros.com.pl/mediaserver/UZPCF8563ts5_0001.pdf
> 
> Signed-off-by: Ilya Chichkov <i.chichkov@yadro.com>
> ---
>   hw/rtc/Kconfig       |   5 +
>   hw/rtc/meson.build   |   1 +
>   hw/rtc/pcf8563_rtc.c | 638 +++++++++++++++++++++++++++++++++++++++++++
>   hw/rtc/trace-events  |  11 +
>   4 files changed, 655 insertions(+)
>   create mode 100644 hw/rtc/pcf8563_rtc.c


> +static void pcf8563_realize(DeviceState *dev, Error **errp)
> +{
> +    I2CSlave *i2c = I2C_SLAVE(dev);
> +    Pcf8563State *s = PCF8563(i2c);
> +
> +    s->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &alarm_timer_cb, s);
> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &timer_cb, s);
> +    s->irq_gen_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &irq_gen_timer_cb, s);
> +
> +    pcf8563_reset(i2c);

Calling pcf8563_reset() here, the device will only be reset once
(cold reset), not when a guest VM resets (hot reset).

See below to register a reset handler called when guest resets.

> +}


> +static void pcf8563_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);

        ResettableClass *rc = RESETTABLE_CLASS(klass);

> +
> +    k->event = pcf8563_event;
> +    k->recv = pcf8563_rx;
> +    k->send = pcf8563_tx;
> +    dc->realize = pcf8563_realize;
> +    dc->vmsd = &vmstate_pcf8563;

        rc->phases.hold = pcf8563_reset_hold;

> +
> +    trace_pcf8563_rtc_init();

This trace event is wrong, this isn't the device init but the
registration of its model.

> +}

Your device is missing testing coverage. Our QTest framework seems
well adapted for it.

You can use some examples as template:

$ git grep -l i2c tests/qtest/*.c
tests/qtest/adm1266-test.c
tests/qtest/adm1272-test.c
tests/qtest/bcm2835-i2c-test.c
tests/qtest/ds1338-test.c
tests/qtest/emc141x-test.c
tests/qtest/isl_pmbus_vr-test.c
tests/qtest/lsm303dlhc-mag-test.c
tests/qtest/max34451-test.c
tests/qtest/microbit-test.c
tests/qtest/npcm7xx_smbus-test.c
tests/qtest/pca9552-test.c
tests/qtest/pnv-host-i2c-test.c
tests/qtest/qtest_aspeed.c
tests/qtest/tmp105-test.c
tests/qtest/tpm-tis-i2c-test.c

Regards,

Phil.

