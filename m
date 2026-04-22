Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7EBF94CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFNyP-0006AY-S7; Tue, 21 Apr 2026 23:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFNyM-0006A6-M0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:09:54 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFNyL-0005tW-2v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:09:54 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35e576110adso3316384a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776827391; x=1777432191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8SajErzMYBUM2h5Gh3vhHT4JlD15bqwjD3bQ9dx3BzA=;
 b=ThkUJfOcIgFkqjlaMyALmX+FJf9MV0Dhpw+rLZWDQ+I59N8O/zlgYBgLp1fRzA+5OM
 TUKHC4Ydz+jDMUGo3uK7WwtugN+JdrT3q+4pjwZoUcT9vW1obqHE0RxlLvhT4tBlYkS1
 mTKxk982SQ9NPe5+cRMobcN+0/YLHNSL4XXyQ2wB2cRAFqh3bu6oOM4fQTXYdfUbKOSO
 4vk/Ge3rWwyVPCQdtjk2s65H5pMETQmjzWNq2n+6irqiNVSrfZyAXJgQOsJNeTojWhc3
 t60/aR+BbIB1bsXbk4MhfXuo4xW0p6NawzfVnA/+SZ/Ezjo9pR9k5R9IxrUuKjg7nxnQ
 8ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776827391; x=1777432191;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8SajErzMYBUM2h5Gh3vhHT4JlD15bqwjD3bQ9dx3BzA=;
 b=CX5CPTgym+PksoaG5++4IKOo2AUoi8hmC5cGgwuEEofit0C5838J4dDmvoDjzJbyOg
 8r/g5Guw25z/KYgbjd7EkhbVM7HCY8+QLrqnvPViI+w2OZ6fHpLTq1Xfcq8M9yqz9sFb
 CW76ofANECLkZ58Oy7S70w5HPXZlKpxz09vtgLXAiV8YC+SZiEUL+uUl2lSbmLMIBvcf
 FCDykZEdpIHv7n0sfv6Ze3pJN+S1C18qWopl7Umfbx5s6Ek+qNwm+Ahkc6P7FIWy5AhA
 tF4rCyLNQu+xqR21QZDMgnA//+Lku0auBSlWG4gNBeDDGpgNTX2Boz+GYe28aTsB68P7
 Jvng==
X-Gm-Message-State: AOJu0YyXy2oNNJfMbv8fIL6i95Y0LrfVUjmdlOLdCpTVQZxrPngLgcWF
 6Hsm3MtxnJRLcWUB3yPx3su2F0d61oKKk688Ra2Svb6bRSW2EoQYirXIOrSx1wflQ/Mqpx7WoJ1
 m1/Qd9Q4=
X-Gm-Gg: AeBDievSXs6/4NPhsyOGTGy0PywepycMx47GxoOBT9IOBa0ZuD5S/4dUQ6CfJ344LJg
 FsjBIp6xz8LbUmi5L+MRH5OJm7sArxPLCyZC24ZeDPNjmhrqr5xeyICqdNwKWVnQbs+JWdOtMPZ
 Ro5o/sJ7dWRtsFL3Xtsh2MgJManBHb0ZXDhOHVofrFoH5dfsC6cSiByfHjbgL+hXH1tropPmOac
 qlN8fT1LeH0uaqv6ikrSnBG6Blon6w1RImiYRkFjM7vPEZBNNypN3aIAtVVsijrrqTUQzdfChxt
 nQi3yX5k204hfGqh+Nz6XfMIrGWT3BoZGw++T4vKmLGb40efxG8LIcShns1q1Bto7NJ2iEer3bW
 yFdmh8rf+AwKB8N92ZHSsPeOg/40vgJpUhLsCZ2jtAZGW+voaSsaBRTSiylr6yO3BgblgGBb65L
 1R5LQOG0d5vtff9C0hG1OPKWiYdR4YY/8M0r2dUSGOFwmRUXjlYKA=
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id
 98e67ed59e1d1-361401eb6e8mr14759177a91.4.1776827390915; 
 Tue, 21 Apr 2026 20:09:50 -0700 (PDT)
Received: from [10.72.56.227] ([144.130.157.129])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-362b9a79176sm3816376a91.5.2026.04.21.20.09.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 20:09:50 -0700 (PDT)
Message-ID: <85755be0-dc8f-416d-8c57-15dff26bdf63@linaro.org>
Date: Wed, 22 Apr 2026 13:09:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] target/mips: use explicit i64 TCG ops for Octeon
 translation
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-4-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-4-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
> Octeon instructions are only available on 64-bit CPUs. Use explicit i64
> TCG temporaries and operations in the existing Octeon translator paths,
> and reject 64-bit-only forms when decoding for a non-64-bit target.
> 
> This matches the architectural restriction directly and avoids depending
> on target_ulong width in translator code that is only valid for MIPS64.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/tcg/octeon_translate.c | 76 +++++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index fce01eb196..73090ce6d8 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -13,9 +13,15 @@
>   /* Include the auto-generated decoder.  */
>   #include "decode-octeon.c.inc"
>   
> +static bool octeon_check_64(DisasContext *ctx)
> +{
> +    check_mips_64(ctx);
> +    return ctx->base.is_jmp == DISAS_NEXT;
> +}
> +

Why are you checking is_jmp?

The check_mips_64 test is redundant with the tests in translate.c that precede 
decode_ext_octeon.  So the *only* thing you should be doing here is s/_tl/_i64/ et at.


r~

