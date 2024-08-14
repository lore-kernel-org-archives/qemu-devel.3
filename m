Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB0C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se3jq-0004YW-Es; Tue, 13 Aug 2024 22:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1se3jo-0004Vc-DZ; Tue, 13 Aug 2024 22:27:48 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1se3jl-00018Z-Rd; Tue, 13 Aug 2024 22:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723602456; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=QuUGDTFpY6SZKjiZhvS8WIJeF8HfDxa2XVinMblpFD8=;
 b=cc+IYVqa/53RWKavQ/e8ywKlWBrlEEaR53xp2Q6faDA5BFPVhCf+tjyB64uvXLE5w2vhk6N0wp6gqfoKxU63fr7n+1Rw4y0zkHkGUYw5FoF6iuWnDNH6t4y0MiLzH2sqxOtnx0KGqO8CUdOXtsj0kL0jCWKK557yIhYf2QnOs9c=
Received: from 30.166.64.117(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCqbVqn_1723602453) by smtp.aliyun-inc.com;
 Wed, 14 Aug 2024 10:27:33 +0800
Message-ID: <5f1f74de-3403-4371-97eb-f376e65b7ae5@linux.alibaba.com>
Date: Wed, 14 Aug 2024 10:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] tcg: Fix register allocation constraints
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
 <2efe353a-4700-4632-b919-e43cb039c2c0@linaro.org>
 <1e61235e-1cb8-4bc1-9983-6e8dc0c3b406@linux.alibaba.com>
 <149df4e8-f51c-4925-8c65-e8e10fed85a3@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <149df4e8-f51c-4925-8c65-e8e10fed85a3@linaro.org>
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


On 2024/8/14 10:04, Richard Henderson wrote:
> On 8/14/24 10:58, LIU Zhiwei wrote:
>> Thus if we want to use all registers of vectors, we have to add a 
>> dynamic constraint on register allocation based on IR types.
>
> My comment vs patch 4 is that you can't do that, at least not without 
> large changes to TCG.
>
> In addition, I said that the register pressure on vector regs is not 
> high enough to justify such changes.  There is, so far, little benefit 
> in having more than 4 or 5 vector registers, much less 32.  Thus 7 
> (lmul 4, omitting v0) is sufficient.

At least on QEMU, SVE can support 2048 bit vector length with 
'sve-default-vector-length=256'.  Software optimized with SVE, such as 
X264 can benefit with long SVE length in less dynamic A64 instructions.

We want to expose all host vector ability. Thus the largest 
TCG_TYPE_V256 is not enough, as 128-bit RVV can give 8*128=1024 width 
operation. We have expand TCG_TYPE_V512/1024/2048 types(not in this 
patch set, but intend to upstream later).
With large TCG_TYPE_V1024/2048, we get better performance on RISC-V 
board with much less translated RISC-V vector instructions. We can give 
a more detailed experiment result if needed.

However, we will only have 3 vector register when support 
TCG_TYPE_V1024.  And even less for TCG_TYPE_V2048.  Current approach 
will give more vectors TCG_TYPE_V128 even with support TCG_TYPE_V1024, 
which will relax some guest NEON register pressure.

Thanks,
Zhiwei

>
>
> r~

