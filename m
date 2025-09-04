Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73494CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 07:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu4RA-0001Mb-MQ; Thu, 04 Sep 2025 03:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uu4Qy-0001G7-Nk
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 03:31:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uu4Qr-0001Rq-3J
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 03:31:04 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaNEeQLlo2ZAGAA--.13881S3;
 Thu, 04 Sep 2025 15:30:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxocIbQLlo0259AA--.693S3;
 Thu, 04 Sep 2025 15:30:37 +0800 (CST)
Subject: Re: [PATCH v3 03/12] target/loongarch: Reduce TLB flush with
 helper_tlbwr
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-4-maobibo@loongson.cn>
 <fc0eaa0c-252e-4c74-8a2c-ddf0f3b11bb4@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <fa20a13f-b549-274f-6df3-3d26ddb1a9c9@loongson.cn>
Date: Thu, 4 Sep 2025 15:28:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc0eaa0c-252e-4c74-8a2c-ddf0f3b11bb4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocIbQLlo0259AA--.693S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr48uw1DArWkGrWDGryDArc_yoW5GrW7pr
 n7CrWDtFykGrnYyw13Xw15tFy3Zr18WanrXF1SgF15tr47Jr1Igr4kX3sYgFyUJr48JF4U
 tF4Y9r1DZFy7X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY38nU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.65,
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



On 2025/9/3 下午9:07, Richard Henderson wrote:
> On 9/3/25 10:48, Bibo Mao wrote:
>> With function helper_tlbwr(), specified LoongArch TLB entry will be
>> updated. There are two PTE pages in one TLB entry called even/odd
>> pages. Supposing even/odd page is normal/none state, when odd page
>> is added, TLB entry is changed as normal/normal state and even page
>> keeps unchanged.
>>
>> In this situation, it is not necessary to flush QEMU TLB since even
>> page keep unchanged and odd page is newly changed. Here check whether
>> PTE page is the same or not, TLB flush can be skipped if both are the
>> same or newly added.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/tcg/tlb_helper.c | 33 ++++++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/tlb_helper.c 
>> b/target/loongarch/tcg/tlb_helper.c
>> index fcd03ca320..331b485b1a 100644
>> --- a/target/loongarch/tcg/tlb_helper.c
>> +++ b/target/loongarch/tcg/tlb_helper.c
>> @@ -302,16 +302,39 @@ void helper_tlbrd(CPULoongArchState *env)
>>   void helper_tlbwr(CPULoongArchState *env)
>>   {
>>       int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>> +    LoongArchTLB *old, new;
> 
> Perhaps "new = { }", then ...
> 
>> +    new.tlb_misc = 0;
>> +    new.tlb_entry0 = 0;
>> +    new.tlb_entry1 = 0;
> 
> ... this is unnecessary.
yes, this is simpler with { }.  Will do.
> 
>> +    fill_tlb_entry(env, &new);
>> +    /* Check whether ASID/VPPN is the same */
>> +    if (old->tlb_misc == new.tlb_misc) {
>> +        /* Check whether both even/odd pages is the same or invalid */
>> +        tlb_v0 = FIELD_EX64(old->tlb_entry0, TLBENTRY, V);
>> +        tlb_v1 = FIELD_EX64(old->tlb_entry1, TLBENTRY, V);
>> +        if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
>> +            (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
>> +            skip_inv = true;
>> +        }
>> +    }
>> +
>> +    /* flush tlb before updating the entry */
>> +    if (!skip_inv) {
>> +        invalidate_tlb(env, index);
>> +    }
>> +    old->tlb_misc = new.tlb_misc;
>> +    old->tlb_entry0 = new.tlb_entry0;
>> +    old->tlb_entry1 = new.tlb_entry1;
> 
> Perhaps better as "*old = new".
Will do in this way.

Regards
Bibo Mao
> 
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


