Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F067C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjvRx-0002U0-GV; Wed, 15 Jul 2026 04:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wjvRw-0002Tr-08
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:58:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wjvRt-0004a9-5R
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:58:39 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxReq2S1dqibkDAA--.13674S3;
 Wed, 15 Jul 2026 16:58:30 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxu8S1S1dqLr4NAA--.13424S2;
 Wed, 15 Jul 2026 16:58:29 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: fix data race in CSR_ESTAT
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xi Ruoyao <xry111@xry111.site>
References: <20260714-loong-race-v1-1-54111549c95e@gmail.com>
 <fc1b3da5-2433-7f23-03c4-c1d0a0b5a6f4@loongson.cn>
 <7FF8CCC1-5065-45E0-8EB8-B414F5C87056@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <877f6ddf-a012-bfe9-d667-c443a23d1841@loongson.cn>
Date: Wed, 15 Jul 2026 16:58:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7FF8CCC1-5065-45E0-8EB8-B414F5C87056@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxu8S1S1dqLr4NAA--.13424S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr13JFWDtw1kWr1fXw4rXrc_yoW8KFyfpa
 y7C3Z8Jr4kXF1DA347K3WFyrs0vr13WF4F9393K3s5Cr1DGr15Xr17tF9IvF9F9ryfWw10
 vr4FvayUua4DAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07jOF4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.494,
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



On 2026/7/15 下午4:29, Miao Wang wrote:
> Hi,
> 
>> 2026年7月15日 11:16，Bibo Mao <maobibo@loongson.cn> 写道：
>>
>>
>>
>> On 2026/7/14 下午11:40, Miao Wang via B4 Relay wrote:
>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>> The CSR_ESTAT register of a CPU can be read and written by both the
>>> CPU thread and other threads (e.g., the interrupt controller thread).
>>> Currently the possible readers and writers of CSR_ESTAT are:
>>> - Readers
>>>    - tcg generated by trans_csrrd(, CSR_ESTAT)
>>>    - loongarch_cpu_has_work()
>>> - Writers
>>>    - tcg generated by trans_csrxchg(, CSR_ESTAT)
>>>    - helper_csrwr_estat()
>>>    - helper_csrrd_msgir()
>>>    - loongarch_cpu_set_irq()
>>>    - loongarch_cpu_do_interrupt()
>>>    - loongarch_cpu_exec_interrupt()
>>
>> yes, there is contention problem when injecting interrupt to vCPU in TCG mode, only that it is a little strange to use atomic method on CSR estat register.
>>
>>  From another side, only loongarch_cpu_set_irq() is called from other threads, the other APIs are called from vCPU thread itself.
>>
>> How about using method like KVM, adding software state irq_pending/irq_clear in structure CPULoongArchState and using atomic method, add cpu_sync_interrupt() and it is called function
>> cpu_loongarch_hw_interrupts_pending(). When vCPU thread is kicked with new interrupt and executes cpu_loongarch_hw_interrupts_pending(), it synchronize software intterupt irq_pending/irq_clear  to CS ESTAT register.
>>
> 
> I understand that adding an additional field which is protected by atomic
> operations to store the pending changes to ESTAT in loongarch_cpu_set_irq()
> and merging it into ESTAT afterwards in cpu_loongarch_hw_interrupts_pending()
> is simpler and cleaner.
> 
> However, there might be a problem here. In loongarch_cpu_set_irq(), without
> reading ESTAT, it cannot decide whether to call cpu_interrupt() or
> cpu_reset_interrupt(). If ESTAT should be read in loongarch_cpu_set_irq(), then
> ESTAT should still be protected by atomic operations.
Is it ok to judge from software pending interrupt rather than ESTAT? 
something like this,
  if (level == 1) {
     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
  } else if (!env->pending_int) {
     cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
  }

Regards
Bibo Mao
> 
> Cheers,
> 
> Miao Wang
> 


