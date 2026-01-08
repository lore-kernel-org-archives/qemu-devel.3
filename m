Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC4D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnmu-00074V-Ce; Thu, 08 Jan 2026 06:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnmi-0006uB-Hn
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:02:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnmg-0000Ks-4Y
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:02:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so22654375e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870148; x=1768474948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxLpiQ1fQUeRpHtwFYVGxCXBqZ1pWDshEI0qn3mxiiA=;
 b=w/9QVfshVfdoYL9PwQSd23YhXk76wYiDid0DFqHe2qHGtpAgM/5NBiAu34UusALy8k
 8OpZf2QmfN4Lj+9itF9kwO7jUtLjJy+HC+AGZaStgahWlkgiQvDnraRrUEmvIyO3YTkJ
 J7mNyejTrNVxchCIBzipDtpTnqaogHuhrfJq5ZKdvpXALcbDkTw01DeXW658WI8V2zf9
 cx5420wHDN1xVoKVtSX1xv6mMfxFaydXOfrdV2rfSfI3ZaZJR4nLTbzotUNFkPKZ0V/3
 NEc0KnU3fBWXZTBjVi+6fFrBJcxhFlAEDnlEKzCy0hPUUHb7vkOVVvd7dcHd5jRzqZnV
 o+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870148; x=1768474948;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxLpiQ1fQUeRpHtwFYVGxCXBqZ1pWDshEI0qn3mxiiA=;
 b=qKiBjhnRgxc5FjiZOGkDkoJmXwaJs+3BeHiOUifvh5yQlm9CelzbemHF5X9pntEXG6
 JYbIJKK13avWIGC7fAUc6DH4TzthBF+w3D+3XBZRuTzIguzmrE3CUbK0V4bwOxHRNIKc
 kuPSV9ttpm9Jk6dsjX+2qYyPTq/WtBPUKWKCosgNufMhqmNSIawNZjb3w+0niqeK1dhM
 nqtavTPqEeCJfHwVw26rBqEhMWAtb49oN4UI7fBr2vxuzcpra0e6K2s7dqkMVS/tCxRz
 z7nS7D67gMuZPjNV2XZhSYMwqvgcLylJbhcN6gc5bH7828elaAHs+24r6mkRKvhY/rQ2
 5UrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVofjOpsnUvxRMaKSz3BRP/4XX4gnZLgopWBbOBQ++iwF0Zo2PGOvrAeJ4Xa/HowuQgSbzgFoK4N/eG@nongnu.org
X-Gm-Message-State: AOJu0Yweh8iD67qssw0nE+h8+8i7F7rkiopGymZTW3nOxBs4UQzNvUSn
 3bHWpnvJNnQISbHIM3LrM8iWwItwJ7Pi3g77FAQG8EldnnZ2J88Xg5lUiIbYCxEkr48=
X-Gm-Gg: AY/fxX4t35u4s5JDIt0fpmmBgOXxLsL0oskt6jwsvd1EkraORSkV/Lq1THmmKhVb0tB
 NSCrSP4EDQdJjCncUy45hLJidg3ff69QrCqvJb6oKD4SYpAzDz7tTG7psmDXdaxcoqoZ6rH5xG6
 9Gyp0iRyt00B1v2VNM6l0WuLM/5WNJu3+HP7LtlcMiCaOXrvxU8B537T1a8h+6pfo5GbfWRo7Wr
 jXnAMSkECEYn0JxF26+ZbRTtlzUvrIiG6YoMbeuSOQRTUxBRRlw3Lr3vwwmvaZNagSV7R1aJ2uh
 lBrszvCTsAUZ0VmxSN+CupU9Ij8QRW9YmK/7iI/LwC/8DJmez3JchJDYqFmuI/HgSE/h6uj3hw6
 BWxu04xNxkKZc724J3vYgiNwVTgbCr52pu44AXCrrRX3ZYbNbmoXn84Q5QCX4Bgn7m4YHBTDHsB
 G5501vugIlciOPaRYiT169F7upZ1bEBUXjMVCUPx8CmWPYDYVrBy7/SA==
X-Google-Smtp-Source: AGHT+IHdCXDT4yIm5sJVKKOsWcBpNuWLVjL5X8h3X35S5Br9F8U0IS0oxiOAwJU6tXp9fa9Zp7k9qw==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d84b54c52mr67843065e9.21.1767870148527; 
 Thu, 08 Jan 2026 03:02:28 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8661caffsm34768815e9.5.2026.01.08.03.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:02:27 -0800 (PST)
Message-ID: <7a70b08d-efa1-4114-8580-9310d7a7dd2c@linaro.org>
Date: Thu, 8 Jan 2026 12:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/50] *: Drop TCG_TARGET_REG_BITS test for prefer_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-19-richard.henderson@linaro.org>
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

On 8/1/26 06:29, Richard Henderson wrote:
> Mechanically via sed -i.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/gengvec.c                | 32 ++++++-------
>   target/arm/tcg/gengvec64.c              |  4 +-
>   target/arm/tcg/translate-sve.c          | 26 +++++------
>   tcg/tcg-op-gvec.c                       | 62 ++++++++++++-------------
>   target/i386/tcg/emit.c.inc              |  2 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |  2 +-
>   6 files changed, 64 insertions(+), 64 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


