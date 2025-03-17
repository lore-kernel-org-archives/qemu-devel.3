Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C114C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCaL-00035K-60; Mon, 17 Mar 2025 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCaJ-00033g-4g
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:40:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCaH-0006NH-8w
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:40:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso16400485e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226055; x=1742830855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7U6GKad7d5wHAblMe/tmj5AtpY2LZZcCgj/vdBJVDVA=;
 b=JB1+akPWyRYKKr4Sn95+b2I1OdeBZ9CI/XrLlhujiPHt7L/uFrLznxT40RXgn2abNL
 AppPGELNfeuH9D9pljHlFwTKFnqjAG+xu1BTkUQNIyHGRXv+jMhK1dg76xBRqXz9Ss7o
 +PkpzjRHx5Wjc8sx7/a+wJ3twPwJytaWb3nus+SxpjYu+qa+kOhdVvXt8DSQlV5acXmP
 IcRWzS9j38HHFa2t+SBHQSNhYV4gdNThlHZs5GM5RtdhBALg4XWnw9QcLhFMrDeV2Dn8
 1P5U6X8D4LXSw6GIl0xoIVZazJF3TJCivs2f8Q6kjhQDuXSRq7Ox0JuzoRRsiVAyLlK0
 B0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226055; x=1742830855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7U6GKad7d5wHAblMe/tmj5AtpY2LZZcCgj/vdBJVDVA=;
 b=nqYhwhwTVvUFt5vzBUMIT+EI3VM5KVCj3oscrCRLRgFIh7NuabN6tV16WbSddiBXIP
 iPpTTuffJe2TXUVN4P/b9/5osIkjviMsRq7R52k2e3Uo5ERZahszlsuTx4FSlvXRflzW
 g4UTDsx9/rVKJVx2Kgw8jzbGp76zbf5zInCkZLbFc7/TrxZLUBnPaXS5yAoL+Rx9ZhMk
 Foa7OqJi2yxLrsIgaro2wJWh8/wYvrWo6rXxRwOZTbz4cJpYE+QU2JS+eOqMFfV3w9s4
 2UQNBN6bLKKORwRlGf+ZFg4Hmfl8eGSPyJeOJSmZjdhNsdfa3/CM90Y9GGOSTxl5c6FR
 n+/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9P7LNt6z9O+z4anDGdBlsNu/GAsnccqRSPqTLMGnpX8u8njOqUAPoW++8SlpAuP6TNYNZI1YSbEbB@nongnu.org
X-Gm-Message-State: AOJu0Yy29qWAEDeGcQjiT4Z9ttlUo2UNKyXFRaKZRwX3bqTX7L4Jo3oI
 Lql4+mYwNXRk8Hx1kZl1puVrY9v4eoxzWhEY4lAkr/HUMgAzDBzgPWWkrRBaEpc=
X-Gm-Gg: ASbGncu/U+oXs1A6rU5TApXJspxnIJRv7tbKjBcqE7cD51laA7AT96J68PGM2+x3D/7
 aI13rUTzSLaiaKBLKHzn3JlofYoGbes0P+RWKNuXWZjlvm4ZX+KKfZVZjrvDoIrzqt72wXdd4VC
 Mi9ASYWYiZDZvR2BBLD8Iy6VYlKhaiWEZoMmVHGc8EuJiKBdsLLX7QbXakpnP+DvIQTG1AjwBja
 VQf5pXeyoHcMnXWNdac4MPDbgca1YpBa1G+KoFzudavkYay6e5KaDJHQpzcB3aJmtHQ4/yKALCS
 8NaN/bYLRKQWA6Dx8CYv7T1Hh021xFL8RqQDP4ePUzCY2GBD+9Gej219EfAD2hyCcGezLIYOYvI
 9kuOHLK9GvQ==
X-Google-Smtp-Source: AGHT+IEYwBk0dUdQRJT9sqJGaCayj6bL4LFjurb9TpcIfyKVU0kX1cAvJGoQW83QeaXr7408J8Yo5g==
X-Received: by 2002:a05:600c:56c5:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43d1ef4b074mr112131375e9.8.1742226055531; 
 Mon, 17 Mar 2025 08:40:55 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8e43244sm15653788f8f.60.2025.03.17.08.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:40:55 -0700 (PDT)
Message-ID: <1b3b4ca7-5522-4e43-b165-2f6aa53ee4a2@linaro.org>
Date: Mon, 17 Mar 2025 16:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 6/9] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> Currently we provide an AArch64 gdbstub for CPUs which are
> TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
> TYPE_ARM_CPU.  This mostly does the right thing, except in the
> corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
> which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
> and which to the guest is in AArch32 mode.
> 
> Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
> behaviour into TYPE_ARM_CPU we can change the condition we use for
> whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
> This will mean that we now correctly provide an AArch32 gdbstub for
> aarch64=off CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


