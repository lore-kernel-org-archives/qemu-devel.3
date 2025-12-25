Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3DCE784BD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 02:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYbMF-00057s-9N; Wed, 24 Dec 2025 21:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vYbM8-00056B-QO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 21:45:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vYbM4-0007U3-Vf
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 21:45:35 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxjsNIpUxpwAIDAA--.10225S3;
 Thu, 25 Dec 2025 10:45:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDx6+BFpUxpNo4EAA--.13624S3;
 Thu, 25 Dec 2025 10:45:27 +0800 (CST)
Subject: Re: [PATCH v2 3/3] target/loongarch: Fix exception ADEF/ADEM missing
 update CSR_BADV
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20251224031929.2371837-1-gaosong@loongson.cn>
 <20251224031929.2371837-4-gaosong@loongson.cn>
 <06436084-251e-a233-490d-7944ed0f8f41@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3f7e15e7-84a7-6ccb-2216-d6556533c28a@loongson.cn>
Date: Thu, 25 Dec 2025 10:46:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <06436084-251e-a233-490d-7944ed0f8f41@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDx6+BFpUxpNo4EAA--.13624S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr18JFyrCFy7ZF18CrykWFX_yoW8AF17pr
 97Ca4UJryFyr1kJw1xJw4UJFyUWr1UJw1UGr1Uta48Gr45Jry0qr40q3yqgr17Jw4rJw17
 Zr1UJr17ZFW7JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.053,
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

在 2025/12/24 下午5:42, Bibo Mao 写道:
>
>
> On 2025/12/24 上午11:19, Song Gao wrote:
>> Exception ADEM/ADEF need update CSR_BADV, ADEF value from env->pc,
>> ADEM value from the virtual address.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/tcg_cpu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/tcg/tcg_cpu.c 
>> b/target/loongarch/tcg/tcg_cpu.c
>> index c05a06eeb5..53e0970797 100644
>> --- a/target/loongarch/tcg/tcg_cpu.c
>> +++ b/target/loongarch/tcg/tcg_cpu.c
>> @@ -109,10 +109,12 @@ static void loongarch_cpu_do_interrupt(CPUState 
>> *cs)
>>           }
>>           QEMU_FALLTHROUGH;
>>       case EXCCODE_PIF:
>> -    case EXCCODE_ADEF:
>>           cause = cs->exception_index;
>>           update_badinstr = 0;
>>           break;
>> +    case EXCCODE_ADEF:
>> +        update_badinstr = 0;
>> +        QEMU_FALLTHROUGH;
> I think this modification is unnecessary. CSR_BADV is already set with 
> exception EXCCODE_ADEF/EXCCODE_ADEM.
>
I will drop this.

Thanks.
Song Gao
> Regards
> Bibo Mao
>>       case EXCCODE_BCE:
>>           env->CSR_BADV = env->pc;
>>           QEMU_FALLTHROUGH;
>> @@ -225,6 +227,7 @@ static void 
>> loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>>   {
>>       CPULoongArchState *env = cpu_env(cs);
>>   +    env->CSR_BADV = addr;
>>       if (access_type == MMU_INST_FETCH) {
>>           do_raise_exception(env, EXCCODE_ADEF, retaddr);
>>       } else {
>>


