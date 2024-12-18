Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DFE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzPj-0001ZF-TZ; Wed, 18 Dec 2024 14:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNzPh-0001Xt-C0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:08:53 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNzPf-0006lG-LW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:08:53 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e181fb288so3845769a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734548930; x=1735153730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udJcTVb9DLI0AydQwO+2wkSMyUU5OAyGu8logyWVzCI=;
 b=DhubOM8RI94MAQXXEFoor47JR5AMjNShMMISdLwGJJmlgdaDr1bvKcJqiLx/Y+4255
 xafY5mvGHZVkmJAKbIlRTS6X/uibxRuQ7AwOEWcfpjSv9yZLZ+/g2KTKzYwtCNNg+/76
 wOOU4nR/PXD1rEdsyZqFMnsQmg4Fb35A5X6xRNNAZVEbZmQB3K2xmCDzLSMA1bQJVRZs
 26F8DoMF48r/V67/empwu0ePrPxzG/3uT7i1MnoPXaFRNdtCutpJLnfEcYON8iUNkCyw
 QnwxBLRX+rvA9lyoa+zPjWjYBgOv0QLrCMVcW86SywiS0JMHRwMugDWcpqegpwVUJxzH
 8MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734548930; x=1735153730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udJcTVb9DLI0AydQwO+2wkSMyUU5OAyGu8logyWVzCI=;
 b=RulQ4jci6ZVzQp6bWPL59ip6XBPXAe4usyO1fUsjjSFSALHNAhqDxVW5SknXYOj8ar
 fU0vDkEfnld9t9RynpLSa1lyuFVGiju+Q5BzHbdN3EXGf8dnThYYf/MWfvDFiIG8/DGZ
 buavnsdOZydFVLfrPThTInXlTNwqMM4S9RAxMuksYaau9GNVJ0b79V6cwJwP9U+PHhVC
 1lxySyyRYgvJz9arU3aH9cnnf9Q7zDXLUZV7trRZcgoS4kQN+XyoA6xOMICJKCjN+J4Z
 UDnEf3lU6cpTCYVW+A+c0jFnuv2ay5AxjJV8hANDy2at+EnH6KDSJ91/Iv0dbtg9sTY8
 T3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFYybzzs4nVt2GYMFlisBYPBg2ZyJJ9Ados/PJvdXpCaDlh5/7Og/5wu+PKq9QMS8NBFkBpdA0/Aig@nongnu.org
X-Gm-Message-State: AOJu0YzntIK+30Be2qk2+QtepfFjL4Q09RdCpYUwkVqU+SZRsC1rxEP7
 sa89QHJ6W/yWx7cx6ZeRY0jaPk58YIfubvxMEHwaCoiRnoPkh2kLDIQ1aMhoRqA=
X-Gm-Gg: ASbGncuZBFvxfUmx0yFDXh/TWkRs3ZROXs82LjmyRruAshVMF5AixPWb6PGZZG+VKgA
 w8t4qREIAHYOS5+qUpIFbZJZ6TmHjY8CzoBHPDmGtpm5v9+3PzirJm2GMHXyA3CylkSikHUSmTW
 q3CDm6ef2CEZVQs0WHNHP+QcaDwRlM8NEtj9G1RTkcMyet8SmFJ3hZGGcS/Z/SVWqzdZDvdBUl5
 YE33DC7o4RPNhQ4BQGj9zcV474QxC+ToV3gnwn+hdmqqHX4MikIB+XuKd5emWx5CwQ0aCh5ug==
X-Google-Smtp-Source: AGHT+IGiXfaSqv6UQhnOL/WbhW6s1n3N8cLy1601OXY/Su2qeIdMZazB2bvJeXx6/RYFhpUSN/RP3g==
X-Received: by 2002:a05:6830:6a98:b0:71d:4488:19d9 with SMTP id
 46e09a7af769-71fb75a59e8mr2084831a34.17.1734548930207; 
 Wed, 18 Dec 2024 11:08:50 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e48371490sm2681475a34.33.2024.12.18.11.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 11:08:49 -0800 (PST)
Message-ID: <e8fb908d-4723-417a-bf88-b4050432ddad@linaro.org>
Date: Wed, 18 Dec 2024 13:08:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Jeremy Bennett
 <jeremy.bennett@embecosm.com>, Craig Blackmore <craig.blackmore@embecosm.com>
References: <20241218170840.1090473-1-paolo.savini@embecosm.com>
 <20241218170840.1090473-2-paolo.savini@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218170840.1090473-2-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/18/24 11:08, Paolo Savini wrote:
> This patch aims at emulating the whole register loads and stores through
> direct generation of tcg operations rather than through the aid of a helper
> function.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 104 +++++++++++++-----------
>   1 file changed, 56 insertions(+), 48 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index b9883a5d32..63d8b05bf1 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1100,26 +1100,34 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
>   typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
>   
>   static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
> -                             gen_helper_ldst_whole *fn,
> -                             DisasContext *s)
> +                             uint32_t log2_esz, gen_helper_ldst_whole *fn,
> +                             DisasContext *s, bool is_load)
>   {
> -    TCGv_ptr dest;
> -    TCGv base;
> -    TCGv_i32 desc;
> -
> -    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
> -    data = FIELD_DP32(data, VDATA, VM, 1);
> -    dest = tcg_temp_new_ptr();
> -    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> -                                      s->cfg_ptr->vlenb, data));
> -
> -    base = get_gpr(s, rs1, EXT_NONE);
> -    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
> +    TCGv addr;
> +    addr = get_address(s, rs1, 0);
> +    uint32_t size = s->cfg_ptr->vlenb * nf;
>   
> -    mark_vs_dirty(s);	

Did you lose this?  You can't rely on the call from finalize_rvv_inst at the end.  Dirty 
must be already be set for the exception path if any of these memory operations fault.

> -
> -    fn(dest, base, tcg_env, desc);
> +    TCGv_i128 t16 = tcg_temp_new_i128();
>   
> +    /*
> +     * Load/store minimum vlenb bytes per iteration.
> +     * When possible do this atomically.
> +     * Update vstart with the number of processed elements.
> +     */
> +    for (int i=0; i < size; i+=16) {

Spaces.  scripts/checkpatch.pl should have complained.

> +        addr = get_address(s, rs1, i);
> +        if (is_load) {
> +	    tcg_gen_qemu_ld_i128(t16, addr, s->mem_idx,
> +		    MO_LE | MO_128 | MO_ATOM_WITHIN16);

FWIW, for MO_128, MO_ATOM_WITHIN16 is equivalent to MO_ATOM_IFALIGN, which is the default.

Where you can improve things if by specifying *less* atomicity.  For instance:

   log2_esz == MO_8:  MO_ATOM_NONE
   When operating on bytes, no larger atomicity is required.

   log2_esz <= MO_64: MO_ATOM_IFALIGN_PAIR
   Require atomicity on the two MO_64 halves, but no more than that.

I don't currently support further granularity, because there doesn't seem to be a need, 
and it's already somewhat confusing.

There's no handling for vstart != 0.
You could easily fall back to the helper for !s->vstart_eq_zero.

> +	    tcg_gen_st_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
> +	    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 16 >> log2_esz);
> +        } else {
> +            tcg_gen_ld_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
> +            tcg_gen_qemu_st_i128(t16, addr, s->mem_idx,
> +		    MO_LE | MO_128 | MO_ATOM_WITHIN16);
> +	    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 16 >> log2_esz);

The final iteration must set cpu_vstart to 0.

Otherwise this looks quite plausible.


r~

