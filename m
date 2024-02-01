Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B59DC47DB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 01:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVLiF-0006qS-V9; Wed, 31 Jan 2024 20:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rVLiD-0006qK-Kj
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 20:17:53 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rVLiA-0007Pn-Ev
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 20:17:53 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax++g48bplg0MJAA--.7890S3;
 Thu, 01 Feb 2024 09:17:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVMw18bpl_RorAA--.39327S3; 
 Thu, 01 Feb 2024 09:17:43 +0800 (CST)
Subject: Re: [PATCH] tcg: Fixes set const_args[i] wrong value when
 instructions imm is 0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@redhat.com, git@xen0n.name, maobibo@loongson.cn
References: <20240131072740.2569850-1-gaosong@loongson.cn>
 <70186760-61be-4b44-8c0f-eb6acb4587f2@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5e5215e4-5d91-b113-3889-2e617af42f40@loongson.cn>
Date: Thu, 1 Feb 2024 09:17:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <70186760-61be-4b44-8c0f-eb6acb4587f2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxVMw18bpl_RorAA--.39327S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw48Aw4xAr1DXF1rJFWUAwc_yoW8Ar4rpr
 4kta48GFyYkrs5Xr4UKryUWryUGr48tw1DAr1kXa4qyrZ8Jr1vqFW5WF4jgFy8JFWkAr1U
 Ar1jvrnrZFyDAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.281,
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

在 2024/2/1 上午5:16, Richard Henderson 写道:
> On 1/31/24 17:27, Song Gao wrote:
>> It seems that tcg_reg_alloc_op() set const_args[i] wrong value
>> when instructions imm is 0. The LoongArch tcg_out_vec_op() cmp_vec
>> use the wrong const_args[2].
>> e.g
>>     The wrong const_args[2] is 0.
>>     IN: vslti.w v5, v4, 0x0   OUT: vslt.w  v1, v1, v0
>>
>>     The right const_args[2] is 1.
>>     IN: vslti.w v5, v4, 0x0   OUT: vslti.w v1, v1, 0x0
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2136
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   tcg/tcg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index e2c38f6d11..5b290123bc 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -4808,7 +4808,7 @@ static void tcg_reg_alloc_op(TCGContext *s, 
>> const TCGOp *op)
>>           arg_ct = &def->args_ct[i];
>>           ts = arg_temp(arg);
>>   -        if (ts->val_type == TEMP_VAL_CONST
>> +        if ((ts->val_type == TEMP_VAL_CONST || ts->kind == TEMP_CONST)
>>               && tcg_target_const_match(ts->val, ts->type, 
>> arg_ct->ct, TCGOP_VECE(op))) {
>>               /* constant is OK for instruction */
>>               const_args[i] = 1;
>
> This is wrong.
>
> I strongly suspect that the TEMP_CONST value 0 has been loaded into a 
> register for use in another operation, and the register allocator sees 
> that it is still there.
>
Ah, I'm not familiar with this piece of code,  I just try to fix the bug,
and thanks for your suggestion.

Thanks.
Song Gao
>
> r~


