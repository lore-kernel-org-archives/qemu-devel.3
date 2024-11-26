Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E0CD6555E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG3XQ-000341-1P; Tue, 26 Nov 2024 16:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG3XN-00033l-C1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:56:01 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG3XL-0006um-Hf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:56:01 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f1e573f35bso1105878eaf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732658157; x=1733262957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ax2B3V2rSbqIYcBXkgXTK5KxKqm3DuufkDhLPr+GcAM=;
 b=fuadwk1bEaS67TRLNXk/040p7dkbupO57nO9DUs7u+u3/T620qjLWG2KlwbixIwwgw
 peCsVz7fC/QMfaIA2s8cSKZ2rbHatmF0BqxJpyOugm1DK0Mlhg5UwVICTAX3jSsGUSKT
 QfP1Sf6Sb1Viu+ZgjiUozLQuw8aSJvxC3LM+7PQQBuqdmqcl+YWA2gk/snUo63H1cM7P
 n7M1Ov3P5DVhkFKx/MWeveA2jBRx6eXQDM1KZtKmknUjb/TlQ95P+dhHgYKtFz74uB5g
 ZNuyj12hECieREUe40BUxhuKiRbwhm6JXh62on4KTlQA4bd2kz9NqZokgJh/06R/s6gU
 V/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732658157; x=1733262957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ax2B3V2rSbqIYcBXkgXTK5KxKqm3DuufkDhLPr+GcAM=;
 b=Jaq3C4kYdPfaShinxPo/1rmvSJpavX52qr6xyZw7qfF0IuTfqVbIB1STo7wJVUHVGr
 wBb1doY3Ie83TV2Howz1Yb5CCx9UcktUBsIrzhO8WempfPpevPH38bynLGpDrG40yI0x
 nUiBIL1m8lPAZC6HjWfWWI8Tx7c0axtsWzgmlGsu8iB2d0cSZjLnOrvG8TgHcWrIREsG
 0ptoyo/cSbAm5RXvvD+jS956juEQm1f8ocmPRSaO16LkPDIn61+R+v8N5rlz9MUAIUmc
 tpjuRetezarXin2CFC82HperT3G7CiFxHrepmWwocLg95S8cBteq+KVe6ViaJEqe5hrk
 HwZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIvWDYV5A+Kuza9t0V7eeO90GvdK3g3TRNMuAPMPv2eE0wUOHkqZ7O6wE+WLxzGKciAFjsBDKuKu+o@nongnu.org
X-Gm-Message-State: AOJu0YzbHWAnKWG7Kk5Jrpkx/uA5zQmQJ0SEJJ5oUF3DRrMU7vcPnDZU
 F25u57duxnTmvxY78J4JEWP/V0nOStT6arRBv7BCDoiRBkvf3i47OTY19QQ7UfM=
X-Gm-Gg: ASbGnct4VQyyeamObUQlaKJx4lzWlAuowicNAWud+Q+G0GGCvqFH7pkw+bjXQI5ZN+1
 wOJlHO3ObhJetjBZynX4aM+jvnvubWneJA9mItmb311mKX241r7CzkbyMUaMTWGHnyd77avkR2f
 XQrBWNhHNfi0g8ibqVxFP3Qr99GF7E0ysLnaMwJof8AgvfT8kiVKbB4ai5ky4IQGCoIlD0pBhI/
 GSRw2DCopb45szsgnO4Q/EiGKh0emmeShg6FFNodgXOnN0vvA2JpLc20jx+7k3mOs7cRe6BeWh6
 QD6FjKLyY3nlE4qkh4NOjoFFr9yl
X-Google-Smtp-Source: AGHT+IGnJirHCNHQDWtLz6aZm34rpiHLNDLCl6skq2zTGim9upUxlpJ7CFR3do+IrtXp6REfaCKVUA==
X-Received: by 2002:a05:6820:1e12:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5f20a1db85cmr960942eaf.3.1732658156975; 
 Tue, 26 Nov 2024 13:55:56 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f0696476fasm2975984eaf.0.2024.11.26.13.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 13:55:56 -0800 (PST)
Message-ID: <d03c3d13-5e4d-4766-afe5-0064a9338566@linaro.org>
Date: Tue, 26 Nov 2024 15:55:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] target/mips: Convert MIPS16e LI opcodes to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/26/24 08:00, Philippe Mathieu-Daudé wrote:
> Decode the destination register using the xlat() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mips16e_16.decode       |  8 ++++++++
>   target/mips/tcg/mips16e_32.decode       |  9 +++++++++
>   target/mips/tcg/mips16e_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/mips16e_translate.c.inc | 11 -----------
>   4 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
> index 82586493f68..bae7bfbb522 100644
> --- a/target/mips/tcg/mips16e_16.decode
> +++ b/target/mips/tcg/mips16e_16.decode
> @@ -7,3 +7,11 @@
>   # Reference: MIPS Architecture for Programmers, Volume IV-a
>   #            The MIPS16e Application Specific Extension
>   #            (Document Number: MD00076)
> +
> +&rd_imm         rd imm
> +
> +%xlat_rx8       8:3  !function=xlat
> +
> +@ri             ..... ... imm:8             &rd_imm   rd=%xlat_rx8

mips16e is decent enough to name its instruction formats -- this one is "I8".  You'd do 
well to use those names.


> +
> +LI              01101 ... ........          @ri
> diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
> index fc429049e18..248ee95706d 100644
> --- a/target/mips/tcg/mips16e_32.decode
> +++ b/target/mips/tcg/mips16e_32.decode
> @@ -7,3 +7,12 @@
>   # Reference: MIPS Architecture for Programmers, Volume IV-a
>   #            The MIPS16e Application Specific Extension
>   #            (Document Number: MD00076)
> +
> +&rd_imm         rd imm                                          !extern
> +
> +%immx           0:5 21:6 16:5

The bits are in reverse order.

> +%xlat_rx8       8:3  !function=xlat
> +
> +@ri             ..... ...... ..... ..... ... ... .....          &rd_imm rd=%xlat_rx8 imm=%immx

The format is "EXT-I8", though there appear to be variants where the immediate is signed 
(ADDIU) or unsigned (LI).

> @@ -9,6 +9,20 @@
>   #include "qemu/osdep.h"
>   #include "translate.h"
>   
> +static inline int xlat(DisasContext *ctx, int x)
> +{
> +  static const int map[8] = { 16, 17, 2, 3, 4, 5, 6, 7 };
> +
> +  return map[x];
> +}

Don't mark inline.

> +
>   /* Include the auto-generated decoders.  */
>   #include "decode-mips16e_16.c.inc"
>   #include "decode-mips16e_32.c.inc"
> +
> +static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
> +{
> +    gen_li(ctx, a->rd, a->imm);
> +
> +    return true;
> +}

We nearly have the right set of decodetree options to allow these trans_* functions to be 
shared:

     --translate=trans

which will drop the 'static'.  But we do not currently have an option to emit a separate 
header with all of the declarations.  That should be trivial.


r~

