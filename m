Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A6C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvevD-0000zr-CD; Fri, 21 Mar 2025 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tveuk-0000xJ-Ka
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:08:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tveui-0002H4-Rz
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:08:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a823036so21413015e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742573283; x=1743178083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N4znD/2cgzpsyWYKOZAh0DeRQSLpcc/yxZECrB6w5pw=;
 b=vmqpXSH8++QBCc3Ie/4BjremYnF1C9+WX9KPbim4vj6PQ3xo+HRQGshu4UFVJp05TY
 mflX91Ov7rlTB0xsy4mN3LygoMjRDuzoYq2CDHh0aHlXnfuJtnHriMj3e9EYe1v/dVYe
 2/NNCOyPru+3A8YQamKQy29oq+m6ER9qWqk3xDkt0nbwaVUNiLokgcEl/A3VBJrGBNhF
 nq+gTB0oJaDUWiAUaZL4dykUkuZK7RDqlmm9rni4zvVgnYlXDOtMc6s2SCwlynfA4tdL
 /n2AjQ4U19Xvajb79EsCF+IkigoljYhVPyg/+yCZQgTAX8GGXuQGxf2030kg6bpzo9x5
 tiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742573283; x=1743178083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4znD/2cgzpsyWYKOZAh0DeRQSLpcc/yxZECrB6w5pw=;
 b=OmFKNIJQy4B1VpQj/F4sdnx5wQ68Pv7pCqPfGiNOU+4nemf5neiaDv8Fiw1n5IiFhK
 qI0ZxyJdLccoToZouPs69TYu5LEh189dxQ3TD4Ro7C8L0cJK/p7IGLxKHRHyLs+w16mo
 0EHlUIvAC/yr9dBi1AO9P4QXgLHSnshHRexhBMbSclREVgc45WHkeUY87IwCOWnwT/1H
 cpfRCSW4+8lLsXmpFNDrSYfE9xiJkS42h+xpBk+MQQCFZuDW40ua7ZR+19HHowmpFP46
 QAdaQkwvqjYgVnT/UCda/QZh5sxYwFrQ51DhqTmO83B3ex+Ts4BVOTO9uA0+mZei7vvA
 OIhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNe4YrHWe0p3KE0bEG7KLMw+FK4l/mlByExkYxIHr0dOuNfZHDNGJcuBm+Hbhnm5PWkW9mK8TXE+8Z@nongnu.org
X-Gm-Message-State: AOJu0Yy4aCAC97j3cpK0qVlRmqNX74SDjYaOwDaASydF+9OCaSqKIlY8
 aUAoLtHhI75PRARpH0iYFyy65fXa8yavQc4L8VQrPpEeC4mRRCMMNtG7XQPzXAk=
X-Gm-Gg: ASbGncuqNqUtZzY3h2RWiiNgm9HAJHv+Mr2XdKSZEVzF1hsVb9oP/9y3g5Dw2K8VW6/
 jlxriv8KX4wD5bqY9P40oRqB4f4b/lsnfbJRoo4TrFpAGRnt/Eox+9h7uU8twkE3Jf1yB4oOPHD
 gvAAkNjt8tqBz3Zwt9G3EAxHktto1FknUO+bbzt0Q4Uc9/ntu1lihdY37x8pd6nIdjRLyG84qT+
 /u10MiVIcBbeKDHm+h+dy5VIF3Voi3h+qNco5Swy4GXXy+7BeJSI8beobJJeC4HduA+1x9SvkqT
 jHC8BsjNp8mUWuW0Yps8YxrLQJsZL1EwlCHhDorSg7Is+PvUylXs92dYgNWdxAr/Pb/ebbWOZrh
 xTNWYXJSR5EVZ
X-Google-Smtp-Source: AGHT+IG4eInY0S+J4iOFL57SFmN3IB8bxJdISB4JxKTz54TnuxkbMZkk13MerVL6nLOSEXb2U6jdUw==
X-Received: by 2002:a05:600c:4ec7:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43d50a35fb0mr27158065e9.26.1742573282993; 
 Fri, 21 Mar 2025 09:08:02 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdb0669sm30398685e9.34.2025.03.21.09.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:08:02 -0700 (PDT)
Message-ID: <5dd32cd5-ff51-4d28-bbaa-3153493dec39@linaro.org>
Date: Fri, 21 Mar 2025 17:08:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/1] goldfish_rtc: keep time offset when resetting
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anup Patel <anup.patel@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Heinrich,

On 21/3/25 09:12, Heinrich Schuchardt wrote:
> Currently resetting leads to resynchronizing the Goldfish RTC with the
> system clock of the host. In real hardware an RTC reset would not change
> the wall time. Other RTCs like pl031 do not show this behavior.
> 
> Move the synchronization of the RTC with the system clock to the instance
> realization.
> 

Cc: qemu-stable@nongnu.org
Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")

> Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   hw/rtc/goldfish_rtc.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 0f1b53e0e4..203a343511 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -239,15 +239,8 @@ static const VMStateDescription goldfish_rtc_vmstate = {
>   static void goldfish_rtc_reset(DeviceState *dev)
>   {
>       GoldfishRTCState *s = GOLDFISH_RTC(dev);
> -    struct tm tm;
>   
>       timer_del(s->timer);
> -
> -    qemu_get_timedate(&tm, 0);
> -    s->tick_offset = mktimegm(&tm);
> -    s->tick_offset *= NANOSECONDS_PER_SECOND;
> -    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
> -    s->tick_offset_vmstate = 0;
>       s->alarm_next = 0;
>       s->alarm_running = 0;
>       s->irq_pending = 0;
> @@ -258,6 +251,7 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
>   {
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       GoldfishRTCState *s = GOLDFISH_RTC(d);
> +    struct tm tm;
>   
>       memory_region_init_io(&s->iomem, OBJECT(s),
>                             &goldfish_rtc_ops[s->big_endian], s,
> @@ -267,6 +261,12 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
>       sysbus_init_irq(dev, &s->irq);
>   
>       s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> +
> +    qemu_get_timedate(&tm, 0);
> +    s->tick_offset = mktimegm(&tm);
> +    s->tick_offset *= NANOSECONDS_PER_SECOND;
> +    s->tick_offset -= qemu_clock_get_ns(rtc_clock);

OK

> +    s->tick_offset_vmstate = 0;

This last line is pointless. Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }


