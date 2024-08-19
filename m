Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E466C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 01:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfrPN-00053H-3I; Sun, 18 Aug 2024 21:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sfrPL-00052K-8n; Sun, 18 Aug 2024 21:42:07 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sfrPI-00080y-Je; Sun, 18 Aug 2024 21:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724031716; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=+YScLDAgCoW//l1ToCsCYfTB8rsY8yMnozs/0lvJZeI=;
 b=Dov4J3nh434KiHNp78q9ocSnqeTi4Ju4vvWyDoKpQBs/XBA7ROqAPg4Fl64DJLSsUG4G8wnw1AOKU7jSBp258GdWs8kmeAx2EOspO01URTiSovAAgGv6B59QNN1HtiK3AKIWDcrLrryXIk+9jCBXWGrYTAIkxmRXhPdaVK7JEv8=
Received: from 30.166.64.89(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WD4tuR6_1724031713) by smtp.aliyun-inc.com;
 Mon, 19 Aug 2024 09:41:54 +0800
Message-ID: <d65c866d-2a04-4f8f-9867-3d3be4eec593@linux.alibaba.com>
Date: Mon, 19 Aug 2024 09:41:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/15] tcg/riscv: Implement vector load/store
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-7-zhiwei_liu@linux.alibaba.com>
 <2ecd1ccc-ce2b-4432-a2a1-9af2dc70f037@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <2ecd1ccc-ce2b-4432-a2a1-9af2dc70f037@linaro.org>
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


On 2024/8/14 17:01, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> @@ -827,14 +850,59 @@ static void tcg_out_ldst(TCGContext *s, 
>> RISCVInsn opc, TCGReg data,
>>   static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
>>                          TCGReg arg1, intptr_t arg2)
>>   {
>> -    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
>> +    RISCVInsn insn;
>> +
>> +    if (type < TCG_TYPE_V64) {
>> +        insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
>> +    } else {
>> +        tcg_debug_assert(arg >= TCG_REG_V1);
>> +        switch (prev_vece) {
>> +        case MO_8:
>> +            insn = OPC_VLE8_V;
>> +            break;
>> +        case MO_16:
>> +            insn = OPC_VLE16_V;
>> +            break;
>> +        case MO_32:
>> +            insn = OPC_VLE32_V;
>> +            break;
>> +        case MO_64:
>> +            insn = OPC_VLE64_V;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +    }
>>       tcg_out_ldst(s, insn, arg, arg1, arg2);
>
> tcg_out_ld/st are called directly from register allocation spill/fill.
> You'll need to set vtype here, and cannot rely on this having been 
> done in tcg_out_vec_op.
OK.
>
> That said, with a little-endian host, the selected element size 
> doesn't matter *too* much.  A write of 8 uint16_t or a write of 2 
> uint64_t produces the same bits in memory.
>
> Therefore you can examine prev_vtype and adjust only if the vector 
> length changes.
OK.
>   But we do that -- e.g. load V256, store V256, store V128 to perform 
> a 384-bit store for AArch64 SVE when VQ=3.
>
> Is there an advantage to using the vector load/store whole register 
> insns, if the requested length is not too small?
For vector type equal or bigger than vlen in host, we will use the whole 
register instructions.
>   IIRC the NF field can be used to store multiples, but we can't store 
> half of a register with these.

I think we can still use the unit-stride instructions for them.

Thanks,
Zhiwei

>
>
> r~

