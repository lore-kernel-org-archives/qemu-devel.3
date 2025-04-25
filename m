Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF84C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Fk8-0002Um-A0; Fri, 25 Apr 2025 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Fk4-0002Ty-OC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:53:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Fk2-0001yr-Vh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:53:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1533801f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745574784; x=1746179584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCIFc9Ywm0AmaVntvVN1+juG/a3jixQnZLK3MkEjkm4=;
 b=kSouVUMOot5Zj39yk0LfLkjUXupHvsl294SM5+kdqvq6iLVrJZ4KEHEqplzO3gqlbb
 ouq12+ZEfilZ8RLEeMUaGJd81rOiytxv7x+cxBNcRdQM0byH7dfr3jJteLM3DRoC5Bvz
 xGwsZ+MG0uc5MDvG17F5yt+Te9TTnQWUQcciabCAF5gbDvQcvYdRobChmn8I/GJvF2xN
 KVEw76sTAiH6J9Q8GaxGX7hA1VLNanYdNwgT9prOB35URjtbKVGvoDgsTvfKfbRACaHM
 cmXC/4rqbdqB0XCSBc7c7eDRvuoYt1NP/iepWpHzDpFz45FlogyltYFdaOM/+B1Q+Z92
 Z53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574784; x=1746179584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oCIFc9Ywm0AmaVntvVN1+juG/a3jixQnZLK3MkEjkm4=;
 b=Iv4zPYFJeVlJ7vLw0XrnU5MbIdssesovKxpF9YjHwK4p9hjoEEGtldFDa65KMGMScZ
 xg3R5OGAdT7U7QOq1b9rWzy5VWDsCi/ZPSLrLUBa8DgCb3SoBx0r7tcPs7Q92lTU5d45
 TXZVzGx6y5hz5NVx3UIN+1hAkvixIO6racmOxNPcUBofyAQmVBP6/MIp0YrcQ1ScvkMn
 CHuPpkAhqsH19fj2nZ3qASaWrVp1BRKx6lSjhz4fMb6IFLp7Oz9d1wckcHx8NgYxf3je
 eVuvsq0LfTjL0NlRj28y1p1SUisc/jORRoqPGZaRUHJCbVKUVGS12oou0lQov7ZRiGHb
 TFrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZGAb+gF9xZi/CIBUMYjdT+yixKMFmpJ83YUgvji0bDkzkjEWC8c8I8Rx/tRU3TqIpZ7FK++fpY4gI@nongnu.org
X-Gm-Message-State: AOJu0YwX0W40BuZ+DIck0Y2od+BkYBk2YOpHL4i94UtBkGolweG1QhEe
 4TzmypK1RhIo3JJ4feMCIDaSBueRgGBgf086kaDihsyXcsR+HnXv3Sq+uBEJ4lI=
X-Gm-Gg: ASbGncuNQ9bf2zQz2cOQAB3WO63DJxPKGBYk9mF2Xrfp3SHbweDcWkzFKAnYHYfzvD9
 lhpoCcan1cD8W9LhwS6yZAXtbOPoGxwbvB/EsfK/ycohnTvGzppciQCY5uUOUyKf85W5SbOjhRR
 HSJD+ZuidZsgXi6DWw6whl3k4kZCc9jEqk+QNFN/ADojbztTxXIuti7W7bPHvYgF2O+yLuNaviL
 JeCeA2iFmKQA7CNEjSej0pbsiBBtBdEzb5YvbaYq0QVJlJ5S0cyFRBc4YEq9yXzvB/6v2cpgHLh
 /M3H3i13XjsPPZ581tXsgzeoFj12NzbyBqciB/PkxZOT0qovw6B7nmaijStAagrsvDQm3EHsOOT
 OLfvk93WdBEvc3w==
X-Google-Smtp-Source: AGHT+IG95+POenL5gKJwS9slJpt7SxpswHKyyx89IsPDwhTXRxfUHh00LpewklDXgGcsHBUbli+wLg==
X-Received: by 2002:a05:6000:22c6:b0:391:3406:b4e1 with SMTP id
 ffacd0b85a97d-3a074e2e253mr1240336f8f.15.1745574784367; 
 Fri, 25 Apr 2025 02:53:04 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c7d1sm1804282f8f.83.2025.04.25.02.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:53:03 -0700 (PDT)
Message-ID: <25215587-3a6b-4206-92be-16ae25e4853c@linaro.org>
Date: Fri, 25 Apr 2025 11:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/intc/loongarch_pch: Use generic read callback
 for iomem32_low region
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-8-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324093730.3683378-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 24/3/25 10:37, Bibo Mao wrote:
> For memory region iomem32_low, generic read callback is used.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 71 +++++++++++++++++++++++++------------
>   1 file changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 10b4231464..b495bd3a4d 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -7,6 +7,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/bitops.h"
> +#include "qemu/log.h"
>   #include "hw/irq.h"
>   #include "hw/intc/loongarch_pch_pic.h"
>   #include "trace.h"
> @@ -71,47 +72,71 @@ static void pch_pic_irq_handler(void *opaque, int irq, int level)
>       pch_pic_update_irq(s, mask, level);
>   }
>   
> -static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
> -                                            unsigned size)
> +static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> +    uint32_t offset = addr & 7;
>   
>       switch (addr) {
> -    case PCH_PIC_INT_ID:
> -        val = s->id.data & UINT_MAX;
> +    case PCH_PIC_INT_ID ... PCH_PIC_INT_ID + 7:
> +        val = s->id.data;
>           break;
> -    case PCH_PIC_INT_ID + 4:
> -        val = s->id.data >> 32;
> +    case PCH_PIC_INT_MASK ... PCH_PIC_INT_MASK + 7:
> +        val = s->int_mask;
>           break;
> -    case PCH_PIC_INT_MASK:
> -        val = (uint32_t)s->int_mask;
> +    case PCH_PIC_INT_EDGE ... PCH_PIC_INT_EDGE + 7:
> +        val = s->intedge;
>           break;
> -    case PCH_PIC_INT_MASK + 4:
> -        val = s->int_mask >> 32;
> +    case PCH_PIC_HTMSI_EN ... PCH_PIC_HTMSI_EN + 7:
> +        val = s->htmsi_en;
>           break;
> -    case PCH_PIC_INT_EDGE:
> -        val = (uint32_t)s->intedge;
> +    case PCH_PIC_AUTO_CTRL0 ... PCH_PIC_AUTO_CTRL0 + 7:
> +    case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
> +        /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
>           break;
> -    case PCH_PIC_INT_EDGE + 4:
> -        val = s->intedge >> 32;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
>           break;
> -    case PCH_PIC_HTMSI_EN:
> -        val = (uint32_t)s->htmsi_en;
> +    }
> +
> +    return (val >> (offset * 8)) & field_mask;

Maybe you want to simplify from a different angle:

--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -320,8 +320,7 @@ static const MemoryRegionOps 
loongarch_pch_pic_reg32_low_ops = {
          .max_access_size = 8,
      },
      .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+        .min_access_size = 8,
      },
      .endianness = DEVICE_LITTLE_ENDIAN,
  };


