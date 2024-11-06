Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C404FD3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cbI-00014y-Hb; Wed, 06 Nov 2024 04:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8cbG-00014a-W8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:45:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8cbE-0006DI-OI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:45:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d8901cb98so381506f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730886315; x=1731491115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zL8xxK66LPjkfbtu/EPTey05wunZPR6N2FUGKrsGI38=;
 b=BQHfC8jsmvA4YQGIiREB6WP77IldTL9sfGWb42+JKZ8EX0M+WwhArCZguYR/+ZG3+R
 h0eW3vjJnKCUFj22uJQiHMyPYZFrAS39At6I95VnFWzgveyBheNb+jRaaozaOe3DxfJe
 J7q5ZMdblMtQxyBrN8HZNOCtuJwddBN6IEEArY9FmMNlHHkUDr07me8tKM9//y20BTQP
 XKDJiRRrn5jtl+lIn+RDbI9TIqh5Pa0F9KquyErFJwbnD6Wsd2LBa8Ay4qjTucRsA2jl
 21dA5oW1RfxbjIh7t/qNXSQNZpw4tFSSbwrT9ppHqvPa0vrxYrLfjJmtslCpXqY2YAOK
 KV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730886315; x=1731491115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zL8xxK66LPjkfbtu/EPTey05wunZPR6N2FUGKrsGI38=;
 b=Rqz7HuaVwPBPBTT3+EfgO2l5o7J9ww/BLKczy9G86KHsvC/gF6DdaYYnEQihxzAP4/
 VPhCpEH6g6gdS4bY34oFEbibXIRA55JGBjKXrGEsG85Fyj/kTPkDpoZBIQ5X/tsWlKWt
 JRSIQWmEirUXD0+52ANuKHWfO3zQsMrwBfZWXatVwAOTO2zDTlLPJITyq6RXEk6XOWj9
 EU+ss89NpFJk895YniDZtiC8FuGL7upBTKeyQViMq6PTheHYobedJRlNqliA8TCy9Ra2
 emkE/HQwBd3T2xf0desDfZ7SKaPQEov/uC2nctS6z6j9HfKkG/zh7V0jEXmNXpTF7G24
 0ybg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxY2gDUS4dglmUXxydt/lpXo+vhFQNEC3mHag+Z88pj2pDT1q5rB6N8J6J15DUVJRuvlDLxOY9GB9z@nongnu.org
X-Gm-Message-State: AOJu0YxN6cKde4Z0OjptuLIf8c2n6CneFgmP3/kbiKRusZORQgeeGE9L
 a8N1FGYC3T0x/Sase/FQth1TiTIyPTGeV3ss/6jtvmy/xwiFPTyP+MfTFUYqiiQ=
X-Google-Smtp-Source: AGHT+IFxOFZX5gf6cQ7l7amNXaLw7lPR7R9G+TlfyM3KbCRbVg0eKvePdHCHo8scoozmKPr4UkeAzQ==
X-Received: by 2002:a05:6000:1f8e:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-381e81cf113mr1429228f8f.16.1730886314930; 
 Wed, 06 Nov 2024 01:45:14 -0800 (PST)
Received: from [172.16.23.118] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5b2dsm15842105e9.1.2024.11.06.01.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 01:45:14 -0800 (PST)
Message-ID: <83926eb8-c5d7-4edf-b180-cc20c95a4c04@linaro.org>
Date: Wed, 6 Nov 2024 09:45:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/openpic: Avoid taking address of out-of-bounds
 array index
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20241105180205.3074071-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105180205.3074071-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/5/24 18:02, Peter Maydell wrote:
> The clang sanitizer complains about the code in the EOI handling
> of openpic_cpu_write_internal():
> 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
> ../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in
> 
> This is because we do
>    src = &opp->src[n_IRQ];$
> when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
> is -1 then we don't do anything with the src pointer, but it is
> undefined behaviour. (This has been present since this device
> was first added to QEMU.)
> 
> Rearrange the code so we only do the array index when n_IRQ is not -1.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Arguable whether it's worth the stable backport or not...
> ---
>   hw/intc/openpic.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index cd3d87768e0..2ead4b9ba00 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1031,13 +1031,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
>           s_IRQ = IRQ_get_next(opp, &dst->servicing);
>           /* Check queued interrupts. */
>           n_IRQ = IRQ_get_next(opp, &dst->raised);
> -        src = &opp->src[n_IRQ];
> -        if (n_IRQ != -1 &&
> -            (s_IRQ == -1 ||
> -             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
> -            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> -                    idx, n_IRQ);
> -            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> +        if (n_IRQ != -1) {
> +            src = &opp->src[n_IRQ];

Could move the variable declaration here.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> +            if (s_IRQ == -1 ||
> +                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
> +                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> +                        idx, n_IRQ);
> +                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> +            }
>           }
>           break;
>       default:


