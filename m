Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03997C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQND-00077m-MG; Tue, 23 Jul 2024 21:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sWQNA-00076p-Dj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:00:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sWQN5-0007lT-JM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:00:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxW+o4UqBmh74AAA--.2942S3;
 Wed, 24 Jul 2024 09:00:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMc1UqBmAIxWAA--.60723S3; 
 Wed, 24 Jul 2024 09:00:39 +0800 (CST)
Subject: Re: [PULL 2/3] target/loongarch: Fix tlb huge page loading issue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240320024010.1659193-1-gaosong@loongson.cn>
 <20240320024010.1659193-3-gaosong@loongson.cn>
 <CAFEAcA_8TvbqwUhDsvZm+oi0mj2zGbkFmMuKO+cFqAX-dm5S-g@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <15e258e6-dc19-5c93-13d1-98af2c601298@loongson.cn>
Date: Wed, 24 Jul 2024 09:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8TvbqwUhDsvZm+oi0mj2zGbkFmMuKO+cFqAX-dm5S-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxDMc1UqBmAIxWAA--.60723S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1kJr43GF4fAF1kur1Utwc_yoW8tF45pF
 WfAanxGF4DtFy7GFsxX34vkr13Zr97GFZ7ZrW0yry0k34qyF93WrW8trWayFy7AF1Fka1I
 vrZrtFy7Can5WFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.04,
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

在 2024/7/23 下午11:47, Peter Maydell 写道:
> On Wed, 20 Mar 2024 at 02:40, Song Gao <gaosong@loongson.cn> wrote:
>> From: Xianglai Li <lixianglai@loongson.cn>
>>
>> When we use qemu tcg simulation, the page size of bios is 4KB.
>> When using the level 2 super huge page (page size is 1G) to create the page table,
>> it is found that the content of the corresponding address space is abnormal,
>> resulting in the bios can not start the operating system and graphical interface normally.
>>
>> The lddir and ldpte instruction emulation has
>> a problem with the use of super huge page processing above level 2.
>> The page size is not correctly calculated,
>> resulting in the wrong page size of the table entry found by tlb.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240318070332.1273939-1-lixianglai@loongson.cn>
> Hi; Coverity points out an issue with this patch (Coverity
> CID 1547717):
>
>
>> @@ -485,7 +513,25 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>>       target_ulong badvaddr, index, phys, ret;
>>       int shift;
>>       uint64_t dir_base, dir_width;
>> -    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>> +
>> +    if (unlikely((level == 0) || (level > 4))) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "Attepted LDDIR with level %"PRId64"\n", level);
>> +        return base;
>> +    }
>> +
>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +        if (unlikely(level == 4)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "Attempted use of level 4 huge page\n");
> Here we log level == 4 as being a guest error, but there is no
> early "return <something>" the way the previous error-exit
> codepath did above...
>
>> +        }
>> +
>> +        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
>> +            return base;
>> +        } else {
>> +            return FIELD_DP64(base, TLBENTRY, LEVEL, level);
> ...so Coverity complains that here we will try to put that value 4
> into a field in the TLBENTRY that is only 2 bits wide.
>
>> +        }
>> +    }
> Should the level == 4 if() do a "return base" like the
> error cases for level == 0 or > 4 ?
Yes,  we should,  I will send a patch to fix it.

Thanks.
Song Gao


