Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B9FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCZG-0001uP-HS; Mon, 17 Mar 2025 11:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCZC-0001oV-T6
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:39:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCZA-000620-Ph
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:39:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso21343295e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742225987; x=1742830787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dnU1iaIjyphAuTTJ24Wz/YJtJ7FKCuQp+pKPpgYiNA8=;
 b=wr8ZrRoMoI21f7T8scilD0mi4HbFigpquG1ZYv3ddT84AGN+veldmifIY0TIkXXLeJ
 Fd1tFEyZqyzZtqRb31+RjSyCtuuedEqm0cG+cc+ylbNXwEdV30btG5MiRR0dcQsm6bAs
 y4ZZBJwGu1P/jJ6ZR/EqR4QOskAxtIAvry+RbXY6RRNAbpO7TfuWP6a5Zw1MXQzuYJ4/
 ES/1Ua5XpMwle/1ZJ/qSKDaMpz4qcaZFLZAZWoXEe9o/ZXRCuk1FicecYT1jd6YGukOb
 GTMNJ3QQdzlJRb4hV83VAvb8MwpVqfyCFLKBNPjD0B1CLlF33njbc946eAfjFgNJiG/8
 LRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225987; x=1742830787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnU1iaIjyphAuTTJ24Wz/YJtJ7FKCuQp+pKPpgYiNA8=;
 b=tL2dsT3Zfjh/3NHQliJjxevY/Pf2OmjZ9X1jGBP+K88tlDgzHMkYmajE4vzefz2pte
 tpSHw9C039k9szfUfYS5/YCsTiTe/PVlyZNNkHgreNN2xKfMsTQmmKvytFHkYEJMRFii
 kDoJjJmMj98t9IHpW7svV9N1CTK/VI4bPbzenCW77810xry98J7Qb5jPXhevEYH8ishN
 3HQ/A18CUZsYruyhN0zixDJScy8t20Oq9eoBL5io9buRQiHrp3lAfuTv8ZWkpqNZMLFS
 Or7C74NQidQecHrwRfyVn2kDFfNApWAr/OWRBFTKfqcvR0H54nyKkqZfg8EUV1BQ7eEF
 GKTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoD0ZOICd60SjmkHoC8h9fU5KlX6vCnryehgBZ8/ZegdbUnqwKTBEEzbbeItSTP1qKymDqaJLN+caw@nongnu.org
X-Gm-Message-State: AOJu0YweZyAH/un6b5FrEeL2Htjn/6s1nPHYv3Jhf+leZVHmIlA7T/fn
 OIpY8JbBzWf37mqqOm3mXApGyyaSFXHQStDmlOacJ9aS68iCr0d+70NGjO45pLs=
X-Gm-Gg: ASbGncvq7J105YqikctMVm1qss1bPDDtIttWJppPnTCb1/o423gxrFJ/I5CuERebEEz
 Xe9kAJR16DVXKQjNUjY6tQMcxVYQCMOkYhBD1yN7OM5KY9BJQjNbtGZQ2H4qLEMorQ8zBKCQNs/
 K4VuUcPynRHiRs6hXl42Q0WJ17vgdHbWilK2e5P8UmR2M2CA0ES6NddvX43lYnDJ9fefItcPwdm
 /2ta7cdabDSJkrSI4OLstWOHsnPx9KhW9wJjrabkUfHAMlRVjg5Yc3u597ZVJuUIiQWSCTskmr0
 W3RU2jQ2Pn//sOgb6I/8KrtykIJgzHpPQQabzPLDg1dzoSBycXS7wAZDntVCct2XeQjz63Ib13O
 iPgiygs1cmg==
X-Google-Smtp-Source: AGHT+IFMKnQvfHUXc8gK7vJc630XzPwBlYGnUvr0+6PvAfWZ0i4TveJrNoE1WhojrMnekUUZ4uVNWw==
X-Received: by 2002:a05:6000:4011:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-3971e2add48mr12939402f8f.16.1742225987020; 
 Mon, 17 Mar 2025 08:39:47 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318afbsm15770725f8f.72.2025.03.17.08.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:39:46 -0700 (PDT)
Message-ID: <77a5875d-f9a7-4eb8-a090-4863ea9af36b@linaro.org>
Date: Mon, 17 Mar 2025 16:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 9/9] target/arm: Remove TYPE_AARCH64_CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> The TYPE_AARCH64_CPU class is an abstract type that is the parent of
> all the AArch64 CPUs.  It now has no special behaviour of its own, so
> we can eliminate it and make the AArch64 CPUs directly inherit from
> TYPE_ARM_CPU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-qom.h   |  5 -----
>   target/arm/cpu.h       |  4 ----
>   target/arm/internals.h |  1 -
>   target/arm/cpu64.c     | 49 +-----------------------------------------
>   target/arm/tcg/cpu64.c |  2 +-
>   5 files changed, 2 insertions(+), 59 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


