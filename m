Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F18F433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDARf-00048s-LM; Wed, 15 Apr 2026 20:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDARe-00048j-FR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:18:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDARc-0003nF-SL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:18:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b461310af5so381755ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298735; x=1776903535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G21MTiAWYMgeeYQmBJuqFRfusIrCDrz3BYAAKOl5oOo=;
 b=U6At3i5xP0z8os9Evx7Heku9xwgSWbiuDtxNZFgjSdYNxB290qKBIh1X2rzGddIZ8c
 dwhlhLbzR6N8jm0ubmMKxhO/2K5WVm8ZbkmVx4TAy6N/6xYJYoNKO0VeDRvg3wl/f1Kj
 IqCm1MxNghQy5OOncIyL8jBp/J9YrawY2nZkAJ1wIRwixcFKH6opaS20HT4wZ/m7rxgP
 XpnDKoY4axwNC2sDkU1F3+xxrRNuuC1QU4w4BO+VX7F1oUG7qNPSd1DXB2LkdP4HJdTM
 Kkvmm4CUFMkrz7d1cnuWawLWq1wUWDsAV5DkiunDqSDb5CK/ZsoN5QmCGWnWGCA+pqHx
 uT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298735; x=1776903535;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G21MTiAWYMgeeYQmBJuqFRfusIrCDrz3BYAAKOl5oOo=;
 b=Oxh5lUwFD6LBWPTSgBP+dgifRCJuQ5JYQ2ZZahTAJB738DuzGCWiMBSmnmlwL+AoAz
 hKsRY8uU9oTpT9XsrCZCA1ChC06GV4z6kRmPAQU3zJTFBpHitLMTkrfLpAOC1adtzZM6
 +JJIWM3/3vXao16rCK7eM4v4KN4ht65TJQCHET/0miR92S9joxMyfDeW+JgXtONFT1+6
 tOJA6iZocWQ81VYQYHWaf+JiXH6ueDerceSO1SnXWOCeblFAw8NfF5hltbjXvseUfrKd
 vUL30vz3+xhZaWzVP3Hw76Dd9xF3T4Ap/96fMsW6UARHxF/vOcyq9MgWUJJCh0QGdzjq
 CQXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86X34SqIKp84BmAzq8Oq96tArsA2LD3Xl106gus6IrOE05jVIiky7Q9j66+GSVtcUhhMMgCy6WChCo@nongnu.org
X-Gm-Message-State: AOJu0Yzsmhiifiv9sJh5VarktpWi0MLA9O/a6n9VMiIbpsA2A17xVhCk
 KC4DoKYmEDsMjKOqbhtxsRRaLOGhnG/FzpfAKjXLIlI8mGLJ3lcwZt6BjSMdqlOvJno=
X-Gm-Gg: AeBDietY9P1nRnnYCNc0yyjy4eVH5kDT2htP+lK+89rfIA/5A/VH0SRcefL+EZN6we8
 ZD5Brk0poBcTwqOgjkrrerdS7UHlQqWk7JZkb4yz0E+QYhrOY7uPCexLqz819tS6IXiC5M9Jf4G
 zoVICw0yclTCfdO6enAOaYn4AYcPAmU+zPc2AxOw/QrdMngpkzcWsfhipXDLbEcvzPNILooyEg/
 JNvpgQtOkWyQYJ6h9+T2ZaCf8I29zOxXP6ZNxAYsQIe7BLx5kJlPiGTzqg8jhkE3nFiqOToB+T+
 6NAO321tDXxIXpkmGzNsyikie1tqO+qeBSCIJH93vRWwMeBovlDy17s5HpKyzo2o1WeNY7SlVLU
 013nAbb8w1N3Xxu6Wd1m31PghaIJv84SSnAbiB2sJUZnkil/i2GvJm8ZHHnp3Q3rgsxwB8LJfo5
 KPK/Xwx6a5FjhzB+ZcQUA+YvYAMTS02IDZs/545+qudGNE2QcqCHK2Dn5KGGeE4kq9zzJ6FGHmG
 Q9DlId8uxLTOPHvsgVsuFPe0vwqR/3i77vQSmvUjdVoNh2AFET0KwdN6mDvP523hg==
X-Received: by 2002:a17:903:11c4:b0:2b4:6122:10f8 with SMTP id
 d9443c01a7336-2b5eab1b687mr13182615ad.21.1776298734554; 
 Wed, 15 Apr 2026 17:18:54 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 (bg30dhzr9yyk68wp6s9g.ip6.superloop.au.
 [2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826e90csm33545775ad.38.2026.04.15.17.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:18:54 -0700 (PDT)
Message-ID: <a490461d-9598-411e-87ed-4d555d0b19af@linaro.org>
Date: Thu, 16 Apr 2026 10:18:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 6/6] target/mips: Endian-swap MSA LD/ST.D
 (Doubleword Vector)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
> Doubleword Vector entries need to be swapped w.r.t. endianness.
> 
> Fixes: 83be6b54123 ("Fix MSA instructions LD.<B|H|W|D> on big endian host")
> Fixes: 6decc572dce ("Fix MSA instructions ST.<B|H|W|D> on big endian host")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Probably optimizable since tcg_gen_qemu_ld/st_i128 handles MO_BSWAP.
> ---
>   target/mips/tcg/msa_translate.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index b1d764bd179..63d797a39b7 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -822,6 +822,10 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>               gen_bswap32x2_i64(d0, d0);
>               gen_bswap32x2_i64(d1, d1);
>               break;
> +        case 3:
> +            tcg_gen_bswap64_i64(d0, d0);
> +            tcg_gen_bswap64_i64(d1, d1);
> +            break;
>           }
>       }
>   

No, this is just a fix to patch 5.


r~

