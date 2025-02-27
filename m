Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0ADC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhun-0005qR-BE; Thu, 27 Feb 2025 12:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhuf-0005hA-4C
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:43:09 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhud-0001lX-EZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:43:08 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-221057b6ac4so21285315ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740678185; x=1741282985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+19GxuBXpLR7F9zaDqBwNGPVoSdqFS7ssRC3tjRDn+M=;
 b=xMZEMhG9fgo2N0GUpkfRnKHtvRo/ppfbU+Mt51YeGjkFoBHTcW5BrielVZNDfyR3y3
 FeodsMGN6sQZHYlfkHdEAmplFHgVnUa8DdiQkgCc5vB9fSc4KK4/4sa3/0HphDMYspRG
 FXnGFji95NBzbuePU+8haKxyizNbvH35+8Jc0SN8P2bYixITmz48/9Ngdi2cxGv+7QpO
 gYmZBXBVslStmSm+ZRLNYelWZrlwm6DaGDqVLId3PqF3/C6+kJs2QR4F8xxreFmQ2CmS
 sX/hbJcQseRI12hGSuVy1h7RAD9iFMS63UvFWA7rxEHmqDy9moYf3eKxHulBqUnJHdNV
 qOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740678185; x=1741282985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+19GxuBXpLR7F9zaDqBwNGPVoSdqFS7ssRC3tjRDn+M=;
 b=PfCB5cxBpkbSuLlYafSLs+6eW57Hud0XG0ljaD9OROInINYBGEsfZvQ5wXPdYCvJ3g
 qoBGZ3Iq7onR0RQ6eP/c3u9KZWSVmCgxDDoYUyebTxW+af9e09ArpF983cwn2lTWm+eX
 Dg/7YcietEGHnoHGBPQWajV12hXKHZJAO9Whg+EodK9HV8JKAHlXQ4xopckY7KTSsB6v
 Cvl6sG+NL5N6+qHxUZSxhumUqmC66RXVXpU5Y9Cx2bmPxc10/eoMdow4yoIQsMRi3W3G
 lH2hCFw8VoGbrLuzbUfzCTTYVG6N25CU/N8zhGmL7sKTzwZxJWHoEhvWnoceqG3EI4ZC
 QC5A==
X-Gm-Message-State: AOJu0YziTegV9Bb2UrhuxpySel3h9D797VmChcCp01S9chqGnIQPF8cZ
 I6BunoSf/04r4kyaxAvYsQFoZcKPllBGXlJ7i8+JHwMd6TKc2wVHcllK+2RUOwARalZLSx1v+qr
 R
X-Gm-Gg: ASbGncvVpylFtU7Ku4xGlGOvSmnZ30F7S0W+0gX4dQQlY/x3pF+Pl7g5u4o4MBlcI1z
 3UJ3BNn0OTDQcyS+aV64ZTWY4jpgpexD7xytEfGTL/i6DJarF6sZJ+/mKrb7qzJ4cSVBNL4f2UH
 ZCVWVgnZfwVQg3FPli8Zz/YNrVkznqXKc8qF6M+aUSzMJD/RLHZUSF37YK5iLBOWU2uOjKAtjOQ
 uPFCMpEW54caZ28jUfaIeYyQ+ys9Fvrfp8fnu5fCml7swaNbWmmoWUX8FRPJlwKbv6iaGj9bpmM
 nO6OcUyYANN7OimUlrRNHtZ/CZa008rpBVAZUkFwcM6OjXXVWaWpvvCVlepzbYBgz4oWVgSYuwR
 3d9DVfJI=
X-Google-Smtp-Source: AGHT+IFTlsEo54rlCccLy7oqoR6KjkvUe44t24gSuSlJKQqOHR1D/6vOTTJTCNsFyZhh9nzywEaAaw==
X-Received: by 2002:a17:903:74f:b0:223:5e56:a1ce with SMTP id
 d9443c01a7336-22369213d64mr276455ad.32.1740678185524; 
 Thu, 27 Feb 2025 09:43:05 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5a11sm17885205ad.150.2025.02.27.09.43.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:43:05 -0800 (PST)
Message-ID: <fd861c04-55f2-4568-8eb2-64edc933bb9e@linaro.org>
Date: Thu, 27 Feb 2025 09:43:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Drop unused address_offset from
 op_addr_{rr, ri}_post()
To: qemu-devel@nongnu.org
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250227142746.1698904-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/27/25 06:27, Peter Maydell wrote:
> All the callers of op_addr_rr_post() and op_addr_ri_post() now pass in
> zero for the address_offset, so we can remove that argument.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

