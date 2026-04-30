Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A91FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIK3J-0003Lm-5n; Thu, 30 Apr 2026 01:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK3C-0003LE-HK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:35:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK3A-000093-3h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:35:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso2886295e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527297; x=1778132097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S2oRmhlV5pdM6FalVhuaR0Ps706wYjakWQco6s0Jk28=;
 b=eRUa9kH/jMZ07K6lhy3Q2xuU7O7hXDFDVDlmkO/yztlNemc9DliGrf4aVhlaG0GWyW
 6sC60XI5N6Gy8A7r3Vf2jisWnxknjYrAZOg6KXwITeUHd2VtJPHKCK1ivXU2iEjYLm4V
 /16JqNmF/ZWgYfgCMA7gXGlnHSaUFSZRbm7pICRNJGNOS5mNnjcEDmA2XcNXloKuKFGA
 ARg8oMC5pIMhoUTJqfxV/9EirF+EZoveIyATWXWWSSiTIHU1l4WP/OU9F70MiacXPFCb
 vBiLhLFqdrWtVBGEa6l7ilxwqwUuIdooFxln+0Wirk3utue/+T7UnX5zJCS3ogCSQ1W7
 SvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527297; x=1778132097;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S2oRmhlV5pdM6FalVhuaR0Ps706wYjakWQco6s0Jk28=;
 b=SgPIdieiglgRaTxm0lYK/u+zeZOWOH/oO0FAq7T4Y+P61li1NWwVFWY4GRZq0toFEn
 T0Wk4GsjlgGbuqzeWRxW6X8KTLCFhleCZBVL64fAC0qU460lISQu/85DTMw5F7pW8X/q
 blcyQ237n4wjJ1687RpOMIW+7kMK/TTTzRnKR/1mIAQUHsmMOBTw6DIGOPDrowGou8jE
 H5CcmoKNj3J+/Uc4+BakYdxhgFMY0v33u65qw9DarFbrB3jbVkPOZtxgC6qi4uQFL0kc
 1bENxCJVWGm0dsxJx4FdxvfqSjDRJwjYEi3aBKyFo+8slb9ojRAur5qfg1iQjWqTGASo
 F/Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ946C2+dDinfEsvWfnBEoC5uP1cnnnBqR1x+Ij5NBG1lG6bYAlFS/Lfvqhah7dD6Xl/u2O84oOAhaO2@nongnu.org
X-Gm-Message-State: AOJu0YyoAnsOHawC/KTSq2xJ/L6T6iYp20uV/Pr0Mn9eI3CDtKG/rIEL
 ngMXczziU/mOVwh5c95tHKJMHBMA+LS5SeCCr3B3VtdXzUlGzcYxD/ltjGrJy4PG8rg=
X-Gm-Gg: AeBDietF8/aDDwVkDvmV/ByDckAZM5h6nU179MHzQ4xiuDC3onNsDSlpj5jlHgDsKrH
 mtJ3p+IHMpKLpr+LG/ewvmidFWKHqIsFUoxGDXZx9Fg9v/vvFr5FWP8qydkiDFvq4nYw32tNRg9
 iINSIL0PsRxhoSUWAKWblgbqTyKqXLK027dkASO4udID6g062Xo9X8xcmlpgjXTAIRHBCwyueIp
 vx0kLvNfI8b3jHNaXX5B3eqft2IZ3qWOf5pJ3WBTNcERpOZ94dWjr6bVXoi8pVcRxtYjrPqoda7
 wraKCv/YjGBO5lDAd6w8ytPAbyub6Rhn2WFDW4aBiGpNFeAn34qeBtHca94VQYeNrfVCYv/nl1K
 pvWbg2Jrrsq0MjRzzsjno2kvaet61MkxQiYVCf7x+JbJOPm3D0+RY3ad4OYkWEp4xhxiGsK4XYy
 ZVHtNFo7LJKuvcoMplXnmzdGAnkxHCkCfQ2Gr3lWbG1eBsg4DROhSM3FWZwEkAm+yVYy11YVk0R
 yn5
X-Received: by 2002:a05:600c:c117:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48a844a1528mr15415715e9.0.1777527297340; 
 Wed, 29 Apr 2026 22:34:57 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2fb5c7sm47708065e9.5.2026.04.29.22.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:34:55 -0700 (PDT)
Message-ID: <5ed130e8-4442-4393-a50c-322d7754d098@linaro.org>
Date: Thu, 30 Apr 2026 07:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/40] fpu: Sink exp_bias adjustment in
 float64r32_pack_raw
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Share the float32->float64 bias adjustment from both
> the normal and denormal paths.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

