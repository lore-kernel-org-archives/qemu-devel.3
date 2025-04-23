Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0003CC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WrV-0004mm-SF; Wed, 23 Apr 2025 05:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WrT-0004mG-JU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:57:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WrO-0001jL-Lb
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:57:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso71484265e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402260; x=1746007060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zhaaJuCFV2oUS3vCCVVdYiHqHjGvnJchVjGenl5nXY=;
 b=o8BDCA1xmtAznfqFZR4zyh+GnR73ezWKaJXSsYTFRb+yaYyKoi/v9RMwITTzK2CLBX
 lV3fFhnhzdFlIgENASdwYgiCrO67l1QirJKuZ60G4AnUZUoVNtksQ3/v7k85qaNOj/1C
 8UhSjsLN8gYCq/jbIdBNNuKUamm01DIXnOjZ5ziwcPxjjNzAfX7Ths0edoKuqdMakx/t
 r576GDF9Ma+swWu+BeOjIVWeDkk7HsY4hPl1VYMBieFE7GQt1SlCk6Uu7Qqt1x69fbCM
 pmqt9q4R3fjwJXcgY/0XY3/K48blYW0oVSYw0bSZQWFRjTYeP1pLWCOS1ZJwPtW2fZVW
 iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402260; x=1746007060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4zhaaJuCFV2oUS3vCCVVdYiHqHjGvnJchVjGenl5nXY=;
 b=bL/kBZPNmS4AdrAyiK/q+ZeIICLQB7YS7mbe/2MHil4g1bjLP02QoF1J4c5WLU4kLC
 Gkf/FVDLQVJKzkx1+dErxnOpuRXsllh67N4FjNivaii+IbcwgYOon7+KyfMRmxUFTCT2
 smQdGEwWvu277yKMubD5KkVtBB05twgsCAGyNvmyV3/t/JS5NslQOY0nap+Cx/LRo3AH
 UWmknkgXdq/ytKskcUI7rwSCOeM55mdCbFbA8GgCsywQewXoXcyXplcc4WhvEaKmVvXm
 ISHBbts+eVnU6USJenu9DIkWcDEk/7EHiql8oywDKfMiWFxM+1zN/FehjOeb2ehXs31t
 nt6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA/CMpVZ5V8N4La8lRDaxGSU7uE9F57LoYI2h1w7aq9bA2OqB63KvUzkeXY3dInBNliIijB83KOFbS@nongnu.org
X-Gm-Message-State: AOJu0Yzt64lMll2B8Vj8QKiXqYi5+DdFrQXmTp8DZQ0xDVwIvmgNFDhR
 39NQBztyNxW+JknnQZ5i+AKQAR93cPa7Ao8vlFBUsBH57So/oOCANpDoykT0YKo=
X-Gm-Gg: ASbGnct+gX7XH8ZH9oIINZpsRLoqxU93rJ/KicPUGkg5yETAFITAeA8aEoHMh4VpeGh
 dB6OHXzvdj7HL6BXQL4Vmxyifg9FvcaqsUEJ50DKK8hH6dZut3tJiiJOv6pM6lwLOvaiQ8kgh6j
 UqgKPyVc+Ipy0X+cbAtxYnbxvHagWHEn7G299db++27Tl19FSZ074tuXDtPP7ROb1qP5MdbqpOd
 5HHMpEYd7VAC73bDEqDBr8RT6valNqZg3oW2bdi6Ao+ck48FQYTu+qPcGPV4F0lioowjnQlsLLU
 IvYsV7lX9vOKYWbgZiT2T++WT2l83I+D0+AqHUc/aLA5MUr6Vlo/KBzAIWSWfT2bnPzBN9MpvhB
 xsr1fiwP5
X-Google-Smtp-Source: AGHT+IFFtvbjfKq/4+ffhyoAuhfSuK17TaLpqcUfsomPARpQH0Ok1e3XsSMACXPuiMRJn/fuhmLhHg==
X-Received: by 2002:a05:600c:3107:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-4406ac163bemr129388725e9.29.1745402260471; 
 Wed, 23 Apr 2025 02:57:40 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092db2beesm20088235e9.30.2025.04.23.02.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:57:39 -0700 (PDT)
Message-ID: <14dd9443-13e5-4cd3-bac2-911db1f1af7d@linaro.org>
Date: Wed, 23 Apr 2025 11:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 061/147] meson: Only allow CONFIG_USER_ONLY from certain
 source sets
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-62-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-62-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 22/4/25 21:26, Richard Henderson wrote:
> Poison CONFIG_USER_ONLY and CONFIG_SOFTMMU unless
> the compilation unit is in specific_ss, libuser_ss,
> or libsystem_ss.  This is intended to prevent files
> being incorrectly added to common_ss.
> 
> Remove #ifndef CONFIG_USER_ONLY / #error / #endif blocks.
> All they do is trigger the poison error.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/poison.h                       | 5 +++++
>   include/hw/hw.h                             | 4 ----
>   include/system/confidential-guest-support.h | 4 ----
>   include/system/replay.h                     | 4 ----
>   include/system/xen.h                        | 4 ----
>   meson.build                                 | 6 ++++--
>   6 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 2c151fd1e0..4180a5a489 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -66,4 +66,9 @@
>   #pragma GCC poison CONFIG_WHPX
>   #pragma GCC poison CONFIG_XEN
>   
> +#ifndef COMPILING_SYSTEM_VS_USER
> +#pragma GCC poison CONFIG_USER_ONLY
> +#pragma GCC poison CONFIG_SOFTMMU
> +#endif

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


