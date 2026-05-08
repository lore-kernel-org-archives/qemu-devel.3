Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09BECD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPRE-000771-VH; Fri, 08 May 2026 13:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPR6-00076h-Pv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:56:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPR3-00063c-Uu
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:56:28 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso1893281a34.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778262984; x=1778867784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MM5J+Y2tCkGQzoWrq2mKC6zxFYkxupBmULA7ryc2Ttg=;
 b=XtZyEPaWxIdqXYzOG/oN6COFQ8ymsOBeLMzhREjSwBjqs1Kp6EFEn2pBBbI9HaaTII
 wwSv3Eg/xO/W4c53wA+u9Lmpyaor0ro1rqOErdjaKiOx4fMf3ILfhpQHSUusy6CxCAuy
 smKuS2sI/3Aj4wKrMEuag97Tpko6re9vllJkTzLZL1AslNAQdlN3hlgSzAEZ8qUOjQ4D
 p30dsdJFoqMV4zE+4TRr/aERn0isnalGys0/rWkxKz9kayGg8kWrkhBY4mrlLlUmvJPy
 Uc6n1KGDyhzVni1ek5EkGDq8ziSigKsYY26/7nmr9XUCMPsgfgVKXJjqjQsfejNGos9m
 sAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262984; x=1778867784;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MM5J+Y2tCkGQzoWrq2mKC6zxFYkxupBmULA7ryc2Ttg=;
 b=GNswGPycUMY+ywSF4QZ8VmpZkIoUpA3l2OMF0z4wBUOvgLs8ToCFUoDWvaOwxpjRjS
 S8vpE4S0U6uqQM0Kyhlm+EeajfUbTtLvttEyELigFEXQOlV8VkJIUxLfaXL58NSK9Fwi
 68ofgNB9i5Nq1FBAZmifGquASO4XT6+lJIbpHLw3hrukq3+/YUJ2mGSJ2d9VWk5Qrq6d
 /8zr2GpAaWWPloDcXjZVSi+KV9Rzv83Ju9rovuTh2OOGhHQvoNg5njRJ+mIx+QAvEJFi
 QOpqiyY2pHTpEYPlqzc4QCD1TpO6k2WT7XcYG0ys7+CKw/4+mHenp5iSS++cDQueNPZm
 0CqQ==
X-Gm-Message-State: AOJu0YyiB1kxhlkIgL/cT7+KP1c6JUSNi0KLVZtD8xo3Nh/3bJ0nDDak
 U1bggkdsoGFryvDD8Q3TN+Xi+fGbIPjDllHwFWVxUhbNEnNsKRVlmre2RgkDYs0BVOt6dys30m5
 VT2w/
X-Gm-Gg: AeBDietClOQDOBn1KTL3yy6c6FAK9XlhfKz/kFZwMstClMiXBNP9GhRLBJQLM9EhfoY
 VNU+q6xBOrpwSXVXIwvoWcnII4dJVQvRdxUczlxkLVJysb5yCHCsY5XTvA/9HjTDX0GsHZy5M5T
 o56W3k+o11+tcyPne2djBmNEE09zKrnT524yZKvAmhjtZ0QBVJ+0gEKSaU23hJy9kEMLVpdTjr5
 HUqWbbjnYbEGFeLmUNsRVkbMM6Cr7QH5cBSukiDyxHhG11LUlgXtKfQ8mdB84nIb05YMwfeJZwn
 b1+MlvWqfooHc9q1X0CeGTElPATXV8/TPn+o4H9vD8yd44hCGvk1Va5oNJfxJ08XyZb//rNuaai
 S/eTBK2YzjMvii6Dr6TussGQLOETXIO5dNxZI7oMhFwlBuvU9DLeKzFN/hEHesiK4byY4X/V9vy
 M/0SXnMEWMcTa0YzicIeJpV7RZazvVsG86lueNjtGbQbq8OpF64JLgi02pmSBLRgzNiPAnyPb11
 wYazPzW7yhpBH3yuf0Y
X-Received: by 2002:a05:6820:60b:b0:694:980a:2c33 with SMTP id
 006d021491bc7-69b25b17567mr1950936eaf.5.1778262984065; 
 Fri, 08 May 2026 10:56:24 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c76cc4sm1480922eaf.6.2026.05.08.10.56.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:56:23 -0700 (PDT)
Message-ID: <cd983945-0c31-4632-9ebd-f6c151a5ef62@linaro.org>
Date: Fri, 8 May 2026 12:56:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/32] target/mips: add Octeon SAA instruction
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-11-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-11-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> SAA atomically adds rt to the naturally aligned 32-bit word at base and
> discards the old memory value.
> 
> Implement it with TCG atomic_fetch_add_i32 using Octeon L2 transaction
> alignment semantics.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAA out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index db7d5f55f0..d6b241de42 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
>   SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
>   SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   
> +&saa         base rt
> +@saa         ...... base:5 rt:5 ................ &saa
> +SAA          011100 ..... ..... 00000 00000 011000 @saa
> +
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
>   LWX          011111 ..... ..... ..... 00000 001010 @lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index c93eff59a5..19535768d2 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -161,6 +161,33 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
>       return true;
>   }
>   
> +static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, a->base, 0);
> +
> +    if (mop == MO_UQ) {
> +        TCGv_i64 value = tcg_temp_new_i64();
> +        TCGv_i64 old = tcg_temp_new_i64();
> +
> +        gen_load_gpr(value, a->rt);
> +        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
> +    } else {
> +        TCGv_i64 value = tcg_temp_new_i64();
> +        TCGv_i32 value32 = tcg_temp_new_i32();
> +        TCGv_i32 old = tcg_temp_new_i32();
> +
> +        gen_load_gpr(value, a->rt);
> +        tcg_gen_extrl_i64_i32(value32, value);
> +        tcg_gen_atomic_fetch_add_i32(old, addr, value32, ctx->mem_idx, amo);
> +    }
> +
> +    return true;
> +}

No need to special-case UQ.  You can always use tcg_gen_atomic_fetch_add_i64, which will 
do the right thing based on mop.


r~

