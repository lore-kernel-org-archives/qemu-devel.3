Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CDBCCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1Gu-00045t-3w; Thu, 06 Nov 2025 09:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vH1Gr-00045X-Kc
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:47:29 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vH1Go-00042W-8M
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:47:28 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so729381a34.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762440444; x=1763045244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXgccf7I5iySfbLwoBZqSZ4fs3thsclpVhNyfz7pkmU=;
 b=T0AzeM7tHVqN38wLk8v0FHFviF9c2CnRAAKD4o0dlLPW+yh2p5ptPcEJ9ZqkwKg+OM
 Hma/VUZW2fiJKwWdnWkyQQvFIKXsnTcYT51Ik6gN3wPuj5TN517j+MpaCbB4xeqq6+Jb
 w4p4IB5Egh4nG+3KFeIjXZKEW7ziz1d1CqOcp654dbQiSjs0DUjvNCiYMcUfqOaSHdh3
 UxxnSXGKqtvb5ZGVUbxPdZp8sDiATRWwhBUZBz+S1yhDBC3u0KO8JSbVeWIFI4yeULlL
 87f55yEYHMkxsW+u7LGS1GKlbgfCdimuqc6VznjjcBntjJ/MulMX6kJi0hRLjPJ5TnAU
 KzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762440444; x=1763045244;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXgccf7I5iySfbLwoBZqSZ4fs3thsclpVhNyfz7pkmU=;
 b=AYinrxovBinKnYdv4DvumeYVi3hYCDPB79sTsCAK57HNvZUMkYXgeo0GjEl+uuEpra
 vBfOF16xmccgW8U9xyAYL6c1iCnPKfl5EO40TDlNYrdR6CwStTTxZ3CjMDJAOd3qFSOY
 fISOJvkzL1rMg/0W9C1Q6tGamPPc0namMc+aApB/jXYZFYDh/AFwJNQG3G2MblmAQ9Jx
 fDqpnP8pcw2LLI1yEzzfMvimwFd/6/+yGi4L3E1KtxwLXME+merwwx0pZRER+7EXhQgK
 Y89XsJWDyM6H0mLUwyBHxs5wgeLk0wz3HRskACMsiJ+vh7um3A66h+oLMUVVuINlN3aV
 B1Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMdWimM0n3bF85Wvm0p1Us7G1pGlAA/G+HA1POHaCoV9oa1coD4iRmk/HKzLZQQS9zhvDVRGiRVyaq@nongnu.org
X-Gm-Message-State: AOJu0YxKLTJksVe6rkdhpq+gzxTGarwRKpXH1gaonJsT4FJwjhIYVxCC
 gFsqmNXSBBxO9VRU9hH2zauWTPyH1ESOOiisA/AFi4YBcW3dM3K9vvFr15KvUsn9/7w=
X-Gm-Gg: ASbGncufvXH/oHbRCpkAFLDSO3q75zwW7QkIMu8h7GFpiYoJ7yVZcRevjH7T10w8NrV
 rh4ui/fVueTXN6Fo5lLaBPtEjg3cNJ32vOYeXKfNtBA2kKpbXvBjXnn7nHqOZwypjMMs9yu05Ze
 Sdb6hEUNuWnwgh2V6nM10rgcsxjYutkoc+4q5n6+S7kpm4/np2CDLBVW/WsbTpXQn+3Vmlcam4F
 sSAaNPOlrZvT/FnWPFr9v4GKZASGqvfQvtuaUM2zayrJ+WlwMV0I/ZcGUb38adEpUC5I2ZmRH/O
 ceS8MreHEZswT3uVrnThs3rAXpCOt7SI8SX3BaJf0toF4tse6XsOjlHfOPbbV7R1JJTsZYPlTvA
 7I4RqLET312hgJOFmqCjIRgIbYFty/7tXPT5s2PQ3CwtjmBeH+brPkrV6FNSEx/PIdNG2Zr7ITx
 e82BiJCHTT8WC/yA==
X-Google-Smtp-Source: AGHT+IFN+PfcOLQGVDRRew6qsBEDqIOoaYcjQmynXT9qDZUKw92TbtdQnMlmQ1jzQ7dFm1IhsYdXkw==
X-Received: by 2002:a05:6830:6d19:b0:788:d698:a0ad with SMTP id
 46e09a7af769-7c6d13e9de1mr5032896a34.24.1762440444223; 
 Thu, 06 Nov 2025 06:47:24 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6e32d1abesm1180433a34.19.2025.11.06.06.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 06:47:23 -0800 (PST)
Message-ID: <6b90bd55-f2c9-4c6c-9058-16ba147f3c0f@ventanamicro.com>
Date: Thu, 6 Nov 2025 11:47:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add RISCV Zilsd extension
To: Roan Richmond <roan.richmond@codethink.co.uk>, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, alistair23@gmail.com
References: <20251104120012.194899-1-roan.richmond@codethink.co.uk>
 <710d9b96-ac43-4d51-b210-65917bf91aa0@ventanamicro.com>
 <6d00d026-25e7-40a7-ad44-348a7aa4fc1a@codethink.co.uk>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <6d00d026-25e7-40a7-ad44-348a7aa4fc1a@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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



On 11/6/25 11:31 AM, Roan Richmond wrote:
> I understand your point about doing the check before the 2 ld_tl() and the 2 dst_gpr() calls.
> 
> My reasoning for doing the check after was the wording of the specification:
> "LD instructions with destination x0 are processed as any other load, but the result is discarded entirely and x1 is not written"
> This suggests that a load instruction is still dispatched but the result is then discarded.

Oh, so it's not a coding choice. In this case let's adhere to the spec as close as
we can (a.k.a keep it as is).


Thanks,

Daniel

> 
> I am happy to move the check if you think it is definitely necessary, otherwise I would prefer to leave it as happening after the calls to ld_tl() and dst_gpr, so we are closer the the expected behavior.
> 
> Thanks,
> Roan
> 
> On 06/11/2025 12:17, Daniel Henrique Barboza wrote:
>>
>>
>> On 11/4/25 8:59 AM, Roan Richmond wrote:
>>> This is based on v1.0 of the Zilsd extension [1].
>>> The specification is listed as in the Ratified state [2],
>>>   since Jan 30, 2025.
>>>
>>> [1]: https://github.com/riscv/riscv-zilsd
>>> [2]: https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/RISC-V+Specs+Under+Development
>>>
>>> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
>>> ---
>>>   target/riscv/cpu.c                      |  2 +
>>>   target/riscv/cpu_cfg_fields.h.inc       |  1 +
>>>   target/riscv/insn_trans/trans_rvi.c.inc | 56 ++++++++++++++++++++++++-
>>>   3 files changed, 57 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 73d4280d7c..6e0d37fb96 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>>       ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>>>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>>>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>>> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_13_0, ext_zilsd),
>>>       ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>>>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>>>       ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
>>> @@ -1247,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>>>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>>>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>>> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>>>       MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>>>       MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>>>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>>> index a154ecdc79..8d8e35e4cf 100644
>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>> @@ -41,6 +41,7 @@ BOOL_FIELD(ext_zicond)
>>>   BOOL_FIELD(ext_zihintntl)
>>>   BOOL_FIELD(ext_zihintpause)
>>>   BOOL_FIELD(ext_zihpm)
>>> +BOOL_FIELD(ext_zilsd)
>>>   BOOL_FIELD(ext_zimop)
>>>   BOOL_FIELD(ext_zcmop)
>>>   BOOL_FIELD(ext_ztso)
>>> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
>>> index 54b9b4f241..dcbb3811d9 100644
>>> --- a/target/riscv/insn_trans/trans_rvi.c.inc
>>> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
>>> @@ -370,6 +370,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a, MemOp memop)
>>>       return true;
>>>   }
>>>   +/* Zilsd extension adds load/store double for 32bit arch */
>>> +static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
>>> +{
>>> +    TCGv dest_1 = dest_gpr(ctx, a->rd);
>>> +    TCGv dest_2 = dest_gpr(ctx, (a->rd)+1);
>>> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
>>> +    TCGv addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
>>> +
>>> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
>>> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
>>> +
>>> +    /* If destination is x0 then result of the load is discarded */
>>> +    if (a->rd == 0) {
>>> +        return true;
>>> +    }
>>
>> Can't we exit earlier in this case? We're doing 2 dst_gpr() calls, 2 get_address() and
>> 2 ld_tl() loads before checking a->rd == 0. Maybe something like this:
>>
>>
>>> +    TCGv addr_1, addr_2, dest_1, dest_2;
>>> +
>>> +    /* If destination is x0 then result of the load is discarded */
>>> +    if (a->rd == 0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    dest_1 = dest_gpr(ctx, a->rd);
>>> +    dest_2 = dest_gpr(ctx, (a->rd)+1);
>>> +    addr_1 = get_address(ctx, a->rs1, a->imm);
>>> +    addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
>>> +
>>> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
>>> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>
>>> +
>>> +    gen_set_gpr(ctx, a->rd, dest_1);
>>> +    gen_set_gpr(ctx, a->rd+1, dest_2);
>>> +    return true;
>>> +}
>>> +
>>>   /* Compute only 64-bit addresses to use the address translation mechanism */
>>>   static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>>>   {
>>> @@ -409,6 +430,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>>>       decode_save_opc(ctx, 0);
>>>       if (get_xl(ctx) == MXL_RV128) {
>>>           out = gen_load_i128(ctx, a, memop);
>>> +    } else if (memop == MO_SQ && get_xl(ctx) == MXL_RV32) {
>>> +        out = gen_load_zilsd(ctx, a);
>>>       } else {
>>>           out = gen_load_tl(ctx, a, memop);
>>>       }
>>> @@ -437,7 +460,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
>>>     static bool trans_ld(DisasContext *ctx, arg_ld *a)
>>>   {
>>> -    REQUIRE_64_OR_128BIT(ctx);
>>> +    /* Check for Zilsd extension if 32bit */
>>> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
>>> +        return false;
>>> +    }
>>>       return gen_load(ctx, a, MO_SQ);
>>>   }
>>>   @@ -482,6 +508,27 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>>>       return true;
>>>   }
>>>   +/* Zilsd extension adds load/store double for 32bit arch */
>>> +static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
>>> +{
>>> +    TCGv data_1 = tcg_temp_new();
>>> +    TCGv data_2 = tcg_temp_new();
>>> +    if (a->rs2 != 0) {
>>> +        data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
>>> +        data_2 = get_gpr(ctx, (a->rs2)+1, EXT_NONE);
>>> +    }
>>> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
>>> +    TCGv addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
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
>>> @@ -511,6 +558,8 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>>>       decode_save_opc(ctx, 0);
>>>       if (get_xl(ctx) == MXL_RV128) {
>>>           return gen_store_i128(ctx, a, memop);
>>> +    } else if (memop == MO_UQ && get_xl(ctx) == MXL_RV32) {
>>> +        return gen_store_zilsd(ctx, a);
>>>       } else {
>>>           return gen_store_tl(ctx, a, memop);
>>>       }
>>> @@ -533,7 +582,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>>>     static bool trans_sd(DisasContext *ctx, arg_sd *a)
>>>   {
>>> -    REQUIRE_64_OR_128BIT(ctx);
>>> +    /* Check for Zilsd extension if 32bit */
>>> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
>>> +        return false;
>>> +    }
>>>       return gen_store(ctx, a, MO_UQ);
>>>   }
>>
>>


