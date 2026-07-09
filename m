Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79BAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whljD-0006cs-RX; Thu, 09 Jul 2026 06:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1whljC-0006cj-JO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:11:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1whlj9-0004UQ-JW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:11:34 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxJOrKc09qRs8BAA--.6235S3;
 Thu, 09 Jul 2026 18:11:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxPsfHc09qJL0GAA--.14284S2;
 Thu, 09 Jul 2026 18:11:21 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
To: Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
 <2b0109e5-6495-8295-564b-fb057fbce108@loongson.cn>
 <0c00bf25-b03d-4b4e-a642-01f55fca7f96@redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d919ab8e-40a4-356a-5e0f-0875ed52eb49@loongson.cn>
Date: Thu, 9 Jul 2026 18:11:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0c00bf25-b03d-4b4e-a642-01f55fca7f96@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPsfHc09qJL0GAA--.14284S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4DXFWkKw1DCr4kGFW8Zrc_yoWrZw15pF
 Z7CF90grWUJ397X3yUKa45ZFyxCr4xX3W2qrnxKFyIyFZrJr1jgr4rXr1q9F97Cw48ur1j
 yryDG3W3uF13JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07j0sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/7/9 下午5:33, Thomas Huth wrote:
> On 09/07/2026 11.08, Bibo Mao wrote:
>>
>>
>> On 2026/7/1 下午2:54, Song Gao wrote:
>>> Validate guest-controlled cpu_num before using it to index the cpu[] 
>>> array
>>> or pass to async_run_on_cpu(). Without this check, a malicious guest can
>>> trigger a NULL pointer dereference in async_run_on_cpu() and an
>>> out-of-bounds array access in qemu_set_irq(), causing host crash.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
>>> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
>>> index c877a8003b..e40292887c 100644
>>> --- a/hw/intc/loongarch_dintc.c
>>> +++ b/hw/intc/loongarch_dintc.c
>>> @@ -19,6 +19,7 @@
>>>   #include "target/loongarch/cpu.h"
>>>   #include "qemu/error-report.h"
>>>   #include "system/hw_accel.h"
>>> +#include "qemu/log.h"
>>>   /* msg addr field */
>>>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>>> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void 
>>> *opaque, hwaddr addr,
>>>       CPUState *cs;
>>>       cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
>>> +
>>> +    /* Validate cpu_num against the configured number of CPUs */
>>> +    if (cpu_num >= s->num_cpu) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "loongarch-dintc: invalid cpu number%d\n", 
>>> cpu_num);
>>> +        return;
>>> +    }
>> Here cpu_num decoded from MSG_ADDR is physical CPU ID, I think that it 
>> is not meaningful to compare it with s->num_cpu.
> 
> Later in this function, cpu_num is used to index into the s->cpu[] array:
> 
>      qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
> 
> and s->cpu is allocated like this in the realize function:
> 
>      s->num_cpu = id_list->len;
>      s->cpu = g_new(DINTCCore, s->num_cpu);
> 
> So the new check here looks valid for me, at least right now. Or what 
> else would you suggest here?

I prefer separate function dintc_cpu_by_arch_id(), this piece of code is 
not tested.

+static int loongarch_dintc_cmp(const void *a, const void *b)
+{
+   DINTCCore *dintc_a = (DINTCCore *)a;
+   DINTCCore *dintc_b = (DINTCCore *)b;
+
+   return dintc_a->arch_id - dintc_a->arch_id;
+}
+
+static int dintc_cpu_by_arch_id(LoongArchDINTCState *s,
+                                int64_t arch_id, int *index, CPUState 
**pcs)
+{
+    DINTCCore dintc, *found;
+
+    dintc.arch_id = arch_id;
+    found = bsearch(&dintc, s->cpu, s->num_cpu, sizeof(DINTCCore),
+                    loongarch_dintc_cmp);
+    if (found && found->cpu) {
+        if (index) {
+            *index = found - s->cpu;
+        }
+
+        if (pcs) {
+            *pcs = found->cpu;
+        }
+
+        return MEMTX_OK;
+    }
+
+    return MEMTX_ERROR;
+}
+
  static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
                                       uint64_t val, unsigned size)
  {
-    int irq_num, cpu_num = 0;
+    int irq_num, cpu_num, ret;
      LoongArchDINTCState *s = LOONGARCH_DINTC(opaque);
      uint64_t msg_addr = addr + VIRT_DINTC_BASE;
      CPUState *cs;
+    uint32_t cpuid;

-    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
-    cs = cpu_by_arch_id(cpu_num);
+    cpuid = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
      irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
+    ret = dintc_cpu_by_arch_id(s, cpuid, &cpu_num, &cs);
+    if (ret != MEMTX_OK || cpu_num >= ipi->num_cpu) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch-dintc: no CPU for arch_id %d\n", cpuid);
+        return;
+    }

      async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
                           RUN_ON_CPU_HOST_INT(irq_num));

Regards
Bibo Mao
> 
>   Thomas
> 
> 
>>>       cs = cpu_by_arch_id(cpu_num);
>> This is ok to use cpu_by_arch_id now, in later when CPU hotplug is 
>> support with dintc, there should be self CPU search logic like ipi 
>> irqchip.
>>
>> Regards
>> Bibo Mao
>>> +    if (!cs) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "loongarch-dintc: no CPU for arch_id %d\n", 
>>> cpu_num);
>>> +        return;
>>> +    }
>>>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>>>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
>>>
>>
> 


