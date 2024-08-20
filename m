Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEABC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 01:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgE7D-00035v-Md; Mon, 19 Aug 2024 21:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgE7C-00034M-8Y; Mon, 19 Aug 2024 21:56:54 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgE79-0006vC-JM; Mon, 19 Aug 2024 21:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724118999; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=nA809LtVfKWVOwke62uMihCDUdWhyXWDWY+4FRYQ9ag=;
 b=kq1fI1ykY0zgzVhsFh5sIWX/fUiHxq0T8T8lsjKjkixognPZpCfP8gxAkvyrY7+Pr+pEFR45j04JC5wsFRyQUYPfBlKgmk0MFgouxxr5TL4QoVliJ9wmX6lhGIv+v4gQB69rbUQRRSQxgz19D+afJDFsihA5ftmQAGK8juGsYzY=
Received: from 30.166.65.10(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDGbxRD_1724118996) by smtp.aliyun-inc.com;
 Tue, 20 Aug 2024 09:56:37 +0800
Message-ID: <8788fae2-14ca-4af2-a075-bf20a533f540@linux.alibaba.com>
Date: Tue, 20 Aug 2024 09:56:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
 <ae44194c-776a-48aa-8567-c56b5e7c4167@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <ae44194c-776a-48aa-8567-c56b5e7c4167@linaro.org>
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


On 2024/8/14 17:13, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   tcg/riscv/tcg-target-con-set.h |  1 +
>>   tcg/riscv/tcg-target.c.inc     | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/tcg/riscv/tcg-target-con-set.h 
>> b/tcg/riscv/tcg-target-con-set.h
>> index d73a62b0f2..8a0de18257 100644
>> --- a/tcg/riscv/tcg-target-con-set.h
>> +++ b/tcg/riscv/tcg-target-con-set.h
>> @@ -23,3 +23,4 @@ C_O1_I4(r, r, rI, rM, rM)
>>   C_O2_I4(r, r, rZ, rZ, rM, rM)
>>   C_O0_I2(v, r)
>>   C_O1_I1(v, r)
>> +C_O1_I2(v, v, v)
>> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
>> index f60913e805..650b5eff1a 100644
>> --- a/tcg/riscv/tcg-target.c.inc
>> +++ b/tcg/riscv/tcg-target.c.inc
>> @@ -289,6 +289,12 @@ typedef enum {
>>       OPC_VSE32_V = 0x6027 | V_SUMOP,
>>       OPC_VSE64_V = 0x7027 | V_SUMOP,
>>   +    OPC_VADD_VV = 0x57 | V_OPIVV,
>> +    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
>> +    OPC_VAND_VV = 0x24000057 | V_OPIVV,
>> +    OPC_VOR_VV = 0x28000057 | V_OPIVV,
>> +    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
>> +
>>       OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
>>       OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
>>       OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
>> @@ -2158,6 +2164,21 @@ static void tcg_out_vec_op(TCGContext *s, 
>> TCGOpcode opc,
>>       case INDEX_op_st_vec:
>>           tcg_out_st(s, type, a0, a1, a2);
>>           break;
>> +    case INDEX_op_add_vec:
>> +        tcg_out_opc_vv(s, OPC_VADD_VV, a0, a1, a2, true);
>> +        break;
>> +    case INDEX_op_sub_vec:
>> +        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2, true);
>> +        break;
>> +    case INDEX_op_and_vec:
>> +        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2, true);
>> +        break;
>> +    case INDEX_op_or_vec:
>> +        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2, true);
>> +        break;
>> +    case INDEX_op_xor_vec:
>> +        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
>> +        break;
>
> As with load/store/move, and/or/xor can avoid changing element type.
> Thus I think the vtype setup before the switch is premature.

Agree. We have implemented this feature on the v2 patch set.

Thanks,
Zhiwei

>
>
> r~

