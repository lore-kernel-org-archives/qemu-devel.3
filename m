Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4449C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 08:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnDpw-00042q-62; Thu, 21 Mar 2024 04:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rnDpg-00041n-7j; Thu, 21 Mar 2024 04:31:38 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rnDpd-0008Nr-OF; Thu, 21 Mar 2024 04:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711009874; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=FuW58n5UxtdOQUlpaE5I8ecHkdr/LWyJ9sJqO9JqRH4=;
 b=aUocw5LMGXpcB/vFQD/AjjzNVI3PZQIvv9L5k7waGYf/3OGklxzIopVzjJ2vR/7kkCfsCqMgkwWmLCrIGUstBDqr1J0yCb4t4M7TnTqPYnigtn/fnisb0JVownwYourDAfPlwGJRP+BC1ar74bwJla0mGfm2lSBMBgowu0xi7D8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W3-5zGG_1711009872; 
Received: from 30.21.186.11(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W3-5zGG_1711009872) by smtp.aliyun-inc.com;
 Thu, 21 Mar 2024 16:31:13 +0800
Message-ID: <73db23e8-fa6c-425e-bb0b-4db9213bbbbb@linux.alibaba.com>
Date: Thu, 21 Mar 2024 16:31:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix the element agnostic function problem
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20240321035816.99983-1-eric.huang@linux.alibaba.com>
 <ed5675bc-f82b-4d4e-95e4-1a3045dd1870@linaro.org>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <ed5675bc-f82b-4d4e-95e4-1a3045dd1870@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/3/21 16:18, Richard Henderson wrote:
> On 3/20/24 17:58, Huang Tao wrote:
>> In RVV and vcrypto instructions, the masked and tail elements are set 
>> to 1s
>> using vext_set_elems_1s function if the vma/vta bit is set. It is the 
>> element
>> agnostic policy.
>>
>> However, this function can't deal the big endian situation. This 
>> patch fixes
>> the problem by adding handling of such case.
>>
>> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Changes in v2:
>> - Keep the api of vext_set_elems_1s
>> - Reduce the number of patches.
>> ---
>>   target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/target/riscv/vector_internals.c 
>> b/target/riscv/vector_internals.c
>> index 12f5964fbb..3e45b9b4a7 100644
>> --- a/target/riscv/vector_internals.c
>> +++ b/target/riscv/vector_internals.c
>> @@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t 
>> is_agnostic, uint32_t cnt,
>>       if (tot - cnt == 0) {
>>           return ;
>>       }
>> +
>> +#if HOST_BIG_ENDIAN
>> +    /*
>> +     * Deal the situation when the elements are insdie
>> +     * only one uint64 block including setting the
>> +     * masked-off element.
>> +     */
>> +    if ((tot - 1) ^ cnt < 8) {
>> +        memset(base + H1(tot - 1), -1, tot - cnt);
>> +        return;
>> +    }
>
> (1) tot will always be a multiple of 8, afaik, so there's no need for 
> this first block.
> (2) Using if not #if means that the code is always compile-tested, 
> even if it is eliminated.
>
>
> r~

tot is not always be a multiple of 8. In the vector instructions, the 
helper fuinctions will use vext_set_elems_1s to set one masked-off 
element. In that case, tot = cnt + esz, and tot is not the end of a 
vector register.

There is an example in GEN_VEXT_SHIFT_VV:

     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
             vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
             continue;
         }

As for the second point, I will use if instead of #if in the next version.

Thanks,

Huang Tao



