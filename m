Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3CDEDE98A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 01:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snpWP-0003TT-Qb; Mon, 09 Sep 2024 21:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snpWO-0003Pv-61; Mon, 09 Sep 2024 21:18:20 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snpWL-0007ST-DK; Mon, 09 Sep 2024 21:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725931091; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=ARNilNE2YM9SNm+pbtULnv5xSyliHHJvU0ek3qDhbU4=;
 b=UC/LZsHqdpRR0Cr6AqtNUV/XuBHVHK3E/FwREGcjFmCT6dMRYv6lUwk3LciIbAQ0EPf3eKion57PqUOcHIggsILTSPuCdLjW9qME6oRNldvzDm/1rg9pi9UWpuW/LncoeIr90C502Ngd1j17ClLsb9b5yKnt25dI/VpIZZ7OyKg=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEhvYg5_1725931089) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 09:18:10 +0800
Message-ID: <1eb26532-98fb-4cb5-b5a8-7da5d24e03d7@linux.alibaba.com>
Date: Tue, 10 Sep 2024 09:17:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] tcg/riscv: Implement vector cmp ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-9-zhiwei_liu@linux.alibaba.com>
 <9d40d3f4-731d-478f-81ba-1c380ef9d0ae@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <9d40d3f4-731d-478f-81ba-1c380ef9d0ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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


On 2024/9/5 15:12, Richard Henderson wrote:
> On 9/4/24 07:27, LIU Zhiwei wrote:
>> @@ -2322,6 +2411,51 @@ static void tcg_out_vec_op(TCGContext *s, 
>> TCGOpcode opc,
>>           riscv_set_vec_config_vl(s, type);
>>           tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
>>           break;
>> +    case INDEX_op_cmpsel_vec:
>> +        TCGArg a3, a4;
>> +        int c3, c4;
>> +        TCGCond cond;
>
> While I suppose this compiles, it's not great to have new variables 
> added randomly within a switch.  At minimum, add { } around the block, 
> but consider breaking out a separate tcg_out_cmpsel function, akin to 
> tcg_out_movcond et al.
OK.
>
>> @@ -2332,10 +2466,27 @@ static void tcg_out_vec_op(TCGContext *s, 
>> TCGOpcode opc,
>>   void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
>>                          TCGArg a0, ...)
>>   {
>> +    va_list va;
>> +    TCGv_vec v0, v1;
>> +    TCGArg a2, a3;
>> +
>> +    va_start(va, a0);
>> +    v0 = temp_tcgv_vec(arg_temp(a0));
>> +    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
>> +    a2 = va_arg(va, TCGArg);
>> +
>>       switch (opc) {
>> +    case INDEX_op_cmp_vec:
>> +        a3 = va_arg(va, TCGArg);
>> +        vec_gen_6(INDEX_op_cmpsel_vec, type, vece, tcgv_vec_arg(v0),
>> +                    tcgv_vec_arg(v1), a2,
>> +                    tcgv_i64_arg(tcg_constant_i64(-1)),
>> +                    tcgv_i64_arg(tcg_constant_i64(0)), a3);
>> +        break;
>>       default:
>>           g_assert_not_reached();
>>       }
>> +    va_end(va);
>>   }
>
> Better to use "TCGArg a0, a1".  Converting through arg_tmp + 
> temp_tcgv_vec to v0/v1 and then undoing that with tcgv_vec_arg is 
> confusing.

OK.

Thanks,
Zhiwei

>
>
> r~

