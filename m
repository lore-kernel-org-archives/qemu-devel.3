Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C6DC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA3f-0007t7-73; Sat, 21 Jun 2025 22:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA3e-0007sx-9V
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:03:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA3c-0007Em-FA
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:03:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748ece799bdso2025950b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557822; x=1751162622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D/9Oyth2vsHTOsemlLNoEchhN0SyhJumOuIJ/A0lZbs=;
 b=bJROoV6JTYs/9Hs/kJ7qeERhw5ruW8YWmVpTa6NoLO7rGXuIa7mSiS3swVmqh/Rlpx
 9hWJ3KSwdktk12vgWaBISwRz45B/hkpE02wUw9/XUX4UfrM8WVkNu2j+fgm1l8GRG9UR
 ezK0rzCYgprP8S+qRIYKCAAESm5Jcq+XuVx6iiRtCTdzk8kUcR4A/DL85IzjLxSPfhak
 YqqNNW0vcKo3r/XSZ2RKvD29SOO32/EpToWP+p1/e6utBqwmGkTn048y6El0Hu8Dz8V0
 T4nC08V5+IfrCr63CZePkFzb2FtK6TSG8pgIeVnYTGq6n+l93fCIysQDPwjz8OUava5C
 sKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557822; x=1751162622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/9Oyth2vsHTOsemlLNoEchhN0SyhJumOuIJ/A0lZbs=;
 b=iWQ9jJ/a8X+CQ3/2yuaD6ARa2gEyY+FqS+hYrAx87e+4Ur9ang98O4s3Q5LyTbW8Z6
 akMc9QBN7+qLRR1XFM4/rpbMJ98G/Yawr1VwSOO03trjO1EuHfY2wivhucLezhyjjQ8e
 x0NlrTn4Ec4+aSKllt8YeNwDVwsX8FJp2Q26usPTtMToAFoT+ZRNlS90lN29CNfeg24Z
 aAeLnXGpBSgGxjgnnxLKutVckY+iypNPY6NWXRDvqt+W+ROrWX2nzbQARUBdeqQ3GX5p
 yy9uopRV4p/8T8aArOOUJ0KQEiswRs8KtfGRgm4JwSjtGwYhuguOigTTS0tR1TD2xKjj
 wUhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDhqGTeNAHtg9bT+hNsijPwdNmaFdKmb3R42s1b31+XTldK0qt+arAEe1xkSVkgUhJDIu17iz5+nbQ@nongnu.org
X-Gm-Message-State: AOJu0YwTgUamhwDpkJiy7EuVM6GHeUQeiApJST2mu+wN/GeFWj3qiDN0
 pnuvZR0u5HZgldTZBBx1UsPM4EgAISDLeqqg/d2pVWaRtYSOkfrPWlkGDQIOVpW5/e4=
X-Gm-Gg: ASbGncvvzWVtTO8/8qakIiEh8PcemscpaEhfWPGMTG3ReGIvUu2Soj7thtc3WTb65kV
 67L21xLFTG+rYRjY9NTYfgXpE/8pu3gqczJ+Espab0y/CRRMD/g9LyHyBoK9ejtZWFA7fOg01+v
 o863FDycAidW2BipqrcTWZf4Nn6P46NuDVLDNbG0VcKhdut9/JUhEM5FgkDOXolagUQ5yHCZG6o
 M0C1OgZztw3WnR3H+h5dhMYG2jl1Snpv6aOSw6WWzpwL8s13I7uK5XDavQZlWGf7bIEmM6Vu24J
 dtBlAoOFzvMjDavU7UvMvg4QJFVPrKmb5YgD3xNWcsfcvNZ+yM732c5horCYkBUJV5X/oe4ea/D
 FcyrrewzL8X5DbPmnq14m2uZ69Hj6
X-Google-Smtp-Source: AGHT+IFQtr3rHGiDeMhYT7nTfwU6PwgM/5nBTuSdP3T/g6VdQqO//m9mbyByqMp+onnjJOfzUbvyQw==
X-Received: by 2002:a05:6a21:9987:b0:21f:8d4f:9e3b with SMTP id
 adf61e73a8af0-22026e60126mr12502095637.7.1750557822608; 
 Sat, 21 Jun 2025 19:03:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm3995861a12.40.2025.06.21.19.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:03:42 -0700 (PDT)
Message-ID: <56ed441b-fe0f-44cb-a71c-84d92bdf3c7b@linaro.org>
Date: Sat, 21 Jun 2025 19:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 32/48] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-33-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-33-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
>   accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
>   accel/tcg/tcg-accel-ops.c       |  3 ++-
>   3 files changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

