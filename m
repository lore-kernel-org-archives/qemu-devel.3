Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93090CED27E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy5ww-0000Mz-Bf; Tue, 08 Oct 2024 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sy5ws-0000Mm-Cl; Tue, 08 Oct 2024 04:52:06 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sy5wp-0003bI-Dz; Tue, 08 Oct 2024 04:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728377510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=/3Yj2H6jm6ngDUz5GP0eILTVpbC4tCc4fryGVFQOLuo=;
 b=nUp1HNXCdN5O8mYr5WNP7Vd3rU+5Qd38HiGuh+XBhO6Tp7w+hgMSAZXa4EswarvzJ3H72t5eW3c9OM3rudkcyc1MgI5ekdTMzvsCS9ouhRXkaVyK+fBbzg9fdQcIGUjl23NJhgeI3VAFfHS9XxVdN0Mr9fGlwH+tUy9OVfX5UUk=
Received: from 30.166.64.126(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGd3HHX_1728377508) by smtp.aliyun-inc.com;
 Tue, 08 Oct 2024 16:51:49 +0800
Message-ID: <e6cd032a-e183-445c-821e-9fed93fe0389@linux.alibaba.com>
Date: Tue, 8 Oct 2024 16:51:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
 <20241007025700.47259-4-zhiwei_liu@linux.alibaba.com>
 <a370de66-d966-44d2-9dee-091b28082fcc@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <a370de66-d966-44d2-9dee-091b28082fcc@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/10/8 00:24, Richard Henderson wrote:
> On 10/6/24 19:56, LIU Zhiwei wrote:
>> +static void probe_frac_lmul(void)
>> +{
>> +    unsigned long vlmax[3];
>> +
>> +    for (int i = MO_8; i <= MO_64; ++i) {
>> +        switch (i) {
>> +        case MO_8:
>> +            asm volatile(
>> +                "vsetvli %0, zero, e8, mf2\n\t"
>> +                "vsetvli %1, zero, e8, mf4\n\t"
>> +                "vsetvli %2, zero, e8, mf8"
>> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
>> +            );
>> +            break;
>> +        case MO_16:
>> +            asm volatile(
>> +                "vsetvli %0, zero, e16, mf2\n\t"
>> +                "vsetvli %1, zero, e16, mf4\n\t"
>> +                "vsetvli %2, zero, e16, mf8"
>> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
>> +            );
>> +            break;
>> +        case MO_32:
>> +            asm volatile(
>> +                "vsetvli %0, zero, e32, mf2\n\t"
>> +                "vsetvli %1, zero, e32, mf4\n\t"
>> +                "vsetvli %2, zero, e32, mf8"
>> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
>> +            );
>> +            break;
>> +        case MO_64:
>> +            asm volatile(
>> +                "vsetvli %0, zero, e64, mf2\n\t"
>> +                "vsetvli %1, zero, e64, mf4\n\t"
>> +                "vsetvli %2, zero, e64, mf8"
>> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
>> +            );
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +        vaild_frac_lmul[i][1] = vlmax[0] != 0;
>> +        vaild_frac_lmul[i][2] = vlmax[1] != 0;
>> +        vaild_frac_lmul[i][3] = vlmax[2] != 0;
>> +    }
>>   }
>
> This fails to build on debian with default cflags:
>
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc: Assembler messages:
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2880: Error: 
> unrecognized opcode `vsetvli a3,zero,e8,mf2', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2881: Error: 
> unrecognized opcode `vsetvli a4,zero,e8,mf4', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2882: Error: 
> unrecognized opcode `vsetvli a5,zero,e8,mf8', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2888: Error: 
> unrecognized opcode `vsetvli a3,zero,e16,mf2', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2889: Error: 
> unrecognized opcode `vsetvli a4,zero,e16,mf4', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2890: Error: 
> unrecognized opcode `vsetvli a5,zero,e16,mf8', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2896: Error: 
> unrecognized opcode `vsetvli a3,zero,e32,mf2', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2897: Error: 
> unrecognized opcode `vsetvli a4,zero,e32,mf4', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2898: Error: 
> unrecognized opcode `vsetvli a5,zero,e32,mf8', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2904: Error: 
> unrecognized opcode `vsetvli a3,zero,e64,mf2', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2905: Error: 
> unrecognized opcode `vsetvli a4,zero,e64,mf4', extension `v' or 
> `zve64x' or `zve32x' required
> /home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2906: Error: 
> unrecognized opcode `vsetvli a5,zero,e64,mf8', extension `v' or 
> `zve64x' or `zve32x' required
>
> Rather than expanding this with a switch over immediate encodings, 
> perhaps better feed encode_vtype() to the .insn encoding of vsetvl.

OK.

>
>
>> @@ -2160,6 +2483,7 @@ static void tcg_target_init(TCGContext *s)
>>          tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
>>          break;
>>      }
>> +    probe_frac_lmul();
>
> You need to avoid this call if the host does not support vectors.
Agree.
>
> It occurs to me that, rather than caching valid_frac_lmul[][], we can 
> pre-compute encode_vtype and lmul_eq_avl.

Do you mean cache vtype and lmul_eq_avl for different (lmul, sew) pairs 
instead of valid_frac_lmul?

Thanks,
Zhiwei

>   It's not much of a savings within set_vtype(), but perhaps it is 
> clearer.
>
>
> r~

