Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E121FC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0vx-00063R-QV; Mon, 17 Feb 2025 08:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0vr-00062L-JA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0vp-00062v-R6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so28656085e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797984; x=1740402784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQFPpqikWGLZdZt+Ak+vVpSJS+vmERD2ytvbDps7YB0=;
 b=Fek0DcnOCLaHw3pBwzJeeLS3pX7eC8q5WXNPXxAsn5pjg55F8fopnVsjUgfPGGs9hT
 uLtii4yd5AI+HoEmt0YsSI89w7Safg2P6Wa7fToXmuPJeg+f7wx14ulTXBuILN2BxDJR
 nqG9mKQ8ERxLwaD1RV4gRTwngatjeewbmju5NWF96DI6iFSVsmXCvOXirgvloa6BjXk5
 7AMfDvhNQP+PuhL6vhCMJd9pTSKtjPe67T+qwyhCjpLeJogEBBl5EIiUtqRbQ6gBql6t
 3o7YYPlmUTwMDkBKhl1tGlHXuU9ZHspzYrqXJ/bo3TsgdQ+k9OYwEoGAEHEdk9DEmjse
 e+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797984; x=1740402784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQFPpqikWGLZdZt+Ak+vVpSJS+vmERD2ytvbDps7YB0=;
 b=q2QS+rO3ymQTyXRZiA5OLT4o6bdq0knXNHnQFSk6V4rmK6/l18+4V3Zi0RVV6YgWPi
 Wc+cp5Yb0A2A3ptMZl/bbuzY98K6iW3CLI1B1z02ZkxtT+yBmLp/c4U94AUGU/tuWtmz
 ZOvh4cQty71/lI37B78ERU47iQ0ZEMCqRacUTrZlmgSBGw4kB6nubmVT/CrOR6PasrUj
 o1vn1O5bNE7JRWA68wmxvF7FJdzxNyy+Op1DfSHR+T5S8U3y8VBtsWAYTTO2otl5ohG8
 iOZhJ6PTyd+Zjkb6nd1GfEoilCNgDypQppj2UsmwTo+nJxLbbEo1Xx+AtlqnxeCZC+II
 +sFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfT/vTZwh5u7qTzqjFSLxrZc391HJeSmkvfKpNJPd42I0pWlyo0IXzW7mvrvDOvBz6SmSAi5qMn10q@nongnu.org
X-Gm-Message-State: AOJu0YycGXIpcyZVCpDkG5d6E0s7F2TXCmdEp4iKyU5cq0sjPnRalrUd
 v+r2sNy15Q+Wz/6DRGCscWqnFXC5bN34RrjjEybh8L1heJvOHsASFsJopBGo+GI=
X-Gm-Gg: ASbGncsWp8pYZCOwZUXmqrQ3npP1D32jinId4WXjm/t0hppGoK3RC2BbPUaMMZirl6K
 wvKoGbsr8tLRJ6qHXmLLrHxuz1vvc28LcMM3bv8+8haQKv9Mo6CXShSVI2myADAoOkjWs6KS89m
 Jp+iHnfHuBXItb/s20cOg29feTVOsjqfbKxbNyBlRYhdJnnI/gjZ6jWOPYt88+aEIxX3YEa9Xbk
 Yr+imixW41XfOSbc6hw1c60ajN27+zfPRZYvRE1Hu1uvgSGlcNq4W1yIZZugIZkuOtUeB/+Xpse
 J8h9Ptzkd3eyOO1SDGyuNJzU6Ay7bcboWcw=
X-Google-Smtp-Source: AGHT+IF+JRPnhOXlj87lM4ecO9V/c5QbaHzF/37+6VtXX7GL50353vyPYZcng3igfI7nmcy9Y8gklA==
X-Received: by 2002:a05:600c:19d0:b0:439:66ba:bc07 with SMTP id
 5b1f17b1804b1-4396e5bae17mr112750605e9.0.1739797983841; 
 Mon, 17 Feb 2025 05:13:03 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06cf2fsm151357575e9.19.2025.02.17.05.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:13:03 -0800 (PST)
Message-ID: <2ef616dd-b50e-406e-aac9-0afe59654af4@linaro.org>
Date: Mon, 17 Feb 2025 14:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] fpu: Always decide no_signaling_nans() at runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> Currently we have a compile-time shortcut where we
> return false from no_signaling_nans() on everything except
> Xtensa, because we know that's the only target that
> might ever set status->no_signaling_nans.
> 
> Remove the ifdef, so we always look at the status flag;
> this has no behavioural change, but will be necessary
> if we want to build softfloat once for all targets.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   fpu/softfloat-specialize.c.inc | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


