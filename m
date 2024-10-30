Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89603D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xry-0002uL-4Q; Tue, 29 Oct 2024 21:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5xrv-0002u8-HH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:51:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5xrs-0002EA-Ai
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:51:31 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxeeAckSFn7kcdAA--.60211S3;
 Wed, 30 Oct 2024 09:51:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx98AakSFnkjwoAA--.23043S3;
 Wed, 30 Oct 2024 09:51:22 +0800 (CST)
Subject: Re: [PATCH v2 2/4] hw/loongarch/virt: Implement cpu plug interface
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-3-maobibo@loongson.cn> <ZyDlDjkO8ewhiE/m@intel.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <6e53ba79-041a-3294-3656-9f5d5c41ad19@loongson.cn>
Date: Wed, 30 Oct 2024 09:50:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZyDlDjkO8ewhiE/m@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98AakSFnkjwoAA--.23043S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryUXF13tw4rKw18tr45XFc_yoW5XrWDpF
 Z7tFyaqFyDZrn7A34ft3WrWry0gwn7Wa17Wws5JFnxAws8Ar18GF1UKw4Y9F15C340vry0
 va13Aa4kZF1Y9agCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZU
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


Hi Zhao,

On 2024/10/29 下午9:37, Zhao Liu wrote:
> (CC Igor since I want to refer his comment on hotplug design.)
> 
> Hi Bibo,
> 
> I have some comments about your hotplug design.
> 
> [snip]
> 
>> +static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>> +                              DeviceState *dev, Error **errp)
>> +{
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>> +    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    CPUState *cs = CPU(dev);
>> +    CPUArchId *cpu_slot;
>> +    Error *local_err = NULL;
>> +    LoongArchCPUTopo topo;
>> +    int arch_id, index = 0;
> 
> [snip]
> 
>> +    if (cpu->phy_id == UNSET_PHY_ID) {
>> +        error_setg(&local_err, "CPU hotplug not supported");
>> +        goto out;
>> +    } else {
>> +        /*
>> +         * For non hot-add cpu, topo property is not set. And only physical id
>> +         * property is set, setup topo information from physical id.
>> +         *
>> +         * Supposing arch_id is equal to cpu slot index
>> +         */
>> +        arch_id = cpu->phy_id;
>> +        virt_get_topo_from_index(ms, &topo, arch_id);
>> +        cpu->socket_id = topo.socket_id;
>> +        cpu->core_id   = topo.core_id;
>> +        cpu->thread_id = topo.thread_id;
>> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
>> +    }
> 
> It seems you want to use "phy_id" (instead of topology IDs as for now)
> as the parameter to plug CPU. And IIUC in previous patch, "phy_id" is
> essentially the CPU index.
> 
> Igor has previously commented [1] on ARM's hotplug design that the
> current QEMU should use the topology-id (socket-id/core-id/thread-id) as
> the parameters, not the CPU index or the x86-like apic id.
> 
> So I think his comment can apply on loongarch, too.
Yes, I agree. This piece of code is for cold-plug CPUs which is added 
during VM power-on stage, not hot-plugged cpu. For hot-plugged cpu, 
value of cpu->phy_id is UNSET_PHY_ID.

Topology-id (socket-id/core-id/thread-id) is not set for cold-plug CPUs.
For cold-plug CPUs topology-id is calculated from archid.

Regards
Bibo

> 
>  From my own understanding, the CPU index lacks topological intuition,
> and the APIC ID for x86 is even worse, as its sometimes even
> discontinuous. Requiring the user to specify topology ids would allow
> for clearer localization to CPU slots.
> 
> [1]: https://lore.kernel.org/qemu-devel/20240812101556.1a395712@imammedo.users.ipa.redhat.com/
> 
>> +    /*
>> +     * update cpu_index calculation method since it is easily used as index
>> +     * with possible_cpus array by function virt_cpu_index_to_props
>> +     */
>> +    cs->cpu_index = index;
>> +    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
>> +    return ;
>> +
>> +out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
> 
> Thanks,
> Zhao
> 


