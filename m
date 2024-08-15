Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84854C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seY3W-0000hp-MM; Thu, 15 Aug 2024 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1seY3P-0000gf-2v; Thu, 15 Aug 2024 06:50:05 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1seY3M-00014M-Bx; Thu, 15 Aug 2024 06:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723718988; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=AV3AYu+DH86HNGKe/JSeSW5at/TVVSSufIlvyzQQA24=;
 b=mNJHiYJpPuxZiTXxPQSY8C7YniCLef+i8x5v5qsXsIxGRAKZRsNZecAE3JR1UnG1rDRrpbCb/ioa5Yqt0i3vknlYhaf+Tfxh0BxAgo4dicSo3hZrM2CyjPM1MzNRHsBDy3Pt/eN3q/lkt0l+ex46pfmc3S6BZL+QDAVdJDPw2jQ=
Received: from 30.166.64.117(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCwdTc0_1723718984) by smtp.aliyun-inc.com;
 Thu, 15 Aug 2024 18:49:45 +0800
Message-ID: <70a2e212-e2c5-4221-87cc-6ff371b5f509@linux.alibaba.com>
Date: Thu, 15 Aug 2024 18:49:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/15] tcg/riscv: Implement vector mov/dup{m/i}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-8-zhiwei_liu@linux.alibaba.com>
 <21210e0f-457e-4858-befc-f869984d3315@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <21210e0f-457e-4858-befc-f869984d3315@linaro.org>
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


On 2024/8/14 17:11, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> @@ -641,6 +645,13 @@ static bool tcg_out_mov(TCGContext *s, TCGType 
>> type, TCGReg ret, TCGReg arg)
>>       case TCG_TYPE_I64:
>>           tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
>>           break;
>> +    case TCG_TYPE_V64:
>> +    case TCG_TYPE_V128:
>> +    case TCG_TYPE_V256:
>> +        tcg_debug_assert(ret > TCG_REG_V0 && arg > TCG_REG_V0);
>> +        tcg_target_set_vec_config(s, type, prev_vece);
>> +        tcg_out_opc_vv(s, OPC_VMV_V_V, ret, TCG_REG_V0, arg, true);
>
> I suggest these asserts be in tcg_out_opc_*
> That way you don't need to replicate to all uses.
OK.
>
>> +static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, 
>> unsigned vece,
>> +                                   TCGReg dst, TCGReg src)
>
> Oh, please drop all of the inline markup, from all patches.
> Let the compiler decide.
>
OK.
>> +static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, 
>> unsigned vece,
>> +                                    TCGReg dst, TCGReg base, 
>> intptr_t offset)
>> +{
>> +    tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
>> +    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
>> +}
>
> Is this really better than using strided load with rs2 = r0?

It depends.  For our test board, it is.

Thanks,
Zhiwei

>
>
> r~

