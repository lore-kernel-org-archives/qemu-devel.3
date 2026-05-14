Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D469CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSzG-0001CV-Iy; Thu, 14 May 2026 06:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSzC-00019W-6f
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:08:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSzA-0005Ih-0u
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:08:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so63301205e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778753285; x=1779358085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hHYn8XZLB4es06Hxygy7Br+mGIdl5xl86oW4hO0Yd28=;
 b=dw7AHo9y1cc4nK0TBX5sK+GDqhtEGN3i2eDfWlEojvQxcp+9a8a0q0QzcZL6nwlzJ6
 O8l1UiVPYB1/IYP/79BzASLaexUGkjsOjzCqbqjACk77cduyBrb/fSij8AGwu6JfiRzb
 7ynnu5sACVkH5bPpZQPJmWb6XiWSHjYu7KhSFArWC6kgSCgnBXVnZup2p/eweiELB7sG
 4XaBTWhV+RZyuV3s6MxrSbdY8znnPOpl9vkGS32MFC6BP5kfLY9pcZ0GY/OXifSY7V/R
 2poWK45CZ0vLpk1PVPOoOquhoNNQX2StSyBEA1iU+OPOAEgxZ0kn31Vx/bTHwB1L+/Lq
 B65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778753285; x=1779358085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHYn8XZLB4es06Hxygy7Br+mGIdl5xl86oW4hO0Yd28=;
 b=GdS8eG4vRmqu5K2rjrxv1XSMvWWZvgbQNDZuwpquEcmsnubvn2bjoU4Trxn5bo5Q8b
 Nx4R4itRzxsdnnEoPG1UttiEL54p02LkfglQKvPmY+z84nrR+SOSa+/DjNWFyPYV1lfL
 +CmINznxSfh7juamewrRRz5qRlToOGotqZG/9/zb6HFb0DihtXa1YVMvdvKrMTzhuJ3w
 4SAVz+dkJGbwsqWSeCNE8SesKconmVLpmJljvynX+ofhObXUZnkbFyAZ+II8JtoZPmqw
 iKGhuWoMQUpTixKnAzMyM/fTp3HdoEIuhmcfO300e2rzGkDalZ0UaQYyPMxDB9+KmxxE
 xGzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PDz8jQKPD0ajdi+Mh7AvJG+TTQb+cfP3ahMocIQXX5p0jjbNLmzce4GWS5Vcwp/yqX+IUTg9fvljr@nongnu.org
X-Gm-Message-State: AOJu0YwbEmL1fJNVe7R5nDo1mqMeo2b5ClJLnehaIirQqV0KnxJqy1Y6
 MC678rGZe8w/fOKVh/hDz6sVUu7FMP4szMKLF3vefMeWZxY8FfuD5WOv21HBiLhlGQY=
X-Gm-Gg: Acq92OGjkcg2VcuODcEV8P6EdpknHs6z7E8gW5VlfkcgaVrZ3MfJsb18mIIwxnbloho
 a/3+80ERurfQQiWZZIU5asOHHLO7sEMftFrUOTVpF2jFFYKr1W9ycEAaPWEhl/4G8V7cv6Xocqv
 HIPXA4nn4QWmAfMwpBOcBau68/uFmm3hsgvBEbyUo6/wlU/IgJsIqLNusUSs2wROifPo32NlDG9
 CPxQ5idBmesK5WolubnoQNwRvoRMJKWAulXfPNSqbVkvfZv2gpsPhW0EG2HWafiYaWde8ptXmr3
 h6rPMFxuQ+QN7NxxFeGPrZH51Ze8c/3z991q4RsnzoAdfEhPTWnWBv0qN3OZFN2XIj2JaGyEvTu
 39Z6Hpm0VlYYvgPfSVfV5Z4EqShuZ05jToNKq7NQpPtiJj9kHqMSV1qTXFppM09ZVfMy9y6bHxx
 UsE1XWuwrrDJ+WEkT5SlE8LyUL+GhgZCsN77uzBgmFt7OnbW1kxdDGqjTGjn8Owgl5yGUIF/UZf
 TqU
X-Received: by 2002:a05:600c:4a09:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-48fd5b85ba6mr38833685e9.20.1778753284968; 
 Thu, 14 May 2026 03:08:04 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fdb2c80f2sm36870145e9.9.2026.05.14.03.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:08:04 -0700 (PDT)
Message-ID: <035f2176-ed01-4013-9cdd-813cca355d9a@linaro.org>
Date: Thu, 14 May 2026 12:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/35] target/mips: add Octeon SAA instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-11-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-11-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> SAA atomically adds rt to the naturally aligned 32-bit word at base and
> discards the old memory value.
> 
> Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
> The MemOp selects the word or doubleword transaction size.  QEMU only has
> one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
> instruction feature bucket instead of adding a finer-grained Octeon+
> feature bit.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAA out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
>      Henderson)
>    - Use the i64 TCG atomic add path for both word and doubleword sizes.
>      (suggested by Richard Henderson)
> 
> Changes v4 -> v5:
>    - Drop the separate Octeon+ feature bit; QEMU only has one Octeon CPU
>      model today.  (comment by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
>   2 files changed, 18 insertions(+)
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
> index 401c4bd14b..441d71d57b 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -161,6 +161,20 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
>       return true;
>   }
>   
> +static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 value = tcg_temp_new_i64();
> +    TCGv_i64 old = tcg_temp_new_i64();
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, a->base, 0);
> +    gen_load_gpr(value, a->rt);
> +    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
> +    return true;
> +}
> +
> +TRANS(SAA,  trans_saa, MO_UL);

Sign doesn't seem relevant here, so -- although it is equivalent --
I'd rather s/MO_UL/MO_32/. Can do when applying if you ack.

>   TRANS(LBX,  trans_lx, MO_SB);
>   TRANS(LBUX, trans_lx, MO_UB);
>   TRANS(LHX,  trans_lx, MO_SW);
> 


