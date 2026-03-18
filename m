Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E074A10706D6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2o0P-0007fU-1F; Wed, 18 Mar 2026 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2o0L-0007f6-7q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:19:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2o0D-0003qQ-Il
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:19:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso57138985e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829187; x=1774433987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3rh1TPgm1EPU147kYB8v+fvEdEEmc69S8CNeICWgCFk=;
 b=l5yoO6NdYcqC0fr+1V7GK3hbnrVUdHuSz2hjDji3Yr9VPoSXMWR6OFoGu6dpKdzFX/
 sfXi1SRGFVKfGMOEwG00rgPgK6QORqlY1a2ucmWNbKofFwoOhPT7+gNQPBI6KiDLlmvI
 AATb+395BMDEY1UFXYvdVI3FvNljtDUXTcIED1wVIaNcRUDCb4qEv/yFTvc4Qz12pOnx
 /+D6M1NPhZmRZtxj8VHp8atXiYGH4kRdr3lUGVG2iT7GIpOryBcfux9a0g64UCYRrgTO
 y9pDacH9ObffVFYX1Hc2FH9YKuZ4z5Hs+S2WfrXvCR02AhuvKbyzQ71WSlwEyzkF8zUN
 FxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829187; x=1774433987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3rh1TPgm1EPU147kYB8v+fvEdEEmc69S8CNeICWgCFk=;
 b=mLyZBWftiCpQ7zIKXS3WoSMZqSUFl0ATcrbgKGSI9u1+nHicuM8pZtweXQo+e+vvhw
 VDXfUbFuXVNFxIdqplF+/wS2YKO9lFAlG0U9VJHmdWBTKIaIc/mHbh2n4OrcHS6pCSz0
 kHqmMyERo1pZZmbIn3KhPlJz+2Oa3a2Fz+URriq1alPJz1P/06s4PwVEpIvjEONQHyzr
 VR4HZQg07kApfOM6F/Sj5KO6g4MbT0Lyvj5IDqMrJRJ5Ga9UU+RoZuognhjkpcJ4mP3S
 9KAWVL7Nsq367ZsGrgHHw/gkA/DT+xuKtZu+MEjlSDqo1DTCU5jk/5/aX/Lq3rSLJ4XO
 VnBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQPJvm5kPSO4JNBYVxafpxotqvNBbNKF6IFK6zI0788bOEpDIXofzb0uc43Ue21Mouw7lr5JKUketA@nongnu.org
X-Gm-Message-State: AOJu0YzXvZGBsyU3RljsZIxRMxYfw9uWp1ZIHdsCI5NFTvbF+RlBEJfG
 avfvdlua7ib2+nBLgPnoBUvrLO9UBUR4j5J4snnDYl+J4vvtQv/bbbivCH1yMYqwRwY=
X-Gm-Gg: ATEYQzwSiFKVlYBgzBumtD9rkQvSDumgTVNDTqk5IZDFdCEKYQSCB2z01eZknnZT5Ls
 IrtD/OmG6zHVcO+M2NonkIZCJ2dbqKNat43PEe5npdMf3g6029tDEldCIaqzN52pUKUlk90P6eS
 J9H0hPxkGl6Vseq17LSGykAflhJnvwHMLAH0f0Y0EABLPjAQwjMa8ufQSbb2Opne5LWkdHzNXtx
 5BsjvfEXQBI5JBlxA20Gzmz4wy8i8UcL1ww3oGGreblvBiEszNvwz6sQ0zav7zI7SzXjgGLLrXt
 PnQhzxPYdKQdZ1EMGNp61MoinTI46PiJtlX91bzD8IPzIaOnQH1pnRMpf+j+Rq5H18rmTQ+qZmM
 bnjedUxR6o79zsOShtul9f95poF2jRqkOIrXXOhHMQwibmDRegW5esgMCE32aTbesR1NhD76JQN
 1jzytpnzt6tiV424MIrpdKpHg4aaNwpk9Fyl0U94kqWS1aLS5Fna83fn0Egjy7d813Yw==
X-Received: by 2002:a05:600c:58d9:b0:485:309c:2984 with SMTP id
 5b1f17b1804b1-486f4429daemr34295315e9.13.1773829186918; 
 Wed, 18 Mar 2026 03:19:46 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3037sm130250125e9.11.2026.03.18.03.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 03:19:45 -0700 (PDT)
Message-ID: <8b145eea-be30-4952-83b3-4bc9e522213f@linaro.org>
Date: Wed, 18 Mar 2026 11:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] trans_rvi.c.inc: Make lq and sq use 128-bit ld/st
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/1/26 19:14, frederic.petrot--- via wrote:
> The lq and sq helpers for the experimental rv128 architecture currently
> use direct memory accesses.
> Replace these direct accesses with the standard tcg_gen_qemu_{ld,st}_i128
> TCG helpers that handle endianness issues.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 54b9b4f241..2c82ae41a7 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -377,6 +377,9 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>       TCGv destl = dest_gpr(ctx, a->rd);
>       TCGv desth = dest_gprh(ctx, a->rd);
>       TCGv addrl = tcg_temp_new();
> +    TCGv_i128 t16 = tcg_temp_new_i128();
> +    TCGv_i64 tl = tcg_temp_new_i64();
> +    TCGv_i64 th = tcg_temp_new_i64();
>   
>       tcg_gen_addi_tl(addrl, src1l, a->imm);
>   
> @@ -388,10 +391,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>               tcg_gen_movi_tl(desth, 0);
>           }
>       } else {
> -        /* assume little-endian memory access for now */
> -        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
> +        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
> +        if (mo_endian(ctx) == MO_LE) {
> +            tcg_gen_extr_i128_i64(tl, th, t16);
> +        } else {
> +            tcg_gen_extr_i128_i64(th, tl, t16);
> +        }
> +        tcg_gen_trunc_i64_tl(destl, tl);
> +        tcg_gen_trunc_i64_tl(desth, th);

I'd have rathered avoid the temps / truncate, but I suppose
we are restricted by the GPR being declared as target_ulong,
so this code wouldn't build for rv32 althought it isn't
reachable, and your code is almost a simple copy on rv64.

   bool le = mo_endian(ctx) == MO_LE;
   TCGv destl = (le ? dest_gpr : dest_gprh)(ctx, a->rd);
   TCGv desth = (le ? dest_gprh : dest_gpr)(ctx, a->rd);
   ...
   tcg_gen_extr_i128_i64(destl, desth, t16);

>       }
>   
>       gen_set_gpr128(ctx, a->rd, destl, desth);
> @@ -488,16 +495,25 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>       TCGv src2l = get_gpr(ctx, a->rs2, EXT_NONE);
>       TCGv src2h = get_gprh(ctx, a->rs2);
>       TCGv addrl = tcg_temp_new();
> +    TCGv_i128 t16 = tcg_temp_new_i128();
> +    TCGv_i64 tl = tcg_temp_new_i64();
> +    TCGv_i64 th = tcg_temp_new_i64();
>   
>       tcg_gen_addi_tl(addrl, src1l, a->imm);
>   
>       if ((memop & MO_SIZE) <= MO_64) {
>           tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
>       } else {
> -        /* little-endian memory access assumed for now */
> -        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
> +
> +        tcg_gen_ext_tl_i64(tl, src2l);
> +        tcg_gen_ext_tl_i64(th, src2h);
> +
> +        if (mo_endian(ctx) == MO_LE) {
> +            tcg_gen_concat_i64_i128(t16, tl, th);

(Ditto)

> +        } else {
> +            tcg_gen_concat_i64_i128(t16, th, tl);
> +        }
> +        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
>       }
>       return true;
>   }

This approach is good enough for me for now:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

