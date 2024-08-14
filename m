Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC706C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 00:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se2MC-0008Op-EN; Tue, 13 Aug 2024 20:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1se2MA-0008NO-0L; Tue, 13 Aug 2024 20:59:18 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1se2M7-0004QV-DF; Tue, 13 Aug 2024 20:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723597145; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=qc9zSGnAkRo6xuD6J8t5C+U/jljFRApyqoH6+UZTs9U=;
 b=tw4vZrybfXWBP9gBfqWRuICfQ6tInqWxlTRRv05WApthzgLBFMXLTrUE9+E+ENkkskLECkyVzF6IDzznb8WCh2yZAweOS7audTHQffdgPMg20yqwrwxyzHVf141fpFlht/gkX6VmAenXjFyobE4p2BNfEcw5nJMEg+flv3QGXXE=
Received: from 30.166.64.117(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCqL5u3_1723597142) by smtp.aliyun-inc.com;
 Wed, 14 Aug 2024 08:59:02 +0800
Message-ID: <1e61235e-1cb8-4bc1-9983-6e8dc0c3b406@linux.alibaba.com>
Date: Wed, 14 Aug 2024 08:58:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] tcg: Fix register allocation constraints
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
 <2efe353a-4700-4632-b919-e43cb039c2c0@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <2efe353a-4700-4632-b919-e43cb039c2c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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


On 2024/8/13 19:52, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>>
>> When allocating registers for input and output, ensure they match
>> the available registers to avoid allocating illeagal registers.
>>
>> We should respect RISC-V vector extension's variable-length registers
>> and LMUL-based register grouping. Coordinate with 
>> tcg_target_available_regs
>> initialization tcg_target_init (behind this commit) to ensure proper
>> handling of vector register constraints.
>>
>> Note: While mov_vec doesn't have constraints, dup_vec and other IRs do.
>> We need to strengthen constraints for all IRs except mov_vec, and this
>> is sufficient.
>>
>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>> Fixes: 29f5e92502 (tcg: Introduce paired register allocation)
>> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
>> ---
>>   tcg/tcg.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index 34e3056380..d26b42534d 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -4722,8 +4722,10 @@ static void tcg_reg_alloc_dup(TCGContext *s, 
>> const TCGOp *op)
>>           return;
>>       }
>>   -    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
>> -    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
>> +    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs &
>> + tcg_target_available_regs[ots->type];
>> +    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs &
>> + tcg_target_available_regs[its->type];
>
> Why would you ever have constraints that resolve to unavailable 
> registers?
>
> If you don't want to fix this in the backend, then the next best place 
> is in process_op_defs(), so that we take care of this once at startup, 
> and never have to think about it again.

Hi Richard,

The constraints provided in process_op_defs() are static and tied to the 
IR operations. For example, if we create constraints for add_vec, the 
same constraints will apply to all types of add_vec operations 
(TCG_TYPE_V64, TCG_TYPE_V128, TCG_TYPE_V256). This means the constraints 
don't change based on the specific type of operation being performed.
In contrast, RISC-V's LMUL (Length Multiplier) can change at runtime 
depending on the type of IR operation. Different LMUL values affect 
which vector registers are available for use in RISC-V. Let's consider 
an example where the host's vector register width is 128 bits:

For an add_vec operation on v256 (256-bit vectors), only even-numbered 
vector registers like 0, 2, 4 can be used.
However, for an add_vec operation on v128 (128-bit vectors), all vector 
registers (0, 1, 2, etc.) are available.

Thus if we want to use all registers of vectors, we have to add a 
dynamic constraint on register allocation based on IR types.

Thanks,
Zhiwei

>
>
> r~

