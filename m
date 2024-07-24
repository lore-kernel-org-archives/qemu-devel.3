Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642FC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVZk-0000yQ-Ca; Wed, 24 Jul 2024 02:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWVZg-0000xU-IW; Wed, 24 Jul 2024 02:34:08 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWVZc-0003sI-NT; Wed, 24 Jul 2024 02:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721802832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=DG0bdKAAKodGYuJbTSlYkGjI4jr8LKx8HUsZyKv8omw=;
 b=gK2YgOl4sphzCMAojzXzCQlrOsB0/aZfs1hNeevLiDQVpvfrmgsk0frSlWMRRUF7vmUxtp0Jono/r896SJpPNkEGBYpiH7Wb7/2JQpbGEBcVjcL9Z6H5Trg9IICAqR81PzUcgh1GDon3xQKbuB1rBMYvKpuoaIWW4JvqQbV3LLM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBDHGlV_1721802830; 
Received: from 30.15.255.241(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBDHGlV_1721802830) by smtp.aliyun-inc.com;
 Wed, 24 Jul 2024 14:33:51 +0800
Message-ID: <5c34fb1a-ce46-4039-b887-9ea56488239b@linux.alibaba.com>
Date: Wed, 24 Jul 2024 14:32:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
 <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
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


On 2024/7/23 13:59, Richard Henderson wrote:
> On 7/23/24 15:29, LIU Zhiwei wrote:
>> The more detailed information about its meaning is in priviledged 
>> 1.13 specification. More exactly, in 3.6.4. Misaligned Atomicity 
>> Granule PMA.
>>
>> The specification said:
>>
>> "The misaligned atomicity granule PMA applies only to AMOs, loads and 
>> stores defined in the base
>> ISAs, and loads and stores of no more than MXLEN bits defined in the 
>> F, D, and Q extensions. For an
>> instruction in that set, if all accessed bytes lie within the same 
>> misaligned atomicity granule, the
>> instruction will not raise an exception for reasons of address 
>> alignment, and the instruction will give
>> rise to only one memory operation for the purposes of RVWMO—i.e., it 
>> will execute atomically."
>>
>> That's the reason why I do not apply zama16b to compressed instructions.
> Given the non-specificity of this paragraph, I think not specifically 
> calling out compressed forms of the base ISA is simply a documentation 
> error.  In general, the compressed ISA is supposed to be a smaller 
> encoding of the exact same instruction as the standard ISA.
I will confirm this with the RISC-V community. Thanks.
>
> However!  It does explicitly say "no more than MXLEN bits", which 
> means that an RV32/RV64 check is appropriate for FLD/FSD, since MXLEN 
> may be less than 64.
Yes.  That's true. Although I don't know why MXLEN is needed as F, D or 
Q don't depend on MXLEN. We can implement D extension on RV32 CPU.
>
> In addition, your change for AMOs is incomplete.  From the text:
>
>   If a misaligned AMO accesses a region that does not specify a 
> misaligned
>   atomicity granule PMA, or if not all accessed bytes lie within the same
>   misaligned atomicity granule, then an exception is raised.
>
> The second clause corresponds exactly with the Arm FEAT_LSE2.
> See check_lse2_align in target/arm/tcg/translate-a64.c.
>
>
> r~
>
>
> PS: The first clause is similar to Arm access to pages marked as 
> Device memory, for which all misaligned accesses trap.  I didn't dig 
> deep enough to see how PMAs are defined to suggest how that might be 
> applied.

It's more complex than I once thought. I will do more work before 
sending next version.

Thanks,
Zhiwei


