Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5ECC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkDN-0005g5-3c; Tue, 30 Jan 2024 04:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUkD8-0005ZN-Uo
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:15:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUkD6-00032x-2M
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:15:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40ed3101ce3so50775745e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706606113; x=1707210913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XfLxFI71XIL2+DXs783wOnsq5mKcs7k1NE3Mgkhwb64=;
 b=OqdgQ1+uTGA20KvCz/5xHOwRatboVVoxpNdWpy7/I1LkVgABKLBkYFPi0458FNGsxB
 7TzbWAixuu/1maSmKNnsnm48kWiyJdvBy46jv95A6jmRwm6Ow+RudSP+4YernVlbqQnI
 mQfoqeWPPjMp4MG6jSUGLHhcmhBfqTrESqfHAvcYcKGeKosod8+j/obl4qEYHLD6/253
 g2rSNoO4N1ce0HG+riIQJVApeUvaFBAUXidzy06Rlb+7dD+4KbCfDViu3XMw+qjnzVH3
 aMNJZQPzFB0QZDORUy2cKpbiRP5mxM+Ri9vYd3f9NjCzC8lfkyLHV1fWurSdWn/0lkVq
 /vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706606113; x=1707210913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfLxFI71XIL2+DXs783wOnsq5mKcs7k1NE3Mgkhwb64=;
 b=sWbbd4iHY8iz67D5P4tZFiffWkdpdH/qGAeHl7jOTaKHH/qzbY5VD4T5LmMBGhEhtg
 TIYIkhtZZ13Wqg7YDBQ0el6aSD60fEXIqJ98P9eKHVtlK6kxd15CW4O0epflG6PmvgmB
 djov2xY4e9j6ZEV3beGO7g+TNk54ngsky3SChQVC+OBqRvHcxcQSE2h2aXaO7leZPF+k
 M6cGf25zGJfgGZJ3nZNm38ldozDLcRJyeVLskjqQzMWNQn2c0DmPpRam6ke+8aLU0cz6
 U9zrMhoKSapgC/rgJf7MmKOz8ZFi9x772K9gK5MmoKX3J9qB/dSmZ8mCuoGzIIhtdr/n
 WuiA==
X-Gm-Message-State: AOJu0YykLTiSJ9QyUsM45lDfhXF6bPAbKVu3LAK2KmyCdsLOuF8YjnWK
 mdfLOy7wcj7yZOj8RksJnQ0N3DbRbRozswaIte+ChhXXX6VwjAvGCKLj77wwrmg=
X-Google-Smtp-Source: AGHT+IGC/6N/3WghPptMWVuT4hGgCt69hXwHHV1fqkiLjZLsg0ybuMnX2OSZ30EFAgA3lhpXIF8ulA==
X-Received: by 2002:a05:600c:3c91:b0:40e:5e25:4099 with SMTP id
 bg17-20020a05600c3c9100b0040e5e254099mr7095730wmb.7.1706606113132; 
 Tue, 30 Jan 2024 01:15:13 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 gw7-20020a05600c850700b0040efc845cb6sm2449364wmb.7.2024.01.30.01.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 01:15:12 -0800 (PST)
Message-ID: <61f637bc-96da-48f6-8798-95426060deff@linaro.org>
Date: Tue, 30 Jan 2024 10:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] leon3: check cpu_id in the tiny bootloader
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-8-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-8-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/1/24 14:02, Clément Chigot wrote:
> Now that SMP is possible, the asr17 must be checked in the little boot code
> or the secondary CPU will reinitialize the Timer and the Uart.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/sparc/leon3.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index eacd85ee4f..87a8044a3e 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -100,13 +100,27 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
>   
>   /*
>    * When loading a kernel in RAM the machine is expected to be in a different
> - * state (eg: initialized by the bootloader). This little code reproduces
> - * this behavior.
> + * state (eg: initialized by the bootloader).  This little code reproduces
> + * this behavior.  Also this code can be executed by the secondary cpus as
> + * well since it looks at the %asr17 register before doing any
> + * initialization, it allows to use the same reset address for all the
> + * cpus.
>    */
>   static void write_bootloader(CPUSPARCState *env, uint8_t *base,
>                                hwaddr kernel_addr)
>   {
>       uint32_t *p = (uint32_t *) base;
> +    uint32_t *sec_cpu_branch_p = NULL;
> +
> +    /* If we are running on a secondary CPU, jump directly to the kernel.  */
> +
> +    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
> +    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> +    stl_p(p++, 0x80908000); /* tst  %g2            */
> +    /* Fill that later.  */

       /* Filled below. */

> +    sec_cpu_branch_p = p;
> +    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
> +    stl_p(p++, 0x01000000); /* nop */
>   
>       /* Initialize the UARTs                                        */
>       /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> @@ -120,6 +134,10 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
>       /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
>       p = gen_store_u32(p, 0x80000318, 3);
>   
> +    /* Now, the relative branch above can be computed.  */
> +    stl_p(sec_cpu_branch_p, 0x12800000
> +          + (p - sec_cpu_branch_p));
> +
>       /* JUMP to the entry point                                     */
>       stl_p(p++, 0x82100000); /* mov %g0, %g1 */
>       stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));

Alternatively have main_cpu_reset / secondary_cpu_reset handlers.
You could split BL in HWINIT / JUMP, have HWINIT() return # instr
used and adjust secondary_cpu_reset entry.

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

