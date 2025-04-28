Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F54AC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OEx-0007p6-Sx; Mon, 28 Apr 2025 09:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9OBd-0004zF-Jx
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:06:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9OBa-00040y-V3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:06:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so31528935e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845573; x=1746450373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IeTh6Y9MI64p2F6pSY+GZFUSHDRGIEi15yluLRkHwkQ=;
 b=FaeV9SrdGnXfV5c9ZFkzzj46W7GAgn5+Lkd3j5cLc39TgnQ8wslzI/Aq3iIqkQhHRn
 u8eMwm+ud4PWOBVL3BwVOr/TJWMm/SDqxAm1OCfMX+k7KwUU0Lei+7Z9OP7L2VS2W0Gn
 vLDw+oQH0gjnI2txxWWcbNLhxlpbxKk3QWhIs10qM02RoWNLQYzdEIB66JojKUKQrDN5
 TaqYRJc4/vfIFXyf3sZYOL7bqhdDNlXwViIWkBeN76OcS6xx4gPzNelrI5wZSpFTnxZr
 D8nsv1DsbEsZP1Vt7ErGjfDJj+T/fIfZru6bfc0N9bs2tOjhtPU5bfodgbHiy35LhZTQ
 RcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845573; x=1746450373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IeTh6Y9MI64p2F6pSY+GZFUSHDRGIEi15yluLRkHwkQ=;
 b=rtqjTdZGJBtwR2bsy/FOYKopG70ly0Aif2AMlG/r6DQJB0+r9kp2HOxgrDse7YjFm5
 cJkaAhpowNLQqM+WV3oQMpThymPqwoDZpxlpnxnqDI1F02aGt3bnUVoFn8RyeOYVi63E
 9qss+T1V3EB6z9FYAQfkE0iBeirMiWXZg58AB1v+z9jgIYSjHc/07Slv8mrOEAGrIbh/
 0xJx4Y7WLdONWN0yi/CaZEld5v10w/vwMKi/43Hp5P4Z4NWmKBSf9bVZtzZS2BPz4YZt
 o2vIczl6ME/tCwY41B2L1GtrUP9JlY36Sj/Tu0Sq60ts5NWmGUVwo/eNEWIcK4SuGW++
 PcQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmfMN2bQbu179GIriDovHoy5JlAfpfIVtdzV7d5Ief9c9FB7eshzKhG5Vf/muKz7fV/pxHT2KPqdRe@nongnu.org
X-Gm-Message-State: AOJu0YxbdWzpZxck1HUB2DeCKRmnhtqytOv6NEZbZmXRwS8cW2yqd9yq
 TLnAZd9Hs/wFleeL8B927aKPlpLwdOOsC8+kCLdO1YWdAa1qENmAW+DxbSGRkQiDVYljWsyrEKV
 x
X-Gm-Gg: ASbGncuTq5c2uuOLMEx1OWj5GanEjeoTd0mMsqvANLxm1OU007Qi23j4zRHcNeAvANs
 DXj7zTPUteqKLm9bbEgqzi2MRVAQY+ocCI6c80fn7s2tmlIpZ0H+AyTcNF6H8CnyPzV6uKNr2GR
 aSttYKiAh241DtFGuo2Z45uEKIsbyw+GV7kNyOPUIeLsGRatL0YqZw65deTKIM4bJ4ng/VSddDt
 L0AlPNAdZsk4oQXtLRUk5zwboNJXgne6QGVnd0KVbkltlgVaGFa0fsDH24dmTlPjx+Ne5tq0nR5
 n30IcSDragDRDWRlVHrfJZDKg9j+T5eCvM8zzRqm2FlR74LgQiNRNirvKUMhEMG9Cwl3l7H8JdX
 2VjOsstbduP6j1YI8hXBXc586
X-Google-Smtp-Source: AGHT+IEDVxgQzSGTlb/LGPgo0a1q+rRWFUt1Xv7HZOV4hDiHgaQm8/j1m5NYht/VKplOLgQ28Ykvag==
X-Received: by 2002:a05:600d:9:b0:43c:ea40:ae4a with SMTP id
 5b1f17b1804b1-440a7d56563mr88908365e9.31.1745845572864; 
 Mon, 28 Apr 2025 06:06:12 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac079sm156344935e9.18.2025.04.28.06.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 06:06:12 -0700 (PDT)
Message-ID: <c07b6c0d-b3d5-4598-9794-f6e1fb3f0295@linaro.org>
Date: Mon, 28 Apr 2025 15:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/intc/loongarch_pch: Use generic read callback
 for iomem32_low region
To: bibo mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-8-maobibo@loongson.cn>
 <25215587-3a6b-4206-92be-16ae25e4853c@linaro.org>
 <58b52db4-f921-008b-1eb8-d6eb31ac8227@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <58b52db4-f921-008b-1eb8-d6eb31ac8227@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 27/4/25 09:09, bibo mao wrote:
> 
> 
> On 2025/4/25 下午5:53, Philippe Mathieu-Daudé wrote:
>> On 24/3/25 10:37, Bibo Mao wrote:
>>> For memory region iomem32_low, generic read callback is used.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/intc/loongarch_pch_pic.c | 71 +++++++++++++++++++++++++------------
>>>   1 file changed, 48 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
>>> index 10b4231464..b495bd3a4d 100644
>>> --- a/hw/intc/loongarch_pch_pic.c
>>> +++ b/hw/intc/loongarch_pch_pic.c
>>> @@ -7,6 +7,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu/bitops.h"
>>> +#include "qemu/log.h"
>>>   #include "hw/irq.h"
>>>   #include "hw/intc/loongarch_pch_pic.h"
>>>   #include "trace.h"
>>> @@ -71,47 +72,71 @@ static void pch_pic_irq_handler(void *opaque, int 
>>> irq, int level)
>>>       pch_pic_update_irq(s, mask, level);
>>>   }
>>> -static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>>> -                                            unsigned size)
>>> +static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t 
>>> field_mask)
>>>   {
>>>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>>>       uint64_t val = 0;
>>> +    uint32_t offset = addr & 7;
>>>       switch (addr) {
>>> -    case PCH_PIC_INT_ID:
>>> -        val = s->id.data & UINT_MAX;
>>> +    case PCH_PIC_INT_ID ... PCH_PIC_INT_ID + 7:
>>> +        val = s->id.data;
>>>           break;
>>> -    case PCH_PIC_INT_ID + 4:
>>> -        val = s->id.data >> 32;
>>> +    case PCH_PIC_INT_MASK ... PCH_PIC_INT_MASK + 7:
>>> +        val = s->int_mask;
>>>           break;
>>> -    case PCH_PIC_INT_MASK:
>>> -        val = (uint32_t)s->int_mask;
>>> +    case PCH_PIC_INT_EDGE ... PCH_PIC_INT_EDGE + 7:
>>> +        val = s->intedge;
>>>           break;
>>> -    case PCH_PIC_INT_MASK + 4:
>>> -        val = s->int_mask >> 32;
>>> +    case PCH_PIC_HTMSI_EN ... PCH_PIC_HTMSI_EN + 7:
>>> +        val = s->htmsi_en;
>>>           break;
>>> -    case PCH_PIC_INT_EDGE:
>>> -        val = (uint32_t)s->intedge;
>>> +    case PCH_PIC_AUTO_CTRL0 ... PCH_PIC_AUTO_CTRL0 + 7:
>>> +    case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
>>> +        /* PCH PIC connect to EXTIOI always, discard auto_ctrl 
>>> access */
>>>           break;
>>> -    case PCH_PIC_INT_EDGE + 4:
>>> -        val = s->intedge >> 32;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
>>>           break;
>>> -    case PCH_PIC_HTMSI_EN:
>>> -        val = (uint32_t)s->htmsi_en;
>>> +    }
>>> +
>>> +    return (val >> (offset * 8)) & field_mask;
>>
>> Maybe you want to simplify from a different angle:
>>
>> --- a/hw/intc/loongarch_pch_pic.c
>> +++ b/hw/intc/loongarch_pch_pic.c
>> @@ -320,8 +320,7 @@ static const MemoryRegionOps 
>> loongarch_pch_pic_reg32_low_ops = {
>>           .max_access_size = 8,
>>       },
>>       .impl = {
>> -        .min_access_size = 4,
>> -        .max_access_size = 4,
>> +        .min_access_size = 8,
>>       },
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
> I do not follow this, do you mean something like this?
>         .impl = {
>   -        .min_access_size = 4,
>   -        .max_access_size = 4,
>   +        .min_access_size = 1,
>   +        .max_access_size = 8,
>         },
> 
> Since this driver is used by KVM, performance issue need be considered.

We are in slow path anyway, I doubt performance is measurable, you are
doing the same maths manually before returning.
Anyway I'm not insisting.

> For normal aligned 1/2/4/8 bytes access, it had better be accessed once 
> rather than concatenated with 1 byte access for many times.
> 
> Regards
> Bibo Mao
> 


