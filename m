Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1913C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 03:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjsvj-0000c2-Jq; Mon, 11 Mar 2024 23:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rjsvh-0000bo-9H
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 23:35:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rjsvd-0003nR-TM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 23:35:52 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxuuiEze9lUW0XAA--.37663S3;
 Tue, 12 Mar 2024 11:35:33 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_xOBze9l_8hWAA--.3632S2; 
 Tue, 12 Mar 2024 11:35:31 +0800 (CST)
Subject: Re: [PATCH V3 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 wuruiyang@loongson.cn
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn
References: <cover.1709796364.git.lixianglai@loongson.cn>
 <de249feeab14b46d4b7bd842335a4e6e4b654681.1709796364.git.lixianglai@loongson.cn>
 <167331cd-068b-470f-b08c-6687e426bd15@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <9b475a8e-e628-91ba-2909-869ddb013811@loongson.cn>
Date: Tue, 12 Mar 2024 11:35:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <167331cd-068b-470f-b08c-6687e426bd15@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx_xOBze9l_8hWAA--.3632S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWUGFyktFW8AF1kKF4kAFc_yoWxtFW8pF
 4kGrW3AryUJryvyr1UGw1UJry5Xr4jyw4DJr1UtFyjvw1UJry0gr4UWrnF9r17Jr48JF48
 Zr17tr1DZr13GrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.065,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard:
>
>> @@ -495,30 +508,10 @@ target_ulong helper_lddir(CPULoongArchState 
>> *env, target_ulong base,
>>       shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>>       shift = (shift + 1) * 3;
>>   -    if (huge) {
>> -        return base;
>> -    }
>> -    switch (level) {
>> -    case 1:
>> -        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
>> -        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
>> -        break;
>> -    case 2:
>> -        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
>> -        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
>> -        break;
>> -    case 3:
>> -        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
>> -        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
>> -        break;
>> -    case 4:
>> -        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
>> -        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
>> -        break;
>> -    default:
>> -        do_raise_exception(env, EXCCODE_INE, GETPC());
>> +    if (get_dir_base_width(env, &dir_base, &dir_width, level) != 0) {
>>           return 0;
>>       }
>
> I believe that we should not raise an exception here at all.  This 
> illegal instruction exception is based on the LDDIR immediate operand, 
> so we should have diagnosed this error and raised an exception in 
> trans_lddir().

After consulting the hardware technician, when the level value is 
greater than 4,

the hardware does not report an exception, we can check the level in 
helper_lddir,

if the parameter is not valid, we will directly return to base,

and it is not reasonable to check the validity of the immediate number 
in trans_lddir.

The actual action should be implemented in the instruction 
simulation,and the log should be printed and recorded,

like this:

target_ulong helper_lddir( )

{

     if ((level == 0) || (level > 4)) {

        qemu_log_mask(LOG_GUEST_ERROR, "Illegal instruction level 
%lu\n",  level);

         return base;

     }

......

}

>
> Therefore the default label should use only g_assert_not_reached(), 
> and there need not be a error return from get_dir_base_width at all.
>
>
>> @@ -534,17 +527,38 @@ void helper_ldpte(CPULoongArchState *env, 
>> target_ulong base, target_ulong odd,
>>       bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
>> +    uint64_t dir_base, dir_width;
>> +    uint64_t huge_page_level;
>>         base = base & TARGET_PHYS_MASK;
>>         if (huge) {
>> -        /* Huge Page. base is paddr */
>> +        /*
>> +         * Gets the huge page level
>> +         * Clears the huge page level information in the address
>> +         * Clears huge page bit
>> +         * Gets huge page size
>> +         */
>> +        huge_page_level = (base & HUGE_PAGE_LEVEL_MASK) >>
>> +                          HUGE_PAGE_LEVEL_SHIFT;
>> +
>> +        base &= ~HUGE_PAGE_LEVEL_MASK;
>> +
>>           tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
>>           /* Move Global bit */
>>           tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
>>                   LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
>>                   (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
>> -        ps = ptbase + ptwidth - 1;
>> +
>> +        huge_page_level++;
>
> Why are you incrementing the level?

level plus 1 is to obtain the dir_base of the upper level,

because I directly use the dir_base of the upper level as the size of 
the huge page when calculating the page size,

this practice is different from the hardware implementation,

the hardware implementation is explained below,

the next version I will refer to the hardware implementation method to 
calculate the size of the huge page.

>
> I think you want
>
>     level = MIN(level, 1);
>
> Google translates the documentation for LDPTE as "bits [14:13] ... 
> should be a non-zero value".  I don't know if "should" is precisely 
> correct here (english technical documents prefer "shall" or "may" to 
> indicate a hard requirement vs optional behaviour). The document does 
> not appear to say what happens if the value is zero.
>

After consulting hardware technicians, LDPTE uses dir_base + dir_width 
corresponding to [14..13]bits as the page size,

and when [14..13]bits is 0, the page size should be PTbase + PTwidth.

So [14..13]bits can be zero and we should revise the manual.

And The get_dir_base_width function plans to add the handling of case 0,

so that get_dir_base_width will not receive illegal level arguments when 
ldpte,

and because of the validity of the level at the entry of the lddir 
function,

the get_dir_base_width function will not receive illegal level arguments.

So you will not receive level == 0 and level > 4:


static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level)
{
     switch (level) {
     case 0:
         *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
         *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
         break;
     case 1:
         *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
         *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
         break;
     case 2:
         *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
         *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
         break;
     case 3:
         *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
         *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
         break;
     case 4:
         *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
         *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
         break;
     default:
         g_assert_not_reached();
     }
}


> Since an earlier version of the specification did not have bits 
> [14:13], my suspicion is that the the current version of the 
> specification is intended to be compatible, which would map [14:13] == 
> 0 to level == 1.
>
> In any case, incrementing the level such that [14:13] == 1 -> level == 
> 2 definitely seems wrong.
>
>
> r~


