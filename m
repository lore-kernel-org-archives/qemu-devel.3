Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98630C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57yt-0004WG-DR; Wed, 16 Apr 2025 14:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57yn-0004Ut-RB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:59:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57yl-0003Mh-Jf
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:59:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6271289b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829961; x=1745434761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/E7EIaqziZydBDXn99AOa+bVBf7gDyVJ4nzRyJ5umw=;
 b=YT3y5KMe7mE9jbMS1FC0h4s4te4zHE8OURKTSYdeUsumt2NyYwRYfa1oBa5A2oUxXg
 opWvoWCQlId1sbRA4Im2U5Em8oGAFhkiEf4aspYcekTXCMQivSFx+dScfQkPFImnKLLr
 /zTQUnYoKoYAl2jHPMkhS/EySZVkt+HuG1DGPmSvLIwngdP7UlhlbAwEHuCy8ZpGcXc8
 bMo8UDPu1FgSgtIz4Ak7Qvg59Ox5venXB6VAUeNtquOm9dQICjDiamc9v4a0RBiCdiDS
 s2aaZw6BlyuhUB5is78SM8LB6Jrg0z0tknev2R5+YfOT1Ya3tziQwbs7STXaibTyoatF
 2d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829961; x=1745434761;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/E7EIaqziZydBDXn99AOa+bVBf7gDyVJ4nzRyJ5umw=;
 b=Vo0QHgtup5SxAU1emY5XUycYKQ6FU/VMlFVqQ0+O7gDIMIbALYLpJz1hxl2BNYbe4J
 MvqARTl3f23zvWXB4JDg3PEfxzPtUe1bCA3yVeUhJY7jV9WA06cdDbsfMdMgnYy6QG/8
 mr6Yo6kQHQor151kWtVZVC0XOSOPdcOeJ6ARlY6xkJYvTsiSuox3FEk+gDUo9PdnEz7k
 RST2t1yL7uEyISZwoIW5mIuQtK9hozUmoXVgAHFZLYketcOJ5DtXvzPm54EksUCr4fEL
 wFhqvFje7rvzT57NmpsLVBQwRL7Mfu32guCJdO8ZVVCpGy/l/XycaRHDSlG/MZCJTW7b
 tsSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD2OZ1hevFvoak5jhk9tpexa8t7f/wE8Z3VloRGHtb/8uD78gj53WWIOGbrxhSxaECl6qipb2heLYj@nongnu.org
X-Gm-Message-State: AOJu0YxUScdIHSqG3tjgovz3fNp5zH/v68zZ5xzPShAg58Vo5Gx21qXg
 qj4mxnFaSWkJ47+pQl7YlY1NKzYcyGjxXZQz93LMhXjdUasKEJBk2PJ/lZ9OwdE=
X-Gm-Gg: ASbGncvM5Fema8lL2ygZaeQsI0Gq8GM7F6Eugzj0unQMOY21bEjazmUgnP5x/kjHN1c
 kAh47rNR+huN8gRnZ1WZ/vMxjUyh7gGVOTkSgFghO9QOXbQLp9WEqxRF9VUBkG0cagU+JQgaR41
 FtDRRTGrZR7/HQ0S+ZdOKTEqikGu42CpCnqyUsrKqgS+nsAd9GddijE9e+RzJKHWgPFxWdVuCvB
 0nZmeHxFhm+NVZQQVkMmnvdwwH6onfuuBBc2Gon81WbSbZJLuYoUmKFXCj9f7JMecrL4Mmi4b5R
 Sjp6GRNYnYrhtc88V6XsExrmHmFtOl/oXm7PmYFCwpDtTKNoNMYFuw==
X-Google-Smtp-Source: AGHT+IGx4Jhjppj9iYgkqrcrbz26KITWqrep9G+R090hL+nxQzEW42NsCvnJsq9UkMonHKGTQAyOYA==
X-Received: by 2002:a05:6a20:1443:b0:1f5:5ca4:2744 with SMTP id
 adf61e73a8af0-203b3eb22a0mr4324475637.17.1744829961523; 
 Wed, 16 Apr 2025 11:59:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220fc366sm1633996a12.42.2025.04.16.11.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:59:21 -0700 (PDT)
Message-ID: <81a73738-11e6-4cd4-a98c-b1da07cac51d@linaro.org>
Date: Wed, 16 Apr 2025 11:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 122/163] tcg/i386: Special case addci r, 0, 0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-123-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-123-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Using addci with two zeros as input in order to capture the value
> of the carry-in bit is common.  Special case this with sbb+neg so
> that we do not have to load 0 into a register first.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target-con-set.h |  1 +
>   tcg/i386/tcg-target.c.inc     | 46 ++++++++++++++++++++++++++++++++---
>   2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
> index 85c93836bb..458d69c3c0 100644
> --- a/tcg/i386/tcg-target-con-set.h
> +++ b/tcg/i386/tcg-target-con-set.h
> @@ -45,6 +45,7 @@ C_O1_I2(r, L, L)
>   C_O1_I2(r, r, r)
>   C_O1_I2(r, r, re)
>   C_O1_I2(r, r, ri)
> +C_O1_I2(r, rO, re)
>   C_O1_I2(x, x, x)
>   C_N1_I2(r, r, r)
>   C_N1_I2(r, r, rW)
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 44f9afc0d6..da05f13b21 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2670,10 +2670,50 @@ static const TCGOutOpBinary outop_addcio = {
>       .out_rri = tgen_addcio_imm,
>   };
>   
> +static void tgen_addci_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    /* Because "0O" is not a valid constraint, we must match ourselves. */
> +    if (a0 == a2) {
> +        tgen_addcio(s, type, a0, a0, a1);
> +    } else {
> +        tcg_out_mov(s, type, a0, a1);
> +        tgen_addcio(s, type, a0, a0, a2);
> +    }
> +}
> +
> +static void tgen_addci_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_mov(s, type, a0, a1);
> +    tgen_addcio_imm(s, type, a0, a0, a2);
> +}
> +
> +static void tgen_addci_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tgen_addci_rri(s, type, a0, a2, a1);
> +}
> +
> +static void tgen_addci_rii(TCGContext *s, TCGType type, TCGReg a0,
> +                           tcg_target_long a1, tcg_target_long a2)
> +{
> +    if (a2 == 0) {
> +        /* Implement 0 + 0 + C with -(x - x - c). */
> +        tgen_arithr(s, ARITH_SBB, a0, a0);
> +        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, a0);
> +    } else {
> +        tcg_out_movi(s, type, a0, a2);
> +        tgen_addcio_imm(s, type, a0, a0, a1);
> +    }
> +}
> +
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_O1_I2(r, 0, re),
> -    .out_rrr = tgen_addcio,
> -    .out_rri = tgen_addcio_imm,
> +    .base.static_constraint = C_O1_I2(r, rO, re),
> +    .out_rrr = tgen_addci_rrr,
> +    .out_rri = tgen_addci_rri,
> +    .out_rir = tgen_addci_rir,
> +    .out_rii = tgen_addci_rii,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


