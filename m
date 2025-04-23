Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C95C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7aZg-00044N-1b; Wed, 23 Apr 2025 09:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1u7aZd-000447-VE; Wed, 23 Apr 2025 09:55:37 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1u7aZb-0006G6-FD; Wed, 23 Apr 2025 09:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJWfKt3Nzg2uxMFT7GSfrs8BrAsmmHaSQ9gT2O7SMdo=; b=RsAZE77hMl6fZJmeIwZWtxrwag
 dasREMyEIYQJiMVvdj5X+A8KlPbrLQRgS0WY3Ac++5EHFusHlS3JRBfomFkaBwK+RtjKJY3loPSEK
 lgdWkB0iT/CfTPd74rSwqTH90VG1IOI7Kgu2OnB3moV3jVIlqq198QgbJWe6uHlTh8GrqTXbd168t
 9igKs9nlaQTuar3TUQx8Eu+whXP8BeHEAQxQlbYfyvQJ6tEm8Jl71bw3ZUTOncfkBx/tmuUeIxVXy
 kdM2WSkrrrT3t2vY6jiqpv8KtbQlnlEZxBEqLyawd5+vD+Zqy/axYpn9ikjJxAZNXiUZNnC4g33Io
 ck+Le3pQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1u7aYl-001JoX-0L; Wed, 23 Apr 2025 14:54:43 +0100
Message-ID: <ee7e6775-9dd7-48b4-a5f3-9189b1386deb@codethink.co.uk>
Date: Wed, 23 Apr 2025 14:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
To: Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
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
 <275dd8a6-c4f7-47de-ac45-64612e14b8a7@redhat.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <275dd8a6-c4f7-47de-ac45-64612e14b8a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 23/04/2025 14:08, Paolo Bonzini wrote:
> On 4/23/25 12:09, Ben Dooks wrote:
>> In adding a new feature to the riscv target, it turns out the
>> tb_flags had already got to the 32-bit limit. Everyone other target
>> has been fine with uint32_t (except perhaps arm which does somethng
>> strange to extend tb_flags, I think).
>>
>> To allow extending of tb_flags to be bigger, change the uint32_t to a 
>> tb_flags_t which a target can define to be bigger (and do this for 
>> riscv as having tb_flags_t be uint64_t somewhere is necessary to
>> pick out bugs in this translation).
>>
>> This method of extension also stops having to go through each arch 
>> fixing field usage and anything else that may arise, and given this is 
>> currently only affecting the tcg, it can be done per target arch.
>>
>> Note, target/riscv does not currently use any of the other flag bits 
>> yet. The work is done as we would like to try the big-endian riscv 
>> again and someone has already taken the last bit we where using at 
>> (target/riscv/cpu.h#L666 adding PM_SIGNEXTEND where we had BE_DATA)
> 
> Leaving aside your patch I think you can improve the density of the 
> tbflags a bit too:
> 
> - PM_MASK_ENABLED, PM_BASE_ENABLED and AXL are unused, which gives you 
> back 4 bits.

Hmm, the PM_MASK_ENABLED, PM_BASE_ENABLED are also used by VMA and VTA
which i've not checked if they're actually used from the ctx.

> 
> - VLMUL == 4 is invalid, and you can use that to get rid of VILL
> 
> - SEW reserves 3 bits, but TCG only supports 8/16/32/64; that could be 
> one more bit if you can live with the limitation
> 
> This is already 6 bits, but for FS and VS it may be efficient enough to 
> have just one bit (dirty vs. everything else): for all cases other than 
> dirty, REQUIRE_FPU and require_rv* can call a helper to look at the 
> actual MSTATUS and generate the exception if the extension is disabled; 
> then the caller always proceeds with translation into TCG ops(*).  The 
> overhead for the DISABLED/INITIAL/CLEAN cases is minimal and it gives 
> back 2 more bits.
> 
> Finally, in many cases it makes sense to do a full TB flush when CSRs
> change.  However I am not sure if this could be done for RISC-V, maybe 
> for the CFI enabled bits?

I'll have a look at those, but for now I'm going back to 9.1


> Thanks,
> 
> Paolo
> 
> (*) that is:
> 
> static bool require_rvv(DisasContext *s)
> {
>      REQUIRE_EXT(s, RVV);
>      if (!s->mstatus_vs_dirty) {
>          gen_helper_require_rvv(tcg_env);
>      }
>      return true;
> }
> 
> static bool require_rvf(DisasContext *s)
> {
>      switch (s->sew) {
>      case MO_16:
>          if (!s->cfg_ptr->ext_zvfh) {
>              return false;
>          }
>          break;
>      case MO_32:
>          if (s->cfg_ptr->ext_zve32f) {
>              return false;
>          }
>          break;
>      case MO_64:
>          if (s->cfg_ptr->ext_zve64d) {
>              return false;
>          }
>          break;
>      default:
>          return false;
>      }
> 
>      if (!s->mstatus_fs_dirty) {
>          gen_helper_require_rvf(tcg_env);
>      }
>      return true;
> }
> 
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

