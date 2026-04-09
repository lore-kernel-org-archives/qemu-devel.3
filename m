Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80981E98FB5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAiWY-0006uP-6E; Thu, 09 Apr 2026 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wAiWW-0006u5-9P; Thu, 09 Apr 2026 02:05:52 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wAiWS-0007mV-KE; Thu, 09 Apr 2026 02:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775714738; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=+2eRMK0bbolQD6BTn0BD1C/2iHm2dNdRtiel+Rp75ug=;
 b=n9NaPVp1zYBBJrI3iIMHjnb1xpIyGWU0Ak2Jm6jHe0wzJrUwZDAZwQ1vl+5W2v3RiQqvbkPDnftPzRgBWBiGT6dsgToSw6u5zP/IRQUszCDWKBlege4pRHh7q/CuV4XG1+5fArlcHaTnYEB/ACdKlI7SMBKBaqswRi0FGWoax0M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X0hKfDa_1775714736; 
Received: from 30.166.65.22(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X0hKfDa_1775714736 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Apr 2026 14:05:37 +0800
Message-ID: <0fc9dde4-16a3-425f-9e51-38e892c34008@linux.alibaba.com>
Date: Thu, 9 Apr 2026 14:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
To: Alistair Francis <alistair23@gmail.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-6-alistair.francis@wdc.com>
 <ce3cde01-d4cf-4e01-befb-e9631dcf7757@linux.alibaba.com>
 <CAKmqyKPcK4_o06geCsganH8h8yV80TfxPSzsuDY=nOsU7a2B6g@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKPcK4_o06geCsganH8h8yV80TfxPSzsuDY=nOsU7a2B6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 4/9/26 1:32 PM, Alistair Francis wrote:
> On Tue, Apr 7, 2026 at 10:13 PM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> Hi Alistair,
>>
>> On 4/7/26 12:36 PM, alistair23@gmail.com wrote:
>>
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> The RISC-V spec states that
>>
>> """
>> For a given supported fractional LMUL setting, implementations
>> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
>> """
>>
>> I think the meaning  of "must support"  in specification is "must at least support" instead of "must only support".
> Good point, I didn't really think about that.
>
>> Sail or Spike have the same check as this patch to prevent user program can run on them, but
>> can't run on RTLs, as RTLs implementation may support SEW besides the  SEWMIN and LMUL * ELEN range.
>>
>> We can refer to discussion here: https://github.com/riscv-software-src/riscv-isa-sim/pull/620
> I think this is still the right fix, as it seems like it's unlikely
> there will be implementations that expect outside that minimum support
> to work, see https://github.com/riscv/riscv-isa-manual/issues/2359#issuecomment-3458627615
> for example.
Make sense.
>
>> In my opinion, we had better add a option such as "frac_sew_check" to make user set right value for their RTL implementation.
> In future if there are implementations that want extra support that we
> can add a property.
Agree.
> Right now I suspect there isn't any software that
> expects it to work, so it probably isn't an issue and will help catch
> faulty implementations.

Some RTLs can issue more vector instructions one cycle when lmul = 1/2 
than lmul = 1. It is useful for some workloads, such as H264, which 
typical calculation unit is 128 bit.
If vlen is 256bit, software can set lmul to 1/2 (64bit sew is allowed by 
specification, but forbidden by this patch) to issue more vector 
instructions one cycle for this type workload.

Standard software should use this feature by vsetvl and vill detection.  
So it should also work with this patch.

Thanks,
Zhiwei

>
> Alistair
>
>> Otherwise,
>> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>
>> Thanks,
>> Zhiwei
>>
>> We were previously checking VLEN, instead of ELEN, so let's update to
>> check ELEN instead of VLEN for fractional scaling.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/vector_helper.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 83dd26314d..b4fc791eb7 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>>       target_ulong reserved = s2 &
>>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>> -    uint16_t vlen = cpu->cfg.vlenb << 3;
>>       int8_t lmul;
>>
>>       if (vlmul & 4) {
>>           /*
>>            * Fractional LMUL, check:
>>            *
>> -         * VLEN * LMUL >= SEW
>> -         * VLEN >> (8 - lmul) >= sew
>> -         * (vlenb << 3) >> (8 - lmul) >= sew
>> +         * ELEN * LMUL >= SEW
>> +         * ELEN >> (8 - vlmul) >= sew
>>            */
>> -        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
>> +        if (vlmul == 4 ||
>> +            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
>>               vill = true;
>>           }
>>       }

