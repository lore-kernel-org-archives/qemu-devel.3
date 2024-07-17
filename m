Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E050AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0sA-0005Q9-Lj; Wed, 17 Jul 2024 05:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sU0s8-0005OH-03
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:22:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sU0s4-0004ll-Cu
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:22:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxnOpdjZdmcw8AAA--.359S3;
 Wed, 17 Jul 2024 17:22:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsVZjZdm0k5MAA--.29785S3; 
 Wed, 17 Jul 2024 17:22:35 +0800 (CST)
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
 <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
 <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
 <4061a31e-1cd8-4cd7-96f3-3e5208e12a87@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <51574a26-9f62-e069-f8db-d7f243f89b44@loongson.cn>
Date: Wed, 17 Jul 2024 17:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4061a31e-1cd8-4cd7-96f3-3e5208e12a87@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxlsVZjZdm0k5MAA--.29785S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1rZrWrurWkZw18Zw1UArc_yoW8Kr4UpF
 W8CayYgF4DJr15Jrsrtas0gFWqyr13JrZ2g3WFqr97CrZFqryFqw4IvrWUu3Z8Ar1fJ3Wj
 vF409347Za4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.356,
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



On 2024/7/16 下午2:40, Philippe Mathieu-Daudé wrote:
> On 16/7/24 03:29, maobibo wrote:
>>
>>
>> On 2024/7/16 上午9:04, maobibo wrote:
>>>
>>>
>>> On 2024/7/15 下午11:17, Philippe Mathieu-Daudé wrote:
>>>> On 4/7/24 05:37, Bibo Mao wrote:
>>>>> Now loongson ipi and loongarch ipi share the same code with different
>>>>> macro, loongson ipi has its separate function such mmio region,
>>>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>>>
>>>>> Interrupt irqchip has strong relationship with architecture, since
>>>>> it sends irq to vcpu and interfaces to get irqchip register is also
>>>>> architecture specific.
>>>>>
>>>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>>>> is added, it comes from loongson ipi mostly. And it defined four 
>>>>> abstract
>>>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 
>>>>> machine,
>>>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>>>
>>>>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>>>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>>>> loongson ipi device only passes to compile and make check, it is not
>>>>> tested.
>>>>>
>>>>> Bibo Mao (4):
>>>>>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>>>>>    hw/intc/loongarch_ipi: Add loongarch ipi support
>>>>>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>>>>    hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>>>
>>>> I'll try to respin a clearer v3.
>>> I am ok with it since it solve the problem, and it is suitable for 
>>> 9.1 release. Only that in the long time we hope that intc emulation 
>>> driver has common base class + tcg/kvm driver, similar with other 
>>> architecture.
>>>
>> Sorry for the confusion, I had thought it was another topic.
>>
>> Thanks for pointing out the problem and welcome the v3 version.
> 
> Please do not post v3, let me post it.
Hi Philippe,

QEMU 9.1 is coming to soft frozen stage, do you have enough time working 
on it?  Is it ok to use bugfix patch for 9.1 release version?
https://lore.kernel.org/all/20240627125819.62779-2-philmd@linaro.org/

After 9.1 is released, there will be enough time for patch v3.

Regards
Bibo, Mao


