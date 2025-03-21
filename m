Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D274C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfNR-0000kK-Qh; Fri, 21 Mar 2025 12:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfNP-0000YX-5R
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:37:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfNN-00058i-5l
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:37:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so45527135ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742575059; x=1743179859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y59C5Qrj18DiWWjCyKGAGj8vz+PXlW5k6VnD2BYRmjo=;
 b=PdKj8oaMIYmZMQ7qbsdaliPdbYu+frYW6hAeul3bRsXd872cJgSTizUVQ2TZw9Heyb
 IP2N0Tg0kZyTgrO+KqA0zGaWohAiDyrvSDKISr1xkSkjtlhnoRhLBK0osEGugaajQTex
 Ryb2D3+CTPcBZxj8wPC+X0O8pCA+0v+LXClf9Sd1h8gmZprwHl0SujHrZcJvS5yxW+so
 wiZLjBIlx6j9uYZ7ofWk+aSPke+qiCHHEKryVvF0y/DrrT1JLQIoXxtRhNFEOHzOxZEh
 +1te5Qft1a6VUueFjylvWhOLhjY3740vxIpC6tG2MRyrGsXhdLd2Mu93aYhmrDCCd5md
 xW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742575059; x=1743179859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y59C5Qrj18DiWWjCyKGAGj8vz+PXlW5k6VnD2BYRmjo=;
 b=nIA04zPQZvev+UsdUtiKbhQBBBjNW0AGxf4+Yd2xi9GYadqufcM5rVF/Dgr3w0v99U
 bodXIKJNbskwd8lPwTzliG+kDaJK1szD4E6hNP692dghQNGkD2jUzKDYJPmzTROdLHCt
 jFgCIjLk2w+egiQ7W5X60cn/diQ/7MvTQDiERDAoputi8NrqhPSMp7iDtHKLtzdeL4t3
 jmhF6hIK3i2PTd9mJjYf73uACIud4yt5wsuUqVwnzpIRcQARLDQDCus8jY5CzviQfEp1
 H+IZVUlKCDkCzs/4j041ZfX4XIOrT0yPD0op6zm9gIgNgmcWGRtcD1T4o80aNgpv+LAl
 HumQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxvPKrC2cmTXgae1UQjI4LcGksT1/Zw/YpGe+ljf5LyEYQQk/z/VU8Hv6/rpAKxrY2c3F3PpJBXQCh@nongnu.org
X-Gm-Message-State: AOJu0Yys5bT3hgW1oH/Y/7h4RjwQtXlRFEVOV4HuDi6qQRkCxccNJs1B
 ee3NBXktpyQQpzckFjDWgMk+xq79ga06psGWNJlbJ4UJCXyM/0pTYCq67TLDhsc=
X-Gm-Gg: ASbGnctX1814jTNouwOPuiSe8JRA2l/UwebBzaPakiDjjDsAj0C+k67VX4X+OZCdSFu
 pUEpK8khutF0yTdtBJn/r+smKumdrQQZRid9jh107X6Ickvyek4prZVZdCpzRTC3UaHql37DKJ/
 LzHAk5sZSfGeFJUaJtLk7DYzHNv6j/0SwZljw3KQWq8o4K7ES7GLE7Sp5hog5p+IHNCvOP22Z3Y
 id34I/oUqdBjKJdp2fEFa8VXNt2MJNWw0gaTWF6eNAr8DVDJbGyen2YyG+Uror0zdZ4zkihrJRG
 h1+O0+lbsT947VLLrvWfmQsbIksisvpcPiPFGqAZLUvyGqqYdiGCwlF4MeUthDtVz4oZVM7k3Tk
 kABzqMqoT
X-Google-Smtp-Source: AGHT+IEZrO7nUw4P8/L9oXnNbpWNLCvFQg8dOSD+kcKxwvCK1Gn6uemtpZ/wD0vshfT03aSdYi8KUw==
X-Received: by 2002:a17:90b:2703:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-3030fee5ef6mr6721415a91.28.1742575058884; 
 Fri, 21 Mar 2025 09:37:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f45b2sm19128455ad.214.2025.03.21.09.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:37:38 -0700 (PDT)
Message-ID: <543e972d-8154-4a35-bd00-b8b950f4c794@linaro.org>
Date: Fri, 21 Mar 2025 09:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/30] exec/cpu-all: remove tswap include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h               | 1 -
>   target/ppc/mmu-hash64.h              | 2 ++
>   target/i386/tcg/system/excp_helper.c | 1 +
>   target/i386/xsave_helper.c           | 1 +
>   target/riscv/vector_helper.c         | 1 +
>   5 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

