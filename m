Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517CCCD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTxs8-0003p8-31; Mon, 01 Jun 2026 04:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1wTxs1-0003ne-0t
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:19:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1wTxry-0007te-49
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:19:36 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxX+uIQB1qeUQPAA--.42557S3;
 Mon, 01 Jun 2026 16:19:21 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxGOCFQB1qCOCXAA--.25551S3;
 Mon, 01 Jun 2026 16:19:20 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: clear the registers when cpu is reset
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20260529063858.3437928-1-lixianglai@loongson.cn>
 <9ede8d17-2a2c-ce1a-16e8-80fc3e984451@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <1d5aaf66-0a4c-59f4-3f4b-7ea8de0f9c1d@loongson.cn>
Date: Mon, 1 Jun 2026 16:09:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9ede8d17-2a2c-ce1a-16e8-80fc3e984451@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxGOCFQB1qCOCXAA--.25551S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4ftr48GF17Ar1rWF18tFc_yoWrKw4rpr
 18KFWqyry5tr1kAw17Jwn8Jry5Xr18t3WkJw13XFy8Ar1UXr1YqFW0qr1vgr17Aw4rAr4U
 Ar1Dtr4UZF4UArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

Hi Bibo Mao :
> On 2026/5/29 下午2:38, Xianglai Li wrote:
>> Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
>> reset state when the CPU is reset.
> Hi Xianglai,
>
> Thanks for the patch.
>
> Could you add some description how do you find this issue? such as by 
> code reviewing or there is a real problem.
>
OK, I will add some descriptions related to the issue in the next 
version of the patch.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>>
>>   target/loongarch/cpu-csr.h |  7 +++++++
>>   target/loongarch/cpu.c     | 19 ++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index d860417af2..d936af8e57 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -211,6 +211,13 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
>>   #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
>>   #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
>>   +FIELD(CSR_PERFCTRL, EV, 0, 10)
>> +FIELD(CSR_PERFCTRL, PLV0, 16, 1)
>> +FIELD(CSR_PERFCTRL, PLV1, 17, 1)
>> +FIELD(CSR_PERFCTRL, PLV2, 18, 1)
>> +FIELD(CSR_PERFCTRL, PLV3, 19, 1)
>> +FIELD(CSR_PERFCTRL, PMIE, 20, 1)
>> +
>>   /* Debug CSRs */
>>   #define LOONGARCH_CSR_DBG            0x500 /* debug config */
>>   FIELD(CSR_DBG, DST, 0, 1)
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 8f277f7696..7f82c4c46c 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -622,6 +622,7 @@ static void loongarch_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
>>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 0);
>>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 0);
>> +    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, WE, 0);
>>         env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, FPE, 0);
>>       env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, SXE, 0);
>> @@ -633,7 +634,7 @@ static void loongarch_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>       env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, VS, 0);
>>       env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, LIE, 0);
>>   -    env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>> +    env->CSR_ESTAT = 0;
>>       env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, 
>> RBITS, 0);
>>       env->CSR_CPUID = cs->cpu_index;
>>       env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
>> @@ -641,6 +642,22 @@ static void loongarch_cpu_reset_hold(Object 
>> *obj, ResetType type)
>>       env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, 
>> ISTLBR, 0);
>>       env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, 
>> ISMERR, 0);
>>       env->CSR_TID = cs->cpu_index;
>> +
>> +    memset(env->CSR_MSGIS, 0, sizeof(env->CSR_MSGIS));
>> +    env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 0);
>> +    for (n = 0; n < MAX_PERF_EVENTS; n++) {
> how about for (n = 0; n < env.perf_event_num; n++) {  ?
>
OK, I will fix it in the next version of the patch.

Thanks,
Xianglai.

> Regards
> Bibo Mao
>> +        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], 
>> CSR_PERFCTRL,
>> +                                          PLV0, 0);
>> +        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], 
>> CSR_PERFCTRL,
>> +                                          PLV1, 0);
>> +        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], 
>> CSR_PERFCTRL,
>> +                                          PLV2, 0);
>> +        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], 
>> CSR_PERFCTRL,
>> +                                          PLV3, 0);
>> +        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], 
>> CSR_PERFCTRL,
>> +                                          PMIE, 0);
>> +    }
>> +
>>       /*
>>        * Workaround for edk2-stable202408, CSR PGD register is set 
>> only if
>>        * its value is equal to zero for boot cpu, it causes reboot 
>> issue.
>>


