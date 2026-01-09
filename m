Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39F0D26D9E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veK8F-000409-LF; Fri, 09 Jan 2026 16:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veK84-0003zS-Jo
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:34:45 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veK82-0003GK-Ne
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:34:44 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so33453775ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994481; x=1768599281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUvhpnhqern18EBLxnOdl9+0XBd4UugahN8MOj2hImg=;
 b=kxtIu/KmKimywFb6Glo6dGMaqfKIWQMAtXcWRp6f1QNOABEiBOv8D+GaoN97uknVgo
 MizjD7rizaBSLWQEqKVWF7RUE8RgGgb0h3oEUigOUvQnv7z7s6Di6/lsuoFUiy8Eh/Uq
 Oc6/3In/odwwFflJfb+liMDFjVbDRI9BbKf778cuAuvnn/aRtYjw8Xjv9NMyIW0Ft/E/
 XcCwXyFMB7T9b93W+MfiB/MA2Od6IHJP/13dAJsb8xt1gI88JqWfZAJs19zyDf2EW6qY
 5/n2iS7nBG0aH9A9LkxO+iPpJRjxBGrg82s6gtZdEW/6XuRspfPRgVFOVcWjI9yZUzEa
 lrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994481; x=1768599281;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUvhpnhqern18EBLxnOdl9+0XBd4UugahN8MOj2hImg=;
 b=vdsN4k/9+6DoMu/Jmi+EMR8HjvEjdkf345w61D0xCDjx3b8ccdEXITXcsmVxi1WFTV
 jkAegY7ZBNLPHSNr8Hwhm26EpVgS6vdyYITRDCVay1V+fxcV6cKjK028CRQRI8+ddexl
 k451bZifV0Fmgdwbibbegn6nySHP679W/RW/SRH8LMmlCcm2Gock93Lsnqytk0VwU3I1
 U28u5QiJhAHBkLxOG/YJeBUfeS6hC5lYBrz7HgL8h+tbCmvot5zk2Kfuu+ksJPeYPavh
 V8km61zAhGZgE/U6ukRfjZswoYu8LpJztvnhIxRry32JVduz3AS434D6YbqsvPYrXEnp
 W/gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIM+kSJeuhj2LIJrgi6TCvlsNqMX7lWDL37E4X3c5pcGp8yxxPAcN1gLVbA2D6/9fZMo2Ds7Ykc1FV@nongnu.org
X-Gm-Message-State: AOJu0YxRnHqoKVvXcEmZ6WvpVaLaRs6kbKETtRH+SHUgvDWCew1OXZQ/
 PA7qwUoAo3bELebnV2LO++omuVH/4wN+efV1V2RrI22w3tKgQ2RzMwedc20jE5WKWOE=
X-Gm-Gg: AY/fxX4AzUMgHS/loYwBg3pg2PCRv3chBFf0+W25NhnOvfNgWNmQbWNgarn1tjV1PKt
 kDs2nQTPI1OFf6vNWiMIua8yEH0kCndCKh+wwiQk6NVSfRDKxNr5y8HpfyBNJAOughYdEsfz/RZ
 /8NendcJK36Y6Wn8C7X92DgFPGOa8R06ps25Lwti2exZp2yUSMBZg0k363dI9O1L3efxkqnhpuy
 uKM5lK92afI/pY1+20Du53xtiN/1w3S3yfPkxIuL9hliFAPu76c+XA/3Kv9h1v7HSnrePGhAIFW
 ePfp+MX6ZmUbNBN78bqZ8KW/4PSRTVVY7I6ZtMVCTyznbs27qJAQbNyEAE1i2RRagPtqMULB8+h
 hGqm5dE38ohy7MxFhrENx++7V/adF1LHELjvqxh2Pw1sXt97Qq1Dw7LSwVbffgCdItHqmq8lKbF
 L3eWmnu0vl/3/k37yGCGBziX3+jA==
X-Google-Smtp-Source: AGHT+IGAkKU9evx3SRXfyb/rBMe+Tx88lxTKZX6uDim3qJw/8bB8rTtvVbJxKIjuL7naffqdhGjGFg==
X-Received: by 2002:a17:902:ea04:b0:2a1:2ebc:e633 with SMTP id
 d9443c01a7336-2a3ee4372c6mr105132845ad.4.1767994481080; 
 Fri, 09 Jan 2026 13:34:41 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48d77sm111824205ad.41.2026.01.09.13.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:34:40 -0800 (PST)
Message-ID: <dfa7edbd-8c07-420a-b524-7f6de1caaa45@linaro.org>
Date: Sat, 10 Jan 2026 08:34:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/29] target/arm/tcg/psci.c: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Now that helper.h does not contain TARGET_AARCH64 identifier, we can
> move forward with this file.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/psci.c      | 2 +-
>   target/arm/tcg/meson.build | 5 +----
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
> index 2d409301578..fc23d62ed94 100644
> --- a/target/arm/tcg/psci.c
> +++ b/target/arm/tcg/psci.c
> @@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>       CPUARMState *env = &cpu->env;
>       uint64_t param[4];
>       uint64_t context_id, mpidr;
> -    target_ulong entry;
> +    uint64_t entry;
>       int32_t ret = 0;
>       int i;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

>   
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 1b115656c46..144a8cd9474 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -49,10 +49,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>     'sve_helper.c',
>   ))
>   
> -arm_system_ss.add(files(
> -  'psci.c',
> -))
> -
>   arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>   arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>   
> @@ -67,6 +63,7 @@ arm_common_system_ss.add(files(
>     'cpregs-at.c',
>     'hflags.c',
>     'neon_helper.c',
> +  'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
>     'vfp_helper.c',


