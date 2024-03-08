Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32ABC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWjf-0006ru-Fc; Fri, 08 Mar 2024 04:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1riWjZ-0006rK-IL; Fri, 08 Mar 2024 04:41:48 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1riWjV-0002eA-SM; Fri, 08 Mar 2024 04:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709890888; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=dPL+ujSiWgHnEHJogZSkcv/KP3AYWtQSfNwGvOJkMOc=;
 b=sy8KypKHVKlUUK+B/Vnoi/k+RVtNV2oGeXfahLl60j3D1I0sZ2GNMmSUiTxcV7jzZmko+/hQfYwRkFg/xKY9CQnkw6PJzwQs8PsHu/paFK5TsLQfwrzNx0iU9l50V85TZTwvyu7NhPH2jLongLn0zNa5QVKiiSoXQb3CTmG5AVk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W22FG6Y_1709890885; 
Received: from 30.21.185.204(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W22FG6Y_1709890885) by smtp.aliyun-inc.com;
 Fri, 08 Mar 2024 17:41:26 +0800
Message-ID: <04d8070b-04ec-4993-9418-5bb982f0433b@linux.alibaba.com>
Date: Fri, 8 Mar 2024 17:41:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
 <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
 <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
 <dc9f673a-3f5a-4703-b171-b8599bdec22e@linaro.org>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <dc9f673a-3f5a-4703-b171-b8599bdec22e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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

Hello, Richard and Daniel,

Thanks to your review, the suggestions about decoder_table_size and 
decoder's place will be adopted in the next version of the patch.

But I would not agree that this patch is a wash or worse. On average, 
though, the two approaches may be comparable. However, as more and more 
vendors join in, this approach will have scalability issues.

For example, if you add 10 vendors, it is not fair to treat the 10th 
vendor with the lowest performance. Our approach works for most 
scenarios, which are basic RV extensions + vendor-specific extensions.

Thanks,

Huang Tao


在 2024/3/8 04:35, Richard Henderson 写道:
>>>> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
>>>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>>>> -                decoders[i].decode_func(ctx, opcode32)) {
>>>> +        for (size_t i = 0; i < decoder_table_size; ++i) {
>>>> +            if (ctx->decoder[i](ctx, opcode32)) {
>>>>                   return;
>
> By the way, you're adding layers of pointer chasing, so I suspect 
> you'll find all of this is a wash or worse, performance-wise.
>
> Indeed, since some of the predicates are trivial, going the other way 
> might help: allow everything to be inlined:
>
>     if (decode_insn32(...)) {
>         return;
>     }
>     if (has_xthead_p(...) && decode_xthead(...)) {
>         return;
>     }
>     ...
>
> Even if there are 10 entries here, so what?  All of the code has to be 
> compiled into QEMU.  You're not going to somehow add truly dynamic 
> code that you've loaded from a module.
>
> You could perhaps streamline predicates such as has_xthead_p to not 
> test 11 variables by adding an artificial "ext_xthead_any" 
> configuration entry that is the sum of all of those.
>
>
> r~


