Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E6EEDE994
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrCk-0006Ee-Dn; Mon, 09 Sep 2024 23:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snrCi-0006DW-7M; Mon, 09 Sep 2024 23:06:08 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snrCa-0000w4-SI; Mon, 09 Sep 2024 23:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725937551; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=QUR9OLZGVTOGZd1ncybK0E8qPKWrFERHNLqKsDj5v4I=;
 b=gsB2A/+6c/bFJ6EC20rlGwRMYKCgQ1lRBvhufyp1r4BFhi45NwWQt+CN3mmJwhl9jwYMwUC31n24M3bvsepoM+dqQAiMYSIExi/Y6wmRzwlQVFFspsD+GKmeuM778in9qlYKY0oTKDnzwJmdkWvulq62wmqwONzfgsAdtohBRB8=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEiiu83_1725937550) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 11:05:51 +0800
Message-ID: <436c4c68-9a44-402d-ad1a-8fa6b502a9a6@linux.alibaba.com>
Date: Tue, 10 Sep 2024 11:04:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] tcg/riscv: Implement vector load/store
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-6-zhiwei_liu@linux.alibaba.com>
 <77a1f5a9-0dff-4207-940c-e0d52316398e@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <77a1f5a9-0dff-4207-940c-e0d52316398e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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


On 2024/9/5 14:39, Richard Henderson wrote:
> On 9/4/24 07:27, LIU Zhiwei wrote:
>> @@ -811,31 +849,52 @@ static void tcg_out_extrl_i64_i32(TCGContext 
>> *s, TCGReg ret, TCGReg arg)
>>       tcg_out_ext32s(s, ret, arg);
>>   }
>>   -static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>> -                         TCGReg addr, intptr_t offset)
>> +static intptr_t split_offset_scalar(TCGContext *s, TCGReg *addr,
>> +                                    intptr_t offset)
>>   {
>>       intptr_t imm12 = sextreg(offset, 0, 12);
>>         if (offset != imm12) {
>>           intptr_t diff = tcg_pcrel_diff(s, (void *)offset);
>>   -        if (addr == TCG_REG_ZERO && diff == (int32_t)diff) {
>> +        if (*addr == TCG_REG_ZERO && diff == (int32_t)diff) {
>>               imm12 = sextreg(diff, 0, 12);
>>               tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - 
>> imm12);
>>           } else {
>>               tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - 
>> imm12);
>> -            if (addr != TCG_REG_ZERO) {
>> -                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, 
>> TCG_REG_TMP2, addr);
>> +            if (*addr != TCG_REG_ZERO) {
>> +                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, 
>> TCG_REG_TMP2, *addr);
>>               }
>>           }
>> -        addr = TCG_REG_TMP2;
>> +        *addr = TCG_REG_TMP2;
>> +    }
>> +    return imm12;
>> +}
>> +
>> +static void split_offset_vector(TCGContext *s, TCGReg *addr, 
>> intptr_t offset)
>> +{
>> +    if (offset != 0) {
>> +        if (offset == sextreg(offset, 0, 12)) {
>> +            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, *addr, offset);
>> +        } else {
>> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
>> +            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, 
>> *addr);
>> +        }
>> +        *addr = TCG_REG_TMP0;
>>       }
>> +}
>> +
>> +static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>> +                         TCGReg addr, intptr_t offset)
>> +{
>> +    intptr_t imm12;
>>         switch (opc) {
>>       case OPC_SB:
>>       case OPC_SH:
>>       case OPC_SW:
>>       case OPC_SD:
>> +        imm12 = split_offset_scalar(s, &addr, offset);
>>           tcg_out_opc_store(s, opc, addr, data, imm12);
>>           break;
>>       case OPC_LB:
>> @@ -845,8 +904,31 @@ static void tcg_out_ldst(TCGContext *s, 
>> RISCVInsn opc, TCGReg data,
>>       case OPC_LW:
>>       case OPC_LWU:
>>       case OPC_LD:
>> +        imm12 = split_offset_scalar(s, &addr, offset);
>>           tcg_out_opc_imm(s, opc, data, addr, imm12);
>>           break;
>> +    case OPC_VSE8_V:
>> +    case OPC_VSE16_V:
>> +    case OPC_VSE32_V:
>> +    case OPC_VSE64_V:
>> +    case OPC_VS1R_V:
>> +    case OPC_VS2R_V:
>> +    case OPC_VS4R_V:
>> +    case OPC_VS8R_V:
>> +        split_offset_vector(s, &addr, offset);
>> +        tcg_out_opc_ldst_vec(s, opc, data, addr, true);
>> +        break;
>> +    case OPC_VLE8_V:
>> +    case OPC_VLE16_V:
>> +    case OPC_VLE32_V:
>> +    case OPC_VLE64_V:
>> +    case OPC_VL1RE64_V:
>> +    case OPC_VL2RE64_V:
>> +    case OPC_VL4RE64_V:
>> +    case OPC_VL8RE64_V:
>> +        split_offset_vector(s, &addr, offset);
>> +        tcg_out_opc_ldst_vec(s, opc, data, addr, true);
>> +        break;
>>       default:
>>           g_assert_not_reached();
>>       }
>
> This is more complicated than it needs to be, calling a combined 
> function, then using a switch to separate, then calling separate 
> functions.  Calling separate functions in the first place is simpler.  
> E.g.
>
> static void tcg_out_vec_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>                              TCGReg addr, intptr_t offset)
> {
>     tcg_debug_assert(data >= TCG_REG_V0);
>     tcg_debug_assert(addr < TCG_REG_V0);
>
>     if (offset) {
>         tcg_debug_assert(addr != TCG_REG_ZERO);
>         if (offset == sextreg(offset, 0, 12)) {
>             tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, offset);
>         } else {
>             tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
>             tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, 
> addr);
>         }
>         addr = TCG_REG_TMP0;
>     }
>
>     tcg_out32(s, opc | ((data & 0x1f) << 7) | (addr << 15) | (1 << 25));
> }
>
>>   static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
>>                          TCGReg arg1, intptr_t arg2)
>>   {
>> -    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
>> +    RISCVInsn insn;
>> +
>> +    if (type < TCG_TYPE_V64) {
>> +        insn = (type == TCG_TYPE_I32) ? OPC_LW : OPC_LD;
>> +    } else {
>> +        int nf = get_vec_type_bytes(type) / riscv_vlenb;
>> +
>> +        switch (nf) {
>> +        case 1:
>> +            insn = OPC_VL1RE64_V;
>> +            break;
>> +        case 2:
>> +            insn = OPC_VL2RE64_V;
>> +            break;
>> +        case 4:
>> +            insn = OPC_VL4RE64_V;
>> +            break;
>> +        case 8:
>> +            insn = OPC_VL8RE64_V;
>> +            break;
>> +        default:
>> +            {
>> +                int prev_vsew = riscv_set_vec_config_vl(s, type);
>> +
>> +                switch (prev_vsew) {
>> +                case MO_8:
>> +                    insn = OPC_VLE8_V;
>> +                    break;
>> +                case MO_16:
>> +                    insn = OPC_VLE16_V;
>> +                    break;
>> +                case MO_32:
>> +                    insn = OPC_VLE32_V;
>> +                    break;
>> +                case MO_64:
>> +                    insn = OPC_VLE64_V;
>> +                    break;
>> +                default:
>> +                    g_assert_not_reached();
>> +                }
>> +            }
>> +            break;
>
> This can be simplified:
>
>     switch (type) {
>     case TCG_TYPE_I32:
>         tcg_out_ldst(s, OPC_LW, data, base, offset);
>         break;
>     case TCG_TYPE_I64:
>         tcg_out_ldst(s, OPC_LD, data, base, offset);
>         break;
>     case TCG_TYPE_V64:
>     case TCG_TYPE_V128:
>     case TCG_TYPE_V256:
>         if (type >= riscv_lg2_vlenb) {
>             static const RISCVInsn whole_reg_ld[] = {
>                 OPC_VL1RE64_V, OPC_VL2RE64_V, OPC_VL4RE64_V, 
> OPC_VL8RE64_V
>             };
>             unsigned idx = type - riscv_lg2_vlenb;
>             insn = whole_reg_ld[idx];
>         } else {
>             static const RISCVInsn unit_stride_ld[] = {
>                 OPC_VLE8_V, OPC_VLE16_V, OPC_VLE32_V, OPC_VLE64_V
>             };
>             MemOp prev_vsew = set_vtype_len(s, type);
>             insn = unit_stride_ld[prev_vsew];
>         }
>         tcg_out_vec_ldst(s, insn, data, base, offset);
>         break;
>     default:
>         g_assert_not_reached();
>     }
>
> and similar for store.

Great. We will take this way.

Zhiwei

>
>
> r~

