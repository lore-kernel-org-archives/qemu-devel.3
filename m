Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E643C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 01:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWneo-00063c-ST; Wed, 24 Jul 2024 21:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWnem-00062Z-P1; Wed, 24 Jul 2024 21:52:36 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWnej-0002L7-Ia; Wed, 24 Jul 2024 21:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721872344; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=2X5tM3arX2FaqGeafZf05pc7XMS3xztGVn1X/kbQmz4=;
 b=adAH9rvJ/kf/v3OElbPS0BoaOkM4pZaMdD0rW/P6F+GZtnLB9aZTeEbihXFHLi0CTCuzIdWl9bL+/vuGnFHmVEUsT3AulqolyA8efK30PoAlxNhZ3GDk8s9YLv2B627eUoLO9yMHnccHrXIPt3DtZ8zDkGI4IK5SeLT9/Mw+Fvs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032019045;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBFnJYf_1721872342; 
Received: from 30.166.64.206(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBFnJYf_1721872342) by smtp.aliyun-inc.com;
 Thu, 25 Jul 2024 09:52:22 +0800
Message-ID: <ca1b9449-f6e0-412c-829a-bc6258f461ff@linux.alibaba.com>
Date: Thu, 25 Jul 2024 09:50:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
 <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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

Yes, it's a documentation error. We will fix in the specification.

https://github.com/riscv/riscv-isa-manual/pull/1557

Zhiwei

>
> However!  It does explicitly say "no more than MXLEN bits", which 
> means that an RV32/RV64 check is appropriate for FLD/FSD, since MXLEN 
> may be less than 64.
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

