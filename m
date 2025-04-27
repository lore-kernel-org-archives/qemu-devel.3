Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A0C369D5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8wA3-0000gN-SN; Sun, 27 Apr 2025 03:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u8wA0-0000fx-Ur
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 03:10:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u8w9x-0006Uq-CV
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 03:10:44 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxjaxr2A1owh7HAA--.35133S3;
 Sun, 27 Apr 2025 15:10:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxHcVo2A1oHU+YAA--.52381S3;
 Sun, 27 Apr 2025 15:10:35 +0800 (CST)
Subject: Re: [PATCH v2 07/16] hw/intc/loongarch_pch: Use generic read callback
 for iomem32_low region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-8-maobibo@loongson.cn>
 <25215587-3a6b-4206-92be-16ae25e4853c@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <58b52db4-f921-008b-1eb8-d6eb31ac8227@loongson.cn>
Date: Sun, 27 Apr 2025 15:09:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <25215587-3a6b-4206-92be-16ae25e4853c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcVo2A1oHU+YAA--.52381S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr47CrW8WrW7Gw1rCFWDZFc_yoWrXw1xpr
 4kArW5ArWUJr1xXr17J34UJFyUJrn7JwnFg3WYqFyUAF43Aryjqr1kXr1qgF17Kw4kJr1U
 Xr1DGFnxZF17JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUclAp
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.665,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/4/25 下午5:53, Philippe Mathieu-Daudé wrote:
> On 24/3/25 10:37, Bibo Mao wrote:
>> For memory region iomem32_low, generic read callback is used.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/intc/loongarch_pch_pic.c | 71 +++++++++++++++++++++++++------------
>>   1 file changed, 48 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
>> index 10b4231464..b495bd3a4d 100644
>> --- a/hw/intc/loongarch_pch_pic.c
>> +++ b/hw/intc/loongarch_pch_pic.c
>> @@ -7,6 +7,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/bitops.h"
>> +#include "qemu/log.h"
>>   #include "hw/irq.h"
>>   #include "hw/intc/loongarch_pch_pic.h"
>>   #include "trace.h"
>> @@ -71,47 +72,71 @@ static void pch_pic_irq_handler(void *opaque, int 
>> irq, int level)
>>       pch_pic_update_irq(s, mask, level);
>>   }
>> -static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>> -                                            unsigned size)
>> +static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t 
>> field_mask)
>>   {
>>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>>       uint64_t val = 0;
>> +    uint32_t offset = addr & 7;
>>       switch (addr) {
>> -    case PCH_PIC_INT_ID:
>> -        val = s->id.data & UINT_MAX;
>> +    case PCH_PIC_INT_ID ... PCH_PIC_INT_ID + 7:
>> +        val = s->id.data;
>>           break;
>> -    case PCH_PIC_INT_ID + 4:
>> -        val = s->id.data >> 32;
>> +    case PCH_PIC_INT_MASK ... PCH_PIC_INT_MASK + 7:
>> +        val = s->int_mask;
>>           break;
>> -    case PCH_PIC_INT_MASK:
>> -        val = (uint32_t)s->int_mask;
>> +    case PCH_PIC_INT_EDGE ... PCH_PIC_INT_EDGE + 7:
>> +        val = s->intedge;
>>           break;
>> -    case PCH_PIC_INT_MASK + 4:
>> -        val = s->int_mask >> 32;
>> +    case PCH_PIC_HTMSI_EN ... PCH_PIC_HTMSI_EN + 7:
>> +        val = s->htmsi_en;
>>           break;
>> -    case PCH_PIC_INT_EDGE:
>> -        val = (uint32_t)s->intedge;
>> +    case PCH_PIC_AUTO_CTRL0 ... PCH_PIC_AUTO_CTRL0 + 7:
>> +    case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
>> +        /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
>>           break;
>> -    case PCH_PIC_INT_EDGE + 4:
>> -        val = s->intedge >> 32;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
>>           break;
>> -    case PCH_PIC_HTMSI_EN:
>> -        val = (uint32_t)s->htmsi_en;
>> +    }
>> +
>> +    return (val >> (offset * 8)) & field_mask;
> 
> Maybe you want to simplify from a different angle:
> 
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -320,8 +320,7 @@ static const MemoryRegionOps 
> loongarch_pch_pic_reg32_low_ops = {
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 4,
> -        .max_access_size = 4,
> +        .min_access_size = 8,
>       },
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
I do not follow this, do you mean something like this?
        .impl = {
  -        .min_access_size = 4,
  -        .max_access_size = 4,
  +        .min_access_size = 1,
  +        .max_access_size = 8,
        },

Since this driver is used by KVM, performance issue need be considered.
For normal aligned 1/2/4/8 bytes access, it had better be accessed once 
rather than concatenated with 1 byte access for many times.

Regards
Bibo Mao


