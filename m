Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC332C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzEO-0000aU-ES; Thu, 08 May 2025 07:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzEK-0000YO-KD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:15:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzEI-0003Km-T5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:15:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso748863b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746702953; x=1747307753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bxvXFK6wyH800bbxULSduBDyAO1im3t1VVcC9kc1l+0=;
 b=TnXEcabEnVOnLABB2QUCm3NdrsIKZzQn3lu3ZDgku8kv0QywapGunBg2A4Rvo/nBlu
 tjElQjnraZkJoLy2bB1eTGzWevTg1wxeO+5r79/uUornFJ/n7gZE1sL5SiBq4FVHKSf8
 a/tpBa+lEhWilLkBU5EySwYKNtpUwSM1NwXucKxY1IFKO5VKPME1/buNdWbKc1vZ0vUY
 XS8qPJyRkBNRVRekVXWmTmsTPbeUbUadX40In3ecqCSyh5w95A1o4mNIb5mcgGwhbWm8
 VfS3qreggnxT7U8eT1venm09T7JENQiMq0YUl9UPeamo3d54hWV7jp2ltc6wv3UcFn6Y
 jgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746702953; x=1747307753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxvXFK6wyH800bbxULSduBDyAO1im3t1VVcC9kc1l+0=;
 b=XujOPo0EPYOutmIwOYQfLGJCuIWSfl/RuortBaqytW5ErBnt9T0AyHlOKjndJAY7ux
 6jP3AwXDuYfRpE+DSj5Lmoagx+XeHIcWH0YQU4PQUzhQHoDOxdWMQJv13ALJ5KAQv2MH
 QzwrIFGJ64RSIb9N6P5lGXtYeBf7jgxoN9WnWTp9tW+xKcNkmrdB0xA0KzJFtWjQwXvT
 wc/z/2p/RJOgFGXuA//Ll7RKQIRhpjzpByxBzWkxJSXLzZSksRiarTTIW31SKY4CsnFJ
 gG8z6xC/5sXLq909b/uevXNvZ8ts6F9lgH4YSKusA6fecyXXCKIm5oGu/Ki3ZfE8PeC1
 MJSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqoN1fIyDEjDFmcg+pG6/qJarSAx2ZTbhWj/Ev5ptG8Y4GOMRnDWM7KMPHptf5Yh2CdUVoshjN64fr@nongnu.org
X-Gm-Message-State: AOJu0Yygd8ZN2hYpLaK/FbCz588/0calTeKcBx/yawjK82+BHd2o6SD1
 sOszLCUjEjFkXT064mz5e4msvZMABAJvYwAYEDTlCGt4O9ee5o7oGXR+gbJF7QQ=
X-Gm-Gg: ASbGncuq3a6k8lxxSpJvS1op3FfaW+wvMO3A9sSvqvZyx3pDdzOmYsEsSnfLuoE1/Gy
 MMQblyUyRoC7EJ27bgK6GBQeFvhCEYvfLF41/hBWtp5TCe50cPY/0Wn3TNr4rZ7SpyG0IBgNpcG
 zSTeNY5WvX+5BWKkUjZxH2EqJG/gHsR7jDG6VCsYtIctp7/VK1SnMjqGDdUbGuxZBxgN+Tpyn5e
 ZBRRJ2BwhKbToX8DLacX9xi/bQcarZL0VqtkBku+mHwXqTxgi2E8FbeU0vhfMBJANnvpeJuaa0p
 40J42h6jJZqmHK8PKqjOYCHoBt2Dv4xXhCYVc1y5dxZM7Bamj5UZ4NeCaozZro8SAJpJXipho2P
 saUa12T2nY71teHnmrmE=
X-Google-Smtp-Source: AGHT+IFawoyvGUHhnXP+m8rwiZuJFX+G7XNa+3Yms592k8ITLyMfvseOoFC8KzPpFvrhHD1tRLW9Ig==
X-Received: by 2002:a05:6a00:2c86:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-740a947b507mr4637639b3a.10.1746702953214; 
 Thu, 08 May 2025 04:15:53 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b5113csm11119773a12.18.2025.05.08.04.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:15:52 -0700 (PDT)
Message-ID: <90356173-31a1-48f7-9eb8-7a9068b167bf@linaro.org>
Date: Thu, 8 May 2025 13:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: pl011: Really use RX FIFO depth
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250508082943.446512-1-pbonzini@redhat.com>
 <20250508082943.446512-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508082943.446512-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/5/25 10:29, Paolo Bonzini wrote:
> While we model a 16-elements RX FIFO since the PL011 model was
> introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
> emulation"), we only read 1 char at a time!
> 

This comment ...

> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.

... is not relevant, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/rust.rst              |  2 +-
>   rust/hw/char/pl011/src/device.rs | 14 +++++++-------
>   2 files changed, 8 insertions(+), 8 deletions(-)


