Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEEEDE994
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 02:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snqy3-0003PZ-F2; Mon, 09 Sep 2024 22:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqy1-0003NK-QG; Mon, 09 Sep 2024 22:50:57 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqxz-0007ui-Dw; Mon, 09 Sep 2024 22:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725936649; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=sIsOF/NCJExJYmgliUcKf+dlTxkxwBFTdKKaABCL7vE=;
 b=YAzghRlL8YYU9h/eYX08UrC2N7TnEI6ge1Im4Q2vS+orG6kZmN11eM85tuV92EZMbUD2VaKSn/f262Q+7wj4NrjG3GIFjWN8ME4Lepld4UipbcPdELDKjdJljMj1iB5Tn5Rk0OH9LrmggJYg/4E2vWkfiO/jVHGmVk2H57A+tIc=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEiiRdB_1725936648) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 10:50:48 +0800
Message-ID: <de11de3f-8435-4400-aa3a-04ba85aa0feb@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:49:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] tcg/riscv: Add basic support for vector
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-4-zhiwei_liu@linux.alibaba.com>
 <943abf2a-de03-49fd-b594-76b15224f2cc@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <943abf2a-de03-49fd-b594-76b15224f2cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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


On 2024/9/5 12:05, Richard Henderson wrote:
> On 9/4/24 07:27, LIU Zhiwei wrote:
>> From: Swung0x48 <swung0x48@outlook.com>
>>
>> The RISC-V vector instruction set utilizes the LMUL field to group
>> multiple registers, enabling variable-length vector registers. This
>> implementation uses only the first register number of each group while
>> reserving the other register numbers within the group.
>>
>> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
>> host runtime needs to adjust LMUL based on the type to use different
>> register groups.
>>
>> This presents challenges for TCG's register allocation. Currently, we
>> avoid modifying the register allocation part of TCG and only expose the
>> minimum number of vector registers.
>>
>> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, 
>> with
>> LMUL equal to 4, we use 4 vector registers as one register group. We can
>> use a maximum of 8 register groups, but the V0 register number is 
>> reserved
>> as a mask register, so we can effectively use at most 7 register groups.
>> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
>> forced to be used. This is because TCG cannot yet dynamically constrain
>> registers with type; likewise, when the host vlen is 128 bits and
>> TCG_TYPE_V256, we can use at most 15 registers.
>>
>> There is not much pressure on vector register allocation in TCG now, so
>> using 7 registers is feasible and will not have a major impact on code
>> generation.
>>
>> This patch:
>> 1. Reserves vector register 0 for use as a mask register.
>> 2. When using register groups, reserves the additional registers within
>>     each group.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Co-authored-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> This patch does not compile.
>
> ../src/tcg/tcg.c:135:13: error: 'tcg_out_dup_vec' used but never 
> defined [-Werror]
>   135 | static bool tcg_out_dup_vec(TCGContext *s, TCGType type, 
> unsigned vece,
>       |             ^~~~~~~~~~~~~~~
> ../src/tcg/tcg.c:137:13: error: 'tcg_out_dupm_vec' used but never 
> defined [-Werror]
>   137 | static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, 
> unsigned vece,
>       |             ^~~~~~~~~~~~~~~~
> ../src/tcg/tcg.c:139:13: error: 'tcg_out_dupi_vec' used but never 
> defined [-Werror]
>   139 | static void tcg_out_dupi_vec(TCGContext *s, TCGType type, 
> unsigned vece,
>       |             ^~~~~~~~~~~~~~~~
> In file included from ../src/tcg/tcg.c:755:
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:516:13: error: 
> 'tcg_out_opc_ldst_vec' defined but not used [-Werror=unused-function]
>   516 | static void tcg_out_opc_ldst_vec(TCGContext *s, RISCVInsn opc, 
> TCGReg data,
>       |             ^~~~~~~~~~~~~~~~~~~~
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:507:13: error: 
> 'tcg_out_opc_vi' defined but not used [-Werror=unused-function]
>   507 | static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc, 
> TCGReg vd,
>       |             ^~~~~~~~~~~~~~
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:501:13: error: 
> 'tcg_out_opc_vx' defined but not used [-Werror=unused-function]
>   501 | static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc, 
> TCGReg vd,
>       |             ^~~~~~~~~~~~~~
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:495:13: error: 
> 'tcg_out_opc_vv' defined but not used [-Werror=unused-function]
>   495 | static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc, 
> TCGReg vd,
>       |             ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
Oops. We miss compiling each patch one by one.
>
> Either:
> (1) Provide stubs for the functions that are required, and delay 
> implementation
>     of the unused functions until the patch(es) that use them.
We will take this way.
> (2) Merge the dup patch so that these functions are defined and 
> implemented,
>     which will also provide uses for most of the tcg_out_opc_* functions.
>
>
>> @@ -2100,6 +2174,32 @@ static void tcg_target_init(TCGContext *s)
>>   {
>>       tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
>>       tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
>> +    s->reserved_regs = 0;
>> +
>> +    if (cpuinfo & CPUINFO_ZVE64X) {
>> +        switch (riscv_vlen) {
>> +        case 64:
>> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V128] = 
>> ALL_DVECTOR_REG_GROUPS;
>> +            tcg_target_available_regs[TCG_TYPE_V256] = 
>> ALL_QVECTOR_REG_GROUPS;
>> +            s->reserved_regs |= (~ALL_QVECTOR_REG_GROUPS & 
>> 0xffffffff00000000);
>
> No need for ().
> Use ALL_VECTOR_REGS instead of the immediate integer.
OK.
>
>> +            break;
>> +        case 128:
>> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V256] = 
>> ALL_DVECTOR_REG_GROUPS;
>> +            s->reserved_regs |= (~ALL_DVECTOR_REG_GROUPS & 
>> 0xffffffff00000000);
>> +            break;
>> +        case 256:
>> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>
> The first host with 512-bit or larger vectors will trigger the assert.
>
> With my suggestion against patch 2, this becomes
>
>     switch (riscv_lg2_vlenb) {
>     case TCG_TYPE_V64:
>         ...
>     case TCG_TYPE_V128:
>         ...
>     default:
>         /* Guaranteed by Zve64x. */
>         tcg_debug_assert(riscv_lg2_vlenb >= TCG_TYPE_V256);
>     }
>
Agree.


Thanks,

Zhiwei
>
> r~

