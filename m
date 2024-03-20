Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CC0C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 02:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmltj-0005cs-Vc; Tue, 19 Mar 2024 22:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rmlti-0005c6-Fw; Tue, 19 Mar 2024 22:41:46 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rmltg-0006BT-41; Tue, 19 Mar 2024 22:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710902489; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=zUQbuKIGDIGmQijVfWwtup6rm2YaudwQCJMVWSxE/3U=;
 b=cUoTSOxzUzRHV90pXjzjCn5GbBwfnaJ+uKz0CS/Om25FrMh9U9VCz7+NMsdclTtSeQUALZDF7DlT4MmaLtNvk+U/L9Nc9JB4aMHR7YDf+r7dA63n7VhjPBRnQhZJ00R46s8pSNtGVVU6EkXHHTSmBzqhkgWYZH1jTSGBsDNtenc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2vb3IZ_1710902487; 
Received: from 30.21.185.204(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W2vb3IZ_1710902487) by smtp.aliyun-inc.com;
 Wed, 20 Mar 2024 10:41:28 +0800
Message-ID: <c7487e4c-2d9a-42db-b920-30f1463e8a34@linux.alibaba.com>
Date: Wed, 20 Mar 2024 10:41:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Add right functions to set agnostic
 elements
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
 <20240306092013.21231-3-eric.huang@linux.alibaba.com>
 <c765adcb-2702-45d3-b875-6eaa6b6d7d0c@ventanamicro.com>
 <675f13e6-4030-4099-a97b-f5bd38d030e9@linaro.org>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <675f13e6-4030-4099-a97b-f5bd38d030e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
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

I will rewrite the patch, and send a new version soon.

Thanks,

Huang Tao

On 2024/3/20 07:32, Richard Henderson wrote:
> On 3/19/24 11:57, Daniel Henrique Barboza wrote:
>> This seems correct but a bit over complicated at first glance. I 
>> wonder if we have
>> something simpler already done somewhere.
>>
>> Richard, does ARM (or any other arch) do anything of the sort? Aside 
>> from more trivial
>> byte swaps using bswap64() I didn't find anything similar.
>
> No, nothing quite like.
>
>> We recently posted a big endian related fix here:
>>
>> [PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix 'vmvr_v' 
>> memcpy endianess
>>
>> But not sure how to apply it here.
>
> It's almost exactly the same, only with memset instead of memcpy.
>
>     if (HOST_BIG_ENDIAN && idx % 8 != 0) {
>         uint32_t j = ROUND_UP(idx, 8);
>         memset(vd + H(j - 1), -1, j - idx);
>         idx = j;
>     }
>     memset(vd + idx, -1, tot - idx);
>
>
> I'll note that you don't need to change the api of vext_set_elems_1s 
> -- so most of these patches are not required.
>
>
> r~

