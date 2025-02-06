Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42732C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfy34-0003ER-2m; Thu, 06 Feb 2025 04:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy31-0003Dw-L4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:19:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy2y-00020n-V0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:19:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso4064915e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738833582; x=1739438382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWktGDjfm4x3Q8DrddUd9S9UWefotKFj6PcowIixsJE=;
 b=f/4gGFJ+6Mi2IDIR/6Cek/hNBwqJw0YM3f9IQuSMDThSQSrtwKV0ZQdH6oAcE784SG
 Qpzp9DRGDKW1/QoOnt29mXQrb2q7RYyAMz+OMCpspsVJeTQ6AJvh2yvQ42zfo8cQF1JX
 iyclTGSECrPOYDi2lSmOP9U3hSdWdZYZ/zXhM8gMCsgc9p1UvPCJ4zILr6inTDhjB1y0
 +tKn2i+5BATYYKj8oI16Fvg8vZFpmesLJNBjj35W9WaSofrFgOknSMokGWK2J/M2cFvW
 DO0HGxGck87DjhMAI6z8h2bogT4nwcoCsFwmi6C4z0lJEbn0ZgFk4fGNxlA7giIjiuw7
 3/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738833582; x=1739438382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWktGDjfm4x3Q8DrddUd9S9UWefotKFj6PcowIixsJE=;
 b=e/bFUON5PpEVJvZgiPyAilu+AZTTfChxkyX14mnmZMQh2Gxzrn9mYfgtF0b5J4IOGS
 LbWCwFLzQg7wj0bKXvq4jY4uMoRjaFuZu5yycdYlVudFNdH6kyPJa6YojUjnSdxng0+X
 XFJOuSMES1dPvYFw8vxGMk9G03+xS2Y3mBL1oztM/feavsZ9qNxrPb53sPPlWGIq3YAU
 /pthpegaRa872cm+VQg65MaC39/9gYiTVqNuSe2xxrldZx/hdY9d968r2RWO5O+Q53fj
 agX3I86oVaHkEvOSTxMp3r1fyURnV/FaxmP9qPRveouYL75q/4whjnKTSpAcgLst1y5o
 nUVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlAKnncWbgMZBalq2icweiv73DJiPttQQmFjHvzFCEZenfr/E4OTj3kLi3+5+ivC/qCalUBisYl46s@nongnu.org
X-Gm-Message-State: AOJu0YzfOQoZc3W9vkv1lT1a0bzmXv3EZFTNI74uhnwNM7NTxpi7j5jI
 6BAAbRvm3PjYWy8/K44vBAezOnPlsjbqogHDnYZeZRUAODXoItjJZw6GVx1PhaU=
X-Gm-Gg: ASbGnctzJ9M+aCGexCSdzInUpFjE2Xn33guFXu7af5Y1rahcFPzcHpyBGwlSKkL9kbq
 5aiGE9tohNGQl2Jc7qaU8edqv68i7gLq5elLsl5n90Hnr+opXIMRe/XYQxEC/8vSlsC4KZK5Ywj
 Nyx1Np/tqa1XZBJavqyHptF/cLJ4PlJxhM7nc68lKhT/tw/mmswYbuxlzCkkiEPG7uBOJZCBvKQ
 GEK/gAHWNss8lGH9E6ChegtnFGFM1wTRv++k7h6lS/oWQxvUR9hmJ41ssSdtW/oYgFvCZAkFjw9
 eVG7LzHJZsEzi8z900SjDRMxa5GbM61lHWO8gq1EuAvQYWxaKnHJ2sPReqU=
X-Google-Smtp-Source: AGHT+IFUHWxPJ1Pf8A+iUWJsR80ZjSo3vtWsPqkNPTGLlql6kWYC0i/U04QbyRsWyXnF40aa++pl0g==
X-Received: by 2002:a05:600c:5115:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-4390d442069mr50078595e9.18.1738833582482; 
 Thu, 06 Feb 2025 01:19:42 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd7f081sm1219571f8f.58.2025.02.06.01.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:19:41 -0800 (PST)
Message-ID: <7d50d81c-982f-45f0-81eb-1c842b3c55cc@linaro.org>
Date: Thu, 6 Feb 2025 10:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] hw/misc: Support 8-bytes memop in NPCM GCR module
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-10-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-10-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/2/25 02:30, Hao Wu wrote:
> The NPCM8xx GCR device can be accessed with 64-bit memory operations.
> This patch supports that.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
>   hw/misc/trace-events |  4 +-
>   2 files changed, 74 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
> index 820b730606..654e048048 100644
> --- a/hw/misc/npcm_gcr.c
> +++ b/hw/misc/npcm_gcr.c
> @@ -201,6 +201,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>       uint32_t reg = offset / sizeof(uint32_t);
>       NPCMGCRState *s = opaque;
>       NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
> +    uint64_t value;
>   
>       if (reg >= c->nr_regs) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> @@ -209,9 +210,21 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>           return 0;
>       }
>   
> -    trace_npcm_gcr_read(offset, s->regs[reg]);
> +    switch (size) {
> +    case 4:
> +        value = s->regs[reg];
> +        break;
> +
> +    case 8:

Should we assert(!(reg & 1)) in case someone want to enable unaligned
accesses?

> +        value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
>   
> -    return s->regs[reg];
> +    trace_npcm_gcr_read(offset, value);
> +    return value;
>   }
>   
>   static void npcm_gcr_write(void *opaque, hwaddr offset,
> @@ -231,29 +244,65 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
>           return;
>       }
>   
> -    switch (reg) {
> -    case NPCM7XX_GCR_PDID:
> -    case NPCM7XX_GCR_PWRON:
> -    case NPCM7XX_GCR_INTSR:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
> -                      __func__, offset);
> -        return;
> -
> -    case NPCM7XX_GCR_RESSR:
> -    case NPCM7XX_GCR_CP2BST:
> -        /* Write 1 to clear */
> -        value = s->regs[reg] & ~value;
> +    switch (size) {
> +    case 4:
> +        switch (reg) {
> +        case NPCM7XX_GCR_PDID:
> +        case NPCM7XX_GCR_PWRON:
> +        case NPCM7XX_GCR_INTSR:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
> +                          __func__, offset);
> +            return;
> +
> +        case NPCM7XX_GCR_RESSR:
> +        case NPCM7XX_GCR_CP2BST:
> +            /* Write 1 to clear */
> +            value = s->regs[reg] & ~value;
> +            break;
> +
> +        case NPCM7XX_GCR_RLOCKR1:
> +        case NPCM7XX_GCR_MDLR:
> +            /* Write 1 to set */
> +            value |= s->regs[reg];
> +            break;
> +        };
> +        s->regs[reg] = value;
>           break;
>   
> -    case NPCM7XX_GCR_RLOCKR1:
> -    case NPCM7XX_GCR_MDLR:
> -        /* Write 1 to set */
> -        value |= s->regs[reg];
> +    case 8:

Ditto.

> +        s->regs[reg] = value;
> +        s->regs[reg + 1] = extract64(v, 32, 32);
>           break;
> -    };
>   
> -    s->regs[reg] = value;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool npcm_gcr_check_mem_op(void *opaque, hwaddr offset,
> +                                  unsigned size, bool is_write,
> +                                  MemTxAttrs attrs)
> +{
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(opaque);
> +
> +    if (offset >= c->nr_regs * sizeof(uint32_t)) {
> +        return false;
> +    }
> +
> +    switch (size) {
> +    case 4:
> +        return true;
> +    case 8:
> +        if (offset >= NPCM8XX_GCR_SCRPAD_00 * sizeof(uint32_t) &&
> +            offset < (NPCM8XX_GCR_NR_REGS - 1) * sizeof(uint32_t)) {
> +            return true;
> +        } else {
> +            return false;
> +        }
> +    default:
> +        return false;
> +    }
>   }
>   
>   static const struct MemoryRegionOps npcm_gcr_ops = {
> @@ -262,7 +311,8 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid      = {
>           .min_access_size        = 4,
> -        .max_access_size        = 4,
> +        .max_access_size        = 8,
> +        .accepts                = npcm_gcr_check_mem_op,
>           .unaligned              = false,
>       },
>   };
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 0f7204a237..f25dbd6030 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -135,8 +135,8 @@ npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " valu
>   npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
>   
>   # npcm_gcr.c
> -npcm_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
> -npcm_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
> +npcm_gcr_read(uint64_t offset, uint64_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
> +npcm_gcr_write(uint64_t offset, uint64_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
>   
>   # npcm7xx_mft.c
>   npcm7xx_mft_read(const char *name, uint64_t offset, uint16_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx16


