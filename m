Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE7F94CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFOXT-0001zd-Kv; Tue, 21 Apr 2026 23:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOXL-0001yv-HC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:46:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOXJ-0005XC-Li
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:46:03 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso1975105a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776829560; x=1777434360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yHqBwK7rPwgiFAPMGt6cCb/CLdNfKGBQ/Lx4qCA1Yb0=;
 b=nsQhFTFu6p0teZ0fOIyoW5D/S699qGeonUcAcZLf2GV8lHh7BN1yDeRpfRfZ9EFU3u
 F+c7/IuZbWoCdTWuglgU0u2O66GVfAUmlgTrS4bXf9FZZumDnO0LWj2ODxLRmskQyR6s
 POHmMsnGZqlmgwvYkUOzF2ZS28aeSCubTQx9MxTl6iou3mS2GEDmDK+RiV+jkTAG8ALF
 OcgalItD1zIkbe3iQWGrtxJ7/rWBLcUePZPvmndhf5SD+L/sARHY5742F79RoGvbK/lR
 nN1FHkFl83NDG0L2hIkvYV+iuCcrfH+PW2mgdizMetgUHxs6O2fupiqpIC+ooZDP1P4Q
 VvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776829560; x=1777434360;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yHqBwK7rPwgiFAPMGt6cCb/CLdNfKGBQ/Lx4qCA1Yb0=;
 b=DnlFRkxDlM3i7EudQ0hZfEKJhy8GFxkTqgwZJq7U7qB9CRINOT85nnB0c6wZRQwoyo
 As+8TiKc3hixvQoe3h+uW6S0fO0sSQvofwQgb+dLchBhessH6pIwXE7zGNQDXr36qHx2
 Hod/ggOoB+stqLq2a2bClYZ5CYeeveiX9eVwZ2q94/6MLOmPZgqxIfv1sixytc1Y+0pl
 7HGZ658Z8Q0X/5XxG0IndX0AgJGz513h384+LKbrkkYvHSfMzCPwVF9xc8hIElodEihI
 9a2q5AeYjigqnm3xDvIprUV+dwtmRMOexCPjdzJcLXKeHgn0Gwxt4pUL5ZDAlE7QVPlf
 5eNQ==
X-Gm-Message-State: AOJu0YyJAQWRUgW7tHWvh4mZKlGrwpAHZJo5MSy/ieAMHSxaBFvAj1zK
 wIPzI5RtZlWFpi1Yxbr5GM2JinWnLpP0yGCknXnaRmZmE6JJ7/xdTnqAcDodhhgBy0EYDJkiQZi
 2rI2ItCQ=
X-Gm-Gg: AeBDiev5wFYDBhkwm+wu3TCoYKyigwbwDooezNlY7Rf+fc4cGjuuO9GhOK3X0EgDcm6
 L8n6ircNkbMbXC8IjaZQAwsNuYOnFNH/HfbdkeSxSr2Ivvv4T5AcbY5TwCfoYgpUsQKKfKK1rWB
 VIYifdSbygMieldTyKbmfXBP9ZODY4zCaz4ba6xTKv9KtF2Mrt9SdCoigRya3czOwoZUMUnhCJ1
 /xht0UdE9vUvsFBPFVPOre0Dy2XZsgvq1Eog5BFpNlUxIv2qVt/DrJ4UpUtS+Cv1D//h7op4TOn
 ATHMLUfE2+rdg/mCfsfAJVgVgJhUkDo1UaewtX9v5f3/qVu5wu4gxJadRXZ1IwJwT0q/ClyHa5t
 K480vJLq8ZJIzqJUrmzma5qyY2q2c7FyMYrXfCsbVvUAa/gtYnGdtYuNg95Aw40iroACIZEHqhf
 4Fmq2kInU7A1UDUWfKo7IzGYyD3czcufBVbc/EHqTRYND3DvADMLbuRffBIkuYrA==
X-Received: by 2002:a17:903:11ce:b0:2b4:5ff5:e51f with SMTP id
 d9443c01a7336-2b5f9f51dfemr219596545ad.36.1776829560035; 
 Tue, 21 Apr 2026 20:46:00 -0700 (PDT)
Received: from [10.72.56.227] ([144.130.154.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3a929sm144548695ad.72.2026.04.21.20.45.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 20:45:59 -0700 (PDT)
Message-ID: <2c6bf45a-cf64-4879-9cec-3dac35a4905c@linaro.org>
Date: Wed, 22 Apr 2026 13:45:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] target/mips: add Octeon LA* atomic instructions
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-6-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-6-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> Implement the Octeon LA* read-modify-write atomic instruction family:
> LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.
> 
> These operations are architecturally distinct from SAA/SAAD and are used
> by existing Octeon user-mode code for atomic counters, bit operations,
> and exchange-style updates.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Keep LA* atomics naturally aligned per Octeon L2 transaction
>      semantics.
>    - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
>      Philippe Mathieu-Daudé)
> ---
>   target/mips/tcg/octeon.decode      |  17 ++++
>   target/mips/tcg/octeon_translate.c | 170 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 187 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 2eb15aa17f..9dcc5a6ae0 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -60,6 +60,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>   SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
> +&la          base rd
> +&laa         base add rd
> +@la          ...... base:5 ..... rd:5 ........... &la
> +@laa         ...... base:5 add:5 rd:5 ........... &laa
> +LAI          011100 ..... 00000 ..... 00010 011111 @la
> +LAID         011100 ..... 00000 ..... 00011 011111 @la
> +LAD          011100 ..... 00000 ..... 00110 011111 @la
> +LADD         011100 ..... 00000 ..... 00111 011111 @la
> +LAA          011100 ..... ..... ..... 10010 011111 @laa
> +LAAD         011100 ..... ..... ..... 10011 011111 @laa
> +LAS          011100 ..... 00000 ..... 01010 011111 @la
> +LASD         011100 ..... 00000 ..... 01011 011111 @la
> +LAC          011100 ..... 00000 ..... 01110 011111 @la
> +LACD         011100 ..... 00000 ..... 01111 011111 @la
> +LAW          011100 ..... ..... ..... 10110 011111 @laa
> +LAWD         011100 ..... ..... ..... 10111 011111 @laa
> +
>   &zcb         base
>   ZCB          011100 base:5 00000 00000 11100 011111 &zcb
>   ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index cdb4d36c8e..6309cd5fff 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -254,6 +254,164 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>       return true;
>   }
>   
> +static bool trans_la_common(DisasContext *ctx, int base, int add_reg, int rd,
> +                            int64_t imm, bool dw)
> +{
> +    if (dw && !octeon_check_64(ctx)) {
> +        return true;
> +    }
> +
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (dw) {
> +#if TARGET_LONG_BITS == 64
> +        TCGv_i64 value = tcg_temp_new_i64();
> +        TCGv_i64 old = tcg_temp_new_i64();
> +        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
> +
> +        if (add_reg >= 0) {
> +            gen_load_gpr(value, add_reg);
> +        } else {
> +            tcg_gen_movi_i64(value, imm);
> +        }
> +
> +        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
> +        gen_store_gpr(old, rd);
> +#endif


Surely patch 2 was all about octeon being only for 64-bit cpus.  Why the ifdef?


r~

