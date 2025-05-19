Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12670C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 07:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGuew-0001O5-3g; Mon, 19 May 2025 03:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGuei-0001Nc-Od
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:11:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGuef-0002S6-QH
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:11:24 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxnOKG2SpoMcnxAA--.28210S3;
 Mon, 19 May 2025 15:11:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzxuE2Spol7PgAA--.63539S3;
 Mon, 19 May 2025 15:11:02 +0800 (CST)
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
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
Date: Mon, 19 May 2025 15:09:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxuE2Spol7PgAA--.63539S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryrKFy8tryUAr13tr4rXrc_yoW8uF4Upr
 4UCF4DW3WDWrWrGa4vgFnYkr18t3yxJw4Uurn8Gry8trs8uFWY93WqywsI9FsxXw17Gw10
 v3yv9a4xA34DCagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
 wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
 WIevJa73UjIFyTuYvjxU2DUUUUUUU
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



On 2025/5/19 下午2:50, Jiaxun Yang wrote:
> 
> 
> 在2025年5月19日周一 上午3:56，Bibo Mao写道：
> [...]
>>>
>>> Hi Bibo,
>>>
>>> I believe hijacking loongarch_extioi.c is not the proper way to do it.
>>> The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, which
>>> inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
>>> TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.
>> what is advantage about creating TYPE_LOONGARCH_EXTIOI_KVM device in KVM
>> node and TYPE_LOONGARCH_EXTIOI device in TCG mode?
> 
> Cleaner, less error-prone, isolate unnecessary emulation functions to
> reduce attack surface...
yes, there is a beautiful code logic internal, however from user the 
device tree will be different because of irqchip-in-kernel feature, such 
as different output of *info qom-tree*. It will bring out illusions of 
different virt machine type for users.

Regards
Bibo Mao
> 
>>
>> That means there will be two virt machine types since device name is
>> different in different accel mode.
> 
> Yes I do think you shouldn't aim migration capability between different
> accel mode. It's not doable given we can't emulate full set of h/w behaviour.
> 
>>>
>>> In this way you can avoid ugly "irqchip-in-kernel" property.
>>> Also you don't really want all those emulation functions in
>>> loongarch_extioi.c to kick in when irqchip is in kernel. If
>>> IOCSR VMEXIT happens on extioi range, it's a hypervisor error
>>> rather than something needs to be emulated.
>>>
>>> Also I think EXTIOI_VIRT_CONFIG range MMIO needs to be handled
>>> differently on KVM vs userspace irqchip. EXTIOI_VIRT_CONFIG needs
>>> to be relayed to kernel, as virt_iocsr_misc_write will perform
>>> IOCSR read/write in userspace, this needs to be translated to
>>> KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE.
>> Will handle it, misc iocsr should be emulated in kernel also.
> 
> IMHO misc IOCSR should be in user space because it described
> the capability of machine instead of CPU, it's not a part of
> irqchip.
> 
>>
>> Regards
>> Bibo Mao
> 
> Thanks
> 


