Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6CCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI97b-00041S-95; Wed, 29 Apr 2026 13:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI97Q-0003zf-BM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:54:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI97O-0004T7-QT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:54:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso237075e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777485277; x=1778090077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6nLPGUccpXINzp++IlSsZJa7t5fmxAq+x3uKaL8jh4=;
 b=gkxd48/JjSzUlFkAg24aLyRUSg3jKuS3XGLMuYhtEjE65W95drBUaOjpyHRq6vFdC2
 /mJOzeyn8NQo3Oxl5AjsbB0J6tKCpJF/H82Tdfd3sYKZjidLuN1BJoUBvcgNP4wvezw9
 gGU5bLxDGdJ8lOgN64O3MdOR0hKYT8i+pULPjNltkkFBixYevzkgczGtQg1Q7FXPE+R5
 npNLBUWNBkTaE2I2HOPsaLnK5ArkbJ8Z2wz0f72V/SleYl6YdQH6xfGLRJWICm2YojB1
 Y/DaLWVdnLvLGOfE8LifCjKkhhZKDofNWRtiA7yx4cE7Q8dne/L42YKG7s5RxjjFrQWN
 nr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485277; x=1778090077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6nLPGUccpXINzp++IlSsZJa7t5fmxAq+x3uKaL8jh4=;
 b=MyxvocVqnL1IOapo8bQBnteVcNWUNw/QoIpMCwSLFQfMaKnnOJss+LozXwxlyr1tR2
 JoPwcfhucS7HkQ47HWdvAdt2UKT0V26tOy2Y3qmwsU4zpKQvfoG20FdIGUW+W5SqZGqY
 P2odIkBgt/6pLEOIyT0JjtQLYfWLoPIhvUVUwozhlvbjYMEmAa5Z6cmvXryFt4TtNKIa
 C8QYerzdWTOY7my5p/uzUoKjzu64enVYNXfsyZCGkUmbtkhUBTc2hcVurcEMMZ5hSpGk
 OrEuaF38CDzHBntNVlKS4jimlblRl0kbbwd2d+HHUeAJ1geMBcK9cKIRiHaerA1jkRbK
 WIaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ecRKhTafuK4BWm0nqRdMk5wJBT4x7WfkKl4HETc/98qoNsrstSqmsQgNtxtWBJEvXHeZZ/OuwsF/h@nongnu.org
X-Gm-Message-State: AOJu0Yz+mbj5BsMTrsowCcbr0+m6IE7WgIwNUo5zTfrNiIAaws2gVOtM
 Ygpcvuc3DO8cFC0H46pp1RpQX/v6k7J8Z7p73Z4QPFgdvrGUoYFqdMZx4dT/vZOl5Sk=
X-Gm-Gg: AeBDieta/eLcXkvOKq4PEGKWBLKAWoWR9ZQDYNSrli5TFrRAWggdi4WZAQl/lLaAwOd
 gNW/i9iN3NqFPPNMH+f3h3mg2mjJSu3qo9q6NlyUTAF/v8TjqWJpvDppExHEeMlwYuEtQ65ECPf
 q9fM6PB2l+DuJp4jybhltPFbkB7Vx+Ky6X6aZZ/m5UfyANWvHxVfSCb8mkDqswhufmQllYXoaMS
 oLNuj8xKJsB/+xCDFSF+j7OvWSm6X4Rp7yLlyTpObSIvPxQ9i8jSASjnaMmsjs3JNylUKp+zyzP
 Xp18v1kRfoOI9Sf5Ss8xjdBonTYgnLCkDYP93JaprWOy3cAdyxoc6s5FqOps/2/PRev3+bCQYR/
 B5Lze1nNI3V+jFfMSFiTJYix9ojbEWNqh/u+mFBJEORZpDdJfM4oKkKZfDMLrd3RxTDgR2CWoCt
 TOoGHVAwp0a5BL94XLlZDxCJu2154gB7ar3aqegHP/Wb8F1l1M5q8aW28x3zAjgYeTP2zMBwh9/
 +P2
X-Received: by 2002:a05:600c:8b2f:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-48a779ab7c9mr141094365e9.0.1777485277168; 
 Wed, 29 Apr 2026 10:54:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b900d29sm24454835e9.3.2026.04.29.10.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 10:54:36 -0700 (PDT)
Message-ID: <d7779bda-4f5c-411b-936c-ed0aee5f22c9@linaro.org>
Date: Wed, 29 Apr 2026 19:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/84] fpu: Drop parts_log2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts64_log2 at each call site.
> 
> That leaves parts128_log2 unused, so move the whole function back
> to softfloat.c and specialize for FloatParts64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 133 +++++++++++++++++++++++++++++++++++---
>   fpu/softfloat-parts.c.inc | 131 -------------------------------------
>   2 files changed, 125 insertions(+), 139 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

