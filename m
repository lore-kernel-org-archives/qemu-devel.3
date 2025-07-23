Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D4CC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 06:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSy6-0004dp-SF; Wed, 23 Jul 2025 02:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ueSf7-00030r-BS
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:09:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ueSf3-0007Zm-TA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:09:09 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxrnJ4fIBo0BswAQ--.32962S3;
 Wed, 23 Jul 2025 14:08:56 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxzsF1fIBoZswiAA--.23054S3;
 Wed, 23 Jul 2025 14:08:56 +0800 (CST)
Subject: Re: [PATCH 1/1] hw/intc/loongarch_ipi: use physical CPU ID for
 kvm_ipi_access_regs
To: Bibo Mao <maobibo@loongson.cn>, lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250723014054.742353-1-gaosong@loongson.cn>
 <fb9b7c23-d85a-819b-a950-2e57d52caa02@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <edb48440-48d8-5efc-ea26-2f2324b5a84d@loongson.cn>
Date: Wed, 23 Jul 2025 14:11:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fb9b7c23-d85a-819b-a950-2e57d52caa02@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxzsF1fIBoZswiAA--.23054S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw43Ar45tF1xXF4xtF4fZwc_yoW8XFWxpr
 WkC3W5CrW8ArykJa4qqa4UWFyDXrn7t3W7ua1xKFyUJFnxZr1Fgryq9r90gFyUA3y8tFyj
 vF17tF17ZFWUAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.517,
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

在 2025/7/23 上午11:21, Bibo Mao 写道:
>
>
> On 2025/7/23 上午9:40, Song Gao wrote:
>> QEMU reboot after inserting no-configuous cpus may start failed
>> becaue the vcpu context may not have created on KVM, On QEMU side use 
>> physical CPU ID
>> for kvm_ipi_access_regs and do some check. On KVM use 
>> kvm_get_vcpu_by_cpuid get vcpu.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_ipi_kvm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
>> index 4cb3acc921..1c26fdcb10 100644
>> --- a/hw/intc/loongarch_ipi_kvm.c
>> +++ b/hw/intc/loongarch_ipi_kvm.c
>> @@ -31,6 +31,11 @@ static void kvm_ipi_access_regs(void *opaque, bool 
>> write)
>>         for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
>>           core = &ipi->cpu[cpu];
>> +        if (core == NULL || core->cpu == NULL ) {
>> +            continue;
>> +        }
>> +        cpu = core->cpu->cpu_index;
> Can we use another variable since cpu is used in loop sentence already?
yes ,   I will correct on v2.

Thanks
Song Gao.
> for (cpu = 0; cpu < ipi->num_cpu; cpu++)
> Here modification with cpu will change loop sentence flow.
>
> Or direct use attr = (core->cpu->cpu_index << 16) | CORE_STATUS_OFF;
>
> Regards
> Bibo Mao
>> +
>>           attr = (cpu << 16) | CORE_STATUS_OFF;
>>           kvm_ipi_access_reg(fd, attr, &core->status, write);
>>


