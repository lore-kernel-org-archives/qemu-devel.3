Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA51CFA477
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLmO-00013s-A1; Fri, 21 Nov 2025 02:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLmM-00013E-9c
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:42:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLmJ-0005ld-0l
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:42:02 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so981364f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763710916; x=1764315716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L1ma/FgOyn6F5DDDvAZGScTkgrExcWHFs5u8FhdaZUg=;
 b=I4kdN48RaKhHAikpiwpY/CNjhB0ZBRPSA//905mhFaQTQAa3B6FNvL1//AFU0sm10X
 pSE3Sd3+JG3vlChw1OTaKm4BaMMpGmbOVFnlr9tz9RYq95Tx28600xNSZrig9d2ZDQ/x
 mizVepBs9lLh1CQkYMxbcy1d1N9ugjAblJ/wB4SujoslKmdvW58vSdsFE09dJ+9cumUV
 RD/SckCfCCmOYsoNsdlD6kEVnu+8xCdKSPmc5pk1Do3qCSK4VN7ni+eTmEWFJa9mzGGj
 KAR4cyHZ71ApK6puhZFlTfjBr0+yg/Iikr9nVE3yigM26sib9lEgg30CNvw3QFeLbXrs
 Z7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763710916; x=1764315716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1ma/FgOyn6F5DDDvAZGScTkgrExcWHFs5u8FhdaZUg=;
 b=BJLRBGpUrVKtR27rI/9W4VULWOrEhDoCVNZ1gyJkgAbtq5YdHoTlNKHoE+nO7L4cfG
 cMMR+zxZ99CU9VgB4Hybqu/bHLe76lMOxJIZL/I5JAeym1CT5AflPg4/ByknWgmZNyNH
 jUAQ2gavr1d1ZuTsCPVtaYZFC0Pi4PcpIvlv2rfF9xlqv3eCS08psMoATmNnfhYcLVpO
 WjHtIhrM1agr4mlI+cy6LRrthCJmYAD40ND14FQlB2CX89mWDRlhB7d/OiHrf42LnikN
 GOe+6TZLjRc/ps2X3K81UdshKFIJxBwP9ktFbVjFMNEluqq2zpE9h3W7UBUNuwszTIEn
 r9Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1L60PXmJuWgOibuGxhXZ0LiZsjIGkZ3wMNRpQT1mHTDe3oXX8dIemv2gOXUQlS40XjVdJbnZcurmv@nongnu.org
X-Gm-Message-State: AOJu0YyY4hmCXTSe50enrjQZyEbUBIRJWdMl6kM3Rzv9Tx95HrnxDfTm
 cr1FHt+p7LfNX5887YQHYDiDBPp2odASiZS2K2fyySF1mMlhRTkjilYqmeTxf7YufJE=
X-Gm-Gg: ASbGncu19tFESEcQIkuF58/AAKlGcJceIpDazxmk260+3Up9kwGZLeDinUlXNGw9VeV
 BiVULA3g247sMyN+NKKaT9JJfTuTJ4WO8N74wKC9F21NDw+JPRhwasDJMTpX8hCI28w77szSC/c
 0uH8uhptQLOGvQBh+UsRxdzN0X8F3c1lHbNLTosGqSLFekprVX4vIIyNarSBiRpCA0ToHjMGroU
 qnfQ8vJ0qU/ahalO9c9GL3/xzul30QDwX3enQk9zc11qyQ/9lowX+WqbK3R599INPG0Q2ZI+1S4
 rz29h0peEIMOXlxK+IKTurbu9grY2a4QamvabHe9UjMSXlvBKYdL8EWTvNqr8LcyMQLoaTZgydt
 g3UCRalAxB4VQ8Zj2B2PxBLdbKnRSVjJw/cn0TZLvdzSpVy28ZTkhugCCJwAqa9vcZ1e+3zx82x
 3ra17DqdzmfoHkp5F1nSThA8ojI0mo50TM3sTWqEAQ1zO4qXM9gobdGA==
X-Google-Smtp-Source: AGHT+IFStL+sfVxup5vil7E7ot3Uzb0O0qqSAlc0Ome8ai0acGyOjot4XlKspPovgMmuEv0k4n7dwg==
X-Received: by 2002:a05:6000:1448:b0:429:f0a4:22e with SMTP id
 ffacd0b85a97d-42cc1d3a800mr990706f8f.54.1763710915531; 
 Thu, 20 Nov 2025 23:41:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e432sm9172211f8f.9.2025.11.20.23.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:41:54 -0800 (PST)
Message-ID: <442e57d9-74f1-4a46-be5a-70158ce0c8ea@linaro.org>
Date: Fri, 21 Nov 2025 08:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add RISCV Zilsd extension
Content-Language: en-US
To: Roan Richmond <roan.richmond@codethink.co.uk>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
References: <20251110090510.84103-1-roan.richmond@codethink.co.uk>
 <CAKmqyKPheAMZt6cn2d4bN2kPxXMrr5Vr8jY5+MBuqhptnc4wjw@mail.gmail.com>
 <19ada6a7-089e-4103-9c2f-c6a9a0e7add2@codethink.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <19ada6a7-089e-4103-9c2f-c6a9a0e7add2@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Roan,

On 13/11/25 09:53, Roan Richmond wrote:
> On 12/11/2025 01:41, Alistair Francis wrote:
>> On Mon, Nov 10, 2025 at 7:05 PM Roan Richmond
>> <roan.richmond@codethink.co.uk> wrote:
>>> This is based on v1.0 of the Zilsd extension [1].
>>> The specification is listed as in the Ratified state [2],
>>>   since Jan 30, 2025.
>>>
>>> [1]: https://github.com/riscv/riscv-zilsd
>>> [2]: https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/ 
>>> RISC-V+Specs+Under+Development
>>>
>>> Reviewed-by: Daniel Henrique barboza <dbarboza@ventanamicro.com>
>>> Reviewed-by: Richard Henderson  <richard.henderson@linaro.org>
>>> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
>>> ---
>>> v2:
>>>    - In `gen_load_zilsd` swapped `dest_gpr` with `tcg_temp_new`, this 
>>> prevents
>>>      writing to `r1/r0` in the case where `r0` is the set as `rd`.
>>>    - Removed unneeded brackets around `a->rd` + c expressions
>>>
>>>   target/riscv/cpu.c                      |  2 +
>>>   target/riscv/cpu_cfg_fields.h.inc       |  1 +
>>>   target/riscv/insn_trans/trans_rvi.c.inc | 57 ++++++++++++++++++++++++-
>>>   3 files changed, 58 insertions(+), 2 deletions(-)


>>> @@ -482,6 +509,27 @@ static bool gen_store_tl(DisasContext *ctx, 
>>> arg_sb *a, MemOp memop)
>>>       return true;
>>>   }
>>>
>>> +/* Zilsd extension adds load/store double for 32bit arch */
>>> +static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
>>> +{
>>> +    TCGv data_1 = tcg_temp_new();
>>> +    TCGv data_2 = tcg_temp_new();

[*]

>>> +    if (a->rs2 != 0) {
>>> +        data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
>>> +        data_2 = get_gpr(ctx, a->rs2+1, EXT_NONE);
>>> +    }
>> Don't mix code and declarations, otherwise
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> Alistair
> Struggling to see what you mean by this.
> 
> Could you provide a bit more clarification on the changes you would like 
> me to make and then I'll send out a v3.
> 
> Thanks,
> Roan
> 
>>
>>> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);

The declaration part is:

    TCGv addr_1;

and the code part is:

    addr_1 = get_address(ctx, a->rs1, a->imm);

Per our coding style (docs/devel/style.rst) chapter "Declarations":

    Mixed declarations (interleaving statements and declarations
    within blocks) are generally not allowed; declarations should
    be at the beginning of blocks.

Declarations should go in [*].

For v3 you should address Richard's comments.

Regards,

Phil.

>>> +    TCGv addr_2 = get_address(ctx, a->rs1, a->imm+4);
>>> +
>>> +    if (ctx->ztso) {
>>> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>>> +    }
>>> +
>>> +    tcg_gen_qemu_st_tl(data_1, addr_1, ctx->mem_idx, MO_SL);
>>> +    tcg_gen_qemu_st_tl(data_2, addr_2, ctx->mem_idx, MO_SL);
>>> +    return true;
>>> +}
>>> +
>>>   static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>>>   {
>>>       TCGv src1l = get_gpr(ctx, a->rs1, EXT_NONE);
>>> @@ -511,6 +559,8 @@ static bool gen_store(DisasContext *ctx, arg_sb 
>>> *a, MemOp memop)
>>>       decode_save_opc(ctx, 0);
>>>       if (get_xl(ctx) == MXL_RV128) {
>>>           return gen_store_i128(ctx, a, memop);
>>> +    } else if (memop == MO_UQ && get_xl(ctx) == MXL_RV32) {
>>> +        return gen_store_zilsd(ctx, a);
>>>       } else {
>>>           return gen_store_tl(ctx, a, memop);
>>>       }
>>> @@ -533,7 +583,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>>>
>>>   static bool trans_sd(DisasContext *ctx, arg_sd *a)
>>>   {
>>> -    REQUIRE_64_OR_128BIT(ctx);
>>> +    /* Check for Zilsd extension if 32bit */
>>> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
>>> +        return false;
>>> +    }
>>>       return gen_store(ctx, a, MO_UQ);
>>>   }
>>>
>>> -- 
>>> 2.43.0
>>>


