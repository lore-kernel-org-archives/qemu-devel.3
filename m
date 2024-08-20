Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21BEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 01:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgE8N-0005nw-Fv; Mon, 19 Aug 2024 21:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgE8L-0005c2-0D; Mon, 19 Aug 2024 21:58:06 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgE8J-0006zG-2x; Mon, 19 Aug 2024 21:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724119078; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=ZSrVJzfFcRCuX2Jrlj2tIUb/4h9oZBt6KlcD59mRzWs=;
 b=YeUhBLlAorfLi5IhvDUtBYVs2VDbwcOex06ufpfH4lWw8mM+nkOVz48Ans1cYQWPoZUzn1gxg1+mqwJho5PnjVHDqrWg+bAFiy4e7eoBIGzxDkR6E/R6G4+z+dTgtnLar/mWk4U5MptVrbQ1puDa5NbgENBjJvV4Hb1l4v0wS1s=
Received: from 30.166.65.10(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDGXBTz_1724119076) by smtp.aliyun-inc.com;
 Tue, 20 Aug 2024 09:57:56 +0800
Message-ID: <c3d0e2bf-9e5b-40ce-9acd-73f10f06913c@linux.alibaba.com>
Date: Tue, 20 Aug 2024 09:57:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
 <b325f636-c337-4fbd-b5da-c08b8978da15@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <b325f636-c337-4fbd-b5da-c08b8978da15@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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


On 2024/8/14 17:17, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> +    OPC_VADD_VV = 0x57 | V_OPIVV,
>> +    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
>> +    OPC_VAND_VV = 0x24000057 | V_OPIVV,
>> +    OPC_VOR_VV = 0x28000057 | V_OPIVV,
>> +    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
>
> Immediate operand variants to be handled as a follow-up?
Do you mean VXOR_VI? We use vxor.vi for not_vec already in patch 10.

Zhiwei
>
>
> r~

