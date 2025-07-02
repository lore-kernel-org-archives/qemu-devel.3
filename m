Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEE4C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzBt-0003ed-Io; Wed, 02 Jul 2025 11:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzBk-0003bz-9c
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:16:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzBi-0005fM-An
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:15:55 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-407a6c6a6d4so2268088b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469350; x=1752074150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oU1+O65CnEYzAzok7B5HogHZoJzCx18xYLdDTcv5Epo=;
 b=MSuPhJkYVRgbPUBr2tCL7HUohgGUZ0bnesUuVuEDKkYlEhfSDT2T+eMsPY4kTdQyAd
 3WvGDzaDJvTja9RbEcUohP8JQDDbqNqTIygPHJRKDpNXRXe4TEmwKCg3QU+GeCOGcjn3
 qZQeaoClwpUpjTfemhGQEZLDKJbhFhe42hj6yiVJKmv6X9DvUNIRt5CkW3GYduwz8G4h
 uB7nmtEKzIdzN3cdUAqAWHk0Xbcrq9hyzK9ApgeKoC34NzDYmxcd9el2Az2wvmFrPd68
 O6jo4k/Cy785WSgvyL3mlZ+f0uFPTzTtmBYrH0EcAxbhDQknPL8t5TQgvM5yp+9XTDny
 G6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469350; x=1752074150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oU1+O65CnEYzAzok7B5HogHZoJzCx18xYLdDTcv5Epo=;
 b=tGAHHAcWWeGwSoW8qJbboNreG1K1OifkdqJXnX4ibwR3R0n+rNgKzGvC0AEPDsf0uN
 z1z2H+3vjVAFmFDdQZktoavJIV/bCVyws0Avc1bniQlH0RpoWACMtPvL21xVDJKadSLx
 bzjBnp4+dexwpjXGMHvyDy25GSRuQnJfYzXHyZN9/9VkgMUNVw1bged1OkJPnSRpD8ru
 uMnJaIeY9jZdo1JblB8oo8179fqnIvy+Lz+8YZ79LbNnUVApRoxdYIUp6k6JaBw7CC5W
 QzFetciNPrkVetLeN78tmmdMFG2CXidv8nsErx+ZMnBhekjKgbA4kzKBnE+0hQKZ0NEB
 S55w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3PdSNZ6vi0FUcM3JgkILn2Z8GiJdFz6PVGdQ4tjXgdf4Twb/Hc7R8abCVeJS5/PORb0HUB5etWwag@nongnu.org
X-Gm-Message-State: AOJu0YyvWCSzsSzyI4IWegwXW2m7OEYIsEejc4a3BaOarvxD6mguR1Dp
 JRP4+O3eBigLMXpcayid0XiO4f/lqd0Q3AH2kOd8QxVzPxCT9HPoYIJNHMlumn7BBVI=
X-Gm-Gg: ASbGncv22tU3hlmS4CwNC5HdH1LfEQc9j6aXM15qzayVER6/kJYHl0OR8aif2xynbT0
 WaVMn5akaQIvdoFQWY/3Xe+B2gbuDj8u52wi/wz37pW0DeeecDW3hrSFrBLJY/N+IxNZH5AeUAF
 K+fhOG0AFmswlY74nj2Xf2MLSjXxLT5ZMvc5nQnpvc2FKbAn+kvLUhNN8iNps/zOzjP1EURCHF3
 W6Ve1TDKjM7DbUikYojRbIsD3eL+nYEY5TmVImri/uhPKw77U1r63fYn4vHC72+VPtHGYzUUXEx
 qmUZGG2jWtPE51qlIfeX553VgrjkB3RWKpa+F4DnaDtduAskydhS9Vjc1ztg5y3jPDGOlIzg0k3
 W
X-Google-Smtp-Source: AGHT+IHykpZzp85tKx4yMiz/Jo+Ecfz5Tp6a8kby2PHPxqak13/RNf8WO5nadbnPLdJd7rkpceXKkQ==
X-Received: by 2002:a05:6808:f86:b0:408:e68d:975a with SMTP id
 5614622812f47-40b8911917amr2690224b6e.39.1751469349828; 
 Wed, 02 Jul 2025 08:15:49 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3241e38csm2573380b6e.34.2025.07.02.08.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:15:49 -0700 (PDT)
Message-ID: <a0461089-9283-47e6-8763-14a10d735836@linaro.org>
Date: Wed, 2 Jul 2025 09:15:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 54/68] accel: Factor accel_cpu_realize() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-55-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-55-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Factor accel_cpu_realize() out of accel_cpu_common_realize()
> for re-use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/accel-internal.h | 2 ++
>   accel/accel-common.c   | 8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

