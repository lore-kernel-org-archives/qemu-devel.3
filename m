Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226A5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Ot-00064G-1y; Wed, 31 Jul 2024 07:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZ7Or-0005zF-Fa; Wed, 31 Jul 2024 07:21:45 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZ7Ok-0007VX-CB; Wed, 31 Jul 2024 07:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722424888; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=tC3Ku7djqienx5qdftiwGyt+xRIeB8SpBNvj0iOVh4E=;
 b=wbhXXZTPAcNWG1Pogx560vMBQNgM36QUfv5ruO04GWZIKgQCZ1OJ9Nj/dmdA+gQOVRNcT4zNtJm4QdadDzXj7rp9cf3myDq2dj5zNsgUAnmn8yBi/4G6prL1IwjUaPcPfkBzuqPWfvrhH+PubpEaE/sdhnUJaAI4JCD1YkoFGWo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0WBjLE3E_1722424885; 
Received: from 30.166.64.102(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBjLE3E_1722424885) by smtp.aliyun-inc.com;
 Wed, 31 Jul 2024 19:21:26 +0800
Message-ID: <9a05c6f9-fdef-484a-a836-1d3da9be0935@linux.alibaba.com>
Date: Wed, 31 Jul 2024 19:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
 <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
 <ca1b9449-f6e0-412c-829a-bc6258f461ff@linux.alibaba.com>
 <CAKmqyKMftPJuLDc=8vR5R=j90CPYHxM1NscMB_fXk2SUgfM5pQ@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKMftPJuLDc=8vR5R=j90CPYHxM1NscMB_fXk2SUgfM5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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


On 2024/7/31 17:38, Alistair Francis wrote:
> On Thu, Jul 25, 2024 at 11:53 AM LIU Zhiwei
> <zhiwei_liu@linux.alibaba.com> wrote:
>>
>> On 2024/7/23 13:59, Richard Henderson wrote:
>>> On 7/23/24 15:29, LIU Zhiwei wrote:
>>>> The more detailed information about its meaning is in priviledged
>>>> 1.13 specification. More exactly, in 3.6.4. Misaligned Atomicity
>>>> Granule PMA.
>>>>
>>>> The specification said:
>>>>
>>>> "The misaligned atomicity granule PMA applies only to AMOs, loads and
>>>> stores defined in the base
>>>> ISAs, and loads and stores of no more than MXLEN bits defined in the
>>>> F, D, and Q extensions. For an
>>>> instruction in that set, if all accessed bytes lie within the same
>>>> misaligned atomicity granule, the
>>>> instruction will not raise an exception for reasons of address
>>>> alignment, and the instruction will give
>>>> rise to only one memory operation for the purposes of RVWMO—i.e., it
>>>> will execute atomically."
>>>>
>>>> That's the reason why I do not apply zama16b to compressed instructions.
>>> Given the non-specificity of this paragraph, I think not specifically
>>> calling out compressed forms of the base ISA is simply a documentation
>>> error.  In general, the compressed ISA is supposed to be a smaller
>>> encoding of the exact same instruction as the standard ISA.
>> Yes, it's a documentation error. We will fix in the specification.
>>
>> https://github.com/riscv/riscv-isa-manual/pull/1557
> Thanks for getting that clarified
>
> What's the status of a followup patch? We should fix this before the release

I will send the follow patch  as soon as possible.  And resolve another 
comment Richard gives later as it need some work on PBMT(I think).

Thanks,
Zhiwei

>
> Alistair

