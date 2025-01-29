Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B4C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC0I-0002ne-Vp; Wed, 29 Jan 2025 12:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC0A-0002ip-Dl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC08-00034k-4J
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso3648078f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172238; x=1738777038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eMQnS+piGoU3zeXTc3V4n+K17bud2X1zAsKh3KayoPw=;
 b=BAcPcoreuP8ufvVJ5DnmmhN2pJ3oi3oZPZszcawakQABbLzd+zAnTIu9iRxEqxkhB0
 MRSEFBkgPjS8LX10/pG3fgqUitnYDNBCoYrl+YhoCVVUktvZKJEGaeCL+Q7WuttwLnaL
 uCVzFbavwrIQxT4gFT6fjMdUyjM2l2ZZo23Mv9bSt0gYfC20WE0kCpiiGLqudp4Ok/Rr
 0bAAk+msoB3eS/p8cZEeOr8v3f5z0E9CbKccQU6oRGNXE2tqbCd2i0xOkbGwmR+EI/pd
 LpoSzDlfyM+ILuhtb6wRoNk8MP9g2tR+8SohyCsj6J1K3QGd75KncJQf2dWeGk/SvBIa
 PhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172238; x=1738777038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eMQnS+piGoU3zeXTc3V4n+K17bud2X1zAsKh3KayoPw=;
 b=Fw90G8PRfESgKVxumfl0DmXdBeL1bnNYFAHibFpAk0BPQ8cLl9cVWz/hxJlcK7LDK9
 iY/gUDWoyeXHYOE2FFNtOIwOig9OE8EPAF4IKohwvxTjDEjm6BaaOocRUvQDrU5oS1Ei
 JnTW/DckQZK/5xnwceTWmKMKFkJ55qoDbbkiPVxq3atHOWe89S0tX1g8woSasjvNPdKy
 vBAzeiv2ogpjHm3KlzFccgNZ5sNQG6ZB/R37YLr2O8pc3C9oGoQpYoL4Lceq2Iuh7X+P
 xPrCY3FqUaK2syfSYD7jEM5XAtDZFuEOnZi1KtJszR4WS8SERd0qSE1d3K7GnZIPlB+k
 zPLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBPpQg8qECUYfp19RFsCOfEspPWac+HCMuAKEIZ0HvRHMK44tIz7/fMwlU6vpeNtl5LPmJ7/qtzhiG@nongnu.org
X-Gm-Message-State: AOJu0YwUtdqoGiZnDdCo5z5uQG6iVbFv0oncdU1K+ZcMavofbYOlwRez
 rxIuyiFmyXGF4vUT1kxamzlLqzJgIZyxwu8q7wloYs+1sG17s6ivxK2GoMb+pTM=
X-Gm-Gg: ASbGnct4q6/4fGMEmoGyzXarPiB9opyL9II8otckVQ5yvsagGxlOQdBfoKSw/bijdPe
 xrb5OdrYX782hOBZLRIm8t+6cxoRWgBQgbju5XwuvwBVD2AavUoP/Or1u4pMNb4azbMfll5oIO9
 /IuPihreskFgDoO0SQ2N4cESWQZMv9uRnzjcpIO7iG4bqqguXzVbZCJ0iLnpTWBw9L9iS915IyM
 BIOMC5co6UMhkKOkEQeczJyta/vDiMfEPy8Ik90nnA6XYBmgfV3XG0pDDrtd10lZp/xPMu9FOA7
 DSwo3cRj4GGZcQsBWImkyND61KtSviYY7HHDDR16gtQcREw1CnBorqhJHEo=
X-Google-Smtp-Source: AGHT+IGgrennxY91HRS7y0kaKRbzTlxKH3QG3BD1k/PHPYR3/oJjozmQ1+0hUlKOse5OdQ6ncl/5Ug==
X-Received: by 2002:a5d:64ed:0:b0:38b:ece5:5fe4 with SMTP id
 ffacd0b85a97d-38c51946280mr3452925f8f.1.1738172238084; 
 Wed, 29 Jan 2025 09:37:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c3558sm17520657f8f.84.2025.01.29.09.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:37:17 -0800 (PST)
Message-ID: <6291653e-5d19-4333-ae27-71a71344c430@linaro.org>
Date: Wed, 29 Jan 2025 18:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/34] target/arm: Remove fp_status_f16_a64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_A64_F16].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  1 -
>   target/arm/cpu.c            |  2 +-
>   target/arm/tcg/sme_helper.c |  2 +-
>   target/arm/tcg/vec_helper.c |  8 ++++----
>   target/arm/vfp_helper.c     | 16 ++++++++--------
>   5 files changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


