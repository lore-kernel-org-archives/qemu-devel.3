Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15979C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqgi-00011F-MJ; Mon, 04 Aug 2025 04:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqgC-0000tn-Qp
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:36:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqg9-0000pv-03
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:36:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso16782795e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296578; x=1754901378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qp6fkYLu554z+dBJ2b3fhr8W6hjcNHzMLX7jw7ePtA=;
 b=y76DVAoLI5nWeYkHtUrT30ui0dqpSbts1fKNIFwXnwdNHC3OISgEKcNvd/V+sVEhi5
 gXWSJbxrEfyFgRANouStamEGpf+LuKNIS7MOib+eXaS5Ul8hhZ/43JfoFzdyo5RQ23G0
 jdAl6D5fALK5hxHFNpiHODbAkCtkbhjgG0juHKmHnif61mBVRUTbrpT9Ou8Nr8MkcIWN
 eZQw2POfj5+kvH90klDo8OHnBv9+Ywx1b3Rrl3pbPIuYmOZcf7ABP2F0JXboVDJWCvBO
 4zQxPrIiZSr1THrmMPUXsExMmZIDAEIJXiIkWGbrUs6ocvn60UuwEPqz3jJVm+0n5u0D
 t5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296578; x=1754901378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qp6fkYLu554z+dBJ2b3fhr8W6hjcNHzMLX7jw7ePtA=;
 b=q+mhUXSk/dpdKJbBrouwfoeZZZDcNRC1CPDlM3i7WPXI6rqfU26YR/jiTPHLMQE2/P
 bBz+axLJtPXVmPEmAXh/EDGXC7siOvUgPXS37cgehTzaTGc/ZPCccztiHEn+KqCk4RCq
 49Utd+0kP1FHFkIEn8c78Ha5sSWGbmIwSgnPGJvyq8eoAtWJWm93m4mvVS8GvmKUKBgk
 gLBEUrUrLTpBLZi04IQLNettjZ7dbSPQLrtcDpwbkG0Kxbuvx9g0Ep0zKSibHMaJOri9
 OKwIaQapNO834gySWIcWVheEHed9Lvp1ynMWyNBETe5+c3tLDyB/J5lbFF4bK3Uddo0k
 agqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ+QikL0+QvP6oKY5zyq5NqcOg+LOs+S5Gyz0KbgN6KJozGHS13wW5J4ICfK7I02prvBjllLiT5DHT@nongnu.org
X-Gm-Message-State: AOJu0YysNxKT2WhwUn7rYFjZJykn629Qt57ERnVnzHi7eia+Ovtx0DqI
 PBCfoenD+JNR79MErZ9DdtB2KY4+gP1ZcYkNNis9KNtKCogJY1y9M+PLkOGpPY75umM=
X-Gm-Gg: ASbGnctl7nFDnSmiA+o6vjdF1P6XNmbXfp2IEMJtR+LHXSmWfcO9NYiru7EwreTW0yA
 pqA7pBGEYfqc2Mw4z06Rz/UiqkgJDIl+PnzVVYWt/MTxKaAItW8YV06xNw5/EYdZMVIrNGMJZmN
 p3wF35fQ2xQlwsDf22+hSX7ejOh3pEaxXnEAInHlUhmTixkZNXCGcJvDNQj815zGzqRSg8jUZU3
 Kz2n7gK1dQlqXZrSWa0xszyOkBd+ArRhtgb5UbC7XNsLoNb+HTvQ3L+6L0JZ/R0ttH21kHMlD7/
 YeTM7vYXMpHNc8gbVUpxCEIC0esRmxsROEViXVY13zXr29jBCy92YwtoUvBdlmSXy5/7084e9oj
 40i9oMuy4IcTZO7wOBFZNDoRwAWV7qOwIapIf4VnQ8MAwWWfivlu3F/jCOpPtemRBENSvc2g=
X-Google-Smtp-Source: AGHT+IGnX90jTOs5N57Ue3B6fZ1VtQDIBdPGkqIfkHHNCXeQTdX/3WvevS3f5z0oHkCs21oHR0Ivyg==
X-Received: by 2002:a05:600c:3ba5:b0:459:d616:25c5 with SMTP id
 5b1f17b1804b1-459d6162762mr32264355e9.12.1754296577760; 
 Mon, 04 Aug 2025 01:36:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf0csm14441840f8f.14.2025.08.04.01.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:36:17 -0700 (PDT)
Message-ID: <fa19e6e4-7f6e-4bb6-b3d1-756f274fd4bb@linaro.org>
Date: Mon, 4 Aug 2025 10:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] tests/functional: Move loongarch64 tests into
 architecture specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-12-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-12-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> loongarch64 tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                                  | 2 +-
>   tests/functional/loongarch64/meson.build                     | 5 +++++
>   .../{test_loongarch64_virt.py => loongarch64/test_virt.py}   | 0
>   tests/functional/meson.build                                 | 5 +----
>   4 files changed, 7 insertions(+), 5 deletions(-)
>   create mode 100644 tests/functional/loongarch64/meson.build
>   rename tests/functional/{test_loongarch64_virt.py => loongarch64/test_virt.py} (100%)


> diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/loongarch64/test_virt.py
> similarity index 100%
> rename from tests/functional/test_loongarch64_virt.py
> rename to tests/functional/loongarch64/test_virt.py
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index c72b17df1dd..22b46ab34a2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -15,6 +15,7 @@ subdir('arm')
>   subdir('avr')
>   subdir('hppa')
>   subdir('i386')
> +subdir('loongarch64')

I'd just go with generic 'loongarch'. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


