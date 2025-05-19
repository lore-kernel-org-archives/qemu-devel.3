Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A303C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwJE-0004lN-4O; Mon, 19 May 2025 04:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGwJ4-0004jN-Tp
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:57:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGwIw-0001nD-OK
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:57:09 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxHHJP8ipo2OPxAA--.63492S3;
 Mon, 19 May 2025 16:56:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxPsdN8ipomuXgAA--.53769S3;
 Mon, 19 May 2025 16:56:47 +0800 (CST)
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, QEMU devel <qemu-devel@nongnu.org>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
 <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
 <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
 <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1422bdc1-9251-b88e-44fd-e953ee88d0bd@loongson.cn>
Date: Mon, 19 May 2025 16:55:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsdN8ipomuXgAA--.53769S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryDZr4ktFyfKFW7uFWfWFX_yoW8AF18p3
 y7WFWDGa1DGrWrKa40g3ZI9r1rt3yxtr45uFn5GrykAFZ09FWaka4vkr4akFsIq3WxJ3W0
 934ru3WxZr90k3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8HSoJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.872,
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



On 2025/5/19 下午4:49, Jiaxun Yang wrote:
> 
> 
> 在2025年5月19日周一 上午8:09，Bibo Mao写道：
>> On 2025/5/19 下午2:50, Jiaxun Yang wrote:
>>>
>>>
>>> 在2025年5月19日周一 上午3:56，Bibo Mao写道：
>>> [...]
>>>>>
>>>>> Hi Bibo,
>>>>>
>>>>> I believe hijacking loongarch_extioi.c is not the proper way to do it.
>>>>> The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, which
>>>>> inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
>>>>> TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.
>>>> what is advantage about creating TYPE_LOONGARCH_EXTIOI_KVM device in KVM
>>>> node and TYPE_LOONGARCH_EXTIOI device in TCG mode?
>>>
>>> Cleaner, less error-prone, isolate unnecessary emulation functions to
>>> reduce attack surface...
>> yes, there is a beautiful code logic internal, however from user the
>> device tree will be different because of irqchip-in-kernel feature, such
>> as different output of *info qom-tree*. It will bring out illusions of
>> different virt machine type for users.
> 
> It's actually different machine as kernel irqchip is never on par with usermode
> emulation. This approach is taken by i386 (TYPE_KVM_IOAPIC vs TYPE_IOAPIC),
> Arm (TYPE_KVM_ARM_ITS vs TYPE_ARM_GICV3_ITS), PowerPC (TYPE_KVM_OPENPIC vs
> TYPE_OPENPIC) and I see no reason that LoongArch should not follow.
So what is the advantage and disadvantage from yourself understanding here?

Regards
Bibo Mao
> 
> I'm actually planning to bring user space EXTIOI emulation closer to actual
> hardware behaviour and I wound not expect such change to be accepted by
> in-kernel irqchip.
> 
> Thanks
> 
>>
>> Regards
>> Bibo Mao
>>>
> 


