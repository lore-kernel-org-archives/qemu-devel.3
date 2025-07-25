Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE1AC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCs2-0006SW-0a; Fri, 25 Jul 2025 03:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ufCry-0006Pe-6D
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:29:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ufCrv-0008EM-8j
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:29:29 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLGtQMoNoXLkxAQ--.35185S3;
 Fri, 25 Jul 2025 15:29:20 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxT+ZOMoNomAUmAA--.63460S3;
 Fri, 25 Jul 2025 15:29:20 +0800 (CST)
Subject: Re: [PATCH v2] hw/intc/loongarch_ipi: use logical CPU ID for
 kvm_ipi_access_regs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 maobibo@loongson.cn, lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org, jiaxun.yang@flygoat.com
References: <20250725012528.2582498-1-gaosong@loongson.cn>
 <7820abd3-4f11-438a-8047-bc036380cc4c@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3358c70d-5d12-2d63-cf02-077d0b5c39c6@loongson.cn>
Date: Fri, 25 Jul 2025 15:32:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7820abd3-4f11-438a-8047-bc036380cc4c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxT+ZOMoNomAUmAA--.63460S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW7tr45Gw4Utr43XFy5GFX_yoW8Cw1kpr
 WkAr4Y9rW8Cr95Jw4jy34DWFyDWr1xJ3ZrXw4fKFyUAF47Zr10gry8XryvgFyUJr48CF15
 XF17KF12vFy3JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
 wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
 xhVjvjDU0xZFpf9x07jUsqXUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.672,
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

在 2025/7/25 下午3:22, Philippe Mathieu-Daudé 写道:
> On 25/7/25 03:25, Song Gao wrote:
>> QEMU reboot after inserting no-configuous cpus may start failed
>> becaue the vcpu context may not have created on KVM, On QEMU side use 
>> logical CPU ID
>> for kvm_ipi_access_regs and do some check. On KVM use 
>> kvm_get_vcpu_by_id() get vcpu.
>>
Hi,
Sorry
this patch not fix this problem ,
This patch  just  fix qemu start fail with smp cpu < smp maxcpus on KVM.
e.g '-smp 1,maxcpus=4,sockets=4,cores=1,threads=1'

I 'll send a new patch,

Thanks.
Song Gao.
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_ipi_kvm.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
>> index 4cb3acc921..d0a2f2343f 100644
>> --- a/hw/intc/loongarch_ipi_kvm.c
>> +++ b/hw/intc/loongarch_ipi_kvm.c
>> @@ -23,14 +23,19 @@ static void kvm_ipi_access_regs(void *opaque, 
>> bool write)
>>       LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
>>       IPICore *core;
>>       uint64_t attr;
>> -    int cpu, fd = lis->dev_fd;
>> +    int i, cpu, fd = lis->dev_fd;
>
> While here, we could rename s/cpu/cpu_index/,>
>>       if (fd == 0) {
>>           return;
>>       }
>>   -    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
>
> and declare @i here: for (int i = 0; ...).
>
>> -        core = &ipi->cpu[cpu];
>> +    for (i = 0; i < ipi->num_cpu; i++) {
>> +        core = &ipi->cpu[i];
>> +        if (core == NULL || core->cpu == NULL) {
>> +            continue;
>> +        }
>> +        cpu = core->cpu->cpu_index;
>> +
>>           attr = (cpu << 16) | CORE_STATUS_OFF;
>>           kvm_ipi_access_reg(fd, attr, &core->status, write);


