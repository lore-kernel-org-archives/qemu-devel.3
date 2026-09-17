Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355A5C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jyr-0000WA-WD; Thu, 17 Sep 2026 17:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jyk-0000VE-AO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:49:14 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jyi-000283-13
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:49:13 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469a34908so128836b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681750; x=1790286550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6oQHcoELX0fMS4pTkpsgmaooO/x8cXFYbN32QAxzfT0=;
 b=hNxpollli0LfCxUA14jZFQFRSXsfkNdrLwPPiYguUa3MUrRk/KZctT/RQwYMHv7vIJ
 ey5HrDJ8aFUBhk6WhQBmk9E3y6R8j+iiQlC7ailvT/LA62RxmxDJJGwZ3G4AS8Wj0BPQ
 qb/677z7rMpMrey1u/jqCUSAjAtSIZF8GA0xQceBPcynrJ7jsSQ6iRtyFSnjxCSiWz9M
 3tv90fD45wdEjoycxns3o9SEz4G2gBzAV/02QII3UQSynAxmeCmbZV21jzrba+nCSbQ8
 BOiFyQrPLE4hESuVgvUgL89hcWIFt5O75pj+irrEt/y6M0YC22irBU3giYu4BOWc4rZP
 OLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681750; x=1790286550;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6oQHcoELX0fMS4pTkpsgmaooO/x8cXFYbN32QAxzfT0=;
 b=PhpBWn/zgGY47OmWGSYYBvCwXz2cH6zu1bgTEiBAdINSRSCu0QYQItu0dMjGtI9qI6
 XGK4Rgse3pwiZqbpgI07yGS+aJ1nAeGmU4YTOJm9pgPL7OGEYsaKBhSADn8+8VFuXA/E
 4H05oweB6Pz0VnGawkHlbD9f8dJMNOuu/1UgHJpLt+TohJ6Xd0OPF5l7R4sG0+IXSeFM
 xH+7E+BmFJL26mD9CpDymQOeWBb70s3xu5c9p338wznyEK6pqDM5YguBj+zldhTW0iBl
 5A+jtUdJ+lC18Zbv71bYs3ObNd2wIUQfqXiDYsA/MFjy4ioeqYbvyv2fjYqM5731LI9L
 RC7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXuyZHMYbM1+CHu1nTBcKPiPK48z7LunPvQ9x3iph4KcTlth9x5VFXih4NTY7LtvktrGgLk9P8I4J2@nongnu.org
X-Gm-Message-State: AFuF++lRT0ayKsfTJC6Du1UwliyH6O7AKBE0Cs2DbIDn+B05XJlE3XHv
 xsdvmGeiRCHNjvOdU6j5EfJz7HfTsMZu8v3w3MdTTH51S4c2Jyr3lNSGVabxjngV9a4=
X-Gm-Gg: AYBFou3qhihKm40MdCFYOaAu1SC0wFt2gx+6itQKeJbBPPMmB8bHw7cJBLgBXw6bv+x
 p1RIBve8CT+QbBIFjkFHe5BAMfrhdmXy7DZeC1ecPPyw6EM7SByz0BPTPKLMLzFxo4qi5/I7JbW
 LVeKwUgUZUqHj+RdFtMqmdyz+WzXa3omdhuxaGr48Zb+shu+sFE3V6RQ/Z6VkGS7oXyTfLAatL5
 uLYOa1fqub+HhZT6Cw8RK4u6yCpi3xaICmZSMwBjlOVfEG55jhOpNKx5emF2414V09zii7ZKldn
 uQlLiuv/XHKgFOsvbTBHzYgsAX6YPQh2nP/RIyn4W2fTWAu1N5uOBZzwEJlyIkSOEF76RDq8CIV
 a+RE0UNiQu1bJGM3z7Cq5141UNo3sGoIQVs+aim6pueEf7GWLgRNLYwy2XuWaMRkyp9w0dXKNPr
 LUbrMDlJg9r6D8b3+aF6IAMVjjI8oYZy5WZOu5wWC2G5iNZmrzSFro/00v50EtX6yE3yvolEta6
 Zexw93TmVMvt6bGVkNoTvr5azI5QJ+TM9SJSL7ooxq8TM2ktqdDaNAnCetVcg==
X-Received: by 2002:a05:6a20:e293:b0:3dd:85a9:55a4 with SMTP id
 adf61e73a8af0-3dd8c59e06amr539494637.29.1789681750167; 
 Thu, 17 Sep 2026 14:49:10 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5a4b:653b:1dce:569f?
 ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c00ede586sm14879319eec.10.2026.09.17.14.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 14:49:09 -0700 (PDT)
Message-ID: <1f02f0fc-fee2-4722-9798-97bb0132561d@linaro.org>
Date: Thu, 17 Sep 2026 11:49:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/riscv64: Set vtype before whole-register vector
 moves
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: max.chou@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 daniel.barboza@oss.qualcomm.com, joel@jms.id.au
References: <mhng-F8D5674F-046D-44A0-8196-38EDF98E50C3@Palmers-Mini.rwc.dabbelt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <mhng-F8D5674F-046D-44A0-8196-38EDF98E50C3@Palmers-Mini.rwc.dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/17/26 10:59, Palmer Dabbelt wrote:
> On Thu, 17 Sep 2026 13:51:10 PDT (-0700), Richard Henderson wrote:
>> On 9/17/26 03:37, Max Chou wrote:
>>> According to the RISC-V unpriviledge spec,
>>>    "vset{i}vl{i} and whole register loads and stores do not depend upon
>>>     vtype."
>>> The whole-register vector move instructions reuqire legal vtype that
>>> trap when VILL is set.
>>>
>>> The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting 
>>> the
>>> OPC_VMVNR_V.
>>>
>>> Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Signed-off-by: Max Chou <max.chou@sifive.com>
>>> ---
>>>   tcg/riscv64/tcg-target.c.inc | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
>>> index 2ce9d47a633..e3cfedb579d 100644
>>> --- a/tcg/riscv64/tcg-target.c.inc
>>> +++ b/tcg/riscv64/tcg-target.c.inc
>>> @@ -778,6 +778,10 @@ static bool tcg_out_mov(TCGContext *s, TCGType 
>>> type, TCGReg ret, TCGReg arg)
>>>           {
>>>               int lmul = type - riscv_lg2_vlenb;
>>>               int nf = 1 << MAX(lmul, 0);
>>> +
>>> +            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
>>> +                set_vtype_len(s, type);
>>> +            }
>>>               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
>>>           }
>>>           break;
>>
>> Do you have a reproducer for this?  I ask because I still wonder how
>> this can occur.
>>
>> Given that
>>
>> (1) all vector registers are call-clobbered, there should be none live
>> across tcg_out_call_int (which clears the remembered vtype),
>>
>> (2) the first vector action with no vector registers live must be a load
>> or movi (which will initialize vtype).
>>
>> Performing a move between vector registers when all such registers must
>> be dead is... wrong.  It indicates that there's a bug elsewhere.
> 
> I'm not quite sure the commit message is right here, but this whole area 
> is a bit of a landmine: one of the post-ratification changes to V was 
> either this (or very close to this), so we've been through it for every 
> project.
> 
> Here's the LLVM thread, which I think has links to everything else: 
> https://github.com/llvm/llvm-project/issues/114518 (there's a GCC change 
> as well).  IIRC hardware is a bit all over the place on this one, for 
> the compilers we decided to just emit the code that's safe either way -- 
> that's not really an option for QEMU, though, so we'll have to pick one 
> side or the other.
Yes, I get that.  But my point stands that after a function call (which 
can set VILL), all vector registers should be dead.  A move of a dead 
register is itself a bug.

There should have been *something* that brought the source vector 
register back to life: a load or a movi.  Both of which reinitialize vtype.

That's why I'd like to see a reproducer, or if there isn't one,

     tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);

I'm currently running the assert through the testsuite to make sure I've 
not gone loopy.


r~

