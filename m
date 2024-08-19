Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255FDC531DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 02:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfsWx-00029I-SQ; Sun, 18 Aug 2024 22:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sfsWw-00028H-3v; Sun, 18 Aug 2024 22:54:02 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sfsWt-0002ir-O5; Sun, 18 Aug 2024 22:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724036030; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=dDnfXKTJKTzokknwvZN7ZuvtRsHDAIu8i6x238KHu48=;
 b=mr3RrawkWKcI/pI7Kgmf8Eo3CHm/lDSKAelxMG+tq1WxXlmxyg/k+t9DyixubJtP9l/EGGjs4wGYPd1mDN8ccb8R2/sdXUx0QugleTvHGTTUVSjceL3W/NVsKlzekbTjHFIYJfcyL2n7MN8V/LSkrbEK6vV4M8AF/K/4qWgN/II=
Received: from 30.166.64.89(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WD4y1tS_1724036028) by smtp.aliyun-inc.com;
 Mon, 19 Aug 2024 10:53:48 +0800
Message-ID: <fd602a3b-c00e-48d0-b51f-169c8cd9a6f4@linux.alibaba.com>
Date: Mon, 19 Aug 2024 10:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] tcg/riscv: Add riscv vset{i}vli support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-6-zhiwei_liu@linux.alibaba.com>
 <37e67a28-dd86-435d-a072-95f6a85cc2a7@linaro.org>
 <ac327ea2-2b22-40e2-8246-57e4be77d8d1@linux.alibaba.com>
 <6a0f46a5-02f7-47e8-a5f5-5666c2fc9fe2@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <6a0f46a5-02f7-47e8-a5f5-5666c2fc9fe2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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


On 2024/8/19 10:35, Richard Henderson wrote:
> On 8/19/24 11:34, LIU Zhiwei wrote:
>>>> @@ -1914,6 +2029,11 @@ static void tcg_out_vec_op(TCGContext *s, 
>>>> TCGOpcode opc,
>>>>                              const TCGArg args[TCG_MAX_OP_ARGS],
>>>>                              const int const_args[TCG_MAX_OP_ARGS])
>>>>   {
>>>> +    TCGType type = vecl + TCG_TYPE_V64;
>>>> +
>>>> +    if (vec_vtpye_init) {
>>>> +        tcg_target_set_vec_config(s, type, vece);
>>>> +    }
>>>
>>> Here is perhaps too early... see patch 8 re logicals.
>>
>> I guess you mean we don't have implemented any vector op, so there is 
>> no need to set vsetvl in this patch. We will postpone it do really 
>> ops need it.
>
> What I meant is "too early in the function", i.e. before the switch.
>
> Per my comment in patch 8, there are some vector ops that are agnostic 
> to type and only care about length.  Thus perhaps
>
>   switch (op) {
>   case xxx:
>     set_vec_config_len(s, type);
>     something;
>
>   case yyy:
>     set_vec_config_len_elt(s, type, vece);
>     something_else;
>
>   ...
>   }
>
> Or some other structure that makes sense.

Thanks for clarify once again. It's much better to explicitly have two 
API types.

Thanks,
Zhiwei

>
>
> r~

