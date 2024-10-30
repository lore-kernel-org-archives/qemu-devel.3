Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880FD74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xwX-0003k0-7W; Tue, 29 Oct 2024 21:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5xwT-0003jh-3g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:56:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5xwQ-0002no-QM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:56:12 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axjq82kiFnZEkdAA--.36959S3;
 Wed, 30 Oct 2024 09:56:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxLEc2kiFnrT4oAA--.23203S3;
 Wed, 30 Oct 2024 09:56:06 +0800 (CST)
Subject: Re: [PATCH v2 4/4] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-5-maobibo@loongson.cn> <ZyDnpk3tmG4KECWc@intel.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ce111d21-7400-80c0-0984-ee2bc0286f40@loongson.cn>
Date: Wed, 30 Oct 2024 09:55:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZyDnpk3tmG4KECWc@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLEc2kiFnrT4oAA--.23203S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryftF4kKFWUXw17Cry7CFX_yoW8Aw4kpr
 4UJ34DZ3WUAF1Fv3yFga4qgFy0qw1rXay7u3yvqa47A3Zakrn5tF1jkw4YgF4fAa10gaya
 9Fs8WFnF9F4qqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07josjUU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.804,
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



On 2024/10/29 下午9:48, Zhao Liu wrote:
> [snip]
> 
>> @@ -1382,8 +1384,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>        }
>>   
>>       if (cpu->phy_id == UNSET_PHY_ID) {
>> -        error_setg(&local_err, "CPU hotplug not supported");
>> -        goto out;
>> +        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
>> +            error_setg(&local_err,
>> +                       "Invalid thread-id %u specified, must be in range 1:%u",
>> +                       cpu->thread_id, ms->smp.threads - 1);
>> +            goto out;
>> +        }
>> +
>> +        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>> +            error_setg(&local_err,
>> +                       "Invalid core-id %u specified, must be in range 1:%u",
>> +                       cpu->core_id, ms->smp.cores - 1);
>> +            goto out;
>> +        }
>> +
>> +        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>> +            error_setg(&local_err,
>> +                       "Invalid socket-id %u specified, must be in range 1:%u",
>> +                       cpu->socket_id, ms->smp.sockets - 1);
>> +            goto out;
>> +        }
>> +
>> +        topo.socket_id = cpu->socket_id;
>> +        topo.core_id = cpu->core_id;
>> +        topo.thread_id = cpu->thread_id;
>> +        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
>> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
>> +        if (CPU(cpu_slot->cpu)) {
>> +            error_setg(&local_err,
>> +                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>> +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
>> +                       cpu->thread_id, cpu_slot->arch_id);
>> +            goto out;
>> +        }
>> +        cpu->phy_id = arch_id;
>>       } else {
> 
> Here you allow user to specify topology IDs, but "else" still indicates
> user could use "phy_id" instead of topology IDs, right?
"else" for cold-plug CPUs which is created with index from [0 -- smp.cpus)

> 
> Is it necessary to expose "phy_id" to user?
We will remove phy_id property and unexpose it to user.

Regards
Bibo Mao
> 
> Thanks,
> Zhao
> 


