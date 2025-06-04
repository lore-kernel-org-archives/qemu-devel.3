Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DBAC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMm9X-0000SO-EJ; Wed, 04 Jun 2025 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMm9W-0000Q6-0H
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:19:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMm9S-0004Cm-Pp
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:19:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1069910f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749035960; x=1749640760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ep35SEoqUkOR8dMfNcCXga5gHuUt360mpuJnPEtvqIA=;
 b=de0xFmxuT+mZVky8Dma1OC5jDaSenbvBWanRO44Gefrim3peCsc8AJUQ52dKhMFiOx
 3xVebqxhJivXlI9pcGNdBGOLoDH7jpaePDoPyaF7xmBeOci+8LC12kRVuNPZN7rvUxE9
 CHXE7ESZzX0eGEjomikyacadDhKrhyYgfzg0KsbW40GJc6lfCrcYF8j3j1jbapdE5VqW
 XSZIdLF/k5JQp5MeeY8knbKhfNSgbFUsaRTLp1xGoVophT1oI7pXGt7HId5/l0eCPBo9
 RK3qul+vtdYkLNOTGkdx/wphWAm9nfSh1PennqAblOXxT3DwQ2enrXtBbhfUul3xAqa2
 AN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749035960; x=1749640760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ep35SEoqUkOR8dMfNcCXga5gHuUt360mpuJnPEtvqIA=;
 b=pNcJice1AOYjxOksolZ5+ZZEmh1/JLMFKRnhoHuxG/v6tFJq1QV8aaBLvXKSXW6D72
 EH1eSUt6sJSNPKlKBJcob3uPrrUv/f108caxW6SwWuWF/SGQ300X1R/oPBXtE6rE4kXH
 QJ5ul2/klKliZOlKT4mWqw+8VvB9TQWYiZ8pQb/DvWY58CclvfAYjZi8VRkUZktXStaO
 qgMe2XAxt/G5j69ttCF3jxJvA3UUWMh6/F0Ct1a0UUkwSRrtbBa6IGk7iR7UF7J5c8Aa
 XjqIsCrxJuUU7P8Xij6bVD5U0Wp0fuPcHocQCeKhDIepnRjAbvc7UuAK4SehjCui3UI7
 L0tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFbpnu+Mv4g2AOqFdwXbqeiU55syai8SqjQzYdK7prqOnPyF5wKX+HzWuy6N7W3iE2pAFFzJKUOJiJ@nongnu.org
X-Gm-Message-State: AOJu0YyLAKF4FZ9hIOG4jnuq9LO7EaT48TvUpiKyC8trEN2kC5c5P2fJ
 VolPNzXCSeKThSCERi92P4N011WlrP/TMN31svZSPd1xnQRhQhjuJKaUsjLgAeSwxXg=
X-Gm-Gg: ASbGnctoL6fX6KjIYIYNBzB3s1OOWXbxp9ju0G6pDZaLtFMHZF/FUDpM46YOGla+fib
 Zg1GMEbWiIbXjasUfTaAuBsfwVlhAGNY9lZ9+4fzusb2at3FMBLPIB9nmc69ed+9/0yCMTv++aI
 0K1oNoRM+3WoIAkrUDfntqLrfZ//moDkPQ1I0Z3623Ct/D74Puwb+opZPBwGDwjcpFf8gG89PS/
 7Z3j3JppzUHR7EyFhJhtiH/m31ctbQE7YZ/oJ7C9Q5DWucUhp0rVvglwYfl01Z21wbeLE+VDV+t
 ec00FxnbrhY1BW78iJxmhrQU+if/H45ygT9YPzRWXj6paiLgi+b2WH9vF2LV1Y8lcwRsB+8aVjv
 pxb8Nm91OgULB+JOh
X-Google-Smtp-Source: AGHT+IG4M70yzbgfFGr4cLx+q6lQpgdoheKJEyYYf6kGIc7yAGQLAb2zcBsNKLW/EPAbq7QsVf/Lyg==
X-Received: by 2002:a05:6000:1887:b0:3a4:ddd6:427f with SMTP id
 ffacd0b85a97d-3a51d9667aamr1812532f8f.35.1749035960406; 
 Wed, 04 Jun 2025 04:19:20 -0700 (PDT)
Received: from [10.48.99.227] (88.212.189.80.dyn.plus.net. [80.189.212.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d800658csm194347005e9.27.2025.06.04.04.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:19:19 -0700 (PDT)
Message-ID: <531bf074-f951-4d34-a83e-0c53b7a6f8d8@linaro.org>
Date: Wed, 4 Jun 2025 12:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250604084005.528539-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250604084005.528539-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 6/4/25 09:40, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> but on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Fixes: 29bb5d727ff ("target/loongarch: Implement vldi")
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..9d82d162a9 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data = 0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3570,17 +3570,25 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>           }
>           break;
>       default:
> -        generate_exception(ctx, EXCCODE_INE);
>           g_assert_not_reached();
>       }
>       return data;
>   }
>   
> +static bool check_vldi_mode(arg_vldi *a)
> +{
> +   return (a->imm >>8 & 0xf) <= 12;
> +}
>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>   {
>       int sel, vece;
>       uint64_t value;
>   
> +    if (!check_vldi_mode(a)){
> +        generate_exception(ctx, EXCCODE_INE);
> +        return true;
> +    }
> +
>       if (!check_vec(ctx, oprsz)) {
>           return true;
>       }


