Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8ECCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVRV-0003uI-7P; Mon, 24 Nov 2025 07:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVQy-0003Tx-Vb
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:12:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVQx-0001py-DT
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:12:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso25847815e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763986362; x=1764591162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GAahkJUUr13idApsrji8MqjFyOarSXxW6Th5dit+urE=;
 b=MNss/qDOt+E58VVlOGrkw+wjxc/Yb6yaQ9fHQW/k9Np73UDPzYPUHexr+WBpFEZ/Jn
 AdslJJlcAtPqirRN5fd96hCA6YQoM6MlacPskv+jzqgJv+u1CU0E+gd1Q8vs53oSoPSf
 kqlAkoQLJQFD0GqjN2VwYWV9Sd8WmlgbTrjhOz6ed3hVTJAM2MfRWVO0SC1ajn6GXFiT
 oVVorfxokJ5uS0WEokPYh+9uZctZKmLR5a9uJMeioodW2eM5GCcvFgwgvu6lcScusy2u
 XBqITKQW4P3fYKk2iGv6d778QlFgabTPVNLmis87LCeYigEW9JVnWNUSTFoTNZZtsswl
 08Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763986362; x=1764591162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GAahkJUUr13idApsrji8MqjFyOarSXxW6Th5dit+urE=;
 b=j20Chi0pLOBk69XMXpo9Hr4NJfaiKjSKJfwRH4svU36p8xSU9jIE+9vGtXfoJo/j16
 iFgk+9yPnIl+NjIL4pSQwSLkvazwhc62yIL2WhaVAqedWPbz/zQkSxzzYzxrJu4RN+Cm
 Wb/nCe0XdGFp2BXvrfO6vZkR9DetRHrysHPmH53graeyzjTiNBcvcekGWV8/BYoSYa+n
 ipEVRgR4NPYb7tgosiLZUnSGZ6WcB+RC9KmbGFTM5DfW9zcF1w+y7w8VdI1nsSlFdcON
 ZskWkBH/uJp0uiaO7LtaP+mYJ13UKaJiQePNHzElCjuxm9wvbZcxlcGg7EVDEuOfr4zG
 eHQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAyS8SwFd1GUFcHZ46uhYTFW2getIn8p2FQCzpQ0zArFhTaVRawHLdaqmptSl7I+/C1mUWxhkZVX6H@nongnu.org
X-Gm-Message-State: AOJu0Yw0V+X633aoluGkGwjmyZsunUIo5RzvwWwhWj0b/WSPtGFeD98z
 jHSQBfP0SzqN4/hw/T4LajAL3mKmINO5rMfSAJyOc8/cDeOCgku4UKZlRCQ4TBeeiUw=
X-Gm-Gg: ASbGnctaNPLdPRyvzsnHE27wuLLG+ISJFexxew3eNno16Hv67hmlcAfWG9SawS3kzRU
 HoyHY7AfS28DJuRz7diAB1f2TWyMfw7/l/KE/tYQhy8jrGOkLwVgejIVQHFA3MR1bLYRVaYQ44l
 sayfgolZhEF/FG1DNmH+uacb8W4FsRLKGaib8k+vDUKTMuiWongi1re4KvXWEUoBmTlR+VQSGKn
 k3XJs+Tl9eAuOg093XoCkIGRz8pYD7POZg9ed5Dfa8ViEJcHcNuV+fTRaiUinMD4YwxFQlchYUV
 Gol4nuuISSmQIUX/ItvzoAguWjOLtt/BTt6pDqWMXNVzkR1RxiLsDs4AaNJjpm4UhIGBvgkC1+D
 sNEckh/NlW6auMAsYnJXWU6T/Req5E8XzrstIh+HyrZgPJW1HI2LV3Th/+ASTisu9K2LflwFf4x
 1m9jEXXxcwi8yGg08sfhNJO/wTED5/3Q1f6ply8gHd8RP9zEnW8SqQ+g==
X-Google-Smtp-Source: AGHT+IGCuuh5MxYeyTa8fAkuX3uTgaUeAdaBnJlse1+kr0rABmGAVQpNcPI+/8zgfTlpGZNptvyfhQ==
X-Received: by 2002:a05:600c:1909:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-477c11337e0mr117832625e9.31.1763986361728; 
 Mon, 24 Nov 2025 04:12:41 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf35f976sm198059095e9.4.2025.11.24.04.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:12:40 -0800 (PST)
Message-ID: <76090cc4-fb02-4896-b00c-ac0c30585316@linaro.org>
Date: Mon, 24 Nov 2025 13:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
 LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
 <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/10/25 10:15, Daan De Meyer wrote:
> Preparation for adding support for zstd compressed efi zboot kernel
> images.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/arm/boot.c       | 2 +-
>   hw/core/loader.c    | 8 ++++----
>   hw/nvram/fw_cfg.c   | 2 +-
>   include/hw/loader.h | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index e77d8679d8..c0dec0343a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -826,7 +826,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
>       ssize_t size;
>   
>       /* On aarch64, it's the bootloader's job to uncompress the kernel. */
> -    size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_BYTES,
> +    size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES,
>                                        &buffer);
>   
>       if (size < 0) {
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 477661a025..42edcf2d98 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -796,8 +796,8 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
>           goto out;
>       }
>   
> -    if (max_sz > LOAD_IMAGE_MAX_GUNZIP_BYTES) {
> -        max_sz = LOAD_IMAGE_MAX_GUNZIP_BYTES;
> +    if (max_sz > LOAD_IMAGE_MAX_DECOMPRESSED_BYTES) {
> +        max_sz = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
>       }
>   
>       data = g_malloc(max_sz);
> @@ -898,8 +898,8 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
>           return -1;
>       }
>   
> -    data = g_malloc(LOAD_IMAGE_MAX_GUNZIP_BYTES);
> -    bytes = gunzip(data, LOAD_IMAGE_MAX_GUNZIP_BYTES, *buffer + ploff, plsize);
> +    data = g_malloc(LOAD_IMAGE_MAX_DECOMPRESSED_BYTES);
> +    bytes = gunzip(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);

I'd take the opportunity to introduce a size_t variable, since
patch #3 re-use this definition.

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


