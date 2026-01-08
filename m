Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF157D1D495
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxJm-0005OS-HU; Thu, 08 Jan 2026 16:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJk-0005Ei-W3
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJh-0004rU-E6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so2125270b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906787; x=1768511587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RvAc/ZxsvRvyd2pFtMY5EPKZV3+49Sr2Ie0Y7dfTpvo=;
 b=HePqPdCg439auWTNG6t8YPVc2BTKF9kJUuXkmS/3p2y6lrF95o2fxmvY4+Xs9QWaYi
 egMsIfyJGSNajAFcjqJzNPfyIIgbSOAsTc3p5leT+iYY2faMfBQoR8Kgb0+d2USiG4lm
 Sox8GQz9xMpEqldyWDXATXarAljehf5/25qRV1pMCqnIwBKcOz/8+8nsGP/eXepwKeZU
 lsjZK74FGeRvSevuzJbNixGCTKAkcn+fjL1daC2lpjnRl/fJmdDUt4+eh7BGqFrMk7go
 0BE98fbQTUXU7oZxbOhgb6jUcnEilEv7DqjDSzpGKhMNPK32RxLA43trvr0F0LiffYsW
 +Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906787; x=1768511587;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RvAc/ZxsvRvyd2pFtMY5EPKZV3+49Sr2Ie0Y7dfTpvo=;
 b=W8X7XzNhDnjm0vk3F3FdDvg+1Q42QPugurfChSEI5BhHTLfjR+K5VW/+2l9bjveVQ6
 abKzHXH3bJDROCzbcbtVCWp+yx0F6tq+K9RR9Vog2hkkuielAe0XD1YKfu/pyrMspro6
 r7CqJBs8mfwrJCmo82TZN9GbbC698dkf+8qVa601guJgEpbyBP2sitfjB+U8IlaDil4E
 SSARFPWHw+9kyWflGcm3BgGho+pSnMpVHv5QRHVrcHPR9Eqc0FN0opQ2Yzh/nS/BVECa
 dO9AkM/SG7+j5pDYQiIbLKt9deIxL6ENxC6NAXEU/4o3WMt/2BnjNg6d577Uu8zYE3hG
 xz3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCLS/NKZhBe7cCbPjbPWaVrOkUaK5WPKpcZQ500RXbRPVN1OpDJy05JZ0EOzzP3JlTr1+7z7usSZPg@nongnu.org
X-Gm-Message-State: AOJu0YxoWomC/AdO4LgJvMgxs/dkhhjJLKupzcJKkx78fiTlMDOh48Ez
 rq8hDq9pqAQ+Xqcwsk9mexuSgXiiHK7/hPVugDzkPbFqo1WbpH+IkksJ/+NUREzh2rYxyprby8g
 JTrbr
X-Gm-Gg: AY/fxX5eetnLMWDLxHF6sSua8UgvBizbZl5eF4Ou4+cV2ts4tHX0PwNjKT/rBjzoXbR
 Xv3fOr5caAyYyrdUOfVr4rc/R8u4jeUgwFgfhmnfJM8xtHBc7LiWHGgiQ9XEAvdhg0Yisdw4435
 E1leAIEp5aA2HoozcmTqyfdpKnlf2mt+erVqFLAYYa+riuhR7/3TBeloTkSso4WA3Bcs4W3qDea
 iFEIgMPSJejajCLagUCpBDsGLySek1JITfc3OZh3imMKg3tqla2Ejc88r/HaJOpobHBtgt/lkvL
 jvLjsy50i6BcxeD0RFidSKQ2MMq3l67sWfxpMwUr5sJY6lCFdI7ZFR3RgUobgw9t0kR7GWXAWCu
 l5VjKipr3yvOP1zWdXiiQ5kGO0OlqckRbi01eP4VvEAY4FymV0907fuBi/08XC4i26ab8U92rRh
 h+nZQlUKyust9t8HbvWeMxJlldlEuv/wJN5qEraIFF9PDkLpvcVQNz5c2O
X-Google-Smtp-Source: AGHT+IE5QEc25Nr2mQTW2Ka7v8G+8WQ8tnQAJe26vEzUoXVip06pAA63xfCfQMnAXw/iQCyG+CInpQ==
X-Received: by 2002:a05:6a20:4308:b0:35f:b098:1fca with SMTP id
 adf61e73a8af0-3898f9f9f2dmr7366945637.50.1767906786610; 
 Thu, 08 Jan 2026 13:13:06 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a4fcsm87408315ad.12.2026.01.08.13.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:13:06 -0800 (PST)
Message-ID: <73751308-c75a-443b-8b06-0ccba24b3b99@linaro.org>
Date: Thu, 8 Jan 2026 13:13:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/50] linux-user/hppa: Drop CONFIG_ATOMIC64 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-41-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/hppa/cpu_loop.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

