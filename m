Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402C2C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 07:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sir3h-0005t6-FY; Tue, 27 Aug 2024 03:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sir3d-0005rU-06; Tue, 27 Aug 2024 03:56:05 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sir3a-0005Rd-HU; Tue, 27 Aug 2024 03:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724745357; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=kOM2kfPVHlwMt/Z8RmOKJiT0RFoXXKwkLYjz65ONw+c=;
 b=WKHDZ19Ca1T7cyyAJdC2i97hVMCjVyNPwD7joFXRvLkqrAKQcd+G0pDeHC2zJHtJKsAuICjahq1Nrxcs1TMa8T/kIkHDGDOGUpnbSbnpc21FMj4IpyZbCdZFkWBR2yflZ4VjnqDkDOgrLW/16cILpVEhgrFlCasXplW9vyfKx/M=
Received: from 30.166.64.124(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDlplsP_1724745355) by smtp.aliyun-inc.com;
 Tue, 27 Aug 2024 15:55:56 +0800
Message-ID: <c7279e9e-c535-4860-a44d-b2a73a186e29@linux.alibaba.com>
Date: Tue, 27 Aug 2024 15:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/15] tcg/riscv: Implement vector not/neg ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-11-zhiwei_liu@linux.alibaba.com>
 <2c3fe80e-fe1c-49a3-aa4a-03749801e4ee@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <2c3fe80e-fe1c-49a3-aa4a-03749801e4ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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


On 2024/8/14 17:45, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> @@ -2312,6 +2314,12 @@ static void tcg_out_vec_op(TCGContext *s, 
>> TCGOpcode opc,
>>       case INDEX_op_xor_vec:
>>           tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
>>           break;
>> +    case INDEX_op_not_vec:
>> +        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
>> +        break;
>> +    case INDEX_op_neg_vec:
>> +        tcg_out_opc_vx(s, OPC_VRSUB_VX, a0, a1, TCG_REG_ZERO, true);
>> +        break;
>
> Any reason not to use vrsub.vi?  Not wrong, just surprising.
We will use vrsub.vi.
>
> Obviously, NOT does not require SEW change.

OK.

Thanks,
Zhiwei

>
> r~

