Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9257C54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0xS-0007v3-Gv; Fri, 15 Mar 2024 02:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rl0xQ-0007uu-5e
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:22:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rl0xN-0001vU-M9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:22:19 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxXesP6fNloF8ZAA--.61429S3;
 Fri, 15 Mar 2024 14:22:07 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxAOUK6fNlz7taAA--.12881S2; 
 Fri, 15 Mar 2024 14:22:05 +0800 (CST)
Subject: Re: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
References: <cover.1710379781.git.lixianglai@loongson.cn>
 <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
 <60733d71-daba-4f4a-a184-357526a3b3a0@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <05a4b109-6e86-6ecf-4399-c0f9d5fd1a6f@loongson.cn>
Date: Fri, 15 Mar 2024 14:22:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <60733d71-daba-4f4a-a184-357526a3b3a0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxAOUK6fNlz7taAA--.12881S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw48urWrWr1rKF47Ww17Arc_yoW5Aw18pr
 1kJrWUGryUJrn5JF13JryUJry5Xr1Ut3WkXr18ZFyUJr4DtrW0grWUXrnFgF1UJr48Jr4U
 Ar1UZry7Zr17GrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.534,
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
> On 3/13/24 15:33, Xianglai Li wrote:
>> +    if (unlikely((level == 0) || (level > 4))) {
>> +        return base;
>> +    }
>> +
>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
>> +            return base;
>> +        } else {
>> +            return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
>> +        }
>> +
>> +        if (unlikely(level == 4)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "Attempted use of level %lu huge page\n", 
>> level);
>> +        }
>
> This block is unreachable, because you've already returned.
> Perhaps it would be worthwhile to add another for the level==0 or > 4 
> case above?
>
A normal level 4 page table should not print an error log,

only if a level 4 page is large, so we should put it in

     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         if (unlikely(level == 4)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Attempted use of level %lu huge page\n", level);
         }

         if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
             return base;
         } else {
             return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
         }
     }


Thanks!

Xianglai.


>> @@ -530,20 +553,34 @@ void helper_ldpte(CPULoongArchState *env, 
>> target_ulong base, target_ulong odd,
>>       CPUState *cs = env_cpu(env);
>>       target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
>>       int shift;
>> -    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
>> +    uint64_t dir_base, dir_width;
>>         base = base & TARGET_PHYS_MASK;
>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +        /*
>> +         * Gets the huge page level and Gets huge page size
>> +         * Clears the huge page level information in the address
>> +         * Clears huge page bit
>> +         */
>> +        get_dir_base_width(env, &dir_base, &dir_width,
>> +                           FIELD_EX64(base, TLBENTRY, LEVEL));
>> +
>> +        FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>> +        FIELD_DP64(base, TLBENTRY, HUGE, 0);
>> +        if (FIELD_EX64(base, TLBENTRY, HG)) {
>> +            FIELD_DP64(base, TLBENTRY, HG, 0);
>> +            FIELD_DP64(base, TLBENTRY, G, 1);
>
> FIELD_DP64 returns a value.  You need
>
>     base = FIELD_DP64(base, ...);
>
>
> r~


