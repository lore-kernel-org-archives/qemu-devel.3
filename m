Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C80BEDE996
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 02:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snquw-0002Zt-8q; Mon, 09 Sep 2024 22:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqus-0002Yk-Ab; Mon, 09 Sep 2024 22:47:42 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqup-0007Uh-JU; Mon, 09 Sep 2024 22:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725936447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Cw4y96nAE3KcQg6JNpx6s09fmsWAH0zBtKoq2RifKtA=;
 b=sYtKF4RApb8in/kBwyylY+BfL7SqpRyvGI+Qeo98G8Ect8tQHd4uBVAkn8dKpp4WW/0+I9kLiUL6BBQVEm35DXkfFYpJ61q/YSeIA2NknmFEdOYDn9fvkZp8hyXU+GEhXw2rhH/6EETQ92O2Q2cAl6Ju25wOf77g3FX9H7JI40Q=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEiiQNB_1725936443) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 10:47:23 +0800
Message-ID: <ca6c39e0-0b29-4dff-9e89-93db342ae9af@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] tcg/riscv: Add riscv vset{i}vli support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-5-zhiwei_liu@linux.alibaba.com>
 <efa2bcd4-3ed6-4943-8dee-f764ee5afe87@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <efa2bcd4-3ed6-4943-8dee-f764ee5afe87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/9/5 14:03, Richard Henderson wrote:
> On 9/4/24 07:27, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> In RISC-V, vector operations require initial configuration using
>> the vset{i}vl{i} instruction.
>>
>> This instruction:
>>    1. Sets the vector length (vl) in bytes
>>    2. Configures the vtype register, which includes:
>>      SEW (Single Element Width)
>>      LMUL (vector register group multiplier)
>>      Other vector operation parameters
>>
>> This configuration is crucial for defining subsequent vector
>> operation behavior. To optimize performance, the configuration
>> process is managed dynamically:
>>    1. Reconfiguration using vset{i}vl{i} is necessary when SEW
>>       or vector register group width changes.
>>    2. The vset instruction can be omitted when configuration
>>       remains unchanged.
>>
>> This optimization is only effective within a single TB.
>> Each TB requires reconfiguration at its start, as the current
>> state cannot be obtained from hardware.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Signed-off-by: Weiwei Li <liwei1518@gmail.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   include/tcg/tcg.h          |   3 +
>>   tcg/riscv/tcg-target.c.inc | 128 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 131 insertions(+)
>>
>> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
>> index 21d5884741..267e6ff95c 100644
>> --- a/include/tcg/tcg.h
>> +++ b/include/tcg/tcg.h
>> @@ -566,6 +566,9 @@ struct TCGContext {
>>         /* Exit to translator on overflow. */
>>       sigjmp_buf jmp_trans;
>> +
>> +    /* For host-specific values. */
>> +    int riscv_host_vtype;
>>   };
>
> (1) At minimum this needs #ifdef __riscv.
>     I planned to think of a cleaner way to do this,
>     but haven't gotten there yet.
>     I had also planned to place it higher in the structure, before
>     the large temp arrays, so that the structure offset would be smaller.
>
> (2) I have determined through experimentation that vtype alone is 
> insufficient.
>     While vtype + avl would be sufficient, it is inefficient.
>     Best to store the original inputs: TCGType and SEW, since that way
>     there's no effort required when querying the current SEW for use in
>     load/store/logicals.
>
>     The bug here appears as TCG swaps between TCGTypes for different
>     operations.  E.g. if the vtype computed for (V64, E8) is the same
>     as the vtype computed for (V128, E8), with AVL differing, then we
>     will incorrectly omit the vsetvl instruction.
>
>     My test case was tcg/tests/aarch64-linux-user/sha1-vector
>
Agree.
>
> The naming of these functions is varied and inconsistent.
> I suggest the following:
>
>
> static void set_vtype(TCGContext *s, TCGType type, MemOp vsew)
> {
>     unsigned vtype, insn, avl;
>     int lmul;
>     RISCVVlmul vlmul;
>     bool lmul_eq_avl;
>
>     s->riscv_cur_type = type;
>     s->riscv_cur_vsew = vsew;
>
>     /* Match riscv_lg2_vlenb to TCG_TYPE_V64. */
>     QEMU_BUILD_BUG_ON(TCG_TYPE_V64 != 3);
>
>     lmul = type - riscv_lg2_vlenb;
>     if (lmul < -3) {
>         /* Host VLEN >= 1024 bits. */
>         vlmul = VLMUL_M1;
I am not sure if we should use VLMUL_MF8,
> lmul_eq_avl = false;
>     } else if (lmul < 3) {
>         /* 1/8 ... 1 ... 8 */
>         vlmul = lmul & 7;
>         lmul_eq_avl = true;
>     } else {
>         /* Guaranteed by Zve64x. */
>         g_assert_not_reached();
>     }
>
>     avl = tcg_type_size(type) >> vsew;
>     vtype = encode_vtype(true, true, vsew, vlmul);
>
>     if (avl < 32) {
>         insn = encode_i(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
Which may benifit here? we usually use  lmul as smallest as we can for 
macro ops split.
>     } else if (lmul_eq_avl) {
>         /* rd != 0 and rs1 == 0 uses vlmax */
>         insn = encode_i(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
>     } else {
>         tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
>         insn = encode_i(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
And perhaps here.
>     }
>     tcg_out32(s, insn);
> }
>
> static MemOp set_vtype_len(TCGContext *s, TCGType type)
> {
>     if (type != s->riscv_cur_type) {
>         set_type(s, type, MO_64);
I think you mean set_vtype here.
>     }
>     return s->riscv_cur_vsew;
> }
>
> static void set_vtype_len_sew(TCGContext *s, TCGType type, MemOp vsew)
> {
>     if (type != s->riscv_cur_type || vsew != s->riscv_cur_vsew) {
>         set_type(s, type, vsew);

and set_vtype here.

Thanks,
Zhiwei

>     }
> }
>
>
> (1) The storing of lg2(vlenb) means we can convert all of the division 
> into subtraction.
> (2) get_vec_type_bytes() already exists as tcg_type_size().
> (3) Make use of the signed 3-bit encoding of vlmul.
> (4) Make use of rd != 0, rs1 = 0 for the relatively common case of AVL 
> = 32.
>
>
> r~

