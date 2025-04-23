Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D81C369D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zrv-0001Y5-LE; Wed, 23 Apr 2025 09:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1u7Zrd-0001Ux-3B; Wed, 23 Apr 2025 09:10:13 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1u7Zra-00004q-HN; Wed, 23 Apr 2025 09:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=548glwDwT3gf3W/atNFlp97rN1ZgX6DbG9TIWRiaags=; b=JEANxF7de6Dfhy7fikrBLu4V4g
 EffgbXomWZYUGzJFNAEnpE2Ipn9hajnWxLHTT7Le3qqvKBNutr3yRvilOP5TwkmDgkKJsvtiOVecK
 fwZlcLPf5SOI4UofNltqwyg0lqE9uk5mZq+6c0iZ6t+gL/JCD/jUNdZ2H9LLG9XGqD6vrnt050YrA
 z8jBRPlLpnsrDjwRGuHVVHI3ueEhk8N2Vdf74P19AoXug7BnBOlqMo3JGTWKpwyDzCj/hOsydwArL
 vXYVJC+1wiWJ0dx1h4LZLOPcDh6BsVT0i8sP4c6q9XzKbnm05oNk+WpnuS1qSewtJZGJazoV6MDJw
 vCcrOmvQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1u7Zqd-001ICB-Te; Wed, 23 Apr 2025 14:09:08 +0100
Message-ID: <251b8459-3007-4fc2-85b8-aea81e16bc2a@codethink.co.uk>
Date: Wed, 23 Apr 2025 14:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
To: richard.henderson@linaro.org, pbonzini@redhat.com,
 peter.maydell@linaro.org, mrolnik@gmail.com, brian.cain@oss.qualcomm.com,
 deller@gmx.de, zhao1.liu@intel.com, gaosong@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, shorne@gmail.com,
 npiggin@gmail.com, danielhb413@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 ysato@users.sourceforge.jp, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23/04/2025 11:09, Ben Dooks wrote:
> In adding a new feature to the riscv target, it turns out the tb_flags
> had already got to the 32-bit limit. Everyone other target has been
> fine with uint32_t (except perhaps arm which does somethng strange to
> extend tb_flags, I think).
> 
> To allow extending of tb_flags to be bigger, change the uint32_t to
> a tb_flags_t which a target can define to be bigger (and do this for
> riscv as having tb_flags_t be uint64_t somewhere is necessary to pick
> out bugs in this translation).
> 
> This method of extension also stops having to go through each arch
> fixing field usage and anything else that may arise, and given this
> is currently only affecting the tcg, it can be done per target arch.
> 
> Note, target/riscv does not currently use any of the other flag bits
> yet. The work is done as we would like to try the big-endian riscv
> again and someone has already taken the last bit we where using at
> (target/riscv/cpu.h#L666 adding PM_SIGNEXTEND where we had BE_DATA)
> 
> Q: Do the cpu_get_tb_state calls need uint32_t changing to the
> tb_flag_t as part of this?
> 
> Q: As part of this, should we also define a FLAG_DP_TB or similar
> wrapper for the relevant change?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

So after trying this, it looks like the struct TranslationBlock also
has a flags field in it and we missed updating that which had a follow
on issue of causing failures elsewhere.

Need to look into whether we should add a config and a global
tb_flags_t or if the TranslationBlock can include something that
defines tb_flags_t

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

