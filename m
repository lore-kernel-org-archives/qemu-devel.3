Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD7D4335A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91ob-00019s-Pn; Thu, 07 Nov 2024 07:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t91oY-00019b-0T
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:40:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t91oV-0002hA-6l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:40:41 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxyuFCtSxnFGE3AA--.45694S3;
 Thu, 07 Nov 2024 20:40:35 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxnkdAtSxnEhNKAA--.1019S3;
 Thu, 07 Nov 2024 20:40:34 +0800 (CST)
Subject: Re: [PATCH v2 5/5] target/loongarch/tcg: Add hardware page table
 walker support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 wangliupu@loongson.cn, yijun@loongson.cn
Cc: maobibo@loongson.cn, philmd@linaro.org
References: <20241010063536.2276871-1-gaosong@loongson.cn>
 <20241010063536.2276871-6-gaosong@loongson.cn>
 <23534a10-ea21-47ee-b31f-0ce9185e6545@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <42da240c-f78e-774c-73ad-37e7b2e05726@loongson.cn>
Date: Thu, 7 Nov 2024 20:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <23534a10-ea21-47ee-b31f-0ce9185e6545@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxnkdAtSxnEhNKAA--.1019S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryfAF43tr18Cr17XFWfCrX_yoW8Xryrpr
 95Gr47JryUJr1rtrsrWr1UZFyjya47A3Z8JrnYqF1FyFsxAry2gr4DWw1q9F1UJr48JF1U
 XF1UXrZ7Zr15J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 q2_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.588,
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

在 2024/11/5 下午10:27, Richard Henderson 写道:
> On 10/10/24 07:35, Song Gao wrote:
>> +        base = get_pte_base(env, address);
>> +
>> +        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
>> +        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>> +        shift = (shift + 1) * 3;
>> +        ptindex = (address >> ptbase) & ((1 << ptwidth) -1);
>> +        ptoffset = ptindex << shift;
>> +        tmp0 = base | ptoffset;
>
> This is a guest virtual address.
>
>> +      retry:
>> +        old_val = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
>
> Fine.
>
>> +        if (old_val != new_val) {
>> +            cur_val = qatomic_cmpxchg((uint64_t *)tmp0, old_val, 
>> new_val);
>
> This uses a host address.  The cast, and the resulting reference, are 
> incorrect.
>
> This is why Arm and x86 structure things differently, using a 
> different tlb index to resolve the host address.  This allows the 
> result to be cached like any other address resolution.
>
> Riscv does something a bit simpler, using address_space_translate to 
> resolve the host address.
>
> Most of the rest of this patch set is going to need review from 
> loongson employees, since I've not seen public documentation in 
> english for this feature.
>
> r~

Hi, Yijun and Wangliupu

Could you guys help review this patch and provide some documentation 
about it?

Thanks.
Song Gao



