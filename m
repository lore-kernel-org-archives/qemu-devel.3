Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2EDC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE2i-0007rD-1O; Wed, 12 Feb 2025 09:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE2g-0007r4-Ip
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:48:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE2e-0001x5-OI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:48:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so26018555e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739371723; x=1739976523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8sy2d4THmsHrfrpFXeFFO7zsrL1pzRFrjIRZ5uxEkT4=;
 b=leMR0dR7fSIJtDzGxf43KfOSorhq8PMA0qgK+QsbxHlsgnR0J4RgrcEzs3SoNOLRbt
 sUTi9irriHqTGqxuM+ZRcEwS3aMo3D99pgNWggQ/Fa4T+tqEhNYC8Xynxm+/oS5vQmhW
 WyefTO/DZMBgCfmo/ZBGYNa7x+5DCVioLO1NMqVWXbc61/oNVk64S3s9kVSHrS7O0Lor
 sBnCO+jFa1SyVImKmFM9fQCpuHdvExhFHGMuxk1yv1Fu0XdbcTV5d7/iq4NUtJwQXP/T
 YrQzLdcYDCdZKq0oYtoPkHfcI69wyn8s891xf6HGfe8yzTAtBbFxcJZ4Fy5WoundYW61
 diAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739371723; x=1739976523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8sy2d4THmsHrfrpFXeFFO7zsrL1pzRFrjIRZ5uxEkT4=;
 b=f5UU/ADF6k1kQqAcmuXQcH0AR3UNfNPH84c15qTWsGp0dcsOsU7gQF7N20jbdKXI/M
 tEoM47veVqi/t6xOu7VBX/NeddTiws2D+vmNifmqllkenirc7Vi/HlkQviXB+ijQoZlH
 kgaHLNqOlP3Tefch1ooBxy+yjLAM/WJwYSlm0GDN7AIMiZYpyfU4QUVnd+UDRk4Cna5b
 gQkFKQBdxzg3kNR0wGySnecuMRp5l/275OoOot13/DfG9KqJT73TMxjTUQuwAPLS0ZVN
 W9Aa6Jp36SXQ6ZnQPXPPo/WfO3txqVgGqVNLNN5cNuIbRJ2SYEIa2SoJlxjRpF2PutZu
 mt4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWleHUrc/JhkfLUwptePRKBRVQ7ocxoteqaVcgzq2mxl+41BWtFBCg1ewgt+PtMLy3LPYQuPtk7sAwG@nongnu.org
X-Gm-Message-State: AOJu0Yy4VrgRgQCV/+l1/SR2VokREnCXCAmfN0zKo7yjRyTVm1VXdbXc
 TdfVP8Zljq2MyC+bMdKvpntPZvzqeAZ1zC2VIG6YyuFXQiPVU+Ygeonr7cJEUCY=
X-Gm-Gg: ASbGncv9U8zK7ONR6MhT6hQRxiPlNlQ/2IP7q+U7QUv8qM8BoBSbt2pmMtitHYH9Vcv
 93tRFtg4vJfSwsBAl9cDjXh1q5ZgLfQEPRkR2Xjv4Yt4qAgqwWx5S9SSkL5CxwTUqDWj3aBGpJD
 NRo1UUcMPMOsA/a5InmIwh/ifXfiZFyTTn+pdzEbQmQdLahh9Y9y4Pi/fZpyZZ+LuSfswu3oIV2
 AKA/XGHs0Z2V7AG+7i38gUNZMz/ZM0bAKDT0wg/kzTHqWvVMWE6dP3+jy/yjjuaWHL/I/D7VzRR
 RGQghiNR3hWQnjCTOq/d2tnIt5XZV9yC1mG+5dZhSmj1tkxA7/l9OdGNHfc=
X-Google-Smtp-Source: AGHT+IHXk/Iqf+FWVhnFXJErkKq2n2K1ZZmC7+qjVSOmXi10bbjhXca7u7Yq+jQhEFQd8H1/TBj/iw==
X-Received: by 2002:a05:600c:c09:b0:439:4a9d:aecf with SMTP id
 5b1f17b1804b1-439581ca798mr26646745e9.25.1739371722926; 
 Wed, 12 Feb 2025 06:48:42 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38ddaf333c5sm9749592f8f.36.2025.02.12.06.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:48:42 -0800 (PST)
Message-ID: <8099a911-88a1-4eed-a17c-5a18e25b4d68@linaro.org>
Date: Wed, 12 Feb 2025 15:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Daniil,

On 12/2/25 15:39, Daniil Tatianin wrote:
> This will be used in the following commits to make it possible to only
> lock memory on fault instead of right away.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>   include/system/os-posix.h |  2 +-
>   include/system/os-win32.h |  3 ++-
>   meson.build               |  6 ++++++
>   migration/postcopy-ram.c  |  2 +-
>   os-posix.c                | 14 ++++++++++++--
>   system/vl.c               |  2 +-
>   6 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index b881ac6c6f..ce5b3bccf8 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>   void os_set_chroot(const char *path);
>   void os_setup_limits(void);
>   void os_setup_post(void);
> -int os_mlock(void);
> +int os_mlock(bool on_fault);

If we need to support more flag, is your plan to add more arguments?
Otherwise, why not use a 'int flags' argument, and have the callers
pass MCL_ONFAULT?


