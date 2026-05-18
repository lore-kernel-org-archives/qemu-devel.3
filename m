Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E80CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 20:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP4Im-0004SQ-TA; Mon, 18 May 2026 16:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4Ik-0004Rx-GA
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:10:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4Ii-0006iK-VD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:10:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso22878695e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779135055; x=1779739855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5C2hYN0+e1ZuPhm36oCBMGZoosnk4qk5VS1wpggaF1g=;
 b=fJJMY207blZS0qbYeQuBgauLQjY1epitH+0/XegP5jRmq1HKv0vQuC3e1ahEWY2zFq
 zChimUAn31Hw/jEAvyHR3Sd1/pDKYmiI8Zl4spbOZtqQRqaTkOId5VjOdd9jQ1TJe8Qt
 /yeo510LZhgYIZWKVGZbSv8Akd4wKKBCWgT8+NlZEsm/YgPgPnYDkv8p7zBZ+zllyco6
 jJnUQlCKhbej+9A+nPwEcfMa3Xq4idHfrKxYD1hs5m3qYqmN4VfR6NlX14wB2E2Ic5sk
 loDzptgCrFZv7bYXfZU5WEckxb/Yxg89oJA67Q6of2impgiwFVqBR1MSDiHPH/HQX5Sc
 Jx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779135055; x=1779739855;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5C2hYN0+e1ZuPhm36oCBMGZoosnk4qk5VS1wpggaF1g=;
 b=oQY9pA/wRf6fq0pJh4UY+IaxJAUPPg/nAnu7s047Xgr6n2Xs/B18cfS2PghfoYHMp9
 lstwr/vurgQjt1UHHpqCIrxIJg2EQkt9QDEfCaLuvI/3zEeIJvE5u9CKjEe0plZdFRzw
 HYUxapg/EOFTtmSzd3JXlPVTD3awMEzgB5EA/2hVZ9l4CtJmqhGnCZmgwotSHiEnnC6b
 j4VIGL93Zso9KKplqIAVtaXzm6t2uOxUXx+FaWedpcDqlXjywYTHwI/2bgsjlZxlXTLI
 ScliuM8Y2TUWS4rmGq+l1WUvvt9g7Ha+R8XBfB+jOF/ef8dp9YfXRjQhkdyoYKc//xP/
 x5/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O1WXR9nEJUH8aQGxnPy6ntHW8HnZcywsXpbVnr4dguWvkI2FUobkoL+kpC4e7TeFxa2WWql+HCseW@nongnu.org
X-Gm-Message-State: AOJu0Yyds4MJfeGBoExikVFWd2AO5wh4rY7tIw/qzbnC690FJnl1Wvpb
 5HsTLpYNgYgAIqMhqIeAEf4FZUVxxwzBmmfDwrwoAHxlh298qMO6jPDT0mgeztYsY5admsMYmyX
 6NJpvYwY=
X-Gm-Gg: Acq92OFvn5oAfJI8vKgTsLXh6rTVABSjyVkwdMVuSu5FYp+7TM1Ti30QKc/7P6SjjmT
 XzXgOEjX9Yd24ajn7mCexLPPLV8CRx/XaqQm8EfI5FigXWgX7Fe26d2AnLEtGqZDEJCmCHS4Jih
 XhWQITCzStJgApgUymgG6Xc8CbJf+bkn7aJ3qLy8wwIf79hlpLuRtpDzNgxha5q0WS8n9mTk/s8
 OGhXUxP+OLtCIE5mgf902qO8q2sql9JF/6IrY47nb1heE4jAjDtUvkWATk57uhB47BAUDvcGK55
 0aO/O2ifXsiTF+UbQl92a0OGv0EIWufcHtJSpxhuFEp4rSDnI7O5pubZHBidGx1Tv34n7MdJFEc
 IsL5YJ35w08Q6a55+5tKdwaPYM8q05DdJ0vOnAFyCbkF0LnCd19+OEEsLvtjElZnK+MB4xAm/Lm
 BusPemf+pRJohBN33w2uFLQEb32yrA1cYDjSgQuIbid3xI2/w1OFv6aqYQFhGF0mkQUwAm23IUS
 mMx
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id
 5b1f17b1804b1-48fe6626cfbmr261019315e9.31.1779135054920; 
 Mon, 18 May 2026 13:10:54 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe58638sm86658785e9.17.2026.05.18.13.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 13:10:53 -0700 (PDT)
Message-ID: <e0f4dbe4-7573-495c-9802-b021cd226592@linaro.org>
Date: Mon, 18 May 2026 22:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] target/arm: Use FloatParts64 in f16_dotadd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517002550.321291-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
> Use softfloat-parts.h so that we can more naturally
> perform the required operations witha single rounding step.
> This happens to also simplify the NaN detection step.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c | 96 ++++++++++++++++---------------------
>   1 file changed, 40 insertions(+), 56 deletions(-)

To the best of my softfloat understanding:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


