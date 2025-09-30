Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE89CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3UdR-0007l8-NY; Tue, 30 Sep 2025 03:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1v3UdF-0007iO-Ja; Tue, 30 Sep 2025 03:18:45 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1v3Ud8-0004I3-Rs; Tue, 30 Sep 2025 03:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kIuqZxp4Yh/C52yVukBIvOlMaFaQOLAprRWAbW01j3w=; b=BJ9Jlsn45MrEBamHZwxJcErl1B
 x9zjoeCwvwolXgmy7z4SS37LrXipQoH1OAESZE3Q5ljqjw4ryGP9vCevISMnX4wTinr0MX/wgxM6L
 5VQ1hdItnerV5oW7SSc+OEe7wm7xRsxIqfVnw7TEus6NWyGMZCvYePngW4PxNK7UKukj6cC9gXdWc
 ehiuoLr1Gn1l04fRsXckMIfSQrA4mSUghrfj1SsPt4MwsKWGnDutQLLpGNtiOTTTvUHkNA5yHOIsT
 wenJF+XblRAsgbYfibFef53Ww+F+dU494kxvtc3SRDgaOdFqe0eOfOq66uN9mstPT1xEdBtx3AcKC
 Z14Q1KsA==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1v3Uct-004jqh-3Z; Tue, 30 Sep 2025 08:18:19 +0100
Message-ID: <6be4bfa5-006c-40c1-b1d6-37eece96fca1@codethink.co.uk>
Date: Tue, 30 Sep 2025 08:18:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix endianness swap on compressed
 instructions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-trivial@nongnu.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 vhaudiquet <vhaudiquet343@hotmail.fr>, anjo@rev.ng,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
 <cc5b1d2c-90cb-4276-a192-fd0ce9e926e8@linaro.org>
 <95dbbcf4-41fa-481b-9e23-96ed51f66264@canonical.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <95dbbcf4-41fa-481b-9e23-96ed51f66264@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/09/2025 07:59, Heinrich Schuchardt wrote:
> On 9/29/25 16:37, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>>
>> On 29/9/25 13:55, Valentin Haudiquet wrote:
>>> From: vhaudiquet <vhaudiquet343@hotmail.fr>
>>>
>>> Three instructions were not using the endianness swap flag, which 
>>> resulted in a bug on big-endian architectures.
>>
>> I suppose you mean "big-endian host architectures".
>> If so, please clarify.
> 
> Hello Phil,
> 
> Ubuntu is providing QEMU to emulate RISC-V both on little-endian hosts 
> like X86 and ARM as well as on big-endian hosts like the IBM S/390.
> 
> The Unprivileged RISC-V ISA Specification has this sentence:
> 
> "The base ISA has been defined to have a little-endian memory system, 
> with big-endian or bi-endian as non-standard variants."
> 
> According to the Privileged RISC-V ISA Specification the mstatus and 
> mstatush register may be used to set the endianness at runtime.
> 
> "The MBE, SBE, and UBE bits in mstatus and mstatush are WARL fields that 
> control the endianness of memory accesses other than instruction 
> fetches. Instruction fetches are always little-endian."
> 
> Currently RISC-V work focuses on little-endian targets but there is 
> active community work to enable big-endian Linux for RISC-V.
> 
> Therefore a solution is required that considers both the host and the 
> target endianness.
> 
>>
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
>>> Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828
>>>
>>> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>>> ---
>>>   target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/ 
>>> riscv/ insn_trans/trans_rvzce.c.inc
>>> index c77c2b927b..dd15af0f54 100644
>>> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
>>> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
>>> @@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, 
>>> arg_c_lbu *a)
>>>   static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
>>>   {
>>>       REQUIRE_ZCB(ctx);
>>> -    return gen_load(ctx, a, MO_UW);
>>> +    return gen_load(ctx, a, MO_TEUW);
>> NAck.
>> Please do not use MO_TE* anymore. Use explicit endianness.
>>
>> So far all our RISC-V targets are little-endian:
>>
>>    $ git grep TARGET_BIG_ENDIAN configs/targets/riscv*
>>    $
>>
>> If you are not worried about RISCV core running in BE mode
>> (as we currently don't check MSTATUS_[USM]BE bits), your change
>> should be:
>>
>>   -    return gen_load(ctx, a, MO_UW);
>>   +    return gen_load(ctx, a, MO_UW | MO_LE);
> 
> I saw your patches to remove MO_TE from little-endian only targets like 
> i386 but RISC-V is different.
> 
> We should foresee that in future RISC-V targets run in either little- 
> endian or big-endian mode and implement our code accordingly.
> 
> When big-endian RISC-V comes upon QEMU, we should avoid duplicating the 
> target code but reuse what we have.
> 
> MO_UW | MO_LE looks wrong in this context.
> 
> We should stay consistent with
> 
> target/riscv/insn_trans/trans_rvi.c.inc
> target/riscv/insn_trans/trans_rvzfh.c.inc
> target/riscv/insn_trans/trans_xthead.c.inc
> 
> which currently use MO_TEUW.
> 
> For the time being, I would suggest to stick to MO_TE* to maintain the 
> information in which code locations we need to consider the target 
> endianness.
> 
> Targets that can switch endianness at runtime (e.g. MIPS) use an 
> architecture specific implemenation of mo_endian(ctx). When implementing 
> big-endian RISC-V support in future, we can use the MO_TE occurrences as 
> indicator where to use mo_endian() instead.
> 
> With these considerations in mind the current patch looks good to me.
> 
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

You've reminded me that we still haven't managed to get movement on
the big-endian runtime patches.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

