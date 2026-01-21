Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5179DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 23:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vihiX-0007Ef-TL; Wed, 21 Jan 2026 18:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vihiV-0007BE-8Z
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 18:34:27 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vihiT-0007T3-0C
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 18:34:26 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8c52c1d2a7bso161982785a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 15:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769038463; x=1769643263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qj+DHUzATLnjvXIrRWInk4yoR/8+YxjLr7gtSEauKmY=;
 b=fK2FL55GMvGktQVe2OjfDF62TFc58jeqaX5ipD2D/yTr6DcqXDYMgDivvWzXMGXaEo
 NQWyuGhdx0Koq2G15mA5ayMbp/k8sSuV0Lu1JF4P6NLaiXnARbAudQTfzVXjWbgAioRm
 y/f+sMuaMSyMF5kcA5GWr0MmTBsv7rEakzflKG00tSOPgIgWBVeFGqIRZZ/Z82lzrL6X
 9+YTPD+Xu7jFMoDOIwJqnRVeO+KJqIionj85r0Bfh0oS3LQMeuGl83B4fz3h5URHve/x
 c9vlkWvH6Qm/E1TlIgLIWWiBjmhcr1SIfoUMBZjYcbe3bnxlBGzHBN6dW7Dpdxcv9Bup
 ZoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769038463; x=1769643263;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qj+DHUzATLnjvXIrRWInk4yoR/8+YxjLr7gtSEauKmY=;
 b=ev7qfo4c38xJyt3R/R4EU0N9pDPfM7vEyzYymRMaoPlG0pxNpFIDELPu/NwOIR0h8B
 vQLJyq4DxVS0d18BOgYXy6eViZ1jJ8fRiYEqTVzFsDUs/1QjskKhSB0e+2gkfYt6wRmB
 lmtUntN5zQPnMPuWjfEGqDdBNhulpwBRTYb9AmXUS64/pTZt1zvDtd9y26edHndGg4rK
 Xl1k6kijweWYtcjTqIeTzrJCkT2f7BFeuYQT4kmww2V+G87biIlJL00vQUnogDCLU8zv
 jSN1asoMoXm6vj+1QEuT4th3BE1oQKHOf7kEOGt5VP90q7z1TW2vdLLqjNv5BWFTlK3+
 tUSg==
X-Gm-Message-State: AOJu0YzB3oqsilcnNQ4C1YFJUDWNa85kWMWwEnlV0hwQzc5G1STHMT4b
 XH79gVgCTVGsBuWbUrIKkgoKa1yUOoDUdWz+ha4QijPZy0/2sXU8BcSO/C+U61HuF8l6eKExR1G
 OCdT8XLs=
X-Gm-Gg: AZuq6aKaVCndJ08sUJAN8T6SG6i1HR9RmKHbT3suur9/Ze8c/Edcub7Xnoqxmcrpoh0
 k9B2U99BzgbFGUCYNz23170pvbCebKpe2I5bni/NBdhefBi98F7gpEDj0CBkR9vnpGknDQV6s+6
 MgXe41kXk5DDH27CWhJZALfvyVHAPMCfiqV0L9cNdN8jqBO3AZS06tOgm4zZXhL+ansbBt9Pyjz
 7xEhCfDbuTDfCHfPRS9SzurW1YVChC6n/9dSr8eOyKIfIq002uWM9ZjuG31aTmzv5UwSlL1TKJh
 vFNm2Eac+yRWKoTVFkKzV/rheY/L4jPZbjgTWRyaqDVhGL9wnPBH2BHnifU3sAImATiuurWGaOQ
 wmsSHyTYD0VrX7zIc4X9ixiyYalF1+dLfuPntd9NkV84QfkXojbcUVPUOUWYISWxplmL5Xmx+g8
 1oCG+giPr5JHRrbt42XR7a896XYttFCrFlh5rpmJInMpF0pNm2xqE=
X-Received: by 2002:a05:620a:7105:b0:891:7008:f2e0 with SMTP id
 af79cd13be357-8c6da876333mr176661785a.8.1769038463324; 
 Wed, 21 Jan 2026 15:34:23 -0800 (PST)
Received: from [10.244.221.227] ([172.59.190.48])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6b22bb7cbsm1060075485a.39.2026.01.21.15.34.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 15:34:22 -0800 (PST)
Message-ID: <d3070a83-10fe-4682-8270-c0af21eff144@linaro.org>
Date: Thu, 22 Jan 2026 10:34:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Enforce sha256 as hashsum algorithm for
 all tests
To: qemu-devel@nongnu.org
References: <20260121101957.82477-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260121101957.82477-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x732.google.com
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

On 1/21/26 21:19, Thomas Huth wrote:
> From: Thomas Huth<thuth@redhat.com>
> 
> The functional testing framework currently supports both, sha256
> and sha512 as hashsums for the assets. However, all but one test
> currently only use sha256, which should also be sufficient according
> to the current security standards. Having two algorithms around already
> caused some confusion (e.g. the clean_functional_cache.py script only
> supports sha256 right now), so standardize now on enforcing sha256
> before more tests use a mix of the two algorithms.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/functional/ppc64/test_fadump.py | 4 +---
>   tests/functional/qemu_test/asset.py   | 4 +---
>   2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

