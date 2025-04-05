Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27604C36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16CF-0000DI-4W; Sat, 05 Apr 2025 12:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16C9-0008EF-Ah
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16C7-0005jw-Np
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso18713015e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869790; x=1744474590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GZjS1cetIF6x3rhhrOiM0CU7zA6JLeTtcuV7xVbfTH0=;
 b=hPwNa5f/sfj/8SJ9CeibZPN4lFSmIcvYhFo7wYbNUt09fci2WD5aXlOtneSqQODySK
 WR89f33Xr9qSk6BlaFW+5SmIfhjb5x94weMc99DiDkSFr4EWQcv3r75mApUCikjfSClP
 6nAzbUUs0qwllp5p5Oh5V/fr4GaHLEoZ06nNrCowXsei4W7UgK4IAoqxt7t352ybHRIl
 EQHgmXjV1uJVO6AqyUm3dkdTdSXWQ63wgWWsk08SwHcGbaKrHUJGo/YyQ+deNbD4zkwD
 ZcHZod/PY4C7x72iIxEr0e6DMSc3lZ4Whg0AK4r668HcoiMdQMqcS3+IuU8OG7xyKK3/
 Qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869790; x=1744474590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZjS1cetIF6x3rhhrOiM0CU7zA6JLeTtcuV7xVbfTH0=;
 b=VtKTbm8OL+mUHTu+wF4uFqSR0WPayk1uvx8ZiL6J4U3htf96lR7H8wX63NCPeFuQCy
 wVBGMVdFBjijJ5srYAQg15OQ/L1pwk2YPy+yUAICaho7rzVbFcWqnyDk864XHJIKpE+V
 afThQiSZx56YW32hF8AQ3+TJHA5kwjXTKkAyg4wsgsBR6cCdgUFBu2saF1+eeweQ9NHO
 1Rh6qAZvJPkrhJ6pGg+p0pu8URkSWFOTMbnt0DNCL48ulQB8k4fHIrYHVQrMh1TzrcRh
 TyEWgm8HdVmJg8dErpkdbhH+wyQe/Bk4/WE/7MV7BzeA4fPivPy3NPq3DN1Mtj6wiQvX
 OV4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo2xNH3A2/pLrP2d3qIrWY7GoMfbtTdRtAK/qKS3OLgbBQb3GvVEvvqLmGUSOXecSBiH4EAFD8Mht+@nongnu.org
X-Gm-Message-State: AOJu0YzUAKraTTZAgYHiEkYzNFKYaQcRnwDov3kz5Mj837CLNYXMLrLR
 X1cPmBx1XON4J77oAnXr//hCW/zSi71ffCOeUmQGZLvJsgbc8/r996HazJOaUs0=
X-Gm-Gg: ASbGncvHuv5LcjIlzuFWAu9a9uYQBlBJZPKlz+mgluJvhivRHJiiWbxZVRT6K8G/xOS
 TzRNc632a5c6TP3YtgviImTuOKBm5wr60zRkG87yqU/NdLNhfxgjLKfD0HyXAaYBVPHq0bZ1jfS
 Q6iCVsuSwjTALBbZkt/9oW7Y1bRyTPetSKnJMkCIgFKoKlgwYoAahKJv85vXc7M6u4qo0pwQqXV
 51x+CNUn4L7w2gVnX2uLApfp4aCRn4IWXYvLzO+UEdMyYH2VrJIT/PdQM/II+abPmP5hLOpEND7
 pWaow3uD898PK8jE7yKzzlFwcN5o7h4PLtALZtp9AnuJyYn98cUnccvG0OpiE6gBJAYLgBYVVHq
 Ndom6vGWwK4KFjMOQ+thpSXvA8lD4
X-Google-Smtp-Source: AGHT+IFJELj+gAF/BwTqsfrFW3EVpYMD7Qk2LcH0mckwfYr8i0+Q6LtRd+/dI/XupHqpunBFqKM6YQ==
X-Received: by 2002:a05:600c:3504:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-43eeb5c0212mr10393665e9.18.1743869790179; 
 Sat, 05 Apr 2025 09:16:30 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf193sm76427895e9.24.2025.04.05.09.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:16:29 -0700 (PDT)
Message-ID: <1fb6c881-e353-4f03-b9d4-bf6b5a99e823@linaro.org>
Date: Sat, 5 Apr 2025 18:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] accel/tcg: Add CPUState argument to
 tb_invalidate_phys_page_unwind
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250405155054.967307-1-richard.henderson@linaro.org>
 <20250405155054.967307-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250405155054.967307-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/4/25 17:50, Richard Henderson wrote:
> Replace existing usage of current_cpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 3 ++-
>   accel/tcg/tb-maint.c    | 8 ++++----
>   accel/tcg/user-exec.c   | 5 +++--
>   3 files changed, 9 insertions(+), 7 deletions(-)

Excellent.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


