Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453EBC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8Ob-0006ue-E7; Sat, 21 Jun 2025 20:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8OW-0006tz-BZ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:17:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8OU-0001ck-PB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:17:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso1384677b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551429; x=1751156229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HE1HeDrI0VmYM4t2Ldfk6yqPqGFYnQaxHkxJMDv/BQE=;
 b=PlSHKcveB1BCaDAECrk2Y9LBq1Al/qcgU8Me662pje7f7jlgutGM0n8CRqGN3h/LBL
 Sl+CxcRtWOxtk8uvI3NaKGE31pt9Wc9LqWKtDN6Rme3tUZ7qRHJt5WCGUjZe82x/cnWw
 HBnSoqO0Vya4/000bXrGvsCqMfrSFuQfoRl6pDn2xaAJcFx+06EWIfKsdpgNyR52aAGI
 B/OxQDb2eYf7tt0Mm2x/LjYST0OjuHkkz1UJSqTh2+2Z24Eep7le6Wl+1cMBm+UHfmqI
 0FlRDSqzztroiS3D9SNu9jeWpK+XS2zE/4fTt2754+X76IEGx+ffTqu1UnhUi6s69uxs
 JEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551429; x=1751156229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HE1HeDrI0VmYM4t2Ldfk6yqPqGFYnQaxHkxJMDv/BQE=;
 b=CpIvhthUnE3tzwKKYvyIa+Omj26IAeTxNoGO7hYPxvjFra5e1UoriUHR/PxTRzo6me
 C91X+mpSB+18MR8DpiNCJ2TwpWFuVjPmmMbTEE9mzSH0DXccq66YGORIB+4jgNpYRUyB
 P5A5BgGUZAI6YW+1OQlf8WqQ9TU3FGzHWWxlVUAAoCLLU+KSWJiRGFQWR07P9GRkw2cm
 YFoa29f49EVscw5DGMZNR7UlRUskcfSyzGn7tw/2z/0qUFoo86UxVRXKEwFTWLc51rqT
 Bo9ZlnMXTbv93Qcju3fVprvUUOWY0YtBX2WgbmScm7cvW83SqgdPzVMxWpSqUA0YyUsI
 sX0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm/Z+npGfRWbSEhDPDLfAsVQSBGpEhNYbuDg+mlUOTuk4XzjTqt4i61Xl21dXXegy6kF8Y7YVZCOaq@nongnu.org
X-Gm-Message-State: AOJu0YwCpDZEKZvfe2iOKm8Qf0AkNcR1ZhSJvPDhzmWF5fxtD7W94r5I
 uHQlnGCN84RNlJjd2cfdl1+1mebTBOnrTNkZX3Idju4i3de1gg4E1FAgwS5fTAFqLdU=
X-Gm-Gg: ASbGnctAV50LUq770gQ+knkZTCjYTdBD1roM7Is2gOmmIaI4Fb/gvt1892k7iFvgk/x
 uekUZBYqysBbH8vOtOLLilKVMfEm0zgDD6aKk9wnMu18eF1oLd5xltH5Qo3DinqA30LVVb/zAUu
 Wv/L4QjNsOi6EWzWOdiQb1S3ysbK+dT4CWMHRY3FRj3ZAjQ8xAhi8rjwPll2ONANr9sG6HfCTaY
 LDgdtqRI2sUawzneEO1MtPbMtjl3m6ftjU5CEKLjIwt/UvbXdsM5dO6bTsK9USI+eZPo+35CAUe
 hmyWLR0XXI8uKPteTIBTN+NmvCa4EKaSufdPzX7LtulHk92uhi6dCEWj/TA87j46ibjA0aGB0uQ
 Kha8XkRYeLJaq7CMmcDCiNLFrciTd
X-Google-Smtp-Source: AGHT+IEIUYXVuagpnJo62Fkt0y1lM40mFH7i5WzJNe4x7dCDdnJoadPIO6V2rb0Qaug42Eh5jgb2xQ==
X-Received: by 2002:a05:6a00:3cd4:b0:748:e38d:fecc with SMTP id
 d2e1a72fcca58-7490d71c76amr8973009b3a.22.1750551428979; 
 Sat, 21 Jun 2025 17:17:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a621ceasm5186576b3a.97.2025.06.21.17.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:17:08 -0700 (PDT)
Message-ID: <67b76a0e-eb29-4f34-8b06-066bae4ac1a6@linaro.org>
Date: Sat, 21 Jun 2025 17:17:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/26] target/arm: Correct KVM & HVF dtb_compatible
 value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".
> 
> See arch/arm64/boot/dts/foundation-v8.dts:
> 
>    https://github.com/torvalds/linux/commit/90556ca1ebdd
> 
> Fixes: 26861c7ce06 ("target-arm: Add minimal KVM AArch64 support")
> Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   target/arm/kvm.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


