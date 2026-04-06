Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14752E9D828
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XmD-00054K-5e; Sun, 05 Apr 2026 20:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xm4-00053E-C8
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:25:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xm2-0002FA-Ia
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:25:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82cf96ca071so1417116b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775435101; x=1776039901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DlVOxNwuoXBPn8LHCFIWM/LCDeJ4F5Ftsm5aeq+3dJ8=;
 b=Y6RirOOacr2XeiU/9n3KzckmeOBfkcbIlhiwrROyEQEydJ0rjgDcH9MtV1cg3+u4w4
 8TUSHhC9/CQWZk2DhordxHZlLrGd2BG7YpqAaKsm5hH2jt63R0yeXYeMnzOYuwSJCKgh
 wK1IE65VVWoiyLsPbTGxgxT/pyvgROqP569SpNHN/oD3lL8mpBO30awjx8/H1RA0bCNe
 AymZLYx2URNcPNMaiz1aI0vpPeI+58qI8dO9iqv3UUbq8UMZJVlL3ED9TOH+VGZdGfYd
 ZFDozY7TULFCz/1EDlT79DUB88CIvGUmc7IpYL0vlen9wKQwDXiCzOADkWzF5ybectUm
 oMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775435101; x=1776039901;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlVOxNwuoXBPn8LHCFIWM/LCDeJ4F5Ftsm5aeq+3dJ8=;
 b=ClPw6916RkjlM5ZjPtBB81xt6K2XIN6YkV32by0/CosOqw2IjlFy1y1LQHMFO2GyIg
 e7bRg6CxdtRwaD5KOzpDBl5Fv1IFjMEYtOE6l9KVloAbRJZmo/CArjYJCXGtcXuKuTRc
 glAxzTx9ycvBiUM/84dndbngf3vxEA1jaAAtJ5QujiTpV6J9S+B0v6Hq6VWbrgHXcHfK
 zuqZofo5I0Kj3ffVKdF6naXFcSP+La9TUp1LoGpMPWVQ9V4yzqyz8Tr/wcu4m+9ZVGcg
 Bj1lBYBHvt+KFEcmxn71kcWLLc0V6mIgL/DlPou7v15meYkzMNQSpT3W8m5L6IGpT1Nd
 pIqQ==
X-Gm-Message-State: AOJu0YzqVGzhbr24H8wTvr3ITEXEG89bP7+D5MyPTXXxSEzGiG9KNyoR
 WiAUlp463VNtUTMd00jqwmBuohRmW9cLZ2c+uI8f83sA4HLa7WfVKwjWIY3Rh8xmNpp6lfC1PBD
 UYl96
X-Gm-Gg: AeBDiesI34XcEetRFnsONqhNSQK1xfDIiG2utVW8UF6qfFoGWZf06ve+90JoPmpYGA1
 SN5o/L2HYM2ZUQIzPTH1xf2pK2xAYJnDXTdhVS7yaM2OqsEna/KnLWNQy+OvVYNAvMLlN1hCg51
 +bRYfID+axQXW5lkgno7NVEDaCl/AQogoME1R0W6FyVMYzn41arzs62ag18gZ6W5tLJTtUjrdCt
 9bPFEIyLxRMxWQ8g8SZj0FOSZg1rSHjpKN0Kuo/q/lQFYmDMjIWv/sMyLX7XWgoLLPI16jPCXTQ
 3AMu8mVxW35Sral8zSwqivZyBbB9cdgAZolIckmjr70HKw2khmvywvFqX6hd1TDpJDVewQC15cF
 SXnbNSIDAfiDpGsCyzK+ZpA+UsSWSg/eJTeCrqoEwzSHc6JZtBB72VfGwYAG+JlgdxQnano0xRR
 WqHiziC7VEr0VqbYUWhyrNsNVAG3zm2kxwGojqCFbNNkMHbNrMqRIZk+ThErI+pPlORH0=
X-Received: by 2002:a05:6a00:2da8:b0:82c:eafa:8875 with SMTP id
 d2e1a72fcca58-82d0da3ddb2mr9852088b3a.2.1775435100745; 
 Sun, 05 Apr 2026 17:25:00 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c3d439sm12766520b3a.35.2026.04.05.17.24.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:25:00 -0700 (PDT)
Message-ID: <4386d42b-e3fa-4aff-8dde-dcad80e6aa98@linaro.org>
Date: Mon, 6 Apr 2026 10:24:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/35] target/arm: report register in WFIT syndromes
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Pass the register number (rd) to the wfit helper and report it in the
> syndrome ISS. This also includes the correction of the TI bits for
> WFIT traps to 0b10.
> 
> TODO: split the helper flags
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h          | 4 +++-
>   target/arm/tcg/helper-defs.h   | 2 +-
>   target/arm/tcg/op_helper.c     | 7 ++++---
>   target/arm/tcg/translate-a64.c | 2 +-
>   4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 1887467b719..f303c41d71a 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -670,7 +670,7 @@ FIELD(WFX_ISS, RN, 5, 5)
>   FIELD(WFX_ISS, COND, 20, 4)
>   FIELD(WFX_ISS, CV, 24, 1)
>   
> -static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
> +static inline uint32_t syn_wfx(int cv, int cond, int rn, int rv, int ti, bool is_16bit)

rv, register valid, should be boolean, yes?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

