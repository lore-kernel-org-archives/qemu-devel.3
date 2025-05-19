Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117DEC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 02:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGqhz-0004oK-Ro; Sun, 18 May 2025 22:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGqhp-0004nE-Mt
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:58:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGqhn-0004LC-2s
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:58:21 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxOGpFnipoIZPxAA--.65413S3;
 Mon, 19 May 2025 10:58:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxbsVCnipoE0rgAA--.52680S3;
 Mon, 19 May 2025 10:58:12 +0800 (CST)
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, QEMU devel <qemu-devel@nongnu.org>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
Date: Mon, 19 May 2025 10:56:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsVCnipoE0rgAA--.52680S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1fCFW8ZryxWFyxtr17CFX_yoW8KFW8pr
 1UCFW5Ww4kW34xG3sak3WDur95Xws3WrW7uFy3trWIkrn8uryY9a4ktr9xWFZxGw1kWw1q
 v34ru3WUuFyDCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jo
 sjUUUUUU=
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



On 2025/5/9 下午8:36, Jiaxun Yang wrote:
> 
> 
> 在2025年5月9日周五 上午11:07，Bibo Mao写道：
>> Add save and store funtction if irqchip-in-kernel property is enabled,
>> it is to get/set ExtIOI irqchip state from KVM kernel.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/intc/loongarch_extioi.c         |  17 +++++
>>   hw/intc/loongarch_extioi_kvm.c     | 100 +++++++++++++++++++++++++++++
>>   include/hw/intc/loongarch_extioi.h |   2 +
>>   3 files changed, 119 insertions(+)
>>
>> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
>> index 854f54684b..e81caf430c 100644
>> --- a/hw/intc/loongarch_extioi.c
>> +++ b/hw/intc/loongarch_extioi.c
>> @@ -398,9 +398,21 @@ static void loongarch_extioi_reset_hold(Object
>> *obj, ResetType type)
>>       }
>>   }
>>
>> +static int vmstate_extioi_pre_save(void *opaque)
>> +{
>> +    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(opaque);
>> +
>> +    if (kvm_enabled() && les->irqchip_in_kernel) {
>> +        return kvm_loongarch_extioi_pre_save(opaque);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> 
> Hi Bibo,
> 
> I believe hijacking loongarch_extioi.c is not the proper way to do it.
> The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, which
> inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
> TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.
what is advantage about creating TYPE_LOONGARCH_EXTIOI_KVM device in KVM 
node and TYPE_LOONGARCH_EXTIOI device in TCG mode?

That means there will be two virt machine types since device name is 
different in different accel mode.
> 
> In this way you can avoid ugly "irqchip-in-kernel" property.
> Also you don't really want all those emulation functions in
> loongarch_extioi.c to kick in when irqchip is in kernel. If
> IOCSR VMEXIT happens on extioi range, it's a hypervisor error
> rather than something needs to be emulated.
> 
> Also I think EXTIOI_VIRT_CONFIG range MMIO needs to be handled
> differently on KVM vs userspace irqchip. EXTIOI_VIRT_CONFIG needs
> to be relayed to kernel, as virt_iocsr_misc_write will perform
> IOCSR read/write in userspace, this needs to be translated to
> KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE.
Will handle it, misc iocsr should be emulated in kernel also.

Regards
Bibo Mao
> 
> Hope it makes sense.
> 
> Thanks
> 


