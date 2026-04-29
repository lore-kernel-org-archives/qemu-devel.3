Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C769CFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICWu-0006Rj-Ql; Wed, 29 Apr 2026 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICWr-0006RX-FV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:33:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICWp-0000BU-1Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:33:08 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso156446b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777498385; x=1778103185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APrdlNOVOzTzNsfgJfjshYUX+ge9YC/XpNtcfI09iYo=;
 b=LRkvn0Kil+KxoGzepHXzHY52lpF1WwvS52HoO3+Rt49qODM60yWSQZGrmOVhGwX6KK
 MkdT2I3XCXKsWSmz7QPlfc4WPh8xP9LhH6ByxaxqW/MCPxUepVKwqtXVBN+eottor+6O
 jJqEPQ031gi4f+UI9IOxqh0XK/DdU+MLXofLQU/Tkd0ej3MEyYFJPDqUgBXHaAlQ1rYC
 mKHxhiI1zfkKosYdMaBgjIIEviHC4nGRL2xvfAjXjjneTQZCJ8TQbg+KSEL1dBeqGCbC
 kT+ACtIQrxE79q88bPQrL4xcPeOFJ7AJtSQ3VE4WxBlpP5S/qHnE7rLNPicQkeWCRW/w
 mhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777498385; x=1778103185;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APrdlNOVOzTzNsfgJfjshYUX+ge9YC/XpNtcfI09iYo=;
 b=YUa40MqLT/VtTP7tC3OjU76dw2uWxobmFwmGkcL5yms36urzR/ZK+dsYbCZPPazxZ8
 /d0LMActZgDZvS0CCgcBwYgI/SssaUTjFwC37FLr1idJTH/2iUabQbqVDwDLeo432gxW
 Uuf+WIN748l8Xw+d4ZP88fwbwRSq3WmPeuC5FuYE9faStu+gd6rZsqoXNjT9iVxVAaM8
 Sx50Y6wBP/VMAukdYZQ0d/rkewNiuGWz4QIToCdhjwVz0MGfznkZXgW38HrgaQDtBcL1
 b/MS0RfpujbhWAuMbUB1zFmgOdOT7qZOqSFqOkwDgP1CyUobupk2mCVuTYpw3KfYIYfk
 4OzA==
X-Gm-Message-State: AOJu0YwbKcekUMvQRuiAwSvjDBwdfFLVWUnHftc66Z9qLy1hTfVDIKYe
 Yc1lfuI21nrfiZMIEfAJ8UgKuD27F0ms1iqklB1u4mXIqEMt++iRGc9g2evXxqbNNzOSlWnrg0t
 NCnV6klQ=
X-Gm-Gg: AeBDies8P/h5pzgxSwrI0KIfaiXiZ9rw0YJQdKfEuGN3uNl7BKq157iwsk174gpkJIS
 Jthm6ZqW1kzYJ12Zd91tprWMY13MYvv4O0qyrGc0ysaadsbpAnwNfmpcKCtbcB9vAqK9Mw/ROGg
 3wvm807JqJOxMeQ/IL7jnEVrYSRcjIqJ3G2CA82FMaA5XmF3aGCUSZ5r/Yxq2v1VoLZ8nRtf68K
 nek3PBilHOeiUIj12Fmyn8YB4WG9CQks9ISwjThErNI6m7Ocn1QVqb93tY1Nu2b7BT0xKmurUzD
 nkgiOl1211W7w+k9tg5X67TnpgND71dKLDWfZml2qKI11BLIC/CzIolAJvsJbGBxYUulwgsO6Ie
 4EAhrD1bBgSWlbeHT4KrZQYjkiMxubplZfCDblRc3h1CO5ZZAs6up1cIg59mPhVugWUHwrzNp1M
 0iP72y2gsOyTDkJdtOwu+bg6LINh0GzD6tibhHdN6Xy1IRuuw3WWTC8N0RGQVxHbM=
X-Received: by 2002:a05:6a00:369a:b0:82f:6bd2:eac5 with SMTP id
 d2e1a72fcca58-834fdb16d75mr359612b3a.2.1777498384968; 
 Wed, 29 Apr 2026 14:33:04 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed80dfbfsm3039920b3a.53.2026.04.29.14.33.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:33:04 -0700 (PDT)
Message-ID: <ed3d3306-5bd0-4d9c-bc27-8f3e091c8171@linaro.org>
Date: Thu, 30 Apr 2026 07:33:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/or1k: fix gen_div INT_MIN / -1 undefined
 behavior
To: qemu-devel@nongnu.org
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
 <20260429170519.2137725-3-joel@airwebreathe.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260429170519.2137725-3-joel@airwebreathe.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/30/26 03:03, joel--- via qemu development wrote:
> From: Joel Holdsworth <jholdsworth@nvidia.com>
> 
> Signed division of INT_MIN (0x80000000) by -1 produces a result that
> overflows a 32-bit signed integer.  On many host architectures (x86,
> ARM) this triggers a hardware exception.  The existing code only guards
> against divide-by-zero but not this case.
> 
> Add an explicit check for the INT_MIN / -1 pattern and suppress the
> host-side exception by substituting a divisor of 1, setting the
> overflow flag instead.
> 
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>   target/or1k/translate.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/target/or1k/translate.c b/target/or1k/translate.c
> index 1602e204fe..68d40111f0 100644
> --- a/target/or1k/translate.c
> +++ b/target/or1k/translate.c
> @@ -279,13 +279,27 @@ static void gen_div(DisasContext *dc, TCGv_i32 dest,
>                       TCGv_i32 srca, TCGv_i32 srcb)
>   {
>       TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 ov = tcg_temp_new_i32();
>   
> -    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
> -    /* The result of divide-by-zero is undefined.
> -       Suppress the host-side exception by dividing by 1. */
> -    tcg_gen_or_i32(t0, srcb, cpu_sr_ov);
> +    /* Check for divide-by-zero. */
> +    tcg_gen_setcondi_i32(TCG_COND_EQ, ov, srcb, 0);
> +
> +    /* Check for INT_MIN / -1 overflow (0x80000000 / -1). */
> +    TCGv_i32 t_is_min = tcg_temp_new_i32();
> +    TCGv_i32 t_is_neg1 = tcg_temp_new_i32();
> +    TCGv_i32 t_intmin_ov = tcg_temp_new_i32();
> +
> +    tcg_gen_setcondi_i32(TCG_COND_EQ, t_is_min, srca, (int32_t)0x80000000);

Just use INT32_MIN here.

> +    tcg_gen_setcondi_i32(TCG_COND_EQ, t_is_neg1, srcb, -1);
> +    tcg_gen_and_i32(t_intmin_ov, t_is_min, t_is_neg1);
> +    tcg_gen_or_i32(ov, ov, t_intmin_ov);
> +
> +    /* Suppress the host-side exception by dividing by 1 on overflow. */
> +    tcg_gen_movcond_i32(TCG_COND_NE, t0, ov, tcg_constant_i32(0),
> +                        tcg_constant_i32(1), srcb);
>       tcg_gen_div_i32(dest, srca, t0);
>   
> +    tcg_gen_mov_i32(cpu_sr_ov, ov);
>       tcg_gen_neg_i32(cpu_sr_ov, cpu_sr_ov);
>       gen_ove_ov(dc);
>   }

It doesn't make much difference, but you can write this without adding new temps, 
especially since you don't need to avoid cpu_sr_ov like you're doing.

     /* Check for INT_MIN / -1 overflow */
     tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_ov, srca, INT_MIN);
     tcg_gen_setcondi_i32(TCG_COND_EQ, t0, srcb, -1);
     tcg_gen_and_i32(cpu_sr_ov, cpu_sr_ov, t0);

     /* Check for divide-by-zero. */
     tcg_gen_setcondi_i32(TCG_COND_EQ, t0, srcb, 0);
     tcg_gen_or_i32(cpu_sr_ov, cpu_sr_ov, t0);

     /* Suppress the host-side exception by dividing by 1 on overflow. */
     tcg_gen_movcond_i32(TCG_COND_NE, t0, cpu_sr_ov, tcg_constant_i32(0),
                         tcg_constant_i32(1), srcb);
     tcg_gen_div_i32(dest, srca, t0);

     tcg_gen_neg_i32(cpu_sr_ov, cpu_sr_ov);


r~

