Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F5C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVWA-00082U-Kp; Thu, 01 May 2025 11:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVVr-0007m6-Eu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVVp-0000aG-RS
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso13890175ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112064; x=1746716864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J6UsLGEvl5QHsostA8JwRSbyir2SZsB7Lm+iq0MyXUU=;
 b=h6wL73vpMTBdRZSv2wtpYVyhhLq8ibbD6SMdct/mytl2uge/qVelwV4FyUZTt14ND3
 qTrOM2fwwblTePJulqEjJqjkaXHe9R7lYR1nzOaGLdRbFsENRCJxSRqCkM6ZNOZN5DwI
 fVecxBlmJ2NQpD8lx7lYBssfibuU28DcNZdk/j1mb+lwobY5h4YjulyZNH3YOi4bIZiA
 9tH+2zlLMgZz669+c136D8y3Fekg3c5sUPLE7R807g6vyZNlI6+4LPpw6qSKo0SgWy+S
 85xfY5TxlRd856AXiAgCCOQC5/SssXBhJG3duEel7oVOmJ+HUKqaA1EItmxr8nvpIrUK
 lThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112064; x=1746716864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6UsLGEvl5QHsostA8JwRSbyir2SZsB7Lm+iq0MyXUU=;
 b=XVNTFy6DW+Y/nfnkcKiwITdb9zNYhJQ7a4Z43zsBkeWVoC7eXPsdiLGBnrVRfHfQIZ
 orkfyQmkQffB0Bqc+TXLZXRY6FQy0qpn1jTI+SYQOVsJS0ZqgW4z+9U1lPB0I5Yf8R+n
 5xKb6Lk9At/Z91hxHzb9g3erek2wv4sn0PQ/N+8iuUfd0WKRPRyGtd88jU4FjvqBRV+F
 K8X4LMaW0I9fxbWnLbhmBuQavbGxyjwbwsJQcA8Pfi7eg4mntTgXbW8XU6l4LUbc8uvq
 wmdKqhTBuxW/wlNKpm7XtQnOp04QNQNHBkz4h3bbeZXUcfLfOcpaV6Xm93bDoRpVIy9a
 ZUjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwgH/RNa1LhocDWtcDOHs9EQsu8NVqvMMPnb5ANbCBAgK3AF/Od/Wzlx1P9a6UQI8sClx6U+ssTwX4@nongnu.org
X-Gm-Message-State: AOJu0YygOQPF4yBN92G8Iwycuf4UE4HphyPlFopRDA9kbvqUodYvjEcJ
 aWsbRPSaJY3tVG1cxP1ZttdkWPNHy5qfMXZN4734OT5oFhWBOlvEBfx4WAT+spKwQRw+Ts/34bj
 2
X-Gm-Gg: ASbGnctr5NxDq/Wz8PySFcc2E0EdlIWdvTHub5tJjQIThmprkLi8ofDmRj51rnBF4Dg
 I9VzY21KuyqhhNNaW9R+F8Gv9rQ6Dkfo26jkERNGf7zsW7oZC3O2xwNk4MChOuBllYLrIc0XSCh
 cA7eGcSipXl5AVuSYLS6nA4TKYixOD92F7/DXesecM9IQy3n1hGe+tTKeFXnY1TBSFSZxjKgWLg
 VbchH4RwFrBg9SE1k2E0SWPVdS47HQH6S2Lx7mNSLh3ig2LuEb8nU8hxNKHNx1wP06NHPefDymT
 KCy+mIy0eKfltN8XXtcQBobwZpPMtqSxpwx/jWFHz91oBdbVolDVD+2L49zv0z7EXDiaQBVxIB5
 P2UjeXwA=
X-Google-Smtp-Source: AGHT+IFhtG/bZFVwWc5cOJbYqNLnqgnJjC/vtZgOZfsbK8XeE1XUv6h51c7+2i0dV2j5oOP+IvlPuw==
X-Received: by 2002:a17:902:f64a:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22df3587932mr131329555ad.38.1746112064289; 
 Thu, 01 May 2025 08:07:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc6da92sm7708035ad.150.2025.05.01.08.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:07:43 -0700 (PDT)
Message-ID: <e1afdcf4-a416-4742-bef2-352a9d184ea9@linaro.org>
Date: Thu, 1 May 2025 08:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/33] target/arm/debug_helper: remove target_ulong
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/debug_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 357bc2141ae..50ef5618f51 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
> -    target_ulong pc;
> +    vaddr pc;
>       int n;
>   
>       /*

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

