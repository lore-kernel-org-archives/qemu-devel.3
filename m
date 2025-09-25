Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67924CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jUB-0007re-82; Thu, 25 Sep 2025 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jU1-0007qx-JZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:45:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jTr-0007Kf-1Q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:45:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso661338f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758797132; x=1759401932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dfRaA6gSzvSsV9rp7HGlFghNlywG8TzQ8wtJQDTIfEI=;
 b=kpsMfFSFndvDLMkmypR5QdtUHw0vevw7m/DV/QUNTBUaYtumqVBmAYt3UhyeG0dp/b
 48Fl8Q6PrkOR/3TEZVZJqTygHeeiOYA5d4EPCXEXCm+BeOe+HUZRoqpu8iwC0CH/pvtG
 lUYslhBsQiANgC7pBInP2H3um/zdkCm5Hm1peqXh/w8mIraB8gz3zttRYdjjdl7IR0jg
 8hICyjKwhBrL0qB/NGeBcJ/RuG2fLUy/KIXwaB+rX+sfj68vFO/9CJf9n590fmMW8EpT
 emjBKXaLw7UCe3upaFQH9tIls8cFYLMI7pMRHIXD+pzw+Mxz7iy7fkTdeZvGjYS/bSTX
 jvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758797132; x=1759401932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfRaA6gSzvSsV9rp7HGlFghNlywG8TzQ8wtJQDTIfEI=;
 b=JWpo3kzJd8hyoNtguaQVytnP6fJdXlBxcJqR9ufuBYtOyNjNum+Z43ueHm7lA3vkZB
 A/3fBC1mTky9F3ff86J+oDjaTDrctKkksKaph32rz30uM4dH2ZQg3E0ld5D8mPsmfFRr
 uegCYW8UwUtyIQu8nnhWqltfldOW7TYQQD/Q70JFjcg3LsB2Up7artzEw28nOOaezOpn
 yyZkzXijkR0zgJqv1ww/orwNA66/tVMRLrTBH/2hvRQA2Cd8NQTvK8/ExDcBQivfkjZs
 VygCuzNMFzaikjJe1+6VCY8+3UpnXWSV5uwF+WWdXECgJKnbD+E0GzLsy0VkBNVzqjdk
 iE1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWg8sSdlMIqQBMFzaYvbg1g/LX13mFnil7qi1O38rgis0Dqq+vT1OYIl8RpgH7zAzEZcVY+nf6PClz@nongnu.org
X-Gm-Message-State: AOJu0Yyn/Mmf8mD64lPBKJVv48KHCh5uwysUZKwum0V7l7dlZ7ohciaR
 gJtW1BfMZrjhcDZT2Z89euIJbwpQYphPHv+A73VB5QhCIgc6ac+/yVCswBAEZ6SLHLw=
X-Gm-Gg: ASbGncuG1oe72zmnqz9WxfdhqNfY315rUv3dU7gfVTSWmg0ucNm8ydFQZrO7kjF1c9f
 FVYIivH4vtK2gMUjpDPlKgaW3z6ZA567G5hxSlbWzmBCuLxyJ1aQI1goIlCWSCfHY36Pk2NzDCh
 YnInrzdz7fMW5G8Dh5A9bVqOZYx1dPc9lKu00hF2YWQspBpUW05hNtc+fmGyDBRE74ofuZPzdj4
 w0moY0FZmZsZe+1FEOwc+8fm+XdSGHrqaIlaOaFBQ5cfH4PZtnGIRb9eqaLenJBLBlg/4+Bn8bg
 jBb6h6A6PGzFwf+YUmkf3EIEoIe8VNcX7TeGVNDiV2yOBsn3bZpheaNZ9Ast382zDZj/pSXjUS3
 Jz7OMZXWhdgccrIdLxkwRGmXkGtzZBQwFwjrSyiOBmLMwju9EesKXiJHMcn8M/UHYaA==
X-Google-Smtp-Source: AGHT+IH1LRZhQtZXYVh/15JefO6OhsC4FAFZOqbPs+f41Kq1L/3Z3h9jGIPNewr3qc7jKNpTwb5q3A==
X-Received: by 2002:a05:6000:400a:b0:3e4:957d:d00 with SMTP id
 ffacd0b85a97d-40e4c2d2576mr2885554f8f.58.1758797132429; 
 Thu, 25 Sep 2025 03:45:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33105e58sm14305605e9.7.2025.09.25.03.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:45:31 -0700 (PDT)
Message-ID: <9c21df4c-1e32-4c64-8dbc-61745ee94e5a@linaro.org>
Date: Thu, 25 Sep 2025 12:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/36] target/arm: Remove cp argument to
 ENCODE_AA64_CP_REG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> All invocations were required to pass the same value,
> CP_REG_ARM64_SYSREG_CP.  Bake that in to the result directly.
> Remove CP_REG_ARM64_SYSREG_CP as unused.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  5 ++---
>   target/arm/kvm-consts.h        |  3 ---
>   target/arm/helper.c            | 11 +++++------
>   target/arm/hvf/hvf.c           |  3 +--
>   target/arm/tcg/translate-a64.c |  6 ++----
>   5 files changed, 10 insertions(+), 18 deletions(-)

Well noticed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


