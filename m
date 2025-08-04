Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1616FC87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3bE-0002Jr-Oy; Mon, 04 Aug 2025 18:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj3b4-0002GD-C5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:23:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj3b0-0007N0-14
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:23:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76b8d289f73so3404648b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754346232; x=1754951032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C11V6iyXWKp5KCR02XvUBcQUNxjQspOybdquxZQLdYA=;
 b=HfLapiNjYRn8eFc7s7ozidJgaQcFkVml1g8+HISrSmhbch1uyq15tYL0cxWrUndyGb
 J7Ry4rjUKRGhJg+Wzks2iqkRnwVtefdjRFTlFdzqylvg3tXjW5E+WUnv3jGHQk74lBPe
 W9tBmL8YfkspXaJBI43J3LTYNaXIIoEscPuyOxeZ0albrkNGRqWD2RkMPWLVgiN8eAXL
 DgJlBueSZdrtkHS4+Ti0D+RsjFd8lmRJM0t6FVWrOpmA9ijCV1nMJP6GNOOkNVZCh5sU
 6wlP7TNpuiCVzqykKCvlXJtLGA4lSnjm4bShNj20U6UbGfDKYEhmRp+DqiyH148r08lB
 Zo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754346232; x=1754951032;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C11V6iyXWKp5KCR02XvUBcQUNxjQspOybdquxZQLdYA=;
 b=AoossmkPR5Zy5cc82eVDAkqY5+xx23NLjjbFUowHU+yk3sEV2i3Y3egp6JrgudAQhe
 McLHgBoIXATaHsazpDWeB4tkkbIWLzkIYV/beZ2NY1dQyTtHSGf3c7rz4ebTnp+0/EwQ
 HhQekSAjONq2BgiLAKOY98UH3sz+FF+WUi5VMR+597IHkgYjLzxIZRmUraHvS9zlLWz6
 bdtR89tTASup+yIhEW5E9BtrHsE4j71hyZL12FW4XjWhepnw6Et/lV0n6cwDiAdd5dPx
 RSldvzBeRTgfDHLZE2PhnpXtz9u6JCd/iz9eFaHkhGADgnXz9TaOzOnUU4tE6nUMWdPF
 t0gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp3ovs8dNi5Qp1BEZAsgh2jGDkxG/zLSXmpsLHIrf/m0LcOT6vRD4zIJpJDkDfA3+0hrvMFHl+uj1C@nongnu.org
X-Gm-Message-State: AOJu0Yxgwn0sArVNG3r0Kxkv06IBtn+1Y25pLgXYLDio7U+OORD+9u9/
 2NIn7X6uDtdJVfCOJkATv9NC7V4gyjVxpQl6LS5DOKk7k32Zloi4TYG6czpg4jLcssU=
X-Gm-Gg: ASbGncsj8nLZX0zFwh9D4pDpfqiGlbqcSQbXPsagVWa9y0Nuv8cgDuLEEONSjmNFynf
 VBG7Ud0OH6Th+UHw8tmiOeLYpHmbFmr3fIKsofSCTlrgnTGpVdC+Spx1QIq+u+BUEIGsWCGK3/9
 I+JZFlaIcM5vsVvQPOKfHC2dZ9YzP9PebV6xL2djQeXpCk1QAtVQbeemjXgYlfZH+UOS/Xirl/B
 qbdLxaAKM6RwptNNqm82HY+RGUXJQNkZsOV62ZrQLGsjjionWerR4LhzLsHsdnjeyfUdWHAcKEi
 D3ZHJ2N1ynAGnsRsAK8TdiCmtC5XDLWyD1PDP4OV3d4bQXlz+nvNpsj5B4b6mBgl3IO/3hvKK8f
 NoX2OTg0831q5NiPHYlRDOtLprKbfVB2TgPVHe46s
X-Google-Smtp-Source: AGHT+IHgod2A648kSf6cGGQtq0c1tGp7Y9bCZNi6vSLTRMEpjS8YDsia+J70EJtHTNNv6O1BPed7CA==
X-Received: by 2002:a05:6a00:a85:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-76bec314c7dmr13291605b3a.7.1754346232129; 
 Mon, 04 Aug 2025 15:23:52 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c14f98fefsm1539951b3a.122.2025.08.04.15.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:23:51 -0700 (PDT)
Message-ID: <88a8333f-0507-4342-8858-445e348c6807@linaro.org>
Date: Tue, 5 Aug 2025 08:23:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] semihosting/arm-compat-semi: change
 common_semi_sys_exit_extended
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
 <20250804183950.3147154-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250804183950.3147154-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/5/25 04:39, Pierrick Bouvier wrote:
> We now check only is sys_exit is extended.
> This allows to break dependency to TARGET_SYS_EXIT_EXTENDED which will
> not be available anymore from this code.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/common-semi-target.h   | 4 ++--
>   target/riscv/common-semi-target.h | 4 ++--
>   semihosting/arm-compat-semi.c     | 3 ++-
>   3 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

