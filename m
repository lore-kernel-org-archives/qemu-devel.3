Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6144CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 20:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP4Dz-0003eJ-5U; Mon, 18 May 2026 16:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4Dy-0003e5-0k
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:06:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4Dw-0004eu-Fz
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:06:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so22368195e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779134758; x=1779739558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuxY4TNT4NrE+d7nPm4By0S+Ij2mE4zsTuMrupvUsF4=;
 b=F3kAnu4EUT9HVfEd3aRlz4Opqh2u4S9fhYCiNy7CWHULLsXQXIkuDeTrgspHG5IjTF
 l+JfQ2qXVfkjpdDcw7+CC+S4yUgkwpjc1el5fES6p/SmEJU8OEVpNLvCyPdOUhK860Um
 YfKCziMCur/ewonaZ+p32xypFfOcFRZX8NER2MYJv56LBCCafn19OrM4T9bPe/QkN258
 gFlAGmIwIaTpkdBTBCt8GzH1f9TyjwRo/62mvHPPmhFIiHl9jBvwKSBj45Q8HwJsi39f
 9qnR0wfAdn3HWYnRQWTruRKxyezbQF+GoTe0aJweCF0pVI2MztLlq4MeRMm1alN5B5mq
 osiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779134758; x=1779739558;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuxY4TNT4NrE+d7nPm4By0S+Ij2mE4zsTuMrupvUsF4=;
 b=kdOfyxlHp6ng4oNVuf7ItRf1dizYQkvPd6790UHyk9wq3D5vhpN5GB4ze4eDMcTAwK
 E9q18cDa08gGeygZOXv6GnnjXpO0y2ruj7pZoI/CZZIHaI+QGHWsFFcbwKi3/+MJiUZ1
 Vp4jDguks5ZWaYd7UVCSjEF9oaEcmmKa82E1C7IMwmldDX2D3H4Lh0mVMPKFralFY17V
 eyQ3KJyqmrtlRqlHpFBpEj+Y2aCJKQaIEXCoEEcedilYkvnTTMWX0OH8p3WXixAE1Kop
 UO57sejed4kHf5/A9+GV7twyA39VLAuJG7l8/pWeuwAkcktAFVPqqoNJ1bTAHNL3/YaY
 sOcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r+fS0y3OhNRalybYPYTj8yNmWvadvJd8mHiPoVVSeqVccvruX3D6kJmf5h8JUfeWw0NeuJKacqxG2@nongnu.org
X-Gm-Message-State: AOJu0Yx5hZx/izJ1/PtyWVbIoqBKt+6u1W4oQgkXzSUnAJK6MDJRiuUE
 9pqCDoviSCdxwP8lbhggtT4PJL0fdkaLja4MtK9xiCOHmCKGK5z31sbf5qvnpsIMRQw=
X-Gm-Gg: Acq92OFe2ZKN3ceK67wGW5dl0SSTN9XeO8lowz6xfNnuQzNls3UwVftSUspe+3M0Ym0
 O+JCFnMHoCJ2yGQ5gIMxnMFzmsAL6ZmKCYQ/3uc6Gusc8IoW9MEV6kB/nKMdca4boPxc/FYfXGI
 d4Bzli/7w+m/panxDwrvzgB6ZH9En7npOENOjV1SxnTpEfyU0Xz/uzpbYog3tlAX3k73/Jv838u
 Y+1Y6lE6/6mopO5m24Fx7xxfQVdsngNCsR3Ie2J11BKJRYObhZKbD+jVeBU0a9tSQoYrV05N8xG
 FV11WJPsQtVKo46wNpsxKPyBxEh1H85qj/4y2unnt+dufYL6TwLRZ+kanDW9EQxgr3fNxv10bbn
 dyABjfRP/usL9QMK/IU/yTagGTyl2p3MVLTA1TyvrUI+VQ1MmKZF1SMv24BTzkgbG/PsnTVoFvs
 lpZ/UZlMfZ8VL73itLG2Md3Cq1gQp1I5rW+DRsekMIe1om/dgcwCeot74hf4vq7f+P+zqErhs87
 JIHaWz4ZgtHNuY=
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-48fe632663emr305752115e9.18.1779134757766; 
 Mon, 18 May 2026 13:05:57 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm295133455e9.6.2026.05.18.13.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 13:05:57 -0700 (PDT)
Message-ID: <11a4d47c-ede2-4431-86df-4dca1140b47c@linaro.org>
Date: Mon, 18 May 2026 22:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] fpu: Saturate the exponent in uncanon_normal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517002550.321291-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 17/5/26 02:25, Richard Henderson wrote:
> Notice the conflict between saturation and rebias_overflow,
> which should never happen.  Otherwise, saturate to INT32_MAX
> and allow the usual overflow to max, infinity, or dnan.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 45606f8402..914e588ec8 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>           g_assert_not_reached();
>       }
>   
> -    exp = p->exp + fmt->exp_bias;
> +    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
> +    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
> +        /*
> +         * rebias_overflow wants to compute a modulo exponent, which
> +         * conflicts with saturation.  That said, saturation can only
> +         * happen with scalbn, which is not a PowerPC operation.
> +         */
> +        assert(!s->rebias_overflow);
> +        exp = INT32_MAX;
> +    }
> +
>       if (likely(exp > 0)) {
>           if (p->frac_lo & round_mask) {
>               flags |= float_flag_inexact;

To the best of my softfloat understanding:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


