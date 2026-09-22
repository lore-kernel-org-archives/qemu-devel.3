Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA11BC982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8pQX-000125-Uo; Mon, 21 Sep 2026 21:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x8pQV-00011x-Eb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 21:36:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x8pQS-0002uv-58
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 21:36:07 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxb9N_27Fqu3wOAA--.42251S3;
 Tue, 22 Sep 2026 09:35:59 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxxMx627FqT5MjAA--.48739S2;
 Tue, 22 Sep 2026 09:35:54 +0800 (CST)
Subject: Re: [PATCH v2 RESEND] tcg/loongarch: strip flag bits in lddir/ldpte
 address calculation
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 numpy1314 <xzj13@mail.ustc.edu.cn>
References: <20260920024217.18116-1-prcups@krgm.moe>
 <7c9246fb-3a0d-268c-1540-ddc05a71a927@loongson.cn>
 <MJ6h21vjTT6CIdZq9lG7Dg@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e296151c-aa91-52fc-8594-594a159223db@loongson.cn>
Date: Tue, 22 Sep 2026 09:35:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MJ6h21vjTT6CIdZq9lG7Dg@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMx627FqT5MjAA--.48739S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryDZr4rCFy5tw18GFW3Jwc_yoW5Wr13pF
 WxCa1ak3Wrtryvyan29a4YvF1jva4DGw4UXw10kryrCwn0qF1xZF48trW5KF18Xw43Zr4x
 ZFnIvFW7ZFyUZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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



On 2026/9/21 下午12:17, SignKirigami wrote:
> On 2026年9月20日星期日 中国标准时间 11:48:53，Bibo Mao wrote：
>>
>> On 2026/9/20 上午10:42, SignKirigami wrote:
>>> helper_lddir and helper_ldpte used TARGET_PHYS_MASK (bits 0-47) when
>>> extracting the base address from a directory entry.  This retained flag
>>> bits (V, D, PLV, MAT, etc.) at positions 0-11, which were then OR'd
>> For LoongArch, what is scenery with DIR/PTE entry where bit0-bit11 such
>> as (V, D, PLV, MAT, etc.) is used, except Huge bit?
>>
>> Regards
>> Bibo Mao
> This patch is originally from rcore developers, and it seems to be hardware's
> responsibility to clear 0-11 bits.
Could you show me the web link how hardware clears 0-11 bits with 
LDDIR/LDPTE instruction?

Regards
Bibo Mao

> Regards
> SignKirigami
>>> with the next-level index, producing a wrong physical address whenever
>>> the directory entry carried non-zero flags.
>>>
>>> Fix both helpers to extract only the PPN field (bits 12-47) before
>>> computing the address of the next-level page table entry.
>>>
>>> Signed-off-by: numpy1314 <xzj13@mail.ustc.edu.cn>
>>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>>> ---
>>> This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
>>>    
>>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05581.html.
>>>    
>>>    target/loongarch/tcg/tlb_helper.c | 7 ++-----
>>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
>>> index 40cc076424..529b22347d 100644
>>> --- a/target/loongarch/tcg/tlb_helper.c
>>> +++ b/target/loongarch/tcg/tlb_helper.c
>>> @@ -750,7 +750,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>>>        }
>>>    
>>>        badvaddr = sys->CSR_TLBRBADV;
>>> -    base = base & palen_mask;
>>> +    base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
>>>        get_dir_base_width(env, &dir_base, &dir_width, level);
>>>        index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>>>        phys = base | index << 3;
>>> @@ -773,7 +773,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>        uint64_t dir_base, dir_width;
>>>        uint8_t  ps;
>>>    
>>> -
>>>        /*
>>>         * The parameter "base" has only two types,
>>>         * one is the page table base address,
>>> @@ -815,9 +814,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>            }
>>>        } else {
>>>            badv = sys->CSR_TLBRBADV;
>>> -
>>> -        base = base & palen_mask;
>>> -
>>> +        base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
>>>            ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
>>>            ptindex = ptindex & ~0x1;   /* clear bit 0 */
>>>            ptoffset0 = ptindex << 3;
>>>
>>
>>
> 
> 
> 


