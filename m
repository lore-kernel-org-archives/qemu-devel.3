Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739CDC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdsw-0008Kz-FO; Tue, 04 Mar 2025 20:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpdst-0008KR-7B
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:49:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpdsq-00068J-6J
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:49:18 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxGHGSrcdnkrSKAA--.41264S3;
 Wed, 05 Mar 2025 09:49:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxDcWLrcdnHr02AA--.4142S3;
 Wed, 05 Mar 2025 09:49:02 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Adjust the cpu reset action to a proper
 position
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20250303063043.3237264-1-lixianglai@loongson.cn>
 <cae24c94-62bf-6876-2f80-1eb91646cd8a@loongson.cn>
 <20250303142118.7f558c8e@imammedo.users.ipa.redhat.com>
Cc: "lixianglai@loongson.cn" <lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <34835b04-6c4a-661a-e280-e7a1fe19fc14@loongson.cn>
Date: Wed, 5 Mar 2025 09:48:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250303142118.7f558c8e@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcWLrcdnHr02AA--.4142S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyDAr4DWrWkCw4kAr4kKrX_yoW8ur4Dpr
 Z7AF1YkF4kJr9IywsFq34jqFyqqr97Kr4kZF1xtryIkrZ0gFnYqF10yan09F9ruw1rG3Wj
 qrWUKa4a9an0v3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.578,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

applied to loongarch-next.

On 2025/3/3 下午9:21, Igor Mammedov wrote:
> On Mon, 3 Mar 2025 17:15:13 +0800
> bibo mao <maobibo@loongson.cn> wrote:
> 
>> Xianglai,
>>
>> There is a similar modification already, just wait a moment :)
>>    https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg01537.html
> 
> Please ignore my patch (commit message gives good enough justification
> for refactoring but that's it).
> 
> this patch commit message however points to the concrete issue
> wrong reset ordering causes, hence I think it's better to merge
> this variant.
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>
>   
>>
>>
>> Regards
>> Bibo Mao
>>
>> On 2025/3/3 下午2:30, Xianglai Li wrote:
>>> The commit 5a99a10da6cf ("target/loongarch: fix vcpu reset command word issue")
>>> fixes the error in the cpu reset ioctl command word delivery process,
>>> so that the command word can be delivered correctly, and adds the judgment
>>> and processing of the error return value, which exposes another problem that
>>> under loongarch, the cpu reset action is earlier than the creation of vcpu.
>>> An error occurs when the cpu reset command is sent.
>>>
>>> Now adjust the order of cpu reset and vcpu create actions to fix this problem
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Bibo Mao <maobibo@loongson.cn>
>>> Huacai Chen <chenhuacai@loongson.cn>
>>> Song Gao <gaosong@loongson.cn>
>>> Xianglai Li <lixianglai@loongson.cn>
>>>
>>>    target/loongarch/cpu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index 3788f895c1..67aa7875b6 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -640,8 +640,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>>    
>>>        loongarch_cpu_register_gdb_regs_for_features(cs);
>>>    
>>> -    cpu_reset(cs);
>>>        qemu_init_vcpu(cs);
>>> +    cpu_reset(cs);
>>>    
>>>        lacc->parent_realize(dev, errp);
>>>    }
>>>    
>>
>>
> 


