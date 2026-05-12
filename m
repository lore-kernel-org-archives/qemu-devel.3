Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EFFCD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcve-0004B0-9x; Mon, 11 May 2026 22:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcvc-0004Ao-Uh; Mon, 11 May 2026 22:33:00 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcvU-0003fX-2u; Mon, 11 May 2026 22:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778553162; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=5Fs3v41EJHi7RqIDNm6WZbz78tVOSQgULvXqDnWe/4E=;
 b=CK87anTm9weuMYkMk+RoP1tkJzkDIsnf5CWTwv4GSAFUF7HKpaM2nQonbo/abLumMNUzMA8rXA7/BsZ1+6kh8MoOEtwAYtJERF+Q17AlashG/sxYE1aiwkaGG8brEkFmjrkhWlL/PQFgiAe5LPhV9S+eFX4IPjUPUL8cD1sNKUw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X2oliUV_1778553160; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2oliUV_1778553160 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:32:41 +0800
Message-ID: <1846c9bd-61c2-4ee0-8f61-0a95ba82eda7@linux.alibaba.com>
Date: Tue, 12 May 2026 10:32:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] target/riscv: Implement SMMPT fence instructions
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
 <CANzO1D1m3Jht1BNuPi3MvCr=iQRHWSgEGZqHryNof=m4Dra7SA@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CANzO1D1m3Jht1BNuPi3MvCr=iQRHWSgEGZqHryNof=m4Dra7SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Frank,

On 4/13/26 4:19 PM, Frank Chang wrote:
> Hi Zhiwei,
>
> LIU Zhiwei <zhiwei_liu@linux.alibaba.com> 於 2026年4月9日週四 上午3:24寫道：
>> This patch completes the SMMPT implementation by adding support for the
>> new fence instructions: `mfence.spa` and `minval.spa`.
>>
>> According to the specification, these instructions act as memory ordering
>> fences for MPT updates. In QEMU's TCG model, this is conservatively
>> implemented by flushing the entire TLB, which ensures that any subsequent
>> memory accesses will re-evaluate permissions and see the effects of any prior
>> MPT modifications.
>>
>> The instructions are privileged and will cause an illegal instruction
>> exception if executed outside of M-mode.
>>
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/insn32.decode                    |  2 ++
>>   .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index 6e35c4b1e6..84cec57daf 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>>   mret        0011000    00010 00000 000 00000 1110011
>>   wfi         0001000    00101 00000 000 00000 1110011
>>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
>> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>>
>>   # *** NMI ***
>>   mnret       0111000    00010 00000 000 00000 1110011
>> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
>> index 8a62b4cfcd..5ec6bf5991 100644
>> --- a/target/riscv/insn_trans/trans_privileged.c.inc
>> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
>> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>>   #endif
>>       return false;
>>   }
>> +
>> +#define REQUIRE_SMSDID(ctx) do {          \
>> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
>> +        return false;                     \
>> +    }                                     \
>> +} while (0)
>> +
>> +static bool do_mfence_spa(DisasContext *ctx)
>> +{
>> +#ifndef CONFIG_USER_ONLY
>> +    REQUIRE_SMSDID(ctx);
>> +    if (ctx->priv != PRV_M) {
>> +        return false;
>> +    }
>> +    decode_save_opc(ctx, 0);
>> +    gen_helper_tlb_flush_all(tcg_env);
>> +    return true;
>> +#endif
>> +    return false;
>> +}
>> +
>> +static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
>> +{
>> +    return do_mfence_spa(ctx);
>> +}
>> +
>> +static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
>> +{
>> +    return do_mfence_spa(ctx);
>> +}
> The spec says that:
> "When Svinval is implemented with Smsdid, the MINVAL.SPA instruction
> must be implemented to
> support such fine-granular invalidation of physical memory
> access-permission caches."

I see it is just "when", not explicitly requires Svinval. Another reason 
is that we  implement minval.spa on QEMU in a not such fine-granular 
invalidation way. Thus I don't make it require Svinval in v6 patch set. 
If you have other comments, let me know.

Thanks,
Zhiwei

>
> So I think we should call REQUIRE_SVINVAL() for MINVAL.SPA.
> However, trans_privileged.c.inc is included before trans_svinval.c.inc.
> So it might be better to separate these instructions into trans_smmpt.c.inc
> and include it after trans_svinval.c.inc.
>
> Regards,
> Frank Chang
>
>> --
>> 2.43.0
>>
>>

