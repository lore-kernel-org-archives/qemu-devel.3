Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ED7C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgit-0001IM-Lq; Fri, 21 Mar 2025 14:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgiX-0000tQ-9j
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:03:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgiR-0003Ak-Su
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:03:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22409077c06so27022715ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580210; x=1743185010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHWrgu4CI1pd1XxzLhTETskG12YT/MMg2wUOB15BvDw=;
 b=n+HY6tHHoM/MPYkfXz7KVZCz9t+pEFrlKcTQkbtNKZUPFlLyVwfJvmztAM5TcNhK3w
 KHlD1xRRrVnwEKevmUct/pUURxQGlZjOtA0fBXymRHD581g8O+D6gphT1t/8bC05TOug
 l955e6eLoZU7+Gousx+gdd4C2Y7WLA7AGB2N4mMWZC7ehIf+YEAr3GmBTsf4nK8vkyO2
 C9YB9OpM3323NqYURG4sCpxthsfoqBqq8SdVRcDfWIuYjGhKwuEdLoHyQ1ElKLPsi3qr
 ybgJNwV6k2pVDAqkB8Dj06SV5yqApolyGYoWe9zdK05NLiyZ/cdCnFe/UPJ+cVL5flT5
 +u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580210; x=1743185010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHWrgu4CI1pd1XxzLhTETskG12YT/MMg2wUOB15BvDw=;
 b=bgpan75Ljhui3bUbPeJbGm6KRLH2rQaDPjkhKsMoSR37xdV6C1ybIh79KiVu7kwt3U
 ExeKqIxxxEEulu6rDPVhsx2uk0rwRsa6SBqZ8tOpPQn6LSL4YgV0L9oHBsOHEDGo7M71
 TQWrem7DdkZw4g79/CPo8TaIxlgJGyzc8SsGttUZcQUdA1Htz66lubK8KJTNtzzHtCT2
 14o9AiPkZJ2SnTyxltU6LGbUMCcDO3faUSggsjvIRl2SR1tIwPRq2qIlvz3q2bYXOEaM
 eqpkiBPRmywx2CPRcjLlN5/WrdXvIsJOmZWmFMARzbPmZcRPCAq0HIQ2Z3oU0FSw8fBF
 UD/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyiskjpJIGifh6AAIJ3vamTM66m2ldwRMQ/UU1WqBDtLR5F/i6OppscdLFLBMnstvvPjMJ+MYoSou1@nongnu.org
X-Gm-Message-State: AOJu0YzAAzyeAR1bFzZSfnlSOc5jwkODtUTHgNAtqbJrruI/OYzAPQc8
 jdAY6Kj0uhmCIByx0f0ODPYblL5r6zKDEWxibC58bY7darSYnGzmgXLdipWDXbo=
X-Gm-Gg: ASbGncsH0k8/bIuX6MGpl729VWNf58XuigqSRoOhNbVLgfT3JpqcJh5IFL1OsjAaZ/G
 +h+LrLj8Lw+OrN4qVPBjaps1FZjmjh+VzVYz1ys1FfP50pcCCSfIPj+kYfWKRz+C8IqG3TfzmXH
 sz8MT/AAOkobRzmiwK3LVmz/KcHRpU9CoqOHOkaUoq/orOAOnQWUe0TKrfroNK9KsPR0oqHPf43
 MXvbURvK/E4U7Dw8eaqYynQW/Ppw0gSgU8mYycVIcyV/pr803NXJIvQfHkueDMoa4cHNzfzS57J
 eFkInHzV53SpG7fp74jQCnYw2DTmtWMjgrezzf0QPXw53wpO22sRdIipKZHfgB7qSdtYItFiPAn
 wYkJaOL4S
X-Google-Smtp-Source: AGHT+IFw1l5Jp6Qozd56AnDUA+f0dW6g+9lo+kicQ35LV6Y00Wjk+3zxrVeXUdhwG9mrH+L7/mOUQg==
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id
 d9443c01a7336-22780e0969cmr66161015ad.42.1742580210285; 
 Fri, 21 Mar 2025 11:03:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f39797sm20285935ad.11.2025.03.21.11.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:03:29 -0700 (PDT)
Message-ID: <d1a86799-a978-4af1-9505-0d972f8e0f88@linaro.org>
Date: Fri, 21 Mar 2025 11:03:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/30] exec/cpu-all: transfer exec/cpu-common include
 to cpu.h headers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-16-pierrick.bouvier@linaro.org>
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h  | 2 --
>   include/exec/cpu_ldst.h | 1 +
>   target/alpha/cpu.h      | 1 +
>   target/arm/cpu.h        | 1 +
>   target/avr/cpu.h        | 1 +
>   target/hexagon/cpu.h    | 1 +
>   target/hppa/cpu.h       | 1 +
>   target/i386/cpu.h       | 1 +
>   target/loongarch/cpu.h  | 1 +
>   target/m68k/cpu.h       | 1 +
>   target/microblaze/cpu.h | 1 +
>   target/mips/cpu.h       | 1 +
>   target/openrisc/cpu.h   | 1 +
>   target/ppc/cpu.h        | 1 +
>   target/riscv/cpu.h      | 1 +
>   target/rx/cpu.h         | 1 +
>   target/s390x/cpu.h      | 1 +
>   target/sh4/cpu.h        | 1 +
>   target/sparc/cpu.h      | 1 +
>   target/tricore/cpu.h    | 1 +
>   target/xtensa/cpu.h     | 1 +
>   cpu-target.c            | 1 +
>   22 files changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

